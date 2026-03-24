import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import {
  ApprovalWorkflowPanel,
  CapitalWorkflowPanel,
  IncidentsWorkflowPanel,
  ReturnPoliciesWorkflowPanel,
  ReturnsWorkflowPanel,
  SupplierReliabilityAndRiskPanel,
} from "./MockWriteWorkflowPanels";

const approvalGetPendingListings = vi.fn();
const approvalGetPendingOrders = vi.fn();
const approvalApproveListing = vi.fn();
const approvalRejectListing = vi.fn();
const approvalApproveAndFulfillOrder = vi.fn();
const approvalRejectOrder = vi.fn();
const returnsGetReturns = vi.fn();
const returnsComputeRouting = vi.fn();
const returnsUpdateReturn = vi.fn();
const incidentsGetIncidents = vi.fn();
const incidentsCreateIncident = vi.fn();
const incidentsProcessIncident = vi.fn();
const capitalGetSnapshot = vi.fn();
const capitalRecordAdjustment = vi.fn();
const policiesGetAll = vi.fn();
const policiesUpsert = vi.fn();
const suppliersGetSuppliers = vi.fn();
const suppliersRefreshReliabilityScores = vi.fn();
const riskGetDashboardSnapshot = vi.fn();
const riskRefreshListingHealth = vi.fn();
const riskRefreshCustomerMetrics = vi.fn();

vi.mock("@/lib/adminTransport", () => ({
  getAdminTransport: () => ({
    approvalGetPendingListings,
    approvalGetPendingOrders,
    approvalApproveListing,
    approvalRejectListing,
    approvalApproveAndFulfillOrder,
    approvalRejectOrder,
    returnsGetReturns,
    returnsComputeRouting,
    returnsUpdateReturn,
    incidentsGetIncidents,
    incidentsCreateIncident,
    incidentsProcessIncident,
    capitalGetSnapshot,
    capitalRecordAdjustment,
    policiesGetAll,
    policiesUpsert,
    suppliersGetSuppliers,
    suppliersRefreshReliabilityScores,
    riskGetDashboardSnapshot,
    riskRefreshListingHealth,
    riskRefreshCustomerMetrics,
  }),
}));

describe("ApprovalWorkflowPanel", () => {
  beforeEach(() => {
    approvalGetPendingListings.mockReset();
    approvalGetPendingOrders.mockReset();
    approvalApproveListing.mockReset();
    approvalRejectListing.mockReset();
    approvalApproveAndFulfillOrder.mockReset();
    approvalRejectOrder.mockReset();
    returnsGetReturns.mockReset();
    returnsComputeRouting.mockReset();
    returnsUpdateReturn.mockReset();
    incidentsGetIncidents.mockReset();
    incidentsCreateIncident.mockReset();
    incidentsProcessIncident.mockReset();
    capitalGetSnapshot.mockReset();
    capitalRecordAdjustment.mockReset();
    policiesGetAll.mockReset();
    policiesUpsert.mockReset();
    suppliersGetSuppliers.mockReset();
    suppliersRefreshReliabilityScores.mockReset();
    riskGetDashboardSnapshot.mockReset();
    riskRefreshListingHealth.mockReset();
    riskRefreshCustomerMetrics.mockReset();

    approvalGetPendingListings.mockResolvedValue({
      ok: true,
      requestId: "r1",
      pendingListings: [{ id: "lst-1", status: "pendingApproval" }],
    });
    approvalGetPendingOrders.mockResolvedValue({
      ok: true,
      requestId: "r2",
      pendingOrders: [{ id: "ord-internal-1", targetOrderId: "ORD-1", status: "pendingApproval" }],
    });
    approvalApproveListing.mockResolvedValue({
      ok: true,
      requestId: "r3",
      listing: { id: "lst-1", status: "active" },
    });
    approvalRejectListing.mockResolvedValue({
      ok: true,
      requestId: "r4",
      listing: { id: "lst-1", status: "draft" },
    });
    approvalApproveAndFulfillOrder.mockResolvedValue({
      ok: true,
      requestId: "r5",
      order: { id: "ord-internal-1", targetOrderId: "ORD-1", status: "sourceOrderPlaced" },
    });
    approvalRejectOrder.mockResolvedValue({
      ok: true,
      requestId: "r6",
      order: { id: "ord-internal-1", targetOrderId: "ORD-1", status: "cancelled" },
    });
    returnsGetReturns.mockResolvedValue({
      ok: true,
      requestId: "r9",
      rows: [
        {
          id: "ret-1",
          orderId: "ord-1",
          status: "requested",
          reason: "notAsDescribed",
          notes: null,
          refundAmount: null,
        },
      ],
    });
    returnsComputeRouting.mockResolvedValue({
      ok: true,
      requestId: "r10",
      returnId: "ret-1",
      routing: { destination: "sellerAddress" },
    });
    returnsUpdateReturn.mockResolvedValue({
      ok: true,
      requestId: "r11",
      return: {
        id: "ret-1",
        orderId: "ord-1",
        status: "approved",
      },
      returnedStockCreated: { created: false, rowsInserted: 0 },
    });
    incidentsGetIncidents.mockResolvedValue({
      ok: true,
      requestId: "r12",
      rows: [{ id: 101, orderId: "ord-1", status: "open" }],
    });
    incidentsCreateIncident.mockResolvedValue({
      ok: true,
      requestId: "r13",
      incident: { id: 101, orderId: "ord-1", status: "open" },
    });
    incidentsProcessIncident.mockResolvedValue({
      ok: true,
      requestId: "r14",
      incident: { id: 101, orderId: "ord-1", status: "resolved" },
    });
    capitalGetSnapshot.mockResolvedValue({
      ok: true,
      requestId: "r15",
      snapshot: { balance: 100, entriesRecent: [], queuedOrders: [] },
    });
    capitalRecordAdjustment.mockResolvedValue({
      ok: true,
      requestId: "r16",
      balance: 110,
      ledgerEntryId: 1,
    });
    policiesGetAll.mockResolvedValue({
      ok: true,
      requestId: "r17",
      rows: [],
    });
    policiesUpsert.mockResolvedValue({
      ok: true,
      requestId: "r18",
      policy: { supplierId: "sup_1", policyType: "returnWindow" },
    });
    suppliersGetSuppliers.mockResolvedValue({
      ok: true,
      requestId: "r19",
      rows: [],
    });
    suppliersRefreshReliabilityScores.mockResolvedValue({
      ok: true,
      requestId: "r20",
      updatedSuppliersCount: 1,
    });
    riskGetDashboardSnapshot.mockResolvedValue({
      ok: true,
      requestId: "r21",
      snapshot: { negativeMarginListings: 0, pausedListings: 0, listingHealthAlerts: 0 },
    });
    riskRefreshListingHealth.mockResolvedValue({
      ok: true,
      requestId: "r22",
      pausedListingsDelta: 0,
      metricsRefreshed: true,
    });
    riskRefreshCustomerMetrics.mockResolvedValue({
      ok: true,
      requestId: "r23",
      abuseSignalsUpdated: 0,
      metricsRefreshed: true,
    });
  });

  it("auto-loads on mount and shows initial counts", async () => {
    render(<ApprovalWorkflowPanel />);

    await waitFor(() => {
      expect(approvalGetPendingListings).toHaveBeenCalledTimes(1);
      expect(approvalGetPendingOrders).toHaveBeenCalledTimes(1);
    });

    expect(screen.getByText("Pending listings: 1")).toBeInTheDocument();
    expect(screen.getByText("Pending orders: 1")).toBeInTheDocument();
    expect(screen.getByText("lst-1")).toBeInTheDocument();
    expect(screen.getByText("ORD-1")).toBeInTheDocument();
  });

  it("refresh button triggers another load", async () => {
    const user = userEvent.setup();
    render(<ApprovalWorkflowPanel />);

    await waitFor(() => expect(approvalGetPendingListings).toHaveBeenCalledTimes(1));

    await user.click(screen.getByRole("button", { name: "Refresh" }));

    await waitFor(() => {
      expect(approvalGetPendingListings).toHaveBeenCalledTimes(2);
      expect(approvalGetPendingOrders).toHaveBeenCalledTimes(2);
    });
  });

  it("shows processing transition while approve is in flight", async () => {
    const user = userEvent.setup();
    let resolveApprove: (value: unknown) => void = () => {};
    const approvePromise = new Promise((resolve) => {
      resolveApprove = resolve;
    });
    approvalApproveListing.mockReturnValueOnce(approvePromise);

    render(<ApprovalWorkflowPanel />);
    await screen.findByText("lst-1");

    await user.click(screen.getByRole("button", { name: "Approve" }));

    await waitFor(() => expect(screen.getByText("lst-1")).toBeInTheDocument());
    expect(screen.getByText("Processing...")).toBeInTheDocument();

    resolveApprove({
      ok: true,
      requestId: "r7",
      listing: { id: "lst-1", status: "active" },
    });
    await waitFor(() => expect(approvalApproveListing).toHaveBeenCalledTimes(1));
  });

  it("keeps row and shows error when approve fails", async () => {
    const user = userEvent.setup();
    approvalApproveListing.mockResolvedValueOnce({
      ok: false,
      requestId: "r8",
      error: { code: "conflict", message: "approve failed" },
    });

    render(<ApprovalWorkflowPanel />);
    await screen.findByText("lst-1");

    await user.click(screen.getByRole("button", { name: "Approve" }));

    await waitFor(() => expect(screen.getByText("lst-1")).toBeInTheDocument());
    expect(screen.getByText("approve failed")).toBeInTheDocument();
  });
});

describe("CapitalWorkflowPanel", () => {
  it("shows transition label while recording adjustment", async () => {
    const user = userEvent.setup();
    let resolveAdjust: (value: unknown) => void = () => {};
    capitalRecordAdjustment.mockReturnValueOnce(new Promise((resolve) => (resolveAdjust = resolve)));

    render(<CapitalWorkflowPanel />);
    await screen.findByText(/Balance:/);
    await user.click(screen.getByRole("button", { name: "Record adjustment" }));
    await waitFor(() => expect(screen.getByRole("button", { name: "Processing..." })).toBeInTheDocument());
    resolveAdjust({ ok: true, requestId: "cap-1", balance: 120, ledgerEntryId: 2 });
    await waitFor(() => expect(capitalRecordAdjustment).toHaveBeenCalledTimes(1));
  });
});

describe("ReturnPoliciesWorkflowPanel", () => {
  it("shows transition label while saving policy", async () => {
    const user = userEvent.setup();
    let resolveSave: (value: unknown) => void = () => {};
    policiesUpsert.mockReturnValueOnce(new Promise((resolve) => (resolveSave = resolve)));

    render(<ReturnPoliciesWorkflowPanel />);
    await screen.findByText(/Policies:/);
    await user.click(screen.getByRole("button", { name: "Save policy" }));
    await waitFor(() => expect(screen.getByRole("button", { name: "Processing..." })).toBeInTheDocument());
    resolveSave({ ok: true, requestId: "pol-1", policy: { supplierId: "sup_1", policyType: "returnWindow" } });
    await waitFor(() => expect(policiesUpsert).toHaveBeenCalledTimes(1));
  });
});

describe("SupplierReliabilityAndRiskPanel", () => {
  it("shows transition label while refreshing reliability", async () => {
    const user = userEvent.setup();
    let resolveRefresh: (value: unknown) => void = () => {};
    suppliersRefreshReliabilityScores.mockReturnValueOnce(new Promise((resolve) => (resolveRefresh = resolve)));

    render(<SupplierReliabilityAndRiskPanel />);
    await screen.findByText(/Suppliers:/);
    await user.click(screen.getByRole("button", { name: "Refresh reliability scores" }));
    await waitFor(() => expect(screen.getByRole("button", { name: "Processing..." })).toBeInTheDocument());
    resolveRefresh({ ok: true, requestId: "sup-1", updatedSuppliersCount: 2 });
    await waitFor(() => expect(suppliersRefreshReliabilityScores).toHaveBeenCalledTimes(1));
  });

  it("shows transition label while refreshing listing health", async () => {
    const user = userEvent.setup();
    let resolveRefresh: (value: unknown) => void = () => {};
    riskRefreshListingHealth.mockReturnValueOnce(new Promise((resolve) => (resolveRefresh = resolve)));

    render(<SupplierReliabilityAndRiskPanel />);
    await screen.findByText(/Suppliers:/);
    await user.click(screen.getByRole("button", { name: "Refresh listing health" }));
    await waitFor(() => expect(screen.getByRole("button", { name: "Processing listing health..." })).toBeInTheDocument());
    resolveRefresh({ ok: true, requestId: "risk-1", pausedListingsDelta: 1, metricsRefreshed: true });
    await waitFor(() => expect(riskRefreshListingHealth).toHaveBeenCalledTimes(1));
  });

  it("shows transition label while refreshing customer metrics", async () => {
    const user = userEvent.setup();
    let resolveRefresh: (value: unknown) => void = () => {};
    riskRefreshCustomerMetrics.mockReturnValueOnce(new Promise((resolve) => (resolveRefresh = resolve)));

    render(<SupplierReliabilityAndRiskPanel />);
    await screen.findByText(/Suppliers:/);
    await user.click(screen.getByRole("button", { name: "Refresh customer metrics" }));
    await waitFor(() => expect(screen.getByRole("button", { name: "Processing customer metrics..." })).toBeInTheDocument());
    resolveRefresh({ ok: true, requestId: "risk-2", abuseSignalsUpdated: 2, metricsRefreshed: true });
    await waitFor(() => expect(riskRefreshCustomerMetrics).toHaveBeenCalledTimes(1));
  });
});

describe("ReturnsWorkflowPanel", () => {
  beforeEach(() => {
    returnsGetReturns.mockReset();
    returnsComputeRouting.mockReset();
    returnsUpdateReturn.mockReset();
    returnsGetReturns.mockResolvedValue({
      ok: true,
      requestId: "rr-1",
      rows: [
        {
          id: "ret-1",
          orderId: "ord-1",
          status: "requested",
          reason: "notAsDescribed",
          notes: null,
          refundAmount: null,
        },
      ],
    });
    returnsUpdateReturn.mockResolvedValue({
      ok: true,
      requestId: "rr-2",
      return: { id: "ret-1", orderId: "ord-1", status: "approved" },
      returnedStockCreated: { created: false, rowsInserted: 0 },
    });
  });

  it("shows transition and keeps previous status when save fails", async () => {
    const user = userEvent.setup();
    let resolveSave: (value: unknown) => void = () => {};
    const savePromise = new Promise((resolve) => {
      resolveSave = resolve;
    });
    returnsUpdateReturn.mockReturnValueOnce(savePromise);

    render(<ReturnsWorkflowPanel />);
    await screen.findByText("ret-1");
    expect(screen.getByText("requested")).toBeInTheDocument();

    await user.click(screen.getByRole("button", { name: "Edit" }));
    await user.click(screen.getAllByRole("combobox")[0]);
    await user.click(screen.getByRole("option", { name: "approved" }));
    await user.click(screen.getByRole("button", { name: "Save" }));

    await waitFor(() => expect(screen.getByText("Processing...")).toBeInTheDocument());
    resolveSave({
      ok: false,
      requestId: "rr-3",
      error: { code: "conflict", message: "save failed" },
    });
    await waitFor(() => expect(screen.getByText("requested")).toBeInTheDocument());
    expect(screen.getByText("save failed")).toBeInTheDocument();
  });
});

describe("IncidentsWorkflowPanel", () => {
  beforeEach(() => {
    incidentsGetIncidents.mockReset();
    incidentsCreateIncident.mockReset();
    incidentsProcessIncident.mockReset();
    incidentsGetIncidents.mockResolvedValue({
      ok: true,
      requestId: "ir-1",
      rows: [{ id: 101, orderId: "ord-1", status: "open" }],
    });
    incidentsProcessIncident.mockResolvedValue({
      ok: true,
      requestId: "ir-2",
      incident: { id: 101, orderId: "ord-1", status: "resolved" },
    });
  });

  it("shows processing transition while incident process is in flight", async () => {
    const user = userEvent.setup();
    let resolveProcess: (value: unknown) => void = () => {};
    const processPromise = new Promise((resolve) => {
      resolveProcess = resolve;
    });
    incidentsProcessIncident.mockReturnValueOnce(processPromise);

    render(<IncidentsWorkflowPanel />);
    await screen.findByText("ord-1");

    await user.click(screen.getByRole("button", { name: "Process" }));
    await waitFor(() => expect(screen.getByText("Processing...")).toBeInTheDocument());

    resolveProcess({
      ok: true,
      requestId: "ir-3",
      incident: { id: 101, orderId: "ord-1", status: "resolved" },
    });

    await waitFor(() => expect(incidentsProcessIncident).toHaveBeenCalledTimes(1));
  });

  it("keeps row and shows error when process fails", async () => {
    const user = userEvent.setup();
    incidentsProcessIncident.mockResolvedValueOnce({
      ok: false,
      requestId: "ir-4",
      error: { code: "conflict", message: "process failed" },
    });

    render(<IncidentsWorkflowPanel />);
    await screen.findByText("ord-1");
    await user.click(screen.getByRole("button", { name: "Process" }));

    await waitFor(() => expect(screen.getByText("ord-1")).toBeInTheDocument());
    expect(screen.getByText("process failed")).toBeInTheDocument();
  });
});

