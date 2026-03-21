"use client";

import { Suspense, useEffect, useMemo, useState } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { AdminShell } from "@/components/AdminShell";
import { PRODUCTS_OFFLINE, type ProductsPayload } from "@/lib/emptyTablePayloads";
import { Box, Chip, Stack, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Typography, Card, CardContent, TextField, FormControl, InputLabel, Select, MenuItem, TableSortLabel, TablePagination, Button } from "@mui/material";

function ProductsPageContent() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [data, setData] = useState<ProductsPayload | null>(null);
  const [loading, setLoading] = useState(true);
  const [offline, setOffline] = useState(false);
  const query = searchParams.get("q") ?? "";
  const platform = searchParams.get("platform") ?? "all";
  const marginBucket = searchParams.get("margin") ?? "all";
  const sortBy = searchParams.get("sortBy") ?? "title";
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
        const res = await fetch("/api/products", { cache: "no-store" });
        if (!res.ok) {
          if (!cancelled) {
            setData(PRODUCTS_OFFLINE);
            setOffline(true);
          }
          return;
        }
        const json = (await res.json()) as ProductsPayload;
        if (!cancelled) {
          setData(json);
          setOffline(false);
        }
      } catch {
        if (!cancelled) {
          setData(PRODUCTS_OFFLINE);
          setOffline(true);
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, []);

  const filteredRows = (data?.rows ?? [])
    .filter((r) => (platform === "all" ? true : r.sourcePlatformId === platform))
    .filter((r) => {
      if (marginBucket === "all") return true;
      if (marginBucket === "good") return r.avgMarginPercent >= 20;
      if (marginBucket === "mid") return r.avgMarginPercent >= 10 && r.avgMarginPercent < 20;
      return r.avgMarginPercent < 10;
    })
    .filter((r) => {
      if (!query.trim()) return true;
      const q = query.toLowerCase();
      return (
        r.title.toLowerCase().includes(q) ||
        (r.supplierId ?? "").toLowerCase().includes(q) ||
        r.sourcePlatformId.toLowerCase().includes(q)
      );
    });

  const platforms = Array.from(new Set((data?.rows ?? []).map((r) => r.sourcePlatformId)));
  const sortedRows = useMemo(() => {
    const rows = [...filteredRows];
    const sign = sortDir === "asc" ? 1 : -1;
    rows.sort((a, b) => {
      const av = sortBy === "basePrice" ? a.basePrice : sortBy === "listings" ? a.listingCount : sortBy === "active" ? a.activeListingCount : sortBy === "margin" ? a.avgMarginPercent : a.title;
      const bv = sortBy === "basePrice" ? b.basePrice : sortBy === "listings" ? b.listingCount : sortBy === "active" ? b.activeListingCount : sortBy === "margin" ? b.avgMarginPercent : b.title;
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
    const header = ["title", "supplierId", "sourcePlatformId", "basePrice", "listingCount", "activeListingCount", "avgMarginPercent"];
    const lines = pageRows.map((r) =>
      [r.title, r.supplierId ?? "", r.sourcePlatformId, r.basePrice.toFixed(2), r.listingCount, r.activeListingCount, r.avgMarginPercent.toFixed(1)]
        .map((v) => `"${String(v).replaceAll('"', '""')}"`)
        .join(",")
    );
    const csv = [header.join(","), ...lines].join("\n");
    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "products_filtered.csv";
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Products
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Live catalog with listing density and margin profile.
          </Typography>
          {loading ? <Typography color="text.secondary" sx={{ mt: 0.5 }}>Loading products...</Typography> : null}
          {offline ? (
            <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
              Live data unavailable — start the Dart dashboard API or set `DART_API_BASE_URL`. Showing empty table.
            </Typography>
          ) : null}
        </Box>

        <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
          <Chip label={`Products: ${data?.summary.total ?? 0}`} />
          <Chip label={`With active listings: ${data?.summary.withActiveListings ?? 0}`} color="primary" variant="outlined" />
        </Stack>

        <Stack direction="row" spacing={1.5} useFlexGap flexWrap="wrap">
          <TextField
            size="small"
            label="Search products"
            value={query}
            onChange={(e) => setParam("q", e.target.value)}
            sx={{ minWidth: 260 }}
          />
          <FormControl size="small" sx={{ minWidth: 170 }}>
            <InputLabel>Source</InputLabel>
            <Select value={platform} label="Source" onChange={(e) => setParam("platform", e.target.value)}>
              <MenuItem value="all">All</MenuItem>
              {platforms.map((p) => (
                <MenuItem key={p} value={p}>{p}</MenuItem>
              ))}
            </Select>
          </FormControl>
          <FormControl size="small" sx={{ minWidth: 170 }}>
            <InputLabel>Margin</InputLabel>
            <Select value={marginBucket} label="Margin" onChange={(e) => setParam("margin", e.target.value)}>
              <MenuItem value="all">All</MenuItem>
              <MenuItem value="good">&gt;= 20%</MenuItem>
              <MenuItem value="mid">10-20%</MenuItem>
              <MenuItem value="low">&lt; 10%</MenuItem>
            </Select>
          </FormControl>
          <Chip label={`Visible: ${sortedRows.length}`} variant="outlined" />
          <Button size="small" variant="outlined" onClick={downloadCsv}>Export CSV</Button>
        </Stack>

        <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
          <Chip label="Low margin <10%" variant="outlined" onClick={() => setParam("margin", "low")} clickable />
          <Chip label="No active listings" variant="outlined" onClick={() => {
            setParam("sortBy", "active");
            setParam("sortDir", "asc");
          }} clickable />
          <Chip label="Best margin first" variant="outlined" onClick={() => {
            setParam("sortBy", "margin");
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
                      <TableSortLabel active={sortBy === "title"} direction={sortBy === "title" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("title")}>Product</TableSortLabel>
                    </TableCell>
                    <TableCell>Supplier</TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "basePrice"} direction={sortBy === "basePrice" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("basePrice")}>Base</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "listings"} direction={sortBy === "listings" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("listings")}>Listings</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "active"} direction={sortBy === "active" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("active")}>Active</TableSortLabel>
                    </TableCell>
                    <TableCell align="right">
                      <TableSortLabel active={sortBy === "margin"} direction={sortBy === "margin" ? (sortDir as "asc" | "desc") : "asc"} onClick={() => onSort("margin")}>Avg margin</TableSortLabel>
                    </TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {pageRows.map((r) => (
                    <TableRow key={r.id} hover>
                      <TableCell>{r.title}</TableCell>
                      <TableCell>{r.supplierId ?? "-"}</TableCell>
                      <TableCell align="right">{r.basePrice.toFixed(2)} {r.currency}</TableCell>
                      <TableCell align="right">{r.listingCount}</TableCell>
                      <TableCell align="right">{r.activeListingCount}</TableCell>
                      <TableCell align="right" sx={{ fontWeight: 700, color: r.avgMarginPercent >= 20 ? "success.main" : "warning.main" }}>
                        {r.avgMarginPercent.toFixed(1)}%
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
      </Stack>
    </AdminShell>
  );
}

export default function ProductsPage() {
  return (
    <Suspense fallback={<AdminShell><Stack spacing={2.5}><Typography color="text.secondary">Loading products view...</Typography></Stack></AdminShell>}>
      <ProductsPageContent />
    </Suspense>
  );
}

