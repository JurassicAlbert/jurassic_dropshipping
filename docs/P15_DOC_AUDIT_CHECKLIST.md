# p15 — Doc audit checklist (9 targets)

Reconcile each document with **current** code paths (`lib/`, `admin_next/`, `tool/`). Check off when reviewed; note commit/PR in team process if useful.

| # | Document | Focus | Status |
|---|----------|-------|--------|
| 1 | Architecture overview (repo root / `docs/` as applicable) | Modules, boundaries | ☐ |
| 2 | `DECISION_LOGIC` / decision flow | Scanner, decider, pricing | ☐ |
| 3 | `ADDING_A_MARKETPLACE` | Onboarding steps vs code | ☐ |
| 4 | `MONEY_SAFETY` | Fees, ledger — avoid hardcoded-only narrative | ☐ |
| 5 | Deployment / ops | Build targets, env | ☐ |
| 6 | Post-order plan (`POST_ORDER` phase) | Lifecycle vs `lib/domain/post_order/` | ☐ |
| 7 | [`ADMIN_NEXT_CONTINUATION.md`](ADMIN_NEXT_CONTINUATION.md) | Transport, routes, tests | ☐ (rolling) |
| 8 | [`TEST_TRACEABILITY_MATRIX.md`](TEST_TRACEABILITY_MATRIX.md) | Route/API/test TP rows | ☐ (rolling) |
| 9 | [`NO_API_WRITE_WORKFLOW_CONTRACTS.md`](NO_API_WRITE_WORKFLOW_CONTRACTS.md) | Method names vs `adminTransport` | ☐ |

**Cloud audit reference:** [`JURASIC_BACKLOG_CHECKLIST.md`](JURASIC_BACKLOG_CHECKLIST.md) — section *Doc audit (2026-03)*.
