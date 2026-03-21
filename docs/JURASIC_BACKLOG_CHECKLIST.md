# Jurasic backlog checklist (p1–p18)

**Purpose:** Git-tracked mirror of the **Jurasic full backlog** plan so any clone, CI, or web agent can continue **without** relying on a local Cursor plan file (`.cursor/plans/*.plan.md` is outside the repo).

**How to use:** Update checkboxes and the **Status** column when you ship work. Link PRs or commits in your team process if helpful.

| ID | Task | Status | Notes / pointers |
|----|------|--------|------------------|
| **p1** | Pricing path audit (calculator aligned across flows) | Done | [`PRICING_PATH_AUDIT.md`](PRICING_PATH_AUDIT.md); deepen with code if new surfaces add ad-hoc margin math |
| **p2** | Rename visible branding **Jurassic → Jurasic** | Done | `lib/l10n/`, `lib/main.dart`, shell/login, `admin_next` layout/shell, README, tests |
| **p3** | Fix CI (`analyze-and-test`, `admin-next-tests`) | Done | `analysis_options.yaml` excludes generated `*.freezed.dart`/`*.g.dart`; `admin_next` build + TS fixes |
| **p4** | Fix Admin Next **hydration** mismatch | Done | [`useClientMounted`](../admin_next/src/lib/useClientMounted.ts) uses `useSyncExternalStore`; Recharts gated on client |
| **p5** | **503** messaging + **Settings** → rules / flags | Done | [`/api/rules`](../admin_next/src/app/api/rules/route.ts); Dart `GET/POST /rules`; [`settings/page.tsx`](../admin_next/src/app/settings/page.tsx); dashboard errors in [`dashboardApi.ts`](../admin_next/src/lib/dashboardApi.ts) |
| **p6** | KPI: Core Financial (5) | Partial | Placeholders in [`JurasicKpiDashboard.tsx`](../admin_next/src/components/kpi/JurasicKpiDashboard.tsx) — wire Dart aggregates + charts |
| **p7** | KPI: Risk (5) — priority | Partial | Same component block; needs risk/return/incident series from DB or analytics |
| **p8** | KPI: Operations (5) | Partial | Placeholders; needs order funnel / fulfillment metrics |
| **p9** | KPI: Supplier (4) | Partial | Placeholders; align with supplier reliability services |
| **p10** | KPI: Product Quality (4) | Partial | Placeholders; listing/product health data |
| **p11** | KPI: Customer / Message (4) | Partial | Placeholders; needs messaging/analyzer metrics when available |
| **p12** | KPI: Capital / Cashflow (4) — critical | Partial | Placeholders; connect to ledger/capital snapshots |
| **p13** | KPI: Market / Listing (4) | Partial | Placeholders; listing health + competitiveness |
| **p14** | KPI: System Performance (4) | Partial | Placeholders; needs job queue / feed instrumentation |
| **p15** | Refresh **9 docs** (architecture, decision logic, marketplace, money safety, deployment, post-order plan, admin continuation, traceability matrix, no-api contracts) | Partial | Several titles/branding/admin sections updated; finish service/repo inventory per [cloud audit](#doc-audit-2026-03) |
| **p16** | README: **warehouse-first** sourcing, CJ/API2Cart secondary | Done | [README.md](../README.md) |
| **p17** | **`FEATURE_MAP.md`** (feature → function → nav → UI) | Done | [`FEATURE_MAP.md`](FEATURE_MAP.md) — expand rows over time |
| **p18** | Full coverage tests (APIs, nav, services/repos) | Partial | Vitest + Playwright; extend E2E + matrix as KPIs and APIs grow |

## Suggested execution order (same as plan)

1. Stabilize: **p3 → p4 → p5** (CI, hydration, settings/API errors).  
2. Product: **p2**, **p1** (branding, pricing audit doc + code vigilance).  
3. KPIs: **p7** Risk and **p12** Capital first, then **p6**, then **p8–p11**, **p13–p14**.  
4. Docs: **p15–p17**.  
5. Tests: **p18** incrementally with [`TEST_TRACEABILITY_MATRIX.md`](TEST_TRACEABILITY_MATRIX.md).

## Related docs

- [ADMIN_NEXT_CONTINUATION.md](ADMIN_NEXT_CONTINUATION.md) — env, commands, transport.  
- [FEATURE_MAP.md](FEATURE_MAP.md) — matrix seed.  
- [TEST_TRACEABILITY_MATRIX.md](TEST_TRACEABILITY_MATRIX.md) — TP-A..TP-E.  
- [NO_API_WRITE_WORKFLOW_CONTRACTS.md](NO_API_WRITE_WORKFLOW_CONTRACTS.md) — transport contracts.

## External / blocked (not in this checklist)

Allegro sandbox, CJ keys, Temu public API, Amazon SP-API — credentials or upstream APIs; keep placeholder/skipped tests until available.

### Doc audit (2026-03)

Cloud agent noted gaps in **DECISION_LOGIC**, **ADDING_A_MARKETPLACE**, **MONEY_SAFETY** (fees not only 10% hardcoded), **POST_ORDER** phase status, **TEST_TRACEABILITY_MATRIX** rows, **NO_API** method names — track under **p15** until each file is reconciled with `lib/` and `admin_next/`.
