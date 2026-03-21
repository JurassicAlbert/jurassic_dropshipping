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

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch(apiPath, { cache: "no-store" });
        if (!res.ok) {
          if (!cancelled) {
            setData({
              rows: [],
              summary: {},
              placeholder: true,
              placeholderReason:
                "Live API unavailable (start `dart run tool/dashboard_api_server_dart_main.dart` or set DART_API_BASE_URL).",
            });
          }
          return;
        }
        const json = (await res.json()) as LivePayload;
        if (!cancelled) setData(json);
      } catch {
        if (!cancelled) {
          setData({
            rows: [],
            summary: {},
            placeholder: true,
            placeholderReason:
              "Could not reach API. Start the Dart dashboard server or check the Next.js proxy.",
          });
        }
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
        {data?.placeholder ? (
          <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
            {data.placeholderReason ?? "Pending integration"}
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

