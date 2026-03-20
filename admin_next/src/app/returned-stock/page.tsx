"use client";

import { AdminShell } from "@/components/AdminShell";
import { LiveDataTablePage } from "@/components/ops/LiveDataTablePage";

export default function ReturnedStockPage() {
  return (
    <AdminShell>
      <LiveDataTablePage
        title="Returned Stock"
        subtitle="Restockable units from returns and their condition."
        apiPath="/api/returned-stock"
        rowKey="id"
      />
    </AdminShell>
  );
}

