import { beforeAll, afterAll, afterEach, describe, expect, it } from "vitest";
import { HttpTransport } from "./httpTransport";
import { server } from "../../test/msw/server";

describe("HttpTransport + MSW (returns.updateReturn)", () => {
  beforeAll(() => server.listen({ onUnhandledRequest: "bypass" }));
  afterEach(() => server.resetHandlers());
  afterAll(() => server.close());

  it("maps MSW PATCH /api/returns/:id response into ReturnRow + returnedStockCreated", async () => {
    const t = new HttpTransport();
    const res = await t.returnsUpdateReturn(
      "req-1",
      "ret_1",
      { status: "received", notes: "ok", refundAmount: null, returnRoutingDestination: null },
      true,
    );

    expect(res.ok).toBe(true);
    if (!res.ok) return;

    expect(res.return.id).toBe("ret_1");
    expect(res.return.status).toBe("received");
    expect(res.return.notes).toBe("ok");
    expect(res.returnedStockCreated.created).toBe(true);
    expect(res.returnedStockCreated.rowsInserted).toBe(1);
  });
});

