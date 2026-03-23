# Feature map (test matrix source)

**Purpose:** Map **features → functions → storage/UI → routes** for traceability with [`TEST_TRACEABILITY_MATRIX.md`](TEST_TRACEABILITY_MATRIX.md) and Playwright/Vitest.

Legend: **F** = Flutter (`lib/`), **N** = Next admin (`admin_next/`).

## Rules & automation

| Feature | Domain / functions | Data | F route | N route |
|--------|----------------------|------|---------|---------|
| User rules | `RulesRepository.get/save`, `UserRules` | `user_rules` table | `/settings` | `/settings` + `GET/POST /api/rules` → Dart `/rules` |
| Pricing | `PricingCalculator`, `ListingDecider`, `Scanner` | products, listings, offers | `/products`, `/approval` | `/`, `/analytics`, `/products` |
| Approvals | approval screens, queues | listings, orders | `/approval` | `/approval` + mock transport panels |

## Sourcing & inventory

| Feature | Domain / functions | Data | F route | N route |
|--------|----------------------|------|---------|---------|
| Warehouse feeds | ingest / mapping (see `WAREHOUSE_FEEDS.md`) | products, offers | `/products` | `/products` |
| Price refresh | `PriceRefreshService`, catalog events | listings, offers | `/products` | `/api/products` proxy |

## Post-order

| Feature | Domain / functions | Data | F route | N route |
|--------|----------------------|------|---------|---------|
| Returns | `ReturnRepository`, routing | `return_requests` | `/returns` | `/returns` |
| Incidents | `IncidentHandlingEngine`, incident repo | incidents | `/incidents` | `/incidents` |
| Capital | `CapitalManagementService`, ledger | `financial_ledger` | `/capital` | `/capital` + `capital` snapshot in `GET /dashboard` (Dart) |

## Analytics & KPI (admin)

| Feature | Domain / functions | Data | F route | N route |
|--------|----------------------|------|---------|---------|
| Extended KPIs (p7–p14) | `AnalyticsEngine`, repos (incidents, ledger, jobs, health) | orders, returns, listings, ledger, `background_jobs`, etc. | `/analytics` (Flutter) | `/analytics`, `/profit-dashboard`, `/capital`; `GET /dashboard` → [`dashboardApi.ts`](../admin_next/src/lib/dashboardApi.ts) `dashboardPayloadVersion` |

## How to extend

- Add a row per new **user-visible** capability.
- Link **automated tests** in the matrix (TP-A Flutter, TP-B Next, TP-C risk, TP-E load).
