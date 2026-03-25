import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { server } from "../../test/msw/server";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport + MSW (incidents)", () => {
  beforeAll(() => server.listen({ onUnhandledRequest: "bypass" }));
  afterEach(() => server.resetHandlers());
  afterAll(() => server.close());

  it("creates incident and maps IncidentRow", async () => {
    const t = new HttpTransport();
    const res = await t.incidentsCreateIncident("req-inc-create-1", {
      orderId: "ord_1",
      incidentType: "customerReturn14d",
    });

    expect(res.ok).toBe(true);
    if (!res.ok) return;
    expect(res.incident.orderId).toBe("ord_1");
    expect(res.incident.status).toBe("open");
    expect(res.incident.createdAt).toMatch(/^\d{4}-\d{2}-\d{2}T/);
  });

  it("processes incident and maps resolved IncidentRow", async () => {
    const t = new HttpTransport();
    const res = await t.incidentsProcessIncident("req-inc-proc-1", 123);
    expect(res.ok).toBe(true);
    if (!res.ok) return;
    expect(res.incident.id).toBe(123);
    expect(res.incident.status).toBe("resolved");
    expect(res.incident.resolvedAt).not.toBeNull();
  });
});

