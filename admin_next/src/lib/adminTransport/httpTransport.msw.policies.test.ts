import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { server } from "../../test/msw/server";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport + MSW (return-policies)", () => {
  beforeAll(() => server.listen({ onUnhandledRequest: "bypass" }));
  afterEach(() => server.resetHandlers());
  afterAll(() => server.close());

  it("saves a return policy via policiesUpsert and maps to SupplierReturnPolicy", async () => {
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
    if (!res.ok) return;
    expect(res.policy.supplierId).toBe("sup_1");
    expect(res.policy.policyType).toBe("returnWindow");
    expect(res.policy.returnWindowDays).toBe(14);
    expect(res.policy.restockingFeePercent).toBe(5);
    expect(res.policy.returnShippingPaidBy).toBe("supplier");
    expect(res.policy.requiresRma).toBe(false);
  });
});

