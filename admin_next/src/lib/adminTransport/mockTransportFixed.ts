import type {
  ApprovalListing,
  ApprovalOrder,
  AdminError,
  CapitalSnapshot,
  IncidentRow,
  ListingStatus,
  LedgerEntry,
  MockErrorCode,
  OrderStatus,
  ReturnRoutingDestination,
  ReturnRow,
  ReturnStatus,
  RiskDashboardSnapshot,
  SupplierReturnPolicy,
  SupplierReturnPolicyType,
  SupplierRow,
  TransportResponse,
} from "./types";
import type { AdminTransport } from "./adminTransport";
import type { RequestId } from "./types";

type MockState = {
  listings: Record<string, ApprovalListing>;
  orders: Record<string, ApprovalOrder>;
  returns: Record<string, ReturnRow>;
  incidents: Record<number, IncidentRow>;
  policiesBySupplierId: Record<string, SupplierReturnPolicy>;
  suppliersById: Record<string, SupplierRow>;
  returnedStockRows: Array<{
    id: number;
    productId: string;
    supplierId: string;
    quantity: number;
    sourceReturnId: string;
    createdAt: string;
  }>;
  ledgerEntries: LedgerEntry[];
  nextIncidentId: number;
  nextLedgerId: number;
  appliedRequestIds: Map<string, TransportResponse<unknown>>;
  writeChain: Promise<void>;
  lastSnapshot: RiskDashboardSnapshot;
};

function nowIso(): string {
  return new Date().toISOString();
}

function deterministicHash(input: string): number {
  let h = 2166136261;
  for (let i = 0; i < input.length; i++) {
    h ^= input.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return Math.abs(h);
}

function shouldFail(requestId: string, kind: string): boolean {
  // Deterministic failure injection for retry/error-path stress tests.
  // Roughly 1 / 17 requests will fail per kind.
  return deterministicHash(`${kind}:${requestId}`) % 17 === 0;
}

function mkOk<T>(requestId: string, extra: T): TransportResponse<T> {
  return { requestId, ok: true, ...(extra as T) } as TransportResponse<T>;
}

function mkFail<T>(requestId: string, code: MockErrorCode, message: string, details?: Record<string, unknown>): TransportResponse<T> {
  const error: AdminError = { code, message, details };
  return { requestId, ok: false, error } as TransportResponse<T>;
}

export function createDefaultMockState(): MockState {
  const suppliersById: Record<string, SupplierRow> = {};
  const policiesBySupplierId: Record<string, SupplierReturnPolicy> = {};

  const policyTypes: SupplierReturnPolicyType[] = [
    "noReturns",
    "defectOnly",
    "returnWindow",
    "fullReturns",
    "returnToWarehouse",
    "sellerHandlesReturns",
  ];

  for (let i = 1; i <= 10; i++) {
    const supplierId = `sup_${i}`;
    suppliersById[supplierId] = {
      id: supplierId,
      name: `Supplier ${i}`,
      platformType: i % 2 === 0 ? "cj" : "allegro",
      countryCode: "PL",
      rating: i % 3 === 0 ? null : 4.2 + (i % 5) * 0.1,
      reliabilityScore: null,
      isActiveListings: true,
    };
    policiesBySupplierId[supplierId] = {
      supplierId,
      policyType: policyTypes[i % policyTypes.length],
      returnWindowDays: 14,
      restockingFeePercent: i % 3 === 0 ? 0 : 5,
      returnShippingPaidBy: i % 2 === 0 ? "supplier" : "customer",
      requiresRma: i % 5 === 0,
      warehouseReturnSupported: true,
      virtualRestockSupported: i % 2 === 0,
    };
  }

  const listings: Record<string, ApprovalListing> = {};
  const orders: Record<string, ApprovalOrder> = {};

  for (let i = 1; i <= 24; i++) {
    const listingId = `list_${i}`;
    const supplierId = `sup_${(i % 10) + 1}`;
    const sellingPrice = i % 7 === 0 ? 80 : 100 + (i % 9) * 3;
    const sourceCost = sellingPrice - (i % 6 === 0 ? 25 : 10 + (i % 5) * 2);
    const status: ListingStatus =
      i % 6 === 0 ? "pendingApproval" : i % 9 === 0 ? "draft" : i % 11 === 0 ? "paused" : "active";
    listings[listingId] = {
      id: listingId,
      status,
      productId: `prod_${i}_${supplierId}`,
      targetPlatformId: i % 2 === 0 ? "allegro" : "temu",
      sellingPrice,
      sourceCost,
      variantId: null,
    };

    const orderId = `ord_${i}`;
    const orderStatus: OrderStatus = i % 5 === 0 ? "pendingApproval" : "shipped";
    orders[orderId] = {
      id: orderId,
      targetOrderId: `tord_${i}`,
      platform: i % 2 === 0 ? "Allegro" : "Temu",
      status: orderStatus,
      quantity: i % 4 === 0 ? 3 : 1,
      sellingPrice,
      sourceCost,
      profit: (sellingPrice - sourceCost) * (i % 4 === 0 ? 3 : 1),
      riskScore: (i * 17) % 100,
      queuedForCapital: i % 7 === 0,
      createdAt: new Date(Date.now() - i * 60_000).toISOString(),
    };
  }

  const returns: Record<string, ReturnRow> = {};
  for (let i = 1; i <= 12; i++) {
    const returnId = `ret_${i}`;
    const orderId = `ord_${i}`;
    const status: ReturnStatus = i % 6 === 0 ? "received" : i % 5 === 0 ? "approved" : "requested";
    const supplierId = `sup_${(i % 10) + 1}`;
    returns[returnId] = {
      id: returnId,
      orderId,
      status,
      reason: i % 4 === 0 ? "damagedInTransit" : i % 3 === 0 ? "wrongItem" : "noReason",
      notes: null,
      refundAmount: i % 2 === 0 ? 25.0 * i : null,
      returnShippingCost: i % 2 === 1 ? 8.5 * i : null,
      restockingFee: i % 3 === 0 ? 2.0 * i : null,
      returnRoutingDestination: null,
      supplierId,
      requestedAt: new Date(Date.now() - i * 120_000).toISOString(),
      resolvedAt: null,
    };
  }

  const incidents: Record<number, IncidentRow> = {};
  const startIncidentId = 1000;
  for (let i = 0; i < 6; i++) {
    incidents[startIncidentId + i] = {
      id: startIncidentId + i,
      orderId: `ord_${(i % 12) + 1}`,
      incidentType: i % 2 === 0 ? "damageClaim" : "customerReturn14d",
      status: i % 3 === 0 ? "open" : "resolved",
      trigger: "manual",
      automaticDecision: null,
      supplierInteraction: null,
      marketplaceInteraction: null,
      refundAmount: i % 2 === 0 ? 15.0 * i : null,
      financialImpact: i % 2 === 0 ? 12.0 * i : null,
      decisionLogId: null,
      createdAt: new Date(Date.now() - i * 240_000).toISOString(),
      resolvedAt: i % 3 === 0 ? null : new Date(Date.now() - i * 200_000).toISOString(),
      attachmentIds: i % 2 === 0 ? ["photo_1", "photo_2"] : null,
    };
  }

  const ledgerEntries: LedgerEntry[] = [];
  for (let i = 0; i < 20; i++) {
    const type: LedgerEntry["type"] =
      i % 4 === 0 ? "adjustment" : i % 4 === 1 ? "supplier_prepayment" : i % 4 === 2 ? "marketplace_held" : "loss";
    ledgerEntries.push({
      id: i + 1,
      type,
      amount: i % 4 === 3 ? -20 * (i + 1) : 50 * (i + 1),
      currency: "PLN",
      orderId: null,
      referenceId: i % 5 === 0 ? `note_${i}` : null,
      createdAt: new Date(Date.now() - i * 86_400_000).toISOString(),
    });
  }

  return {
    listings,
    orders,
    returns,
    incidents,
    policiesBySupplierId,
    suppliersById,
    returnedStockRows: [],
    ledgerEntries,
    nextIncidentId: startIncidentId + 6,
    nextLedgerId: 21,
    appliedRequestIds: new Map(),
    writeChain: Promise.resolve(),
    lastSnapshot: { negativeMarginListings: 0, pausedListings: 0, highReturnRateListings: 0, listingHealthAlerts: 0 },
  };
}

export class MockTransportFixed implements AdminTransport {
  private state: MockState;

  constructor(state?: MockState) {
    this.state = state ?? createDefaultMockState();
  }

  private async withWriteLock<T>(fn: () => Promise<TransportResponse<T>>): Promise<TransportResponse<T>> {
    const run = this.state.writeChain.then(fn, fn);
    this.state.writeChain = run.then(() => undefined, () => undefined);
    return run;
  }

  private async idempotent<T>(requestId: RequestId, apply: () => Promise<TransportResponse<T>>): Promise<TransportResponse<T>> {
    const cached = this.state.appliedRequestIds.get(requestId) as TransportResponse<T> | undefined;
    if (cached) return cached;
    return this.withWriteLock(async () => {
      const cached2 = this.state.appliedRequestIds.get(requestId) as TransportResponse<T> | undefined;
      if (cached2) return cached2;
      const response = await apply();
      this.state.appliedRequestIds.set(requestId, response as TransportResponse<unknown>);
      return response;
    });
  }

  // -------- Approval queue --------
  async approvalGetPendingListings(requestId: string): Promise<TransportResponse<{ pendingListings: ApprovalListing[] }>> {
    const pendingListings = Object.values(this.state.listings).filter((l) => l.status === "pendingApproval");
    return { requestId, ok: true, pendingListings };
  }

  async approvalGetPendingOrders(requestId: string): Promise<TransportResponse<{ pendingOrders: ApprovalOrder[] }>> {
    const pendingOrders = Object.values(this.state.orders).filter((o) => o.status === "pendingApproval");
    return { requestId, ok: true, pendingOrders };
  }

  async approvalRejectListing(listingId: string, requestId: string): Promise<TransportResponse<{ listing: ApprovalListing }>> {
    return this.idempotent(requestId, async () => {
      const listing = this.state.listings[listingId];
      if (!listing) return mkFail(requestId, "not_found", "Listing not found");
      if (listing.status === "draft") return mkFail(requestId, "conflict", "Listing already draft");
      listing.status = "draft";
      return mkOk(requestId, { listing });
    });
  }

  async approvalApproveListing(listingId: string, requestId: string): Promise<TransportResponse<{ listing: ApprovalListing }>> {
    return this.idempotent(requestId, async () => {
      const listing = this.state.listings[listingId];
      if (!listing) return mkFail(requestId, "not_found", "Listing not found");
      if (listing.status !== "pendingApproval") return mkFail(requestId, "conflict", "Listing is not pendingApproval");
      listing.status = "active";
      return mkOk(requestId, { listing });
    });
  }

  async approvalRejectOrder(orderId: string, requestId: string, _reason: string): Promise<TransportResponse<{ order: ApprovalOrder }>> {
    return this.idempotent(requestId, async () => {
      void _reason;
      const order = this.state.orders[orderId];
      if (!order) return mkFail(requestId, "not_found", "Order not found");
      if (order.status !== "pendingApproval") return mkFail(requestId, "conflict", "Order is not pendingApproval");
      order.status = "cancelled";
      return mkOk(requestId, { order });
    });
  }

  async approvalApproveAndFulfillOrder(orderId: string, requestId: string): Promise<TransportResponse<{ order: ApprovalOrder }>> {
    return this.idempotent(requestId, async () => {
      const order = this.state.orders[orderId];
      if (!order) return mkFail(requestId, "not_found", "Order not found");
      if (order.status !== "pendingApproval") return mkFail(requestId, "conflict", "Order is not pendingApproval");
      order.status = "sourceOrderPlaced";
      return mkOk(requestId, { order });
    });
  }

  // -------- Returns --------
  async returnsGetReturns(requestId: string): Promise<TransportResponse<{ rows: ReturnRow[] }>> {
    return { requestId, ok: true, rows: Object.values(this.state.returns) };
  }

  async returnsComputeRouting(
    requestId: string,
    returnId: string,
  ): Promise<
    TransportResponse<{ returnId: string; routing: { destination: ReturnRow["returnRoutingDestination"] } }>
  > {
    const ret = this.state.returns[returnId];
    if (!ret) return mkFail(requestId, "not_found", "Return not found");
    const policy = ret.supplierId ? this.state.policiesBySupplierId[ret.supplierId] : null;
    if (!ret.supplierId || !policy) {
      return mkOk(requestId, { returnId, routing: { destination: "sellerAddress" as ReturnRow["returnRoutingDestination"] } });
    }
    let destination: ReturnRoutingDestination = "sellerAddress";
    switch (policy.policyType) {
      case "returnToWarehouse":
      case "fullReturns":
      case "returnWindow":
        destination = "supplierWarehouse";
        break;
      case "sellerHandlesReturns":
        destination = "sellerAddress";
        break;
      case "noReturns":
        destination = "disposal";
        break;
      case "defectOnly":
        destination = "supplierWarehouse";
        break;
    }
    return mkOk(requestId, { returnId, routing: { destination } });
  }

  async returnsUpdateReturn(
    requestId: string,
    returnId: string,
    patch: Partial<ReturnRow> & { status: ReturnRow["status"] },
    addToReturnedStock: boolean,
  ): Promise<TransportResponse<{ return: ReturnRow; returnedStockCreated: { created: boolean; rowsInserted: number } }>> {
    return this.idempotent(requestId, async () => {
      const existing = this.state.returns[returnId];
      if (!existing) return mkFail(requestId, "not_found", "Return not found");

      const next: ReturnRow = {
        ...existing,
        status: patch.status,
        notes: patch.notes ?? existing.notes,
        refundAmount: patch.refundAmount ?? existing.refundAmount,
        returnShippingCost: patch.returnShippingCost ?? existing.returnShippingCost,
        restockingFee: patch.restockingFee ?? existing.restockingFee,
        returnRoutingDestination: patch.returnRoutingDestination ?? existing.returnRoutingDestination,
        resolvedAt:
          patch.status === "refunded" || patch.status === "rejected"
            ? existing.resolvedAt ?? nowIso()
            : patch.status === "received"
              ? null
              : existing.resolvedAt,
      };

      // Apply return state first (partial failure possible below).
      this.state.returns[returnId] = next;

      let rowsInserted = 0;
      if (patch.status === "received" && addToReturnedStock) {
        if (shouldFail(requestId, "returnedStockInsert")) {
          // Partial failure: return is updated, returned-stock insert fails.
          return mkFail(requestId, "conflict", "Returned stock insert failed after return update");
        }
        const productId = `mock_product_for_${next.id}`;
        const supplierId = next.supplierId ?? "sup_1";
        rowsInserted = 1;
        this.state.returnedStockRows.push({
          id: this.state.returnedStockRows.length + 1,
          productId,
          supplierId,
          quantity: 1,
          sourceReturnId: next.id,
          createdAt: nowIso(),
        });
      }

      return mkOk(requestId, {
        return: next,
        returnedStockCreated: { created: rowsInserted > 0, rowsInserted },
      });
    });
  }

  // -------- Incidents --------
  async incidentsGetIncidents(requestId: string): Promise<TransportResponse<{ rows: IncidentRow[] }>> {
    return { requestId, ok: true, rows: Object.values(this.state.incidents).sort((a, b) => b.id - a.id) };
  }

  async incidentsCreateIncident(
    requestId: string,
    payload: { orderId: string; incidentType: string; attachmentIds?: string[] },
  ): Promise<TransportResponse<{ incident: IncidentRow }>> {
    return this.idempotent(requestId, async () => {
      if (!payload.orderId) return mkFail(requestId, "validation_error", "orderId is required");
      const id = this.state.nextIncidentId++;
      const incident: IncidentRow = {
        id,
        orderId: payload.orderId,
        incidentType: payload.incidentType,
        status: "open",
        trigger: "manual",
        automaticDecision: null,
        supplierInteraction: null,
        marketplaceInteraction: null,
        refundAmount: null,
        financialImpact: null,
        decisionLogId: null,
        createdAt: nowIso(),
        resolvedAt: null,
        attachmentIds: payload.attachmentIds ?? null,
      };
      this.state.incidents[id] = incident;

      if (shouldFail(requestId, "incidentCreateExternalPost")) {
        // Partial failure: incident created, but post-processing fails.
        return mkFail(requestId, "conflict", "Incident created, but post-processing failed");
      }

      return mkOk(requestId, { incident });
    });
  }

  async incidentsGetIncident(requestId: string, incidentId: number): Promise<TransportResponse<{ incident: IncidentRow | null }>> {
    const incident = this.state.incidents[incidentId] ?? null;
    return { requestId, ok: true, incident };
  }

  async incidentsProcessIncident(
    requestId: string,
    incidentId: number,
  ): Promise<TransportResponse<{ incident: IncidentRow }>> {
    return this.idempotent(requestId, async () => {
      const existing = this.state.incidents[incidentId];
      if (!existing) return mkFail(requestId, "not_found", "Incident not found");
      existing.status = "resolved";
      existing.resolvedAt = nowIso();
      existing.refundAmount ??= 10.0;
      existing.financialImpact ??= 10.0;

      if (shouldFail(requestId, "incidentProcessExternal")) {
        // Partial failure: state updated, but external notification fails.
        return mkFail(requestId, "conflict", "Incident resolved, but external notification failed");
      }

      return mkOk(requestId, { incident: existing });
    });
  }

  // -------- Capital --------
  async capitalGetSnapshot(requestId: string): Promise<TransportResponse<{ snapshot: CapitalSnapshot }>> {
    const balance = this.state.ledgerEntries.reduce((s, e) => s + e.amount, 0);
    const entriesRecent = [...this.state.ledgerEntries].sort((a, b) => b.id - a.id).slice(0, 30);
    const queuedOrders = Object.values(this.state.orders).filter((o) => o.queuedForCapital);
    return mkOk(requestId, { snapshot: { balance, entriesRecent, queuedOrders } });
  }

  async capitalRecordAdjustment(
    requestId: string,
    payload: { amount: number; referenceId: string | null; currency?: string },
  ): Promise<TransportResponse<{ balance: number; ledgerEntryId: number }>> {
    return this.idempotent(requestId, async () => {
      if (!Number.isFinite(payload.amount) || payload.amount === 0) return mkFail(requestId, "validation_error", "amount must be non-zero");
      const id = this.state.nextLedgerId++;
      const entry: LedgerEntry = {
        id,
        type: "adjustment",
        amount: payload.amount,
        currency: payload.currency ?? "PLN",
        orderId: null,
        referenceId: payload.referenceId,
        createdAt: nowIso(),
      };
      this.state.ledgerEntries.push(entry);
      const balance = this.state.ledgerEntries.reduce((s, e) => s + e.amount, 0);
      return mkOk(requestId, { balance, ledgerEntryId: id });
    });
  }

  // -------- Return policies --------
  async policiesGetAll(requestId: string): Promise<TransportResponse<{ rows: SupplierReturnPolicy[] }>> {
    return { requestId, ok: true, rows: Object.values(this.state.policiesBySupplierId) };
  }

  async policiesUpsert(requestId: string, payload: { policy: SupplierReturnPolicy }): Promise<TransportResponse<{ policy: SupplierReturnPolicy }>> {
    return this.idempotent(requestId, async () => {
      const policy = payload.policy;
      if (!policy?.supplierId) return mkFail(requestId, "validation_error", "supplierId is required");
      this.state.policiesBySupplierId[policy.supplierId] = policy;
      if (!this.state.suppliersById[policy.supplierId]) {
        this.state.suppliersById[policy.supplierId] = {
          id: policy.supplierId,
          name: `Supplier ${policy.supplierId}`,
          platformType: "mock",
          countryCode: null,
          rating: null,
          reliabilityScore: null,
          isActiveListings: true,
        };
      }
      return mkOk(requestId, { policy });
    });
  }

  // -------- Suppliers --------
  async suppliersGetSuppliers(requestId: string): Promise<TransportResponse<{ rows: SupplierRow[] }>> {
    return { requestId, ok: true, rows: Object.values(this.state.suppliersById) };
  }

  async suppliersRefreshReliabilityScores(
    requestId: string,
    payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ updatedSuppliersCount: number }>> {
    return this.idempotent(requestId, async () => {
      const windowDays = payload?.windowDays ?? 90;
      for (const [supplierId, row] of Object.entries(this.state.suppliersById)) {
        const h = deterministicHash(`${supplierId}:${windowDays}`);
        row.reliabilityScore = h % 101;
      }
      return mkOk(requestId, { updatedSuppliersCount: Object.keys(this.state.suppliersById).length });
    });
  }

  // -------- Risk --------
  async riskRefreshListingHealth(
    requestId: string,
    payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ pausedListingsDelta: number; metricsRefreshed: boolean }>> {
    return this.idempotent(requestId, async () => {
      void payload;
      if (shouldFail(requestId, "riskRefresh")) {
        return mkFail(requestId, "external_integration_required", "Risk refresh failed (mock transient)");
      }

      const beforePaused = Object.values(this.state.listings).filter((l) => l.status === "paused").length;
      for (const l of Object.values(this.state.listings)) {
        if (l.sellingPrice - l.sourceCost < 0) l.status = "paused";
      }
      const afterPaused = Object.values(this.state.listings).filter((l) => l.status === "paused").length;
      const delta = afterPaused - beforePaused;

      this.state.lastSnapshot = {
        negativeMarginListings: Object.values(this.state.listings).filter((l) => l.sellingPrice - l.sourceCost < 0).length,
        pausedListings: afterPaused,
        highReturnRateListings: 0,
        listingHealthAlerts: Math.max(0, delta),
      };

      return mkOk(requestId, { pausedListingsDelta: delta, metricsRefreshed: true });
    });
  }

  async riskRefreshCustomerMetrics(
    requestId: string,
    payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ abuseSignalsUpdated: number; metricsRefreshed: boolean }>> {
    return this.idempotent(requestId, async () => {
      void payload;
      if (shouldFail(requestId, "riskRefreshCustomer")) {
        return mkFail(requestId, "external_integration_required", "Customer metrics refresh failed (mock transient)");
      }

      const abuseSignalsUpdated = 3;
      this.state.lastSnapshot = {
        ...this.state.lastSnapshot,
        listingHealthAlerts: this.state.lastSnapshot.listingHealthAlerts + abuseSignalsUpdated,
      };
      return mkOk(requestId, { abuseSignalsUpdated, metricsRefreshed: true });
    });
  }

  async riskGetDashboardSnapshot(requestId: string): Promise<TransportResponse<{ snapshot: RiskDashboardSnapshot }>> {
    return mkOk(requestId, { snapshot: this.state.lastSnapshot });
  }
}

