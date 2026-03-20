"use client";

import { AdminShell } from "@/components/AdminShell";
import { ReturnsWorkflowPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { Box, Stack, Typography } from "@mui/material";

export default function ReturnsPage() {
  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Returns
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Edit return status, compute routing, and test returned-stock add behavior.
          </Typography>
        </Box>
        <ReturnsWorkflowPanel />
      </Stack>
    </AdminShell>
  );
}

