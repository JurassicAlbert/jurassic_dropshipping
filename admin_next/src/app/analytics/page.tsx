"use client";

import {
  ListingStatusPieChart,
  OrderStatusPieChart,
  ReturnRateTrendChart,
  RiskScoreHistogram,
} from "@/components/analytics/AnalyticsRiskCharts";
import { CapitalSnapshotCards } from "@/components/analytics/CapitalSnapshotCards";
import {
  CustomerMessagingPlaceholder,
  DailyIncidentsLine,
  FailedOrdersCard,
  FulfillmentStatsCard,
  IncidentsByTypeChart,
  ListingHealthBar,
  MarketListingPlaceholder,
  OrderFunnelChart,
  ReturnCostByReasonChart,
  ReturnRateTrendLine,
  RiskMetaChips,
  SupplierKpiTable,
  SystemJobsCard,
  TopRiskListingsTable,
} from "@/components/analytics/KpiExtendedDashboard";
import { AdminShell } from "@/components/AdminShell";
import { AnalyticsIssuesCard } from "@/components/dashboard/AnalyticsIssuesCard";
import { KpiCard } from "@/components/dashboard/KpiCard";
import { useDashboardData } from "@/lib/dashboardApi";
import { Box, Grid, Stack, Typography } from "@mui/material";

/**
 * Analytics: full KPI program (p7–p14) — same `/api/dashboard` payload as Dashboard / Profit.
 * Profit time series: **Profit Dashboard**.
 */
export default function AnalyticsPage() {
  const { data: view, loading, offline } = useDashboardData();

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Analytics
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Extended KPIs from Dart <code>AnalyticsEngine</code> + repositories (ledger, incidents, jobs, health). Payload v
            {view.dashboardPayloadVersion ?? 1}.
          </Typography>
          {loading ? (
            <Typography color="text.secondary" sx={{ mt: 0.5 }}>
              Loading live analytics…
            </Typography>
          ) : null}
          {!loading && offline ? (
            <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
              Live dashboard API unavailable — showing offline snapshot. Start the Dart dashboard API or set `DART_API_BASE_URL`.
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

        <RiskMetaChips view={view} />

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1, mt: 1 }}>
          Risk &amp; returns (detail)
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <ReturnRateTrendChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <RiskScoreHistogram view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <ReturnRateTrendLine view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <ReturnCostByReasonChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <IncidentsByTypeChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <DailyIncidentsLine view={view} />
          </Grid>
        </Grid>

        <Typography
          variant="overline"
          sx={{ fontWeight: 800, letterSpacing: 1 }}
          data-testid="analytics-capital-overline"
        >
          Capital &amp; cashflow
        </Typography>
        <CapitalSnapshotCards view={view} />

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1 }}>
          Operations
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <OrderFunnelChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 3 }}>
            <FulfillmentStatsCard view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 3 }}>
            <FailedOrdersCard view={view} />
          </Grid>
        </Grid>

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1 }}>
          Orders &amp; listings (mix)
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <OrderStatusPieChart view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <ListingStatusPieChart view={view} />
          </Grid>
        </Grid>

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1 }}>
          Suppliers
        </Typography>
        <SupplierKpiTable view={view} />

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1 }}>
          Product &amp; listing quality
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <ListingHealthBar view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <TopRiskListingsTable view={view} />
          </Grid>
        </Grid>

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1 }}>
          Customer / market (placeholders)
        </Typography>
        <Grid container spacing={2}>
          <Grid size={{ xs: 12, md: 6 }}>
            <CustomerMessagingPlaceholder view={view} />
          </Grid>
          <Grid size={{ xs: 12, md: 6 }}>
            <MarketListingPlaceholder view={view} />
          </Grid>
        </Grid>

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1 }}>
          System
        </Typography>
        <SystemJobsCard view={view} />

        <Typography variant="overline" sx={{ fontWeight: 800, letterSpacing: 1 }}>
          Issues
        </Typography>
        <AnalyticsIssuesCard issues={view.issues} />
      </Stack>
    </AdminShell>
  );
}
