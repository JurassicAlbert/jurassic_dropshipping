"use client";

import { Suspense, useEffect, useMemo, useState } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { AdminShell } from "@/components/AdminShell";
import { SupplierReliabilityAndRiskPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { Box, Chip, Stack, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Typography, Card, CardContent, TextField, FormControl, InputLabel, Select, MenuItem, TableSortLabel, TablePagination, Button } from "@mui/material";

type SuppliersPayload = {
  summary: { total: number; withActiveListings: number };
  rows: {
    id: string;
    name: string;
    platformType: string;
    countryCode?: string | null;
    rating?: number | null;
    productsCount: number;
    listingsCount: number;
    activeListingsCount: number;
    ordersCount: number;
    returnsCount: number;
    avgOrderProfit: number;
  }[];
};

function SuppliersPageContent() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [data, setData] = useState<SuppliersPayload | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const query = searchParams.get("q") ?? "";
  const country = searchParams.get("country") ?? "all";
  const profitBucket = searchParams.get("profit") ?? "all";
  const sortBy = searchParams.get("sortBy") ?? "name";
  const sortDir = searchParams.get("sortDir") ?? "asc";
  const page = Number(searchParams.get("page") ?? "0");
  const pageSize = Number(searchParams.get("pageSize") ?? "20");

  const setParam = (key: string, value: string) => {
    const next = new URLSearchParams(searchParams.toString());
    if (!value || value === "all") next.delete(key);
    else next.set(key, value);
    if (key !== "page") next.delete("page");
    router.replace(`${pathname}?${next.toString()}`);
  };

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch("/api/suppliers", { cache: "no-store" });
        if (!res.ok) {
          if (!cancelled) setError(`API error (${res.status})`);
          return;
        }
        const json = (await res.json()) as SuppliersPayload;
        if (!cancelled) setData(json);
      } catch {
        if (!cancelled) setError("Unable to reach suppliers API");
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  const filteredRows = (data?.rows ?? [])
    .filter((r) => (country === "all" ? true : (r.countryCode ?? "unknown") === country))
    .filter((r) => {
      if (profitBucket === "all") return true;
      if (profitBucket === "good") return r.avgOrderProfit >= 0;
      return r.avgOrderProfit < 0;
    })
    .filter((r) => {
      if (!query.trim()) return true;
      const q = query.toLowerCase();
      return (
        r.name.toLowerCase().includes(q) ||
        (r.countryCode ?? "").toLowerCase().includes(q) ||
        r.platformType.toLowerCase().includes(q)
      );
    });

  const countries = Array.from(new Set((data?.rows ?? []).map((r) => r.countryCode ?? "unknown")));
  const sortedRows = useMemo(() => {
    const rows = [...filteredRows];
    const sign = sortDir === "asc" ? 1 : -1;
    rows.sort((a, b) => {
      const av = sortBy === "rating" ? (a.rating ?? 0) : sortBy === "products" ? a.productsCount : sortBy === "active" ? a.activeListingsCount : sortBy === "orders" ? a.ordersCount : sortBy === "returns" ? a.returnsCount : sortBy === "profit" ? a.avgOrderProfit : a.name;
      const bv = sortBy === "rating" ? (b.rating ?? 0) : sortBy === "products" ? b.productsCount : sortBy === "active" ? b.activeListingsCount : sortBy === "orders" ? b.ordersCount : sortBy === "returns" ? b.returnsCount : sortBy === "profit" ? b.avgOrderProfit : b.name;
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
    const header = ["name", "countryCode", "rating", "productsCount", "activeListingsCount", "ordersCount", "returnsCount", "avgOrderProfit"];
    const lines = pageRows.map((r) =>
      [r.name, r.countryCode ?? "", (r.rating ?? 0).toFixed(1), r.productsCount, r.activeListingsCount, r.ordersCount, r.returnsCount, r.avgOrderProfit.toFixed(2)]
        .map((v) => `"${String(v).replaceAll('"', '""')}"`)
        .join(",")
    );
    const csv = [header.join(","), ...lines].join("\n");
    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "suppliers_filtered.csv";
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Suppliers
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Live supplier performance and operational quality.
          </Typography>
          {loading ? <Typography color="text.secondary" sx={{ mt: 0.5 }}>Loading suppliers...</Typography> : null}
          {error ? <Typography sx={{ mt: 0.5, color: "warning.main", fontWeight: 700 }}>{error}</Typography> : null}
        </Box>

        <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
          <Chip label={`Suppliers: ${data?.summary.total ?? 0}`} />
          <Chip label={`With active listings: ${data?.summary.withActiveListings ?? 0}`} color="primary" variant="outlined" />
        </Stack>

        <Stack direction="row" spacing={1.5} useFlexGap flexWrap="wrap">
          <TextField
            size="small"
            label="Search suppliers"
            value={query}
            onChange={(e) => setParam("q", e.target.value)}
            sx={{ minWidth: 260 }}
          />
          <FormControl size="small" sx={{ minWidth: 170 }}>
            <InputLabel>Country</InputLabel>
            <Select value={country} label="Country" onChange={(e) => setParam("country", e.target.value)}>
              <MenuItem value="all">All</MenuItem>
              {countries.map((c) => (
                <MenuItem key={c} value={c}>{c}</MenuItem>
              ))}
            </Select>
          </FormControl>
          <FormControl size="small" sx={{ minWidth: 170 }}>
            <InputLabel>Avg profit</InputLabel>
            <Select value={profitBucket} label="Avg profit" onChange={(e) => setParam("profit", e.target.value)}>
              <MenuItem value="all">All</MenuItem>
              <MenuItem value="good">Non-negative</MenuItem>
              <MenuItem value="loss">Negative</MenuItem>
            </Select>
          </FormControl>
          <Chip label={`Visible: ${sortedRows.length}`} variant="outlined" />
          <Button size="small" variant="outlined" onClick={downloadCsv}>Export CSV</Button>
        </Stack>

        <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
          <Chip label="Negative avg profit" variant="outlined" onClick={() => setParam("profit", "loss")} clickable />
          <Chip label="Lowest rating" variant="outlined" onClick={() => {
            setParam("sortBy", "rating");
            setParam("sortDir", "asc");
          }} clickable />
          <Chip label="Most returns" variant="outlined" onClick={() => {
            setParam("sortBy", "returns");
            setParam("sortDir", "desc");
          }} clickable />
        </Stack>

        <Card>
          <CardContent>
            <TableContainer>
              <Table size="small">
                <TableHead>
                  <TableRow>
                    <TableCell>
                      <TableSortLabel active={sortBy === "name"} direction={sortBy === "name" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("name")}>Name</TableSortLabel>
                    </TableCell>
                    <TableCell>Country</TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "rating"} direction={sortBy === "rating" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("rating")}>Rating</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "products"} direction={sortBy === "products" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("products")}>Products</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "active"} direction={sortBy === "active" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("active")}>Active listings</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "orders"} direction={sortBy === "orders" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("orders")}>Orders</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "returns"} direction={sortBy === "returns" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("returns")}>Returns</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "profit"} direction={sortBy === "profit" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("profit")}>Avg profit/order</TableSortLabel>
                    </TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {pageRows.map((r) => (
                    <TableRow key={r.id} hover>
                      <TableCell>{r.name}</TableCell>
                      <TableCell>{r.countryCode ?? "-"}</TableCell>
                      <TableCell align="right">{(r.rating ?? 0).toFixed(1)}</TableCell>
                      <TableCell align="right">{r.productsCount}</TableCell>
                      <TableCell align="right">{r.activeListingsCount}</TableCell>
                      <TableCell align="right">{r.ordersCount}</TableCell>
                      <TableCell align="right">{r.returnsCount}</TableCell>
                      <TableCell align="right" sx={{ fontWeight: 700, color: r.avgOrderProfit >= 0 ? "success.main" : "error.main" }}>
                        {r.avgOrderProfit.toFixed(2)}
                      </TableCell>
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

        <SupplierReliabilityAndRiskPanel />
      </Stack>
    </AdminShell>
  );
}

export default function SuppliersPage() {
  return (
    <Suspense fallback={<AdminShell><Stack spacing={2.5}><Typography color="text.secondary">Loading suppliers view...</Typography></Stack></AdminShell>}>
      <SuppliersPageContent />
    </Suspense>
  );
}

