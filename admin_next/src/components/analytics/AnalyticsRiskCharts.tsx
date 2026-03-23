"use client";

import type { DashboardApiPayload } from "@/lib/dashboardApi";
import { useClientMounted } from "@/lib/useClientMounted";
import { Box, Card, CardContent, Skeleton, Typography } from "@mui/material";
import {
  Bar,
  BarChart,
  CartesianGrid,
  Cell,
  Pie,
  PieChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from "recharts";

const PIE_COLORS = ["#6366F1", "#1C6EF2", "#059669", "#D97706", "#DC2626", "#7C3AED"];

function ChartShell({
  title,
  subtitle,
  height,
  children,
  empty,
}: {
  title: string;
  subtitle: string;
  height: number;
  children: React.ReactNode;
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
            <Typography variant="body2" color="text.disabled" sx={{ py: 4 }}>
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

export function ReturnRateTrendChart({ view }: { view: DashboardApiPayload }) {
  const data = view.returnsByReason ?? [];
  const empty = data.length === 0;
  return (
    <ChartShell title="Returns by reason" subtitle="Count of return requests by reason enum." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 32 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="reason" tick={{ fontSize: 10 }} angle={-25} textAnchor="end" height={48} />
          <YAxis width={36} allowDecimals={false} />
          <Tooltip />
          <Bar dataKey="count" fill="#D97706" radius={[6, 6, 0, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </ChartShell>
  );
}

export function RiskScoreHistogram({ view }: { view: DashboardApiPayload }) {
  const data = view.riskScoreHistogram ?? [];
  const empty = data.length === 0;
  return (
    <ChartShell title="Risk score distribution" subtitle="Order risk scores bucketed (0–100)." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="bucket" tick={{ fontSize: 11 }} />
          <YAxis width={36} allowDecimals={false} />
          <Tooltip />
          <Bar dataKey="count" fill="#7C3AED" radius={[6, 6, 0, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </ChartShell>
  );
}

export function OrderStatusPieChart({ view }: { view: DashboardApiPayload }) {
  const raw = view.orderStatusDistribution ?? [];
  const data = raw.map((r) => ({ name: r.status, value: r.count }));
  const empty = data.length === 0 || data.every((d) => d.value === 0);
  return (
    <ChartShell title="Order status distribution" subtitle="All orders by lifecycle status." height={280} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <PieChart>
          <Pie data={data} dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={90} label>
            {data.map((_, i) => (
              <Cell key={i} fill={PIE_COLORS[i % PIE_COLORS.length]} />
            ))}
          </Pie>
          <Tooltip />
        </PieChart>
      </ResponsiveContainer>
    </ChartShell>
  );
}

export function ListingStatusPieChart({ view }: { view: DashboardApiPayload }) {
  const raw = view.listingStatusCounts ?? [];
  const data = raw.map((r) => ({ name: r.status, value: r.count }));
  const empty = data.length === 0 || data.every((d) => d.value === 0);
  return (
    <ChartShell title="Listing status" subtitle="Active vs paused (and other states)." height={280} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <PieChart>
          <Pie data={data} dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={90} label>
            {data.map((_, i) => (
              <Cell key={i} fill={PIE_COLORS[i % PIE_COLORS.length]} />
            ))}
          </Pie>
          <Tooltip />
        </PieChart>
      </ResponsiveContainer>
    </ChartShell>
  );
}
