# Handoff / Agent Snapshot – Jurassic Dropshipping

**Last updated:** After completing Phases 1–6 + all suggested next changes.

---

## Current state (all phases done)

### Phase 1 – Foundation
- Flutter project (Android + Windows/macOS/Linux), [pubspec.yaml](pubspec.yaml) with Riverpod, Drift, Hive, Dio, flutter_secure_storage, freezed, go_router, logger, fl_chart.
- **Core**: [lib/core/](lib/core/) – `AppError`, `Result<T,E>`, `appLogger`.
- **Models**: [lib/data/models/](lib/data/models/) – `Product`, `ProductVariant`, `Listing`, `Order`, `CustomerAddress`, `DecisionLog`, `UserRules` (freezed + json).
- **Database**: [lib/data/database/app_database.dart](lib/data/database/app_database.dart) – Drift schema, row types `ProductRow`, `ListingRow`, etc.
- **Repositories**: [lib/data/repositories/](lib/data/repositories/) – Product, Listing, Order, DecisionLog, Rules.

### Phase 2 – Domain & decision engine
- **Interfaces**: [lib/domain/platforms.dart](lib/domain/platforms.dart) – `SourcePlatform`, `TargetPlatform`, `SourceSearchFilters`, `PlaceOrderRequest`, `SourceOrderResult`, `ListingDraft`.
- **Decision engine**: [lib/domain/decision_engine/](lib/domain/decision_engine/) – `PricingCalculator`, `SupplierSelector`, `ListingDecider`, `Scanner` (scan → persist products/listings + decision logs).

### Phase 3 – Integrations
- **Secure storage**: [lib/services/secure_storage_service.dart](lib/services/secure_storage_service.dart) – `SecureKeys`, `SecureStorageService`.
- **CJ**: [lib/services/sources/cj_dropshipping_client.dart](lib/services/sources/cj_dropshipping_client.dart), [cj_source_platform.dart](lib/services/sources/cj_source_platform.dart) – auth, product listV2, detail, createOrderV2.
- **Allegro**: [lib/services/targets/allegro_client.dart](lib/services/targets/allegro_client.dart), [allegro_target_platform.dart](lib/services/targets/allegro_target_platform.dart) – token refresh, checkout forms, create/update offer, shipments.
- **Allegro OAuth**: [lib/services/allegro_oauth_service.dart](lib/services/allegro_oauth_service.dart) – authorization code flow via local HTTP server redirect. Settings UI has Client ID/Secret + "Connect Allegro (OAuth)" button.

### Phase 4 – Orders & fulfillment
- [lib/services/order_sync_service.dart](lib/services/order_sync_service.dart) – poll targets, insert orders (pending or pendingApproval per rules).
- [lib/services/order_sync_scheduler.dart](lib/services/order_sync_scheduler.dart) – timer-based periodic sync using `scanIntervalMinutes`; auto-fulfills pending orders when `manualApprovalOrders` is false.
- [lib/services/fulfillment_service.dart](lib/services/fulfillment_service.dart) – resolve listing/product/source, place source order, update tracking.
- `ListingRepository.getByTargetListingId` for order → listing lookup.

### Phase 5 – UI
- **App**: [lib/main.dart](lib/main.dart) – `ProviderScope`, [lib/app_router.dart](lib/app_router.dart) – go_router, [lib/app_providers.dart](lib/app_providers.dart) – all providers.
- **Shell**: [lib/features/shell/shell_screen.dart](lib/features/shell/shell_screen.dart) – drawer → Dashboard, Products, Orders, Approval, Decision log, Settings.
- **Screens**: Dashboard (summary cards + Run scan + profit trend chart + order sync controls), Products/Orders/Decision log (lists), Approval (pending listings + orders, Approve/Reject), Settings (rules + CJ credentials + Allegro OAuth).
- **Dashboard charts**: Daily profit trend line chart using fl_chart (last 7 days).

### Phase 6 – Stubs & docs
- **Stubs**: [lib/services/sources/temu_stub_source.dart](lib/services/sources/temu_stub_source.dart), [lib/services/targets/amazon_stub_target.dart](lib/services/targets/amazon_stub_target.dart).
- **Docs**: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [docs/DECISION_LOGIC.md](docs/DECISION_LOGIC.md), [docs/ADDING_A_MARKETPLACE.md](docs/ADDING_A_MARKETPLACE.md). README updated.

### Tests
- 29 unit tests for PricingCalculator (10), ListingDecider (8), SupplierSelector (11).
- See `test/domain/decision_engine/`.

### Web panel
- **Platform**: Flutter web added (`web/`). Same app runs in the browser with all features (dashboard, products, orders, approval, decision log, settings).
- **Database**: Conditional DB connection: [lib/data/database/app_database_storage_io.dart](lib/data/database/app_database_storage_io.dart) (native SQLite), [app_database_storage_web.dart](lib/data/database/app_database_storage_web.dart) (Drift WASM). `web/sqlite3.wasm` and `web/drift_worker.js` from sqlite3/drift releases.
- **Shell**: Responsive layout: NavigationRail on width >= 600px (desktop/web), drawer on small screens.

---

## Suggested next changes

- **Allegro sandbox testing**: Test OAuth flow against Allegro sandbox environment to verify token exchange and offer creation.
- **Widget tests**: Add widget tests for main screens (Dashboard, Settings, Approval) using `WidgetTester`.
- **Order sync UI feedback**: Show sync progress indicator and last-sync timestamp in Dashboard; persist last sync time across app restarts.
- **Profit chart interactivity**: Add weekly/monthly toggle for profit chart; tooltip showing exact profit on hover.
- **Error handling for path_provider**: Fix `MissingPlatformDirectoryException` on Linux by providing fallback path for application documents directory.

---

## Commands

- **Run**: `flutter pub get && flutter run`
- **Codegen**: `dart run build_runner build --delete-conflicting-outputs`
- **Analyze**: `flutter analyze lib`
- **Test**: `flutter test test/domain/`

Secrets: use Settings (CJ email/API key, Allegro Client ID/Secret via OAuth). Tokens in secure storage; no keys in repo.
