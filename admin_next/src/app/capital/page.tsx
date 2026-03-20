"use client";

import { AdminShell } from "@/components/AdminShell";
import { CapitalWorkflowPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { Box, Stack, Typography } from "@mui/material";

export default function CapitalPage() {
  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Capital
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Record adjustments and validate ledger/balance updates in mock mode.
          </Typography>
        </Box>
        <CapitalWorkflowPanel />
      </Stack>
    </AdminShell>
  );
}

