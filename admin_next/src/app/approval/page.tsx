"use client";

import { AdminShell } from "@/components/AdminShell";
import { ApprovalWorkflowPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { Box, Stack, Typography } from "@mui/material";

export default function ApprovalPage() {
  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Approval Queue
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Mocked approve/reject workflows with deterministic request outcomes.
          </Typography>
        </Box>
        <ApprovalWorkflowPanel />
      </Stack>
    </AdminShell>
  );
}

