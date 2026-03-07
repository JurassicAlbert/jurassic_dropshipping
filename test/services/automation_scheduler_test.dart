import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/listing_decider.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/scanner.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/supplier_selector.dart';
import 'package:jurassic_dropshipping/services/automation_scheduler.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';
import 'package:jurassic_dropshipping/services/order_sync_service.dart';
import 'package:jurassic_dropshipping/services/price_refresh_service.dart';

import '../fixtures/test_database.dart';
import '../fixtures/test_fixtures.dart';
import '../mocks/mock_source_platform.dart';
import '../mocks/mock_target_platform.dart';

void main() {
  late AppDatabase db;
  late AutomationScheduler scheduler;

  setUp(() async {
    Fixtures.reset();
    db = createTestDatabase();

    final rulesRepo = RulesRepository(db);
    await rulesRepo.save(Fixtures.defaultRules);

    final productRepo = ProductRepository(db);
    final listingRepo = ListingRepository(db);
    final orderRepo = OrderRepository(db);
    final decisionLogRepo = DecisionLogRepository(db);
    final offerRepo = SupplierOfferRepository(db);

    final pricingCalculator = PricingCalculator();
    final listingDecider = ListingDecider(pricingCalculator: pricingCalculator);
    final supplierSelector = SupplierSelector();
    final mockSource = MockSourcePlatform(mockId: 'mock_source');
    final mockTarget = MockTargetPlatform(mockId: 'mock_target');

    final scanner = Scanner(
      productRepository: productRepo,
      listingRepository: listingRepo,
      decisionLogRepository: decisionLogRepo,
      rulesRepository: rulesRepo,
      pricingCalculator: pricingCalculator,
      listingDecider: listingDecider,
      supplierSelector: supplierSelector,
      sources: [mockSource],
    );

    final orderSyncService = OrderSyncService(
      orderRepository: orderRepo,
      rulesRepository: rulesRepo,
      targets: [mockTarget],
    );

    final fulfillmentService = FulfillmentService(
      orderRepository: orderRepo,
      listingRepository: listingRepo,
      productRepository: productRepo,
      sources: [mockSource],
      targets: [mockTarget],
    );

    final priceRefreshService = PriceRefreshService(
      supplierOfferRepository: offerRepo,
      sources: [mockSource],
    );

    scheduler = AutomationScheduler(
      scanner: scanner,
      orderSyncService: orderSyncService,
      fulfillmentService: fulfillmentService,
      rulesRepository: rulesRepo,
      priceRefreshService: priceRefreshService,
    );
  });

  tearDown(() async {
    scheduler.stopAll();
    await db.close();
  });

  group('AutomationScheduler', () {
    test('isRunning states are false initially', () {
      expect(scheduler.isScanRunning, isFalse);
      expect(scheduler.isSyncRunning, isFalse);
      expect(scheduler.isPriceRefreshRunning, isFalse);
    });

    test('startAll starts all timers', () async {
      await scheduler.startAll();

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(scheduler.isScanRunning, isTrue);
      expect(scheduler.isSyncRunning, isTrue);
      expect(scheduler.isPriceRefreshRunning, isTrue);
    });

    test('stopAll stops all timers', () async {
      await scheduler.startAll();
      await Future<void>.delayed(const Duration(milliseconds: 100));

      scheduler.stopAll();

      expect(scheduler.isScanRunning, isFalse);
      expect(scheduler.isSyncRunning, isFalse);
      expect(scheduler.isPriceRefreshRunning, isFalse);
    });
  });
}
