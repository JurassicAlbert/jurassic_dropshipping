import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/feature_flag_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_intelligence_state_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/listing_decider.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/scanner.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/supplier_selector.dart';

import '../fixtures/test_database.dart';
import '../fixtures/test_fixtures.dart';
import '../mocks/mock_source_platform.dart';

void main() {
  late AppDatabase db;
  late ProductRepository productRepo;
  late ListingRepository listingRepo;
  late DecisionLogRepository logRepo;
  late RulesRepository rulesRepo;
  late PricingCalculator pricingCalculator;
  late ListingDecider listingDecider;
  late SupplierSelector supplierSelector;

  setUp(() async {
    Fixtures.reset();
    db = createTestDatabase();
    productRepo = ProductRepository(db);
    listingRepo = ListingRepository(db);
    logRepo = DecisionLogRepository(db);
    rulesRepo = RulesRepository(db);
    pricingCalculator = PricingCalculator(marketplaceFeePercent: 10.0);
    listingDecider = ListingDecider(pricingCalculator: pricingCalculator);
    supplierSelector = SupplierSelector();
  });

  tearDown(() async {
    await db.close();
  });

  group('Scanner → Listing integration', () {
    test('Scanner.run() creates listings from source products', () async {
      const rules = UserRules(
        minProfitPercent: 15.0,
        defaultMarkupPercent: 30.0,
        searchKeywords: ['electronics'],
        manualApprovalListings: true,
        manualApprovalOrders: true,
      );
      await rulesRepo.save(rules);

      final products = [
        Fixtures.product(
          id: 'prod_scan_1',
          sourceId: 'src_scan_1',
          sourcePlatformId: 'mock_source',
          basePrice: 50.0,
          shippingCost: 5.0,
        ),
        Fixtures.product(
          id: 'prod_scan_2',
          sourceId: 'src_scan_2',
          sourcePlatformId: 'mock_source',
          basePrice: 30.0,
          shippingCost: 3.0,
        ),
      ];

      final mockSource = MockSourcePlatform(
        mockId: 'mock_source',
        products: products,
      );

      final scanner = Scanner(
        productRepository: productRepo,
        listingRepository: listingRepo,
        decisionLogRepository: logRepo,
        rulesRepository: rulesRepo,
        pricingCalculator: pricingCalculator,
        listingDecider: listingDecider,
        supplierSelector: supplierSelector,
        sources: [mockSource],
        featureFlagRepository: FeatureFlagRepository(db),
        productIntelligenceStateRepository: ProductIntelligenceStateRepository(db),
        targetPlatformId: 'allegro',
      );

      final result = await scanner.run();

      expect(result.candidatesFound, 2);
      expect(result.listingsCreated, 2);

      final listings = await listingRepo.getAll();
      expect(listings, hasLength(2));

      for (final listing in listings) {
        expect(listing.status, ListingStatus.pendingApproval);
        expect(listing.targetPlatformId, 'allegro');
        expect(listing.sellingPrice, greaterThan(0));
        expect(listing.sourceCost, greaterThan(0));
        expect(listing.decisionLogId, isNotNull);
      }

      final savedProducts = await productRepo.getAll();
      expect(savedProducts, hasLength(2));
    });

    test('Scanner.run() writes decision logs for each listing', () async {
      const rules = UserRules(
        minProfitPercent: 15.0,
        defaultMarkupPercent: 30.0,
        searchKeywords: ['electronics'],
        manualApprovalListings: true,
      );
      await rulesRepo.save(rules);

      final products = [
        Fixtures.product(
          id: 'prod_log_1',
          sourceId: 'src_log_1',
          sourcePlatformId: 'mock_source',
          basePrice: 40.0,
          shippingCost: 5.0,
        ),
      ];

      final scanner = Scanner(
        productRepository: productRepo,
        listingRepository: listingRepo,
        decisionLogRepository: logRepo,
        rulesRepository: rulesRepo,
        pricingCalculator: pricingCalculator,
        listingDecider: listingDecider,
        supplierSelector: supplierSelector,
        sources: [MockSourcePlatform(mockId: 'mock_source', products: products)],
        featureFlagRepository: FeatureFlagRepository(db),
        productIntelligenceStateRepository: ProductIntelligenceStateRepository(db),
        targetPlatformId: 'allegro',
      );

      await scanner.run();

      final logs = await logRepo.getAll();
      expect(logs, hasLength(1));
      expect(logs.first.reason, contains('>='));
      expect(logs.first.criteriaSnapshot, isNotNull);
    });

    test('Scanner.run() skips products that fail decision rules', () async {
      await rulesRepo.save(Fixtures.conservativeRules);

      final products = [
        Fixtures.product(
          id: 'prod_exp',
          sourceId: 'src_exp',
          sourcePlatformId: 'mock_source',
          basePrice: 200.0,
          shippingCost: 50.0,
        ),
      ];

      final scanner = Scanner(
        productRepository: productRepo,
        listingRepository: listingRepo,
        decisionLogRepository: logRepo,
        rulesRepository: rulesRepo,
        pricingCalculator: pricingCalculator,
        listingDecider: listingDecider,
        supplierSelector: supplierSelector,
        sources: [MockSourcePlatform(mockId: 'mock_source', products: products)],
        featureFlagRepository: FeatureFlagRepository(db),
        productIntelligenceStateRepository: ProductIntelligenceStateRepository(db),
        targetPlatformId: 'allegro',
      );

      final result = await scanner.run();

      expect(result.candidatesFound, 1);
      expect(result.listingsCreated, 0);

      final listings = await listingRepo.getAll();
      expect(listings, isEmpty);
    });

    test('Scanner.run() returns zero when no search keywords', () async {
      const noKeywordsRules = UserRules(
        minProfitPercent: 25.0,
        defaultMarkupPercent: 30.0,
        searchKeywords: [],
      );
      await rulesRepo.save(noKeywordsRules);

      final scanner = Scanner(
        productRepository: productRepo,
        listingRepository: listingRepo,
        decisionLogRepository: logRepo,
        rulesRepository: rulesRepo,
        pricingCalculator: pricingCalculator,
        listingDecider: listingDecider,
        supplierSelector: supplierSelector,
        sources: [MockSourcePlatform(products: [Fixtures.product()])],
        featureFlagRepository: FeatureFlagRepository(db),
        productIntelligenceStateRepository: ProductIntelligenceStateRepository(db),
        targetPlatformId: 'allegro',
      );

      final result = await scanner.run();

      expect(result.candidatesFound, 0);
      expect(result.listingsCreated, 0);
    });

    test('Scanner.run() uses draft status when manual approval is off', () async {
      await rulesRepo.save(Fixtures.aggressiveRules);

      final products = [
        Fixtures.product(
          id: 'prod_auto',
          sourceId: 'src_auto',
          sourcePlatformId: 'mock_source',
          basePrice: 50.0,
          shippingCost: 5.0,
        ),
      ];

      final scanner = Scanner(
        productRepository: productRepo,
        listingRepository: listingRepo,
        decisionLogRepository: logRepo,
        rulesRepository: rulesRepo,
        pricingCalculator: pricingCalculator,
        listingDecider: listingDecider,
        supplierSelector: supplierSelector,
        sources: [MockSourcePlatform(mockId: 'mock_source', products: products)],
        featureFlagRepository: FeatureFlagRepository(db),
        productIntelligenceStateRepository: ProductIntelligenceStateRepository(db),
        targetPlatformId: 'temu',
      );

      final result = await scanner.run();

      expect(result.listingsCreated, 1);

      final listings = await listingRepo.getAll();
      expect(listings.first.status, ListingStatus.draft);
      expect(listings.first.targetPlatformId, 'temu');
    });

    test('Scanner handles multiple source platforms', () async {
      const rules = UserRules(
        minProfitPercent: 15.0,
        defaultMarkupPercent: 30.0,
        searchKeywords: ['electronics'],
        manualApprovalListings: true,
      );
      await rulesRepo.save(rules);

      final source1 = MockSourcePlatform(
        mockId: 'source_a',
        products: [
          Fixtures.product(
            id: 'prod_s1',
            sourceId: 'src_s1',
            sourcePlatformId: 'source_a',
            basePrice: 40.0,
            shippingCost: 5.0,
          ),
        ],
      );
      final source2 = MockSourcePlatform(
        mockId: 'source_b',
        products: [
          Fixtures.product(
            id: 'prod_s2',
            sourceId: 'src_s2',
            sourcePlatformId: 'source_b',
            basePrice: 35.0,
            shippingCost: 4.0,
          ),
        ],
      );

      final scanner = Scanner(
        productRepository: productRepo,
        listingRepository: listingRepo,
        decisionLogRepository: logRepo,
        rulesRepository: rulesRepo,
        pricingCalculator: pricingCalculator,
        listingDecider: listingDecider,
        supplierSelector: supplierSelector,
        sources: [source1, source2],
        featureFlagRepository: FeatureFlagRepository(db),
        productIntelligenceStateRepository: ProductIntelligenceStateRepository(db),
        targetPlatformId: 'allegro',
      );

      final result = await scanner.run();

      expect(result.candidatesFound, 2);
      expect(result.listingsCreated, 2);
    });
  });
}
