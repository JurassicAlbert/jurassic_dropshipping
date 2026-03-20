import { expect, test } from "@playwright/test";

test("dashboard shell renders and navigates to new parity pages", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByText("Jurassic Admin")).toBeVisible();
  await page.getByRole("link", { name: "Marketplaces" }).click();
  await expect(page.getByText("Marketplaces", { exact: true })).toBeVisible();
  await page.getByRole("link", { name: "Approval" }).click();
  await expect(page.getByText("Approval Queue", { exact: true })).toBeVisible();
});

