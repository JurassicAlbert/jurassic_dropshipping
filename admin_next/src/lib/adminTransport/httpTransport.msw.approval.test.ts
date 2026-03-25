import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { server } from "../../test/msw/server";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport + MSW (approval)", () => {
  beforeAll(() => server.listen({ onUnhandledRequest: "bypass" }));
  afterEach(() => server.resetHandlers());
  afterAll(() => server.close());

  it("GET /api/approval maps pending listings + orders", async () => {
    const t = new HttpTransport();
    const [l, o] = await Promise.all([
      t.approvalGetPendingListings("req-appr-l"),
      t.approvalGetPendingOrders("req-appr-o"),
    ]);
    expect(l.ok).toBe(true);
    expect(o.ok).toBe(true);
    if (l.ok) expect(l.pendingListings.length).toBe(1);
    if (o.ok) expect(o.pendingOrders.length).toBe(1);
  });

  it("POST approve/reject listing returns mapped ApprovalListing", async () => {
    const t = new HttpTransport();
    const a = await t.approvalApproveListing("list_1", "req-appr-list-a");
    expect(a.ok).toBe(true);
    if (a.ok) {
      expect(a.listing.id).toBe("list_1");
      expect(a.listing.status).toBe("active");
    }
    const r = await t.approvalRejectListing("list_1", "req-appr-list-r");
    expect(r.ok).toBe(true);
    if (r.ok) {
      expect(r.listing.id).toBe("list_1");
      expect(r.listing.status).toBe("draft");
    }
  });

  it("POST approve/reject order returns mapped ApprovalOrder", async () => {
    const t = new HttpTransport();
    const a = await t.approvalApproveAndFulfillOrder("ord_1", "req-appr-ord-a");
    expect(a.ok).toBe(true);
    if (a.ok) {
      expect(a.order.id).toBe("ord_1");
      expect(a.order.status).toBe("sourceOrderPlaced");
    }
    const r = await t.approvalRejectOrder("ord_1", "req-appr-ord-r", "reason");
    expect(r.ok).toBe(true);
    if (r.ok) {
      expect(r.order.id).toBe("ord_1");
      expect(r.order.status).toBe("cancelled");
    }
  });
});

