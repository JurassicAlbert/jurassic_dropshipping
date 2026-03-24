import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport suppliersRefreshReliabilityScores", () => {
  beforeEach(() => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() =>
        Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              updatedSuppliersCount: 4,
            }),
        } as Response),
      ),
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("POSTs refresh request and maps updated count", async () => {
    const t = new HttpTransport();
    const res = await t.suppliersRefreshReliabilityScores("req-sup-1", { windowDays: 90 });
    expect(res.ok).toBe(true);
    if (res.ok) expect(res.updatedSuppliersCount).toBe(4);
    expect(fetch).toHaveBeenCalledWith(
      "/api/suppliers/reliability/refresh",
      expect.objectContaining({ method: "POST" }),
    );
  });
});

