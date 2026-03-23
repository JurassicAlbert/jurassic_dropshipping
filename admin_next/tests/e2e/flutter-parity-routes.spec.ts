import { expect, test } from "@playwright/test";

/**
 * Direct URL parity: Flutter `GoRouter` paths vs Next routes (no reliance on drawer alone).
 * `/dashboard` in Flutter → `/` in Next.
 */
const directRoutes: Array<{ path: string; heading: string }> = [
  { path: "/", heading: "Dashboard" },
  { path: "/analytics", heading: "Analytics" },
  { path: "/profit-dashboard", heading: "Profit Dashboard" },
  { path: "/products", heading: "Products" },
  { path: "/orders", heading: "Orders" },
  { path: "/suppliers", heading: "Suppliers" },
  { path: "/suppliers/parity-test-supplier", heading: "Supplier Detail: parity-test-supplier" },
  { path: "/marketplaces", heading: "Marketplaces" },
  { path: "/returns", heading: "Returns" },
  { path: "/incidents", heading: "Incidents" },
  { path: "/incidents/42", heading: "Incident 42" },
  { path: "/risk-dashboard", heading: "Risk Dashboard" },
  { path: "/returned-stock", heading: "Returned Stock" },
  { path: "/capital", heading: "Capital" },
  { path: "/approval", heading: "Approval Queue" },
  { path: "/decision-log", heading: "Decision Log" },
  { path: "/return-policies", heading: "Return Policies" },
  { path: "/settings", heading: "Settings" },
  { path: "/how-it-works", heading: "How It Works" },
];

test.describe("Flutter parity — each shell route responds with expected heading", () => {
  for (const { path, heading } of directRoutes) {
    test(`GET ${path}`, async ({ page }) => {
      const res = await page.goto(path);
      expect(res?.ok()).toBeTruthy();
      await expect(page.getByRole("heading", { name: heading, exact: true })).toBeVisible();
    });
  }
});
