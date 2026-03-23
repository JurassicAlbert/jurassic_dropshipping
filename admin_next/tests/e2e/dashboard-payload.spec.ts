import { expect, test } from "@playwright/test";

/** Minimal v2-shaped body so Analytics shows extended sections without Dart. */
const v2Payload = {
  dashboardPayloadVersion: 2,
  kpis: [
    { label: "Revenue (30d)", value: "100 PLN", delta: "+0%", chipTone: "primary" },
    { label: "Profit (30d)", value: "50 PLN", delta: "+0%", chipTone: "success" },
    { label: "Return rate", value: "2%", delta: "+0%", chipTone: "warning" },
    { label: "Queued for capital", value: "0", delta: "0", chipTone: "warning" },
  ],
  profitPoints: [{ day: "Mon", profit: 10 }],
  dailyFinancialSeries: [{ dayLabel: "1/1", revenue: 100, profit: 50, marginPercent: 50 }],
  profitTopProducts: [],
  lossMakingProducts: [],
  profitByPlatform: [],
  profitByMarginBand: [],
  returnsByReason: [],
  orderStatusDistribution: [],
  riskScoreHistogram: [],
  listingStatusCounts: [],
  issues: [],
  signals: [],
  recentOrders: [],
  dailyReturnRateSeries: [{ dayLabel: "1/1", returnCount: 0, shippedCount: 1, returnRatePercent: 0 }],
  returnCostByReason: [],
  totalReturnCostPln: 0,
  lowMarginHighRiskCount: 0,
  incidentsByType: [],
  dailyIncidents: [],
  incidentsOpenCount: 0,
  capital: { availablePln: 1000, lockedPln: 0, returnReservePln: 0, cashflowGapPln: 1000 },
  fulfillment: { medianDays: 0, avgDays: 0, sampleCount: 0 },
  failedOrders: { failed: 0, total: 0, ratePercent: 0 },
  orderFunnel: [],
  supplierKpis: [],
  listingHealthHistogram: [],
  blockedListingsCount: 0,
  topRiskListings: [],
  customerMessaging: { hasData: false },
  marketListing: { priceCompetitivenessIndex: null, listingConversionRate: null },
  systemJobs: {
    byStatus: { pending: 0 },
    oldestPendingAgeMinutes: null,
    processingEfficiencyPercent: 100,
    queueDepth: 0,
  },
};

test("Analytics shows capital section when /api/dashboard returns v2 payload (stubbed)", async ({ page }) => {
  await page.route("**/api/dashboard", async (route) => {
    await route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify(v2Payload),
    });
  });
  await page.goto("/analytics");
  await expect(page.getByRole("heading", { name: "Analytics", exact: true })).toBeVisible();
  await expect(page.getByTestId("analytics-capital-overline")).toBeVisible();
  await expect(page.getByText("Available (ledger)")).toBeVisible();
  await expect(page.getByTestId("analytics-p11-customer-messaging")).toBeVisible();
  await expect(page.getByTestId("analytics-p13-market-listing")).toBeVisible();
});

test("Profit Dashboard shows core financial when /api/dashboard is stubbed", async ({ page }) => {
  await page.route("**/api/dashboard", async (route) => {
    await route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify(v2Payload),
    });
  });
  await page.goto("/profit-dashboard");
  await expect(page.getByRole("heading", { name: "Profit Dashboard", exact: true })).toBeVisible();
  await expect(page.getByTestId("profit-core-financial-overline")).toBeVisible();
  await expect(page.getByText("Revenue over time")).toBeVisible();
});
