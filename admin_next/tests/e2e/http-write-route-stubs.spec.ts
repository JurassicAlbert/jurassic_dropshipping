import { expect, test } from "@playwright/test";

/**
 * Requires a production build with NEXT_PUBLIC_ADMIN_TRANSPORT=http so the UI uses
 * HttpTransport (browser fetch to /api/...). Run: npm run test:e2e:http-writes
 *
 * Stubs explicit write paths with latency or 429 + minimal GET payloads so pages load
 * without a live Dart API (approval POST, incidents PATCH, return-policies POST).
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

  const incidentOpen = {
    id: 501,
    orderId: "ord_1",
    incidentType: "customerReturn14d",
    status: "open",
    trigger: "manual",
    automaticDecision: null,
    supplierInteraction: null,
    marketplaceInteraction: null,
    refundAmount: null,
    financialImpact: null,
    decisionLogId: null,
    createdAt: "2026-01-01T00:00:00.000Z",
    resolvedAt: null,
    attachmentIds: null,
  };

  const incidentResolved = {
    ...incidentOpen,
    status: "resolved",
    resolvedAt: "2026-01-02T00:00:00.000Z",
  };

  test("incidents process: slow PATCH keeps Processing visible until response", async ({ page }) => {
    let patchDone = false;

    await page.route(/.*\/api\/incidents(?:\/\d+)?(?:\?.*)?$/, async (route) => {
      const url = new URL(route.request().url());
      const path = url.pathname;
      const method = route.request().method();
      const isListGet = method === "GET" && path === "/api/incidents";
      const isProcessPatch = method === "PATCH" && /^\/api\/incidents\/\d+$/.test(path);

      if (isListGet) {
        await route.fulfill({
          status: 200,
          contentType: "application/json",
          body: JSON.stringify({
            rows: patchDone ? [incidentResolved] : [incidentOpen],
          }),
        });
        return;
      }
      if (isProcessPatch) {
        await new Promise((r) => setTimeout(r, 2000));
        patchDone = true;
        await route.fulfill({
          status: 200,
          contentType: "application/json",
          body: JSON.stringify({ incident: incidentResolved }),
        });
        return;
      }
      await route.continue();
    });

    await page.goto("/incidents");
    const processBtn = page.getByRole("button", { name: "Process" }).first();
    await expect(processBtn).toBeEnabled();
    await processBtn.click();
    await expect(page.getByText("Processing...").first()).toBeVisible();
    await expect(processBtn).toBeDisabled();
    await expect(page.getByText("Processing...")).toHaveCount(0, { timeout: 25_000 });
  });

  test("incidents process: 429 PATCH shows warning and clears transition", async ({ page }) => {
    await page.route(/.*\/api\/incidents(?:\/\d+)?(?:\?.*)?$/, async (route) => {
      const url = new URL(route.request().url());
      const path = url.pathname;
      const method = route.request().method();
      const isListGet = method === "GET" && path === "/api/incidents";
      const isProcessPatch = method === "PATCH" && /^\/api\/incidents\/\d+$/.test(path);

      if (isListGet) {
        await route.fulfill({
          status: 200,
          contentType: "application/json",
          body: JSON.stringify({ rows: [incidentOpen] }),
        });
        return;
      }
      if (isProcessPatch) {
        await route.fulfill({
          status: 429,
          contentType: "application/json",
          body: JSON.stringify({ error: "Too Many Requests" }),
        });
        return;
      }
      await route.continue();
    });

    await page.goto("/incidents");
    const processBtn = page.getByRole("button", { name: "Process" }).first();
    await processBtn.click();
    await expect(page.getByText(/Failed to process incident \(429\)/)).toBeVisible();
    await expect(page.getByText("Processing...")).toHaveCount(0);
    await expect(processBtn).toBeEnabled();
  });

  const savedPolicy = {
    supplierId: "sup_1",
    policyType: "returnWindow",
    returnWindowDays: 14,
    restockingFeePercent: 5,
    returnShippingPaidBy: "supplier",
    requiresRma: false,
    warehouseReturnSupported: true,
    virtualRestockSupported: false,
  };

  test("return policies: slow POST keeps Save policy in processing until response", async ({ page }) => {
    let postDone = false;

    await page.route(
      (url) => url.pathname === "/api/return-policies",
      async (route) => {
        const method = route.request().method();
        if (method === "GET") {
          await route.fulfill({
            status: 200,
            contentType: "application/json",
            body: JSON.stringify({ rows: postDone ? [savedPolicy] : [] }),
          });
          return;
        }
        if (method === "POST") {
          await new Promise((r) => setTimeout(r, 2000));
          postDone = true;
          await route.fulfill({
            status: 200,
            contentType: "application/json",
            body: JSON.stringify({ policy: savedPolicy }),
          });
          return;
        }
        await route.continue();
      },
    );

    await page.goto("/return-policies");
    const saveCta = page.getByRole("button", { name: /Save policy|Processing/ });
    await expect(saveCta).toBeEnabled();
    await saveCta.click();
    const busySave = page.locator("button").filter({ hasText: /^Processing\.\.\.$/ });
    await expect(busySave).toBeVisible({ timeout: 15_000 });
    await expect(busySave).toBeDisabled();
    await expect(page.getByRole("button", { name: "Save policy" })).toBeEnabled({ timeout: 25_000 });
  });

  test("return policies: 429 POST shows warning and clears transition", async ({ page }) => {
    await page.route(
      (url) => url.pathname === "/api/return-policies",
      async (route) => {
        const method = route.request().method();
        if (method === "GET") {
          await route.fulfill({
            status: 200,
            contentType: "application/json",
            body: JSON.stringify({ rows: [] }),
          });
          return;
        }
        if (method === "POST") {
          await route.fulfill({
            status: 429,
            contentType: "application/json",
            body: JSON.stringify({ error: "Too Many Requests" }),
          });
          return;
        }
        await route.continue();
      },
    );

    await page.goto("/return-policies");
    const saveCta = page.getByRole("button", { name: /Save policy|Processing/ });
    await saveCta.click();
    await expect(page.getByText(/Failed to save return policy \(429\)/)).toBeVisible();
    await expect(page.getByRole("button", { name: "Save policy" })).toBeEnabled();
  });
});
