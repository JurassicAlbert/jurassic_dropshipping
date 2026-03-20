"use client";

import { AdminShell } from "@/components/AdminShell";
import { Box, Grid, Stack, Typography } from "@mui/material";
import { KpiCard } from "@/components/dashboard/KpiCard";
import { ProfitTrendChartCard } from "@/components/dashboard/ProfitTrendChartCard";
import { ProfitByPlatformCard } from "@/components/dashboard/ProfitByPlatformCard";
import { MarginBandProfitCard } from "@/components/dashboard/MarginBandProfitCard";
import { AnalyticsIssuesCard } from "@/components/dashboard/AnalyticsIssuesCard";
import { OperationalSignalsCard } from "@/components/dashboard/OperationalSignalsCard";
import { RecentOrdersTableCard } from "@/components/dashboard/RecentOrdersTableCard";
import { DashboardApiPayload, useDashboardData } from "@/lib/dashboardApi";

export default function Home() {
  const mock: DashboardApiPayload = {
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

  const { data, loading, error } = useDashboardData(mock);
  const view = data ?? mock;

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Dashboard
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Materio-like overview with KPIs, profit trend, and recent operational signals.
          </Typography>
          {loading ? (
            <Typography color="text.secondary" sx={{ mt: 0.5 }}>
              Refreshing live analytics...
            </Typography>
          ) : null}
          {error ? (
            <Typography sx={{ mt: 0.5, color: "warning.main", fontWeight: 700 }}>
              {error}. Showing fallback snapshot.
            </Typography>
          ) : null}
        </Box>

        <Grid container spacing={2}>
          {view.kpis.map((k) => (
            <Grid key={k.label} size={{ xs: 12, sm: 6, lg: 3 }}>
              <KpiCard label={k.label} value={k.value} delta={k.delta} chipTone={k.chipTone} />
            </Grid>
          ))}

          <Grid size={{ xs: 12, lg: 8 }}>
            <ProfitTrendChartCard points={view.profitPoints} />
          </Grid>

          <Grid size={{ xs: 12, lg: 4 }}>
            <OperationalSignalsCard signals={view.signals} />
          </Grid>

          <Grid size={{ xs: 12, lg: 6 }}>
            <ProfitByPlatformCard points={view.profitByPlatform} />
          </Grid>

          <Grid size={{ xs: 12, lg: 6 }}>
            <MarginBandProfitCard points={view.profitByMarginBand} />
          </Grid>

          <Grid size={{ xs: 12, lg: 6 }}>
            <AnalyticsIssuesCard issues={view.issues} />
          </Grid>

          <Grid size={{ xs: 12 }}>
            <RecentOrdersTableCard rows={view.recentOrders} />
          </Grid>
        </Grid>
      </Stack>
    </AdminShell>
  );
}
