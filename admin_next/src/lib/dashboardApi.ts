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

type UseDashboardDataResult = {
  data: DashboardApiPayload | null;
  loading: boolean;
  error: string | null;
};

export function useDashboardData(fallback?: DashboardApiPayload): UseDashboardDataResult {
  const [data, setData] = useState<DashboardApiPayload | null>(fallback ?? null);
  const [loading, setLoading] = useState(fallback == null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;

    (async () => {
      setLoading(true);
      setError(null);
      try {
        const res = await fetch("/api/dashboard", { method: "GET", cache: "no-store" });
        if (!res.ok) {
          if (!cancelled) {
            setError(`API error (${res.status})`);
          }
          return;
        }
        const json = (await res.json()) as DashboardApiPayload;
        if (!cancelled) {
          setData(json);
        }
      } catch {
        if (!cancelled) {
          setError("Unable to reach dashboard API");
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
  }, []);

  return { data, loading, error };
}

