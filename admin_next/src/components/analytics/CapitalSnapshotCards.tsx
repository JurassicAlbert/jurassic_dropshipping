"use client";

import type { DashboardApiPayload } from "@/lib/dashboardApi";
import { Card, CardContent, Grid, Typography } from "@mui/material";

export function CapitalSnapshotCards({ view }: { view: DashboardApiPayload }) {
  const c = view.capital ?? {
    availablePln: 0,
    lockedPln: 0,
    returnReservePln: 0,
    cashflowGapPln: 0,
  };
  return (
    <Grid container spacing={2}>
      <Grid size={{ xs: 12, sm: 6, md: 3 }}>
        <Card variant="outlined" sx={{ height: "100%" }}>
          <CardContent>
            <Typography variant="caption" color="text.secondary">
              Available (ledger)
            </Typography>
            <Typography variant="h6" sx={{ fontWeight: 900 }}>
              {c.availablePln.toFixed(0)} PLN
            </Typography>
          </CardContent>
        </Card>
      </Grid>
      <Grid size={{ xs: 12, sm: 6, md: 3 }}>
        <Card variant="outlined" sx={{ height: "100%" }}>
          <CardContent>
            <Typography variant="caption" color="text.secondary">
              Locked (queued for capital)
            </Typography>
            <Typography variant="h6" sx={{ fontWeight: 900 }}>
              {c.lockedPln.toFixed(0)} PLN
            </Typography>
          </CardContent>
        </Card>
      </Grid>
      <Grid size={{ xs: 12, sm: 6, md: 3 }}>
        <Card variant="outlined" sx={{ height: "100%" }}>
          <CardContent>
            <Typography variant="caption" color="text.secondary">
              Return reserve (cost)
            </Typography>
            <Typography variant="h6" sx={{ fontWeight: 900 }}>
              {c.returnReservePln.toFixed(0)} PLN
            </Typography>
          </CardContent>
        </Card>
      </Grid>
      <Grid size={{ xs: 12, sm: 6, md: 3 }}>
        <Card variant="outlined" sx={{ height: "100%" }}>
          <CardContent>
            <Typography variant="caption" color="text.secondary">
              Cashflow gap (heuristic)
            </Typography>
            <Typography variant="h6" sx={{ fontWeight: 900 }}>
              {c.cashflowGapPln.toFixed(0)} PLN
            </Typography>
            <Typography variant="caption" color="text.disabled">
              available − locked − reserve
            </Typography>
          </CardContent>
        </Card>
      </Grid>
    </Grid>
  );
}
