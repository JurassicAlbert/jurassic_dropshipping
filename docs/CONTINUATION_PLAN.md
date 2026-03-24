# Continuation plan (tracked in repo)

**Purpose:** Step-by-step follow-up after admin parity + tests — CI, local E2E, docs (p15), KPI placeholders (p11/p13), incident detail API, test matrix (p18).

**How to use:** Work top to bottom; check boxes in PRs or locally. Link: [`JURASIC_BACKLOG_CHECKLIST.md`](JURASIC_BACKLOG_CHECKLIST.md).

---

## Step 1 — CI parity (GitHub `admin-next-tests`)

- [ ] Push / open PR to `main` and confirm workflow **admin-next-tests** passes (`lint` → `test` → `build` → Playwright `test:e2e`).
- [ ] If E2E fails: ensure `CI=true` in job (starts `next start` via Playwright `webServer`); fix port conflicts only on self-hosted runners.
- [x] Local CI-parity verification completed on 2026-03-04: `npm run lint`, `npm run test`, `npm run build`, and Playwright E2E (37 passed) with `PLAYWRIGHT_PORT=3002` due to occupied `3001`.

**Local equivalent (before every PR touching `admin_next/`):**

```bash
cd admin_next
npm run lint
npm run test
npm run build
npm run test:e2e:full
# or: npm run test:e2e  (if already built; use PLAYWRIGHT_PORT if 3001 busy — see README)
```

---

## Step 2 — p15 Doc audit (9 docs)

Tracked in [`P15_DOC_AUDIT_CHECKLIST.md`](P15_DOC_AUDIT_CHECKLIST.md). Reconcile each with current `lib/` + `admin_next/`; update [`TEST_TRACEABILITY_MATRIX.md`](TEST_TRACEABILITY_MATRIX.md) rows when APIs/routes change.

---

## Step 3 — p11 / p13 (Customer messaging & Market / listing KPIs)

- [x] **p11** — Placeholder card + `data-testid="analytics-p11-customer-messaging"`; full metrics when messaging feeds exist (`customerMessaging.hasData` / notes).
- [x] **p13** — Placeholder card + `data-testid="analytics-p13-market-listing"`; competitiveness/conversion when marketplace feeds exist.

Covered in Playwright `dashboard-payload.spec.ts` (stubbed `/api/dashboard`).

---

## Step 4 — Incident detail (Next + Dart)

- [x] Next route `/incidents/[id]` + proxy `GET /api/incidents/:id` → Dart `GET /incidents/:id`.
- [x] Dart dashboard server: `_computeIncidentDetailPayload` — one row + summary or 404 (`tool/dashboard_api_server_dart_main.dart`).
- [x] Next UI: `LiveDataTablePage` on incident detail (same shape as list payload).
- [x] **HTTP transport mode:** `incidentsGetIncident` in `httpTransport.ts` calls `GET /api/incidents/:id` (Dart dashboard API) — see `httpTransport.incidents.test.ts`.

---

## Step 5 — p18 Tests & matrix

- [x] Vitest: Flutter→Next route file parity (`flutterParityRoutes.test.ts`).
- [x] Playwright: `flutter-parity-routes.spec.ts`, `admin-functionality.spec.ts`, `dashboard-payload.spec.ts`.
- [ ] Extend E2E when new API routes or write paths ship; keep [`TEST_TRACEABILITY_MATRIX.md`](TEST_TRACEABILITY_MATRIX.md) in sync.

---

## Step 6 — Transition-first write UX (clarity over instant flips)

- [x] Approval actions: animated transition state (`Processing...`) before final success/error.
- [x] Returns save: animated transition state with rollback-safe error handling.
- [x] Incidents process: animated transition state before success/error.
- [x] Unit tests for transition behavior and failure outcomes: `MockWriteWorkflowPanels.test.tsx`.
- [x] Extended transition-state pattern to capital adjustment, return policy save, and supplier reliability refresh actions (with unit tests).
- [x] Extended transition-state pattern to risk refresh actions (`listingHealth`, `customerMetrics`) and added tests.

---

## Related

- [`ADMIN_NEXT_CONTINUATION.md`](ADMIN_NEXT_CONTINUATION.md) — env, transport, commands.
- [`admin_next/README.md`](../admin_next/README.md) — Testing section.
