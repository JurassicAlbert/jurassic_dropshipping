# Handoff / Agent Snapshot – Jurassic Dropshipping

**Last updated:** After completing Phases 1–6 locally. Use this for the next session or cloud agent.

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

### Phase 4 – Orders & fulfillment
- [lib/services/order_sync_service.dart](lib/services/order_sync_service.dart) – poll targets, insert orders (pending or pendingApproval per rules).
- [lib/services/fulfillment_service.dart](lib/services/fulfillment_service.dart) – resolve listing/product/source, place source order, update tracking.
- `ListingRepository.getByTargetListingId` for order → listing lookup.

### Phase 5 – UI
- **App**: [lib/main.dart](lib/main.dart) – `ProviderScope`, [lib/app_router.dart](lib/app_router.dart) – go_router, [lib/app_providers.dart](lib/app_providers.dart) – all providers.
- **Shell**: [lib/features/shell/shell_screen.dart](lib/features/shell/shell_screen.dart) – drawer → Dashboard, Products, Orders, Approval, Decision log, Settings.
- **Screens**: Dashboard (summary cards + Run scan), Products/Orders/Decision log (lists), Approval (pending listings + orders, Approve/Reject), Settings (rules + CJ credentials).

### Phase 6 – Stubs & docs
- **Stubs**: [lib/services/sources/temu_stub_source.dart](lib/services/sources/temu_stub_source.dart), [lib/services/targets/amazon_stub_target.dart](lib/services/targets/amazon_stub_target.dart).
- **Docs**: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [docs/DECISION_LOGIC.md](docs/DECISION_LOGIC.md), [docs/ADDING_A_MARKETPLACE.md](docs/ADDING_A_MARKETPLACE.md). README updated.

---

## Agent steps (what was done in order)

1. Phase 1: Flutter project, core, models, Drift schema, repositories (already present from earlier handoff).
2. Phase 2: Added `lib/domain/platforms.dart`; `pricing_calculator.dart`, `supplier_selector.dart`, `listing_decider.dart`, `scanner.dart`.
3. Phase 3: `SecureStorageService` + `SecureKeys`; `CjDropshippingClient` (auth, listV2, createOrderV2); `CjSourcePlatform`; `AllegroClient` (OAuth refresh, checkout forms, offers, shipments); `AllegroTargetPlatform`.
4. Phase 4: `OrderSyncService`, `FulfillmentService`; `ListingRepository.getByTargetListingId`.
5. Phase 5: `app_providers.dart` (repos, clients, platforms, scanner, order sync, fulfillment, FutureProviders); `app_router.dart` + shell; all feature screens; main.dart with ProviderScope + go_router.
6. Phase 6: Temu/Amazon stubs; ARCHITECTURE, DECISION_LOGIC, ADDING_A_MARKETPLACE; README.

---

## Suggested next changes

- **Allegro OAuth in app**: Add a proper OAuth flow (e.g. web or desktop redirect) so the user can log in once and store access/refresh tokens via Settings (Allegro client already supports `setTokens` and refresh).
- **Order sync scheduling**: Run `OrderSyncService.syncOrders(since)` on a timer (e.g. from rules.scanIntervalMinutes or a dedicated interval) or background task.
- **Auto-fulfill when approval off**: When `manualApprovalOrders` is false, after inserting a new order call `FulfillmentService.fulfillOrder(order)` so orders are fulfilled without a manual approval step.
- **Allegro offer payload**: Align `AllegroTargetPlatform.createListing` (and Allegro client) with Allegro’s current offer API (required fields, category, images format).
- **Dashboard charts**: Use fl_chart for profit trend (daily/weekly) from order repository data.
- **Tests**: Unit tests for PricingCalculator, ListingDecider, SupplierSelector; widget tests for main screens.

---

## Commands

- **Run**: `flutter pub get && flutter run`
- **Codegen**: `dart run build_runner build --delete-conflicting-outputs`
- **Analyze**: `flutter analyze lib`

Secrets: use Settings (CJ email/API key). Allegro tokens in secure storage; no keys in repo.
