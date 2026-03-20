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

- `/`
- `/analytics`
- `/orders`
- `/products`
- `/suppliers`
- `/settings`

## Business logic -> UI/API/Test traceability

| Domain area | Key implementation files | Flutter route(s) | Next route(s) | Next API route(s) | TP-A white-box | TP-B admin UI | TP-C risk | TP-D logic availability | Status |
|---|---|---|---|---|---|---|---|---|---|
| Decision engine (scan/list/price/select) | `lib/domain/decision_engine/scanner.dart`, `listing_decider.dart`, `pricing_calculator.dart`, `supplier_selector.dart` | `/dashboard`, `/approval`, `/decision-log` | `/`, `/analytics` | `/api/dashboard` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Orders lifecycle | `lib/domain/post_order/post_order_lifecycle_engine.dart`, `lib/data/repositories/order_repository.dart` | `/orders`, `/approval`, `/returns`, `/incidents` | `/orders` | `/api/orders`, `/api/dashboard` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Risk scoring | `lib/domain/risk/order_risk_scoring_service.dart`, `lib/domain/listing_health/listing_health_scoring_service.dart` | `/risk-dashboard`, `/orders` | `/orders`, `/analytics`, `/` | `/api/orders`, `/api/dashboard` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Returns and incidents | `lib/domain/post_order/incident_handling_engine.dart`, `return_routing_service.dart`, `lib/data/repositories/return_repository.dart` | `/returns`, `/incidents`, `/incidents/:id` | MISSING | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Returned stock | `lib/data/repositories/returned_stock_repository.dart`, `lib/features/returned_stock/**` | `/returned-stock` | MISSING | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Capital and ledger | `lib/domain/capital/capital_management_service.dart`, `lib/data/repositories/financial_ledger_repository.dart` | `/capital` | MISSING | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Approval queue | `lib/features/approval/**`, repo/service integrations | `/approval` | MISSING | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Decision log | `lib/data/repositories/decision_log_repository.dart`, `lib/features/decision_log/**` | `/decision-log` | MISSING | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Suppliers and reliability | `lib/domain/supplier_reliability/**`, `lib/data/repositories/supplier_repository.dart` | `/suppliers`, `/suppliers/:id` | `/suppliers` | `/api/suppliers` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Products/listings margin health | `lib/data/repositories/product_repository.dart`, `listing_repository.dart` | `/products`, `/profit-dashboard` | `/products`, `/analytics`, `/` | `/api/products`, `/api/dashboard` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Marketplaces/accounts | `lib/data/repositories/marketplace_account_repository.dart`, `lib/features/marketplaces/**` | `/marketplaces` | MISSING | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Return policies | `lib/data/repositories/supplier_return_policy_repository.dart`, `lib/features/return_policies/**` | `/return-policies` | MISSING | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Inventory/stock refresh | `lib/domain/inventory/**`, `lib/services/price_refresh_service.dart` | `/products`, `/orders`, `/returned-stock` | `/products`, `/orders` | `/api/products`, `/api/orders` | REQUIRED | REQUIRED | REQUIRED | REQUIRED | PARTIAL |
| Messaging automation | `lib/services/messaging/customer_message_analyzer.dart`, `response_engine.dart` | Embedded in existing Flutter screens | MISSING | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| Settings/rules | `lib/data/repositories/rules_repository.dart`, `lib/features/settings/**` | `/settings` | `/settings` (stub) | MISSING | REQUIRED | REQUIRED | REQUIRED | REQUIRED | MISSING |
| How it works (functional explainability) | `lib/features/how_it_works/**` | `/how-it-works` | MISSING | N/A | REQUIRED | REQUIRED | OPTIONAL | REQUIRED | MISSING |

## Admin panel parity checklist (implementation work queue)

1. Implement missing Next pages + navigation entries for:
   - `marketplaces`, `returns`, `incidents`, `risk-dashboard`, `returned-stock`, `capital`, `approval`, `decision-log`, `return-policies`, `how-it-works`, `suppliers/[id]`.
2. Add Next API routes for each missing data surface.
3. Add actionable workflows (approve/reject/update/status transitions) where backend supports writes.
4. Add read-only placeholders for not-yet-live integrations with explicit `PLACEHOLDER` tags.

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

