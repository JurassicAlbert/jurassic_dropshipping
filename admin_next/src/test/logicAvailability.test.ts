import { existsSync } from "node:fs";
import path from "node:path";

/**
 * TP-D: each implemented business surface must have a Next page + API proxy path.
 * Extend this list when new admin modules ship.
 */
const adminSurfaces = [
  { page: "app/page.tsx", api: "app/api/dashboard/route.ts" },
  { page: "app/analytics/page.tsx", api: "app/api/dashboard/route.ts" },
  { page: "app/orders/page.tsx", api: "app/api/orders/route.ts" },
  { page: "app/products/page.tsx", api: "app/api/products/route.ts" },
  { page: "app/suppliers/page.tsx", api: "app/api/suppliers/route.ts" },
  { page: "app/marketplaces/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/returns/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/incidents/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/risk-dashboard/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/returned-stock/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/capital/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/approval/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/decision-log/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/return-policies/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/profit-dashboard/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/how-it-works/page.tsx", api: "app/api/[...proxy]/route.ts" },
  { page: "app/suppliers/[id]/page.tsx", api: "app/api/[...proxy]/route.ts" },
];

describe("TP-D logic availability (file presence)", () => {
  const root = path.join(__dirname, "..");

  it.each(adminSurfaces)("has page and API for $page", ({ page: pageRel, api: apiRel }) => {
    expect(existsSync(path.join(root, pageRel))).toBe(true);
    expect(existsSync(path.join(root, apiRel))).toBe(true);
  });
});
