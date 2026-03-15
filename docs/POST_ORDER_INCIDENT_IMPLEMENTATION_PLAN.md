# Post-Order Incident & Returns – Implementation Plan

**Jurassic Dropshipping** – Extension of the existing architecture for robust post-order incident and returns handling. This plan **extends** current models and services; it does not replace them.

---

## Implementation status & notes (as of 15.03.2026)

- **Phases 1–11, 13–18** (lifecycle, policies, incidents, capital, risk, return-rate pricing, inventory) are implemented in code; UI exists for incidents, returns, returned stock, capital, settings (rules, risk threshold, return-rate).
- **Phase 12 (Allegro returns/refunds):** Implemented using **Allegro API documentation from 2024** (customer-returns BETA, payments/refunds). **Note:** Once you have an Allegro seller account, please provide current API docs or endpoints — the implementation may need updates (paths, request/response shapes, headers) to match Allegro’s current API. Until then, the existing integration is kept as a placeholder and can be adjusted when you share the up-to-date seller API.
- **Optional next steps (most done):** Incident detail screen added (route `/incidents/:id`, view + “View order” + “Process” for open incidents). Further: use InventoryService in listing/fulfillment when desired; InventoryService in fulfillment (warning when availableToSell &lt; order qty). Ledger export: Capital "Export CSV". Allegro disputes when API available.
- **Extended plan (below):** Phases 19–33 add scalability, resilience, and observability. **Implemented:** 19 (safetyStockBuffer, lastStockCheckAt), 23 (update_listing job, throttling), 25 (CustomerMetrics, abuse thresholds), 28 (StockState, fast path), 29 (offer change to catalog_event/update_listing; per-warehouse price refresh), 30 (CatalogCache, invalidation on catalog_event), 31 (catalog_event job and handler, PriceRefreshService emits events), 32 (ObservabilityMetrics, dashboard, periodic log). Phase 27 principles only. 22 (ResilientSourcePlatform), 24, 26 implemented earlier.

---

## 1. Current architecture (as-is)

### Models (existing)
- **Order**: id, listingId, targetOrderId, targetPlatformId, customerAddress, **status** (pending, pendingApproval, sourceOrderPlaced, shipped, delivered, failed, failedOutOfStock, cancelled), sourceOrderId, sourceCost, sellingPrice, quantity, trackingNumber, decisionLogId, marketplaceAccountId, promisedDeliveryMin/Max, deliveredAt, approvedAt, createdAt.
- **ReturnRequest**: id, orderId, ReturnReason (noReason, defective, wrongItem, damagedInTransit, other), ReturnStatus (requested, approved, shipped, received, refunded, rejected), refundAmount, returnShippingCost, restockingFee, returnDestination (toSupplier, toSeller), supplierId, productId, sourcePlatformId, targetPlatformId, return tracking/address fields.
- **Supplier**: id, name, platformType, **returnWindowDays**, **returnShippingCost**, **restockingFeePercent**, **acceptsNoReasonReturns**, warehouse address/contact, feedSource, shopUrl.
- **DecisionLog**: id, type (listing, order, supplier, profitAlert), entityId, reason, criteriaSnapshot, createdAt.
- **UserRules**: sellerReturnAddress, marketplaceReturnPolicy (returnWindowDays, etc.), plus pricing/approval rules.

### Services (existing)
- **OrderSyncService**: polls targets, inserts orders (pending/pendingApproval), syncs cancellation from target.
- **FulfillmentService**: placeOrder at source, update tracking, OOS handling, cancel on target when OOS.
- **MarketplaceListingSyncService**: sync stock from sources to targets, refresh products.
- **PriceRefreshService**: refresh stale supplier offers; triggers ProfitGuard.
- **AutomationScheduler**: timers for scan, order sync, price refresh; enqueues fulfill_order jobs; processes job queue.
- **OrderCancellationService**: cancelOrder on target/source, syncOrderStatusFromTarget, create return request for “cancel after shipped”.

### Database
- Tables: Products, Listings, Orders, DecisionLogs, UserRulesTable, Suppliers, SupplierOffers, Returns, MarketplaceAccounts, MessageThreads, Messages, FeatureFlags, BackgroundJobs, DistributedLocks, BillingPlans, TenantPlans.
- Returns table stores return_request data; Suppliers has return-related columns.

---

## 2. Phase-by-phase design (extend vs add)

### PHASE 1 — Post-order lifecycle

**Existing:** `Order.status` enum (8 values). No formal state machine.

**Extend:**
- **Option A (recommended):** Add a **lifecycle state** alongside status for post-order flows, so existing status remains the source of truth for sync/fulfillment and the lifecycle layer adds return/complaint/refund semantics.
- **Option B:** Extend `OrderStatus` with new values (returnRequested, returnApproved, returned, complaintOpened, refunded). This requires migrating all usages and sync logic.

**Recommendation: Option A.**

- **New:** `OrderLifecycleState` enum (or table `order_lifecycle` with one row per order):
  - **Values:** created, pendingApproval, approved, sentToSupplier, shipped, delivered, returnRequested, returnApproved, returned, complaintOpened, refunded, failed, cancelled.
- **Mapping:** Keep `Order.status` for sync/fulfillment; derive or persist `OrderLifecycleState` from status + return/complaint data (e.g. when ReturnRequest exists and status = requested → lifecycle = returnRequested).
- **New domain service:** `PostOrderLifecycleEngine`
  - Holds allowed transitions (e.g. delivered → returnRequested; returnRequested → returnApproved → returned → refunded).
  - `canTransition(order, fromState, toState) -> bool`.
  - `transition(order, toState)` validates and updates lifecycle (and optionally Order.status where it aligns).
- **Schema:** Either add column `order_lifecycle_state` to Orders (migration) or new table `order_lifecycle` (orderId, state, updatedAt). New table is cleaner for history later.

**Schema change:**
- Add `order_lifecycle_state` text column to Orders (nullable, backfill from status + returns), or add table `OrderLifecycle` (orderId PK or unique, state, updatedAt).

**Future refinements (extend existing engine, do not replace):**
- Optional additional lifecycle states for finer supplier/carrier tracking: **awaitingSupplierConfirmation**, **supplierAccepted**, **supplierRejected**, **inTransit**, **returnRejected**, **replacementSent**. Integrate into `PostOrderLifecycleEngine` allowed transitions when supplier/carrier APIs provide these signals.
- **Corner cases:** (1) Duplicate marketplace events — idempotency by orderId + eventId or timestamp in sync layer. (2) Late delivery updates — allow transition to delivered from shipped/inTransit when update arrives; no duplicate fulfillment. (3) Supplier rejection after order placement — transition to supplierRejected then failed or cancelled; trigger incident/refund flow; keep existing status/lifecycle mapping.

---

### PHASE 2 — Supplier return policy (flexible)

**Existing:** Supplier has returnWindowDays, returnShippingCost, restockingFeePercent, acceptsNoReasonReturns. No policy type enum or RMA/warehouse flags.

**Extend:**
- Add **SupplierReturnPolicy** as a first-class model (new table or extend Suppliers with new columns).
- **New table `supplier_return_policies`** (or columns on Suppliers):
  - supplierId (FK or 1:1 with Suppliers).
  - **policyType** enum: NO_RETURNS, DEFECT_ONLY, RETURN_WINDOW, FULL_RETURNS, RETURN_TO_WAREHOUSE, SELLER_HANDLES_RETURNS.
  - returnWindowDays, restockingFeePercent (already on Supplier; can move or duplicate here).
  - **returnShippingPaidBy** enum: SELLER, CUSTOMER, SUPPLIER.
  - **requiresRma** bool.
  - **warehouseReturnSupported** bool.
  - **virtualRestockSupported** bool.
- **Domain model:** `SupplierReturnPolicy` (freezed) with above fields; repository `SupplierReturnPolicyRepository` (getBySupplierId, upsert). If one policy per supplier, 1:1 table or extra columns on Suppliers.

**Schema change:**
- New table `SupplierReturnPolicies` (supplierId PK or unique, policyType, returnWindowDays, restockingFeePercent, returnShippingPaidBy, requiresRma, warehouseReturnSupported, virtualRestockSupported) **or** add these columns to Suppliers and deprecate/keep old return columns for backward compatibility.

**Corner cases:** Supplier requires RMA before return — use `requiresRma`; workflow waits for RMA before creating/approving return. Supplier rejects return after inspection — handle via incident (supplierRejected); optional refund without return or dispute. Supplier charges restocking fee — already in policy and ReturnRequest; apply in financial impact and decision rules.

---

### PHASE 3 — Incident-handling engine

**Existing:** No incident model or incident-type handling. Fulfillment handles OOS and failure; OrderCancellationService handles cancel-after-shipped (creates ReturnRequest).

**Add (new):**
- **IncidentType** enum (or table): customer_return_14d, complaint_defect, parcel_not_collected, courier_damage, wrong_item_supplier, supplier_oos, delivery_delayed, customer_claims_damaged_after_open, partial_refund, supplier_rma_return, supplier_warehouse_return, parcel_after_awizo, courier_delivered_damaged, item_missing_in_parcel, etc.
- **IncidentRecord** model + table:
  - id, orderId, incidentType, status (open, supplier_contacted, marketplace_contacted, resolved), trigger (manual, webhook, sync), automaticDecision (e.g. auto_refund_without_return), supplierInteraction (none, rma_requested, return_sent), marketplaceInteraction (refund_issued, dispute_opened), refundAmount, financialImpact (total cost impact), createdAt, resolvedAt, decisionLogId.
- **IncidentHandlingEngine** (domain service):
  - For each incident type: **trigger** (when to create IncidentRecord), **automatic decision rules** (e.g. if returnShippingCost > productCost → autoRefundWithoutReturn), **supplier interaction** (call supplier API or RMA flow), **marketplace interaction** (refund, dispute), **refund handling**, **financial impact** (formula or stored value).
  - Methods: `handleIncident(incident)`, `suggestDecision(incident, context) -> IncidentDecision`.
- **Decision context:** product price, shipping cost, supplier return policy, customer rating (if we have it), return cost, restocking cost, historical return rate (from stats). Implement as a small **IncidentDecisionContext** built from Order, ReturnRequest, SupplierReturnPolicy, and optional stats.
- **Multiple incidents per order:** Allow multiple IncidentRecords with same orderId (e.g. return + complaint). Engine and UI must handle list by orderId; decisions may reference each other where applicable.

**Schema change:**
- New table `IncidentRecords` (id, tenantId, orderId, incidentType, status, trigger, automaticDecision, supplierInteraction, marketplaceInteraction, refundAmount, financialImpact, decisionLogId, createdAt, resolvedAt, ...).

---

### PHASE 4 — Return routing

**Existing:** ReturnRequest has returnDestination (toSupplier, toSeller). No routing logic based on policy type.

**Extend:**
- Add **ReturnDestination** (or routing target) enum: SELLER_ADDRESS, SUPPLIER_WAREHOUSE, RETURN_CENTER, DISPOSAL.
- **ReturnRoutingService** (new):
  - `routeReturn(returnRequest, supplier, supplierReturnPolicy) -> ReturnDestination`.
  - Logic: if policyType == RETURN_TO_WAREHOUSE → SUPPLIER_WAREHOUSE; if SELLER_HANDLES_RETURNS → SELLER_ADDRESS; if NO_RETURNS / DEFECT_ONLY and defect → SUPPLIER_WAREHOUSE or SELLER_ADDRESS per policy; DISPOSAL when not restockable and not to supplier.
  - Persist chosen destination on ReturnRequest (extend model + table: returnRoutingDestination or reuse returnDestination with extended enum).
- Use in UI and in IncidentHandlingEngine when creating/updating return requests.

**Schema change:**
- Extend ReturnRequest / Returns table: add `return_routing_destination` (text) or extend `return_destination` to include RETURN_CENTER, DISPOSAL.

**Corner cases:** Supplier accepts return only after inspection — route to SELLER_ADDRESS or RETURN_CENTER first; after inspection, supplier may accept (then SUPPLIER_WAREHOUSE or restock) or refuse. Supplier refuses damaged item — treat as disposal or seller-handled; record in incident; financial impact as loss.

---

### PHASE 5 — Returned inventory (restock)

**Existing:** No returned-stock or restock concept.

**Add:**
- **ReturnedStock** table: id, tenantId, productId, supplierId, condition (e.g. as_new, damaged), quantity, restockable (bool), sourceOrderId, sourceReturnId, createdAt.
- **ReturnedStockRepository:** insert, getByProductId, getAvailableQuantity(productId, supplierId?), decrement (when fulfilling from returned stock).
- **FulfillmentService extension:** Before calling `source.placeOrder(order)`, check `returnedStockRepository.getAvailableQuantity(...)`. If sufficient, **fulfillFromReturnedStock** (decrement ReturnedStock, set order sourceOrderId to a special value or internal id, no supplier call); else place order at supplier as today.
- **IncidentHandlingEngine / return flow:** When a return is received and policy allows restock, insert or update ReturnedStock (condition, quantity, restockable from policy or inspection).

**Corner cases:** Damaged return — set condition (e.g. damaged), restockable false or per policy. Partial return — insert one row per unit (or single row with quantity); link sourceOrderId/sourceReturnId. Multiple returned items from one order — multiple ReturnedStock rows or quantity > 1; FulfillmentService decrement respects quantity.

**Schema change:**
- New table `ReturnedStock` (id, tenantId, productId, supplierId, condition, quantity, restockable, sourceOrderId, sourceReturnId, createdAt).

---

### PHASE 6 — Non-collected parcel handling

**Existing:** Order status sync (e.g. cancelled on target); OrderCancellationService creates return request for “cancel after shipped”. No specific “parcel not collected” flow.

**Add:**
- **IncidentType:** NON_COLLECTED_PARCEL.
- **Trigger:** When marketplace or carrier webhook/sync indicates “returned to sender” / “not collected” (or manual creation).
- **Flow:** Create IncidentRecord (type NON_COLLECTED_PARCEL), update Order (e.g. lifecycle to returned or keep status, add a flag like `returnedByCarrier` if needed), compute **financial impact** (shippingCost, returnCost, supplierRestockingFee, marketplaceFeeLoss), then **ReturnRoutingService** or direct logic: relist (if product returned to us/supplier and restockable), add to ReturnedStock, or discard. Persist decision in DecisionLog and IncidentRecord.
- **NonCollectedParcelHandler** (or inside IncidentHandlingEngine): `handleNonCollected(order, carrierStatus) -> (financialImpact, decision: relist | addToReturnedStock | discard)`.
- **Outcomes:** Returned to supplier, returned to seller, returned to return warehouse, destroyed — map to ReturnRoutingDestination or internal outcome enum; drive relist / ReturnedStock / discard from outcome and policy.

**Corner cases:** Parcel damaged during return — incident subtype or note; may still add to ReturnedStock as damaged/non-restockable or discard. Supplier refuses returned parcel — incident; financial impact as loss; no ReturnedStock entry.

**Schema:** IncidentRecords + optional Order column or lifecycle state; financial impact stored on IncidentRecord.

---

### PHASE 7 — Damage-claim flow

**Existing:** ReturnRequest supports reason (e.g. defective, damagedInTransit). No photo upload or structured damage workflow.

**Add:**
- **IncidentType:** DAMAGE_CLAIM.
- **IncidentRecord:** optional attachmentIds (references to stored photos; store in blob table or file storage and reference by id).
- **DamageClaimFlow:** (1) Customer uploads photos (UI + storage); (2) Create Incident (type DAMAGE_CLAIM, link attachments); (3) Check supplier policy (DEFECT_ONLY → may refund or request return with RMA); (4) Decision: refundCustomer, sendReplacement, or requestReturn; (5) Execute via marketplace API (refund) or FulfillmentService (replacement) or create ReturnRequest (return).
- **UI:** Damage claim creation, photo upload, decision actions (refund / replacement / return). Can live in Incidents dashboard.

**Corner cases:** Suspected customer fraud — decision rule or manual review; optional customer abuse score (see Phase 26). Customer cannot provide evidence — policy-based: require evidence for high value or allow refund without return per rule.

**Schema:** IncidentRecords.attachmentIds (JSON array or separate IncidentAttachments table). File storage for photos (path or URL in DB).

---

### PHASE 8 — Decision-engine rules (incident/return)

**Existing:** ListingDecider + PricingCalculator for listing/order creation. No post-order decision rules.

**Add:**
- **IncidentDecisionRules** (configurable, e.g. in UserRules or new table):
  - Rules like: if returnShippingCost > productCost → autoRefundWithoutReturn; if supplier policy NO_RETURNS and defect → autoRefund; if customer rating < X and high value → pendingApproval.
  - Inputs: product price, shipping cost, supplier policy, customer rating (if available), return cost, restocking cost, historical return rate.
- **IncidentDecisionEngine** (or part of IncidentHandlingEngine): evaluates rules and returns suggested decision (autoRefundWithoutReturn, requestReturn, requestRma, pendingManual, etc.). AutomationScheduler or a dedicated job can apply auto-decisions and create DecisionLog entries.

**Schema:** Optional table `incident_decision_rules` (tenantId, ruleType, conditionJson, action) or store in UserRules as JSON (e.g. incidentRules).

---

### PHASE 9 — Logging and diagnostics

**Existing:** DecisionLog (type, entityId, reason, criteriaSnapshot, createdAt). Used for listing/order/supplier/profitAlert.

**Extend:**
- Add **DecisionLogType.incident** (and optionally **return**, **refund**).
- Add columns to DecisionLog (or new table **IncidentDecisionLog**): **incidentType**, **decision** (text or enum), **financialImpact** (real). If you prefer to keep DecisionLog generic, store incidentType and financialImpact inside **criteriaSnapshot** JSON and add a short **decision** text to **reason**.
- **Contract:** Every automated or manual incident decision creates a DecisionLog (or IncidentDecisionLog) with incidentType, decision, financialImpact, reason.

**Schema change:**
- DecisionLog: add optional `incident_type` (text), `financial_impact` (real). Or new table `IncidentDecisionLogs` (id, incidentId, decision, financialImpact, reason, createdAt) and keep DecisionLog for backward compatibility.

---

### PHASE 10 — Scalability

**Existing:** Background job queue (BackgroundJobs table), job processor (scan, fulfill_order, price_refresh), AutomationScheduler, DistributedLockService for fulfill. Designed for in-process worker; can run multiple workers sharing DB.

**Extend:**
- **Incident jobs:** Add job types `process_incident`, `return_routing`, `non_collected_parcel`, `damage_claim_workflow` (or one generic `incident_handle` with payload). Workers process these like fulfill_order; idempotent by incidentId.
- **Idempotency:** IncidentHandlingEngine and return flows must be idempotent (e.g. by incidentId + state); avoid duplicate refunds or duplicate ReturnedStock entries.
- **Queue processing:** Same pattern as B1: enqueue on trigger (webhook, sync, manual); worker processes with retries and dead-letter. For 10k orders/day, incident volume is a fraction; existing queue + a few new job types is sufficient. Optionally partition by tenantId for very large tenants.
- **Order-level idempotency (extend):** Marketplace webhooks may deliver the same event multiple times. Use **idempotency keys** (e.g. targetPlatformId + targetOrderId + eventType + eventId/timestamp) in OrderSyncService or webhook handler to deduplicate; only create/update order once per logical event. Before FulfillmentService places supplier order, ensure **no duplicate supplier order** for the same marketplace order (e.g. key by orderId or targetOrderId in job payload and in supplier order creation; check existing sourceOrderId or external id at supplier).

**No new tables required** if reusing BackgroundJobs; add new job types and handlers. Optional: store idempotency keys in a small table or in BackgroundJobs payload/deduplication.

---

### PHASE 11 — UI additions

**Existing:** Returns screen (return requests list); Approval queue (listings + orders); Settings (rules, credentials).

**Add:**
- **Incidents dashboard:** List IncidentRecords (filter by type, status, order); open incident detail (photos, timeline, decision, financial impact); actions (apply decision, request RMA, issue refund).
- **Return management:** Enhance Returns screen with routing destination, link to incident, and “received / restock” actions that update ReturnedStock.
- **Supplier return policies:** Screen or Settings section to view/edit SupplierReturnPolicy (policy type, window, RMA, warehouse return, etc.).
- **Returned stock management:** List ReturnedStock by product/supplier; show quantity, condition, restockable; manual adjust or write-off.

**No schema change** for UI only; use existing + new repos.

---

### PHASE 12 — Marketplace integration (Allegro)

**Existing:** AllegroTargetPlatform (createListing, updateListing, getOrders, updateTracking, cancelOrder, getOrderStatus). OrderSyncService syncs orders; OrderCancellationService cancels on target.

**Extend:**
- **Returns:** Allegro API for creating/accepting return requests, providing return instructions (address, label). Implement in AllegroTargetPlatform or dedicated AllegroReturnsClient: createReturn(orderId, reason), getReturnStatus(returnId), acceptReturn, rejectReturn.
- **Refunds:** Allegro refund API (if available): issueRefund(orderId, amount, reason). Call from IncidentHandlingEngine when decision is refund.
- **Order cancellation:** Already present (cancelOrder). Ensure it’s used in incident flows when order is cancelled post-ship (e.g. non-collected).
- **Tracking updates:** Already present (updateTracking). Keep using for replacements if we send new tracking.
- **Disputes:** If Allegro exposes dispute/complaint API, add methods to open/respond to disputes and link to IncidentRecord.

**Implementation:** New methods on AllegroClient / AllegroTargetPlatform; IncidentHandlingEngine and UI call these when executing marketplace actions.

**Note (15.03.2026):** Current implementation is based on 2024 Allegro API docs. When you have a seller account, provide current API (returns, refunds, disputes) so we can align endpoints and payloads.

---

### PHASE 13 — Implementation plan (this document)

Outputs requested:
1. **Database schema changes** — See “Schema summary” below.
2. **New domain services** — PostOrderLifecycleEngine, IncidentHandlingEngine, ReturnRoutingService, IncidentDecisionEngine (or merged into IncidentHandlingEngine), NonCollectedParcelHandler (or inside IncidentHandlingEngine).
3. **New repositories** — SupplierReturnPolicyRepository, IncidentRecordRepository, ReturnedStockRepository; extend ReturnRepository for routing destination; optionally IncidentDecisionLog / extend DecisionLogRepository.
4. **Service responsibilities** — See “Service responsibilities” below.
5. **Background jobs** — process_incident, return_routing, non_collected_parcel (or generic incident_handle); optionally financial_sync, risk_score_order.
6. **UI modules** — Incidents dashboard, Return management (enhanced), Supplier return policies, Returned stock management.
7. **Migration strategy** — See “Migration strategy” below.
8. **Risk analysis** — See “Risk analysis” below.

---

### PHASE 14 — Supplier prepayment & capital management

**Existing:** No financial ledger or order-level financial state. Billing (plan/usage) exists; no capital tracking.

**Add:**
- **FinancialLedger** table: id, tenantId, type (supplier_prepayment, marketplace_held, marketplace_released, refund, loss, adjustment), orderId (nullable), amount, currency, referenceId (e.g. payment id), createdAt. Optional: balanceSnapshotPerTenant (or compute from ledger).
- **OrderFinancialState** enum: UNPAID, SUPPLIER_PAID, MARKETPLACE_HELD, MARKETPLACE_RELEASED, REFUNDED, LOSS. Store on Order (new column) or in a small OrderFinancialState table (orderId, state, updatedAt).
- **CapitalManagementService:** Tracks available capital (e.g. ledger balance or configured “cash” minus locked). Before FulfillmentService.placeOrder: if capitalAvailable < orderCost, **queue order** (new status or flag `queued_for_capital`) instead of fulfilling; process when capital available. Update ledger on: place order (SUPPLIER_PAID), marketplace payout (MARKETPLACE_RELEASED), refund (REFUNDED), loss (LOSS).

**Schema change:**
- Table `FinancialLedger` (id, tenantId, type, orderId, amount, currency, referenceId, createdAt).
- Orders: add `financial_state` (text), optional `queued_for_capital` (bool) or use status.

---

### PHASE 15 — Non-collected parcel financial recovery

**Existing:** Phase 6 defines non-collected handling and financial impact.

**Extend:**
- **Financial impact formula:** shippingCost + returnCost + supplierRestockingFee + marketplaceFeeLoss; persist on IncidentRecord and optionally post to FinancialLedger (type LOSS).
- **Decision:** relistItem (if returned and restockable → add to ReturnedStock or relist listing), addToReturnedStock, discardItem. Implement in NonCollectedParcelHandler and log in DecisionLog.

No additional schema if IncidentRecord and FinancialLedger already exist.

---

### PHASE 16 — Order risk scoring

**Existing:** Orders can be pendingApproval (manual approval). No risk scoring.

**Add:**
- **OrderRiskScore** model: orderId, score (0–100 or similar), factors (e.g. newCustomer, highValue, unusualDestination, highReturnCategory, cashOnDelivery), evaluatedAt.
- **OrderRiskScoringService:** evaluate(order, context) -> score. Context: is new customer (no history?), order total, shipping country/region, product category return rate (from stats), payment method (COD if supported).
- **Rule:** If score > threshold (from UserRules or config), set order to **pendingApproval** (already exists). OrderSyncService or a post-sync job calls risk scorer and updates status.

**Schema:** Table `OrderRiskScores` (orderId, score, factorsJson, evaluatedAt) or add columns to Orders (risk_score, risk_factors_json).

---

### PHASE 17 — Pricing engine adaptation (return-rate)

**Existing:** PricingCalculator: calculateMinimumSellingPrice, calculateSellingPrice, profitAfterFee, strategies (always_below_lowest, etc.). No return-rate or expected-cost formula.

**Extend:**
- **New strategy or config:** “return_rate_adjusted” or a **PricingStrategyId.returnRateAware**.
- **Formula:** expectedCost = productCost + shippingCost + (returnRate * returnCost); returnCost = returnShippingCost + restockingFee + optional marketplaceFeeLoss; minimumPrice = expectedCost / (1 - targetMargin) or equivalent so that with 20–30% return rate we still hit target margin on average.
- **Inputs:** productCost, supplierShippingCost, averageReturnRate (per category or global from UserRules/stats), returnShippingCost, restockingFee, marketplaceFee, expectedLossFromNonCollectedParcels (optional). Store in UserRules as optional config (e.g. defaultReturnRatePercent, returnCostFormula) or in rules JSON.
- **PricingCalculator:** Add method `calculateMinimumSellingPriceWithReturnRate(...)` and use it when strategy is return_rate_adjusted (or when UserRules has return rate config). ListingDecider already uses PricingCalculator; no change to decider interface, only to calculator and rules.

**Schema:** UserRules: add optional columns or JSON (defaultReturnRatePercent, returnRateByCategoryJson, nonCollectedLossPercent) for configuration.

---

### PHASE 18 — Inventory virtualization layer

**Existing:** No unified inventory. Stock comes from sources (getProduct, SupplierOffers); listings have no “reserved” or “marketplace stock” concept. Fulfillment checks source stock at order time.

**Add:**
- **InventoryService** (abstraction):
  - **supplierStock(productId, sourcePlatformId):** from source getProduct / SupplierOffers (existing).
  - **returnedStock(productId, supplierId?):** from ReturnedStockRepository (Phase 5).
  - **reservedStock(productId):** orders in status sourceOrderPlaced/shipped that reference this product (reserved for those orders). Optional table ReservedStock (orderId, listingId, productId, quantity) or compute from Orders + Listings.
  - **marketplaceStock(listingId):** from target getListingDetails or from our Listing + sync (existing MarketplaceListingSyncService).
  - **availableToSell(productId, listingId):** min(supplierStock + returnedStock - reserved, marketplaceStock) or policy-based (e.g. list only if supplierStock > 0).
- **Unified view:** Prevents overselling: when creating/updating listing or when order is placed, check availableToSell; optionally block listing or show “low stock” when below threshold.
- **Tables:** ReturnedStock (Phase 5). Optional: ReservedStock (orderId, productId, quantity) if we want explicit reservation; else derive from Orders.

**Schema:** ReturnedStock already added; optional ReservedStock table. No change to Products/Listings; service layer only.

---

## 10. Extended phases (scalability, resilience, observability)

The following phases **extend** the architecture toward high automation and scale (thousands of orders/day, millions of products). They do not replace existing modules.

### PHASE 19 — Supplier stock drift

**Problem:** Supplier stock may be outdated (feed delay, cache, or no real-time API).

**Extend (do not replace):**
- **supplierStockConfidenceScore:** Per product/supplier or per SupplierOffer, a score or age indicating how fresh the stock value is (e.g. last feed sync time, last API check). InventoryService or callers can use this to treat null/unknown vs stale differently.
- **safetyBuffer logic:** When deciding availableToSell or whether to list, apply an optional buffer (e.g. list only if supplierStock > reserved + buffer, or reduce listed quantity by buffer). Configurable in UserRules or per listing (e.g. safetyStockBuffer).

**Integration:** InventoryService already returns nullable supplierStock; add optional confidence/age in InventorySnapshot or in SupplierOffers table (lastStockCheckAt). ListingDecider / MarketplaceListingSyncService can respect buffer when updating listing quantity.

---

### PHASE 20 — Price drift protection

**Problem:** Supplier prices change frequently; listing may sell at a loss if not refreshed.

**Extend (do not replace):**
- **Guardrail:** If current margin &lt; minimumMargin (from UserRules or listing rules), **pause listing** automatically (or reduce visibility) until PriceRefreshService updates and margin is restored. Existing ProfitGuard / PricingCalculator can feed into this; add a listing status or flag (e.g. paused_margin) and a job or check in PriceRefreshService / AutomationScheduler that sets it.

**Integration:** PricingCalculator and ListingDecider already exist; add a post-refresh check or a periodic job that evaluates margin and updates listing state.

---

### PHASE 21 — Shipping validation

**Problem:** Listings must meet marketplace delivery promises; otherwise risk penalties or returns.

**Extend (do not replace):**
- **Fields:** On Supplier, SupplierOffer, or UserRules: **supplierProcessingTime** (days), **supplierShippingTime** (days or min–max). Optionally carrier-specific.
- **Rule:** When creating or updating a listing, compute **expected delivery time** (processing + shipping + buffer). If expected delivery &gt; marketplace max allowed (e.g. from marketplace config or listing policy), **block listing** or mark as not eligible for fast delivery. MarketplaceListingSyncService or ListingDecider can enforce this.

**Schema:** Add columns to Suppliers or SupplierOffers (processingTimeDays, shippingTimeDays) or store in UserRules as defaults.

---

### PHASE 22 — Supplier API resilience

**Problem:** Supplier APIs fail or rate-limit; repeated calls can make things worse.

**Extend (do not replace):**
- **RetryQueue:** For transient failures (network, 5xx), retry with backoff (existing BackgroundJobs retries can cover this; ensure fulfill_order and price_refresh use retry policy). Optional: dedicated retry queue for supplier calls with max attempts and exponential backoff.
- **CircuitBreaker:** Per supplier (or per source platform), track consecutive failures or error rate. When threshold exceeded, **open circuit** — temporarily skip calling that supplier (e.g. do not place orders or refresh offers) and optionally alert. After cooldown, half-open and probe. Integrate at the layer that calls supplier (e.g. SourcePlatform implementation or a wrapper used by FulfillmentService / PriceRefreshService).

**Integration:** Wrap supplier HTTP/client calls in a small resilience layer; do not replace FulfillmentService or PriceRefreshService, only the underlying supplier invocation.

---

### PHASE 23 — Listing update throttling

**Problem:** Marketplace APIs have rate limits; bulk listing updates can overload or get throttled.

**Extend (do not replace):**
- **ListingUpdateQueue:** Instead of updating all listings in one sync, enqueue **per-listing or batched updates** (e.g. as background jobs or an in-memory/DB queue). Workers consume at a controlled rate (e.g. N updates per minute per marketplace account).
- **Priority update system:** Critical updates (e.g. price below cost, stock 0) get higher priority; routine refresh gets lower priority. Queue payload can include priority; worker sorts or uses separate queues.

**Integration:** MarketplaceListingSyncService currently drives updates; add a queue (table or in-memory) and a worker that pulls from it and calls existing update listing logic. Existing BackgroundJobs can be used with job type `update_listing` and priority field.

---

### PHASE 24 — Supplier reliability scoring

**Problem:** Not all suppliers perform equally; high failure rate should affect sourcing and possibly listing.

**Extend (do not replace):**
- **SupplierReliabilityScore** (model or table): supplierId, score (0–100 or similar), metrics: orderCancellations, lateShipments, wrongItems, averageShippingTimeDays, lastEvaluatedAt. Optionally store factors as JSON.
- **Service:** Periodically (e.g. job) compute from Orders and Incidents/Returns: count cancellations, late shipments (deliveredAt &gt; promisedDeliveryMax), wrong-item incidents, average shipped→delivered. Update SupplierReliabilityScore. Use in SupplierSelector or ListingDecider to prefer higher-reliability suppliers or to hide/pause listings for very low scores.

**Schema:** New table `SupplierReliabilityScores` (supplierId, score, metricsJson, lastEvaluatedAt) or extend Suppliers with optional columns.

---

### PHASE 25 — Customer abuse detection

**Problem:** Some customers have high return/complaint/refund rates; may warrant manual review or limits.

**Extend (do not replace):**
- **Customer metrics:** By customer identifier (e.g. from Order or marketplace): return rate, complaint rate, refund rate (over window, e.g. 90 days). Store in a small table or compute on demand from Orders + ReturnRequests + Incidents.
- **Rule:** If customer return rate or complaint rate &gt; threshold (UserRules), set order to **pendingApproval** or flag for manual review. Integrate with OrderRiskScoringService (add customer factor) or as a separate check after order sync.

**Schema:** Optional table `CustomerMetrics` (customerId, returnRate, complaintRate, refundRate, orderCount, windowEnd) or derive from existing data; no change to Order model if using existing pendingApproval.

---

### PHASE 26 — Listing health monitoring

**Problem:** Listings with high cancellation, late shipment, or return rate can hurt account standing on the marketplace.

**Extend (do not replace):**
- **Per-listing (or per product/supplier) metrics:** cancellation rate, late shipment rate, return rate (from Orders and Incidents). Compute over a rolling window.
- **Rule:** If metrics exceed thresholds (UserRules or per-marketplace config), **reduce exposure** — e.g. pause listing, or lower priority in ListingUpdateQueue, or mark "under review". Optional: automatic unpause when metrics improve.

**Integration:** Use existing DecisionLog and Order/Incident data; add a job that computes metrics and updates listing state or a ListingHealth table. MarketplaceListingSyncService can respect "paused" or "reduced" state.

---

### PHASE 27 — Catalog scaling architecture (1k → 1M products)

**Existing:** Products (canonical), SupplierOffers (supplier SKU, price, stock), Listings (marketplace listing mapped to SupplierOffer). This separation already avoids duplication.

**Extend (principles only; no replacement):**
- **Product normalization:** Keep Products as single source of truth for product identity; multiple SupplierOffers per product; multiple Listings per product (per marketplace).
- **Supplier offer mapping:** Listings reference SupplierOffer (or productId + supplierId); FulfillmentService uses the mapped offer for the chosen source.
- **Listing caching:** At scale, avoid loading full catalog into memory; use pagination, indexes (productId, supplierId, targetPlatformId), and optional cache layer (Phase 29).
- **Event-driven updates:** Catalog changes (price, stock, listing pause) should trigger downstream updates via events/jobs rather than synchronous cascades (Phase 31).

---

### PHASE 28 — Overselling protection (StockState / materialized view)

**Existing:** InventoryService computes availableToSell from supplierStock + returnedStock - reservedStock (and marketplace cap). No persistent StockState table yet.

**Extend (optional, for scale or consistency):**
- **StockState table (optional):** productId, supplierId (optional), supplierStock, returnedStock, reservedStock, availableStock, lastUpdatedAt. Updated by a job or event handlers when offers change, orders place/ship, or returned stock changes. InventoryService can read from this for fast path when present; otherwise compute on the fly (current behavior).
- **Alternative:** Keep InventoryService as the single abstraction; use **materialized view or cached snapshot** populated asynchronously for dashboard/bulk checks. Do not change FulfillmentService contract; it already uses InventoryService.

---

### PHASE 29 — Listing synchronization architecture (feed → offers → queue)

**Existing:** MarketplaceListingSyncService syncs listings; PriceRefreshService refreshes supplier offers.

**Extend (do not replace):**
- **SupplierFeedSync:** Dedicated job or service that updates **SupplierOffers** table from supplier feeds (or API). Runs on schedule; does not directly update marketplace listings.
- **OfferSnapshot cache:** Optional cache of last known offer (price, stock) per SupplierOffer to avoid hitting supplier on every listing update.
- **ListingUpdateQueue:** (See Phase 23.) When SupplierOffers change (from feed or refresh), enqueue **listing update jobs** for affected Listings (productId/supplierId). Workers process queue and call marketplace update listing API. This decouples feed sync from marketplace API and prevents DB overload from synchronous cascade.

**Workflow:** SupplierFeedSync → SupplierOffers updated → enqueue ListingUpdateQueue for affected listings → worker updates marketplace. Existing MarketplaceListingSyncService logic can be reused inside the worker.

---

### PHASE 30 — Product catalog caching

**Problem:** At hundreds of thousands of products, repeated DB reads for product/offer/listing state can become a bottleneck.

**Extend (do not replace):**
- **Caching layer:** In-memory or distributed cache (e.g. by productId, listingId) for: product data, supplier offer state (price, stock, lastCheck), listing state (status, quantity). TTL and invalidation on update (from feed, order, or manual change). Use in ListingDecider, PriceRefreshService, InventoryService read path where appropriate.
- **Goal:** Reduce database reads for hot path (e.g. order sync, fulfillment, listing scan); keep single source of truth in DB; cache is optional and can be disabled for small catalogs.

---

### PHASE 31 — Event-driven catalog updates

**Extend (do not replace):**
- **Internal events:** Emit or enqueue on: supplier price change, supplier stock change, return restocked, listing paused, order placed/shipped. Events can be in-process (callbacks) or via BackgroundJobs (e.g. job type `catalog_event` with payload).
- **Consumers:** Background workers that react to events: update ListingUpdateQueue, refresh InventoryService cache, update StockState (if used), trigger PriceRefreshService for affected products. No direct synchronous cascade from one service to many; events decouple.

**Integration:** PriceRefreshService, FulfillmentService, ReturnedStockRepository (on insert/decrement) can enqueue events; existing AutomationScheduler or new small event router dispatches to handlers.

---

### PHASE 32 — System observability

**Extend (do not replace):**
- **Operational metrics:** Track and expose (logs, metrics endpoint, or dashboard): orders per minute, supplier API health (success rate, latency, circuit state), incident rate, return rate, financial exposure (e.g. ledger balance, queued orders value), listing update throughput (queued vs processed). Use for alerting and capacity planning.
- **Implementation:** Instrument existing services (OrderSyncService, FulfillmentService, supplier clients, BackgroundJobs processor) with counters/timers; optional integration with existing logging or a metrics library. No change to business logic; additive only.

---

## 3. Schema summary (new / changed)

| Table / change | Purpose |
|----------------|--------|
| **OrderLifecycle** (or column on Orders) | Phase 1: lifecycle state (created … refunded, cancelled). |
| **SupplierReturnPolicies** (or columns on Suppliers) | Phase 2: policyType, returnShippingPaidBy, requiresRma, warehouseReturnSupported, virtualRestockSupported. |
| **IncidentRecords** | Phase 3, 6, 7: incident type, status, decisions, financial impact, attachments. |
| **ReturnedStock** | Phase 5: productId, supplierId, condition, quantity, restockable, sourceOrderId. |
| **DecisionLog** (extend) or **IncidentDecisionLogs** | Phase 9: incidentType, decision, financialImpact. |
| **FinancialLedger** | Phase 14: prepayment, held, released, refund, loss. |
| **Orders** (extend) | financial_state, optional risk_score, risk_factors_json (Phase 14, 16). |
| **ReturnRequest / Returns** (extend) | return_routing_destination (Phase 4). |
| **UserRules** (extend) | Optional: defaultReturnRatePercent, returnRateByCategoryJson, incidentRules, riskScoreThreshold (Phase 8, 17, 16). |
| **BackgroundJobs** | New job types: process_incident, etc. (Phase 10); optional update_listing, catalog_event (Phases 23, 31). |
| **Suppliers / SupplierOffers** (extend) | Phase 19–21: optional lastStockCheckAt, supplierStockConfidence; processingTimeDays, shippingTimeDays (Phase 21). |
| **UserRules** (extend) | Phase 19–20, 25–26: safetyStockBuffer, marginPauseThreshold, customerAbuseThreshold, listingHealthThresholds. |
| **SupplierReliabilityScores** (optional) | Phase 24: supplierId, score, metricsJson, lastEvaluatedAt. |
| **CustomerMetrics** (optional) | Phase 25: customerId, returnRate, complaintRate, refundRate, windowEnd. |
| **StockState** (optional) | Phase 28: productId, supplierId, supplierStock, returnedStock, reservedStock, availableStock, lastUpdatedAt. |
| **ListingUpdateQueue** (or BackgroundJobs) | Phase 23, 29: queue listing updates with priority; workers consume at throttled rate. |

---

## 4. New domain services

| Service | Responsibility |
|--------|----------------|
| **PostOrderLifecycleEngine** | Validates and applies lifecycle state transitions; maps Order.status + return/complaint data to lifecycle. |
| **IncidentHandlingEngine** | Creates/handles incidents; applies rules; suggests or applies decision; coordinates supplier/marketplace interaction and refund; records financial impact and DecisionLog. |
| **ReturnRoutingService** | Determines return destination (SELLER_ADDRESS, SUPPLIER_WAREHOUSE, RETURN_CENTER, DISPOSAL) from SupplierReturnPolicy and context. |
| **CapitalManagementService** | Tracks ledger, available capital; blocks or queues orders when capital &lt; order cost. |
| **OrderRiskScoringService** | Computes risk score for order; sets pendingApproval when score &gt; threshold. |
| **InventoryService** | Unified view: supplierStock, returnedStock, reservedStock, marketplaceStock; availableToSell to prevent overselling. |
| **Resilience layer (supplier)** | Phase 22: Retry with backoff, CircuitBreaker per supplier; wraps supplier API calls. |
| **ListingUpdateQueue worker** | Phase 23, 29: Consumes queue at throttled rate; calls existing marketplace update listing logic. |
| **SupplierReliabilityScoringService** (optional) | Phase 24: Computes and stores supplier reliability from Orders/Incidents. |
| **ShippingValidationService** (optional) | Phase 21: Validates expected delivery vs marketplace promise; blocks or flags listing. |

---

## 5. New repositories

| Repository | Responsibility |
|-----------|-----------------|
| **SupplierReturnPolicyRepository** | CRUD for SupplierReturnPolicy (getBySupplierId, upsert). |
| **IncidentRecordRepository** | CRUD, getByOrderId, getByStatus, list with filters. |
| **ReturnedStockRepository** | insert, getByProductId, getAvailableQuantity, decrement. |
| **FinancialLedgerRepository** | append entry, getBalance(tenantId), getEntriesByOrderId. |
| **OrderRiskScoreRepository** (optional) | store/retrieve score per order. |

Extend: **ReturnRepository** (add returnRoutingDestination); **DecisionLogRepository** (log incident decisions with incidentType, financialImpact); **OrderRepository** (financial_state, risk_score if on Order).

Optional (Phases 24–28, 30): **SupplierReliabilityScoreRepository**, **CustomerMetricsRepository**, **StockStateRepository** (or computed); **ListingUpdateQueue** table or use BackgroundJobs with type `update_listing`.

---

## 6. Background jobs

| Job type | When enqueued | Handler |
|----------|----------------|--------|
| **process_incident** | On new IncidentRecord or webhook (e.g. return created on marketplace). | IncidentHandlingEngine.handleIncident (idempotent by incident id). |
| **return_routing** | When return is approved / received. | ReturnRoutingService + update ReturnRequest; optionally add to ReturnedStock. |
| **non_collected_parcel** | When carrier/marketplace signals non-collected. | Create incident, compute impact, decide relist/restock/discard. |
| **financial_sync** (optional) | Periodic or after order/refund. | Reconcile ledger with marketplace payouts. |
| **risk_score_order** | After order sync (new orders). | OrderRiskScoringService.evaluate; set pendingApproval if needed. |

Existing jobs (scan, fulfill_order, price_refresh) unchanged. Fulfillment job handler: before placeOrder, check CapitalManagementService and ReturnedStock (fulfill from returned first, then supplier).

Optional new job types (Phases 23–31): **update_listing** (from ListingUpdateQueue; throttled per marketplace), **supplier_reliability_score**, **customer_metrics**, **listing_health**, **catalog_event** (event-driven handlers), **supplier_feed_sync**.

---

## 7. Migration strategy

1. **Schema:** Add new tables (OrderLifecycle or column, SupplierReturnPolicies, IncidentRecords, ReturnedStock, FinancialLedger); add columns to Orders, Returns, DecisionLog/UserRules as needed. Migrations in Drift (schema version bump).
2. **Backfill:** Order lifecycle: backfill from current Order.status + Returns (e.g. has return → returnRequested/returnApproved/refunded). Supplier return policy: from existing Supplier columns create initial SupplierReturnPolicy rows (policyType from acceptsNoReasonReturns/returnWindowDays).
3. **Feature flags:** Use existing FeatureFlags (e.g. `incident_handling`, `capital_management`, `risk_scoring`) to toggle new flows so existing behavior stays default until validated.
4. **Order of rollout:** (1) Lifecycle + SupplierReturnPolicy + IncidentRecords + ReturnRouting (read-only or manual); (2) IncidentHandlingEngine + decision rules + jobs; (3) ReturnedStock + fulfill from returned; (4) Capital management; (5) Risk scoring; (6) Pricing return-rate; (7) Inventory layer. UI can follow each block.

---

## 8. Risk analysis

| Risk | Mitigation |
|------|------------|
| **Duplicate refunds** | Idempotent incident handling (by incidentId); ledger and order financial state prevent double-release. |
| **Wrong return destination** | ReturnRoutingService driven by policy; manual override in UI for edge cases. |
| **Overselling** | InventoryService.availableToSell used at listing/order time; optional reservation (ReservedStock). |
| **Capital deadlock** | Clear rules: what counts as “available”; queue orders with visibility (UI) so operator can add capital or cancel. |
| **Performance (10k orders/day)** | Incident volume is a fraction; queue + workers; index IncidentRecords by orderId, status; ledger by tenantId, createdAt. |
| **Marketplace API changes** | Allegro return/refund behind interfaces; adapters in AllegroTargetPlatform. |
| **Data migration** | Backfill lifecycle and policies in batches; keep old columns until new flows are stable. |
| **Supplier API instability** | Phase 22: CircuitBreaker and retries limit blast radius; queue orders for failed suppliers. |
| **Marketplace rate limits** | Phase 23: ListingUpdateQueue and throttling prevent API overload. |
| **Catalog scale** | Phases 28–31: StockState/cache and event-driven updates reduce DB load; no replacement of Products/SupplierOffers/Listings. |

---

## 9. What stays unchanged

- **Order.status** remains the primary sync/fulfillment status; lifecycle is an extension for post-order flows.
- **ReturnRequest** and **Returns** table stay; extended with routing destination and link to IncidentRecord.
- **Supplier** stays; return policy can live in new table linked by supplierId or in new columns.
- **DecisionLog** stays; extended with incident type and financial impact (or separate IncidentDecisionLog).
- **PricingCalculator** and **ListingDecider** stay; calculator extended with return-rate formula; no change to decider contract.
- **FulfillmentService**, **OrderSyncService**, **OrderCancellationService**, **MarketplaceListingSyncService**, **PriceRefreshService**, **AutomationScheduler** keep current responsibilities; they are **called from** or **integrated with** new services (e.g. FulfillmentService checks capital and ReturnedStock; OrderSyncService or a new job runs risk scoring).
- **Existing UI** (Dashboard, Orders, Returns, Approval, Settings) stays; new screens (Incidents, Returned stock, Supplier policies) are additions.
- **Core models** (Orders, Listings, Products, Suppliers, SupplierOffers, ReturnRequests, DecisionLogs, UserRules) stay; extended with optional columns or linked new tables only where needed.
- **Core services** (OrderSyncService, FulfillmentService, MarketplaceListingSyncService, PriceRefreshService, AutomationScheduler) keep their responsibilities; extended with optional resilience, queues, and guards; no replacement.

This plan extends the existing architecture with minimal breaking change and keeps automation and manual override points clear. Phases 19–32 are additive for scalability, reliability, and operational safety.
