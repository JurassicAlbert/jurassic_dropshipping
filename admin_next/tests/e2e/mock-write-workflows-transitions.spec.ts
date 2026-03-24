import { expect, test } from "@playwright/test";

test.describe("Mock write workflows transition states", () => {
  test("Approval shows row transition while action is pending", async ({ page }) => {
    await page.goto("/approval");
    await expect(page.getByRole("button", { name: "Approve" }).first()).toBeEnabled();
    await page.getByRole("button", { name: "Approve" }).first().click();
    await expect(page.getByText("Processing...").first()).toBeVisible();
    await expect(page.getByRole("button", { name: "Approve" }).first()).toBeDisabled();
  });

  test("Returns save shows processing transition", async ({ page }) => {
    await page.goto("/returns");
    await page.getByRole("button", { name: "Edit" }).first().click();
    await page.locator('[role="combobox"]').first().click();
    await page.getByRole("option", { name: "approved" }).click();
    await page.getByRole("button", { name: "Save", exact: true }).click();
    await expect(page.getByText("Processing...").first()).toBeVisible();
  });

  test("Risk refresh buttons show distinct processing labels", async ({ page }) => {
    await page.goto("/risk-dashboard");
    await page.getByRole("button", { name: "Refresh listing health" }).click();
    await expect(page.getByRole("button", { name: "Processing listing health..." })).toBeVisible();
    await page.getByRole("button", { name: "Refresh customer metrics" }).click();
    await expect(page.getByRole("button", { name: "Processing customer metrics..." })).toBeVisible();
  });
});

