import { render, screen, waitFor } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { ApprovalWorkflowPanel } from "./MockWriteWorkflowPanels";

const approvalGetPendingListings = vi.fn();
const approvalGetPendingOrders = vi.fn();

vi.mock("@/lib/adminTransport", () => ({
  getAdminTransport: () => ({
    approvalGetPendingListings,
    approvalGetPendingOrders,
  }),
}));

describe("ApprovalWorkflowPanel", () => {
  beforeEach(() => {
    approvalGetPendingListings.mockReset();
    approvalGetPendingOrders.mockReset();

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
});

