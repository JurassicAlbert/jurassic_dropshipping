import 'package:flutter/material.dart' show Locale, ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/services/auth_service.dart';
import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/data/models/marketplace_account.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/feature_flag_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/marketplace_account_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/returned_stock_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/financial_ledger_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/incident_record_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_return_policy_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_reliability_score_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_health_metrics_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/customer_metrics_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/stock_state_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/listing_decider.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/scanner.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/supplier_selector.dart';
import 'package:jurassic_dropshipping/domain/post_order/post_order_lifecycle_engine.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_handling_engine.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';
import 'package:jurassic_dropshipping/domain/post_order/returned_stock.dart';
import 'package:jurassic_dropshipping/domain/post_order/supplier_return_policy.dart';
import 'package:jurassic_dropshipping/domain/post_order/return_routing_service.dart';
import 'package:jurassic_dropshipping/domain/catalog/catalog_cache.dart';
import 'package:jurassic_dropshipping/domain/capital/capital_management_service.dart';
import 'package:jurassic_dropshipping/domain/inventory/inventory_snapshot.dart';
import 'package:jurassic_dropshipping/domain/inventory/stock_state_refresh_service.dart';
import 'package:jurassic_dropshipping/domain/inventory/inventory_service.dart';
import 'package:jurassic_dropshipping/domain/observability/observability_metrics.dart';
import 'package:jurassic_dropshipping/domain/risk/order_risk_scoring_service.dart';
import 'package:jurassic_dropshipping/domain/listing_health/listing_health_metrics.dart';
import 'package:jurassic_dropshipping/domain/customer_abuse/customer_metrics.dart';
import 'package:jurassic_dropshipping/domain/listing_health/listing_health_scoring_service.dart';
import 'package:jurassic_dropshipping/domain/customer_abuse/customer_abuse_scoring_service.dart';
import 'package:jurassic_dropshipping/domain/supplier_reliability/supplier_reliability_score.dart';
import 'package:jurassic_dropshipping/domain/supplier_reliability/supplier_reliability_scoring_service.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/domain/resilience/circuit_breaker_registry.dart';
import 'package:jurassic_dropshipping/services/allegro_oauth_service.dart';
import 'package:jurassic_dropshipping/services/resilient_source_platform.dart';
import 'package:jurassic_dropshipping/services/marketplace_listing_sync_service.dart';
import 'package:jurassic_dropshipping/services/price_refresh_service.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';
import 'package:jurassic_dropshipping/services/automation_scheduler.dart';
import 'package:jurassic_dropshipping/services/billing_service.dart';
import 'package:jurassic_dropshipping/services/allegro_competitor_pricing_service.dart';
import 'package:jurassic_dropshipping/services/competitor_pricing_service.dart';
import 'package:jurassic_dropshipping/services/order_cancellation_service.dart';
import 'package:jurassic_dropshipping/services/order_sync_service.dart';
import 'package:jurassic_dropshipping/services/profit_guard_service.dart';
import 'package:jurassic_dropshipping/services/rate_limiter.dart';
import 'package:jurassic_dropshipping/services/background_job_processor_service.dart';
import 'package:jurassic_dropshipping/services/process_incident_job_handler.dart';
import 'package:jurassic_dropshipping/services/distributed_lock_service.dart';
import 'package:jurassic_dropshipping/data/repositories/background_job_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/billing_plan_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/tenant_plan_repository.dart';
import 'package:jurassic_dropshipping/data/seed/database_seeder.dart';
import 'package:jurassic_dropshipping/services/seed_service.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';
import 'package:jurassic_dropshipping/services/sources/api2cart_client.dart';
import 'package:jurassic_dropshipping/services/sources/api2cart_source_platform.dart';
import 'package:jurassic_dropshipping/services/sources/cj_dropshipping_client.dart';
import 'package:jurassic_dropshipping/services/sources/cj_source_platform.dart';
import 'package:jurassic_dropshipping/services/targets/allegro_client.dart';
import 'package:jurassic_dropshipping/services/targets/allegro_target_platform.dart';
import 'package:jurassic_dropshipping/services/targets/temu_seller_client.dart';
import 'package:jurassic_dropshipping/services/targets/temu_target_platform.dart';
import 'package:jurassic_dropshipping/services/locale_service.dart';
import 'package:jurassic_dropshipping/l10n/app_localizations.dart';

/// Feature flag keys (stored in DB; when missing, default is false).
const String kFeatureFlagTemuTarget = 'temu_target';
const String kFeatureFlagMessages = 'messages';

/// Current tenant id for multi-tenant isolation. Single-tenant defaults to 1.
final currentTenantIdProvider = Provider<int>((ref) => 1);

/// Cached feature flags from DB. Watch this to react to flag changes (e.g. after Settings save).
final featureFlagsProvider = FutureProvider<Map<String, bool>>((ref) async {
  final repo = ref.watch(featureFlagRepositoryProvider);
  return repo.getAll();
});

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final localeServiceProvider = Provider<LocaleService>((ref) => LocaleService());
final localeProvider = AsyncNotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

class LocaleNotifier extends AsyncNotifier<Locale> {
  @override
  Future<Locale> build() async {
    return ref.read(localeServiceProvider).getLocale();
  }

  Future<void> setLocale(Locale l) async {
    final code = l.languageCode == 'en' ? 'en' : 'pl';
    final locale = Locale(code);
    await ref.read(localeServiceProvider).setLocale(locale);
    state = AsyncData(locale);
  }
}

/// Localized strings for the current locale. Use after [localeProvider] is loaded.
final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  final locale = ref.watch(localeProvider).valueOrNull ?? AppLocalizations.defaultLocale;
  return AppLocalizations(locale);
});

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final dbProvider = Provider<AppDatabase>((ref) => AppDatabase());

final secureStorageProvider = Provider<SecureStorageService>((ref) => SecureStorageService());

final productRepositoryProvider = Provider<ProductRepository>((ref) => ProductRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final listingRepositoryProvider = Provider<ListingRepository>((ref) => ListingRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final orderRepositoryProvider = Provider<OrderRepository>((ref) => OrderRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final decisionLogRepositoryProvider = Provider<DecisionLogRepository>((ref) => DecisionLogRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final featureFlagRepositoryProvider = Provider<FeatureFlagRepository>((ref) => FeatureFlagRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final rulesRepositoryProvider = Provider<RulesRepository>((ref) => RulesRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final supplierRepositoryProvider = Provider<SupplierRepository>((ref) => SupplierRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final supplierOfferRepositoryProvider = Provider<SupplierOfferRepository>((ref) => SupplierOfferRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final returnRepositoryProvider = Provider<ReturnRepository>((ref) => ReturnRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final supplierReturnPolicyRepositoryProvider = Provider<SupplierReturnPolicyRepository>((ref) => SupplierReturnPolicyRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final incidentRecordRepositoryProvider = Provider<IncidentRecordRepository>((ref) => IncidentRecordRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final supplierReliabilityScoreRepositoryProvider = Provider<SupplierReliabilityScoreRepository>((ref) => SupplierReliabilityScoreRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final listingHealthMetricsRepositoryProvider = Provider<ListingHealthMetricsRepository>((ref) => ListingHealthMetricsRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final customerMetricsRepositoryProvider = Provider<CustomerMetricsRepository>((ref) => CustomerMetricsRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final stockStateRepositoryProvider = Provider<StockStateRepository>((ref) => StockStateRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final returnedStockRepositoryProvider = Provider<ReturnedStockRepository>((ref) => ReturnedStockRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final financialLedgerRepositoryProvider = Provider<FinancialLedgerRepository>((ref) => FinancialLedgerRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final capitalManagementServiceProvider = Provider<CapitalManagementService>((ref) => CapitalManagementService(
  ref.watch(financialLedgerRepositoryProvider),
  ref.watch(orderRepositoryProvider),
));
final postOrderLifecycleEngineProvider = Provider<PostOrderLifecycleEngine>((ref) => PostOrderLifecycleEngine(ref.watch(orderRepositoryProvider)));
final returnRoutingServiceProvider = Provider<ReturnRoutingService>((ref) => ReturnRoutingService());
final inventoryServiceProvider = Provider<InventoryService>((ref) => InventoryService(
  orderRepository: ref.watch(orderRepositoryProvider),
  returnedStockRepository: ref.watch(returnedStockRepositoryProvider),
  stockStateRepository: ref.watch(stockStateRepositoryProvider),
));
final supplierReliabilityScoringServiceProvider = Provider<SupplierReliabilityScoringService>((ref) => SupplierReliabilityScoringService(
  orderRepository: ref.watch(orderRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  productRepository: ref.watch(productRepositoryProvider),
  incidentRecordRepository: ref.watch(incidentRecordRepositoryProvider),
  scoreRepository: ref.watch(supplierReliabilityScoreRepositoryProvider),
));
final listingHealthScoringServiceProvider = Provider<ListingHealthScoringService>((ref) => ListingHealthScoringService(
  orderRepository: ref.watch(orderRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  incidentRecordRepository: ref.watch(incidentRecordRepositoryProvider),
  returnRepository: ref.watch(returnRepositoryProvider),
  metricsRepository: ref.watch(listingHealthMetricsRepositoryProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
));
final customerAbuseScoringServiceProvider = Provider<CustomerAbuseScoringService>((ref) => CustomerAbuseScoringService(
  orderRepository: ref.watch(orderRepositoryProvider),
  returnRepository: ref.watch(returnRepositoryProvider),
  incidentRecordRepository: ref.watch(incidentRecordRepositoryProvider),
  metricsRepository: ref.watch(customerMetricsRepositoryProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
));
final stockStateRefreshServiceProvider = Provider<StockStateRefreshService>((ref) => StockStateRefreshService(
  listingRepository: ref.watch(listingRepositoryProvider),
  orderRepository: ref.watch(orderRepositoryProvider),
  returnedStockRepository: ref.watch(returnedStockRepositoryProvider),
  stockStateRepository: ref.watch(stockStateRepositoryProvider),
));
final incidentHandlingEngineProvider = Provider<IncidentHandlingEngine>((ref) => IncidentHandlingEngine(
  ref.watch(incidentRecordRepositoryProvider),
  ref.watch(decisionLogRepositoryProvider),
));
final marketplaceAccountRepositoryProvider = Provider<MarketplaceAccountRepository>((ref) => MarketplaceAccountRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final backgroundJobRepositoryProvider = Provider<BackgroundJobRepository>((ref) => BackgroundJobRepository(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final distributedLockServiceProvider = Provider<DistributedLockService>((ref) => DistributedLockService(ref.watch(dbProvider), tenantId: ref.watch(currentTenantIdProvider)));
final billingPlanRepositoryProvider = Provider<BillingPlanRepository>((ref) => BillingPlanRepository(ref.watch(dbProvider)));
final tenantPlanRepositoryProvider = Provider<TenantPlanRepository>((ref) => TenantPlanRepository(ref.watch(dbProvider)));
final billingServiceProvider = Provider<BillingService>((ref) => BillingService(
  listingRepository: ref.watch(listingRepositoryProvider),
  orderRepository: ref.watch(orderRepositoryProvider),
  tenantPlanRepository: ref.watch(tenantPlanRepositoryProvider),
  billingPlanRepository: ref.watch(billingPlanRepositoryProvider),
));

/// Current tenant usage and plan (for Settings / over-limit UI).
final billingUsageProvider = FutureProvider<BillingUsage>((ref) => ref.watch(billingServiceProvider).getUsage());

final databaseSeederProvider = Provider<DatabaseSeeder>((ref) => DatabaseSeeder(
  db: ref.watch(dbProvider),
  productRepo: ref.watch(productRepositoryProvider),
  listingRepo: ref.watch(listingRepositoryProvider),
  orderRepo: ref.watch(orderRepositoryProvider),
  supplierRepo: ref.watch(supplierRepositoryProvider),
  supplierOfferRepo: ref.watch(supplierOfferRepositoryProvider),
  returnRepo: ref.watch(returnRepositoryProvider),
  decisionLogRepo: ref.watch(decisionLogRepositoryProvider),
  rulesRepo: ref.watch(rulesRepositoryProvider),
  marketplaceAccountRepo: ref.watch(marketplaceAccountRepositoryProvider),
));

final seedServiceProvider = Provider<SeedService>((ref) => SeedService(
  db: ref.watch(dbProvider),
  productRepository: ref.watch(productRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  orderRepository: ref.watch(orderRepositoryProvider),
  supplierRepository: ref.watch(supplierRepositoryProvider),
  supplierOfferRepository: ref.watch(supplierOfferRepositoryProvider),
  returnRepository: ref.watch(returnRepositoryProvider),
  decisionLogRepository: ref.watch(decisionLogRepositoryProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
));

/// Per-platform rate limiter from rules (rateLimitMaxRequestsPerSecond). Default 5 req/s when not set.
final rateLimiterForPlatformProvider = Provider.family<RateLimiter, String>((ref, platformId) {
  final rules = ref.watch(rulesProvider).valueOrNull;
  final max = rules?.rateLimitMaxRequestsPerSecond[platformId] ?? 5;
  return RateLimiter(maxRequests: max, window: const Duration(seconds: 1));
});

final cjClientProvider = Provider<CjDropshippingClient>((ref) => CjDropshippingClient(
  secureStorage: ref.watch(secureStorageProvider),
  rateLimiter: ref.watch(rateLimiterForPlatformProvider('cj')),
));
final allegroClientProvider = Provider<AllegroClient>((ref) => AllegroClient(
  secureStorage: ref.watch(secureStorageProvider),
  rateLimiter: ref.watch(rateLimiterForPlatformProvider('allegro')),
));

final cjSourceRawProvider = Provider<SourcePlatform>((ref) => CjSourcePlatform(ref.watch(cjClientProvider)));
final allegroTargetProvider = Provider<TargetPlatform>((ref) => AllegroTargetPlatform(ref.watch(allegroClientProvider)));

final temuSellerClientProvider = Provider<TemuSellerClient>((ref) => TemuSellerClient(
  secureStorage: ref.watch(secureStorageProvider),
  rateLimiter: ref.watch(rateLimiterForPlatformProvider('temu')),
));
final temuTargetProvider = Provider<TargetPlatform>((ref) => TemuTargetPlatform(ref.watch(temuSellerClientProvider)));

final api2cartClientProvider = Provider<Api2CartClient>((ref) => Api2CartClient(
  secureStorage: ref.watch(secureStorageProvider),
  rateLimiter: ref.watch(rateLimiterForPlatformProvider('api2cart')),
));
final api2cartSourceRawProvider = Provider<SourcePlatform>((ref) => Api2CartSourcePlatform(ref.watch(api2cartClientProvider)));

/// Phase 22: Circuit breaker registry (one per source platform).
final circuitBreakerRegistryProvider = Provider<CircuitBreakerRegistry>((ref) => CircuitBreakerRegistry());

final cjSourceProvider = Provider<SourcePlatform>((ref) => ResilientSourcePlatform(
  ref.watch(cjSourceRawProvider),
  circuitRegistry: ref.watch(circuitBreakerRegistryProvider),
));
final api2cartSourceProvider = Provider<SourcePlatform>((ref) => ResilientSourcePlatform(
  ref.watch(api2cartSourceRawProvider),
  circuitRegistry: ref.watch(circuitBreakerRegistryProvider),
));

final sourcesListProvider = Provider<List<SourcePlatform>>(
  (ref) => [ref.watch(cjSourceProvider), ref.watch(api2cartSourceProvider)],
);
final targetsListProvider = Provider<List<TargetPlatform>>((ref) {
  final targets = <TargetPlatform>[ref.watch(allegroTargetProvider)];
  final flags = ref.watch(featureFlagsProvider).valueOrNull;
  final enableTemu = flags?[kFeatureFlagTemuTarget] ?? false;
  if (enableTemu) {
    targets.add(ref.watch(temuTargetProvider));
  }
  return targets;
});

final pricingCalculatorProvider = Provider<PricingCalculator>((ref) => PricingCalculator());
final listingDeciderProvider = Provider<ListingDecider>((ref) => ListingDecider(pricingCalculator: ref.watch(pricingCalculatorProvider)));
final supplierSelectorProvider = Provider<SupplierSelector>((ref) => SupplierSelector());

/// Uses live Allegro listing API when [kFeatureFlagCompetitorPricingLive] is enabled; otherwise behaves like stub (returns null).
final competitorPricingServiceProvider = Provider<CompetitorPricingService>(
  (ref) => AllegroCompetitorPricingService(
    allegroClient: ref.watch(allegroClientProvider),
    featureFlagRepository: ref.watch(featureFlagRepositoryProvider),
  ),
);

final scannerProvider = Provider<Scanner>((ref) => Scanner(
  productRepository: ref.watch(productRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  decisionLogRepository: ref.watch(decisionLogRepositoryProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
  pricingCalculator: ref.watch(pricingCalculatorProvider),
  listingDecider: ref.watch(listingDeciderProvider),
  supplierSelector: ref.watch(supplierSelectorProvider),
  sources: ref.watch(sourcesListProvider),
  targetPlatformIds: ref.watch(targetsListProvider).map((t) => t.id).toList(),
  competitorPricingService: ref.watch(competitorPricingServiceProvider),
  billingService: ref.watch(billingServiceProvider),
));

final orderCancellationServiceProvider = Provider<OrderCancellationService>((ref) => OrderCancellationService(
  orderRepository: ref.watch(orderRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  productRepository: ref.watch(productRepositoryProvider),
  returnRepository: ref.watch(returnRepositoryProvider),
  targets: ref.watch(targetsListProvider),
  sources: ref.watch(sourcesListProvider),
));

final orderRiskScoringServiceProvider = Provider<OrderRiskScoringService>((ref) => OrderRiskScoringService());

/// Phase 32: shared metrics instance for observability (orders, fulfillment, jobs, listing updates).
final observabilityMetricsProvider = Provider<ObservabilityMetrics>((ref) => ObservabilityMetrics());

/// Phase 30: optional in-memory catalog cache (product/listing/offer). Reduces DB reads; invalidated on catalog_event.
final catalogCacheProvider = Provider<CatalogCache>((ref) => CatalogCache());

/// Pending background job count for dashboard system status.
final pendingJobCountProvider = FutureProvider<int>((ref) async {
  return ref.read(backgroundJobRepositoryProvider).countPending();
});

/// Snapshot of observability metrics; watch [observabilitySnapshotVersionProvider] and increment to refresh.
final observabilitySnapshotVersionProvider = StateProvider<int>((ref) => 0);
final observabilitySnapshotProvider = Provider<ObservabilitySnapshot>((ref) {
  ref.watch(observabilitySnapshotVersionProvider);
  return ref.read(observabilityMetricsProvider).getSnapshot();
});

final orderSyncServiceProvider = Provider<OrderSyncService>((ref) => OrderSyncService(
  orderRepository: ref.watch(orderRepositoryProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
  targets: ref.watch(targetsListProvider),
  orderCancellationService: ref.watch(orderCancellationServiceProvider),
  orderRiskScoringService: ref.watch(orderRiskScoringServiceProvider),
  customerAbuseScoringService: ref.watch(customerAbuseScoringServiceProvider),
  observabilityMetrics: ref.watch(observabilityMetricsProvider),
));

final fulfillmentServiceProvider = Provider<FulfillmentService>((ref) => FulfillmentService(
  orderRepository: ref.watch(orderRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  productRepository: ref.watch(productRepositoryProvider),
  decisionLogRepository: ref.watch(decisionLogRepositoryProvider),
  sources: ref.watch(sourcesListProvider),
  targets: ref.watch(targetsListProvider),
  orderCancellationService: ref.watch(orderCancellationServiceProvider),
  returnedStockRepository: ref.watch(returnedStockRepositoryProvider),
  distributedLockService: ref.watch(distributedLockServiceProvider),
  capitalManagementService: ref.watch(capitalManagementServiceProvider),
  inventoryService: ref.watch(inventoryServiceProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
));

final allegroOAuthProvider = Provider<AllegroOAuthService>((ref) => AllegroOAuthService(
  secureStorage: ref.watch(secureStorageProvider),
));

final profitGuardServiceProvider = Provider<ProfitGuardService>((ref) => ProfitGuardService(
  rulesRepository: ref.watch(rulesRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  productRepository: ref.watch(productRepositoryProvider),
  supplierOfferRepository: ref.watch(supplierOfferRepositoryProvider),
  decisionLogRepository: ref.watch(decisionLogRepositoryProvider),
  pricingCalculator: ref.watch(pricingCalculatorProvider),
));

final processIncidentJobHandlerProvider = Provider<ProcessIncidentJobHandler>((ref) => ProcessIncidentJobHandler(
  incidentRecordRepository: ref.watch(incidentRecordRepositoryProvider),
  incidentHandlingEngine: ref.watch(incidentHandlingEngineProvider),
  orderRepository: ref.watch(orderRepositoryProvider),
  returnRepository: ref.watch(returnRepositoryProvider),
  targets: ref.watch(targetsListProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  productRepository: ref.watch(productRepositoryProvider),
  supplierReturnPolicyRepository: ref.watch(supplierReturnPolicyRepositoryProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
  capitalManagementService: ref.watch(capitalManagementServiceProvider),
));

final backgroundJobProcessorServiceProvider = Provider<BackgroundJobProcessorService>((ref) => BackgroundJobProcessorService(
  jobRepository: ref.watch(backgroundJobRepositoryProvider),
  scanner: ref.watch(scannerProvider),
  fulfillmentService: ref.watch(fulfillmentServiceProvider),
  priceRefreshService: ref.watch(priceRefreshServiceProvider),
  processIncidentJobHandler: ref.watch(processIncidentJobHandlerProvider),
  marketplaceListingSyncService: ref.watch(marketplaceListingSyncServiceProvider),
  observabilityMetrics: ref.watch(observabilityMetricsProvider),
  catalogCache: ref.watch(catalogCacheProvider),
));

final priceRefreshServiceProvider = Provider<PriceRefreshService>((ref) => PriceRefreshService(
  supplierOfferRepository: ref.watch(supplierOfferRepositoryProvider),
  sources: ref.watch(sourcesListProvider),
  profitGuard: ref.watch(profitGuardServiceProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
  jobRepository: ref.watch(backgroundJobRepositoryProvider),
));

final marketplaceListingSyncServiceProvider = Provider<MarketplaceListingSyncService>((ref) => MarketplaceListingSyncService(
  listingRepository: ref.watch(listingRepositoryProvider),
  productRepository: ref.watch(productRepositoryProvider),
  sources: ref.watch(sourcesListProvider),
  targets: ref.watch(targetsListProvider),
  profitGuard: ref.watch(profitGuardServiceProvider),
));

final automationSchedulerProvider = Provider<AutomationScheduler>((ref) => AutomationScheduler(
  scanner: ref.watch(scannerProvider),
  orderSyncService: ref.watch(orderSyncServiceProvider),
  fulfillmentService: ref.watch(fulfillmentServiceProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
  priceRefreshService: ref.watch(priceRefreshServiceProvider),
  marketplaceListingSyncService: ref.watch(marketplaceListingSyncServiceProvider),
  jobRepository: ref.watch(backgroundJobRepositoryProvider),
  jobProcessor: ref.watch(backgroundJobProcessorServiceProvider),
  observabilityMetrics: ref.watch(observabilityMetricsProvider),
));

final listingsProvider = FutureProvider<List<Listing>>((ref) => ref.watch(listingRepositoryProvider).getAll());
final ordersProvider = FutureProvider<List<Order>>((ref) => ref.watch(orderRepositoryProvider).getAll());
final rulesProvider = FutureProvider<UserRules>((ref) => ref.watch(rulesRepositoryProvider).get());
final pendingListingsProvider = FutureProvider<List<Listing>>((ref) => ref.watch(listingRepositoryProvider).getPendingApproval());
final pendingOrdersProvider = FutureProvider<List<Order>>((ref) => ref.watch(orderRepositoryProvider).getPendingApproval());

/// Fresh stock at source for an order (for display on approval screen). Null if unknown or refresh failed.
final orderStockAtSourceProvider = FutureProvider.family<int?, String>((ref, orderId) async {
  final orderRepo = ref.read(orderRepositoryProvider);
  final listingRepo = ref.read(listingRepositoryProvider);
  final productRepo = ref.read(productRepositoryProvider);
  final sources = ref.read(sourcesListProvider);
  final order = await orderRepo.getByLocalId(orderId);
  if (order == null) return null;
  final listing = await listingRepo.getByLocalId(order.listingId) ??
      await listingRepo.getByTargetListingId(order.targetPlatformId, order.listingId);
  if (listing == null) return null;
  final product = await productRepo.getByLocalId(listing.productId);
  if (product == null || product.variants.isEmpty) return null;
  final sourceList = sources.where((s) => s.id == product.sourcePlatformId).toList();
  final source = sourceList.isEmpty ? null : sourceList.first;
  if (source == null) return null;
  try {
    final fresh = await source.getProduct(product.sourceId);
    if (fresh == null || fresh.variants.isEmpty) return null;
    if (listing.variantId != null) {
      final variant = fresh.variants.where((v) => v.id == listing.variantId).firstOrNull;
      if (variant == null) return null;
      return variant.stock;
    }
    return fresh.variants.fold<int>(0, (s, v) => s + v.stock);
  } catch (_) {
    return null;
  }
});

/// Fresh stock at source for a listing (for display on approval screen). Null if unknown or refresh failed.
final listingStockAtSourceProvider = FutureProvider.family<int?, String>((ref, listingId) async {
  final listingRepo = ref.read(listingRepositoryProvider);
  final productRepo = ref.read(productRepositoryProvider);
  final sources = ref.read(sourcesListProvider);
  final listing = await listingRepo.getByLocalId(listingId);
  if (listing == null) return null;
  final product = await productRepo.getByLocalId(listing.productId);
  if (product == null || product.variants.isEmpty) return null;
  final sourceList = sources.where((s) => s.id == product.sourcePlatformId).toList();
  final source = sourceList.isEmpty ? null : sourceList.first;
  if (source == null) return null;
  try {
    final fresh = await source.getProduct(product.sourceId);
    if (fresh == null || fresh.variants.isEmpty) return null;
    final String? variantId = listing.variantId;
    if (variantId != null) {
      final variant = fresh.variants.where((v) => v.id == variantId).firstOrNull;
      if (variant == null) return null;
      return variant.stock;
    }
    return fresh.variants.fold<int>(0, (s, v) => s + v.stock);
  } catch (_) {
    return null;
  }
});

final decisionLogsProvider = FutureProvider<List<DecisionLog>>((ref) => ref.watch(decisionLogRepositoryProvider).getAll(limit: 100));
final suppliersProvider = FutureProvider<List<Supplier>>((ref) => ref.watch(supplierRepositoryProvider).getAll());
final supplierOffersProvider = FutureProvider<List<SupplierOffer>>((ref) => ref.watch(supplierOfferRepositoryProvider).getAll());
final returnRequestsProvider = FutureProvider<List<ReturnRequest>>((ref) => ref.watch(returnRepositoryProvider).getAll());

final incidentsProvider = FutureProvider<List<IncidentRecord>>((ref) => ref.watch(incidentRecordRepositoryProvider).getAll());
final incidentDetailProvider = FutureProvider.family<IncidentRecord?, int>((ref, id) => ref.watch(incidentRecordRepositoryProvider).getById(id));

final supplierReturnPoliciesProvider = FutureProvider<List<SupplierReturnPolicy>>((ref) => ref.watch(supplierReturnPolicyRepositoryProvider).getAll());
final supplierReliabilityScoresProvider = FutureProvider<List<SupplierReliabilityScore>>((ref) => ref.watch(supplierReliabilityScoreRepositoryProvider).getAll());
final listingHealthMetricsListProvider = FutureProvider<List<ListingHealthRecord>>((ref) => ref.watch(listingHealthMetricsRepositoryProvider).getAll());
final customerMetricsListProvider = FutureProvider<List<CustomerMetricsRecord>>((ref) => ref.watch(customerMetricsRepositoryProvider).getAll());

final returnedStockListProvider = FutureProvider<List<ReturnedStock>>((ref) => ref.watch(returnedStockRepositoryProvider).getAll());

/// Inventory snapshots for orders (first 30 by key). Key = comma-separated order ids.
/// Used on Orders screen to show "Available to sell" per order.
/// Phase 19: applies safetyStockBuffer from rules when computing availableToSell.
final orderInventoryMapProvider = FutureProvider.family<Map<String, InventorySnapshot>, String>((ref, orderIdsKey) async {
  if (orderIdsKey.isEmpty) return {};
  final orderIds = orderIdsKey.split(',').where((e) => e.isNotEmpty).take(30).toList();
  final orderRepo = ref.watch(orderRepositoryProvider);
  final listingRepo = ref.watch(listingRepositoryProvider);
  final inventory = ref.watch(inventoryServiceProvider);
  final rules = await ref.watch(rulesProvider.future);
  final buffer = rules.safetyStockBuffer > 0 ? rules.safetyStockBuffer : null;
  final map = <String, InventorySnapshot>{};
  for (final id in orderIds) {
    try {
      final o = await orderRepo.getByLocalId(id);
      if (o == null) continue;
      final listing = await listingRepo.getByLocalId(o.listingId) ??
          await listingRepo.getByTargetListingId(o.targetPlatformId, o.listingId);
      if (listing == null) continue;
      final snapshot = await inventory.availableToSell(
        listing.productId,
        o.listingId,
        safetyStockBuffer: buffer,
      );
      map[o.id] = snapshot;
    } catch (_) {}
  }
  return map;
});

final marketplaceAccountsProvider = FutureProvider<List<MarketplaceAccount>>((ref) => ref.watch(marketplaceAccountRepositoryProvider).getAll());
