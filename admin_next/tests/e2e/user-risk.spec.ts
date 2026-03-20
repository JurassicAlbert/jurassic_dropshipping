import { expect, test } from "@playwright/test";

test("dashboard shows warning when dashboard API fails (TP-C)", async ({ page }) => {
  await page.route("**/api/dashboard", async (route) => {
    await route.fulfill({ status: 502, body: JSON.stringify({ error: "bad" }) });
  });
  await page.goto("/");
  await expect(page.getByText(/API error \(502\).*Showing fallback snapshot/s)).toBeVisible();
});
