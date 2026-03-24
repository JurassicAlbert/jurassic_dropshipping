# Deployment and runbook

How to run Jurasic Dropshipping in a production-like environment and operate it day to day.

## Build

- **Android:** `flutter build apk` (or `flutter build appbundle` for Play Store). Output under `build/app/outputs/`.
- **Web:** `flutter build web`. Serve the `build/web` directory (static files). For persistence, serve with appropriate headers (COOP/COEP if using shared-array-buffer for Drift WASM).
- **Desktop (Windows/macOS/Linux):** `flutter build windows` / `macos` / `linux`. Run the executable from `build/windows/runner/Release/` (or equivalent).
- **Next.js admin (`admin_next/`):** `npm ci && npm run build && npm run start` (or deploy to a Node host). Set `DART_API_BASE_URL` (or run `dart run tool/dashboard_api_server_dart_main.dart`) so the proxy can reach the API. CI runs `lint`, `vitest`, `next build`, and Playwright against `admin_next` (see `.github/workflows/ci.yml`), with Playwright `webServer` starting Next in CI mode.

## Run (production mode)

- **Mobile/desktop:** Run the built binary. No separate server is required; the app embeds the database and runs the automation scheduler in-process (scan, order sync, price refresh, background job processing).
- **Web:** Deploy `build/web` to any static host (e.g. Firebase Hosting, Netlify, or your own server). Ensure HTTPS. Credentials (Allegro, CJ, API2Cart) are stored in the browser’s secure storage (e.g. localStorage / IndexedDB per Flutter web); clearing site data clears credentials.

## Data and state

- **SQLite:** The app uses a single SQLite file. On desktop/mobile its path is platform-specific (e.g. app data directory). On web, Drift uses WASM SQLite; data lives in the origin’s storage (can be cleared with site data).
- **Migrations:** Schema version is in `lib/data/database/app_database.dart` (`schemaVersion`). On first run or after an upgrade, Drift runs migrations automatically. Backup the SQLite file (or export critical tables) before major upgrades if you need rollback.
- **Secrets:** API keys and tokens are in Flutter secure storage (platform keychain/Keystore on mobile/desktop; web uses the same secure storage abstraction). Do not commit `.env` or any file containing keys.

## Automation (jobs)

- **In-app scheduler:** The [AutomationScheduler](lib/services/automation_scheduler.dart) runs inside the app process. When the app is running, it:
  - Runs **scan** and **price refresh** on timers (intervals from rules).
  - Runs **order sync** from targets (Allegro, Temu), then enqueues **fulfill_order** jobs for pending orders.
  - Processes the **background job queue** (scan, fulfill_order, price_refresh) every few seconds (see `processUntilEmpty`).
- **No separate worker process:** The current design does not use a separate worker binary. To run jobs 24/7, keep the app running (e.g. desktop app on a server, or a long-lived web tab — not ideal for production). For a dedicated worker, you would run a second process (or backend service) that shares the same DB and processes jobs; that’s outside this runbook.

## Health and limits

- **No API tokens:** If Allegro/CJ/API2Cart credentials are not set, the app and scheduler still run; sync/refresh/scan complete with zero calls (see [no-token-safe automation](no-token-safe_automation_plan.md) and `isConfigured()` in services).
- **Billing:** Plan and usage (listings count, orders this month) are enforced; over limit blocks new listings and shows upgrade in Settings.
- **Rate limits:** Per-platform rate limiters (from rules) throttle API calls. Distributed lock prevents double-fulfill of the same order when multiple processors are used.

## Optional: Docker

To run the app in Docker you would typically:

1. Use a Flutter Docker image (e.g. multi-stage: build with Flutter, run with a minimal runtime) or build the app on the host and copy the built artifact into an image.
2. For **web:** build with `flutter build web`, then serve `build/web` with nginx or another static server in the image.
3. For **desktop:** build for the target OS (e.g. `flutter build linux`) and run the binary in a matching Linux image; ensure a display or headless setup if needed.
4. Mount a volume for the SQLite file (or use a PostgreSQL connection if you migrate to Postgres + RLS; see [POSTGRES_RLS_MIGRATION.md](POSTGRES_RLS_MIGRATION.md)).

A **web** image is provided: [Dockerfile.web](../Dockerfile.web) builds Flutter web and serves it with nginx. Build and run:

```bash
docker build -f Dockerfile.web -t jurassic-web .
docker run -p 80:80 jurassic-web
```

For COOP/COEP (if needed for Drift WASM), add a custom `nginx.conf` and uncomment the COPY line in the Dockerfile.

## Checklist (go-live)

- [ ] Build for target platform(s).
- [ ] Configure credentials in app Settings (Allegro OAuth, CJ, API2Cart as needed).
- [ ] Set rules (search keywords, min profit, approval flags, intervals).
- [ ] Optionally run seed (Settings or first-time flow) to get default billing plan and sample data.
- [ ] Keep app (or worker) running for scheduled jobs, or run scan/sync manually when needed.
