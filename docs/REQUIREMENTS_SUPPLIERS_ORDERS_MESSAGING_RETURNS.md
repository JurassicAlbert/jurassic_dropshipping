# Requirements: Suppliers detail, Allegro orders, buyer messaging, returns

This document captures clarified requirements for the **web admin panel** (Flutter app run in browser) and maps them to the current codebase. It is intended for prioritization and implementation.

---

## 1. Suppliers – very detailed info and regulations

### What you want

- **Very detailed info** per supplier.
- **All regulations** for each supplier, **with links** (e.g. to supplier T&C, return rules, country-specific rules).
- **Per supplier:** for **what type of products** what **return is allowed** (e.g. electronics: defect-only; clothing: 14d no-reason).
- **Per supplier:** see **what type of products we really benefit from** (profitability by product category/type so you know which segments are worth it).

### What exists today

- **Model:** `Supplier` ([lib/data/models/supplier.dart](lib/data/models/supplier.dart)) has: `id`, `name`, `platformType`, `countryCode`, `rating`, `returnWindowDays`, `returnShippingCost`, `restockingFeePercent`, `acceptsNoReasonReturns`, warehouse address/contact, `feedSource`, `shopUrl`.
- **Return policy:** `SupplierReturnPolicy` ([lib/domain/post_order/supplier_return_policy.dart](lib/domain/post_order/supplier_return_policy.dart)) has policy type (noReturns, defectOnly, returnWindow, fullReturns, etc.), return window days, restocking fee, who pays return shipping, RMA/warehouse/virtual restock flags – but it’s **one policy per supplier**, not per product type.
- **UI:** [lib/features/suppliers/suppliers_screen.dart](lib/features/suppliers/suppliers_screen.dart) shows a list with name, platform, country, rating, return window, no-reason flag, reliability score. No regulations links, no per–product-type return rules, no profitability-by-product-type.

### Gaps / extensions

| Need | Suggestion |
|------|------------|
| Regulations with links | Add to `Supplier` (or a related table): `regulationsUrl`, `termsUrl`, optional `returnPolicyUrl`. Show in supplier **detail** view and in list (e.g. “Regulations” link). |
| Return rules **per product type** | Either extend `SupplierReturnPolicy` to support **product-type/category** (e.g. categoryId or productType string) so one supplier can have multiple policies (e.g. “electronics” → defect-only, “clothing” → 14d no-reason), or add a new entity `SupplierReturnRule(supplierId, productType, policyType, ...)`. |
| “What products we benefit from” | Use existing orders/listings/analytics: **aggregate profit (or margin) by supplier and by product category/type** (e.g. from listing category or product metadata). Expose in a **Supplier detail** or **Supplier profitability** section (e.g. “Best categories for this supplier: X, Y, Z”). |

**Deliverables (for web admin):**

- Supplier **detail** screen (or expandable panel) with: all current fields + regulations/terms **links**.
- Return rules **per product type** (data model + UI: e.g. table “Product type / Return allowed” per supplier).
- Section “Product types we benefit from” per supplier (from orders/listings by category/type).

---

## 2. Orders – Allegro: new order, cancellation, delivery preference, parcel comment

### What you want

- **As soon as someone orders on Allegro** we get the info in the app (and if they **cancel a moment later**, we get that too).
- **How the buyer wants the parcel sent** (delivery method / preferences).
- **Any comments to the parcel** that we can pass to the **warehouse** (buyer’s message for the shipment).

### What exists today

- **Order sync:** [lib/services/order_sync_service.dart](lib/services/order_sync_service.dart) fetches orders from targets (Allegro) since a given time; new orders are inserted, status is synced (so **cancellation** can be detected when Allegro marks the checkout as CANCELLED).
- **Allegro:** [lib/services/targets/allegro_target_platform.dart](lib/services/targets/allegro_target_platform.dart) `getOrders()` uses `getCheckoutForms()` and maps `buyer`, `delivery.address`, line items, summary. It does **not** currently map:
  - Buyer’s **message/comment** for the order (if Allegro API provides it).
  - **Delivery method** or parcel preferences (e.g. “InPost”, “leave at parcel locker”, “delivery to address”).
- **Order model:** [lib/data/models/order.dart](lib/data/models/order.dart) has no `buyerMessage` or `deliveryMethod` / `parcelPreferences` field.

### Gaps / extensions

| Need | Suggestion |
|------|------------|
| New order + cancel shortly after | Already supported: sync runs periodically; status sync in `OrderSyncService` and `getOrderStatus()` (Allegro) set `cancelled` when Allegro says CANCELLED. Optionally **shorten sync interval** or add webhooks if Allegro supports them for near-instant updates. |
| How buyer wants parcel sent | Check Allegro API for checkout-form **delivery** (method name, point type, etc.). Add to Order, e.g. `deliveryMethodName`, `deliveryPointType` (or a JSON blob). Show in **order detail** and, if useful, in order list (e.g. “InPost Locker”). |
| Buyer comment for warehouse | If Allegro exposes a **buyer message** or “note to seller” on the checkout form, map it into Order, e.g. `buyerMessage` or `parcelComment`. Display in order detail and, if you have a “handoff” view for warehouse, show it there. |

**Deliverables (for web admin):**

- **Order model:** add optional `buyerMessage` (or `parcelComment`), optional `deliveryMethodName` (and optionally more delivery fields) from Allegro checkout form.
- **Allegro mapping:** in `allegro_target_platform.dart` (and Allegro client if needed), read from checkout-form payload the buyer message and delivery method; map into `Order` when creating/updating.
- **Orders UI:** show “Buyer message / parcel comment” and “Delivery method” in order card and/or order detail so you and the warehouse can use them.

---

## 3. Respond to buyers from the dropshipping app (no Allegro seller account)

### What you want

- **Reply to buyers from the admin app** instead of logging into the Allegro seller account (so all buyer communication in one place).

### What exists today

- **Message thread model:** [lib/data/models/message_thread.dart](lib/data/models/message_thread.dart) has `id`, `orderId`, `targetPlatformId`, `marketplaceAccountId`, `externalThreadId`, `status`, `lastMessageAt`, `unreadCount`, `createdAt` – i.e. structure for **threads per order per marketplace**.
- There is a `Message` model under [lib/data/models/message.dart](lib/data/models/message.dart) (referenced in grep). Allegro client has **after-sales** endpoints (e.g. rejection with `sellerComment`); need to confirm if Allegro REST API exposes **seller–buyer messaging** (get threads, get messages, send message).

### Gaps / extensions

| Need | Suggestion |
|------|------------|
| Allegro messaging API | Confirm Allegro REST/GraphQL: **list threads**, **get messages**, **send message** (e.g. after-sales / “ask seller” threads). If yes, add to `AllegroClient` (e.g. `getMessageThreads(orderId?)`, `getMessages(threadId)`, `sendMessage(threadId, text)`). |
| Sync threads/messages | Persist threads and messages in Drift (or reuse existing tables if present); sync when opening a thread or via background job. |
| Web admin UI | **Messaging** section or **Order detail** tab: list threads for the order (or global inbox); show messages; **compose reply** and send via API. So you never have to open Allegro seller account to answer. |

**Deliverables (for web admin):**

- Integration with Allegro **buyer–seller messaging** (if available): API methods + sync + storage.
- In admin: **“Messages”** or “Conversations” (per order or global) with **reply** so you can respond from the app.

---

## 4. Returns: buyer just sends parcel back (no chat, no reason)

### What you want

- **Buyer can simply send something back** – we may only get **info about the parcel** (e.g. return created, tracking), **without** any chat or reason from the buyer. The system should handle these “minimal info” returns.

### What exists today

- **Return request model:** [lib/data/models/return_request.dart](lib/data/models/return_request.dart) has `ReturnReason` (noReason, defective, wrongItem, damagedInTransit, other), `ReturnStatus`, `notes`, refund/shipping/restock fields, routing, etc. So **noReason** and optional **notes** already allow “no reason given”.
- **Allegro:** [lib/services/targets/allegro_client.dart](lib/services/targets/allegro_client.dart) has **customer returns** (BETA): `getCustomerReturns`, `getCustomerReturn`, reject/refund. Allegro may provide minimal data (e.g. return id, order id, status, maybe tracking) without buyer text or reason.
- **Returns UI:** [lib/features/returns/returns_screen.dart](lib/features/returns/returns_screen.dart) shows return cards; you already show reason and destination.

### Gaps / extensions

| Need | Suggestion |
|------|------------|
| Reason optional / unknown | Treat **reason** as optional when syncing from Allegro: if Allegro doesn’t send a reason, create `ReturnRequest` with `reason: ReturnReason.noReason` (or add `unknown`/`notProvided`) and make UI show e.g. “No reason given” or “Parcel return only”. |
| Parcel-only return | When Allegro only gives parcel/tracking info, store that (e.g. `returnTrackingNumber`, status) and show in returns list/detail as “Return parcel” or “Tracking: …” without requiring chat or reason. |
| UI copy | In returns list/detail, when there’s no reason or no message: show “Buyer sent parcel back (no reason or message provided)” so operators know it’s normal. |

**Deliverables (for web admin):**

- Sync Allegro returns even when **no reason/message**; map to `ReturnRequest` with default reason (e.g. noReason) and optional “parcel-only” flag or display logic.
- Returns UI: clearly show **parcel/tracking** and “No reason / no message” when that’s all we have.

---

## Summary table

| Area | Requirement | Current state | Action |
|------|-------------|----------------|--------|
| Suppliers | Detailed info, regulations with links | Basic supplier + return policy; no links, one policy per supplier | Add regulations/terms URLs; supplier detail view; return rules per product type; “products we benefit from” |
| Suppliers | Return allowed per product type | Single return policy per supplier | Model + UI for return rules by product type |
| Suppliers | See profitable product types per supplier | Not present | Analytics by supplier × category/type; show in supplier view |
| Orders | Get Allegro order (and cancel) | Sync + status sync in place | Keep; optional: shorter interval or webhooks |
| Orders | How buyer wants parcel sent | Not stored | Add delivery method from Allegro; show in order |
| Orders | Buyer comment for warehouse | Not stored | Add buyerMessage from Allegro; show in order |
| Messaging | Reply to buyers in app | MessageThread model only; no Allegro messaging integration | Allegro messaging API + sync + “Messages” / reply UI |
| Returns | Parcel-only returns (no chat/reason) | ReturnRequest has noReason; Allegro returns BETA | Sync returns without reason; UI “no reason/message” |

---

## Implementation order suggestion

1. **Orders:** Add `buyerMessage` and delivery method from Allegro (small model + mapping + UI) so warehouse and you see parcel comment and delivery.
2. **Returns:** Ensure Allegro returns sync and UI support “parcel only / no reason” cleanly.
3. **Suppliers:** Add regulations/terms links and supplier detail view; then return-by-product-type and “products we benefit from.”
4. **Messaging:** After confirming Allegro messaging API, add integration and reply-from-app UI.

This keeps the web admin panel as the single place for operations while aligning with Allegro and your supplier/return reality.
