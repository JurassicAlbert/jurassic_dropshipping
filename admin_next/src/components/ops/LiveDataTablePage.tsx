"use client";

import { useEffect, useMemo, useState } from "react";
import { Box, Card, CardContent, Chip, Stack, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Typography } from "@mui/material";

type LivePayload = {
  summary?: Record<string, unknown>;
  rows?: Record<string, unknown>[];
  placeholder?: boolean;
  placeholderReason?: string;
};

function displayValue(value: unknown): string {
  if (value == null) return "-";
  if (typeof value === "number") return Number.isFinite(value) ? value.toString() : "-";
  if (typeof value === "boolean") return value ? "true" : "false";
  if (typeof value === "string") return value;
  return JSON.stringify(value);
}

export function LiveDataTablePage({
  title,
  subtitle,
  apiPath,
  rowKey = "id",
}: {
  title: string;
  subtitle: string;
  apiPath: string;
  rowKey?: string;
}) {
  const [data, setData] = useState<LivePayload | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch(apiPath, { cache: "no-store" });
        if (!res.ok) {
          if (!cancelled) setError(`API error (${res.status})`);
          return;
        }
        const json = (await res.json()) as LivePayload;
        if (!cancelled) setData(json);
      } catch {
        if (!cancelled) setError(`Unable to reach ${apiPath}`);
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [apiPath]);

  const rows = useMemo(() => data?.rows ?? [], [data?.rows]);
  const columns = useMemo(() => {
    if (rows.length === 0) return [] as string[];
    return Object.keys(rows[0] ?? {});
  }, [rows]);

  return (
    <Stack spacing={2.5}>
      <Box>
        <Typography variant="h4" sx={{ fontWeight: 950 }}>
          {title}
        </Typography>
        <Typography color="text.secondary" sx={{ mt: 0.5 }}>
          {subtitle}
        </Typography>
        {loading ? <Typography color="text.secondary" sx={{ mt: 0.5 }}>Loading data...</Typography> : null}
        {error ? <Typography sx={{ mt: 0.5, color: "warning.main", fontWeight: 700 }}>{error}</Typography> : null}
        {data?.placeholder ? (
          <Typography sx={{ mt: 0.5, color: "warning.main", fontWeight: 700 }}>
            Placeholder: {data.placeholderReason ?? "Pending integration"}
          </Typography>
        ) : null}
      </Box>

      <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
        {Object.entries(data?.summary ?? {}).map(([k, v]) => (
          <Chip key={k} label={`${k}: ${displayValue(v)}`} variant="outlined" />
        ))}
        <Chip label={`rows: ${rows.length}`} />
      </Stack>

      <Card>
        <CardContent>
          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  {columns.map((c) => (
                    <TableCell key={c}>{c}</TableCell>
                  ))}
                </TableRow>
              </TableHead>
              <TableBody>
                {rows.map((r, idx) => {
                  const key = displayValue(r[rowKey]) || `${idx}`;
                  return (
                    <TableRow key={key} hover>
                      {columns.map((c) => (
                        <TableCell key={`${key}-${c}`}>{displayValue(r[c])}</TableCell>
                      ))}
                    </TableRow>
                  );
                })}
              </TableBody>
            </Table>
          </TableContainer>
        </CardContent>
      </Card>
    </Stack>
  );
}

