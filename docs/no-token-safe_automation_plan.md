# No-API-token-safe automation

## Goal

Run the app and automation (scheduler) without any API tokens configured: no Allegro/Temu/CJ/API2Cart credentials. Scheduled jobs should skip unconfigured platforms instead of calling real APIs and failing (401, connection errors).

## Approach

- Add an async `Future<bool> isConfigured()` to the platform interfaces. When `false`, callers skip that platform (no HTTP calls).
- Implement it for real clients using existing [SecureKeys](lib/services/secure_storage_service.dart); mocks/stubs keep default `true` so tests are unchanged.
- In services that call targets/sources, check `isConfigured()` before using a platform and skip if not configured.

## 1. Domain: optional `isConfigured()` on platforms

- **[lib/domain/platforms.dart](lib/domain/platforms.dart)**  
  - Add `Future<bool> isConfigured()` to `SourcePlatform` and `TargetPlatform`.  
  - Default implementation: `return true` (backward compatible; mocks/stubs need no change).

## 2. Implementations (credentials from secure storage)

- **Allegro**  
  - [lib/services/targets/allegro_client.dart](lib/services/targets/allegro_client.dart): add `Future<bool> isConfigured()` that returns true only if `allegroAccessToken` is non-empty or both `allegroClientId` and `allegroClientSecret` are set for OAuth flow.  
  - [lib/services/targets/allegro_target_platform.dart](lib/services/targets/allegro_target_platform.dart): implement `TargetPlatform.isConfigured()` by delegating to the client.
- **Temu**  
  - No Temu credential keys in SecureKeys yet. Implement `TargetPlatform.isConfigured()` to return `false` for now. When you add a Temu key later, check it here.
- **CJ source**  
  - [lib/services/sources/cj_dropshipping_client.dart](lib/services/sources/cj_dropshipping_client.dart) / CjSourcePlatform: implement `SourcePlatform.isConfigured()` by checking that either `cjAccessToken` is non-empty or both `cjApiKey` and `cjEmail` are set.
- **API2Cart source**  
  - [lib/services/sources/api2cart_client.dart](lib/services/sources/api2cart_client.dart) / Api2CartSourcePlatform: implement `SourcePlatform.isConfigured()` by checking that both `api2cartApiKey` and `api2cartStoreKey` are set.
- **Stubs/mocks**  
  - Amazon stub, mock target/source: implement `isConfigured()` returning `true` (or rely on default where applicable).

## 3. Call sites: skip unconfigured platforms

- **MarketplaceListingSyncService**  
  - `syncListingsStock`: skip source/target when `!await isConfigured()`.  
  - `refreshProductsFromSource` and `refreshProductsFromSourceLowStock`: skip when source not configured.
- **OrderSyncService**  
  - In `syncOrders`, skip each target when `!await target.isConfigured()`.  
  - In `_syncCancelledOrders`, skip orders whose target is not configured.
- **PriceRefreshService**  
  - Skip sources for which `!await source.isConfigured()`.

## 4. No new keys or env required

- No new environment variables or SecureKeys. Temu returns `false` until you add a key; Allegro/CJ/API2Cart return `false` when their existing keys are missing or empty.

## 5. Testing

- Existing tests use mocks with `isConfigured()` returning `true`; behavior unchanged.  
- With no credentials, scheduler runs without 401s; sync/refresh complete with zero synced/refreshed.

## Summary

| Area                          | Change                                                |
| ----------------------------- | ----------------------------------------------------- |
| `platforms.dart`              | Add `Future<bool> isConfigured()` (default `true`).   |
| Allegro client + target       | Implement using allegro token or clientId+secret.     |
| Temu target                   | Return `false` (no token key yet).                    |
| CJ source                     | Implement using cj credentials.                       |
| API2Cart source               | Implement using api2cart keys.                         |
| MarketplaceListingSyncService | Skip source/target when `!await isConfigured()`.       |
| OrderSyncService              | Skip target when `!await isConfigured()`.             |
| PriceRefreshService           | Skip source when `!await isConfigured()`.             |

Result: with no API tokens, automation runs without calling Allegro/Temu/CJ/API2Cart; jobs complete with zero synced/refreshed and no 401 or connection errors.
