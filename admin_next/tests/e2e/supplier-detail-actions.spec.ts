import { expect, test } from "@playwright/test";

test.describe("Supplier detail route-scoped actions", () => {
  test("Supplier detail pre-fills policy supplier id from route", async ({ page }) => {
    await page.goto("/suppliers/parity-test-supplier");
    await expect(page.getByRole("heading", { name: "Supplier Detail: parity-test-supplier", exact: true })).toBeVisible();
    await expect(page.getByLabel("Supplier ID")).toHaveValue("parity-test-supplier");
    await expect(page.getByRole("button", { name: "Save policy" })).toBeVisible();
  });
});

