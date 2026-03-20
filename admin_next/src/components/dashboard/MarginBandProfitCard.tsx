"use client";

import { Box, Card, CardContent, Skeleton, Typography } from "@mui/material";
import { CartesianGrid, Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";

export type MarginBandPoint = {
  band: string;
  profit: number;
};

export function MarginBandProfitCard({ points }: { points: MarginBandPoint[] }) {
  const canRenderChart = typeof window !== "undefined";

  return (
    <Card>
      <CardContent>
        <Box sx={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", mb: 1.5 }}>
          <Typography variant="h6" sx={{ fontWeight: 900 }}>
            Profit by margin band
          </Typography>
          <Typography variant="body2" color="text.secondary">
            PLN
          </Typography>
        </Box>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
          Contribution across realized margin ranges.
        </Typography>

        <Box sx={{ height: 260, minWidth: 0 }}>
          {canRenderChart ? (
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={points} margin={{ left: 4, right: 12, top: 10, bottom: 0 }}>
                <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
                <XAxis dataKey="band" axisLine={false} tickLine={false} tick={{ fill: "rgba(16,24,40,0.7)" }} />
                <YAxis axisLine={false} tickLine={false} width={48} tick={{ fill: "rgba(16,24,40,0.7)" }} />
                <Tooltip />
                <Line type="monotone" dataKey="profit" stroke="#7C5CFF" strokeWidth={2.5} dot={{ r: 3 }} />
              </LineChart>
            </ResponsiveContainer>
          ) : (
            <Skeleton variant="rounded" height={260} />
          )}
        </Box>
      </CardContent>
    </Card>
  );
}

