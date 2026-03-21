import { expect, test } from "@playwright/test";

test("dashboard stays usable when dashboard API fails — no loud error banner (TP-C)", async ({ page }) => {
  await page.route("**/api/dashboard", async (route) => {
    await route.fulfill({ status: 502, body: JSON.stringify({ error: "bad" }) });
  });
  await page.goto("/");
  await expect(page.getByRole("heading", { name: "Dashboard", exact: true })).toBeVisible();
  await expect(page.getByText(/API error \(\d+\)\. Showing fallback snapshot/)).toHaveCount(0);
  await expect(page.getByText(/Revenue \(30d\)/)).toBeVisible();
  await expect(page.getByText(/demo snapshot/i)).toBeVisible();
});
