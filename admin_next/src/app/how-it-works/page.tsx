"use client";

import { AdminShell } from "@/components/AdminShell";
import { LiveDataTablePage } from "@/components/ops/LiveDataTablePage";

export default function HowItWorksPage() {
  return (
    <AdminShell>
      <LiveDataTablePage
        title="How It Works"
        subtitle="Operational architecture and control-flow overview."
        apiPath="/api/how-it-works"
        rowKey="title"
      />
    </AdminShell>
  );
}

