"use client";

import { Suspense, useEffect, useMemo, useState } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { AdminShell } from "@/components/AdminShell";
import { Box, Chip, Stack, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Typography, Card, CardContent, TextField, FormControl, InputLabel, Select, MenuItem, TableSortLabel, TablePagination, Button } from "@mui/material";

type OrdersPayload = {
  summary: { total: number; queuedForCapital: number; statusCounts: Record<string, number> };
  rows: {
    id: string;
    targetOrderId: string;
    platform: string;
    listingId: string;
    status: string;
    quantity: number;
    sellingPrice: number;
    sourceCost: number;
    profit: number;
    riskScore?: number | null;
    queuedForCapital: boolean;
    createdAt?: string | null;
  }[];
};

function OrdersPageContent() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [data, setData] = useState<OrdersPayload | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const query = searchParams.get("q") ?? "";
  const platform = searchParams.get("platform") ?? "all";
  const status = searchParams.get("status") ?? "all";
  const sortBy = searchParams.get("sortBy") ?? "createdAt";
  const sortDir = searchParams.get("sortDir") ?? "desc";
  const page = Number(searchParams.get("page") ?? "0");
  const pageSize = Number(searchParams.get("pageSize") ?? "20");

  const setParam = (key: string, value: string) => {
    const next = new URLSearchParams(searchParams.toString());
    if (!value || value === "all") {
      next.delete(key);
    } else {
      next.set(key, value);
    }
    if (key !== "page") {
      next.delete("page");
    }
    router.replace(`${pathname}?${next.toString()}`);
  };

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch("/api/orders", { cache: "no-store" });
        if (!res.ok) {
          if (!cancelled) setError(`API error (${res.status})`);
          return;
        }
        const json = (await res.json()) as OrdersPayload;
        if (!cancelled) setData(json);
      } catch {
        if (!cancelled) setError("Unable to reach orders API");
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  const filteredRows = (data?.rows ?? [])
    .filter((r) => (platform === "all" ? true : r.platform === platform))
    .filter((r) => (status === "all" ? true : r.status === status))
    .filter((r) => {
      if (!query.trim()) return true;
      const q = query.toLowerCase();
      return (
        r.targetOrderId.toLowerCase().includes(q) ||
        r.listingId.toLowerCase().includes(q) ||
        r.platform.toLowerCase().includes(q)
      );
    });

  const platforms = Array.from(new Set((data?.rows ?? []).map((r) => r.platform)));
  const statuses = Array.from(new Set((data?.rows ?? []).map((r) => r.status)));
  const sortedRows = useMemo(() => {
    const rows = [...filteredRows];
    const sign = sortDir === "asc" ? 1 : -1;
    rows.sort((a, b) => {
      const av = sortBy === "profit" ? a.profit : sortBy === "risk" ? (a.riskScore ?? 0) : sortBy === "quantity" ? a.quantity : sortBy === "order" ? a.targetOrderId : (a.createdAt ?? "");
      const bv = sortBy === "profit" ? b.profit : sortBy === "risk" ? (b.riskScore ?? 0) : sortBy === "quantity" ? b.quantity : sortBy === "order" ? b.targetOrderId : (b.createdAt ?? "");
      if (typeof av === "number" && typeof bv === "number") return (av - bv) * sign;
      return String(av).localeCompare(String(bv)) * sign;
    });
    return rows;
  }, [filteredRows, sortBy, sortDir]);
  const start = page * pageSize;
  const pageRows = sortedRows.slice(start, start + pageSize);
  const onSort = (nextSortBy: string) => {
    const nextDir = sortBy === nextSortBy && sortDir === "asc" ? "desc" : "asc";
    setParam("sortBy", nextSortBy);
    setParam("sortDir", nextDir);
  };
  const downloadCsv = () => {
    const header = ["targetOrderId", "platform", "status", "quantity", "profit", "riskScore"];
    const lines = pageRows.map((r) =>
      [r.targetOrderId, r.platform, r.status, r.quantity, r.profit.toFixed(2), (r.riskScore ?? 0).toFixed(0)]
        .map((v) => `"${String(v).replaceAll('"', '""')}"`)
        .join(",")
    );
    const csv = [header.join(","), ...lines].join("\n");
    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "orders_filtered.csv";
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Orders
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Live orders with status and profit diagnostics.
          </Typography>
          {loading ? <Typography color="text.secondary" sx={{ mt: 0.5 }}>Loading orders...</Typography> : null}
          {error ? <Typography sx={{ mt: 0.5, color: "warning.main", fontWeight: 700 }}>{error}</Typography> : null}
        </Box>

        <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
          <Chip label={`Total: ${data?.summary.total ?? 0}`} />
          <Chip label={`Queued: ${data?.summary.queuedForCapital ?? 0}`} color="warning" variant="outlined" />
          {Object.entries(data?.summary.statusCounts ?? {}).slice(0, 4).map(([k, v]) => (
            <Chip key={k} label={`${k}: ${v}`} variant="outlined" />
          ))}
        </Stack>

        <Stack direction="row" spacing={1.5} useFlexGap flexWrap="wrap">
          <TextField
            size="small"
            label="Search orders"
            value={query}
            onChange={(e) => setParam("q", e.target.value)}
            sx={{ minWidth: 260 }}
          />
          <FormControl size="small" sx={{ minWidth: 170 }}>
            <InputLabel>Platform</InputLabel>
            <Select value={platform} label="Platform" onChange={(e) => setParam("platform", e.target.value)}>
              <MenuItem value="all">All</MenuItem>
              {platforms.map((p) => (
                <MenuItem key={p} value={p}>{p}</MenuItem>
              ))}
            </Select>
          </FormControl>
          <FormControl size="small" sx={{ minWidth: 170 }}>
            <InputLabel>Status</InputLabel>
            <Select value={status} label="Status" onChange={(e) => setParam("status", e.target.value)}>
              <MenuItem value="all">All</MenuItem>
              {statuses.map((s) => (
                <MenuItem key={s} value={s}>{s}</MenuItem>
              ))}
            </Select>
          </FormControl>
          <Chip label={`Visible: ${sortedRows.length}`} variant="outlined" />
          <Button size="small" variant="outlined" onClick={downloadCsv}>Export CSV</Button>
        </Stack>

        <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
          <Chip
            label="Failed orders"
            variant="outlined"
            onClick={() => setParam("status", "failed")}
            clickable
          />
          <Chip
            label="High risk (>=70)"
            variant="outlined"
            onClick={() => {
              setParam("sortBy", "risk");
              setParam("sortDir", "desc");
            }}
            clickable
          />
          <Chip
            label="Queued for capital"
            variant="outlined"
            onClick={() => setParam("status", "pending")}
            clickable
          />
        </Stack>

        <Card>
          <CardContent>
            <TableContainer>
              <Table size="small">
                <TableHead>
                  <TableRow>
                    <TableCell>
                      <TableSortLabel active={sortBy === "order"} direction={sortBy === "order" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("order")}>Order</TableSortLabel>
                    </TableCell>
                    <TableCell>Platform</TableCell>
                    <TableCell>Status</TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "quantity"} direction={sortBy === "quantity" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("quantity")}>Qty</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "profit"} direction={sortBy === "profit" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("profit")}>Profit</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "risk"} direction={sortBy === "risk" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("risk")}>Risk</TableSortLabel>
                    </TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {pageRows.map((r) => (
                    <TableRow key={r.id} hover>
                      <TableCell>{r.targetOrderId}</TableCell>
                      <TableCell>{r.platform}</TableCell>
                      <TableCell>{r.status}</TableCell>
                      <TableCell align="right">{r.quantity}</TableCell>
                      <TableCell align="right" sx={{ color: r.profit >= 0 ? "success.main" : "error.main", fontWeight: 700 }}>
                        {r.profit.toFixed(2)}
                      </TableCell>
                      <TableCell align="right">{(r.riskScore ?? 0).toFixed(0)}</TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </TableContainer>
            <TablePagination
              component="div"
              count={sortedRows.length}
              page={Math.min(page, Math.max(0, Math.ceil(sortedRows.length / pageSize) - 1))}
              onPageChange={(_, nextPage) => setParam("page", String(nextPage))}
              rowsPerPage={pageSize}
              onRowsPerPageChange={(e) => setParam("pageSize", e.target.value)}
              rowsPerPageOptions={[10, 20, 50]}
            />
          </CardContent>
        </Card>
      </Stack>
    </AdminShell>
  );
}

export default function OrdersPage() {
  return (
    <Suspense fallback={<AdminShell><Stack spacing={2.5}><Typography color="text.secondary">Loading orders view...</Typography></Stack></AdminShell>}>
      <OrdersPageContent />
    </Suspense>
  );
}

