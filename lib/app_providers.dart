import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/data/models/marketplace_account.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/marketplace_account_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/listing_decider.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/scanner.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/supplier_selector.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/allegro_oauth_service.dart';
import 'package:jurassic_dropshipping/services/price_refresh_service.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';
import 'package:jurassic_dropshipping/services/automation_scheduler.dart';
import 'package:jurassic_dropshipping/services/order_sync_service.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';
import 'package:jurassic_dropshipping/services/sources/api2cart_client.dart';
import 'package:jurassic_dropshipping/services/sources/api2cart_source_platform.dart';
import 'package:jurassic_dropshipping/services/sources/cj_dropshipping_client.dart';
import 'package:jurassic_dropshipping/services/sources/cj_source_platform.dart';
import 'package:jurassic_dropshipping/services/targets/allegro_client.dart';
import 'package:jurassic_dropshipping/services/targets/allegro_target_platform.dart';
import 'package:jurassic_dropshipping/services/targets/temu_seller_client.dart';
import 'package:jurassic_dropshipping/services/targets/temu_target_platform.dart';

final dbProvider = Provider<AppDatabase>((ref) => AppDatabase());

final secureStorageProvider = Provider<SecureStorageService>((ref) => SecureStorageService());

final productRepositoryProvider = Provider<ProductRepository>((ref) => ProductRepository(ref.watch(dbProvider)));
final listingRepositoryProvider = Provider<ListingRepository>((ref) => ListingRepository(ref.watch(dbProvider)));
final orderRepositoryProvider = Provider<OrderRepository>((ref) => OrderRepository(ref.watch(dbProvider)));
final decisionLogRepositoryProvider = Provider<DecisionLogRepository>((ref) => DecisionLogRepository(ref.watch(dbProvider)));
final rulesRepositoryProvider = Provider<RulesRepository>((ref) => RulesRepository(ref.watch(dbProvider)));
final supplierRepositoryProvider = Provider<SupplierRepository>((ref) => SupplierRepository(ref.watch(dbProvider)));
final supplierOfferRepositoryProvider = Provider<SupplierOfferRepository>((ref) => SupplierOfferRepository(ref.watch(dbProvider)));
final returnRepositoryProvider = Provider<ReturnRepository>((ref) => ReturnRepository(ref.watch(dbProvider)));
final marketplaceAccountRepositoryProvider = Provider<MarketplaceAccountRepository>((ref) => MarketplaceAccountRepository(ref.watch(dbProvider)));

final cjClientProvider = Provider<CjDropshippingClient>((ref) => CjDropshippingClient(secureStorage: ref.watch(secureStorageProvider)));
final allegroClientProvider = Provider<AllegroClient>((ref) => AllegroClient(secureStorage: ref.watch(secureStorageProvider)));

final cjSourceProvider = Provider<SourcePlatform>((ref) => CjSourcePlatform(ref.watch(cjClientProvider)));
final allegroTargetProvider = Provider<TargetPlatform>((ref) => AllegroTargetPlatform(ref.watch(allegroClientProvider)));

final temuSellerClientProvider = Provider<TemuSellerClient>((ref) => TemuSellerClient(secureStorage: ref.watch(secureStorageProvider)));
final temuTargetProvider = Provider<TargetPlatform>((ref) => TemuTargetPlatform(ref.watch(temuSellerClientProvider)));

final api2cartClientProvider = Provider<Api2CartClient>((ref) => Api2CartClient(secureStorage: ref.watch(secureStorageProvider)));
final api2cartSourceProvider = Provider<SourcePlatform>((ref) => Api2CartSourcePlatform(ref.watch(api2cartClientProvider)));

final sourcesListProvider = Provider<List<SourcePlatform>>((ref) => [ref.watch(cjSourceProvider), ref.watch(api2cartSourceProvider)]);
final targetsListProvider = Provider<List<TargetPlatform>>((ref) => [ref.watch(allegroTargetProvider), ref.watch(temuTargetProvider)]);

final pricingCalculatorProvider = Provider<PricingCalculator>((ref) => PricingCalculator());
final listingDeciderProvider = Provider<ListingDecider>((ref) => ListingDecider(pricingCalculator: ref.watch(pricingCalculatorProvider)));
final supplierSelectorProvider = Provider<SupplierSelector>((ref) => SupplierSelector());

final scannerProvider = Provider<Scanner>((ref) => Scanner(
  productRepository: ref.watch(productRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  decisionLogRepository: ref.watch(decisionLogRepositoryProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
  pricingCalculator: ref.watch(pricingCalculatorProvider),
  listingDecider: ref.watch(listingDeciderProvider),
  supplierSelector: ref.watch(supplierSelectorProvider),
  sources: ref.watch(sourcesListProvider),
  targetPlatformId: 'allegro',
));

final orderSyncServiceProvider = Provider<OrderSyncService>((ref) => OrderSyncService(
  orderRepository: ref.watch(orderRepositoryProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
  targets: ref.watch(targetsListProvider),
));

final fulfillmentServiceProvider = Provider<FulfillmentService>((ref) => FulfillmentService(
  orderRepository: ref.watch(orderRepositoryProvider),
  listingRepository: ref.watch(listingRepositoryProvider),
  productRepository: ref.watch(productRepositoryProvider),
  sources: ref.watch(sourcesListProvider),
  targets: ref.watch(targetsListProvider),
));

final allegroOAuthProvider = Provider<AllegroOAuthService>((ref) => AllegroOAuthService(
  secureStorage: ref.watch(secureStorageProvider),
));

final priceRefreshServiceProvider = Provider<PriceRefreshService>((ref) => PriceRefreshService(
  supplierOfferRepository: ref.watch(supplierOfferRepositoryProvider),
  sources: ref.watch(sourcesListProvider),
));

final automationSchedulerProvider = Provider<AutomationScheduler>((ref) => AutomationScheduler(
  scanner: ref.watch(scannerProvider),
  orderSyncService: ref.watch(orderSyncServiceProvider),
  fulfillmentService: ref.watch(fulfillmentServiceProvider),
  rulesRepository: ref.watch(rulesRepositoryProvider),
  priceRefreshService: ref.watch(priceRefreshServiceProvider),
));

final listingsProvider = FutureProvider<List<Listing>>((ref) => ref.watch(listingRepositoryProvider).getAll());
final ordersProvider = FutureProvider<List<Order>>((ref) => ref.watch(orderRepositoryProvider).getAll());
final rulesProvider = FutureProvider<UserRules>((ref) => ref.watch(rulesRepositoryProvider).get());
final pendingListingsProvider = FutureProvider<List<Listing>>((ref) => ref.watch(listingRepositoryProvider).getPendingApproval());
final pendingOrdersProvider = FutureProvider<List<Order>>((ref) => ref.watch(orderRepositoryProvider).getPendingApproval());
final decisionLogsProvider = FutureProvider<List<DecisionLog>>((ref) => ref.watch(decisionLogRepositoryProvider).getAll(limit: 100));
final suppliersProvider = FutureProvider<List<Supplier>>((ref) => ref.watch(supplierRepositoryProvider).getAll());
final supplierOffersProvider = FutureProvider<List<SupplierOffer>>((ref) => ref.watch(supplierOfferRepositoryProvider).getAll());
final returnRequestsProvider = FutureProvider<List<ReturnRequest>>((ref) => ref.watch(returnRepositoryProvider).getAll());
final marketplaceAccountsProvider = FutureProvider<List<MarketplaceAccount>>((ref) => ref.watch(marketplaceAccountRepositoryProvider).getAll());
