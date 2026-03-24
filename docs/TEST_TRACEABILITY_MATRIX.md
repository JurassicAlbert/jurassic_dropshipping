# Test Traceability Matrix

This document maps business logic and product functionality to:
- backend implementation files
- Flutter/admin UI surfaces
- Next.js admin routes
- API endpoints
- required test suites

It is the single source for TP-A/TP-B/TP-C/TP-D planning and coverage tracking.

## Coverage status legend

- `DONE`: implemented and tested
- `PARTIAL`: implemented but incompletely tested or exposed
- `MISSING`: not yet exposed and/or not yet tested
- `PLACEHOLDER`: intentionally deferred until external API/warehouse integration is live

## Route and module inventory

### Flutter route baseline

Source: `lib/app_router.dart`

- `/dashboard`
- `/analytics`
- `/profit-dashboard`
- `/products`
- `/orders`
- `/suppliers`
- `/suppliers/:id`
- `/marketplaces`
- `/returns`
- `/incidents`
- `/incidents/:id`
- `/risk-dashboard`
- `/returned-stock`
- `/capital`
- `/approval`
- `/decision-log`
- `/return-policies`
- `/settings`
- `/how-it-works`

### Next admin route baseline (current)

Source: `admin_next/src/app/**/page.tsx`

- `/` (dashboard)
- `/analytics`, `/orders`, `/products`, `/suppliers`, `/suppliers/[id]`, `/settings`
- `/approval`, `/returns`, `/incidents`, `/incidents/[id]`, `/capital`, `/return-policies`, `/returned-stock`, `/risk-dashboard`, `/decision-log`, `/marketplaces`, `/profit-dashboard`, `/how-it-works`

**Handoff / next tasks:** [ADMIN_NEXT_CONTINUATION.md](./ADMIN_NEXT_CONTINUATION.md)

**KPI extended payload (p7–p14):** Dart `GET /dashboard` (`tool/dashboard_api_server_dart_main.dart`) returns `dashboardPayloadVersion: 2` with risk, capital, operations, supplier, health, jobs. Consumed by `admin_next/src/lib/dashboardApi.ts`. Flutter unit tests: `test/features/analytics/analytics_engine_kpi_test.dart`.

## Business logic -> UI/API/Test traceability

| Domain area | Key implementation files | Flutter route(s) | Next route(s) | Next API route(s) | TP-A white-box | TP-B admin UI | TP-C risk | TP-D logic availability | Status |
|---|---|---|---|---|---|---|---|---|---|
| Decision engine (scan/list/price/select) | `lib/domain/decision_engine/scanner.dart`, `listing_decider.dart`, `pricing_calculator.dart`, `supplier_selector.dart` | `/dashboard`, `/approval`, `/decision-log` | `/`, `/analytics` | `/api/dashboard` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Orders lifecycle | `lib/domain/post_order/post_order_lifecycle_engine.dart`, `lib/data/repositories/order_repository.dart` | `/orders`, `/approval`, `/returns`, `/incidents` | `/orders` | `/api/orders`, `/api/dashboard` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Risk scoring | `lib/domain/risk/order_risk_scoring_service.dart`, `lib/domain/listing_health/listing_health_scoring_service.dart` | `/risk-dashboard`, `/orders` | `/risk-dashboard`, `/orders`, `/analytics`, `/` | `/api/risk-dashboard`, `/api/orders`, `/api/dashboard` + mock refresh | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Returns and incidents | `lib/domain/post_order/incident_handling_engine.dart`, `return_routing_service.dart`, `lib/data/repositories/return_repository.dart` | `/returns`, `/incidents`, `/incidents/:id` | `/returns`, `/incidents`, `/incidents/[id]` | proxy `/api/returns`, `/api/incidents`, `/api/incidents/:id` (Dart dashboard API) + mock writes in `MockWriteWorkflowPanels` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Returned stock | `lib/data/repositories/returned_stock_repository.dart`, `lib/features/returned_stock/**` | `/returned-stock` | `/returned-stock` | proxy `/api/returned-stock` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Capital and ledger | `lib/domain/capital/capital_management_service.dart`, `lib/data/repositories/financial_ledger_repository.dart` | `/capital` | `/capital` | proxy `/api/capital` + mock writes | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Approval queue | `lib/features/approval/**`, repo/service integrations | `/approval` | `/approval` | proxy `/api/approval` + mock writes | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Decision log | `lib/data/repositories/decision_log_repository.dart`, `lib/features/decision_log/**` | `/decision-log` | `/decision-log` | proxy `/api/decision-log` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Suppliers and reliability | `lib/domain/supplier_reliability/**`, `lib/data/repositories/supplier_repository.dart` | `/suppliers`, `/suppliers/:id` | `/suppliers` | `/api/suppliers` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Products/listings margin health | `lib/data/repositories/product_repository.dart`, `listing_repository.dart` | `/products`, `/profit-dashboard` | `/products`, `/analytics`, `/` | `/api/products`, `/api/dashboard` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Marketplaces/accounts | `lib/data/repositories/marketplace_account_repository.dart`, `lib/features/marketplaces/**` | `/marketplaces` | `/marketplaces` | proxy `/api/marketplaces` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Return policies | `lib/data/repositories/supplier_return_policy_repository.dart`, `lib/features/return_policies/**` | `/return-policies` | `/return-policies` | proxy `/api/return-policies` + mock write panel | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Inventory/stock refresh | `lib/domain/inventory/**`, `lib/services/price_refresh_service.dart` | `/products`, `/orders`, `/returned-stock` | `/products`, `/orders` | `/api/products`, `/api/orders` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Messaging automation | `lib/services/messaging/customer_message_analyzer.dart`, `response_engine.dart` | Embedded in existing Flutter screens | N/A (not separate Next route yet) | N/A | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Settings/rules | `lib/data/repositories/rules_repository.dart`, `lib/features/settings/**` | `/settings` | `/settings` (stub) | N/A | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| How it works (functional explainability) | `lib/features/how_it_works/**` | `/how-it-works` | `/how-it-works` | proxy `/api/how-it-works` | REQUIRED | REQUIRED | OPTIONAL | REQUIRED | PARTIAL |

## Admin panel parity checklist (implementation work queue)

**Done (baseline):** Next pages + nav for `marketplaces`, `returns`, `incidents`, `risk-dashboard`, `returned-stock`, `capital`, `approval`, `decision-log`, `return-policies`, `how-it-works`, `profit-dashboard`, `suppliers/[id]`; dynamic proxy `admin_next/src/app/api/[...proxy]/route.ts`; mock write panels (`MockWriteWorkflowPanels`) for transport-backed actions.

**Done (write-path transition coverage):**

- Transition-first UX covered in unit tests: `admin_next/src/components/ops/MockWriteWorkflowPanels.test.tsx`
  - Approval actions (pending transition + error rollback-safe behavior)
  - Returns save (pending transition + failure message behavior)
  - Incidents process (pending transition + failure message behavior)
  - Capital adjustment / return policies save / supplier reliability + risk refresh transitions
- Playwright write-path transition and error coverage:
  - `admin_next/tests/e2e/mock-write-workflows-transitions.spec.ts`
  - `admin_next/tests/e2e/mock-write-workflows-errors.spec.ts`
- Incident detail read-path parity coverage:
  - Vitest route inventory: `admin_next/src/test/flutterParityRoutes.test.ts`
  - Playwright direct route parity: `admin_next/tests/e2e/flutter-parity-routes.spec.ts`

**Remaining:** See [ADMIN_NEXT_CONTINUATION.md](./ADMIN_NEXT_CONTINUATION.md) — HTTP write wiring, MSW expansion, Playwright write-path stress and failure permutations, and supplier-detail policy UX.

1. Wire **real HTTP writes** where Dart API exposes them (currently many writes are mock-only or `mkFailExternal` in `httpTransport.ts`).
2. Keep read-only **placeholders** from Dart API where integration is not live (`placeholder: true` in payloads when applicable).
3. Expand tests per TP-B/TP-C (see continuation doc).

## Test suite mapping (TP-A .. TP-E)

### TP-A: White-box 100% available functionality

- Extend Flutter/domain/service/repository tests to all modules listed above.
- Ensure branch/edge coverage for each decision/risk/financial workflow.

### TP-B: 100% admin functionality

- Add Next tests for each page and all controls:
  - render/load
  - filters/sort/pagination/search
  - action buttons and error states
  - data integrity against API responses

### TP-C: User risk coverage

- Add high-risk scenarios:
  - wrong approvals
  - false risk scores
  - incorrect profit/margin display
  - stale data presentation
  - destructive action safeguards
  - partial API outage behavior

### TP-D: Business logic availability in admin

- For each matrix row above, add an assertion that logic is surfaced in admin UI.
- If intentionally deferred, mark as `PLACEHOLDER` and add expected activation test.

### TP-E: Load validation

- Parameterized datasets:
  - low: 10-100 products
  - mid: 1,000 products
  - heavy: 100,000 products
- Validate:
  - API latency and stability
  - UI interaction responsiveness (filter/sort/pagination)
  - refresh cadence never exceeds warehouse refresh policy

## Placeholder test blocks (external integration pending)

- Warehouse connectors (feed/API) -> `PLACEHOLDER`
- External marketplace write API contracts -> `PLACEHOLDER`
- Token/credential refresh edge-cases in external systems -> `PLACEHOLDER`

## Automated test entry points

- Flutter: `flutter test` (see `test/**`, including `test/data/repositories/advanced_repositories_test.dart`)
- Admin: `admin_next` -> `npm run test`, `npm run test:e2e`, `npm run lint`, `npm run build`
- CI: `.github/workflows/ci.yml` (`admin-next-tests` job)
- Last recorded run: `docs/TEST_EXECUTION_REPORT.md`

## Execution log template (for run-fix-rerun phase)

Use this format after each full run:

- Date:
- Suites run:
- Passed:
- Failed:
- Top failures:
- Root causes:
- Fixes implemented:
- Re-run result:
- Remaining deferred placeholders:

