import { expect, test } from "@playwright/test";

test("dashboard shell renders and navigates to new parity pages", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByText("Jurasic Admin")).toBeVisible();
  await page.getByRole("link", { name: "Marketplaces" }).click();
  await expect(page.getByRole("heading", { name: "Marketplaces", exact: true })).toBeVisible();
  await page.getByRole("link", { name: "Approval" }).click();
  await expect(page.getByRole("heading", { name: "Approval Queue", exact: true })).toBeVisible();
});

