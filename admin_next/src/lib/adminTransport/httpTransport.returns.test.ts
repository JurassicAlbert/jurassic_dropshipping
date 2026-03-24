import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport returnsUpdateReturn", () => {
  beforeEach(() => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() =>
        Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              return: {
                id: "ret-1",
                orderId: "ord-1",
                status: "approved",
                reason: "noReason",
                refundAmount: 10,
                requestedAt: "2025-01-01T00:00:00.000Z",
                resolvedAt: null,
              },
              returnedStockCreated: { created: false, rowsInserted: 0 },
            }),
        } as Response),
      ),
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("PATCHes return update payload and maps response", async () => {
    const t = new HttpTransport();
    const res = await t.returnsUpdateReturn(
      "req-ret-1",
      "ret-1",
      { status: "approved", notes: "ok", refundAmount: 10 },
      false,
    );
    expect(res.ok).toBe(true);
    if (res.ok) {
      expect(res.return.id).toBe("ret-1");
      expect(res.return.status).toBe("approved");
      expect(res.returnedStockCreated.rowsInserted).toBe(0);
    }
    expect(fetch).toHaveBeenCalledWith(
      "/api/returns/ret-1",
      expect.objectContaining({ method: "PATCH" }),
    );
  });
});

