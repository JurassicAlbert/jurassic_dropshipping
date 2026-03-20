"use client";

import { useParams } from "next/navigation";
import { AdminShell } from "@/components/AdminShell";
import { LiveDataTablePage } from "@/components/ops/LiveDataTablePage";

export default function SupplierDetailPage() {
  const params = useParams<{ id: string }>();
  const id = params?.id ?? "";
  return (
    <AdminShell>
      <LiveDataTablePage
        title={`Supplier Detail: ${id}`}
        subtitle="Supplier-level summary, linked policy, and activity footprint."
        apiPath={`/api/suppliers/${id}`}
        rowKey="id"
      />
    </AdminShell>
  );
}

