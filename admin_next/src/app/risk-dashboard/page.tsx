"use client";

import { AdminShell } from "@/components/AdminShell";
import { SupplierReliabilityAndRiskPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { Box, Stack, Typography } from "@mui/material";

export default function RiskDashboardPage() {
  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Risk Dashboard
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Trigger listing-health and customer-metrics refresh actions in mock mode.
          </Typography>
        </Box>
        <SupplierReliabilityAndRiskPanel />
      </Stack>
    </AdminShell>
  );
}

