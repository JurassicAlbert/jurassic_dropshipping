import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/dynamic_pricing_engine.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/quality_risk_scoring.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

void main() {
  test('risk buffer increases price above base decision', () {
    final calc = PricingCalculator(marketplaceFeePercent: 10);
    final engine = DynamicPricingEngine(pricingCalculator: calc);

    final rules = UserRules(
      minProfitPercent: 10,
      maxSourcePrice: null,
      preferredSupplierCountries: const [],
      manualApprovalListings: false,
      manualApprovalOrders: false,
      scanIntervalMinutes: 60,
      blacklistedProductIds: const [],
      blacklistedSupplierIds: const [],
      defaultMarkupPercent: 20,
      searchKeywords: const ['x'],
      marketplaceFees: const {'allegro': 10.0},
      paymentFees: const {'allegro': 0.0},
      sellerReturnAddress: null,
      marketplaceReturnPolicy: const {},
      targetsReadOnly: false,
      pricingStrategy: PricingStrategyId.matchLowest,
      categoryMinProfitPercent: const {},
      premiumWhenBetterReviewsPercent: 2,
      minSalesCountForPremium: 10,
      kpiDrivenStrategyEnabled: false,
      rateLimitMaxRequestsPerSecond: const {},
      incidentRulesJson: null,
      riskScoreThreshold: null,
      defaultReturnRatePercent: null,
      defaultReturnCostPerUnit: null,
      blockFulfillWhenInsufficientStock: false,
      autoPauseListingWhenMarginBelowThreshold: false,
      defaultSupplierProcessingDays: 2,
      defaultSupplierShippingDays: 7,
      marketplaceMaxDeliveryDays: null,
      listingHealthMaxReturnRatePercent: null,
      listingHealthMaxLateRatePercent: null,
      autoPauseListingWhenHealthPoor: false,
      safetyStockBuffer: 0,
      customerAbuseMaxReturnRatePercent: null,
      customerAbuseMaxComplaintRatePercent: null,
      priceRefreshIntervalMinutesBySource: const {},
    );

    final base = calc.decideCompetitivePrice(
      sourceCost: 100,
      rules: rules,
      platformId: 'allegro',
      competitorInput: const CompetitivePricingInput(lowestCompetitorPrice: 150),
    );
    final risk = ProductQualityRiskResult(
      qualityScore: 50,
      returnRiskScore: 100,
      qualityFactors: const [],
      riskFactors: const [],
    );
    final adjusted = engine.decide(
      sourceCost: 100,
      rules: rules,
      platformId: 'allegro',
      competitorInput: const CompetitivePricingInput(lowestCompetitorPrice: 150),
      qualityRisk: risk,
      competitionLevel: 'medium',
    );

    expect(base.shouldCreate, true);
    expect(adjusted.shouldCreate, true);
    expect(adjusted.createAtPrice!, greaterThan(base.createAtPrice!));
  });
}

