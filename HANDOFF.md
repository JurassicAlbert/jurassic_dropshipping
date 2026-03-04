# Handoff for Cloud Agent – Jurassic Dropshipping

This repo is set up for the **Personal Dropshipping Arbitrage App** (Flutter). The cloud agent should continue from the implementation plan and complete the remaining phases.

## Current state (what’s done)

### Phase 1 – Done
- **Flutter project**: Created with `flutter create . --org com.jurassic --platforms android,windows,macos,linux`.
- **Dependencies**: In [pubspec.yaml](pubspec.yaml): Riverpod, Drift, Hive, Dio, flutter_secure_storage, freezed, json_serializable, go_router, logger, flutter_dotenv, fl_chart; dev: build_runner, freezed, drift_dev.
- **Core**: [lib/core/](lib/core/) – `AppError`, `Result<T,E>`, `appLogger`.
- **Domain models** (freezed + json): [lib/data/models/](lib/data/models/) – `Product`, `ProductVariant`, `Listing`, `Order`, `CustomerAddress`, `DecisionLog`, `UserRules`.
- **Database**: [lib/data/database/app_database.dart](lib/data/database/app_database.dart) – Drift schema with tables: `Products`, `Listings`, `Orders`, `DecisionLogs`, `UserRulesTable` (row types: `ProductRow`, `ListingRow`, etc.).
- **Repositories**: [lib/data/repositories/](lib/data/repositories/) – `ProductRepository`, `ListingRepository`, `OrderRepository`, `DecisionLogRepository`, `RulesRepository`. All map DB rows to domain models and expose CRUD.
- **Generated code**: `build_runner` has been run; `.freezed.dart`, `.g.dart`, and `app_database.g.dart` are present and committed. `flutter analyze lib` passes.

### Not done (where to continue)
- **Phase 2**: Domain interfaces `SourcePlatform` and `TargetPlatform`; decision engine (scanner, listing decider, supplier selector, pricing calculator); wiring `UserRules` load/save into the engine.
- **Phase 3**: CJdropshipping API client + `CjSourcePlatform`; Allegro API client + `AllegroTargetPlatform`; secure storage for credentials; Dio interceptors (auth, retry, logging).
- **Phase 4**: Order polling (e.g. Allegro); fulfillment flow (place order at CJ, update tracking on Allegro); approval gates for listings and orders.
- **Phase 5**: UI – dashboard, product/order analytics, decision log, approval queue, settings (rules + platform credentials). Use go_router and Riverpod.
- **Phase 6**: Stub implementations for Temu (source) and Amazon (target); README run instructions; ARCHITECTURE.md, DECISION_LOGIC.md, ADDING_A_MARKETPLACE.md.

## Reference
- **Implementation plan**: See the plan attached to the original request (e.g. in Cursor plans or the user’s prompt). It defines architecture, data flow, API reality (CJ + Allegro first; Temu no official API; Amazon second target), and file layout.
- **Key paths** (from plan):  
  `lib/domain/platforms.dart`, `lib/domain/decision_engine/`,  
  `lib/services/sources/cj_*`, `lib/services/targets/allegro_*`,  
  `lib/features/dashboard/`, `analytics/`, `approval/`, `settings/`.

## Commands
- **Code generation**: `dart run build_runner build --delete-conflicting-outputs`
- **Analyze**: `flutter analyze lib`
- **Run**: `flutter run` (choose Android or desktop device)

## Repo and secrets
- `.env` is in `.gitignore`. Use `.env.example` as a template; real API keys go in **flutter_secure_storage** (not in repo).

Start from **Phase 2** (platform interfaces + decision engine), then Phase 3 (CJ + Allegro clients), then 4–6.
