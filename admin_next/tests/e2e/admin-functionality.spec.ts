import { expect, test } from "@playwright/test";

const pages: Array<{ link: string; heading: string }> = [
  { link: "Dashboard", heading: "Dashboard" },
  { link: "Analytics", heading: "Analytics" },
  { link: "Profit Dashboard", heading: "Profit Dashboard" },
  { link: "Products", heading: "Products" },
  { link: "Orders", heading: "Orders" },
  { link: "Suppliers", heading: "Suppliers" },
  { link: "Marketplaces", heading: "Marketplaces" },
  { link: "Returns", heading: "Returns" },
  { link: "Incidents", heading: "Incidents" },
  { link: "Risk Dashboard", heading: "Risk Dashboard" },
  { link: "Returned Stock", heading: "Returned Stock" },
  { link: "Capital", heading: "Capital" },
  { link: "Approval", heading: "Approval Queue" },
  { link: "Decision Log", heading: "Decision Log" },
  { link: "Return Policies", heading: "Return Policies" },
  { link: "How It Works", heading: "How It Works" },
  { link: "Settings", heading: "Settings" },
];

test("all admin navigation targets render expected content", async ({ page }) => {
  await page.goto("/");
  for (const p of pages) {
    await page.getByRole("link", { name: p.link, exact: true }).click();
    await expect(page.getByRole("heading", { name: p.heading, exact: true })).toBeVisible();
  }
});

