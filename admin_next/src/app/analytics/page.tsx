"use client";

import { AdminShell } from "@/components/AdminShell";
import { Box, Grid, Stack, Typography } from "@mui/material";
import { ProfitTrendChartCard } from "@/components/dashboard/ProfitTrendChartCard";
import { ProfitByPlatformCard } from "@/components/dashboard/ProfitByPlatformCard";
import { MarginBandProfitCard } from "@/components/dashboard/MarginBandProfitCard";
import { AnalyticsIssuesCard } from "@/components/dashboard/AnalyticsIssuesCard";
import { RecentOrdersTableCard } from "@/components/dashboard/RecentOrdersTableCard";
import { useDashboardData } from "@/lib/dashboardApi";

export default function AnalyticsPage() {
  const { data, loading, error } = useDashboardData();

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
          {error ? (
            <Typography sx={{ mt: 0.5, color: "warning.main", fontWeight: 700 }}>
              {error}
            </Typography>
          ) : null}
        </Box>

        <Grid container spacing={2}>
          <Grid size={{ xs: 12, lg: 8 }}>
            <ProfitTrendChartCard points={data?.profitPoints ?? []} />
          </Grid>
          <Grid size={{ xs: 12, lg: 4 }}>
            <RecentOrdersTableCard rows={data?.recentOrders ?? []} />
          </Grid>
          <Grid size={{ xs: 12, lg: 6 }}>
            <ProfitByPlatformCard points={(data?.profitByPlatform ?? []).map((p) => ({ platformId: p.platformId, profit: p.profit }))} />
          </Grid>
          <Grid size={{ xs: 12, lg: 6 }}>
            <MarginBandProfitCard points={data?.profitByMarginBand ?? []} />
          </Grid>
          <Grid size={{ xs: 12 }}>
            <AnalyticsIssuesCard issues={data?.issues ?? []} />
          </Grid>
        </Grid>
      </Stack>
    </AdminShell>
  );
}

