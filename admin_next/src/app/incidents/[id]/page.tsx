"use client";

import { AdminShell } from "@/components/AdminShell";
import { LiveDataTablePage } from "@/components/ops/LiveDataTablePage";
import { useParams } from "next/navigation";

/**
 * Parity with Flutter `GoRoute(path: '/incidents/:id')`.
 * Data: `GET /api/incidents/:id` → Dart `GET /incidents/:id` (dashboard API server).
 */
export default function IncidentDetailPage() {
  const params = useParams<{ id: string }>();
  const id = params?.id ?? "";

  return (
    <AdminShell>
      <LiveDataTablePage
        title={`Incident ${id}`}
        subtitle="Incident record (read-only via Dart dashboard API when running)."
        apiPath={`/api/incidents/${encodeURIComponent(id)}`}
        rowKey="id"
      />
    </AdminShell>
  );
}
