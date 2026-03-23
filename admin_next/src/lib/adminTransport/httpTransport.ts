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
    _listingId: string,
    requestId: string,
  ): Promise<TransportResponse<{ listing: ApprovalListing }>> {
    return mkFailExternal(requestId, "external_integration_required", "reject listing not wired to HTTP writes yet");
  }

  async approvalApproveListing(
    _listingId: string,
    requestId: string,
  ): Promise<TransportResponse<{ listing: ApprovalListing }>> {
    return mkFailExternal(requestId, "external_integration_required", "approve listing not wired to HTTP writes yet");
  }

  async approvalRejectOrder(
    _orderId: string,
    requestId: string,
    _reason: string,
  ): Promise<TransportResponse<{ order: ApprovalOrder }>> {
    return mkFailExternal(requestId, "external_integration_required", "reject order not wired to HTTP writes yet");
  }

  async approvalApproveAndFulfillOrder(
    _orderId: string,
    requestId: string,
  ): Promise<TransportResponse<{ order: ApprovalOrder }>> {
    return mkFailExternal(requestId, "external_integration_required", "approve & fulfill order not wired to HTTP writes yet");
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
    _returnId: string,
    _patch: Partial<ReturnRow> & { status: ReturnRow["status"] },
    _addToReturnedStock: boolean,
  ): Promise<
    TransportResponse<{
      return: ReturnRow;
      returnedStockCreated: { created: boolean; rowsInserted: number };
    }>
  > {
    return mkFailExternal(requestId, "external_integration_required", "update return not wired to HTTP writes yet");
  }

  // -------- Incidents --------
  async incidentsGetIncidents(requestId: string): Promise<TransportResponse<{ rows: IncidentRow[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/incidents`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load incidents (${res.status})`);
    return mkOk(requestId, { rows: (jsonBody(res.data).rows ?? []) as IncidentRow[] });
  }

  async incidentsCreateIncident(
    requestId: string,
    _payload: { orderId: string; incidentType: string; attachmentIds?: string[] },
  ): Promise<TransportResponse<{ incident: IncidentRow }>> {
    return mkFailExternal(requestId, "external_integration_required", "create incident not wired to HTTP writes yet");
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
    _incidentId: number,
  ): Promise<TransportResponse<{ incident: IncidentRow }>> {
    return mkFailExternal(requestId, "external_integration_required", "process incident not wired to HTTP writes yet");
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
    _payload: { amount: number; referenceId: string | null; currency?: string },
  ): Promise<TransportResponse<{ balance: number; ledgerEntryId: number }>> {
    return mkFailExternal(requestId, "external_integration_required", "record adjustment not wired to HTTP writes yet");
  }

  // -------- Policies --------
  async policiesGetAll(requestId: string): Promise<TransportResponse<{ rows: SupplierReturnPolicy[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/return-policies`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load return policies (${res.status})`);
    return mkOk(requestId, { rows: (jsonBody(res.data).rows ?? []) as SupplierReturnPolicy[] });
  }

  async policiesUpsert(
    requestId: string,
    _payload: { policy: SupplierReturnPolicy },
  ): Promise<TransportResponse<{ policy: SupplierReturnPolicy }>> {
    return mkFailExternal(requestId, "external_integration_required", "upsert policies not wired to HTTP writes yet");
  }

  // -------- Suppliers --------
  async suppliersGetSuppliers(requestId: string): Promise<TransportResponse<{ rows: SupplierRow[] }>> {
    const res = await fetchJson(requestId, `${this.base()}/api/suppliers`);
    if (!res.ok) return mkFailExternal(requestId, "external_integration_required", `Failed to load suppliers (${res.status})`);
    return mkOk(requestId, { rows: (jsonBody(res.data).rows ?? []) as SupplierRow[] });
  }

  async suppliersRefreshReliabilityScores(
    requestId: string,
    _payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ updatedSuppliersCount: number }>> {
    return mkFailExternal(requestId, "external_integration_required", "refresh reliability not wired to HTTP writes yet");
  }

  // -------- Risk --------
  async riskRefreshListingHealth(
    requestId: string,
    _payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ pausedListingsDelta: number; metricsRefreshed: boolean }>> {
    return mkFailExternal(requestId, "external_integration_required", "refresh listing health not wired to HTTP writes yet");
  }

  async riskRefreshCustomerMetrics(
    requestId: string,
    _payload?: { windowDays?: number },
  ): Promise<TransportResponse<{ abuseSignalsUpdated: number; metricsRefreshed: boolean }>> {
    return mkFailExternal(requestId, "external_integration_required", "refresh customer metrics not wired to HTTP writes yet");
  }

  async riskGetDashboardSnapshot(requestId: string): Promise<TransportResponse<{ snapshot: RiskDashboardSnapshot }>> {
    // No read endpoint yet; fallback to empty snapshot.
    void requestId;
    return mkOk(requestId, { snapshot: { negativeMarginListings: 0, pausedListings: 0, highReturnRateListings: 0, listingHealthAlerts: 0 } });
  }
}

