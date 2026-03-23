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
});
