import type { AdminTransport } from "./adminTransport";
import type {
  ApprovalListing,
  ApprovalOrder,
  CapitalSnapshot,
  IncidentRow,
  ReturnRow,
  RiskDashboardSnapshot,
  SupplierReturnPolicy,
  SupplierRow,
  TransportResponse,
} from "./types";

import { mkFailExternal } from "./httpTransportUtils";

function mkOk<T>(requestId: string, extra: T): TransportResponse<T> {
  return { requestId, ok: true, ...(extra as T) } as TransportResponse<T>;
}

/** Narrow JSON body for dynamic field access without duplicate identifier issues. */
function jsonBody(data: unknown): Record<string, unknown> {
  return data !== null && typeof data === "object" ? (data as Record<string, unknown>) : {};
}

/** Map Dart/Next `GET /incidents/:id` list row shape to `IncidentRow` (optional fields defaulted). */
function incidentRowFromDetailPayload(r: Record<string, unknown>): IncidentRow {
  const statusRaw = String(r.status ?? "open");
  const status: IncidentRow["status"] = statusRaw === "resolved" ? "resolved" : "open";
  return {
    id: Number(r.id),
    orderId: String(r.orderId ?? ""),
    incidentType: String(r.incidentType ?? ""),
    status,
    trigger: String(r.trigger ?? ""),
    automaticDecision: r.automaticDecision != null ? String(r.automaticDecision) : null,
    supplierInteraction: r.supplierInteraction != null ? String(r.supplierInteraction) : null,
    marketplaceInteraction: r.marketplaceInteraction != null ? String(r.marketplaceInteraction) : null,
    refundAmount: typeof r.refundAmount === "number" ? r.refundAmount : null,
    financialImpact: typeof r.financialImpact === "number" ? r.financialImpact : null,
    decisionLogId: r.decisionLogId != null ? String(r.decisionLogId) : null,
    createdAt: String(r.createdAt ?? ""),
    resolvedAt: r.resolvedAt != null && String(r.resolvedAt) !== "" ? String(r.resolvedAt) : null,
    attachmentIds: Array.isArray(r.attachmentIds) ? (r.attachmentIds as string[]) : null,
  };
}

async function fetchJson(
  requestId: string,
  path: string,
): Promise<{ ok: true; data: unknown } | { ok: false; status: number }> {
  try {
    const res = await fetch(path, { cache: "no-store" });
    if (!res.ok) return { ok: false, status: res.status };
    return { ok: true, data: await res.json() as unknown };
  } catch {
    return { ok: false, status: 503 };
  }
}

async function postJson(
  requestId: string,
  path: string,
  body: unknown,
): Promise<{ ok: true; data: unknown } | { ok: false; status: number }> {
  try {
    const res = await fetch(path, {
      method: "POST",
      cache: "no-store",
      headers: { "content-type": "application/json" },
      body: JSON.stringify(body),
    });
    if (!res.ok) return { ok: false, status: res.status };
    return { ok: true, data: await res.json() as unknown };
  } catch {
    return { ok: false, status: 503 };
  }
}

async function patchJson(
  requestId: string,
  path: string,
  body: unknown,
): Promise<{ ok: true; data: unknown } | { ok: false; status: number }> {
  try {
    const res = await fetch(path, {
      method: "PATCH",
      cache: "no-store",
      headers: { "content-type": "application/json" },
      body: JSON.stringify(body),
    });
    if (!res.ok) return { ok: false, status: res.status };
    return { ok: true, data: await res.json() as unknown };
  } catch {
    return { ok: false, status: 503 };
  }
}

function returnRowFromPayload(r: Record<string, unknown>): ReturnRow {
  const statusRaw = String(r.status ?? "requested");
  const status: ReturnRow["status"] =
    statusRaw === "approved" || statusRaw === "shipped" || statusRaw === "received" || statusRaw === "refunded" || statusRaw === "rejected"
      ? statusRaw
      : "requested";
  return {
    id: String(r.id ?? ""),
    orderId: String(r.orderId ?? ""),
    status,
    reason: String(r.reason ?? ""),
    notes: r.notes != null ? String(r.notes) : null,
    refundAmount: typeof r.refundAmount === "number" ? r.refundAmount : null,
    returnShippingCost: typeof r.returnShippingCost === "number" ? r.returnShippingCost : null,
    restockingFee: typeof r.restockingFee === "number" ? r.restockingFee : null,
    returnRoutingDestination: r.returnRoutingDestination != null ? (String(r.returnRoutingDestination) as ReturnRow["returnRoutingDestination"]) : null,
    supplierId: r.supplierId != null ? String(r.supplierId) : null,
    requestedAt: r.requestedAt != null ? String(r.requestedAt) : null,
    resolvedAt: r.resolvedAt != null ? String(r.resolvedAt) : null,
  };
}

function approvalListingFromPayload(r: Record<string, unknown>): ApprovalListing {
  const statusRaw = String(r.status ?? "draft");
  const status: ApprovalListing["status"] =
    statusRaw === "pendingApproval" || statusRaw === "active" || statusRaw === "paused" || statusRaw === "soldOut"
      ? statusRaw
      : "draft";
  return {
    id: String(r.id ?? ""),
    status,
    productId: String(r.productId ?? ""),
    targetPlatformId: String(r.targetPlatformId ?? ""),
    sellingPrice: typeof r.sellingPrice === "number" ? r.sellingPrice : 0,
    sourceCost: typeof r.sourceCost === "number" ? r.sourceCost : 0,
    variantId: r.variantId != null ? String(r.variantId) : null,
  };
}

function approvalOrderFromPayload(r: Record<string, unknown>): ApprovalOrder {
  const statusRaw = String(r.status ?? "pending");
  const status: ApprovalOrder["status"] =
    statusRaw === "pendingApproval" || statusRaw === "sourceOrderPlaced" || statusRaw === "shipped" || statusRaw === "delivered" || statusRaw === "failed" || statusRaw === "failedOutOfStock" || statusRaw === "cancelled"
      ? statusRaw
      : "pending";
  return {
    id: String(r.id ?? ""),
    targetOrderId: String(r.targetOrderId ?? ""),
    platform: String(r.platform ?? ""),
    status,
    quantity: typeof r.quantity === "number" ? r.quantity : 1,
    sellingPrice: typeof r.sellingPrice === "number" ? r.sellingPrice : 0,
    sourceCost: typeof r.sourceCost === "number" ? r.sourceCost : 0,
    profit: typeof r.profit === "number" ? r.profit : 0,
    riskScore: typeof r.riskScore === "number" ? r.riskScore : 0,
    queuedForCapital: r.queuedForCapital === true,
    createdAt: String(r.createdAt ?? ""),
  };
}

export class HttpTransport implements AdminTransport {
  constructor(private opts?: { baseApiPath?: string }) {}

  private base(): string {
    return this.opts?.baseApiPath ?? "";
  }

  // -------- Approval queue --------
  async approvalGetPendingListings(requestId: string): Promise<TransportResponse<{ pendingListings: ApprovalListing[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/approval`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load approval (${res.status})`);
    const d = jsonBody(res.data);
    const pendingListings = (d.pendingListings ?? []) as ApprovalListing[];
    return mkOk(requestId, { pendingListings });
  }

  async approvalGetPendingOrders(requestId: string): Promise<TransportResponse<{ pendingOrders: ApprovalOrder[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/approval`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load approval (${res.status})`);
    const d = jsonBody(res.data);
    const pendingOrders = (d.pendingOrders ?? []) as ApprovalOrder[];
    return mkOk(requestId, { pendingOrders });
  }

  async approvalRejectListing(
    listingId: string,
    requestId: string,
  ): Promise<TransportResponse<{ listing: ApprovalListing }>> {
    const res = await postJson(requestId, `${this.base()}/api/approval/listings/${encodeURIComponent(listingId)}/reject`, {});
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to reject listing (${res.status})`);
    const d = jsonBody(res.data);
    const row = (d.listing ?? d.row ?? null) as Record<string, unknown> | null;
    if (!row) return mkFailExternal(requestId, "external_integration_required", "Reject listing response missing listing");
    return mkOk(requestId, { listing: approvalListingFromPayload(row) });
  }

  async approvalApproveListing(
    listingId: string,
    requestId: string,
  ): Promise<TransportResponse<{ listing: ApprovalListing }>> {
    const res = await postJson(requestId, `${this.base()}/api/approval/listings/${encodeURIComponent(listingId)}/approve`, {});
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to approve listing (${res.status})`);
    const d = jsonBody(res.data);
    const row = (d.listing ?? d.row ?? null) as Record<string, unknown> | null;
    if (!row) return mkFailExternal(requestId, "external_integration_required", "Approve listing response missing listing");
    return mkOk(requestId, { listing: approvalListingFromPayload(row) });
  }

  async approvalRejectOrder(
    orderId: string,
    requestId: string,
    _reason: string,
  ): Promise<TransportResponse<{ order: ApprovalOrder }>> {
    const res = await postJson(requestId, `${this.base()}/api/approval/orders/${encodeURIComponent(orderId)}/reject`, {});
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to reject order (${res.status})`);
    const d = jsonBody(res.data);
    const row = (d.order ?? d.row ?? null) as Record<string, unknown> | null;
    if (!row) return mkFailExternal(requestId, "external_integration_required", "Reject order response missing order");
    return mkOk(requestId, { order: approvalOrderFromPayload(row) });
  }

  async approvalApproveAndFulfillOrder(
    orderId: string,
    requestId: string,
  ): Promise<TransportResponse<{ order: ApprovalOrder }>> {
    const res = await postJson(requestId, `${this.base()}/api/approval/orders/${encodeURIComponent(orderId)}/approve`, {});
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to approve order (${res.status})`);
    const d = jsonBody(res.data);
    const row = (d.order ?? d.row ?? null) as Record<string, unknown> | null;
    if (!row) return mkFailExternal(requestId, "external_integration_required", "Approve order response missing order");
    return mkOk(requestId, { order: approvalOrderFromPayload(row) });
  }

  // -------- Returns --------
  async returnsGetReturns(requestId: string): Promise<TransportResponse<{ rows: ReturnRow[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/returns`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load returns (${res.status})`);
    return mkOk(requestId, { rows: (jsonBody(res.data).rows ?? []) as ReturnRow[] });
  }

  async returnsComputeRouting(
    _returnId: string,
    requestId: string,
  ): Promise<
    TransportResponse<{
      returnId: string;
      routing: { destination: ReturnRow["returnRoutingDestination"] };
    }>
  > {
    return mkFailExternal(requestId, "external_integration_required", "compute routing not wired to HTTP mode yet");
  }

  async returnsUpdateReturn(
    requestId: string,
    returnId: string,
    patch: Partial<ReturnRow> & { status: ReturnRow["status"] },
    addToReturnedStock: boolean,
  ): Promise<
    TransportResponse<{
      return: ReturnRow;
      returnedStockCreated: { created: boolean; rowsInserted: number };
    }>
  > {
    const res = await patchJson(requestId, `${this.base()}/api/returns/${encodeURIComponent(returnId)}`, {
      patch,
      addToReturnedStock,
    });
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to update return (${res.status})`);
    const d = jsonBody(res.data);
    const row = (d.return ?? d.row ?? null) as Record<string, unknown> | null;
    if (!row) return mkFailExternal(requestId, "external_integration_required", "Return update response missing return");
    const stock = jsonBody(d.returnedStockCreated);
    return mkOk(requestId, {
      return: returnRowFromPayload(row),
      returnedStockCreated: {
        created: stock.created === true,
        rowsInserted: typeof stock.rowsInserted === "number" ? stock.rowsInserted : 0,
      },
    });
  }

  // -------- Incidents --------
  async incidentsGetIncidents(requestId: string): Promise<TransportResponse<{ rows: IncidentRow[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/incidents`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load incidents (${res.status})`);
    return mkOk(requestId, { rows: (jsonBody(res.data).rows ?? []) as IncidentRow[] });
  }

  async incidentsCreateIncident(
    requestId: string,
    payload: { orderId: string; incidentType: string; attachmentIds?: string[] },
  ): Promise<TransportResponse<{ incident: IncidentRow }>> {
    const res = await postJson(requestId, `${this.base()}/api/incidents`, payload);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to create incident (${res.status})`);
    const d = jsonBody(res.data);
    const incidentRaw = (d.incident ?? d.row ?? null) as Record<string, unknown> | null;
    if (!incidentRaw) return mkFailExternal(requestId, "external_integration_required", "Incident create response missing incident");
    return mkOk(requestId, { incident: incidentRowFromDetailPayload(incidentRaw) });
  }

  async incidentsGetIncident(
    requestId: string,
    incidentId: number,
  ): Promise<TransportResponse<{ incident: IncidentRow | null }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/incidents/${incidentId}`);
    if (!res.ok) {
      if (res.status === 404) return mkOk(requestId, { incident: null });
      return mkFailExternal(requestId, "external_integration_required", `Failed to load incident (${res.status})`);
    }
    const d = jsonBody(res.data);
    const rows = (d.rows ?? []) as Record<string, unknown>[];
    const first = rows[0];
    if (!first) return mkOk(requestId, { incident: null });
    return mkOk(requestId, { incident: incidentRowFromDetailPayload(first) });
  }

  async incidentsProcessIncident(
    requestId: string,
    incidentId: number,
  ): Promise<TransportResponse<{ incident: IncidentRow }>> {
    const res = await patchJson(requestId, `${this.base()}/api/incidents/${incidentId}`, { status: "resolved" });
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to process incident (${res.status})`);
    const d = jsonBody(res.data);
    const incidentRaw = (d.incident ?? d.row ?? null) as Record<string, unknown> | null;
    if (!incidentRaw) return mkFailExternal(requestId, "external_integration_required", "Incident process response missing incident");
    return mkOk(requestId, { incident: incidentRowFromDetailPayload(incidentRaw) });
  }

  // -------- Capital --------
  async capitalGetSnapshot(requestId: string): Promise<TransportResponse<{ snapshot: CapitalSnapshot }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/capital`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load capital (${res.status})`);
    const b = jsonBody(res.data);
    const snapshot = (b.summary ?? b.snapshot ?? null) as CapitalSnapshot;
    return mkOk(requestId, { snapshot: snapshot ?? { balance: 0, entriesRecent: [], queuedOrders: [] } });
  }

  async capitalRecordAdjustment(
    requestId: string,
    payload: { amount: number; referenceId: string | null; currency?: string },
  ): Promise<TransportResponse<{ balance: number; ledgerEntryId: number }>> {
    const res = await postJson(requestId, `${this.base()}/api/capital/adjust`, payload);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to record adjustment (${res.status})`);
    const d = jsonBody(res.data);
    const balance = typeof d.balance === "number" ? d.balance : 0;
    const ledgerEntryId = typeof d.ledgerEntryId === "number" ? d.ledgerEntryId : 0;
    return mkOk(requestId, { balance, ledgerEntryId });
  }

  // -------- Policies --------
  async policiesGetAll(requestId: string): Promise<TransportResponse<{ rows: SupplierReturnPolicy[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/return-policies`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load return policies (${res.status})`);
    return mkOk(requestId, { rows: (jsonBody(res.data).rows ?? []) as SupplierReturnPolicy[] });
  }

  async policiesUpsert(
    requestId: string,
    payload: { policy: SupplierReturnPolicy },
  ): Promise<TransportResponse<{ policy: SupplierReturnPolicy }>> {
    const res = await postJson(requestId, `${this.base()}/api/return-policies`, payload);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to save return policy (${res.status})`);
    const d = jsonBody(res.data);
    const policy = (d.policy ?? d.row ?? null) as SupplierReturnPolicy | null;
    if (!policy) return mkFailExternal(requestId, "external_integration_required", "Return policy save response missing policy");
    return mkOk(requestId, { policy });
  }

  // -------- Suppliers --------
  async suppliersGetSuppliers(requestId: string): Promise<TransportResponse<{ rows: SupplierRow[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/suppliers`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load suppliers (${res.status})`);
    return mkOk(requestId, { rows: (jsonBody(res.data).rows ?? []) as SupplierRow[] });
  }

  async suppliersRefreshReliabilityScores(
    requestId: string,
    payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ updatedSuppliersCount: number }>> {
    const res = await postJson(requestId, `${this.base()}/api/suppliers/reliability/refresh`, payload ?? {});
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to refresh reliability (${res.status})`);
    const d = jsonBody(res.data);
    return mkOk(requestId, {
      updatedSuppliersCount: typeof d.updatedSuppliersCount === "number" ? d.updatedSuppliersCount : 0,
    });
  }

  // -------- Risk --------
  async riskRefreshListingHealth(
    requestId: string,
    payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ pausedListingsDelta: number; metricsRefreshed: boolean }>> {
    const res = await postJson(requestId, `${this.base()}/api/risk/listing-health/refresh`, payload ?? {});
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to refresh listing health (${res.status})`);
    const d = jsonBody(res.data);
    return mkOk(requestId, {
      pausedListingsDelta: typeof d.pausedListingsDelta === "number" ? d.pausedListingsDelta : 0,
      metricsRefreshed: d.metricsRefreshed === true,
    });
  }

  async riskRefreshCustomerMetrics(
    requestId: string,
    payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ abuseSignalsUpdated: number; metricsRefreshed: boolean }>> {
    const res = await postJson(requestId, `${this.base()}/api/risk/customer-metrics/refresh`, payload ?? {});
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to refresh customer metrics (${res.status})`);
    const d = jsonBody(res.data);
    return mkOk(requestId, {
      abuseSignalsUpdated: typeof d.abuseSignalsUpdated === "number" ? d.abuseSignalsUpdated : 0,
      metricsRefreshed: d.metricsRefreshed === true,
    });
  }

  async riskGetDashboardSnapshot(requestId: string): Promise<TransportResponse<{ snapshot: RiskDashboardSnapshot }>> {
    // No read endpoint yet; fallback to empty snapshot.
    void requestId;
    return mkOk(requestId, { snapshot: { negativeMarginListings: 0, pausedListings: 0, highReturnRateListings: 0, listingHealthAlerts: 0 } });
  }
}

