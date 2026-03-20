import { expect, test } from "@playwright/test";

test("orders supports sort, search, quick chips, and pagination", async ({ page }) => {
  await page.goto("/orders");

  await expect(page.getByRole("heading", { name: "Orders", exact: true })).toBeVisible();
  await page.getByLabel("Search orders").fill("ord_");
  await page.getByRole("button", { name: "Failed orders" }).click();

  const orderHeader = page.locator("table thead").getByRole("button", { name: "Order", exact: true });
  await orderHeader.click();
  await orderHeader.click();

  await page.getByLabel("Rows per page:").click();
  await page.getByRole("option", { name: "50" }).click();
});

