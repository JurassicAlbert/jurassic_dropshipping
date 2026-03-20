"use client";

import { AdminShell } from "@/components/AdminShell";
import { LiveDataTablePage } from "@/components/ops/LiveDataTablePage";

export default function MarketplacesPage() {
  return (
    <AdminShell>
      <LiveDataTablePage
        title="Marketplaces"
        subtitle="Connected marketplace accounts and activation state."
        apiPath="/api/marketplaces"
        rowKey="id"
      />
    </AdminShell>
  );
}

