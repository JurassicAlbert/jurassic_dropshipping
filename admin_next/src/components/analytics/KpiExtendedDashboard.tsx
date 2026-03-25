"use client";

import type { ReactNode } from "react";
import type { DashboardApiPayload } from "@/lib/dashboardApi";
import { useClientMounted } from "@/lib/useClientMounted";
import {
  Box,
  Card,
  CardContent,
  Skeleton,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Typography,
} from "@mui/material";
import {
  Bar,
  BarChart,
  CartesianGrid,
  Line,
  LineChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from "recharts";

function Shell({
  title,
  subtitle,
  height,
  children,
  empty,
}: {
  title: string;
  subtitle: string;
  height: number;
  children: ReactNode;
  empty?: boolean;
}) {
  const mounted = useClientMounted();
  return (
    <Card variant="outlined" sx={{ height: "100%" }}>
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          {title}
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1.5 }}>
          {subtitle}
        </Typography>
        <Box sx={{ height, minWidth: 0 }}>
          {empty ? (
            <Typography variant="body2" color="text.disabled" sx={{ py: 3 }}>
              No data.
            </Typography>
          ) : mounted ? (
            children
          ) : (
            <Skeleton variant="rounded" height={height} />
          )}
        </Box>
      </CardContent>
    </Card>
  );
}

export function ReturnRateTrendLine({ view }: { view: DashboardApiPayload }) {
  const data = view.dailyReturnRateSeries ?? [];
  const empty = data.length === 0;
  return (
    <Shell title="Return rate trend" subtitle="Daily returns ÷ shipped orders (approx.)." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <LineChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="dayLabel" tick={{ fontSize: 10 }} />
          <YAxis width={40} tickFormatter={(v) => `${v}%`} />
          <Tooltip formatter={(v) => (typeof v === "number" ? `${v.toFixed(1)}%` : String(v))} />
          <Line type="monotone" dataKey="returnRatePercent" stroke="#B45309" strokeWidth={2} dot={false} />
        </LineChart>
      </ResponsiveContainer>
    </Shell>
  );
}

export function ReturnCostByReasonChart({ view }: { view: DashboardApiPayload }) {
  const data = view.returnCostByReason ?? [];
  const empty = data.length === 0;
  return (
    <Shell title="Return cost by reason" subtitle="Refund + return shipping (PLN)." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 40 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="reason" tick={{ fontSize: 9 }} angle={-20} textAnchor="end" height={52} />
          <YAxis width={44} />
          <Tooltip formatter={(v) => (typeof v === "number" ? `${v.toFixed(0)} PLN` : String(v))} />
          <Bar dataKey="costPln" fill="#EA580C" radius={[6, 6, 0, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </Shell>
  );
}

export function IncidentsByTypeChart({ view }: { view: DashboardApiPayload }) {
  const data = view.incidentsByType ?? [];
  const empty = data.length === 0;
  return (
    <Shell title="Incidents by type" subtitle="Post-order incident records." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} layout="vertical" margin={{ left: 8, right: 12, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" horizontal={false} />
          <XAxis type="number" allowDecimals={false} />
          <YAxis type="category" dataKey="type" width={120} tick={{ fontSize: 9 }} />
          <Tooltip />
          <Bar dataKey="count" fill="#7C3AED" radius={[0, 6, 6, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </Shell>
  );
}

export function DailyIncidentsLine({ view }: { view: DashboardApiPayload }) {
  const data = view.dailyIncidents ?? [];
  const empty = data.length === 0;
  return (
    <Shell title="Incidents over time" subtitle="Count opened per day (recent window)." height={240} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <LineChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="dayLabel" tick={{ fontSize: 10 }} />
          <YAxis width={36} allowDecimals={false} />
          <Tooltip />
          <Line type="monotone" dataKey="count" stroke="#9333EA" strokeWidth={2} dot />
        </LineChart>
      </ResponsiveContainer>
    </Shell>
  );
}

export function OrderFunnelChart({ view }: { view: DashboardApiPayload }) {
  const data = view.orderFunnel ?? [];
  const empty = data.length === 0;
  return (
    <Shell title="Order funnel (simplified)" subtitle="Pending → supplier → fulfilled → failed/cancel." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 32 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="stage" tick={{ fontSize: 10 }} angle={-15} textAnchor="end" height={48} />
          <YAxis width={36} allowDecimals={false} />
          <Tooltip />
          <Bar dataKey="count" fill="#2563EB" radius={[6, 6, 0, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </Shell>
  );
}

export function FulfillmentStatsCard({ view }: { view: DashboardApiPayload }) {
  const f = view.fulfillment ?? { medianDays: 0, avgDays: 0, sampleCount: 0 };
  return (
    <Card variant="outlined" sx={{ height: "100%" }}>
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          Fulfillment time (30d)
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          Delivered orders with created → delivered timestamps.
        </Typography>
        <Typography variant="body2">
          Median: <strong>{f.medianDays.toFixed(1)}</strong> days
        </Typography>
        <Typography variant="body2">
          Average: <strong>{f.avgDays.toFixed(1)}</strong> days
        </Typography>
        <Typography variant="caption" color="text.secondary">
          Sample: {f.sampleCount} orders
        </Typography>
      </CardContent>
    </Card>
  );
}

export function FailedOrdersCard({ view }: { view: DashboardApiPayload }) {
  const fo = view.failedOrders ?? { failed: 0, total: 0, ratePercent: 0 };
  return (
    <Card variant="outlined" sx={{ height: "100%" }}>
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          Failed orders (30d)
        </Typography>
        <Typography variant="h5" sx={{ fontWeight: 900, mt: 1 }}>
          {fo.ratePercent.toFixed(1)}%
        </Typography>
        <Typography variant="body2" color="text.secondary">
          {fo.failed} failed of {fo.total} orders
        </Typography>
      </CardContent>
    </Card>
  );
}

export function SupplierKpiTable({ view }: { view: DashboardApiPayload }) {
  const rows = view.supplierKpis ?? [];
  return (
    <Card variant="outlined">
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          Supplier return exposure
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1.5 }}>
          Return count ÷ order count by supplier (sorted by return rate).
        </Typography>
        {rows.length === 0 ? (
          <Typography variant="body2" color="text.disabled">
            No supplier data.
          </Typography>
        ) : (
          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>Supplier</TableCell>
                  <TableCell align="right">Orders</TableCell>
                  <TableCell align="right">Returns</TableCell>
                  <TableCell align="right">Return %</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {rows.map((r) => (
                  <TableRow key={r.supplierId}>
                    <TableCell>{r.name || r.supplierId}</TableCell>
                    <TableCell align="right">{r.orderCount}</TableCell>
                    <TableCell align="right">{r.returnCount}</TableCell>
                    <TableCell align="right">{r.returnRatePercent.toFixed(1)}%</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        )}
      </CardContent>
    </Card>
  );
}

export function ListingHealthBar({ view }: { view: DashboardApiPayload }) {
  const data = view.listingHealthHistogram ?? [];
  const empty = data.length === 0;
  return (
    <Shell title="Listing health (issues)" subtitle="From listing_health_metrics aggregates." height={220} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="bucket" tick={{ fontSize: 10 }} />
          <YAxis width={36} allowDecimals={false} />
          <Tooltip />
          <Bar dataKey="count" fill="#0D9488" radius={[6, 6, 0, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </Shell>
  );
}

export function TopRiskListingsTable({ view }: { view: DashboardApiPayload }) {
  const rows = view.topRiskListings ?? [];
  return (
    <Card variant="outlined">
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          Top risk listings
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
          By average order risk score.
        </Typography>
        {rows.length === 0 ? (
          <Typography variant="body2" color="text.disabled">
            No risk-scored orders.
          </Typography>
        ) : (
          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>Listing</TableCell>
                  <TableCell align="right">Avg risk</TableCell>
                  <TableCell align="right">Orders</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {rows.map((r) => (
                  <TableRow key={r.listingId}>
                    <TableCell sx={{ fontFamily: "monospace", fontSize: 12 }}>{r.listingId}</TableCell>
                    <TableCell align="right">{r.avgRisk.toFixed(0)}</TableCell>
                    <TableCell align="right">{r.orderCount}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        )}
      </CardContent>
    </Card>
  );
}

export function CustomerMessagingPlaceholder({ view }: { view: DashboardApiPayload }) {
  const cm = view.customerMessaging;
  const ready = cm?.hasData === true;
  return (
    <Card
      variant="outlined"
      data-testid="analytics-p11-customer-messaging"
      data-p11-state={ready ? "ready" : "deferred"}
    >
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          Customer / messages
        </Typography>
        {ready ? (
          <>
            <Typography variant="body2" sx={{ mt: 1 }}>
              Messaging aggregates are present in the dashboard payload (customerMessaging.hasData).
            </Typography>
            {cm?.note ? (
              <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
                {cm.note}
              </Typography>
            ) : null}
          </>
        ) : (
          <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
            {cm?.note ??
              "p11 — Messaging KPIs deferred until conversation/return-intent feeds are stored or aggregated. Dashboard payload field: customerMessaging."}
          </Typography>
        )}
      </CardContent>
    </Card>
  );
}

function formatListingConversion(rate: number | null | undefined): string {
  if (rate == null) return "—";
  return `${(rate * 100).toFixed(1)}%`;
}

export function MarketListingPlaceholder({ view }: { view: DashboardApiPayload }) {
  const m = view.marketListing;
  const hasMetrics =
    m != null && (m.priceCompetitivenessIndex != null || m.listingConversionRate != null);
  return (
    <Card
      variant="outlined"
      data-testid="analytics-p13-market-listing"
      data-p13-state={hasMetrics ? "metrics" : "deferred"}
    >
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          Market / listings
        </Typography>
        {hasMetrics ? (
          <Box sx={{ mt: 1 }}>
            <Typography variant="body2">
              Competitiveness index:{" "}
              <strong>
                {m!.priceCompetitivenessIndex != null ? m!.priceCompetitivenessIndex.toFixed(2) : "—"}
              </strong>
            </Typography>
            <Typography variant="body2">
              Listing conversion: <strong>{formatListingConversion(m!.listingConversionRate)}</strong>
            </Typography>
            {m?.note ? (
              <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
                {m.note}
              </Typography>
            ) : null}
          </Box>
        ) : (
          <>
            <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
              {m?.note ??
                "p13 — Competitiveness and listing conversion need marketplace impression/click feeds or stored competitor samples (see dashboard payload marketListing)."}
            </Typography>
            <Typography variant="caption" display="block" sx={{ mt: 1 }}>
              Competitiveness index: — · Conversion: —
            </Typography>
          </>
        )}
      </CardContent>
    </Card>
  );
}

export function SystemJobsCard({ view }: { view: DashboardApiPayload }) {
  const sj = view.systemJobs ?? {
    byStatus: {},
    oldestPendingAgeMinutes: null,
    processingEfficiencyPercent: 0,
    queueDepth: 0,
  };
  return (
    <Card variant="outlined">
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          Background jobs
        </Typography>
        <Typography variant="body2" sx={{ mt: 1 }}>
          Queue depth: <strong>{sj.queueDepth}</strong>
        </Typography>
        <Typography variant="body2">
          Oldest pending:{" "}
          <strong>{sj.oldestPendingAgeMinutes != null ? `${sj.oldestPendingAgeMinutes} min` : "—"}</strong>
        </Typography>
        <Typography variant="body2">
          Processing efficiency: <strong>{sj.processingEfficiencyPercent.toFixed(1)}%</strong> (completed / completed+failed)
        </Typography>
        <Typography variant="caption" color="text.secondary" sx={{ display: "block", mt: 1 }}>
          {Object.entries(sj.byStatus)
            .map(([k, v]) => `${k}: ${v}`)
            .join(" · ")}
        </Typography>
      </CardContent>
    </Card>
  );
}

export function RiskMetaChips({ view }: { view: DashboardApiPayload }) {
  return (
    <Box sx={{ display: "flex", flexWrap: "wrap", gap: 1 }}>
      <Card variant="outlined" sx={{ px: 2, py: 1 }}>
        <Typography variant="caption" color="text.secondary">
          Open incidents
        </Typography>
        <Typography variant="h6">{view.incidentsOpenCount ?? 0}</Typography>
      </Card>
      <Card variant="outlined" sx={{ px: 2, py: 1 }}>
        <Typography variant="caption" color="text.secondary">
          Low margin + high risk orders
        </Typography>
        <Typography variant="h6">{view.lowMarginHighRiskCount ?? 0}</Typography>
      </Card>
      <Card variant="outlined" sx={{ px: 2, py: 1 }}>
        <Typography variant="caption" color="text.secondary">
          Total return cost
        </Typography>
        <Typography variant="h6">{(view.totalReturnCostPln ?? 0).toFixed(0)} PLN</Typography>
      </Card>
      <Card variant="outlined" sx={{ px: 2, py: 1 }}>
        <Typography variant="caption" color="text.secondary">
          Blocked listings (draft/paused)
        </Typography>
        <Typography variant="h6">{view.blockedListingsCount ?? 0}</Typography>
      </Card>
    </Box>
  );
}
