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
            <Typography variant="body2" color="text.disabled" sx={{ py: 4 }}>
              No data for this range.
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

/** Revenue over time — uses `dailyFinancialSeries` from Dart. */
export function RevenueTimeSeriesChart({ view }: { view: DashboardApiPayload }) {
  const data = view.dailyFinancialSeries ?? [];
  const empty = data.length === 0;
  return (
    <ChartShell title="Revenue over time" subtitle="Daily revenue (PLN) from orders." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <LineChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="dayLabel" tick={{ fontSize: 11 }} interval="preserveStartEnd" />
          <YAxis width={48} tick={{ fontSize: 11 }} />
          <Tooltip formatter={(v) => (typeof v === "number" ? `${v.toFixed(0)} PLN` : String(v))} />
          <Line type="monotone" dataKey="revenue" stroke="#6366F1" strokeWidth={2} dot={false} />
        </LineChart>
      </ResponsiveContainer>
    </ChartShell>
  );
}

export function ProfitTimeSeriesChart({ view }: { view: DashboardApiPayload }) {
  const data = view.dailyFinancialSeries ?? [];
  const empty = data.length === 0;
  return (
    <ChartShell title="Profit over time" subtitle="Daily realized profit (PLN)." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <LineChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="dayLabel" tick={{ fontSize: 11 }} interval="preserveStartEnd" />
          <YAxis width={48} tick={{ fontSize: 11 }} />
          <Tooltip formatter={(v) => (typeof v === "number" ? `${v.toFixed(0)} PLN` : String(v))} />
          <Line type="monotone" dataKey="profit" stroke="#1C6EF2" strokeWidth={2} dot={false} />
        </LineChart>
      </ResponsiveContainer>
    </ChartShell>
  );
}

export function MarginTrendChart({ view }: { view: DashboardApiPayload }) {
  const data = view.dailyFinancialSeries ?? [];
  const empty = data.length === 0;
  return (
    <ChartShell title="Margin trend" subtitle="Daily margin % (profit ÷ revenue)." height={260} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <LineChart data={data} margin={{ left: 4, right: 8, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
          <XAxis dataKey="dayLabel" tick={{ fontSize: 11 }} interval="preserveStartEnd" />
          <YAxis width={48} tick={{ fontSize: 11 }} tickFormatter={(v) => `${v}%`} />
          <Tooltip formatter={(v) => (typeof v === "number" ? `${v.toFixed(1)}%` : String(v))} />
          <Line type="monotone" dataKey="marginPercent" stroke="#059669" strokeWidth={2} dot={false} />
        </LineChart>
      </ResponsiveContainer>
    </ChartShell>
  );
}

export function ProfitByProductBarChart({ view }: { view: DashboardApiPayload }) {
  const raw = view.profitTopProducts ?? [];
  const data = raw.map((p) => ({
    id: p.listingId.length > 14 ? `${p.listingId.slice(0, 12)}…` : p.listingId,
    profit: p.profit,
  }));
  const empty = data.length === 0;
  return (
    <ChartShell title="Profit by listing" subtitle="Top listings by aggregate profit (from orders)." height={280} empty={empty}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data} layout="vertical" margin={{ left: 8, right: 12, top: 8, bottom: 0 }}>
          <CartesianGrid stroke="rgba(16,24,40,0.06)" horizontal={false} />
          <XAxis type="number" tick={{ fontSize: 11 }} />
          <YAxis type="category" dataKey="id" width={100} tick={{ fontSize: 10 }} />
          <Tooltip formatter={(v) => (typeof v === "number" ? `${v.toFixed(0)} PLN` : String(v))} />
          <Bar dataKey="profit" fill="#1C6EF2" radius={[0, 4, 4, 0]} />
        </BarChart>
      </ResponsiveContainer>
    </ChartShell>
  );
}

export function LossProductsTable({ view }: { view: DashboardApiPayload }) {
  const rows = view.lossMakingProducts ?? [];
  return (
    <Card variant="outlined" sx={{ height: "100%" }}>
      <CardContent>
        <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
          Loss-making listings
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 1.5 }}>
          Listings with negative aggregate profit across orders.
        </Typography>
        {rows.length === 0 ? (
          <Typography variant="body2" color="text.disabled">
            No loss-making listings in current data.
          </Typography>
        ) : (
          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>Listing</TableCell>
                  <TableCell align="right">Revenue</TableCell>
                  <TableCell align="right">Profit</TableCell>
                  <TableCell align="right">Margin</TableCell>
                  <TableCell align="right">Orders</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {rows.map((r) => (
                  <TableRow key={r.listingId}>
                    <TableCell sx={{ fontFamily: "monospace", fontSize: 12 }}>{r.listingId}</TableCell>
                    <TableCell align="right">{r.revenue.toFixed(0)} PLN</TableCell>
                    <TableCell align="right" sx={{ color: "error.main", fontWeight: 700 }}>
                      {r.profit.toFixed(0)} PLN
                    </TableCell>
                    <TableCell align="right">{r.marginPercent.toFixed(1)}%</TableCell>
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
