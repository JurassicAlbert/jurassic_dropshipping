"use client";

import { Box, Card, CardContent, Skeleton, Typography } from "@mui/material";
import { Bar, BarChart, CartesianGrid, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { useClientMounted } from "@/lib/useClientMounted";

export type ProfitByPlatformPoint = {
  platformId: string;
  profit: number;
};

export function ProfitByPlatformCard({ points }: { points: ProfitByPlatformPoint[] }) {
  const mounted = useClientMounted();

  return (
    <Card>
      <CardContent>
        <Box sx={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", mb: 1.5 }}>
          <Typography variant="h6" sx={{ fontWeight: 900 }}>
            Profit by platform
          </Typography>
          <Typography variant="body2" color="text.secondary">
            PLN
          </Typography>
        </Box>
        <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
          Which channels generate the strongest margins.
        </Typography>

        <Box sx={{ height: 260, minWidth: 0 }}>
          {mounted ? (
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={points} margin={{ left: 4, right: 12, top: 10, bottom: 0 }}>
                <CartesianGrid stroke="rgba(16,24,40,0.06)" vertical={false} />
                <XAxis dataKey="platformId" axisLine={false} tickLine={false} tick={{ fill: "rgba(16,24,40,0.7)" }} />
                <YAxis axisLine={false} tickLine={false} width={48} tick={{ fill: "rgba(16,24,40,0.7)" }} />
                <Tooltip />
                <Bar dataKey="profit" fill="#1C6EF2" radius={[8, 8, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          ) : (
            <Skeleton variant="rounded" height={260} />
          )}
        </Box>
      </CardContent>
    </Card>
  );
}

