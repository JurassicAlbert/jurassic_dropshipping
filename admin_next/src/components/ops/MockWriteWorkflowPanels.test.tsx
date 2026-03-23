import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { ApprovalWorkflowPanel, ReturnsWorkflowPanel } from "./MockWriteWorkflowPanels";

const approvalGetPendingListings = vi.fn();
const approvalGetPendingOrders = vi.fn();
const approvalApproveListing = vi.fn();
const approvalRejectListing = vi.fn();
const approvalApproveAndFulfillOrder = vi.fn();
const approvalRejectOrder = vi.fn();
const returnsGetReturns = vi.fn();
const returnsComputeRouting = vi.fn();
const returnsUpdateReturn = vi.fn();

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

  it("optimistically removes listing on approve before API resolves", async () => {
    const user = userEvent.setup();
    let resolveApprove: (value: unknown) => void = () => {};
    const approvePromise = new Promise((resolve) => {
      resolveApprove = resolve;
    });
    approvalApproveListing.mockReturnValueOnce(approvePromise);

    render(<ApprovalWorkflowPanel />);
    await screen.findByText("lst-1");

    await user.click(screen.getByRole("button", { name: "Approve" }));

    await waitFor(() => expect(screen.queryByText("lst-1")).not.toBeInTheDocument());

    resolveApprove({
      ok: true,
      requestId: "r7",
      listing: { id: "lst-1", status: "active" },
    });
    await waitFor(() => expect(approvalApproveListing).toHaveBeenCalledTimes(1));
  });

  it("rolls back optimistic removal when approve fails", async () => {
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

  it("optimistically updates status and rolls back when save fails", async () => {
    const user = userEvent.setup();
    returnsUpdateReturn.mockResolvedValueOnce({
      ok: false,
      requestId: "rr-3",
      error: { code: "conflict", message: "save failed" },
    });

    render(<ReturnsWorkflowPanel />);
    await screen.findByText("ret-1");
    expect(screen.getByText("requested")).toBeInTheDocument();

    await user.click(screen.getByRole("button", { name: "Edit" }));
    await user.click(screen.getAllByRole("combobox")[0]);
    await user.click(screen.getByRole("option", { name: "approved" }));
    await user.click(screen.getByRole("button", { name: "Save" }));

    await waitFor(() => expect(screen.getByText("requested")).toBeInTheDocument());
    expect(screen.getByText("save failed")).toBeInTheDocument();
  });
});

