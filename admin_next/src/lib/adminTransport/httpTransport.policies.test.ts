import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport policiesUpsert", () => {
  beforeEach(() => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() =>
        Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              policy: {
                supplierId: "sup_1",
                policyType: "returnWindow",
                returnWindowDays: 14,
                restockingFeePercent: 5,
                returnShippingPaidBy: "supplier",
                requiresRma: false,
                warehouseReturnSupported: true,
                virtualRestockSupported: false,
              },
            }),
        } as Response),
      ),
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("POSTs policy payload and returns saved policy", async () => {
    const t = new HttpTransport();
    const res = await t.policiesUpsert("req-pol-1", {
      policy: {
        supplierId: "sup_1",
        policyType: "returnWindow",
        returnWindowDays: 14,
        restockingFeePercent: 5,
        returnShippingPaidBy: "supplier",
        requiresRma: false,
        warehouseReturnSupported: true,
        virtualRestockSupported: false,
      },
    });
    expect(res.ok).toBe(true);
    if (res.ok) {
      expect(res.policy.supplierId).toBe("sup_1");
      expect(res.policy.policyType).toBe("returnWindow");
    }
    expect(fetch).toHaveBeenCalledWith(
      "/api/return-policies",
      expect.objectContaining({
        method: "POST",
      }),
    );
  });
});

