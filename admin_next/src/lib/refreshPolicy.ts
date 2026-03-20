/**
 * Dashboard data is fetched on mount only (no polling). When polling is added,
 * set `DASHBOARD_POLL_INTERVAL_MS` <= warehouse minimum product refresh interval.
 */
export const DASHBOARD_POLL_INTERVAL_MS = 0;

/** Placeholder until warehouse connector documents actual minimum refresh cadence. */
export const WAREHOUSE_PRODUCT_REFRESH_MIN_MS_PLACEHOLDER = 120_000;

export function assertUiRefreshWithinWarehousePolicy(): void {
  if (DASHBOARD_POLL_INTERVAL_MS === 0) return;
  if (DASHBOARD_POLL_INTERVAL_MS < WAREHOUSE_PRODUCT_REFRESH_MIN_MS_PLACEHOLDER) {
    throw new Error(
      "UI refresh interval must not be faster than warehouse product refresh minimum",
    );
  }
}
