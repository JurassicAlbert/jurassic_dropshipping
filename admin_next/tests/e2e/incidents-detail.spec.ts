import { expect, test } from "@playwright/test";

test("Incidents detail renders row when API returns incident", async ({ page }) => {
  await page.route("**/api/incidents/42", async (route) => {
    await route.fulfill({
      status: 200,
      contentType: "application/json",
      body: JSON.stringify({
        summary: { id: 42, orderId: "ORD-42" },
        rows: [
          {
            id: 42,
            orderId: "ORD-42",
            incidentType: "delay",
            status: "open",
            trigger: "manual",
            financialImpact: 0,
            createdAt: "2026-01-01T00:00:00.000Z",
            resolvedAt: null,
          },
        ],
        placeholder: false,
      }),
    });
  });

  await page.goto("/incidents/42");
  await expect(page.getByRole("heading", { name: "Incident 42", exact: true })).toBeVisible();
  await expect(page.getByText("rows: 1")).toBeVisible();
  await expect(page.getByRole("cell", { name: "ORD-42" })).toBeVisible();
});

test("Incidents detail shows placeholder hint when API returns 404", async ({ page }) => {
  await page.route("**/api/incidents/404", async (route) => {
    await route.fulfill({
      status: 404,
      contentType: "application/json",
      body: JSON.stringify({ error: "not_found" }),
    });
  });

  await page.goto("/incidents/404");
  await expect(page.getByRole("heading", { name: "Incident 404", exact: true })).toBeVisible();
  await expect(page.getByText("rows: 0")).toBeVisible();
  await expect(page.getByText(/Live API unavailable|Could not reach API/i)).toBeVisible();
});

