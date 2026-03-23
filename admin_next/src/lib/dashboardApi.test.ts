import { describe, expect, it } from "vitest";
import { DASHBOARD_OFFLINE_FALLBACK, mergeDashboardPayload } from "./dashboardApi";

describe("mergeDashboardPayload", () => {
  it("fills omitted keys from DASHBOARD_OFFLINE_FALLBACK (legacy API)", () => {
    const raw = {
      kpis: [
        { label: "Revenue (30d)", value: "99 PLN", delta: "+0%", chipTone: "primary" as const },
        { label: "Profit (30d)", value: "10 PLN", delta: "+0%", chipTone: "success" as const },
        { label: "Return rate", value: "1%", delta: "+0%", chipTone: "success" as const },
        { label: "Queued for capital", value: "0", delta: "0", chipTone: "warning" as const },
      ],
    };
    const merged = mergeDashboardPayload(raw);
    expect(merged.kpis).toEqual(raw.kpis);
    expect(merged.dashboardPayloadVersion).toBe(DASHBOARD_OFFLINE_FALLBACK.dashboardPayloadVersion);
    expect(merged.dailyFinancialSeries.length).toBeGreaterThan(0);
    expect(merged.capital.availablePln).toBe(DASHBOARD_OFFLINE_FALLBACK.capital.availablePln);
    expect(merged.systemJobs.queueDepth).toBe(DASHBOARD_OFFLINE_FALLBACK.systemJobs.queueDepth);
  });

  it("overrides when API sends v2 fields", () => {
    const merged = mergeDashboardPayload({
      dashboardPayloadVersion: 2,
      capital: {
        availablePln: 100,
        lockedPln: 20,
        returnReservePln: 5,
        cashflowGapPln: 75,
      },
      incidentsOpenCount: 9,
    });
    expect(merged.capital.availablePln).toBe(100);
    expect(merged.incidentsOpenCount).toBe(9);
    expect(merged.kpis).toEqual(DASHBOARD_OFFLINE_FALLBACK.kpis);
  });
});
