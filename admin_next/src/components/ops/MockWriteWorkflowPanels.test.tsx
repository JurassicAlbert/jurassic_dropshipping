import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { ApprovalWorkflowPanel, IncidentsWorkflowPanel, ReturnsWorkflowPanel } from "./MockWriteWorkflowPanels";

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

