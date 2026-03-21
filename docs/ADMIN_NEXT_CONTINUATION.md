# Next.js admin — continuation guide (for agents & developers)

**Purpose:** Single handoff document so a web agent (or human) can resume work without relying on chat history. Last aligned with repo state: 2026-03-04.

## Quick orientation

| Item | Location |
|------|----------|
| Next.js app | `admin_next/` |
| Transport contract (reads + writes) | `admin_next/src/lib/adminTransport/` — `adminTransport.ts`, `types.ts` |
| Deterministic mock (no backend) | `admin_next/src/lib/adminTransport/mockTransportFixed.ts` |
| HTTP reads / stubbed writes | `admin_next/src/lib/adminTransport/httpTransport.ts` |
| Switch mock vs HTTP | `NEXT_PUBLIC_ADMIN_TRANSPORT` — see `getAdminTransport.ts` |
| Write UI panels (mock transport) | `admin_next/src/components/ops/MockWriteWorkflowPanels.tsx` |
| Generic read-only tables | `admin_next/src/components/ops/LiveDataTablePage.tsx` |
| Proxy to Dart API server | `admin_next/src/app/api/[...proxy]/route.ts` |
| Dart read API (local dev) | `tool/dashboard_api_server_dart_main.dart` (port often `4000`) |

## What is already implemented

- **Dashboard, analytics, orders, products, suppliers** with URL state: search, filters, sort, pagination, CSV export (where applicable).
- **Parity pages** (shell + data): `marketplaces`, `returns`, `incidents`, `risk-dashboard`, `returned-stock`, `capital`, `approval`, `decision-log`, `return-policies`, `profit-dashboard`, `how-it-works`, `suppliers/[id]`.
- **API proxy** for allowed paths to `DART_API_BASE_URL` / `http://127.0.0.1:4000`.
- **Mock write workflows** (in-memory, idempotent, failure injection): approval approve/reject, returns update + returned stock path, incidents create/process, capital adjustment, return policies upsert, supplier reliability refresh, risk refresh — all callable from `MockWriteWorkflowPanels` when transport is mock.
- **Tests:** Vitest (components, proxy, logic availability, load-shape synthetics), Playwright (navigation, admin headings, orders interactions, dashboard error stub). CI: `.github/workflows/ci.yml` job `admin-next-tests`.

## Follow-up work (priority order)

### 1. UI polish — `ui-write-workflows` (incomplete)

- **Auto-load:** Workflow panels in `MockWriteWorkflowPanels.tsx` do not `useEffect` on mount; users must click **Refresh**. Add initial load on mount (and keep manual refresh).
- **Optimistic updates:** Current pattern is *action → await transport → reload*. Optional: optimistic row state with rollback on failure (aligns with original plan).
- **Supplier detail (`/suppliers/[id]`):** Still `LiveDataTablePage` only. Consider transport-scoped policy edit or reliability actions for the **route `id`** (reuse patterns from `ReturnPoliciesWorkflowPanel` / `SupplierReliabilityAndRiskPanel`).
- **Duplicate panel:** `SupplierReliabilityAndRiskPanel` appears on both **Suppliers** and **Risk Dashboard** — acceptable; differentiate copy/primary CTA if UX asks for it.

### 2. MSW — `msw-handlers` (not started)

- Add `msw` as a dev dependency and handlers that mirror write endpoints (or mirror `AdminTransport` shapes) so component tests can assert **request schema** and **failure responses** without using in-memory `MockTransportFixed` only.
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
