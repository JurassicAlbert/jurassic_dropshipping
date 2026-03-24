import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport risk refresh writes", () => {
  beforeEach(() => {
    vi.stubGlobal(
      "fetch",
      vi.fn((input) => {
        const url = String(input);
        if (url.endsWith("/api/risk/listing-health/refresh")) {
          return Promise.resolve({
            ok: true,
            json: () =>
              Promise.resolve({
                pausedListingsDelta: 2,
                metricsRefreshed: true,
              }),
          } as Response);
        }
        return Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              abuseSignalsUpdated: 5,
              metricsRefreshed: true,
            }),
        } as Response);
      }),
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("POSTs listing health refresh and maps response", async () => {
    const t = new HttpTransport();
    const res = await t.riskRefreshListingHealth("req-risk-1", { windowDays: 90 });
    expect(res.ok).toBe(true);
    if (res.ok) {
      expect(res.pausedListingsDelta).toBe(2);
      expect(res.metricsRefreshed).toBe(true);
    }
    expect(fetch).toHaveBeenCalledWith(
      "/api/risk/listing-health/refresh",
      expect.objectContaining({ method: "POST" }),
    );
  });

  it("POSTs customer metrics refresh and maps response", async () => {
    const t = new HttpTransport();
    const res = await t.riskRefreshCustomerMetrics("req-risk-2", { windowDays: 90 });
    expect(res.ok).toBe(true);
    if (res.ok) {
      expect(res.abuseSignalsUpdated).toBe(5);
      expect(res.metricsRefreshed).toBe(true);
    }
    expect(fetch).toHaveBeenCalledWith(
      "/api/risk/customer-metrics/refresh",
      expect.objectContaining({ method: "POST" }),
    );
  });
});

