"use client";

import { AdminShell } from "@/components/AdminShell";
import { ReturnPoliciesWorkflowPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { Box, Stack, Typography } from "@mui/material";

export default function ReturnPoliciesPage() {
  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Return Policies
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Add/edit supplier policies through deterministic upsert requests.
          </Typography>
        </Box>
        <ReturnPoliciesWorkflowPanel />
      </Stack>
    </AdminShell>
  );
}

