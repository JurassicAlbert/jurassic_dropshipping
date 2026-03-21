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
import { useDashboardData } from "@/lib/dashboardApi";

export default function Home() {
  const { data: view, loading, offline } = useDashboardData();

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
          {!loading && offline ? (
            <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
              Live dashboard API unavailable — showing demo snapshot. Start the Dart dashboard API or set `DART_API_BASE_URL`.
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
