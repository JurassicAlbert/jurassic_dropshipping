# Admin Web App — Navigation, Screens, Buttons & Settings

This document describes the admin web app’s navigation, every screen/view, all buttons and forms, and the overall theme/layout. Use it to review the UI and then request polish or UX changes.

---

## 1. Routes & navigation

### 1.1 All routes

| Path | Screen | Query params |
|------|--------|--------------|
| `/dashboard` | Dashboard | — |
| `/analytics` | Analytics | — |
| `/profit-dashboard` | Profit intelligence | — |
| `/products` | Products | — |
| `/orders` | Orders | `orderId`, `queued=1` |
| `/suppliers` | Suppliers | — |
| `/marketplaces` | Marketplaces | — |
| `/returns` | Returns | — |
| `/incidents` | Incidents | `orderId` |
| `/incidents/:id` | Incident detail | — |
| `/risk-dashboard` | Risk dashboard | — |
| `/returned-stock` | Returned stock | — |
| `/capital` | Capital | — |
| `/approval` | Approval queue | — |
| `/decision-log` | Decision log | `entityId` |
| `/return-policies` | Return policies | — |
| `/settings` | Settings | — |

### 1.2 Shell layout

- **Single shell:** All routes are inside one `ShellRoute`; `ShellScreen` wraps the current route and provides the same sidebar/drawer everywhere.
- **Navigation groups (rail / drawer):**
  - **MAIN:** Dashboard, Analytics, Profit, Products, Orders
  - **OPERATIONS:** Suppliers, Marketplaces, Returns, Incidents, Risk, Returned stock, Capital
  - **ADMIN:** Approval Queue, Decision Log, Return policies, Settings
- **Responsive:**
  - **Width ≥ 600px:** `NavigationRail` on the left (extended when width ≥ 800px) + vertical divider + main content.
  - **Width &lt; 600px:** Hamburger in AppBar opens a drawer with the same nav items; content area shows only the page (no rail).
- **AppBar:** Title = current route label (e.g. “Dashboard”, “Orders”). Optional badge from rules: “Read-only (no writes to marketplaces)” vs “Live writes enabled”. **Lock app** button calls auth lock (locks the app; user must re-authenticate).

### 1.3 Command palette

- **Shortcut:** **Ctrl+K** (or Cmd+K on macOS) opens the command palette from anywhere inside the shell.
- **Content:** Modal with search field; list of **routes** (all shell routes with label) and **actions** (e.g. "Jump to order…"). Typing filters by label; Enter or tap selects. Selecting a route navigates; selecting "Jump to order…" opens the Jump to order dialog.
- **Implementation:** `showCommandPalette(context, ref)` in `lib/features/shared/command_palette_overlay.dart`; shortcut in `ShellScreen` via `Shortcuts` + `Actions`.

---

## 2. Theme & layout (template)

- **Material 3**, `ColorScheme.fromSeed(seedColor: 0xFF1565C0)` for both light and dark.
- **Cards:** Elevation 0, 12px rounded corners, `surfaceContainerLow` background.
- **AppBar:** No center title, surface background, elevation 0, scrolledUnderElevation 1.
- **NavigationRail:** `surfaceContainerLow` background, `primaryContainer` indicator, selected/unselected icon colors.
- **Inputs:** Filled, `surfaceContainerLow`, outline border radius 12, content padding.
- **Filled / Outlined buttons:** Rounded 12, standard padding. **Chips:** Rounded 8. **Divider:** from `outlineVariant`.
- **Spacing:** `AppSpacing` (lib/features/shared/app_spacing.dart) defines 8px grid: xs=4, sm=8, md=12, lg=16, xl=24, xxl=32; cardPadding=16, sectionGap=24, cardGap=12.
- **Section headers:** `SectionHeader(title, subtitle?, icon?)` for dashboard and list screens; clear typography hierarchy via theme textTheme.
- **Empty states:** Use `EmptyState` with title, subtitle, and optional `action` (e.g. "Go to Dashboard"); consistent copy e.g. "No products found. Run a supplier scan to import available products."
- **Help system:** `ScreenHelpSection(description)` at top of each view; copy in `screen_help_texts.dart`. Tooltips on important buttons (e.g. Refresh listing health, Scan, Approve/Reject). Form fields use `InputDecoration.helperText` where needed (Settings: Min profit %, Pricing strategy, Incident rules).

---

## 3. Screen-by-screen: views, buttons, actions

### 3.1 Dashboard (`/dashboard`)

- **Purpose:** Overview KPIs, automation timers, listings/orders summary, observability, and scan trigger.
- **View:** Scrollable; pull-to-refresh invalidates listings, orders, returns, rules, listing health, customer metrics.
- **Content:**
  - Title: “Dashboard”.
  - **KPI cards:** Profit margin, return rate, weekly revenue, avg order value.
  - **Profit chart** (time series).
  - **System status panel:** Automation ACTIVE/PAUSED, jobs queued, automation health, last run times (supplier sync, marketplace sync, price refresh, scan) with delay warning if >2h.
  - **Automation timeline:** Card with 5–10 recent events (e.g. “Supplier sync finished”, “Price refresh completed”) and “X min ago”; derived from scheduler last run times.
  - **Automation card:** Timers for scan/sync/price refresh/marketplace sync/product refresh/low-stock/job processor.
  - **Listings and Orders summary cards** (counts/summaries).
  - **Row of buttons:**
    - **Refresh listing health** — Recomputes per-listing return/incident and late delivery rates; can auto-pause poor listings if rules say so.
    - **Refresh customer metrics** — Updates customer return/complaint rates used for abuse checks.
    - **Refresh stock state** — Refreshes inventory/sellability state.
    - **Refresh observability** — Refreshes Phase 32 observability metrics.
  - **Observability card** — Phase 32 metrics chips.
  - **Run scan card** with **Scan** button — Triggers product scan (find products, create/update listings).

### 3.2 Analytics (`/analytics`)

- **Purpose:** Deeper analytics on orders, listings, returns, suppliers (KPIs, charts, issues).
- **View:** Single scrollable column; pull-to-refresh for orders, listings, suppliers, returns.
- **Content:** Title “Analytics”; summary KPI row; margin-strategy KPI; profit-by-platform chart; profit-by-product list; issues/alerts; profit trend chart; returns analysis. No primary action buttons; read-only analytics.

### 3.3 Products (`/products`)

- **Purpose:** List all listings (products listed on marketplaces) with search and status filter.
- **View:** Search + filter chips, then list of cards (or empty state). Pull-to-refresh.
- **Search:** By listing ID or product ID.
- **Filter chips:** All, Active, Pending, Draft.
- **List:** Each card shows listing ID, status, sell/cost/profit, optional extra info; tap opens nothing (list only).
- **Empty state:** “No listings yet — Run a scan from Dashboard to find products”.

### 3.4 Orders (`/orders`)

- **Purpose:** List orders with search/filters; backfill lifecycle; open return/incident flows; optional highlight or “queued for capital” filter.
- **View:** Search bar + filter chips, then list of order cards. Supports `?orderId=...` (highlight) and `?queued=1` (filter to queued for capital).
- **Search:** By order ID or tracking number.
- **Filter chips:** All, Pending, Shipped, Failed, Queued for capital.
- **Button:** **Backfill lifecycle** — Backfills order lifecycle state from marketplace where needed.
- **Per order card:** Target order ID, status chip, sell/cost/profit, optional inventory snapshot, “Queued for capital”, risk score, financial/lifecycle state. **Actions (links/buttons):**
  - **Set lifecycle / Change lifecycle** — Opens dialog to set/change order lifecycle state.
  - **View failure reason** — Shown for failed orders with decision log; opens dialog with failure reason.
  - **Create return / complaint** — Opens dialog to create a return or complaint for that order.
  - **View incidents** — Navigates to `/incidents?orderId=...`.

### 3.5 Approval queue (`/approval`)

- **Purpose:** Manually approve or reject pending listings and pending orders.
- **View:** Two sections: “Pending listings”, “Pending orders”. Each section refreshable. Per item: card with actions.
- **Pending listings — per item:**
  - **Reject** — Sets listing to draft (does not publish).
  - **Approve** — Publishes listing to target marketplace; shows stock at source.
- **Pending orders — per item:**
  - **Reject** — Cancels the order on the marketplace.
  - **Approve & Fulfill** — Enqueues fulfillment job (places order at supplier).
- **Empty state:** When nothing pending, message that there are no pending items.

### 3.6 Suppliers (`/suppliers`)

- **Purpose:** List all suppliers with key details and reliability scores.
- **View:** List of supplier cards; pull-to-refresh. One action above list.
- **Button:** **Refresh reliability scores** — Re-evaluates supplier reliability scores for all suppliers.
- **Per card:** Supplier name, platform type avatar, rating, country, return window, “accepts no-reason returns”, optional reliability score. No per-row buttons; list only.

### 3.7 Marketplaces (`/marketplaces`)

- **Purpose:** Show stats per target platform and connection status.
- **View:** List of marketplace cards; pull-to-refresh. Read-only.
- **Per card:** Display name (Allegro, Temu, Amazon, or platform id), “Connected”/“Not connected” chip, order/revenue stats. No action buttons on cards.

### 3.8 Returns (`/returns`)

- **Purpose:** List return requests; search/filter; edit return (status, amounts, routing, add to returned stock).
- **View:** Search + filter chips, then list of return cards. Tap card opens edit dialog.
- **Search:** By order ID.
- **Filter chips:** All, Requested, Approved, Refunded.
- **Per card:** Tap opens **Edit return** dialog.
- **Edit return dialog:** Title “Edit return &lt;id&gt;”.
  - **Fields:** Status (dropdown), Refund amount, Return shipping cost, Restocking fee, Notes. Display of routing if set.
  - **If status = Received:** Checkbox “Add to returned stock” (create returned-stock entry for 1 unit).
  - **Compute routing** — Recomputes return routing from rules/supplier/policy.
  - **Cancel** — Close without saving.
  - **Save** — Saves return request; if “Add to returned stock” checked, creates returned-stock entry and shows snackbar.

### 3.9 Incidents (`/incidents`)

- **Purpose:** List incident records; optional filter by order; create incident; open incident detail.
- **View:** When `?orderId=...`: chip “Order: &lt;id&gt;” with delete + “Show all” link. Then list of incident cards or empty state. Button “Create incident” at bottom when empty.
- **Filter:** Chip removes order filter and goes to `/incidents`; “Show all” same.
- **Button:** **Create incident** — Opens dialog to create a new incident (order, type, etc.).
- **Per card:** Tap navigates to **Incident detail** (`/incidents/:id`). Card shows order, type, status, summary.

### 3.10 Incident detail (`/incidents/:id`)

- **Purpose:** Show one incident; link to order and decision log; enqueue “process incident” job.
- **View:** Detail layout: fields (order, type, status, dates, etc.), then actions.
- **Buttons:**
  - **View order** — Go to `/orders?orderId=...`.
  - **View decision log** — Go to `/decision-log?entityId=...` (order id).
  - **Process (enqueue job)** — Only if status is Open; enqueues background job to process the incident. Snackbar: “Process incident job enqueued”.

### 3.11 Returned stock (`/returned-stock`)

- **Purpose:** List returned stock by product/supplier (quantity, condition, restockable); reduce quantity or write off.
- **View:** List of stock cards. No search/filter.
- **Per card:** Product ID, supplier, quantity, condition, source order/return, “Not restockable” chip if applicable. **View order** link if source order present.
- **If restockable and quantity &gt; 0:**
  - **Reduce** — Opens dialog “Reduce quantity”; user enters amount to deduct (1–current qty); **Reduce** applies decrement; **Cancel** closes.
  - **Write off** — Confirm dialog “Mark as not restockable?”; **Write off** sets restockable = false; **Cancel** cancels.

### 3.12 Capital (`/capital`)

- **Purpose:** Show available balance, add adjustments, see recent ledger activity, see orders queued for capital.
- **View:** Scrollable: balance card, “Add adjustment” card, recent ledger list, “Orders queued for capital” card.
- **Balance card:** “Available capital” and amount in PLN (green if ≥ 0, red if &lt; 0).
- **Add adjustment card:**
  - **Fields:** Amount (PLN), Note (optional).
  - **Button:** **Record adjustment** — Records a capital adjustment (positive or negative); clears fields; invalidates balance and recent entries; snackbar confirms.
- **Recent ledger:** List of recent ledger entries. **Export CSV** (or similar) — Exports recent ledger to CSV in a dialog (copy/paste).
- **Orders queued for capital:** Count and up to 5 order tiles; each tile links to `/orders?orderId=...`. **View in Orders** — Goes to `/orders?queued=1`.

### 3.13 Decision log (`/decision-log`)

- **Purpose:** List decision log entries (scanner/automation decisions); optional filter by entity (e.g. order id).
- **View:** When `?entityId=...`: chip “Order: &lt;id&gt;” + “Show all”. List of cards (reason, type, entityId, date). Pull-to-refresh.
- **Empty state:** “No decisions for this order” or “No decisions logged” with short subtitle.
- **No buttons** on list items; read-only.

### 3.14 Return policies (`/return-policies`)

- **Purpose:** View and edit supplier return policies (routing, restock, RMA, etc.).
- **View:** List of policy cards; tap opens add/edit dialog. One primary button.
- **Button:** **Add policy** — Opens same dialog as edit but empty (new policy).
- **Per card:** Tap opens **Edit policy** dialog (or “Add policy” dialog).
- **Policy dialog:** Fields: supplier id, policy type, return window days, restocking fee %, who pays return shipping, requires RMA, warehouse return supported, virtual restock supported. **Save** / **Cancel** (and **Delete** if editing). Saving persists policy; dialog closes.

### 3.15 Settings (`/settings`)

- **Purpose:** Plan/usage, rules (pricing, fees, thresholds, addresses, incidents, risk, abuse, shipping, listing health, price refresh), API features info, feature flags, connections (CJ, Allegro, API2Cart, Temu), appearance, developer tools.
- **View:** Long scrollable form; many cards. **Save rules** only saves the Rules card; other sections save on their own buttons or toggles.

---

## 4. Settings — Forms and buttons (detailed)

### 4.1 Plan & usage (card)

- **Read-only.** Shows: plan name, listings count (and limit if not unlimited), orders this month (and limit if not unlimited). If over limit, warning: “Limit reached. Upgrade your plan to add more listings or orders.”

### 4.2 Rules (card)

- **Save rules** button at bottom of this card — Validates and saves all rules below; shows “Rules saved successfully!” banner; invalidates rules provider.
- **Dismiss** (on banner) — Hides the success banner.

**Fields (all in one card):**

- Search keywords (comma-separated)
- Min profit %
- Default markup %
- Pricing strategy (dropdown): Always 0.01 below lowest (if safe), Premium when better reviews, Match lowest (if safe), Fixed markup, List at min even if above lowest, Return-rate aware
- Allegro fee %, Temu fee %
- Allegro payment fee %, Temu payment fee %
- Per-category min profit (e.g. electronics:25, toys:20)
- Premium % when better reviews
- Min sales count for premium pricing
- **Switch:** Enable KPI-driven strategy suggestions
- Seller return address: Street, City, ZIP, Country code
- Incident decision rules (JSON) — text area, hint for format
- Risk score threshold (0–100, empty = off)
- Customer abuse: Max return rate %, Max complaint rate %
- Return-rate pricing: Default return rate %, Default return cost per unit (PLN)
- **Checkbox:** Block fulfillment when insufficient stock
- **Checkbox:** Auto-pause listing when margin below threshold
- Shipping validation: Default supplier processing (days), Default supplier shipping (days), Marketplace max delivery (days)
- Listing health: Max return+incident rate %, Max late delivery rate %
- **Checkbox:** Auto-pause listing when health poor
- Price refresh (per warehouse): Source refresh interval (e.g. cj:720, api2cart:360)

### 4.3 Integrations / API features (card)

- **Informational only.** Text explaining: connect marketplaces in Settings; when switching to real APIs use “API features” as checklist. List of **feature descriptions** (no toggles here): Targets read-only, Manual approval for orders, Manual approval for listings, Temu/Amazon targets, Marketplace messaging (future). Link to MANUAL_API_FEATURES.md.

### 4.4 Feature flags (card)

- **Toggle:** Enable Temu target — Show Temu in target marketplaces (experimental). Saved immediately.
- **Toggle:** Enable marketplace messaging — Show Messages/inbox when implemented. Saved immediately.

### 4.5 CJ Dropshipping (card)

- **Fields:** CJ Email, CJ API Key (obscured).
- **Button:** **Save CJ credentials** — Saves to secure storage, ensures token; snackbar “CJ connected.” or “CJ token failed.”

### 4.6 Allegro (card)

- **Fields:** Client ID, Client Secret (obscured).
- **Status:** “Connected” (green) / “Not connected” (red).
- **Button:** **Connect Allegro (OAuth)** — Saves credentials, runs OAuth flow; snackbar “Allegro connected!” or “Allegro OAuth failed.”

### 4.7 API2Cart (card)

- **Fields:** API Key, Store Key (obscured).
- **Button:** **Save API2Cart credentials** — Saves to secure storage; snackbar “API2Cart credentials saved.”

### 4.8 Temu (card)

- (If present) Same pattern: credentials + connect/save button.

### 4.9 Appearance (card)

- **Segmented control:** Theme — **System** | **Light** | **Dark**. Selected value is persisted (theme mode provider).

### 4.10 Developer tools (card)

- **Load demo data** — Seeds DB with demo data (orders, listings, products, etc.); invalidates relevant providers; snackbar with counts.
- **Load heavy demo data (~20k orders)** — Same but heavy seed; snackbar with counts.
- **Drop all data** — Confirmation dialog “Drop all data?”; **Delete everything** confirms and drops all data; **Cancel** cancels. Snackbar “All data dropped.” or error.

---

## 5. Summary: buttons and actions by intent

| Action | Where | What it does |
|--------|--------|--------------|
| Lock app | AppBar (shell) | Locks app; user must re-authenticate |
| Refresh listing health | Dashboard | Recomputes listing health; may auto-pause poor listings |
| Refresh customer metrics | Dashboard | Updates customer return/complaint metrics |
| Refresh stock state | Dashboard | Refreshes inventory/sellability |
| Refresh observability | Dashboard | Refreshes observability metrics |
| Scan | Dashboard | Runs product scan |
| Backfill lifecycle | Orders | Backfills order lifecycle from marketplace |
| Set/Change lifecycle | Orders (per order) | Dialog to set order lifecycle |
| View failure reason | Orders (failed) | Dialog with failure reason from decision log |
| Create return / complaint | Orders (per order) | Dialog to create return for that order |
| View incidents | Orders (per order) | Go to incidents filtered by order |
| Reject (listing) | Approval | Set listing to draft |
| Approve (listing) | Approval | Publish listing to marketplace |
| Reject (order) | Approval | Cancel order on marketplace |
| Approve & Fulfill | Approval | Enqueue fulfillment job |
| Refresh reliability scores | Suppliers | Re-evaluate all supplier scores |
| Compute routing | Returns (edit dialog) | Recompute return routing |
| Save (return) | Returns (edit dialog) | Save return + optionally add to returned stock |
| Create incident | Incidents | Dialog to create new incident |
| View order | Incident detail | Go to order |
| View decision log | Incident detail | Go to decision log filtered by entity |
| Process (enqueue job) | Incident detail | Enqueue process-incident job |
| Reduce | Returned stock (per card) | Reduce quantity by amount (dialog) |
| Write off | Returned stock (per card) | Mark as not restockable |
| Record adjustment | Capital | Add capital adjustment (PLN) |
| Export CSV | Capital (ledger) | Export ledger to CSV (dialog) |
| View in Orders | Capital (queued) | Go to orders with queued=1 |
| Add policy | Return policies | Open add/edit policy dialog |
| Save / Delete | Return policies (dialog) | Save or delete policy |
| Save rules | Settings (Rules card) | Save all rules fields |
| Enable Temu / messaging | Settings (Feature flags) | Toggle feature flags (immediate) |
| Save CJ credentials | Settings (CJ) | Save and test CJ connection |
| Connect Allegro (OAuth) | Settings (Allegro) | Save and OAuth Allegro |
| Save API2Cart credentials | Settings (API2Cart) | Save API2Cart keys |
| Theme: System/Light/Dark | Settings (Appearance) | Set theme mode |
| Load demo data | Settings (Developer) | Seed demo data |
| Load heavy demo data | Settings (Developer) | Seed heavy demo |
| Drop all data | Settings (Developer) | Delete all data (with confirm) |

---

## Scale checklist (Phase 17)

- **Virtualized lists:** All main list screens use `ListView.builder` (Orders, Products, Returns, Incidents, Suppliers, Marketplaces, Returned stock, Return policies). No screen builds a full list of children in memory. The shell drawer uses a small fixed `ListView` for nav items only.
- **Pagination design (when scaling to 100k products, 50k listings, 10k orders/day):**
  - **Orders (priority):** Add `getOrders(limit, offset, {search?, status?, orderId?})` to `OrderRepository` (Drift already supports limit/offset). Add a paginated provider (e.g. `ordersPaginatedProvider`) that holds page index and exposes `list`, `hasNextPage`, `loadMore()`. UI: keep `ListView.builder`; trigger `loadMore()` on scroll-to-end or "Load more" button; show loading indicator when loading next page.
  - **Products / Listings:** Same pattern: `getListings(limit, offset, {search?, status?})` and paginated provider.
  - **Returns / Incidents:** Paginate after Orders and Listings if needed.
  - Filter chips and search should refetch with new params (server-/DB-side filtering) so only matching rows are loaded.

---

You can use this document to decide what to polish or change (labels, grouping, order of sections, missing actions, or theme/layout) and then ask for concrete UI/UX updates.
