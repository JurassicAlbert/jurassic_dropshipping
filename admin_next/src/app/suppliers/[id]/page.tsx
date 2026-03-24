"use client";

import { useParams } from "next/navigation";
import { AdminShell } from "@/components/AdminShell";
import { LiveDataTablePage } from "@/components/ops/LiveDataTablePage";
import { ReturnPoliciesWorkflowPanel } from "@/components/ops/MockWriteWorkflowPanels";
import { Stack, Typography } from "@mui/material";

export default function SupplierDetailPage() {
  const params = useParams<{ id: string }>();
  const id = params?.id ?? "";
  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <LiveDataTablePage
          title={`Supplier Detail: ${id}`}
          subtitle="Supplier-level summary, linked policy, and activity footprint."
          apiPath={`/api/suppliers/${id}`}
          rowKey="id"
        />
        <Typography variant="body2" color="text.secondary">
          Route-scoped action: update policy for this supplier with prefilled Supplier ID.
        </Typography>
        <ReturnPoliciesWorkflowPanel initialSupplierId={id} />
      </Stack>
    </AdminShell>
  );
}

