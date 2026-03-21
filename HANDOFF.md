# Handoff / Agent Snapshot – Jurasic Dropshipping

**Last updated:** After completing Phases 1–6 + all suggested next changes (marketplace accounts, Temu target, API2Cart source, suppliers/offers, returns, safety guardrails, price refresh, automation scheduler, shipping estimator).

---

## Current state (all phases done)

### Phase 1 – Foundation
- Flutter project (Android + Windows/macOS/Linux + Web), [pubspec.yaml](pubspec.yaml) with Riverpod, Drift, Hive, Dio, flutter_secure_storage, freezed, go_router, logger, fl_chart.
- **Core**: [lib/core/](lib/core/) – `AppError`, `Result<T,E>`, `appLogger`.
- **Models**: [lib/data/models/](lib/data/models/) – `Product`, `ProductVariant`, `Listing`, `Order`, `CustomerAddress`, `DecisionLog`, `UserRules`, `Supplier`, `SupplierOffer`, `MarketplaceAccount`, `ReturnRequest` (freezed + json).
- **Database**: [lib/data/database/app_database.dart](lib/data/database/app_database.dart) – Drift schema with tables for products, listings, orders, decision logs, rules, suppliers, supplier offers, returns, marketplace accounts.
- **Repositories**: [lib/data/repositories/](lib/data/repositories/) – Product, Listing, Order, DecisionLog, Rules, Supplier, SupplierOffer, Return, MarketplaceAccount.

### Phase 2 – Domain & decision engine
- **Interfaces**: [lib/domain/platforms.dart](lib/domain/platforms.dart) – `SourcePlatform`, `TargetPlatform`, `SourceSearchFilters`, `PlaceOrderRequest`, `SourceOrderResult`, `ListingDraft`.
- **Decision engine**: [lib/domain/decision_engine/](lib/domain/decision_engine/) – `PricingCalculator`, `SupplierSelector`, `ListingDecider`, `Scanner` (scan → persist products/listings + decision logs).
- **Shipping estimator**: [lib/domain/shipping_estimator.dart](lib/domain/shipping_estimator.dart) – `ShippingEstimator` estimates delivery windows from supplier offer shipping data + handling time.

### Phase 3 – Integrations
- **Secure storage**: [lib/services/secure_storage_service.dart](lib/services/secure_storage_service.dart) – `SecureKeys`, `SecureStorageService`.
- **CJ Dropshipping** (source): [lib/services/sources/cj_dropshipping_client.dart](lib/services/sources/cj_dropshipping_client.dart), [cj_source_platform.dart](lib/services/sources/cj_source_platform.dart) – auth, product listV2, detail, createOrderV2.
- **API2Cart** (source): [lib/services/sources/api2cart_client.dart](lib/services/sources/api2cart_client.dart), [api2cart_source_platform.dart](lib/services/sources/api2cart_source_platform.dart) – unified ecommerce API (Shopify, WooCommerce, Magento, etc.).
- **Allegro** (target): [lib/services/targets/allegro_client.dart](lib/services/targets/allegro_client.dart), [allegro_target_platform.dart](lib/services/targets/allegro_target_platform.dart) – token refresh, checkout forms, create/update offer, shipments.
- **Temu** (target): [lib/services/targets/temu_seller_client.dart](lib/services/targets/temu_seller_client.dart), [temu_target_platform.dart](lib/services/targets/temu_target_platform.dart) – forward-looking seller API integration (placeholder endpoints until public API is available).
- **Allegro OAuth**: [lib/services/allegro_oauth_service.dart](lib/services/allegro_oauth_service.dart) – authorization code flow via local HTTP server redirect. Settings UI has Client ID/Secret + "Connect Allegro (OAuth)" button.
- **Stubs**: [lib/services/sources/temu_stub_source.dart](lib/services/sources/temu_stub_source.dart) (source stub), [lib/services/targets/amazon_stub_target.dart](lib/services/targets/amazon_stub_target.dart) (target stub).

### Phase 4 – Orders & fulfillment
- [lib/services/order_sync_service.dart](lib/services/order_sync_service.dart) – poll targets (Allegro + Temu), insert orders (pending or pendingApproval per rules).
- [lib/services/fulfillment_service.dart](lib/services/fulfillment_service.dart) – resolve listing/product/source, place source order, update tracking.
- `ListingRepository.getByTargetListingId` for order → listing lookup.

### Phase 5 – UI
- **App**: [lib/main.dart](lib/main.dart) – `ProviderScope`, [lib/app_router.dart](lib/app_router.dart) – go_router, [lib/app_providers.dart](lib/app_providers.dart) – all providers.
- **Shell**: [lib/features/shell/shell_screen.dart](lib/features/shell/shell_screen.dart) – responsive layout (NavigationRail >= 600px, drawer on small screens).
- **Screens**: Dashboard (summary cards + Run scan + profit trend chart + automation controls), Products, Orders, Suppliers, Marketplaces, Returns, Approval queue (pending listings + orders), Decision log, Settings (rules + CJ/API2Cart credentials + Allegro OAuth).
- **Dashboard charts**: Daily profit trend line chart using fl_chart (last 7 days).

### Phase 6 – Stubs & docs
- **Docs**: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [docs/DECISION_LOGIC.md](docs/DECISION_LOGIC.md), [docs/ADDING_A_MARKETPLACE.md](docs/ADDING_A_MARKETPLACE.md), [docs/MONEY_SAFETY.md](docs/MONEY_SAFETY.md). README updated.

### Post-phase additions

#### Supplier & offer management
- **Models**: `Supplier` (return policy fields: `returnWindowDays`, `returnShippingCost`, `restockingFeePercent`, `acceptsNoReasonReturns`), `SupplierOffer` (cost, shipping, carrier, price/stock refresh timestamps).
- **Repositories**: [lib/data/repositories/supplier_repository.dart](lib/data/repositories/supplier_repository.dart) (CRUD + return policy), [lib/data/repositories/supplier_offer_repository.dart](lib/data/repositories/supplier_offer_repository.dart) (CRUD + `getStaleOffers`).

#### Marketplace accounts
- **Model**: `MarketplaceAccount` (id, platformId, displayName, isActive, connectedAt).
- **Repository**: [lib/data/repositories/marketplace_account_repository.dart](lib/data/repositories/marketplace_account_repository.dart) (CRUD, getByPlatformId).
- **UI**: [lib/features/marketplaces/marketplaces_screen.dart](lib/features/marketplaces/marketplaces_screen.dart).

#### Returns
- **Model**: `ReturnRequest` (status: requested/approved/shipped/received/refunded/rejected; reason: noReason/defective/wrongItem/damagedInTransit/other; refund/shipping/restocking amounts).
- **Repository**: [lib/data/repositories/return_repository.dart](lib/data/repositories/return_repository.dart) (CRUD, getByOrderId, updateStatus).
- **UI**: [lib/features/returns/returns_screen.dart](lib/features/returns/returns_screen.dart).

#### Safety guardrails
- **ListingDecider**: absolute minimum profit floor (5 PLN), selling price sanity check (10x source cost cap), borderline margin warnings.
- **PricingCalculator**: `calculateSafeSellingPrice` (return risk buffer), `estimateReturnCost`.
- **Docs**: [docs/MONEY_SAFETY.md](docs/MONEY_SAFETY.md) – comprehensive money safety guide.

#### Price refresh
- **PriceRefreshService**: [lib/services/price_refresh_service.dart](lib/services/price_refresh_service.dart) – refreshes stale supplier offer prices from source platforms (configurable `staleDuration`, default 6h).

#### Automation scheduler
- **AutomationScheduler**: [lib/services/automation_scheduler.dart](lib/services/automation_scheduler.dart) – timer-based orchestrator for scanner, order sync, and price refresh. Configurable intervals, auto-fulfillment when manual approval is off.

#### Shipping estimator
- **ShippingEstimator**: [lib/domain/shipping_estimator.dart](lib/domain/shipping_estimator.dart) – estimates delivery windows (min/max days, earliest/latest dates) from carrier days + handling time.

### Web panel
- **Platform**: Flutter web added (`web/`). Same app runs in the browser with all features.
- **Database**: Conditional DB connection: [app_database_storage_io.dart](lib/data/database/app_database_storage_io.dart) (native SQLite), [app_database_storage_web.dart](lib/data/database/app_database_storage_web.dart) (Drift WASM). `web/sqlite3.wasm` and `web/drift_worker.js` from sqlite3/drift releases.

---

## Test coverage

**136 tests total** — all passing.

| Category | Count | Location |
|----------|-------|----------|
| Decision engine | 45 | `test/domain/decision_engine/` (pricing calculator 10, listing decider 8, listing decider safety 6, supplier selector 11, supplier selector offers 10) |
| Shipping estimator | 5 | `test/domain/shipping_estimator_test.dart` |
| Repositories | 57 | `test/data/repositories/` (product 8, listing 8, order 8, return 6, supplier 9, supplier offer 10, marketplace account — included in total) |
| Services | 22 | `test/services/` (order sync 5, fulfillment 6, allegro OAuth 3, price refresh 4, automation scheduler 4) |
| Integration | 6 | `test/integration/scan_to_listing_test.dart` |
| Widget | 1 | `test/widget_test.dart` |

---

## Key file paths

| Area | Path |
|------|------|
| Models (freezed) | `lib/data/models/` |
| Database (Drift) | `lib/data/database/app_database.dart` |
| Repositories | `lib/data/repositories/` |
| Domain interfaces | `lib/domain/platforms.dart` |
| Decision engine | `lib/domain/decision_engine/` |
| Shipping estimator | `lib/domain/shipping_estimator.dart` |
| Source clients | `lib/services/sources/` |
| Target clients | `lib/services/targets/` |
| Services | `lib/services/` |
| Providers | `lib/app_providers.dart` |
| Router | `lib/app_router.dart` |
| UI screens | `lib/features/` |
| Web assets | `web/sqlite3.wasm`, `web/drift_worker.js` |
| Tests | `test/` |
| Docs | `docs/` |

---

## Suggested next changes

- **Allegro sandbox testing**: Test OAuth flow against Allegro sandbox environment to verify token exchange and offer creation end-to-end.
- **Real API integration testing**: Connect to live CJ and API2Cart APIs with test credentials; verify product search, pricing, and order placement.
- **CI/CD pipeline**: Set up GitHub Actions for `flutter analyze`, `flutter test`, and `flutter build web` on every push/PR.
- **Temu seller API**: Replace placeholder endpoints in `TemuSellerClient` when Temu opens their public seller API.
- **Amazon SP-API**: Implement `AmazonTargetPlatform` using Amazon Selling Partner API (currently a stub).
- **Widget tests**: Add widget tests for main screens (Dashboard, Settings, Approval, Returns) using `WidgetTester`.
- **Order sync UI feedback**: Show sync progress indicator and last-sync timestamp in Dashboard; persist last sync time across app restarts.
- **Profit chart interactivity**: Add weekly/monthly toggle for profit chart; tooltip showing exact profit on hover.
- **Multi-target listings**: Extend scanner to produce listings for multiple targets per product (currently single `targetPlatformId`).
- **Marketplace fee per platform**: Make `marketplaceFeePercent` configurable per target platform instead of global 10%.

---

## Commands

- **Run**: `flutter pub get && flutter run`
- **Run web**: `flutter run -d chrome`
- **Build web**: `flutter build web`
- **Codegen**: `dart run build_runner build --delete-conflicting-outputs`
- **Analyze**: `flutter analyze lib`
- **Test all**: `flutter test`
- **Test domain**: `flutter test test/domain/`
- **Test repositories**: `flutter test test/data/`
- **Test services**: `flutter test test/services/`
- **Test integration**: `flutter test test/integration/`

Secrets: use Settings (CJ email/API key, API2Cart API key/store key, Allegro Client ID/Secret via OAuth). Tokens in secure storage; no keys in repo.
