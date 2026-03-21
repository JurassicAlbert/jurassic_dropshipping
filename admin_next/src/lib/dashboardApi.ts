"use client";

import { useEffect, useState } from "react";

export type KpiTone = "success" | "warning" | "error" | "primary";

export type DashboardApiPayload = {
  kpis: { label: string; value: string; delta: string; chipTone: KpiTone }[];
  profitPoints: { day: string; profit: number }[];
  profitByPlatform: {
    platformId: string;
    revenue?: number;
    cost?: number;
    profit: number;
    marginPercent?: number;
    orderCount?: number;
  }[];
  profitByMarginBand: { band: string; profit: number }[];
  returnsByReason?: { reason: string; count: number }[];
  issues: { severity: "critical" | "warning" | "info"; title: string; description: string; entityId?: string | null }[];
  signals: { title: string; subtitle: string; tone: "primary" | "warning" | "error" }[];
  recentOrders: { orderId: string; platform: string; status: "pending" | "shipped" | "failed"; profit: number; risk: number }[];
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
};

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
        const json = (await res.json()) as DashboardApiPayload;
        if (!cancelled) {
          setData(json);
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
