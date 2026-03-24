import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport incidentsGetIncident", () => {
  beforeEach(() => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() =>
        Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              summary: { id: 1, orderId: "ord-1" },
              rows: [
                {
                  id: 1,
                  orderId: "ord-1",
                  incidentType: "delay",
                  status: "open",
                  financialImpact: 0,
                  createdAt: "2025-01-01T00:00:00.000Z",
                  resolvedAt: null,
                },
              ],
              placeholder: false,
            }),
        } as Response),
      ),
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("maps GET /api/incidents/:id payload rows[0] to IncidentRow", async () => {
    const t = new HttpTransport();
    const res = await t.incidentsGetIncident("req-1", 1);
    expect(res.ok).toBe(true);
    if (res.ok) {
      expect(res.incident?.id).toBe(1);
      expect(res.incident?.orderId).toBe("ord-1");
      expect(res.incident?.incidentType).toBe("delay");
    }
  });

  it("returns null incident on 404", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() => Promise.resolve({ ok: false, status: 404 } as Response)),
    );
    const t = new HttpTransport();
    const res = await t.incidentsGetIncident("req-2", 999);
    expect(res.ok).toBe(true);
    if (res.ok) expect(res.incident).toBeNull();
  });

  it("creates incident via POST /api/incidents", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() =>
        Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              incident: {
                id: 1234,
                orderId: "ord-2",
                incidentType: "damageClaim",
                status: "open",
                trigger: "manual",
                createdAt: "2025-01-01T00:00:00.000Z",
                resolvedAt: null,
              },
            }),
        } as Response),
      ),
    );
    const t = new HttpTransport();
    const res = await t.incidentsCreateIncident("req-3", { orderId: "ord-2", incidentType: "damageClaim" });
    expect(res.ok).toBe(true);
    if (res.ok) {
      expect(res.incident.id).toBe(1234);
      expect(res.incident.orderId).toBe("ord-2");
      expect(res.incident.status).toBe("open");
    }
    expect(fetch).toHaveBeenCalledWith(
      "/api/incidents",
      expect.objectContaining({ method: "POST" }),
    );
  });

  it("processes incident via PATCH /api/incidents/:id", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() =>
        Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              incident: {
                id: 1234,
                orderId: "ord-2",
                incidentType: "damageClaim",
                status: "resolved",
                trigger: "manual",
                createdAt: "2025-01-01T00:00:00.000Z",
                resolvedAt: "2025-01-02T00:00:00.000Z",
              },
            }),
        } as Response),
      ),
    );
    const t = new HttpTransport();
    const res = await t.incidentsProcessIncident("req-4", 1234);
    expect(res.ok).toBe(true);
    if (res.ok) {
      expect(res.incident.id).toBe(1234);
      expect(res.incident.status).toBe("resolved");
    }
    expect(fetch).toHaveBeenCalledWith(
      "/api/incidents/1234",
      expect.objectContaining({ method: "PATCH" }),
    );
  });
});
