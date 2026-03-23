import { existsSync } from "node:fs";
import path from "node:path";

/**
 * Parity: Flutter `lib/app_router.dart` shell routes vs Next `app` tree `page.tsx` files.
 * Flutter `/dashboard` (home) maps to Next `/` via `app/page.tsx`.
 */
const flutterShellToNextPage: Record<string, string> = {
  "/dashboard": "app/page.tsx",
  "/analytics": "app/analytics/page.tsx",
  "/profit-dashboard": "app/profit-dashboard/page.tsx",
  "/products": "app/products/page.tsx",
  "/orders": "app/orders/page.tsx",
  "/suppliers": "app/suppliers/page.tsx",
  "/suppliers/:id": "app/suppliers/[id]/page.tsx",
  "/marketplaces": "app/marketplaces/page.tsx",
  "/returns": "app/returns/page.tsx",
  "/incidents": "app/incidents/page.tsx",
  "/incidents/:id": "app/incidents/[id]/page.tsx",
  "/risk-dashboard": "app/risk-dashboard/page.tsx",
  "/returned-stock": "app/returned-stock/page.tsx",
  "/capital": "app/capital/page.tsx",
  "/approval": "app/approval/page.tsx",
  "/decision-log": "app/decision-log/page.tsx",
  "/return-policies": "app/return-policies/page.tsx",
  "/settings": "app/settings/page.tsx",
  "/how-it-works": "app/how-it-works/page.tsx",
};

describe("Flutter shell routes → Next page files (parity inventory)", () => {
  const root = path.join(__dirname, "..");

  it.each(Object.entries(flutterShellToNextPage))("Flutter %s has %s", (_flutterPath, pageRel) => {
    expect(existsSync(path.join(root, pageRel))).toBe(true);
  });

  it("inventory matches count of GoRouter shell children (19 routes)", () => {
    expect(Object.keys(flutterShellToNextPage)).toHaveLength(19);
  });
});
