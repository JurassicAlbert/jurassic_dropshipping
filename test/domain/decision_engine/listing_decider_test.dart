import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/listing_decider.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/dynamic_pricing_engine.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/quality_risk_scoring.dart';

void main() {
  late ListingDecider decider;
  late PricingCalculator calc;

  setUp(() {
    calc = PricingCalculator(marketplaceFeePercent: 10.0);
    decider = ListingDecider(
      pricingCalculator: calc,
      dynamicPricingEngine: DynamicPricingEngine(pricingCalculator: calc),
    );
  });

  Product product0({
    double basePrice = 50.0,
    double? shippingCost = 5.0,
    String? supplierId,
    String id = 'prod_1',
  }) {
    return Product(
      id: id,
      sourceId: 'src_1',
      sourcePlatformId: 'cj',
      title: 'Test Product',
      basePrice: basePrice,
      shippingCost: shippingCost,
      supplierId: supplierId,
      variants: const [
        ProductVariant(id: 'v1', productId: 'prod_1', attributes: {}, price: 50.0, stock: 10),
      ],
    );
  }

  group('decide', () {
    test('accepts product with sufficient profit margin', () {
      const rules = UserRules(
        minProfitPercent: 15.0,
        defaultMarkupPercent: 30.0,
      );
      final product = product0(basePrice: 50.0, shippingCost: 5.0);
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isTrue);
      final accepted = decision as ListingDecisionAccept;
      expect(accepted.listing.sellingPrice, greaterThan(55.0));
      expect(accepted.reason, contains('>='));
    });

    test('rejects product that exceeds max source price', () {
      const rules = UserRules(
        minProfitPercent: 15.0,
        defaultMarkupPercent: 30.0,
        maxSourcePrice: 40.0,
      );
      final product = product0(basePrice: 50.0, shippingCost: 5.0);
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isFalse);
      expect(decision.reason, contains('exceeds'));
    });

    test('rejects blacklisted supplier', () {
      const rules = UserRules(
        minProfitPercent: 15.0,
        defaultMarkupPercent: 30.0,
        blacklistedSupplierIds: ['bad_supplier'],
      );
      final product = product0(supplierId: 'bad_supplier');
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isFalse);
      expect(decision.reason, contains('blacklisted'));
    });

    test('rejects blacklisted product', () {
      const rules = UserRules(
        minProfitPercent: 15.0,
        defaultMarkupPercent: 30.0,
        blacklistedProductIds: ['prod_1'],
      );
      final product = product0();
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isFalse);
      expect(decision.reason, contains('blacklisted'));
    });

    test('sets listing to pendingApproval when manual approval is on', () {
      const rules = UserRules(
        minProfitPercent: 5.0,
        defaultMarkupPercent: 30.0,
        manualApprovalListings: true,
      );
      final product = product0();
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isTrue);
      final accepted = decision as ListingDecisionAccept;
      expect(accepted.listing.status, ListingStatus.pendingApproval);
    });

    test('sets listing to draft when manual approval is off', () {
      const rules = UserRules(
        minProfitPercent: 5.0,
        defaultMarkupPercent: 30.0,
        manualApprovalListings: false,
      );
      final product = product0();
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isTrue);
      final accepted = decision as ListingDecisionAccept;
      expect(accepted.listing.status, ListingStatus.draft);
    });

    test('includes criteria snapshot on accept', () {
      const rules = UserRules(
        minProfitPercent: 5.0,
        defaultMarkupPercent: 30.0,
      );
      final product = product0();
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isTrue);
      final accepted = decision as ListingDecisionAccept;
      expect(accepted.criteriaSnapshot, isNotNull);
      expect(accepted.criteriaSnapshot!.containsKey('sourceCost'), isTrue);
      expect(accepted.criteriaSnapshot!.containsKey('sellingPrice'), isTrue);
      expect(accepted.criteriaSnapshot!.containsKey('marginPercent'), isTrue);
    });

    test('rejects when profit margin too low', () {
      const rules = UserRules(
        minProfitPercent: 99.0,
        defaultMarkupPercent: 1.0,
      );
      final product = product0();
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isFalse);
      expect(decision.reason, contains('<'));
    });

    test('applies dynamic pricing when competitor input + intel signals provided', () {
      const rules = UserRules(
        minProfitPercent: 10.0,
        defaultMarkupPercent: 20.0,
        pricingStrategy: PricingStrategyId.matchLowest,
      );
      final product = product0(basePrice: 100, shippingCost: 0);

      final base = calc.decideCompetitivePrice(
        sourceCost: 100,
        rules: rules,
        platformId: 'allegro',
        competitorInput: const CompetitivePricingInput(lowestCompetitorPrice: 150),
      );
      expect(base.shouldCreate, isTrue);

      final decision = decider.decide(
        product,
        rules,
        targetPlatformId: 'allegro',
        competitorInput: const CompetitivePricingInput(lowestCompetitorPrice: 150),
        qualityRisk: const ProductQualityRiskResult(
          qualityScore: 50,
          returnRiskScore: 100,
          qualityFactors: [],
          riskFactors: [],
        ),
        competitionLevel: 'medium',
      );

      expect(decision.isAccept, isTrue);
      final accepted = decision as ListingDecisionAccept;
      expect(accepted.listing.sellingPrice, greaterThan(base.createAtPrice!));
      expect(accepted.criteriaSnapshot, isNotNull);
      expect(accepted.criteriaSnapshot!['returnRiskScore'], 100.0);
      expect(accepted.criteriaSnapshot!['competitionLevel'], 'medium');
      expect(accepted.criteriaSnapshot!['dynamicPricingAdjusted'], isTrue);
    });
  });
}
