"use client";

import { CapitalWorkflowPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { CapitalSnapshotCards } from "@/components/analytics/CapitalSnapshotCards";
import { AdminShell } from "@/components/AdminShell";
import { useDashboardData } from "@/lib/dashboardApi";
import { Box, Stack, Typography } from "@mui/material";

export default function CapitalPage() {
  const { data: view, loading, offline } = useDashboardData();

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Capital
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Ledger snapshot from the same <code>/api/dashboard</code> payload as Analytics. Adjustments below use mock transport in dev.
          </Typography>
          {loading ? (
            <Typography color="text.secondary" sx={{ mt: 0.5 }}>
              Loading…
            </Typography>
          ) : null}
          {!loading && offline ? (
            <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5 }}>
              Live API unavailable — showing offline snapshot.
            </Typography>
          ) : null}
        </Box>

        <CapitalSnapshotCards view={view} />

        <CapitalWorkflowPanel />
      </Stack>
    </AdminShell>
  );
}
