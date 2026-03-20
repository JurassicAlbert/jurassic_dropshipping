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

export interface AdminTransport {
  // -------- Approval queue --------
  approvalGetPendingListings(requestId: string): Promise<TransportResponse<{ pendingListings: ApprovalListing[] }>>;
  approvalGetPendingOrders(requestId: string): Promise<TransportResponse<{ pendingOrders: ApprovalOrder[] }>>;
  approvalRejectListing(listingId: string, requestId: string): Promise<TransportResponse<{ listing: ApprovalListing }>>;
  approvalApproveListing(listingId: string, requestId: string): Promise<TransportResponse<{ listing: ApprovalListing }>>;
  approvalRejectOrder(orderId: string, requestId: string, reason: string): Promise<TransportResponse<{ order: ApprovalOrder }>>;
  approvalApproveAndFulfillOrder(
    orderId: string,
    requestId: string,
  ): Promise<TransportResponse<{ order: ApprovalOrder }>>;

  // -------- Returns --------
  returnsGetReturns(requestId: string): Promise<TransportResponse<{ rows: ReturnRow[] }>>;
  returnsComputeRouting(requestId: string, returnId: string): Promise<
    TransportResponse<{ returnId: string; routing: { destination: ReturnRow["returnRoutingDestination"] } }>
  >;
  returnsUpdateReturn(
    requestId: string,
    returnId: string,
    patch: Partial<ReturnRow> & { status: ReturnRow["status"] },
    addToReturnedStock: boolean,
  ): Promise<TransportResponse<{ return: ReturnRow; returnedStockCreated: { created: boolean; rowsInserted: number } }>>;

  // -------- Incidents --------
  incidentsGetIncidents(requestId: string): Promise<TransportResponse<{ rows: IncidentRow[] }>>;
  incidentsCreateIncident(
    requestId: string,
    payload: { orderId: string; incidentType: string; attachmentIds?: string[] },
  ): Promise<TransportResponse<{ incident: IncidentRow }>>;
  incidentsGetIncident(requestId: string, incidentId: number): Promise<TransportResponse<{ incident: IncidentRow | null }>>;
  incidentsProcessIncident(requestId: string, incidentId: number): Promise<TransportResponse<{ incident: IncidentRow }>>;

  // -------- Capital --------
  capitalGetSnapshot(requestId: string): Promise<TransportResponse<{ snapshot: CapitalSnapshot }>>;
  capitalRecordAdjustment(
    requestId: string,
    payload: { amount: number; referenceId: string | null; currency?: string },
  ): Promise<TransportResponse<{ balance: number; ledgerEntryId: number }>>;

  // -------- Return policies --------
  policiesGetAll(requestId: string): Promise<TransportResponse<{ rows: SupplierReturnPolicy[] }>>;
  policiesUpsert(
    requestId: string,
    payload: { policy: SupplierReturnPolicy },
  ): Promise<TransportResponse<{ policy: SupplierReturnPolicy }>>;

  // -------- Suppliers --------
  suppliersGetSuppliers(requestId: string): Promise<TransportResponse<{ rows: SupplierRow[] }>>;
  suppliersRefreshReliabilityScores(requestId: string, payload?: { windowDays?: number }): Promise<
    TransportResponse<{ updatedSuppliersCount: number }>
  >;

  // -------- Risk-triggered refresh --------
  riskRefreshListingHealth(requestId: string, payload?: { windowDays?: number }): Promise<
    TransportResponse<{ pausedListingsDelta: number; metricsRefreshed: boolean }>
  >;
  riskRefreshCustomerMetrics(requestId: string, payload?: { windowDays?: number }): Promise<
    TransportResponse<{ abuseSignalsUpdated: number; metricsRefreshed: boolean }>
  >;
  riskGetDashboardSnapshot(requestId: string): Promise<TransportResponse<{ snapshot: RiskDashboardSnapshot }>>;
}

