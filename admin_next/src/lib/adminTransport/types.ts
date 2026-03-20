export type RequestId = string;

export type ListingStatus = "draft" | "pendingApproval" | "active" | "paused" | "soldOut";
export type OrderStatus =
  | "pending"
  | "pendingApproval"
  | "sourceOrderPlaced"
  | "shipped"
  | "delivered"
  | "failed"
  | "failedOutOfStock"
  | "cancelled";

export type ReturnStatus = "requested" | "approved" | "shipped" | "received" | "refunded" | "rejected";
export type ReturnRoutingDestination = "sellerAddress" | "supplierWarehouse" | "returnCenter" | "disposal";

export type IncidentStatus = "open" | "resolved";

export type SupplierReturnPolicyType =
  | "noReturns"
  | "defectOnly"
  | "returnWindow"
  | "fullReturns"
  | "returnToWarehouse"
  | "sellerHandlesReturns";

export type ReturnShippingPaidBy = "seller" | "customer" | "supplier";

export type MockErrorCode =
  | "not_found"
  | "validation_error"
  | "conflict"
  | "external_integration_required"
  | "unauthorized";

export type AdminError = {
  code: MockErrorCode;
  message: string;
  details?: Record<string, unknown>;
};

export type TransportOkBase = {
  requestId: RequestId;
  ok: true;
};

export type TransportFailBase = {
  requestId: RequestId;
  ok: false;
  error: AdminError;
};

export type TransportResponse<T> = (TransportOkBase & T) | TransportFailBase;

export type ApprovalListing = {
  id: string;
  status: ListingStatus;
  productId: string;
  targetPlatformId: string;
  sellingPrice: number;
  sourceCost: number;
  variantId?: string | null;
};

export type ApprovalOrder = {
  id: string;
  targetOrderId: string;
  platform: string;
  status: OrderStatus;
  quantity: number;
  sellingPrice: number;
  sourceCost: number;
  profit: number;
  riskScore: number;
  queuedForCapital: boolean;
  createdAt: string;
};

export type ReturnRow = {
  id: string;
  orderId: string;
  status: ReturnStatus;
  reason: string;
  notes: string | null;
  refundAmount: number | null;
  returnShippingCost: number | null;
  restockingFee: number | null;
  returnRoutingDestination: ReturnRoutingDestination | null;
  supplierId: string | null;
  requestedAt: string | null;
  resolvedAt: string | null;
};

export type IncidentRow = {
  id: number;
  orderId: string;
  incidentType: string;
  status: IncidentStatus;
  trigger: string;
  automaticDecision?: string | null;
  supplierInteraction?: string | null;
  marketplaceInteraction?: string | null;
  refundAmount?: number | null;
  financialImpact?: number | null;
  decisionLogId?: string | null;
  createdAt: string;
  resolvedAt: string | null;
  attachmentIds?: string[] | null;
};

export type LedgerEntryType = "supplier_prepayment" | "marketplace_held" | "marketplace_released" | "refund" | "loss" | "adjustment";

export type LedgerEntry = {
  id: number;
  type: LedgerEntryType;
  amount: number;
  currency: string;
  orderId: string | null;
  referenceId: string | null;
  createdAt: string;
};

export type CapitalSnapshot = {
  balance: number;
  entriesRecent: LedgerEntry[];
  queuedOrders: ApprovalOrder[];
};

export type SupplierRow = {
  id: string;
  name: string;
  platformType: string;
  countryCode: string | null;
  rating: number | null;
  reliabilityScore: number | null;
  isActiveListings?: boolean;
};

export type SupplierReturnPolicy = {
  supplierId: string;
  policyType: SupplierReturnPolicyType;
  returnWindowDays: number | null;
  restockingFeePercent: number | null;
  returnShippingPaidBy: ReturnShippingPaidBy | null;
  requiresRma: boolean;
  warehouseReturnSupported: boolean;
  virtualRestockSupported: boolean;
};

export type RiskDashboardSnapshot = {
  negativeMarginListings: number;
  pausedListings: number;
  highReturnRateListings: number;
  listingHealthAlerts: number;
};

