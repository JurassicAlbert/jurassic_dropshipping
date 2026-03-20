/**
 * TP-E: synthetic load shapes for client-side table prep (no warehouse in CI).
 * Validates filter/sort loops stay within coarse budgets for N rows.
 */

function filterSortPage(
  rows: { id: string; platform: string; status: string; profit: number; riskScore: number }[],
  query: string,
  platform: string,
  status: string,
  sortBy: "profit" | "risk",
  sortDir: "asc" | "desc",
  page: number,
  pageSize: number,
) {
  const q = query.trim().toLowerCase();
  const out = rows
    .filter((r) => (platform === "all" ? true : r.platform === platform))
    .filter((r) => (status === "all" ? true : r.status === status))
    .filter((r) => (q ? `${r.id} ${r.platform} ${r.status}`.toLowerCase().includes(q) : true));
  out.sort((a, b) => {
    const av = sortBy === "profit" ? a.profit : a.riskScore;
    const bv = sortBy === "profit" ? b.profit : b.riskScore;
    return sortDir === "asc" ? av - bv : bv - av;
  });
  const start = page * pageSize;
  return out.slice(start, start + pageSize);
}

describe("TP-E load shapes (synthetic)", () => {
  const sizes = [
    { name: "low", n: 80 },
    { name: "mid", n: 1000 },
    { name: "heavy", n: 100_000 },
  ];

  it.each(sizes)("$name: filter+sort+page under budget", ({ n }) => {
    const rows = Array.from({ length: n }, (_, i) => ({
      id: `ord_${i}`,
      platform: i % 2 === 0 ? "allegro" : "temu",
      status: i % 5 === 0 ? "failed" : "shipped",
      profit: (i % 97) - 40,
      riskScore: i % 100,
    }));
    const t0 = performance.now();
    const pageRows = filterSortPage(rows, "ord_", "all", "all", "risk", "desc", 0, 20);
    const ms = performance.now() - t0;
    expect(pageRows.length).toBeLessThanOrEqual(20);
    // Coarse SLO: 100k rows client prep should stay well under 1s on CI runners.
    expect(ms).toBeLessThan(1000);
  });
});
