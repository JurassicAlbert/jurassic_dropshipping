"use client";

import { AdminShell } from "@/components/AdminShell";
import { LiveDataTablePage } from "@/components/ops/LiveDataTablePage";

export default function DecisionLogPage() {
  return (
    <AdminShell>
      <LiveDataTablePage
        title="Decision Log"
        subtitle="Decision audit trail for listings, orders, and incidents."
        apiPath="/api/decision-log"
        rowKey="id"
      />
    </AdminShell>
  );
}

