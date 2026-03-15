## API-driven features to enable after connecting real accounts

This app is designed to run safely in a "read-mostly" / demo mode by default.
When you first connect **real marketplace and supplier APIs**, use this checklist
to decide what to turn on.

### 1. Global safety switches (Settings → Rules)

- **Targets read-only (`targetsReadOnly`)**
  - Default: **ON** (true) for real accounts; OFF only when you are ready.
  - When ON, automation will:
    - Not create/update listings on marketplaces.
    - Not auto-cancel marketplace orders.
    - Not push tracking numbers to marketplaces.
  - Turn OFF only after:
    - You have verified price/stock sync logic on a test listing.
    - You are comfortable with auto-fulfill behaviour.

- **Manual approval for orders (`manualApprovalOrders`)**
  - Default: **ON**.
  - When ON, new orders come in as **Pending approval** and require a manual click.
  - Consider turning OFF only after:
    - You have processed several orders manually end‑to‑end without surprises.

- **Manual approval for listings (`manualApprovalListings`)**
  - Default: **ON**.
  - Keeps auto-scanned products as drafts until you approve them.

### 2. Platform integrations (Settings → Integrations)

- **CJ Dropshipping**
  - Enter email + API key.
  - Confirm token in the "Save CJ credentials" action.
  - Once CJ is healthy, you can rely on it as a source for fulfillment.

- **Allegro**
  - Enter Client ID + Client Secret.
  - Run **Connect Allegro (OAuth)**.
  - Verify in Marketplaces screen that Allegro shows as **Connected** and that:
    - New orders appear in Orders list.
    - Price/stock updates behave as expected for a single test listing.

- **API2Cart**
  - Enter API key + Store key.
  - Use for shop platforms that are supported via API2Cart.

- **Temu (target)**
  - The app ships with Temu as a **stub** target.
  - It is **gated in code** via `kEnableTemuTarget` in `app_providers.dart`.
  - Only set `kEnableTemuTarget = true` when:
    - Temu exposes an official, stable seller API you want to use.
    - You have audited the Temu client and target implementations.

- **Amazon (target)**
  - Currently a stub (`AmazonStubTarget`).
  - Throws `UnsupportedError` for create listing and returns empty orders.
  - Implement SP‑API + OAuth before using it in production.

### 3. Auto-fulfillment behaviour

- Auto-fulfill currently depends on:
  - `manualApprovalOrders` (must be OFF to auto‑fulfill).
  - `targetsReadOnly` (must be OFF to write to marketplaces).
  - Healthy mappings:
    - Order → Listing (by `listingId` or target listing id).
    - Listing → Product (+ optional variant).
    - Product → Source platform.
- For safety, keep:
  - `manualApprovalOrders = true`
  - `targetsReadOnly = true`
  while you:
  1. Sync orders from marketplaces.
  2. Verify mapping and analytics in UI.
  3. Manually fulfill a few orders via CJ / source UI.

### 4. Mapping diagnostics (Decision log)

- When fulfillment cannot map an order to listing/product/source/target, the app:
  - Sets order status to `failed` or `failedOutOfStock`.
  - Writes a **DecisionLog** entry of type `order` with:
    - Order id, listing id, product id, platforms.
    - A `failureType` (e.g. `listing_not_found`, `product_not_found_or_no_variants`).
  - Links the log to the order via `order.decisionLogId`.
- Use the **Decision log** screen to understand why an order did not auto‑fulfill.

### 5. When you are finally ready for “live” automation

Enable in this order:

1. **Leave `targetsReadOnly = true`**, but:
   - Connect CJ, Allegro, API2Cart.
   - Confirm that:
     - Orders import correctly.
     - Listings, prices, stock look correct.
2. **Turn `targetsReadOnly = false`** for a **small test set**:
   - Keep `manualApprovalOrders = true`.
   - Approve a handful of orders and watch fulfillment + tracking.
3. When you are confident:
   - Consider turning `manualApprovalOrders = false` to enable auto‑fulfill.
   - Keep monitoring the Decision log for mapping failures and out‑of‑stock.

### 6. Pricing strategy and KPI-driven strategy

- **Pricing strategies** (Settings → Rules, or `UserRules.pricingStrategy`):
  - **always_below_lowest** (default): Target price = lowest competitor − 0.01, only if ≥ P_min.
  - **premium_when_better_reviews**: If our listing has enough sales and our rating &gt; category/similar average, allow a small premium % above lowest; otherwise same as always_below_lowest.
  - **match_lowest**: Target = lowest competitor (if ≥ P_min).
  - **fixed_markup**: Ignore competitors; use fixed markup and marketplace fee only.
  - **list_at_min_even_if_above_lowest**: Even if P_min (our safe minimum) is above the current lowest competitor price, still create the listing at **P_min**. When P_min ≤ lowest, it behaves like always_below_lowest (0.01 below, but never below P_min). This is useful when you explicitly want offers listed for KPI/learning, even if they are not the cheapest.
- **P_min** (minimum selling price) is computed from: source cost + per-category min profit % (or global `minProfitPercent`) and **total fee** (marketplace fee + payment fee). Payment fees are configurable per platform in `UserRules.paymentFees`.
- **KPI-driven strategy** (`kpiDrivenStrategyEnabled`):
  - When ON, the app can use a `KpiStrategySnapshot` (e.g. conversion or margin by strategy) to suggest or auto-select a strategy instead of the fixed one.
  - Currently a **placeholder**: pass `KpiStrategySnapshot(recommendedStrategy: '...')` into the pricing decision when you have analytics that recommend a strategy; the engine will use it when the toggle is ON.
  - Future: compute `recommendedStrategy` from orders/listings/analytics (e.g. “switch to always_below_lowest if conversion drops”) and optionally persist which strategy was used per listing for analysis.

### 7. Marketplace messaging (optional, future)

Messaging is intentionally **not** enabled by default. When marketplaces expose
stable messaging APIs you want to use, enable this in phases:

1. **Phase 1 – Read-only sync (recommended first)**
   - Implement `MessageThread` (per order) and `Message` models in the database.
   - Implement a messaging client per marketplace (e.g. Allegro) that can **fetch**
     conversation history, but does **not send** messages yet.
   - Add a `Messages` tab and “Messages” buttons on Orders/Returns that only
     show threads and internal notes.

2. **Phase 2 – Opt-in sending from app**
   - Add a feature flag in code, e.g. `kEnableMessages = true` and
     `kAllowSendingMessages = false` by default.
   - Once read-only sync looks correct, add a Settings switch
     “Allow sending replies from app (beta)”.
   - Only when you are confident in behaviour and rate limits, set this switch
     to ON so replies typed in the app are actually sent through marketplace APIs.

3. **Always keep safety in mind**
   - Never auto-send templated messages without a human click.
   - Handle API failures gracefully and log them (rate limits, timeouts, etc.).
   - Prefer storing important decisions in `ReturnRequest` and `DecisionLog`
     alongside the conversation so automation can still work even if messaging
     APIs change later.

### 8. Per-account targets / multi-account (optional, future)

The schema already supports multiple marketplace accounts via:

- `MarketplaceAccounts` table (`marketplace_accounts`) with:
  - `accountId`, `platformId` (e.g. `allegro`, `temu`), `displayName`, `isActive`.
- `marketplaceAccountId` column on `Listings` and `Orders`.

To keep things simple and safe, the app currently behaves as **one account per
platform** and usually ignores `marketplaceAccountId`. When you later want
true multi-account behaviour:

1. **Routing listings and orders**
   - Ensure that:
     - Each listing has `marketplaceAccountId` set to the correct
       `MarketplaceAccount.accountId`.
     - Orders imported from targets set `order.marketplaceAccountId`
       (based on which account’s token/API key was used).

2. **Per-account targets**
   - Instead of a single `TargetPlatform` instance per platform, consider
     maintaining one per `MarketplaceAccount` (e.g. one Allegro target per
     connected Allegro account) and route:
     - Listing creation by `listing.marketplaceAccountId`.
     - Fulfillment and cancellation by `order.marketplaceAccountId`.

3. **Safety when enabling multi-account**
   - Start with **read-only** behaviour per account (only fetching orders and
     listings) and verify that each account’s data is separated correctly.
   - Only then enable writes (create listings, cancel orders, push tracking)
     per account, still respecting `targetsReadOnly` and manual approval flags.

