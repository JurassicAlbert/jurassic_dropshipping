"use client";

import type { ReactNode } from "react";
import { Box, Card, CardContent, Grid, Skeleton, Stack, Typography } from "@mui/material";

/** Single placeholder slot — SSR-safe (no Recharts until data wiring). */
function KpiSlot({ title, subtitle }: { title: string; subtitle?: string }) {
  return (
    <Card variant="outlined" sx={{ height: "100%" }}>
      <CardContent>
        <Typography variant="subtitle2" sx={{ fontWeight: 800 }} color="text.secondary">
          {title}
        </Typography>
        {subtitle ? (
          <Typography variant="caption" color="text.disabled" sx={{ display: "block", mb: 1 }}>
            {subtitle}
          </Typography>
        ) : null}
        <Skeleton variant="rounded" height={200} sx={{ mt: 1 }} />
        <Typography variant="caption" color="text.disabled">
          Placeholder — connect API aggregates
        </Typography>
      </CardContent>
    </Card>
  );
}

function SectionTitle({ children }: { children: ReactNode }) {
  return (
    <Typography variant="h6" sx={{ fontWeight: 900, mt: 2, mb: 1 }}>
      {children}
    </Typography>
  );
}

/** p6–p14: expanded KPI grid (39 components) — placeholders until Dart/DB aggregates exist. */
export function JurasicKpiDashboard() {
  return (
    <Stack spacing={1}>
      <Box>
        <Typography variant="h5" sx={{ fontWeight: 950 }}>
          Extended KPIs
        </Typography>
        <Typography color="text.secondary" variant="body2">
          Risk and capital blocks are prioritized for wiring. Stubs are SSR-safe.
        </Typography>
      </Box>

      <SectionTitle>p6 — Core financial</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Revenue Over Time" subtitle="<RevenueTimeSeriesChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Profit Over Time" subtitle="<ProfitTimeSeriesChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Margin Trend" subtitle="<MarginTrendChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Profit by Product" subtitle="<ProfitByProductBarChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Loss-Making Products" subtitle="<LossProductsTable />" />
        </Grid>
      </Grid>

      <SectionTitle>p7 — Risk (priority)</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Return Rate Trend" subtitle="<ReturnRateTrendChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Incident Rate" subtitle="<IncidentRateChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Return Cost Impact" subtitle="<ReturnCostImpactChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Risk Score Distribution" subtitle="<RiskScoreHistogram />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Expectation Gap Index" subtitle="<ExpectationGapChart />" />
        </Grid>
      </Grid>

      <SectionTitle>p8 — Operations</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Orders Lifecycle Funnel" subtitle="<OrderLifecycleFunnelChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Fulfillment Time" subtitle="<FulfillmentTimeChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Order Status Distribution" subtitle="<OrderStatusPieChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Failed Orders Rate" subtitle="<FailedOrdersRateChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Automation Health Score" subtitle="<AutomationHealthScoreCard />" />
        </Grid>
      </Grid>

      <SectionTitle>p9 — Supplier</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6 }}>
          <KpiSlot title="Supplier Reliability Ranking" subtitle="<SupplierReliabilityTable />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Supplier Failure Rate" subtitle="<SupplierFailureRateChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Supplier Switching Frequency" subtitle="<SupplierSwitchingChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Supplier Return Rate" subtitle="<SupplierReturnRateChart />" />
        </Grid>
      </Grid>

      <SectionTitle>p10 — Product quality</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Quality Score Distribution" subtitle="<ProductQualityHistogram />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Blocked Products Count" subtitle="<BlockedProductsMetricCard />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Product Approval Funnel" subtitle="<ProductApprovalFunnelChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Top Risk Products" subtitle="<TopRiskProductsTable />" />
        </Grid>
      </Grid>

      <SectionTitle>p11 — Customer / message</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Return Intent Detection Rate" subtitle="<ReturnIntentDetectionChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Complaint Rate" subtitle="<ComplaintRateChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Message Sentiment Trend" subtitle="<MessageSentimentTrendChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Conversation → Return Conversion" subtitle="<ConversationToReturnChart />" />
        </Grid>
      </Grid>

      <SectionTitle>p12 — Capital / cashflow (critical)</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Locked Capital Over Time" subtitle="<LockedCapitalChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Available Capital" subtitle="<AvailableCapitalCard />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Cashflow Gap" subtitle="<CashflowGapChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Return Reserve Level" subtitle="<ReturnReserveGauge />" />
        </Grid>
      </Grid>

      <SectionTitle>p13 — Market / listing</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Listings Health Distribution" subtitle="<ListingHealthChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Listings Status (Active vs Paused)" subtitle="<ListingStatusChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Price Competitiveness Index" subtitle="<PriceCompetitivenessChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Listing Conversion Rate" subtitle="<ListingConversionChart />" />
        </Grid>
      </Grid>

      <SectionTitle>p14 — System performance</SectionTitle>
      <Grid container spacing={2}>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Feed Processing Time" subtitle="<FeedProcessingTimeChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Queue Size Over Time" subtitle="<QueueSizeChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="Processing Efficiency" subtitle="<ProcessingEfficiencyChart />" />
        </Grid>
        <Grid size={{ xs: 12, md: 6, lg: 4 }}>
          <KpiSlot title="System Error Rate" subtitle="<SystemErrorRateChart />" />
        </Grid>
      </Grid>
    </Stack>
  );
}
