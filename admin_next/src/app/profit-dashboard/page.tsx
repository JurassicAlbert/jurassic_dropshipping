"use client";

import { AdminShell } from "@/components/AdminShell";
import { LiveDataTablePage } from "@/components/ops/LiveDataTablePage";

export default function ProfitDashboardPage() {
  return (
    <AdminShell>
      <LiveDataTablePage
        title="Profit Dashboard"
        subtitle="Profit-focused KPI and margin summaries."
        apiPath="/api/profit-dashboard"
        rowKey="band"
      />
    </AdminShell>
  );
}

