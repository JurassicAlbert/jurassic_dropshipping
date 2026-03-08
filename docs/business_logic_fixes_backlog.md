# Business Logic Fixes – Full Backlog

This document lists **all** identified business-logic fixes for the app. The first batch is the current proposed fix (approved to implement). The rest are in priority order for later batches.

**Reference:** Analysis in `Business Logic: OK vs NOK`; implementation detail for Batch 1 in `NOK fixes implementation plan`.

---

## Product direction (default: automated, approval optional)

By default the app is intended to:

1. **Refresh products from feeds** – Keep product/stock data current from supplier feeds so we know what is in stock.
2. **Update seller accounts via API** – Push stock (and price) updates to Allegro, Temu, etc. so marketplace listings stay in sync and reflect availability.
3. **Automatically process selling** – Sync orders from marketplaces, fulfill with suppliers, push tracking back, without manual steps.
4. **Handle issues** – Pre-check stock at fulfill time, cancel on target when OOS or reject, preserve failedOutOfStock for reporting, etc.

**Manual approval (listings/orders) is an option**, not the default. When turned off, the app runs feed-driven refresh, marketplace updates, and auto-fulfill; when turned on, listings and/or orders wait for user approval before publish or fulfill.

**Implications for backlog:** Batch 1–3 fixes support this (cancel on target, OOS handling, refresh-before-display). Future work may include: scheduled refresh from feeds for all products; API integration to **update** existing offers on Allegro/Temu (stock/price) so marketplace stays in sync; and any additional automation or issue-handling flows.

---

## Batch 1 – Current fix (to implement now)

| # | Fix | Summary |
|---|-----|--------|
| **1** | Reject (order) must cancel on target | In Approval screen, "Reject" currently only sets local status to `cancelled`. **Change:** Call `orderCancellationService.cancelOrder(order)` so the order is cancelled on the marketplace (Allegro/Temu) and at source if already placed. Optionally show SnackBar if cancel fails. |
| **2** | Preserve failedOutOfStock when cancelling after OOS | After pre-check or placeOrder OOS, we set `failedOutOfStock` then call `cancelOrder`, which overwrites status to `cancelled`. **Change:** Add `cancelOrder(..., updateLocalStatus: false)` when called from fulfillment after OOS so status stays `failedOutOfStock` for analytics while we still cancel on target. |
| **3** | Only set cancelled if target cancel succeeded | If `target.cancelOrder` throws, we still set local status to `cancelled`. **Change:** Set local to `cancelled` only when target cancel succeeds; optionally return `bool` from `cancelOrder` and show message on Reject when cancel failed. |

**Files:** `lib/features/approval/approval_screen.dart`, `lib/services/order_cancellation_service.dart`, `lib/services/fulfillment_service.dart`.

---

## Batch 2 – Consistency and reporting (recommended next)

| # | Fix | Summary |
|---|-----|--------|
| **4** | OOS heuristic may misclassify (placeOrder errors) | `isLikelyOutOfStock` is string-based; can false-positive (cancel for non-OOS) or false-negative (leave order open for real OOS). **Change:** Use source-specific error codes where available (e.g. CJ response); document which sources are covered; optionally add a strict mode that only cancels when confident it's OOS. |

**Files:** `lib/services/fulfillment_service.dart`, possibly source-specific clients (e.g. CJ).

---

## Batch 3 – Product and listing behaviour (when extending features)

| # | Fix | Summary |
|---|-----|--------|
| **5** | Quantity hardcoded to 1 | Fulfillment uses `const quantity = 1` for pre-check and PlaceOrderRequest. **Change:** When orders support quantity (e.g. from target payload), add `order.quantity` (or equivalent) and use it in pre-check and request. |
| **6** | Variant always first | We use `product.variants.first.id` for every order. **Change:** When listings are variant-specific, store `variantId` on listing and use it in fulfillment and pre-check. |
| **7** | No refresh-before-display | We don’t refresh stock when showing product/listing or approval screen. **Change:** When loading product/listing for detail or approval, call `source.getProduct(sourceId)` and show "In stock" / "Out of stock" (and optionally block or warn before approve). |

**Files:** `lib/services/fulfillment_service.dart`, `lib/data/models/order.dart` (if quantity added), listing model and approval/detail screens.

---

## Summary table (all items)

| Batch | # | Area | Priority |
|-------|---|------|----------|
| 1 | 1 | Reject cancels on target | Must-have |
| 1 | 2 | Preserve failedOutOfStock | Recommended |
| 1 | 3 | Don’t set cancelled when target cancel fails | Recommended |
| 2 | 4 | OOS heuristic / source-specific errors | Recommended |
| 3 | 5 | Order quantity (when supported) | When extending |
| 3 | 6 | Listing variant (when supported) | When extending |
| 3 | 7 | Refresh stock before display | UX improvement |

---

## What is OK (no change planned)

- Pre-check at fulfill time and no fulfillment delay.
- placeOrder failure handling (OOS heuristic + cancel on target) aside from heuristic refinement (Batch 2).
- Manual vs auto fulfillment (pending vs pendingApproval) – approval is optional; auto is the intended default.
- Cancel-after-shipped and return request creation; order status sync from target.
- Listing resolution (local id or target listing id).
- Listing Reject: only sets status to draft; no offer exists on target yet, so no cancel needed.
- Price refresh and scanner (feed-driven product discovery); approval screen stock display (refresh-before-display).

## Implemented (product direction)

- **Refresh products from feeds** – [MarketplaceListingSyncService.refreshProductsFromSource](lib/services/marketplace_listing_sync_service.dart) refreshes product/stock from sources for all products linked to active listings and updates the local product cache. Scheduled every **2 hours** in [AutomationScheduler](lib/services/automation_scheduler.dart) so pre-check and approval screen use fresher data.
- **Update marketplace offers via API** – [MarketplaceListingSyncService.syncListingsStock](lib/services/marketplace_listing_sync_service.dart) refreshes from source and pushes stock to Allegro, Temu, etc. via `TargetPlatform.updateListing`. Scheduled every **6 hours** in AutomationScheduler. Local product cache is updated when syncing.
- **Low-stock adaptive refresh** – [MarketplaceListingSyncService.refreshProductsFromSourceLowStock](lib/services/marketplace_listing_sync_service.dart) refreshes only products linked to active listings whose total stock is at or below a threshold (default 5). Scheduled every **30 minutes** in AutomationScheduler so OOS or restock is detected sooner.
- **Product details pushed to marketplace** – `TargetPlatform.updateListing` now accepts optional `title` and `description`. In `syncListingsStock`, after fetching fresh product from source, title/description are compared with the current product; when they differ, the listing is updated on the marketplace (Allegro/Temu) with the new title/description. Allegro client uses `name` and `description.sections`; Temu client sends `title` and `description` in the PATCH payload.

## Planned (product direction, not in fix batches)

- **Fully automated sell flow** – With approval off: product refresh (2h) + marketplace sync (6h) + order sync + auto-fulfill + tracking and issue handling. All pieces are in place; approval is optional.

---

## Planned refinements: adaptive refresh and product details

### 1. Adaptive refresh timing

**Problem:** Products can reappear on the feed after being sold (sometimes with a different price), or have very low stock. A single fixed refresh interval (e.g. 2h for products, 6h for marketplace) may be too slow for these cases.

**Proposed:**

- **Done: Shorter refresh when stock is low** – Products with total stock ≤ 5 are refreshed every 30 minutes via `refreshProductsFromSourceLowStock(maxStock: 5)` in AutomationScheduler.
- **Shorter refresh when product reappeared after OOS** – If we previously saw 0 stock and the product is linked to an active listing, refresh more often for a period (e.g. first 24h after reappearance) to pick up price or description changes and to keep stock accurate.
- **Optional:** Per-product or per-listing “refresh tier” (e.g. high priority = every 30 min, normal = 2h) based on rules or recent events (sold out, low stock, price change detected).

**Implementation notes:** Product refresh could accept a “priority” list of product IDs (low stock or recently OOS) and refresh those first or on a separate shorter schedule; or the scheduler could run a “fast refresh” pass (e.g. every 30 min) that only touches products with stock &lt; N or a “reappeared” flag.

### 2. Product details and description

**Problem:** When we refresh from the feed, we must keep not only stock and price but also **title, description, and images** in sync. Suppliers can change these; if we don’t update, our listings can be wrong or misleading.

**Proposed:**

- **Refresh and persist full product data** – On every product refresh from source, update and persist **title, description, imageUrls**, and variant data (not only stock). Our product cache should reflect the current feed content so that any new listing or display uses correct details.
- **Detect and handle changes** – When refreshed title/description/images differ from what we have: update local product; optionally log or flag “product content changed” for review; **Done:** `updateListing` now supports title and description; marketplace sync pushes them when they differ from the feed.
- **Listing creation and approval** – When creating or approving a listing, use the **current** product title, description, and images from the refreshed product so we never publish stale details.

**Implementation notes:** Product refresh already upserts the full product from `getProduct()` (including title, description, variants); ensure the source’s `getProduct()` returns full details and that we don’t overwrite with partial data. For marketplace updates: extend `TargetPlatform.updateListing` (or add a separate method) to support title/description if the Allegro/Temu APIs allow it; then in marketplace sync, compare fresh product to listing and push detail changes when supported.

---

After Batch 1 is implemented, proceed to Batch 2 when convenient; Batch 3 items can be scheduled when you add multi-quantity, multi-variant, or proactive stock UX.
