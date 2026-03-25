import { afterAll, afterEach, beforeAll, describe, expect, it } from "vitest";
import { server } from "../../test/msw/server";
import { HttpTransport } from "./httpTransport";

describe("HttpTransport + MSW (capital.adjust)", () => {
  beforeAll(() => server.listen({ onUnhandledRequest: "bypass" }));
  afterEach(() => server.resetHandlers());
  afterAll(() => server.close());

  it("maps POST /api/capital/adjust response into balance + ledgerEntryId", async () => {
    const t = new HttpTransport();
    const res = await t.capitalRecordAdjustment("req-cap-1", {
      amount: 100,
      referenceId: "note_1",
      currency: "PLN",
    });

    expect(res.ok).toBe(true);
    if (!res.ok) return;
    expect(res.balance).toBe(123.45);
    expect(res.ledgerEntryId).toBe(9001);
  });
});

