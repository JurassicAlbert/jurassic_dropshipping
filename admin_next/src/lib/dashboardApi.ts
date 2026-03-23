"use client";

import { useEffect, useState } from "react";

export type KpiTone = "success" | "warning" | "error" | "primary";

export type DailyFinancialPoint = {
  dayLabel: string;
  revenue: number;
  profit: number;
  marginPercent: number;
};

export type ProductProfitRow = {
  listingId: string;
  revenue: number;
  cost?: number;
  profit: number;
  marginPercent: number;
  orderCount: number;
};

export type CountRow = { status: string; count: number };
export type BucketCountRow = { bucket: string; count: number };

export type DashboardApiPayload = {
  dashboardPayloadVersion?: number;
  kpis: { label: string; value: string; delta: string; chipTone: KpiTone }[];
  profitPoints: { day: string; profit: number }[];
  /** Last N days — revenue, profit, margin % (from Dart AnalyticsEngine). */
  dailyFinancialSeries: DailyFinancialPoint[];
  profitTopProducts: ProductProfitRow[];
  lossMakingProducts: ProductProfitRow[];
  profitByPlatform: {
    platformId: string;
    revenue?: number;
    cost?: number;
    profit: number;
    marginPercent?: number;
    orderCount?: number;
  }[];
  profitByMarginBand: { band: string; profit: number }[];
  returnsByReason: { reason: string; count: number }[];
  orderStatusDistribution: CountRow[];
  riskScoreHistogram: BucketCountRow[];
  listingStatusCounts: CountRow[];
  issues: { severity: "critical" | "warning" | "info"; title: string; description: string; entityId?: string | null }[];
  signals: { title: string; subtitle: string; tone: "primary" | "warning" | "error" }[];
  recentOrders: { orderId: string; platform: string; status: "pending" | "shipped" | "failed"; profit: number; risk: number }[];
  /** p7 */
  dailyReturnRateSeries: {
    dayLabel: string;
    returnCount: number;
    shippedCount: number;
    returnRatePercent: number;
  }[];
  returnCostByReason: { reason: string; costPln: number }[];
  totalReturnCostPln: number;
  lowMarginHighRiskCount: number;
  incidentsByType: { type: string; count: number }[];
  dailyIncidents: { dayLabel: string; count: number }[];
  incidentsOpenCount: number;
  /** p12 */
  capital: {
    availablePln: number;
    lockedPln: number;
    returnReservePln: number;
    cashflowGapPln: number;
  };
  /** p8 */
  fulfillment: { medianDays: number; avgDays: number; sampleCount: number };
  failedOrders: { failed: number; total: number; ratePercent: number };
  orderFunnel: { stage: string; count: number }[];
  /** p9 */
  supplierKpis: {
    supplierId: string;
    name: string;
    orderCount: number;
    returnCount: number;
    returnRatePercent: number;
  }[];
  /** p10 */
  listingHealthHistogram: BucketCountRow[];
  blockedListingsCount: number;
  topRiskListings: { listingId: string; avgRisk: number; orderCount: number }[];
  /** p11 */
  customerMessaging: { hasData: boolean; note?: string };
  /** p13 */
  marketListing: {
    priceCompetitivenessIndex: number | null;
    listingConversionRate: number | null;
    note?: string;
  };
  /** p14 */
  systemJobs: {
    byStatus: Record<string, number>;
    oldestPendingAgeMinutes: number | null;
    processingEfficiencyPercent: number;
    queueDepth: number;
  };
};

/** Demo snapshot when the Dart dashboard API is offline — keeps Dashboard/Analytics usable without a global error banner. */
export const DASHBOARD_OFFLINE_FALLBACK: DashboardApiPayload = {
  kpis: [
    { label: "Revenue (30d)", value: "128,420 PLN", delta: "+12.4%", chipTone: "primary" },
    { label: "Profit (30d)", value: "26,910 PLN", delta: "+4.1%", chipTone: "success" },
    { label: "Return rate", value: "3.8%", delta: "-0.6%", chipTone: "warning" },
    { label: "Queued for capital", value: "7", delta: "+2", chipTone: "warning" },
  ],
  profitPoints: [
    { day: "Mon", profit: 1200 },
    { day: "Tue", profit: 980 },
    { day: "Wed", profit: 1480 },
    { day: "Thu", profit: 1320 },
    { day: "Fri", profit: 1710 },
    { day: "Sat", profit: 900 },
    { day: "Sun", profit: 1120 },
  ],
  profitByPlatform: [
    { platformId: "allegro", profit: 1700 },
    { platformId: "temu", profit: 820 },
  ],
  profitByMarginBand: [
    { band: "0-10%", profit: 120 },
    { band: "10-15%", profit: 260 },
    { band: "15-20%", profit: 680 },
    { band: "20-25%", profit: 910 },
    { band: "25-50%", profit: 1180 },
  ],
  issues: [
    {
      severity: "warning",
      title: "Low margin on listing_earbuds",
      description: "Margin near threshold; consider repricing.",
      entityId: "listing_earbuds",
    },
  ],
  signals: [
    { title: "Auto-paused listings", subtitle: "3 listings paused in last 24h", tone: "primary" },
    { title: "Capital queue", subtitle: "7 orders waiting for capital", tone: "warning" },
    { title: "High return rate", subtitle: "2 listings above threshold", tone: "error" },
  ],
  recentOrders: [
    { orderId: "ord_1021", platform: "Allegro", status: "shipped", profit: 42, risk: 22 },
    { orderId: "ord_1022", platform: "Allegro", status: "pending", profit: 18, risk: 55 },
    { orderId: "ord_1023", platform: "Temu", status: "pending", profit: -6, risk: 61 },
    { orderId: "ord_1024", platform: "Allegro", status: "failed", profit: -24, risk: 78 },
    { orderId: "ord_1025", platform: "Temu", status: "shipped", profit: 33, risk: 19 },
    { orderId: "ord_1026", platform: "Allegro", status: "pending", profit: 7, risk: 44 },
    { orderId: "ord_1027", platform: "Temu", status: "shipped", profit: 25, risk: 28 },
    { orderId: "ord_1028", platform: "Allegro", status: "failed", profit: -11, risk: 72 },
  ],
  dailyFinancialSeries: [
    { dayLabel: "3/1", revenue: 5200, profit: 1100, marginPercent: 21 },
    { dayLabel: "3/2", revenue: 4800, profit: 980, marginPercent: 20.4 },
    { dayLabel: "3/3", revenue: 6100, profit: 1320, marginPercent: 21.6 },
    { dayLabel: "3/4", revenue: 5500, profit: 1050, marginPercent: 19.1 },
    { dayLabel: "3/5", revenue: 7200, profit: 1580, marginPercent: 21.9 },
  ],
  profitTopProducts: [
    { listingId: "listing_demo_a", revenue: 2400, cost: 1600, profit: 800, marginPercent: 33.3, orderCount: 4 },
    { listingId: "listing_demo_b", revenue: 1800, cost: 1200, profit: 600, marginPercent: 33.3, orderCount: 3 },
  ],
  lossMakingProducts: [{ listingId: "listing_demo_loss", revenue: 200, profit: -40, marginPercent: -20, orderCount: 1 }],
  orderStatusDistribution: [
    { status: "shipped", count: 42 },
    { status: "pending", count: 12 },
    { status: "failed", count: 2 },
  ],
  riskScoreHistogram: [
    { bucket: "0–20", count: 8 },
    { bucket: "21–40", count: 14 },
    { bucket: "41–60", count: 18 },
    { bucket: "61–80", count: 10 },
    { bucket: "81–100", count: 4 },
  ],
  listingStatusCounts: [
    { status: "active", count: 28 },
    { status: "paused", count: 4 },
  ],
  returnsByReason: [
    { reason: "defective", count: 2 },
    { reason: "changedMind", count: 1 },
  ],
  dashboardPayloadVersion: 2,
  dailyReturnRateSeries: [
    { dayLabel: "3/1", returnCount: 1, shippedCount: 12, returnRatePercent: 8.3 },
    { dayLabel: "3/2", returnCount: 0, shippedCount: 10, returnRatePercent: 0 },
  ],
  returnCostByReason: [
    { reason: "defective", costPln: 120 },
    { reason: "other", costPln: 45 },
  ],
  totalReturnCostPln: 165,
  lowMarginHighRiskCount: 3,
  incidentsByType: [
    { type: "customerReturn14d", count: 1 },
    { type: "complaintDefect", count: 1 },
  ],
  dailyIncidents: [{ dayLabel: "3/4", count: 1 }],
  incidentsOpenCount: 1,
  capital: {
    availablePln: 45000,
    lockedPln: 8200,
    returnReservePln: 165,
    cashflowGapPln: 36635,
  },
  fulfillment: { medianDays: 4.2, avgDays: 5.1, sampleCount: 18 },
  failedOrders: { failed: 2, total: 56, ratePercent: 3.6 },
  orderFunnel: [
    { stage: "pending", count: 8 },
    { stage: "supplier", count: 4 },
    { stage: "fulfilled", count: 40 },
    { stage: "failed_cancel", count: 4 },
  ],
  supplierKpis: [
    {
      supplierId: "sup_a",
      name: "Demo Supplier A",
      orderCount: 30,
      returnCount: 2,
      returnRatePercent: 6.7,
    },
  ],
  listingHealthHistogram: [
    { bucket: "0 issues", count: 22 },
    { bucket: "1 issue", count: 6 },
    { bucket: "2+ issues", count: 2 },
  ],
  blockedListingsCount: 3,
  topRiskListings: [
    { listingId: "listing_r1", avgRisk: 72, orderCount: 5 },
    { listingId: "listing_r2", avgRisk: 61, orderCount: 3 },
  ],
  customerMessaging: {
    hasData: false,
    note: "Wire customer/message tables when messaging ingestion is enabled.",
  },
  marketListing: {
    priceCompetitivenessIndex: null,
    listingConversionRate: null,
    note: "Requires marketplace impression/click feeds or stored competitor samples.",
  },
  systemJobs: {
    byStatus: { pending: 2, running: 0, completed: 120, failed: 1 },
    oldestPendingAgeMinutes: 12,
    processingEfficiencyPercent: 99.2,
    queueDepth: 2,
  },
};

/** Shallow merge: API JSON overwrites fallback; omitted keys keep offline demo values (backward compatible with older Dart payloads). */
export function mergeDashboardPayload(raw: Partial<DashboardApiPayload>): DashboardApiPayload {
  return { ...DASHBOARD_OFFLINE_FALLBACK, ...raw };
}

function debugLogDashboardApiFailures(): boolean {
  return process.env.NEXT_PUBLIC_SHOW_DASHBOARD_API_ERRORS === "true";
}

type UseDashboardDataResult = {
  data: DashboardApiPayload;
  loading: boolean;
  /** True when `/api/dashboard` failed and we are showing the offline snapshot (no loud error banner). */
  offline: boolean;
};

export function useDashboardData(fallback: DashboardApiPayload = DASHBOARD_OFFLINE_FALLBACK): UseDashboardDataResult {
  const [data, setData] = useState<DashboardApiPayload>(fallback);
  const [loading, setLoading] = useState(true);
  const [offline, setOffline] = useState(false);

  useEffect(() => {
    let cancelled = false;

    (async () => {
      setLoading(true);
      setOffline(false);
      try {
        const res = await fetch("/api/dashboard", { method: "GET", cache: "no-store" });
        if (!res.ok) {
          if (!cancelled) {
            setData(fallback);
            setOffline(true);
          }
          if (debugLogDashboardApiFailures()) {
            console.warn(`[dashboard] /api/dashboard returned ${res.status}; using offline snapshot.`);
          }
          return;
        }
        const json = (await res.json()) as Partial<DashboardApiPayload>;
        if (!cancelled) {
          setData(mergeDashboardPayload(json));
          setOffline(false);
        }
      } catch (e) {
        if (!cancelled) {
          setData(fallback);
          setOffline(true);
        }
        if (debugLogDashboardApiFailures()) {
          console.warn("[dashboard] /api/dashboard unreachable; using offline snapshot.", e);
        }
      } finally {
        if (!cancelled) {
          setLoading(false);
        }
      }
    })();

    return () => {
      cancelled = true;
    };
  }, [fallback]);

  return { data, loading, offline };
}
