import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport approval writes", () => {
  beforeEach(() => {
    vi.stubGlobal(
      "fetch",
      vi.fn((input) => {
        const url = String(input);
        if (url.includes("/api/approval/listings/")) {
          return Promise.resolve({
            ok: true,
            json: () =>
              Promise.resolve({
                listing: {
                  id: "lst-1",
                  status: url.endsWith("/approve") ? "active" : "draft",
                  productId: "prod-1",
                  targetPlatformId: "allegro",
                  sellingPrice: 120,
                  sourceCost: 80,
                },
              }),
          } as Response);
        }
        return Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              order: {
                id: "ord-1",
                targetOrderId: "tord-1",
                platform: "allegro",
                status: url.endsWith("/approve") ? "sourceOrderPlaced" : "cancelled",
                quantity: 1,
                sellingPrice: 120,
                sourceCost: 80,
                profit: 40,
                riskScore: 12,
                queuedForCapital: false,
                createdAt: "2025-01-01T00:00:00.000Z",
              },
            }),
        } as Response);
      }),
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("POSTs listing approve and maps listing", async () => {
    const t = new HttpTransport();
    const res = await t.approvalApproveListing("lst-1", "req-a1");
    expect(res.ok).toBe(true);
    if (res.ok) expect(res.listing.status).toBe("active");
    expect(fetch).toHaveBeenCalledWith(
      "/api/approval/listings/lst-1/approve",
      expect.objectContaining({ method: "POST" }),
    );
  });

  it("POSTs order reject and maps order", async () => {
    const t = new HttpTransport();
    const res = await t.approvalRejectOrder("ord-1", "req-a2", "manual");
    expect(res.ok).toBe(true);
    if (res.ok) expect(res.order.status).toBe("cancelled");
    expect(fetch).toHaveBeenCalledWith(
      "/api/approval/orders/ord-1/reject",
      expect.objectContaining({ method: "POST" }),
    );
  });
});

