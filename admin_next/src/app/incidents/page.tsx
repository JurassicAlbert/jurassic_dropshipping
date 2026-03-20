"use client";

import { AdminShell } from "@/components/AdminShell";
import { IncidentsWorkflowPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { Box, Stack, Typography } from "@mui/material";

export default function IncidentsPage() {
  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Incidents
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Create incidents and process/resolve them with deterministic mock responses.
          </Typography>
        </Box>
        <IncidentsWorkflowPanel />
      </Stack>
    </AdminShell>
  );
}

