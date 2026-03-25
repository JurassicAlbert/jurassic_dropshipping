import { http, HttpResponse } from "msw";

const BASE = "/api";

function jsonRecord(v: unknown): Record<string, unknown> {
  return v !== null && typeof v === "object" && !Array.isArray(v) ? (v as Record<string, unknown>) : {};
}

export const handlers = [
  // Approval: approve order
  http.post(`${BASE}/approval/orders/:id/approve`, async ({ params }) => {
    return HttpResponse.json({ id: params.id, status: 'approved' });
  }),

  // Approval: reject order
  http.post(`${BASE}/approval/orders/:id/reject`, async ({ params }) => {
    return HttpResponse.json({ id: params.id, status: 'rejected' });
  }),

  // Returns: update status
  http.patch(`${BASE}/returns/:id`, async ({ params, request }) => {
    // HttpTransport calls:
    //   PATCH /api/returns/:id
    //   { patch: { status, notes, refundAmount, ... }, addToReturnedStock: boolean }
    const body = jsonRecord(await request.json());
    const patch = jsonRecord(body.patch);
    const addToReturnedStock = Boolean(body.addToReturnedStock);

    const status = String(patch.status ?? "requested");
    const created = status === "received" && addToReturnedStock;

    const resolvedAt =
      status === "received" || status === "refunded" || status === "rejected"
        ? "2026-01-02T00:00:00.000Z"
        : null;

    return HttpResponse.json({
      return: {
        id: params.id,
        orderId: "ord_1",
        status,
        reason: "noReason",
        notes: patch.notes ?? null,
        refundAmount: typeof patch.refundAmount === "number" ? patch.refundAmount : null,
        returnShippingCost: null,
        restockingFee: null,
        returnRoutingDestination: null,
        supplierId: "sup_1",
        requestedAt: "2026-01-01T00:00:00.000Z",
        resolvedAt,
      },
      returnedStockCreated: { created, rowsInserted: created ? 1 : 0 },
    });
  }),

  // Incidents: create
  http.post(`${BASE}/incidents`, async ({ request }) => {
    const body = jsonRecord(await request.json());
    const orderId = String(body.orderId ?? "ord_1");
    const incidentType = String(body.incidentType ?? "customerReturn14d");
    return HttpResponse.json({
      incident: {
        id: 1001,
        orderId,
        incidentType,
        status: "open",
        trigger: "manual",
        createdAt: "2026-01-01T00:00:00.000Z",
        resolvedAt: null,
      },
    });
  }),

  // Incidents: process
  http.patch(`${BASE}/incidents/:id`, async ({ params, request }) => {
    void request;
    const id = Number(params.id);
    return HttpResponse.json({
      incident: {
        id: Number.isFinite(id) ? id : 0,
        orderId: "ord_1",
        incidentType: "customerReturn14d",
        status: "resolved",
        trigger: "manual",
        createdAt: "2026-01-01T00:00:00.000Z",
        resolvedAt: "2026-01-02T00:00:00.000Z",
      },
    });
  }),

  // Capital: adjust
  http.post(`${BASE}/capital/adjust`, async ({ request }) => {
    void request;
    return HttpResponse.json({ balance: 123.45, ledgerEntryId: 9001 });
  }),

  // Return policies: upsert
  http.put(`${BASE}/return-policies/:id`, async ({ params, request }) => {
    const body = jsonRecord(await request.json());
    return HttpResponse.json({ id: params.id, ...body });
  }),

  // Supplier reliability: refresh
  http.post(`${BASE}/suppliers/:id/reliability/refresh`, async ({ params }) => {
    return HttpResponse.json({ supplierId: params.id, refreshed: true });
  }),

  // Risk: refresh
  http.post(`${BASE}/risk/refresh`, async () => {
    return HttpResponse.json({ refreshed: true });
  }),

  // Failure variants for testing
  http.post(`${BASE}/test/fail-429`, async () => {
    return HttpResponse.json({ error: 'Too Many Requests' }, { status: 429 });
  }),

  http.post(`${BASE}/test/fail-500`, async () => {
    return HttpResponse.json({ error: 'Internal Server Error' }, { status: 500 });
  }),
];
