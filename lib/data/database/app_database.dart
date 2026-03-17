import 'package:drift/drift.dart';

import 'app_database_storage_io.dart' if (dart.library.html) 'app_database_storage_web.dart' as storage;

part 'app_database.g.dart';

@DataClassName('ProductRow')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get localId => text()();
  TextColumn get sourceId => text()();
  TextColumn get sourcePlatformId => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get imageUrls => text()(); // JSON array as string
  TextColumn get variantsJson => text()(); // JSON array
  RealColumn get basePrice => real()();
  RealColumn get shippingCost => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('PLN'))();
  TextColumn get supplierId => text().nullable()();
  TextColumn get supplierCountry => text().nullable()();
  IntColumn get estimatedDays => integer().nullable()();
  TextColumn get rawJson => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('ListingRow')
class Listings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get localId => text()();
  TextColumn get productId => text()();
  TextColumn get targetPlatformId => text()();
  TextColumn get targetListingId => text().nullable()();
  TextColumn get status => text()();
  RealColumn get sellingPrice => real()();
  RealColumn get sourceCost => real()();
  TextColumn get decisionLogId => text().nullable()();
  TextColumn get marketplaceAccountId => text().nullable()();
  IntColumn get promisedMinDays => integer().nullable()();
  IntColumn get promisedMaxDays => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  // Optional variant this listing sells; when null, listing is product-level.
  TextColumn get variantId => text().nullable()();
}

@DataClassName('OrderRow')
class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get localId => text()();
  TextColumn get listingId => text()();
  TextColumn get targetOrderId => text()();
  TextColumn get targetPlatformId => text()();
  TextColumn get customerAddressJson => text()();
  TextColumn get status => text()();
  TextColumn get sourceOrderId => text().nullable()();
  RealColumn get sourceCost => real()();
  RealColumn get sellingPrice => real()();
  IntColumn get quantity =>
      integer().withDefault(const Constant(1))(); // units in this order
  TextColumn get trackingNumber => text().nullable()();
  TextColumn get decisionLogId => text().nullable()();
  TextColumn get marketplaceAccountId => text().nullable()();
  DateTimeColumn get promisedDeliveryMin => dateTime().nullable()();
  DateTimeColumn get promisedDeliveryMax => dateTime().nullable()();
  DateTimeColumn get deliveredAt => dateTime().nullable()();
  DateTimeColumn get approvedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  /// Post-order lifecycle state (created, approved, shipped, returnRequested, refunded, etc.). Nullable for backfill.
  TextColumn get lifecycleState => text().nullable()();
  /// Phase 14: financial state (unpaid, supplier_paid, marketplace_held, marketplace_released, refunded, loss). Nullable.
  TextColumn get financialState => text().nullable()();
  /// Phase 14: when true, order is waiting for capital before fulfillment.
  BoolColumn get queuedForCapital => boolean().withDefault(const Constant(false))();
  /// Phase 16: risk score 0–100; null until evaluated.
  RealColumn get riskScore => real().nullable()();
  /// Phase 16: JSON array of factor names (e.g. highValue, newCustomer).
  TextColumn get riskFactorsJson => text().nullable()();
  /// Buyer message / parcel comment (e.g. for warehouse). From Allegro when API provides it.
  TextColumn get buyerMessage => text().nullable()();
  /// Delivery method name (e.g. InPost Locker, to address). From Allegro when API provides it.
  TextColumn get deliveryMethodName => text().nullable()();
}

@DataClassName('DecisionLogRow')
class DecisionLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get localId => text()();
  TextColumn get type => text()();
  TextColumn get entityId => text()();
  TextColumn get reason => text()();
  TextColumn get criteriaSnapshot => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  /// For incident decisions: type (e.g. damage_claim, non_collected).
  TextColumn get incidentType => text().nullable()();
  /// For incident decisions: total cost impact (refund + shipping + fees).
  RealColumn get financialImpact => real().nullable()();
}

@DataClassName('UserRulesRow')
class UserRulesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  RealColumn get minProfitPercent => real()();
  RealColumn get maxSourcePrice => real().nullable()();
  TextColumn get preferredSupplierCountries => text()();
  BoolColumn get manualApprovalListings => boolean()();
  BoolColumn get manualApprovalOrders => boolean()();
  IntColumn get scanIntervalMinutes => integer()();
  TextColumn get blacklistedProductIds => text()();
  TextColumn get blacklistedSupplierIds => text()();
  RealColumn get defaultMarkupPercent => real()();
  TextColumn get searchKeywords => text()();
  TextColumn get marketplaceFeesJson => text().withDefault(const Constant('{}'))();
  TextColumn get paymentFeesJson => text().withDefault(const Constant('{}'))();
  TextColumn get sellerReturnAddressJson => text().nullable()();
  TextColumn get marketplaceReturnPolicyJson => text().withDefault(const Constant('{}'))();
  BoolColumn get targetsReadOnly => boolean().withDefault(const Constant(false))();
  TextColumn get pricingStrategy => text().withDefault(const Constant('always_below_lowest'))();
  TextColumn get categoryMinProfitPercentJson => text().withDefault(const Constant('{}'))();
  RealColumn get premiumWhenBetterReviewsPercent => real().withDefault(const Constant(2.0))();
  IntColumn get minSalesCountForPremium => integer().withDefault(const Constant(10))();
  BoolColumn get kpiDrivenStrategyEnabled => boolean().withDefault(const Constant(false))();
  /// Per-platform rate limit: platformId -> max requests per second (JSON object).
  TextColumn get rateLimitMaxRequestsPerSecondJson => text().withDefault(const Constant('{}'))();
  /// Phase 8: incident decision rules – JSON array of { condition, action }. Nullable.
  TextColumn get incidentRulesJson => text().nullable()();
  /// Phase 16: if order risk score > this value, set to pendingApproval. Nullable (disabled when null).
  RealColumn get riskScoreThreshold => real().nullable()();
  /// Phase 17: default expected return rate % for return-rate-aware P_min (e.g. 15 = 15%). Nullable.
  RealColumn get defaultReturnRatePercent => real().nullable()();
  /// Phase 17: default return cost per unit (PLN) for return-rate-aware P_min. Nullable.
  RealColumn get defaultReturnCostPerUnit => real().nullable()();
  /// When true, fulfillment is skipped when inventory availableToSell < order quantity (Phase 18).
  BoolColumn get blockFulfillWhenInsufficientStock => boolean().withDefault(const Constant(false))();
  /// Phase 20: when true, ProfitGuard auto-pauses listing when margin < minProfitPercent.
  BoolColumn get autoPauseListingWhenMarginBelowThreshold => boolean().withDefault(const Constant(false))();
  /// Phase 21: default supplier processing days; used for shipping validation.
  IntColumn get defaultSupplierProcessingDays => integer().withDefault(const Constant(2))();
  /// Phase 21: default supplier shipping days when product has no estimatedDays.
  IntColumn get defaultSupplierShippingDays => integer().withDefault(const Constant(7))();
  /// Phase 21: marketplace max delivery days; reject listing if expected delivery > this. Nullable = skip check.
  IntColumn get marketplaceMaxDeliveryDays => integer().nullable()();
  /// Phase 26: max return+incident rate %; when exceeded and auto-pause on, listing is paused. Null = no limit.
  RealColumn get listingHealthMaxReturnRatePercent => real().nullable()();
  /// Phase 26: max late delivery rate %; when exceeded and auto-pause on, listing is paused. Null = no limit.
  RealColumn get listingHealthMaxLateRatePercent => real().nullable()();
  /// Phase 26: when true, auto-pause listings when health thresholds exceeded.
  BoolColumn get autoPauseListingWhenHealthPoor => boolean().withDefault(const Constant(false))();
  /// Phase 19: reduce effective available-to-sell by this many units (stock drift buffer).
  IntColumn get safetyStockBuffer => integer().withDefault(const Constant(0))();
  /// Phase 25: max return rate % for customer abuse check; null = disabled.
  RealColumn get customerAbuseMaxReturnRatePercent => real().nullable()();
  /// Phase 25: max complaint rate % for customer abuse check; null = disabled.
  RealColumn get customerAbuseMaxComplaintRatePercent => real().nullable()();
  /// Per-warehouse price refresh interval (minutes). sourcePlatformId -> minutes. Warehouses publish 1-2x/day; we pull from XML/CSV/API when stale. Default 720.
  TextColumn get priceRefreshIntervalMinutesBySourceJson => text().withDefault(const Constant('{}'))();
}

@DataClassName('SupplierRow')
class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get supplierId => text()();
  TextColumn get name => text()();
  TextColumn get platformType => text()();
  TextColumn get countryCode => text().nullable()();
  RealColumn get rating => real().nullable()();
  IntColumn get returnWindowDays => integer().nullable()();
  RealColumn get returnShippingCost => real().nullable()();
  RealColumn get restockingFeePercent => real().nullable()();
  BoolColumn get acceptsNoReasonReturns => boolean().withDefault(const Constant(false))();
  TextColumn get warehouseAddress => text().nullable()();
  TextColumn get warehouseCity => text().nullable()();
  TextColumn get warehouseZip => text().nullable()();
  TextColumn get warehouseCountry => text().nullable()();
  TextColumn get warehousePhone => text().nullable()();
  TextColumn get warehouseEmail => text().nullable()();
  TextColumn get feedSource => text().nullable()();
  TextColumn get shopUrl => text().nullable()();
  /// Regulations / T&C URL (e.g. supplier terms, country rules). Shown in supplier detail.
  TextColumn get regulationsUrl => text().nullable()();
  /// Terms and conditions URL.
  TextColumn get termsUrl => text().nullable()();
  /// Return policy document URL.
  TextColumn get returnPolicyUrl => text().nullable()();
}

@DataClassName('SupplierOfferRow')
class SupplierOffers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get offerId => text()();
  TextColumn get productId => text()();
  TextColumn get supplierId => text()();
  TextColumn get sourcePlatformId => text()();
  RealColumn get cost => real()();
  RealColumn get shippingCost => real().nullable()();
  IntColumn get minEstimatedDays => integer().nullable()();
  IntColumn get maxEstimatedDays => integer().nullable()();
  TextColumn get carrierCode => text().nullable()();
  TextColumn get shippingMethodName => text().nullable()();
  DateTimeColumn get lastPriceRefreshAt => dateTime().nullable()();
  DateTimeColumn get lastStockRefreshAt => dateTime().nullable()();
}

@DataClassName('ReturnRow')
class Returns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get returnId => text()();
  TextColumn get orderId => text()();
  TextColumn get reason => text()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  RealColumn get refundAmount => real().nullable()();
  RealColumn get returnShippingCost => real().nullable()();
  RealColumn get restockingFee => real().nullable()();
  DateTimeColumn get requestedAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get returnToAddress => text().nullable()();
  TextColumn get returnToCity => text().nullable()();
  TextColumn get returnToCountry => text().nullable()();
  TextColumn get returnTrackingNumber => text().nullable()();
  TextColumn get returnCarrier => text().nullable()();
  TextColumn get supplierId => text().nullable()();
  TextColumn get productId => text().nullable()();
  TextColumn get sourcePlatformId => text().nullable()();
  TextColumn get targetPlatformId => text().nullable()();
  TextColumn get returnDestination => text().nullable()();
  /// Routing target: SELLER_ADDRESS, SUPPLIER_WAREHOUSE, RETURN_CENTER, DISPOSAL.
  TextColumn get returnRoutingDestination => text().nullable()();
}

/// Supplier return policy (Phase 2). One per supplier; extends Supplier return fields with policy type and RMA/warehouse flags.
@DataClassName('SupplierReturnPolicyRow')
class SupplierReturnPolicies extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get supplierId => text()();
  TextColumn get policyType => text()(); // NO_RETURNS, DEFECT_ONLY, RETURN_WINDOW, FULL_RETURNS, RETURN_TO_WAREHOUSE, SELLER_HANDLES_RETURNS
  IntColumn get returnWindowDays => integer().nullable()();
  RealColumn get restockingFeePercent => real().nullable()();
  TextColumn get returnShippingPaidBy => text().nullable()(); // SELLER, CUSTOMER, SUPPLIER
  BoolColumn get requiresRma => boolean().withDefault(const Constant(false))();
  BoolColumn get warehouseReturnSupported => boolean().withDefault(const Constant(false))();
  BoolColumn get virtualRestockSupported => boolean().withDefault(const Constant(false))();
}

/// Post-order incident record (Phase 3). One per incident (return, complaint, non-collected, damage, etc.).
/// Phase 7: attachmentIds stores JSON array of attachment refs (e.g. photo IDs for damage claims).
@DataClassName('IncidentRecordRow')
class IncidentRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get orderId => text()();
  TextColumn get incidentType => text()();
  TextColumn get status => text()(); // open, supplier_contacted, marketplace_contacted, resolved
  TextColumn get trigger => text().withDefault(const Constant('manual'))(); // manual, webhook, sync
  TextColumn get automaticDecision => text().nullable()();
  TextColumn get supplierInteraction => text().nullable()();
  TextColumn get marketplaceInteraction => text().nullable()();
  RealColumn get refundAmount => real().nullable()();
  RealColumn get financialImpact => real().nullable()();
  TextColumn get decisionLogId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  /// JSON array of attachment IDs (e.g. for damage claim photos). Nullable for Phase 7.
  TextColumn get attachmentIds => text().nullable()();
}

/// Returned stock from customer/supplier (Phase 5). Used to fulfill from returned inventory before ordering from supplier.
@DataClassName('ReturnedStockRow')
class ReturnedStocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get productId => text()();
  TextColumn get supplierId => text()();
  TextColumn get condition => text().withDefault(const Constant('as_new'))(); // as_new, damaged, etc.
  IntColumn get quantity => integer()();
  BoolColumn get restockable => boolean().withDefault(const Constant(true))();
  TextColumn get sourceOrderId => text().nullable()();
  TextColumn get sourceReturnId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Phase 14: financial ledger – prepayment, held, released, refund, loss, adjustment. Balance = sum(amount) per tenant.
@DataClassName('FinancialLedgerRow')
class FinancialLedger extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get type => text()(); // supplier_prepayment, marketplace_held, marketplace_released, refund, loss, adjustment
  TextColumn get orderId => text().nullable()();
  RealColumn get amount => real()(); // signed: positive = inflow, negative = outflow
  TextColumn get currency => text().withDefault(const Constant('PLN'))();
  TextColumn get referenceId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('MarketplaceAccountRow')
class MarketplaceAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get accountId => text()();
  TextColumn get platformId => text()();
  TextColumn get displayName => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get connectedAt => dateTime().nullable()();
}

@DataClassName('MessageThreadRow')
class MessageThreads extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get localId => text()();
  TextColumn get orderId => text()();
  TextColumn get targetPlatformId => text()();
  TextColumn get marketplaceAccountId => text().nullable()();
  TextColumn get externalThreadId => text().nullable()();
  TextColumn get status => text()(); // open, waitingForCustomer, resolved
  DateTimeColumn get lastMessageAt => dateTime().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('MessageRow')
class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get threadLocalId => text()();
  TextColumn get direction => text()(); // incoming, outgoing, internal
  TextColumn get authorLabel => text().nullable()(); // buyer login or 'You'
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('FeatureFlagRow')
class FeatureFlags extends Table {
  TextColumn get name => text()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {name};
}

/// Async job queue for Phase B: scan, fulfill_order, price_refresh run as jobs with retries and dead-letter.
@DataClassName('BackgroundJobRow')
class BackgroundJobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get jobType => text()();
  TextColumn get payloadJson => text().withDefault(const Constant('{}'))();
  TextColumn get status => text()(); // pending, running, completed, failed
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  IntColumn get maxAttempts => integer().withDefault(const Constant(3))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get errorMessage => text().nullable()();
}

/// Distributed lock table (Phase B3). One row per lock key; expires_at for TTL.
@DataClassName('DistributedLockRow')
class DistributedLocks extends Table {
  TextColumn get lockKey => text()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  DateTimeColumn get expiresAt => dateTime()();
  @override
  Set<Column> get primaryKey => {lockKey};
}

/// Billing plan (Phase B5). Defines limits; -1 means unlimited.
@DataClassName('BillingPlanRow')
class BillingPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get maxListings => integer()(); // -1 = unlimited
  IntColumn get maxOrdersPerMonth => integer()(); // -1 = unlimited
  TextColumn get stripePriceId => text().nullable()();
}

/// Tenant's current plan (Phase B5). One row per tenant.
@DataClassName('TenantPlanRow')
class TenantPlans extends Table {
  IntColumn get tenantId => integer()();
  IntColumn get planId => integer()();
  TextColumn get stripeCustomerId => text().nullable()();
  TextColumn get stripeSubscriptionId => text().nullable()();
  DateTimeColumn get currentPeriodStart => dateTime().nullable()();
  DateTimeColumn get currentPeriodEnd => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {tenantId};
}

/// Phase 24: Supplier reliability score (cancellations, late shipments, wrong items, avg shipping).
@DataClassName('SupplierReliabilityScoreRow')
class SupplierReliabilityScores extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get supplierId => text()();
  RealColumn get score => real()(); // 0-100
  TextColumn get metricsJson => text().withDefault(const Constant('{}'))();
  DateTimeColumn get lastEvaluatedAt => dateTime()();
}

/// Phase 26: Listing health metrics (cancellation, late shipment, return rate per listing).
@DataClassName('ListingHealthMetricsRow')
class ListingHealthMetrics extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get listingId => text()();
  IntColumn get totalOrders => integer()();
  IntColumn get cancelledCount => integer()();
  IntColumn get lateCount => integer()();
  IntColumn get returnOrIncidentCount => integer()();
  DateTimeColumn get lastEvaluatedAt => dateTime()();
}

/// Phase 25: Customer abuse metrics (return/complaint/refund rate per customer over window).
@DataClassName('CustomerMetricsRow')
class CustomerMetrics extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get customerId => text()();
  RealColumn get returnRate => real()();
  RealColumn get complaintRate => real()();
  RealColumn get refundRate => real()();
  IntColumn get orderCount => integer()();
  DateTimeColumn get windowEnd => dateTime()();
}

/// Phase 28: Materialized stock state for fast path (supplier + returned - reserved = available).
@DataClassName('StockStateRow')
class StockState extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get productId => text()();
  TextColumn get supplierId => text().nullable()();
  IntColumn get supplierStock => integer().nullable()();
  IntColumn get returnedStock => integer().withDefault(const Constant(0))();
  IntColumn get reservedStock => integer().withDefault(const Constant(0))();
  IntColumn get availableStock => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUpdatedAt => dateTime()();
}

/// Phase 37: Product matching groups (deduplication + supplier comparison + pricing optimization).
@DataClassName('ProductGroupRow')
class ProductGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  /// Stable group id (hash-like string) used across runs.
  TextColumn get groupId => text()();
  /// Canonical product (local product id) representing the group.
  TextColumn get canonicalProductId => text()();
  /// EAN/GTIN if known (normalized).
  TextColumn get ean => text().nullable()();
  /// Supplier SKU / model if known (normalized).
  TextColumn get sku => text().nullable()();
  /// Normalized title for search/debug.
  TextColumn get titleNormalized => text().nullable()();
  /// Hash of canonical attributes used for change detection.
  TextColumn get attributesHash => text().nullable()();
  /// Hash of canonical images (placeholder-friendly; may be null until implemented).
  TextColumn get imageHash => text().nullable()();
  /// Matcher version so we can recompute groups deterministically.
  IntColumn get matchVersion => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('ProductGroupMemberRow')
class ProductGroupMembers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get groupId => text()();
  /// Local product id that belongs to this group.
  TextColumn get productId => text()();
  /// Match confidence 0..1
  RealColumn get confidence => real().withDefault(const Constant(0.0))();
  /// Deterministic reason (ean|sku|title|attributes|image|mixed).
  TextColumn get matchedBy => text().withDefault(const Constant('unknown'))();
  DateTimeColumn get createdAt => dateTime()();
}

/// Phase 37: Hash-based change detection and cached intelligence outputs per product.
@DataClassName('ProductIntelligenceStateRow')
class ProductIntelligenceStates extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get productId => text()();
  /// Deterministic content hash for skip-unchanged (based on normalized title/desc/attrs/images/variants).
  TextColumn get contentHash => text()();
  /// Last computed group id (if matched).
  TextColumn get groupId => text().nullable()();
  RealColumn get qualityScore => real().nullable()();
  RealColumn get returnRiskScore => real().nullable()();
  /// Competition level (low|medium|high) based on group supplier count + price variance.
  TextColumn get competitionLevel => text().nullable()();
  TextColumn get debugJson => text().nullable()();
  DateTimeColumn get lastProcessedAt => dateTime()();
}

/// Phase 37: Supplier switching log (deterministic + explainable).
@DataClassName('SupplierSwitchEventRow')
class SupplierSwitchEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get groupId => text()();
  TextColumn get fromSupplierId => text().nullable()();
  TextColumn get toSupplierId => text()();
  TextColumn get reason => text()();
  RealColumn get marginBeforePercent => real().nullable()();
  RealColumn get marginAfterPercent => real().nullable()();
  TextColumn get listingId => text().nullable()();
  TextColumn get orderId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Phase 37: Auto-pausing decisions log (soft/hard + recovery).
@DataClassName('ListingPauseEventRow')
class ListingPauseEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tenantId => integer().withDefault(const Constant(1))();
  TextColumn get listingId => text()();
  /// soft|hard
  TextColumn get pauseLevel => text()();
  TextColumn get reason => text()();
  TextColumn get metricsJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get recoveredAt => dateTime().nullable()();
}

@DriftDatabase(tables: [
  Products,
  Listings,
  Orders,
  DecisionLogs,
  UserRulesTable,
  Suppliers,
  SupplierOffers,
  MarketplaceAccounts,
  MessageThreads,
  Messages,
  Returns,
  SupplierReturnPolicies,
  IncidentRecords,
  ReturnedStocks,
  FinancialLedger,
  FeatureFlags,
  BackgroundJobs,
  DistributedLocks,
  BillingPlans,
  TenantPlans,
  SupplierReliabilityScores,
  ListingHealthMetrics,
  CustomerMetrics,
  StockState,
  ProductGroups,
  ProductGroupMembers,
  ProductIntelligenceStates,
  SupplierSwitchEvents,
  ListingPauseEvents,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(storage.openAppDatabaseConnection());

  /// For testing: pass a custom [QueryExecutor] (e.g. NativeDatabase.memory()).
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 37;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // v1 -> v2: added marketplaceAccountId to listings/orders, MarketplaceAccounts table
        await m.addColumn(listings, listings.marketplaceAccountId);
        await m.addColumn(orders, orders.marketplaceAccountId);
        await m.createTable(marketplaceAccounts);
      }
      if (from < 3) {
        // v2 -> v3: added promised delivery fields, Returns table
        await m.addColumn(listings, listings.promisedMinDays);
        await m.addColumn(listings, listings.promisedMaxDays);
        await m.addColumn(orders, orders.promisedDeliveryMin);
        await m.addColumn(orders, orders.promisedDeliveryMax);
        await m.createTable(returns);
      }
      if (from < 4) {
        // v3 -> v4: added per-platform marketplace fees
        await m.addColumn(userRulesTable, userRulesTable.marketplaceFeesJson);
      }
      if (from < 5) {
        // v4 -> v5: supplier warehouse/feed fields, return shipment tracking fields
        await m.addColumn(suppliers, suppliers.warehouseAddress);
        await m.addColumn(suppliers, suppliers.warehouseCity);
        await m.addColumn(suppliers, suppliers.warehouseZip);
        await m.addColumn(suppliers, suppliers.warehouseCountry);
        await m.addColumn(suppliers, suppliers.warehousePhone);
        await m.addColumn(suppliers, suppliers.warehouseEmail);
        await m.addColumn(suppliers, suppliers.feedSource);
        await m.addColumn(suppliers, suppliers.shopUrl);
        await m.addColumn(returns, returns.returnToAddress);
        await m.addColumn(returns, returns.returnToCity);
        await m.addColumn(returns, returns.returnToCountry);
        await m.addColumn(returns, returns.returnTrackingNumber);
        await m.addColumn(returns, returns.returnCarrier);
        await m.addColumn(returns, returns.supplierId);
        await m.addColumn(returns, returns.productId);
        await m.addColumn(returns, returns.sourcePlatformId);
        await m.addColumn(returns, returns.targetPlatformId);
      }
      if (from < 6) {
        // v5 -> v6: deliveredAt, fulfillment delay, seller return address, marketplace return policy, return destination
        await m.addColumn(orders, orders.deliveredAt);
        await customStatement('ALTER TABLE user_rules ADD COLUMN fulfillment_delay_minutes INTEGER NOT NULL DEFAULT 0');
        await m.addColumn(userRulesTable, userRulesTable.sellerReturnAddressJson);
        await m.addColumn(userRulesTable, userRulesTable.marketplaceReturnPolicyJson);
        await m.addColumn(returns, returns.returnDestination);
      }
      if (from < 7) {
        // v6 -> v7: remove fulfillment delay (orders fulfilled immediately to avoid OOS during wait)
        await customStatement('ALTER TABLE user_rules DROP COLUMN fulfillment_delay_minutes');
      }
      if (from < 8) {
        // v7 -> v8: order quantity and listing variantId
        await m.addColumn(orders, orders.quantity);
        await m.addColumn(listings, listings.variantId);
      }
      if (from < 9) {
        // v8 -> v9: global read-only switch for target writes
        await m.addColumn(userRulesTable, userRulesTable.targetsReadOnly);
      }
      if (from < 10) {
        // v9 -> v10: payment fees, pricing strategy, category margins, KPI strategy
        await m.addColumn(userRulesTable, userRulesTable.paymentFeesJson);
        await m.addColumn(userRulesTable, userRulesTable.pricingStrategy);
        await m.addColumn(userRulesTable, userRulesTable.categoryMinProfitPercentJson);
        await m.addColumn(userRulesTable, userRulesTable.premiumWhenBetterReviewsPercent);
        await m.addColumn(userRulesTable, userRulesTable.minSalesCountForPremium);
        await m.addColumn(userRulesTable, userRulesTable.kpiDrivenStrategyEnabled);
      }
      if (from < 11) {
        // v10 -> v11: idempotency - unique index so same (target_platform_id, target_order_id, listing_id) cannot be inserted twice
        await customStatement(
          'CREATE UNIQUE INDEX IF NOT EXISTS orders_target_platform_order_listing_unique '
          'ON orders(target_platform_id, target_order_id, listing_id)',
        );
      }
      if (from < 12) {
        // v11 -> v12: feature flags table (name, enabled) for toggles without code deploy
        await m.createTable(featureFlags);
      }
      if (from < 13) {
        await m.addColumn(userRulesTable, userRulesTable.rateLimitMaxRequestsPerSecondJson);
      }
      if (from < 14) {
        await m.addColumn(products, products.tenantId);
        await m.addColumn(listings, listings.tenantId);
        await m.addColumn(orders, orders.tenantId);
        await m.addColumn(decisionLogs, decisionLogs.tenantId);
        await m.addColumn(userRulesTable, userRulesTable.tenantId);
        await m.addColumn(suppliers, suppliers.tenantId);
        await m.addColumn(supplierOffers, supplierOffers.tenantId);
        await m.addColumn(returns, returns.tenantId);
        await m.addColumn(marketplaceAccounts, marketplaceAccounts.tenantId);
        await m.addColumn(featureFlags, featureFlags.tenantId);
      }
      if (from < 15) {
        await m.createTable(backgroundJobs);
      }
      if (from < 16) {
        await m.createTable(distributedLocks);
      }
      if (from < 17) {
        await m.createTable(billingPlans);
        await m.createTable(tenantPlans);
        await customStatement(
          "INSERT INTO billing_plans (name, max_listings, max_orders_per_month) VALUES ('free', 10, 50), ('pro', -1, -1)",
        );
        await customStatement(
          "INSERT INTO tenant_plans (tenant_id, plan_id) VALUES (1, (SELECT id FROM billing_plans WHERE name = 'free' LIMIT 1))",
        );
      }
      if (from < 18) {
        await m.addColumn(orders, orders.lifecycleState);
        await m.addColumn(decisionLogs, decisionLogs.incidentType);
        await m.addColumn(decisionLogs, decisionLogs.financialImpact);
        await m.addColumn(returns, returns.returnRoutingDestination);
        await m.createTable(supplierReturnPolicies);
        await m.createTable(incidentRecords);
        await m.createTable(returnedStocks);
      }
      if (from < 19) {
        await m.addColumn(incidentRecords, incidentRecords.attachmentIds);
      }
      if (from < 20) {
        await m.addColumn(userRulesTable, userRulesTable.incidentRulesJson);
      }
      if (from < 21) {
        await m.addColumn(orders, orders.financialState);
        await m.addColumn(orders, orders.queuedForCapital);
        await m.createTable(financialLedger);
      }
      if (from < 22) {
        await m.addColumn(orders, orders.riskScore);
        await m.addColumn(orders, orders.riskFactorsJson);
        await m.addColumn(userRulesTable, userRulesTable.riskScoreThreshold);
      }
      if (from < 23) {
        await m.addColumn(userRulesTable, userRulesTable.defaultReturnRatePercent);
        await m.addColumn(userRulesTable, userRulesTable.defaultReturnCostPerUnit);
      }
      if (from < 24) {
        await m.addColumn(userRulesTable, userRulesTable.blockFulfillWhenInsufficientStock);
      }
      if (from < 25) {
        await m.addColumn(userRulesTable, userRulesTable.autoPauseListingWhenMarginBelowThreshold);
      }
      if (from < 26) {
        await m.addColumn(userRulesTable, userRulesTable.defaultSupplierProcessingDays);
        await m.addColumn(userRulesTable, userRulesTable.defaultSupplierShippingDays);
        await m.addColumn(userRulesTable, userRulesTable.marketplaceMaxDeliveryDays);
      }
      if (from < 27) {
        await m.createTable(supplierReliabilityScores);
      }
      if (from < 28) {
        await m.createTable(listingHealthMetrics);
      }
      if (from < 29) {
        await m.addColumn(userRulesTable, userRulesTable.listingHealthMaxReturnRatePercent);
        await m.addColumn(userRulesTable, userRulesTable.listingHealthMaxLateRatePercent);
        await m.addColumn(userRulesTable, userRulesTable.autoPauseListingWhenHealthPoor);
      }
      if (from < 30) {
        await m.addColumn(userRulesTable, userRulesTable.safetyStockBuffer);
      }
      if (from < 31) {
        await m.createTable(customerMetrics);
      }
      if (from < 32) {
        await m.addColumn(userRulesTable, userRulesTable.customerAbuseMaxReturnRatePercent);
        await m.addColumn(userRulesTable, userRulesTable.customerAbuseMaxComplaintRatePercent);
      }
      if (from < 33) {
        await m.createTable(stockState);
      }
      if (from < 34) {
        await m.addColumn(userRulesTable, userRulesTable.priceRefreshIntervalMinutesBySourceJson);
      }
      if (from < 35) {
        await m.addColumn(suppliers, suppliers.regulationsUrl);
        await m.addColumn(suppliers, suppliers.termsUrl);
        await m.addColumn(suppliers, suppliers.returnPolicyUrl);
      }
      if (from < 36) {
        await m.addColumn(orders, orders.buyerMessage);
        await m.addColumn(orders, orders.deliveryMethodName);
      }
      if (from < 37) {
        // v36 -> v37: product intelligence pipeline persistence tables (matching, scoring, switching, pausing).
        await m.createTable(productGroups);
        await m.createTable(productGroupMembers);
        await m.createTable(productIntelligenceStates);
        await m.createTable(supplierSwitchEvents);
        await m.createTable(listingPauseEvents);
        await customStatement('CREATE UNIQUE INDEX IF NOT EXISTS idx_product_groups_group_id ON product_groups (tenant_id, group_id)');
        await customStatement('CREATE UNIQUE INDEX IF NOT EXISTS idx_product_intel_product_id ON product_intelligence_states (tenant_id, product_id)');
        await customStatement('CREATE INDEX IF NOT EXISTS idx_product_group_members_gid ON product_group_members (tenant_id, group_id)');
        await customStatement('CREATE INDEX IF NOT EXISTS idx_pause_events_listing_id ON listing_pause_events (tenant_id, listing_id)');
      }
    },
  );
}
