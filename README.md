# Jurassic Dropshipping

Personal dropshipping arbitrage app (Flutter) – automate sourcing, listing, and order fulfillment for the Polish market. Single-user; optional manual approval for listings and orders.

## Features

- **Multi-source product sourcing**: CJ Dropshipping (API v2), API2Cart (Shopify, WooCommerce, Magento, etc.)
- **Multi-target listing**: Allegro (REST API + OAuth), Temu (seller API — forward-looking)
- **Decision engine**: automated product scanning, supplier selection, pricing with configurable rules
- **Safety guardrails**: minimum profit floor (5 PLN), max source price, 10x sanity check, return risk buffer, blacklists — see [MONEY_SAFETY.md](docs/MONEY_SAFETY.md)
- **Returns management**: track return requests, reasons, refund amounts, restocking fees
- **Supplier & offer tracking**: supplier return policies, per-offer cost/shipping/carrier data, stale price detection
- **Marketplace accounts**: manage connected marketplace accounts (Allegro, Temu, etc.)
- **Price refresh**: automatic stale offer price refresh from source platforms
- **Automation scheduler**: timer-based scanner, order sync, and price refresh with configurable intervals
- **Shipping estimator**: delivery window estimation from carrier days + handling time
- **Approval queues**: optional manual approval for listings and orders before publishing/fulfilling
- **Dashboard**: summary cards, profit trend chart (fl_chart), scan + sync + automation controls
- **Web panel**: full app runs in the browser via Flutter web + Drift WASM

## Architecture overview

```
lib/
├── core/              # AppError, Result<T,E>, logger
├── data/
│   ├── database/      # Drift schema + platform-conditional connections
│   ├── models/        # Freezed models (Product, Order, Listing, Supplier, etc.)
│   └── repositories/  # CRUD repositories (Product, Listing, Order, Supplier, etc.)
├── domain/
│   ├── decision_engine/  # Scanner, ListingDecider, SupplierSelector, PricingCalculator
│   ├── platforms.dart    # SourcePlatform / TargetPlatform interfaces
│   └── shipping_estimator.dart
├── features/          # UI screens (dashboard, products, orders, suppliers, etc.)
└── services/          # API clients (CJ, API2Cart, Allegro, Temu), OAuth, sync, fulfillment
```

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the full architecture diagram and data flow.

## Setup

- Flutter SDK >= 3.11.0 (see `environment.sdk` in [pubspec.yaml](pubspec.yaml)).
- Copy [.env.example](.env.example) to `.env` if you need env-based config (API base URLs). **Do not commit API keys** – use the app Settings and secure storage.

## Run

```bash
flutter pub get
flutter run   # pick Android, desktop (Windows/macOS/Linux), or Chrome (web)
```

### Web panel

Run the full app in the browser (dashboard, products, orders, suppliers, marketplaces, returns, approval queue, decision log, settings):

```bash
flutter run -d chrome
# or build for production:
flutter build web
# then serve build/web (e.g. with a static server)
```

The web build uses Drift with SQLite in WebAssembly; `sqlite3.wasm` and `drift_worker.js` in `web/` are required (included from drift/sqlite3 releases). For best persistence in some browsers, serve with COOP/COEP headers (see [Drift web docs](https://drift.simonbinder.eu/Platforms/web)).

## Codegen

After changing models or the Drift schema:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Analyze

```bash
flutter analyze lib
```

## Test

```bash
flutter test               # all 136 tests
flutter test test/domain/  # decision engine + shipping estimator (50)
flutter test test/data/    # repositories (57)
flutter test test/services/ # services (22)
flutter test test/integration/ # integration (6)
```

## Documentation

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) – High-level architecture and data flow.
- [docs/DECISION_LOGIC.md](docs/DECISION_LOGIC.md) – Listing and supplier decision rules.
- [docs/ADDING_A_MARKETPLACE.md](docs/ADDING_A_MARKETPLACE.md) – How to add a new source or target platform.
- [docs/MONEY_SAFETY.md](docs/MONEY_SAFETY.md) – Financial safety guardrails, return risk, and monitoring checklist.
- [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md) – Build, run, data, automation, and optional Docker.
- [docs/OOS_DETECTION.md](docs/OOS_DETECTION.md) – How we detect out-of-stock (CJ codes, heuristics, strict mode).
- [docs/WAREHOUSE_FEEDS.md](docs/WAREHOUSE_FEEDS.md) – Sourcing from warehouse/depot (CSV, XML, API) with flexible mapping; middleman optional.
- [docs/POST_ORDER_INCIDENT_IMPLEMENTATION_PLAN.md](docs/POST_ORDER_INCIDENT_IMPLEMENTATION_PLAN.md) – Post-order lifecycle, incidents, returns, supplier policies, capital management, risk scoring, and pricing adaptation (18-phase plan).
- [docs/ADMIN_NEXT_CONTINUATION.md](docs/ADMIN_NEXT_CONTINUATION.md) – **Next.js admin** (`admin_next/`): handoff for agents, env, commands, and follow-up work (mock transport, tests, HTTP writes).
- [docs/TEST_TRACEABILITY_MATRIX.md](docs/TEST_TRACEABILITY_MATRIX.md) – Test plan mapping (TP-A..TP-E) and admin parity.
- [docs/NO_API_WRITE_WORKFLOW_CONTRACTS.md](docs/NO_API_WRITE_WORKFLOW_CONTRACTS.md) – Write-workflow contracts for the admin transport layer.

### Next.js admin (optional local dashboard)

```bash
cd admin_next && npm ci && npm run dev
```

Uses `admin_next/` with optional Dart API (`tool/dashboard_api_server_dart_main.dart`). See [ADMIN_NEXT_CONTINUATION.md](docs/ADMIN_NEXT_CONTINUATION.md) for transport modes and CI.

## Integrations

- **Source**: CJ Dropshipping (API v2). Configure email + API key in Settings.
- **Source**: API2Cart (unified ecommerce API). Configure API key + store key in Settings.
- **Target**: Allegro REST API. Full OAuth flow in app (Client ID/Secret + authorization code exchange).
- **Target**: Temu Seller API (forward-looking — placeholder endpoints until public API is available).
- **Stubs**: Temu (source) and Amazon (target) are stubs for future implementation.
