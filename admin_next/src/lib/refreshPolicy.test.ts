import { assertUiRefreshWithinWarehousePolicy, DASHBOARD_POLL_INTERVAL_MS } from "./refreshPolicy";

describe("TP-E refresh policy constraint", () => {
  it("dashboard has no polling or respects warehouse minimum when enabled", () => {
    expect(DASHBOARD_POLL_INTERVAL_MS).toBe(0);
    expect(() => assertUiRefreshWithinWarehousePolicy()).not.toThrow();
  });
});
