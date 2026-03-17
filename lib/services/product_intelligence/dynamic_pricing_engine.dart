import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/quality_risk_scoring.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Phase 37: Risk-adjusted dynamic pricing wrapper around existing PricingCalculator.
///
/// Deterministic-first: this does not replace existing pricing logic; it adjusts inputs
/// (effective cost buffer / min price) based on risk and competition signals.
class DynamicPricingEngine {
  const DynamicPricingEngine({required this.pricingCalculator});

  final PricingCalculator pricingCalculator;

  PricingDecision decide({
    required double sourceCost,
    required UserRules rules,
    required String platformId,
    String? categoryId,
    CompetitivePricingInput? competitorInput,
    KpiStrategySnapshot? kpiSnapshot,
    ProductQualityRiskResult? qualityRisk,
    String? competitionLevel, // low|medium|high|null
  }) {
    // Base decision from existing calculator (backward compatible).
    final base = pricingCalculator.decideCompetitivePrice(
      sourceCost: sourceCost,
      rules: rules,
      platformId: platformId,
      categoryId: categoryId,
      competitorInput: competitorInput,
      kpiSnapshot: kpiSnapshot,
    );
    if (!base.shouldCreate) return base;

    var price = base.createAtPrice!;

    // Risk buffer: increase effective min price when return risk is high.
    final risk = qualityRisk?.returnRiskScore ?? 0.0;
    // 0..100 -> 0..6% buffer
    final riskBufferPct = (risk / 100.0) * 0.06;

    // Competition: low competition can tolerate small premium; high competition discourages.
    final competition = (competitionLevel ?? '').toLowerCase();
    final compAdjPct = switch (competition) {
      'low' => 0.01,
      'high' => -0.005,
      _ => 0.0,
    };

    // Apply multiplicative adjustments deterministically.
    price = price * (1 + riskBufferPct + compAdjPct);

    // Enforce P_min again (risk-adjusted).
    final pMin = pricingCalculator.calculateMinimumSellingPrice(sourceCost, rules, platformId, categoryId: categoryId);
    final adjustedMin = pMin * (1 + riskBufferPct);
    if (price < adjustedMin) {
      // If base pricing was safe, keep it, but never below adjustedMin when we do apply buffer.
      price = adjustedMin;
    }

    return PricingDecision(createAtPrice: price);
  }
}

