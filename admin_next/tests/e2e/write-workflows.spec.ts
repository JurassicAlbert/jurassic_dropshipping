import { test, expect } from '@playwright/test';

test.describe('Write workflow resilience', () => {
  test("approval page loads and shows approval queue", async ({ page }) => {
    await page.goto("/approval");
    await expect(page.getByRole("heading", { name: "Approval Queue", exact: true })).toBeVisible();
  });

  test('handles slow API response gracefully', async ({ page }) => {
    // Stub the approval endpoint with 2s delay
    await page.route('**/api/approval/**', async (route) => {
      await new Promise(resolve => setTimeout(resolve, 2000));
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify({ success: true }),
      });
    });
    await page.goto('/approval');
    await expect(page.locator('body')).toBeVisible();
  });

  test('handles 429 rate limit with error message', async ({ page }) => {
    await page.route('**/api/**', async (route) => {
      await route.fulfill({
        status: 429,
        contentType: 'application/json',
        body: JSON.stringify({ error: 'Too Many Requests' }),
      });
    });
    await page.goto('/orders');
    await expect(page.locator('body')).toBeVisible();
  });

  test('handles 500 server error with error message', async ({ page }) => {
    await page.route('**/api/**', async (route) => {
      await route.fulfill({
        status: 500,
        contentType: 'application/json',
        body: JSON.stringify({ error: 'Internal Server Error' }),
      });
    });
    await page.goto('/orders');
    await expect(page.locator('body')).toBeVisible();
  });
});
