# Next.js admin — continuation guide (for agents & developers)

**Purpose:** Single handoff document so a web agent (or human) can resume work without relying on chat history. Last aligned with repo state: 2026-03-04.

**Backlog p1–p18 (versioned checklist):** [JURASIC_BACKLOG_CHECKLIST.md](./JURASIC_BACKLOG_CHECKLIST.md) — use this in Git; Cursor plan files may live only under your local `.cursor/plans/`.

## Dashboard vs Profit Dashboard vs Analytics

| Route | Role |
|-------|------|
| **`/` (Dashboard)** | Executive overview: KPI row, 7d profit trend, signals, platform + margin band charts, issues, recent orders. |
| **`/profit-dashboard`** | **Financial drill-down:** same KPI row + **Recharts** for revenue / profit / margin over time (30d daily series), profit-by-listing bar, loss-making listings table, platform + margin bands. Data: `/api/dashboard` (Dart `AnalyticsEngine`). |
| **`/analytics`** | **Full KPI program (p7–p14):** same KPI row + risk/returns/incidents, capital strip, operations funnel, suppliers, product quality, system jobs, placeholders where data is N/A. Profit time-series stay on **Profit Dashboard** to avoid duplication. |

All three use **`useDashboardData()`** → `/api/dashboard` → Dart `GET /dashboard`. Extended fields (`dailyFinancialSeries`, `capital`, `supplierKpis`, `systemJobs`, etc.) are merged with the offline fallback when the API omits keys. **`dashboardPayloadVersion`** (e.g. `2`) is set by the Dart server when the full KPI payload is present.

## Quick orientation

| Item | Location |
|------|----------|
| Next.js app | `admin_next/` |
| Transport contract (reads + writes) | `admin_next/src/lib/adminTransport/` — `adminTransport.ts`, `types.ts` |
| Deterministic mock (no backend) | `admin_next/src/lib/adminTransport/mockTransportFixed.ts` |
| HTTP reads / stubbed writes | `admin_next/src/lib/adminTransport/httpTransport.ts` |
| Switch mock vs HTTP | `NEXT_PUBLIC_ADMIN_TRANSPORT` — see `getAdminTransport.ts` |
| Dashboard API debug logs | `NEXT_PUBLIC_SHOW_DASHBOARD_API_ERRORS=true` at **build** time — logs `console.warn` when `/api/dashboard` fails. UI uses a **muted** one-line hint + offline snapshot, not a loud error banner. |
| Write UI panels (mock transport) | `admin_next/src/components/ops/MockWriteWorkflowPanels.tsx` |
| Generic read-only tables | `admin_next/src/components/ops/LiveDataTablePage.tsx` |
| Proxy to Dart API server | `admin_next/src/app/api/[...proxy]/route.ts` |
| Dart read API (local dev) | `tool/dashboard_api_server_dart_main.dart` (port often `4000`) |

### Git Bash on Windows (paths)

In **Git Bash**, backslashes are interpreted oddly (`\t` = tab). From the repo root, use **forward slashes**:

```bash
ls tool/dashboard_api_server_dart_main.dart
dart run tool/dashboard_api_server_dart_main.dart
```

## What is already implemented

- **Dashboard, analytics, orders, products, suppliers** with URL state: search, filters, sort, pagination, CSV export (where applicable).
- **Parity pages** (shell + data): `marketplaces`, `returns`, `incidents`, `incidents/[id]` (`GET /api/incidents/:id` → Dart `GET /incidents/:id` when dashboard API runs), `risk-dashboard`, `returned-stock`, `capital`, `approval`, `decision-log`, `return-policies`, `profit-dashboard`, `how-it-works`, `suppliers/[id]`.
- **API proxy** for allowed paths to `DART_API_BASE_URL` / `http://127.0.0.1:4000`.
- **Mock write workflows** (in-memory, idempotent, failure injection): approval approve/reject, returns update + returned stock path, incidents create/process, capital adjustment, return policies upsert, supplier reliability refresh, risk refresh — all callable from `MockWriteWorkflowPanels` when transport is mock.
- **Tests:** Vitest (components, proxy, logic availability, Flutter→Next route parity file list, load-shape synthetics), Playwright (navigation, **direct URL parity** `flutter-parity-routes.spec.ts`, admin headings, orders interactions, dashboard stub). CI: `.github/workflows/ci.yml` job `admin-next-tests`.

## Follow-up work (priority order)

### 1. UI polish — `ui-write-workflows` (incomplete)

- **Auto-load:** Implemented. Workflow panels call `load()` on mount via `useEffect` and keep manual **Refresh**. Coverage: `admin_next/src/components/ops/MockWriteWorkflowPanels.test.tsx`.
- **Optimistic updates:** Current pattern is *action → await transport → reload*. Optional: optimistic row state with rollback on failure (aligns with original plan).
- **Supplier detail (`/suppliers/[id]`):** Still `LiveDataTablePage` only. Consider transport-scoped policy edit or reliability actions for the **route `id`** (reuse patterns from `ReturnPoliciesWorkflowPanel` / `SupplierReliabilityAndRiskPanel`).
- **Duplicate panel:** `SupplierReliabilityAndRiskPanel` appears on both **Suppliers** and **Risk Dashboard** — acceptable; differentiate copy/primary CTA if UX asks for it.

### 2. MSW — `msw-handlers`

- Dev dependency `msw` + stub handlers live under `admin_next/src/test/msw/handlers.ts` (Vitest / future component tests). Extend handlers when HTTP write routes are added.
- Target: Vitest + MSW for any future `fetch`-based write client; until HTTP writes exist, MSW can stub `PATCH/POST` under `/api/...` if you add Next route handlers.

### 3. Playwright — `playwright-route-stubs` (partial)

- Existing: `user-risk.spec.ts` stubs dashboard API.
- Add: **`page.route`** for write paths — latency, 429/500, concurrent clicks — and assert recovery messaging and final UI state.
- Extend coverage when writes are exposed via HTTP or MSW.

### 4. Stress / retest — `stress-retest-suite` (partial)

- `admin_next/src/perf/loadShapes.test.ts` covers client-side table ops at scale.
- Add: repeated **approve/reject / save** loops against **mock transport** (and optional failure injection) to verify no deadlock and stable state after partial failures (`shouldFail` paths in `mockTransportFixed.ts`).

### 5. CI — `ci-enablement` (verify)

- `admin-next-tests` runs lint, vitest, build, Playwright.
- Optional: separate job or env flag for **integration tests against live Dart API**; keep default CI **mock/offline-friendly**.

## Related docs (do not duplicate — link here)

- [NO_API_WRITE_WORKFLOW_CONTRACTS.md](./NO_API_WRITE_WORKFLOW_CONTRACTS.md) — request/response shapes and “next implementation steps” checklist.
- [TEST_TRACEABILITY_MATRIX.md](./TEST_TRACEABILITY_MATRIX.md) — TP-A..TP-E mapping (matrix rows updated as parity improves).
- [TEST_EXECUTION_REPORT.md](./TEST_EXECUTION_REPORT.md) — last full suite run log template.

## Commands (from repo root)

```bash
cd admin_next
npm ci
npm run lint
npm run test
npm run build
npm run test:e2e   # requires build + next start, see playwright.config / CI
```

## Env

- `NEXT_PUBLIC_ADMIN_TRANSPORT` — use mock fixed transport vs HTTP (see `getAdminTransport.ts`).
- `DART_API_BASE_URL` — base URL for Dart dashboard API when using HTTP reads / proxy.
