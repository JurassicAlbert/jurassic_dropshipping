"use client";

import { AdminShell } from "@/components/AdminShell";
import { Box, Grid, Stack, Typography } from "@mui/material";
import { ProfitTrendChartCard } from "@/components/dashboard/ProfitTrendChartCard";
import { ProfitByPlatformCard } from "@/components/dashboard/ProfitByPlatformCard";
import { MarginBandProfitCard } from "@/components/dashboard/MarginBandProfitCard";
import { AnalyticsIssuesCard } from "@/components/dashboard/AnalyticsIssuesCard";
import { RecentOrdersTableCard } from "@/components/dashboard/RecentOrdersTableCard";
import { useDashboardData } from "@/lib/dashboardApi";
import { JurasicKpiDashboard } from "@/components/kpi/JurasicKpiDashboard";

export default function AnalyticsPage() {
  const { data, loading, offline } = useDashboardData();
  const view = data;

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Analytics
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Live analytics detail with margin and platform breakdowns.
          </Typography>
          {loading ? (
            <Typography color="text.secondary" sx={{ mt: 0.5 }}>
              Loading live analytics...
            </Typography>
          ) : null}
          {!loading && offline ? (
            <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
              Live dashboard API unavailable — showing demo snapshot. Start the Dart dashboard API or set `DART_API_BASE_URL`.
            </Typography>
          ) : null}
        </Box>

        <Grid container spacing={2}>
          <Grid size={{ xs: 12, lg: 8 }}>
            <ProfitTrendChartCard points={view.profitPoints} />
          </Grid>
          <Grid size={{ xs: 12, lg: 4 }}>
            <RecentOrdersTableCard rows={view.recentOrders} />
          </Grid>
          <Grid size={{ xs: 12, lg: 6 }}>
            <ProfitByPlatformCard points={view.profitByPlatform.map((p) => ({ platformId: p.platformId, profit: p.profit }))} />
          </Grid>
          <Grid size={{ xs: 12, lg: 6 }}>
            <MarginBandProfitCard points={view.profitByMarginBand} />
          </Grid>
          <Grid size={{ xs: 12 }}>
            <AnalyticsIssuesCard issues={view.issues} />
          </Grid>
        </Grid>

        <JurasicKpiDashboard />
      </Stack>
    </AdminShell>
  );
}

