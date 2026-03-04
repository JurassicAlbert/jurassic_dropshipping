# Adding a new marketplace

## Source platform (e.g. new supplier)

1. **Implement `SourcePlatform`** (see `lib/domain/platforms.dart`):
   - `id`, `displayName`
   - `searchProducts(keywords, filters)` → `List<Product>`
   - `getProduct(sourceId)`, `getBestOffer(productId)`
   - `placeOrder(PlaceOrderRequest)` → `SourceOrderResult`
   - `getOrderStatus(sourceOrderId)` (optional)

2. **Add API client** under `lib/services/sources/` (e.g. `xyz_client.dart`). Use Dio, auth from `SecureStorageService`, and map API responses to domain `Product` and `PlaceOrderRequest` / `SourceOrderResult`.

3. **Register in app**:
   - Add a provider for the client and for `XyzSourcePlatform` in `lib/app_providers.dart`.
   - Append the new source to `sourcesListProvider` so the Scanner and FulfillmentService use it.

4. **Credentials**: Store API keys/tokens via `SecureStorageService` and add keys in `SecureKeys` if needed. Optionally add a settings section for the new platform (e.g. API key input).

## Target platform (e.g. new selling channel)

1. **Implement `TargetPlatform`** (see `lib/domain/platforms.dart`):
   - `id`, `displayName`
   - `createListing(ListingDraft)` → offer/listing id
   - `updateListing(id, price?, stock?)`
   - `getOrders(since)` → `List<Order>`
   - `updateTracking(orderId, trackingNumber)`
   - `getListingDetails(id)` (optional)

2. **Add API client** under `lib/services/targets/` (e.g. `xyz_client.dart`). Handle OAuth or API keys and map to domain `Order` and `ListingDraft`.

3. **Register in app**:
   - Add a provider for the client and for `XyzTargetPlatform` in `lib/app_providers.dart`.
   - Append the new target to `targetsListProvider` so OrderSyncService and FulfillmentService use it.

4. **Listings**: When creating listings, the Scanner uses a single `targetPlatformId` (e.g. from rules or scanner config). To support multiple targets, extend rules or scanner to produce one listing per chosen target and set `listing.targetPlatformId` accordingly.

## Stubs

- **Temu**: `lib/services/sources/temu_stub_source.dart` – returns empty and throws on placeOrder; replace when an official API exists.
- **Amazon**: `lib/services/targets/amazon_stub_target.dart` – throws on createListing, returns empty orders; implement with SP-API when ready.

After implementing, run the decision engine and approval flow against the new platform to confirm listing and order mapping (including `listingId` / `targetListingId` and order ↔ listing linkage for fulfillment).
