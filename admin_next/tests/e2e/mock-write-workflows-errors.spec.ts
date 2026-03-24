import { expect, test, type Page } from "@playwright/test";

/**
 * Make requestId deterministic so mock `shouldFail(kind, requestId)` can be exercised on demand.
 * reqId format: `${prefix}-${Date.now()}-${Math.random().toString(36).slice(2,8)}`
 */
async function forceRequestId(page: Page, timestamp: number) {
  await page.addInitScript(({ ts }) => {
    Date.now = () => ts;
    Math.random = () => 0.123456; // -> "4fzyo8"
  }, { ts: timestamp });
}

test.describe("Mock write workflows deterministic error paths", () => {
  test("Incidents process shows alert and clears transition on failure", async ({ page }) => {
    // incidentProcessExternal fails for: inc-process-1700000000050-4fzyo8
    await forceRequestId(page, 1700000000050);
    await page.goto("/incidents");
    const openRow = page.locator("tr", { hasText: "open" }).first();
    await openRow.getByRole("button", { name: "Process" }).click();
    await expect(page.getByText("Incident resolved, but external notification failed")).toBeVisible();
    await expect(page.getByText("Processing...")).toHaveCount(0);
  });

  test("Risk refresh listing health failure shows alert and re-enables button", async ({ page }) => {
    // riskRefresh fails for: risk-health-1700000000014-4fzyo8
    await forceRequestId(page, 1700000000014);
    await page.goto("/risk-dashboard");
    await page.getByRole("button", { name: "Refresh listing health" }).click();
    await expect(page.getByText("Risk refresh failed (mock transient)")).toBeVisible();
    await expect(page.getByRole("button", { name: "Refresh listing health" })).toBeEnabled();
  });

  test("Returns save partial failure shows alert and clears transition", async ({ page }) => {
    // returnedStockInsert fails for: returns-save-1700000000052-4fzyo8
    await forceRequestId(page, 1700000000052);
    await page.goto("/returns");
    await page.getByRole("button", { name: "Edit" }).first().click();
    await page.locator('[role="combobox"]').first().click();
    await page.getByRole("option", { name: "received" }).click();
    await page.getByRole("button", { name: "Add to returned stock on save" }).click();
    await page.getByRole("button", { name: "Save", exact: true }).click();
    await expect(page.getByText("Returned stock insert failed after return update")).toBeVisible();
    await expect(page.getByText("Processing...")).toHaveCount(0);
  });

  test("Returns save failure re-enables Save button after transition clears", async ({ page }) => {
    // returnedStockInsert fails for: returns-save-1700000000052-4fzyo8
    await forceRequestId(page, 1700000000052);
    await page.goto("/returns");
    await page.getByRole("button", { name: "Edit" }).first().click();
    await page.locator('[role="combobox"]').first().click();
    await page.getByRole("option", { name: "received" }).click();
    await page.getByRole("button", { name: "Add to returned stock on save" }).click();
    const save = page.getByRole("button", { name: "Save", exact: true });
    await save.click();
    await expect(page.getByText("Returned stock insert failed after return update")).toBeVisible();
    await expect(page.getByText("Processing...")).toHaveCount(0);
    await expect(save).toBeEnabled();
  });
});

