"use client";

import { Box, Card, CardContent, Skeleton, Typography } from "@mui/material";
import { AreaChart, Area, XAxis, YAxis, Tooltip, ResponsiveContainer, CartesianGrid } from "recharts";
import { useClientMounted } from "@/lib/useClientMounted";

export type ProfitPoint = { day: string; profit: number };

export function ProfitTrendChartCard({ points }: { points: ProfitPoint[] }) {
  const mounted = useClientMounted();

  return (
    <Card>
      <CardContent>
        <Box sx={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", mb: 1.5 }}>
          <Typography variant="h6" sx={{ fontWeight: 900 }}>
            Profit trend (7d)
          </Typography>
          <Typography variant="body2" color="text.secondary">
            PLN
          </Typography>
        </Box>

        <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
          Smooth area chart with clean axis + “soft” gradients.
        </Typography>

        <Box sx={{ height: 280, minWidth: 0 }}>
          {mounted ? (
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={points} margin={{ left: 4, right: 12, top: 10, bottom: 0 }}>
                <defs>
                  <linearGradient id="profitFill" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stopColor="#1C6EF2" stopOpacity={0.30} />
                    <stop offset="100%" stopColor="#1C6EF2" stopOpacity={0} />
                  </linearGradient>
                </defs>
                <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
                <XAxis dataKey="day" axisLine={false} tickLine={false} tick={{ fill: "rgba(16,24,40,0.7)" }} />
                <YAxis
                  axisLine={false}
                  tickLine={false}
                  width={46}
                  tick={{ fill: "rgba(16,24,40,0.7)" }}
                  tickFormatter={(v) => `${v}`}
                />
                <Tooltip />
                <Area
                  type="monotone"
                  dataKey="profit"
                  stroke="#1C6EF2"
                  strokeWidth={2.5}
                  fill="url(#profitFill)"
                />
              </AreaChart>
            </ResponsiveContainer>
          ) : (
            <Skeleton variant="rounded" height={280} />
          )}
        </Box>
      </CardContent>
    </Card>
  );
}

