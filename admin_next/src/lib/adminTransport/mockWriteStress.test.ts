import { describe, expect, it } from "vitest";
import { MockTransportFixed, createDefaultMockState } from "./mockTransportFixed";

/**
 * Stress / retest: many writes against mock transport (writeChain + idempotency).
 * Complements Playwright transition specs — no UI, fast in CI.
 */

/** Mirrors mockTransportFixed.shouldFail(kind, requestId) for picking stable request ids. */
function mockShouldFail(kind: string, requestId: string): boolean {
  let h = 2166136261;
  const s = `${kind}:${requestId}`;
  for (let i = 0; i < s.length; i++) {
    h ^= s.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  return Math.abs(h) % 17 === 0;
}

function firstRequestIdWhere(kind: string, wantFail: boolean): string {
  for (let i = 0; i < 500; i++) {
    const rid = `stress-rs-${kind}-${i}`;
    if (mockShouldFail(kind, rid) === wantFail) return rid;
  }
  throw new Error(`no requestId found for kind=${kind} wantFail=${wantFail}`);
}

describe("mock transport write stress", () => {
  it("serializes concurrent listing approvals without hanging", async () => {
    const t = new MockTransportFixed(createDefaultMockState());
    const pending = await t.approvalGetPendingListings("stress-list-0");
    expect(pending.ok).toBe(true);
    const ids = pending.pendingListings.map((l) => l.id);
    expect(ids.length).toBeGreaterThan(0);

    await Promise.all(ids.map((id, i) => t.approvalApproveListing(id, `stress-list-${i}-${performance.now()}`)));

    const after = await t.approvalGetPendingListings("stress-list-1");
    expect(after.ok).toBe(true);
    for (const id of ids) {
      expect(after.pendingListings.some((l) => l.id === id)).toBe(false);
    }
  });

  it("parallel identical requestIds for one approve return the same payload (idempotent)", async () => {
    const t = new MockTransportFixed(createDefaultMockState());
    const pending = await t.approvalGetPendingListings("idem-0");
    const id = pending.pendingListings[0]?.id;
    expect(id).toBeDefined();
    const reqId = "idem-parallel-approval-listing";
    const [a, b, c] = await Promise.all([
      t.approvalApproveListing(id!, reqId),
      t.approvalApproveListing(id!, reqId),
      t.approvalApproveListing(id!, reqId),
    ]);
    expect(a.ok && b.ok && c.ok).toBe(true);
    if (!a.ok || !b.ok || !c.ok) return;
    expect(JSON.stringify(a)).toBe(JSON.stringify(b));
    expect(JSON.stringify(b)).toBe(JSON.stringify(c));
  });

  it("mixed concurrent listing + order approvals complete", async () => {
    const t = new MockTransportFixed(createDefaultMockState());
    const pl = await t.approvalGetPendingListings("mix-l");
    const po = await t.approvalGetPendingOrders("mix-o");
    expect(pl.ok && po.ok).toBe(true);
    const lIds = pl.pendingListings.map((x) => x.id);
    const oIds = po.pendingOrders.map((x) => x.id);
    expect(lIds.length + oIds.length).toBeGreaterThan(0);

    await Promise.all([
      ...lIds.map((id, i) => t.approvalApproveListing(id, `mix-l-${i}`)),
      ...oIds.map((id, i) => t.approvalApproveAndFulfillOrder(id, `mix-o-${i}`)),
    ]);

    const pl2 = await t.approvalGetPendingListings("mix-l2");
    const po2 = await t.approvalGetPendingOrders("mix-o2");
    expect(pl2.ok && po2.ok).toBe(true);
    for (const id of lIds) {
      expect(pl2.pendingListings.some((l) => l.id === id)).toBe(false);
    }
    for (const id of oIds) {
      expect(po2.pendingOrders.some((o) => o.id === id)).toBe(false);
    }
  });

  it("second approval wave on already-active listings yields failures without deadlock", async () => {
    const t = new MockTransportFixed(createDefaultMockState());
    const pending = await t.approvalGetPendingListings("wave-0");
    const ids = pending.pendingListings.map((l) => l.id);
    expect(ids.length).toBeGreaterThan(0);

    await Promise.all(ids.map((id, i) => t.approvalApproveListing(id, `wave-a-${i}`)));

    const second = await Promise.all(ids.map((id, i) => t.approvalApproveListing(id, `wave-b-${i}`)));
    expect(second.every((r) => !r.ok)).toBe(true);
    expect(second.every((r) => r.ok === false && r.error.code === "conflict")).toBe(true);
  });

  it("many sequential return updates stay consistent", async () => {
    const t = new MockTransportFixed(createDefaultMockState());
    const rows = await t.returnsGetReturns("ret-0");
    expect(rows.ok).toBe(true);
    const target = rows.rows.find((r) => r.status === "requested" || r.status === "approved");
    expect(target).toBeDefined();

    for (let i = 0; i < 25; i++) {
      const status = i % 2 === 0 ? "approved" : "requested";
      const res = await t.returnsUpdateReturn(`ret-loop-${i}`, target!.id, { status, notes: `n${i}` }, false);
      expect(res.ok).toBe(true);
    }

    const final = await t.returnsGetReturns("ret-1");
    expect(final.ok).toBe(true);
    const row = final.rows.find((r) => r.id === target!.id);
    expect(row?.notes).toBe("n24");
    // i=24 is even → last write uses status "approved"
    expect(row?.status).toBe("approved");
  });

  it("after returned-stock partial failure, retry with new requestId can succeed", async () => {
    const t = new MockTransportFixed(createDefaultMockState());
    const failRid = firstRequestIdWhere("returnedStockInsert", true);
    const okRid = firstRequestIdWhere("returnedStockInsert", false);
    const rows = await t.returnsGetReturns("rs-0");
    expect(rows.ok).toBe(true);
    const target = rows.rows.find((r) => r.status === "approved");
    expect(target).toBeDefined();

    const bad = await t.returnsUpdateReturn(failRid, target!.id, { status: "received", notes: "partial-path" }, true);
    expect(bad.ok).toBe(false);

    const mid = await t.returnsGetReturns("rs-1");
    const midRow = mid.rows.find((r) => r.id === target!.id);
    expect(midRow?.status).toBe("received");

    const good = await t.returnsUpdateReturn(okRid, target!.id, { status: "received", notes: "after-retry" }, true);
    expect(good.ok).toBe(true);
    if (!good.ok) return;
    expect(good.returnedStockCreated.rowsInserted).toBeGreaterThanOrEqual(1);

    const last = await t.returnsGetReturns("rs-2");
    const lastRow = last.rows.find((r) => r.id === target!.id);
    expect(lastRow?.notes).toBe("after-retry");
  });
});
