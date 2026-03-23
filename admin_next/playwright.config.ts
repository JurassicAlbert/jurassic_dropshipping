import { defineConfig, devices } from "@playwright/test";

function e2ePort(): string {
  if (process.env.PLAYWRIGHT_PORT) return process.env.PLAYWRIGHT_PORT;
  const b = process.env.PLAYWRIGHT_BASE_URL;
  if (b) {
    try {
      const p = new URL(b).port;
      if (p) return p;
    } catch {
      /* ignore */
    }
  }
  return "3001";
}

const port = e2ePort();
const baseURL = process.env.PLAYWRIGHT_BASE_URL ?? `http://127.0.0.1:${port}`;

export default defineConfig({
  testDir: "./tests/e2e",
  timeout: 30_000,
  retries: 1,
  /**
   * Starts `next start` before E2E so you don’t need a second terminal.
   * Requires `npm run build` first (`.next` must exist).
   * Locally: if something already answers on `baseURL`, Playwright reuses it.
   * If you get EADDRINUSE on 3001, stop the other process or set PLAYWRIGHT_PORT=3002 (and matching PLAYWRIGHT_BASE_URL).
   */
  webServer: {
    command: `npx next start -p ${port}`,
    url: baseURL,
    reuseExistingServer: process.env.CI !== "true",
    timeout: 120_000,
  },
  use: {
    baseURL,
    trace: "on-first-retry",
  },
  projects: [
    {
      name: "chromium",
      use: { ...devices["Desktop Chrome"] },
    },
  ],
});
