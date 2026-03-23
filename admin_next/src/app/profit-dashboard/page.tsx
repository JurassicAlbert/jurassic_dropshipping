"use client";

import { AdminShell } from "@/components/AdminShell";
import { KpiCard } from "@/components/dashboard/KpiCard";
import { MarginBandProfitCard } from "@/components/dashboard/MarginBandProfitCard";
import { ProfitByPlatformCard } from "@/components/dashboard/ProfitByPlatformCard";
import {
  LossProductsTable,
  MarginTrendChart,
  ProfitByProductBarChart,
  ProfitTimeSeriesChart,
  RevenueTimeSeriesChart,
} from "@/components/profit/ProfitDashboardCharts";
import { useDashboardData } from "@/lib/dashboardApi";
import { Box, Grid, Link as MuiLink, Stack, Typography } from "@mui/material";
import NextLink from "next/link";

/**
 * Profit-focused view: financial time series, top/loss listings, platform & margin bands.
 * Data: same `/api/dashboard` payload as Home (Dart `AnalyticsEngine`).
 */
export default function ProfitDashboardPage() {
  const { data: view, loading, offline } = useDashboardData();

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Profit Dashboard
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Core financial KPIs: revenue, profit, margin, listings, and platform mix — driven by live order data (same{" "}
            <code>/api/dashboard</code> payload as Home).
          </Typography>
          <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
            Risk, capital, operations, suppliers, and extended KPIs:{" "}
            <MuiLink component={NextLink} href="/analytics" fontWeight={700}>
              Analytics
            </MuiLink>
            .
          </Typography>
          {loading ? (
            <Typography color="text.secondary" sx={{ mt: 0.5 }}>
              Loading…
            </Typography>
          ) : null}
          {!loading && offline ? (
            <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
              Live API unavailable — showing offline snapshot. Start the Dart dashboard server for real aggregates.
            </Typography>
          ) : null}
        </Box>

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1 }}>
          Summary KPIs
        </Typography>
        <Grid container spacing={2}>
          {view.kpis.map((k) => (
            <Grid key={k.label} size={{ xs: 12, sm: 6, lg: 3 }}>
              <KpiCard label={k.label} value={k.value} delta={k.delta} chipTone={k.chipTone} />
            </Grid>
          ))}
        </Grid>

        <Typography
          variant="overline"
          sx={{ fontWeight: 800, letterSpacing: 1, mt: 1 }}
          data-testid="profit-core-financial-overline"
        >
          Core financial
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 4 }}>
            <RevenueTimeSeriesChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 4 }}>
            <ProfitTimeSeriesChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 4 }}>
            <MarginTrendChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <ProfitByProductBarChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <LossProductsTable view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <ProfitByPlatformCard points={view.profitByPlatform.map((p) => ({ platformId: p.platformId, profit: p.profit }))} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <MarginBandProfitCard points={view.profitByMarginBand} />
          </Grid>
        </Grid>
      </Stack>
    </AdminShell>
  );
}
