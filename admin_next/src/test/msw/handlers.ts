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
    const body = jsonRecord(await request.json());
    return HttpResponse.json({ id: params.id, ...body });
  }),

  // Incidents: create
  http.post(`${BASE}/incidents`, async ({ request }) => {
    const body = jsonRecord(await request.json());
    return HttpResponse.json({ id: "inc_new", ...body }, { status: 201 });
  }),

  // Incidents: process
  http.patch(`${BASE}/incidents/:id`, async ({ params, request }) => {
    const body = jsonRecord(await request.json());
    return HttpResponse.json({ id: params.id, ...body });
  }),

  // Capital: adjust
  http.post(`${BASE}/capital/adjust`, async ({ request }) => {
    const body = jsonRecord(await request.json());
    return HttpResponse.json({ success: true, ...body });
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
