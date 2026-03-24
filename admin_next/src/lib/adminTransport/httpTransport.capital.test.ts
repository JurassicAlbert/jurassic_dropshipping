import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport capitalRecordAdjustment", () => {
  beforeEach(() => {
    vi.stubGlobal(
      "fetch",
      vi.fn(() =>
        Promise.resolve({
          ok: true,
          json: () =>
            Promise.resolve({
              balance: 1234.5,
              ledgerEntryId: 77,
            }),
        } as Response),
      ),
    );
  });

  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("POSTs adjustment payload and returns balance + entry id", async () => {
    const t = new HttpTransport();
    const res = await t.capitalRecordAdjustment("req-cap-1", {
      amount: 120,
      referenceId: "note-1",
      currency: "PLN",
    });
    expect(res.ok).toBe(true);
    if (res.ok) {
      expect(res.balance).toBe(1234.5);
      expect(res.ledgerEntryId).toBe(77);
    }
    expect(fetch).toHaveBeenCalledWith(
      "/api/capital/adjust",
      expect.objectContaining({ method: "POST" }),
    );
  });
});

