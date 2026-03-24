import { expect, test } from "@playwright/test";

/**
 * Requires a production build with NEXT_PUBLIC_ADMIN_TRANSPORT=http so the UI uses
 * HttpTransport (browser fetch to /api/...). Run: npm run test:e2e:http-writes
 *
 * Stubs explicit write paths (POST) with latency or 429; GET /api/approval is fulfilled
 * so the approval panel can load without a live Dart API.
 */

const listingPending = {
  id: "L1",
  status: "pendingApproval",
  productId: "p1",
  targetPlatformId: "t1",
  sellingPrice: 10,
  sourceCost: 5,
  variantId: null as string | null,
};

const listingApproved = {
  ...listingPending,
  status: "active",
};

test.describe("@httpWrites HTTP write route stubs", () => {
  test.describe.configure({ timeout: 60_000 });

  test("approval approve: slow POST keeps Processing visible until response", async ({ page }) => {
    let postApproveDone = false;

    await page.route("**/api/approval", async (route) => {
      if (route.request().method() !== "GET") {
        await route.continue();
        return;
      }
      await route.fulfill({
        status: 200,
        contentType: "application/json",
        body: JSON.stringify({
          pendingListings: postApproveDone ? [] : [listingPending],
          pendingOrders: [],
        }),
      });
    });

    await page.route("**/api/approval/listings/**/approve", async (route) => {
      if (route.request().method() !== "POST") {
        await route.continue();
        return;
      }
      await new Promise((r) => setTimeout(r, 2000));
      postApproveDone = true;
      await route.fulfill({
        status: 200,
        contentType: "application/json",
        body: JSON.stringify({ listing: listingApproved }),
      });
    });

    await page.goto("/approval");
    const approve = page.getByRole("button", { name: "Approve" }).first();
    await expect(approve).toBeEnabled();
    await approve.click();
    await expect(page.getByText("Processing...").first()).toBeVisible();
    await expect(approve).toBeDisabled();
    await expect(page.getByText("Processing...")).toHaveCount(0, { timeout: 25_000 });
  });

  test("approval approve: 429 POST shows warning and clears transition", async ({ page }) => {
    await page.route("**/api/approval", async (route) => {
      if (route.request().method() !== "GET") {
        await route.continue();
        return;
      }
      await route.fulfill({
        status: 200,
        contentType: "application/json",
        body: JSON.stringify({
          pendingListings: [listingPending],
          pendingOrders: [],
        }),
      });
    });

    await page.route("**/api/approval/listings/**/approve", async (route) => {
      if (route.request().method() !== "POST") {
        await route.continue();
        return;
      }
      await route.fulfill({
        status: 429,
        contentType: "application/json",
        body: JSON.stringify({ error: "Too Many Requests" }),
      });
    });

    await page.goto("/approval");
    const approve = page.getByRole("button", { name: "Approve" }).first();
    await approve.click();
    await expect(page.getByText(/Failed to approve listing \(429\)/)).toBeVisible();
    await expect(page.getByText("Processing...")).toHaveCount(0);
    await expect(approve).toBeEnabled();
  });
});
