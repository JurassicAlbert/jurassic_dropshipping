# Continuation plan (tracked in repo)

**Purpose:** Step-by-step follow-up after admin parity + tests — CI, local E2E, docs (p15), KPI placeholders (p11/p13), incident detail API, test matrix (p18).

**How to use:** Work top to bottom; check boxes in PRs or locally. Link: [`JURASIC_BACKLOG_CHECKLIST.md`](JURASIC_BACKLOG_CHECKLIST.md).

## Execution rules (must follow)

- [ ] **TDD-first default:** before implementation changes, add or update failing tests first (Vitest/Playwright as applicable), then implement, then re-run and pass.
- [ ] **Verification gate per step:** each completed step must include the relevant test run command/result in commit notes or execution report.
- [ ] **One-by-one execution:** do not start the next step until the current step is marked complete or explicitly deferred with reason.

---

## Step 1 — CI parity (GitHub `admin-next-tests`)

- [x] Push / open PR to `main` and confirm workflow **admin-next-tests** passes (`lint` → `test` → `build` → Playwright `test:e2e`).
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
- [x] Extend E2E when new API routes or write paths ship; keep [`TEST_TRACEABILITY_MATRIX.md`](TEST_TRACEABILITY_MATRIX.md) in sync (transition-state + deterministic error specs added).

---

## Step 6 — Transition-first write UX (clarity over instant flips)

- [x] Approval actions: animated transition state (`Processing...`) before final success/error.
- [x] Returns save: animated transition state with rollback-safe error handling.
- [x] Incidents process: animated transition state before success/error.
- [x] Unit tests for transition behavior and failure outcomes: `MockWriteWorkflowPanels.test.tsx`.
- [x] Extended transition-state pattern to capital adjustment, return policy save, and supplier reliability refresh actions (with unit tests).
- [x] Extended transition-state pattern to risk refresh actions (`listingHealth`, `customerMetrics`) and added tests.

---

## Step 7 — Write-path E2E reliability expansion (TDD-first)

- [x] Add transition-state and deterministic error-path specs for write workflows.
- [x] Add repeat-click/disabled-state coverage for pending write actions.
- [x] Add failure-path assertion that transition clears and controls re-enable.
- [x] Add explicit route-stub latency/429 scenarios when HTTP write routes are introduced (`tests/e2e/http-write-route-stubs.spec.ts` — approval POST, incidents PATCH, return-policies POST, returns PATCH + `POST .../compute-routing`, capital adjust POST, supplier reliability refresh POST; `npm run test:e2e:http-writes`; CI rebuilds with `NEXT_PUBLIC_ADMIN_TRANSPORT=http`).

---

## Step 8 — Supplier detail parity (`/suppliers/[id]`)

- [x] Add route-scoped supplier policy action block on detail page.
- [x] Prefill policy supplier ID from route param (`initialSupplierId`) and keep editable.
- [x] Add TDD coverage:
  - Vitest: `MockWriteWorkflowPanels.test.tsx` route-scoped prefill assertion.
  - Playwright: `tests/e2e/supplier-detail-actions.spec.ts`.

---

## Step 9 — HTTP write wiring (incremental, test-first)

- [x] Add proxy `POST` support for allowed API paths (`app/api/[...proxy]/route.ts`) with test coverage.
- [x] Wire `HttpTransport.policiesUpsert` to `POST /api/return-policies` with Vitest coverage.
- [x] Add Dart dashboard API write handler for `POST /return-policies` (upsert + response payload).
- [x] Wire `HttpTransport.incidentsCreateIncident` to `POST /api/incidents` with Vitest coverage.
- [x] Add Dart dashboard API write handler for `POST /incidents` (insert + response payload).
- [x] Wire `HttpTransport.incidentsProcessIncident` to `PATCH /api/incidents/:id` with Vitest coverage.
- [x] Add proxy `PATCH` support and Dart dashboard API write handler for incident resolve (`PATCH /incidents/:id`).
- [x] Wire `HttpTransport.returnsUpdateReturn` to `PATCH /api/returns/:id` with Vitest coverage.
- [x] Wire `HttpTransport.returnsComputeRouting` to `POST /api/returns/:id/compute-routing` (Vitest + Dart `POST /returns/{id}/compute-routing` using `ReturnRoutingService`).
- [x] Add Dart dashboard API write handler for return updates (`PATCH /returns/:id`) returning updated row shape.
- [x] Wire `HttpTransport.capitalRecordAdjustment` to `POST /api/capital/adjust` with Vitest coverage.
- [x] Add Dart dashboard API write handler for capital adjustments (`POST /capital/adjust`) returning balance + ledger entry id.
- [x] Wire `HttpTransport.suppliersRefreshReliabilityScores` to `POST /api/suppliers/reliability/refresh` with Vitest coverage.
- [x] Add Dart dashboard API write handler for supplier reliability refresh (`POST /suppliers/reliability/refresh`).
- [x] Wire `HttpTransport.riskRefreshListingHealth` to `POST /api/risk/listing-health/refresh` with Vitest coverage.
- [x] Wire `HttpTransport.riskRefreshCustomerMetrics` to `POST /api/risk/customer-metrics/refresh` with Vitest coverage.
- [x] Add proxy support for nested `/api/risk/...` routes and Dart dashboard API write handlers for both risk refresh endpoints.
- [x] Wire approval write actions in `HttpTransport` (`approve/reject listing`, `approve/reject order`) with Vitest coverage.
- [x] Add Dart dashboard API write handlers for approval actions (`POST /approval/listings/:id/{approve|reject}`, `POST /approval/orders/:id/{approve|reject}`).
- [x] Continue incremental migration of remaining write actions from mock-only to HTTP where backend routes exist.

---

## Step 10 — Stress / retest (mock transport, Vitest)

- [x] Concurrent approval writes (listings + mixed listing/order) complete without hang; idempotent parallel requestIds converge.
- [x] Second wave of approvals on non-pending rows returns deterministic conflicts (no deadlock).
- [x] Long sequential return updates keep row state consistent.
- [x] After `returnedStockInsert` partial failure, retry with a new requestId that passes `shouldFail` can insert returned stock (`mockWriteStress.test.ts`).

---

## Related

- [`ADMIN_NEXT_CONTINUATION.md`](ADMIN_NEXT_CONTINUATION.md) — env, transport, commands.
- [`admin_next/README.md`](../admin_next/README.md) — Testing section.

