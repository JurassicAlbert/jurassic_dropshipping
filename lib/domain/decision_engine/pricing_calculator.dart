import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Strategy identifiers for pricing (must match UserRules.praging_calculator.dart
/// (must match UserRules.pricingStrategy values).
abstract final class PricingStrategyId {
  /// Try to be cheapest in the listing (0.01 below lowest), but never below P_min.
  static const String alwaysBelowLowest = 'always_below_lowest';

  /// If we have better reviews + enough sales, allow a small premium above lowest.
  static const String premiumWhenBetterReviews = 'premium_when_better_reviews';

  /// Match the current lowest competitor price (if >= P_min).
  static const String matchLowest = 'match_lowest';

  /// Ignore competitors; use fixed markup and fee only.
  static const String fixedMarkup = 'fixed_markup';

  /// Even if P_min is above the current lowest, still list at P_min
  /// (or slightly undercut when P_min <= lowest). This is useful when
  /// you want the product listed anyway so KPI can later tell you if
  /// this category/segment works with higher-priced offers.
  static const String listAtMinEvenIfAboveLowest = 'list_at_min_even_if_above_lowest';

  /// Phase 17: P_min accounts for expected return cost (returnRate × returnCost).
  static const String returnRateAware = 'return_rate_aware';
}

/// KPI snapshot for strategy selection (e.g. conversion by strategy, margin by segment).
/// When [UserRules.kpiDrivenStrategyEnabled] is true, use this to suggest or switch strategy.
class KpiStrategySnapshot {
  const KpiStrategySnapshot({
    this.conversionByStrategy,
    this.avgMarginByStrategy,
    this.recommendedStrategy,
  });
  final Map<String, double>? conversionByStrategy;
  final Map<String, double>? avgMarginByStrategy;
  final String? recommendedStrategy;
}

/// Returns the effective pricing strategy. When [rules.kpiDrivenStrategyEnabled] is true,
/// uses [snapshot.recommendedStrategy] if present; otherwise keeps [rules.pricingStrategy].
/// Future: derive recommendedStrategy from conversionByStrategy / avgMarginByStrategy.
String effectivePricingStrategy(UserRules rules, [KpiStrategySnapshot? snapshot]) {
  if (!rules.kpiDrivenStrategyEnabled) return rules.pricingStrategy;
  final recommended = snapshot?.recommendedStrategy;
  if (recommended != null &&
      (recommended == PricingStrategyId.alwaysBelowLowest ||
          recommended == PricingStrategyId.premiumWhenBetterReviews ||
          recommended == PricingStrategyId.matchLowest ||
          recommended == PricingStrategyId.fixedMarkup ||
          recommended == PricingStrategyId.listAtMinEvenIfAboveLowest ||
          recommended == PricingStrategyId.returnRateAware)) {
    return recommended;
  }
  return rules.pricingStrategy;
}

/// Input for competitive pricing: competitor price and optional "our" listing stats.
class CompetitivePricingInput {
  const CompetitivePricingInput({
    required this.lowestCompetitorPrice,
    this.ourSalesCount,
    this.ourRating,
    this.categoryOrSimilarAvgRating,
  });
  final double lowestCompetitorPrice;
  final int? ourSalesCount;
  final double? ourRating;
  final double? categoryOrSimilarAvgRating;
}

/// Result of pricing decision: either create at a price or do not create with reason.
class PricingDecision {
  const PricingDecision({this.createAtPrice, this.rejectReason});
  final double? createAtPrice;
  final String? rejectReason;
  bool get shouldCreate => createAtPrice != null && rejectReason == null;
}

/// Calculates selling price from source cost + markup + marketplace fee estimate.
class PricingCalculator {
  PricingCalculator({this.marketplaceFeePercent = 10.0});

  /// Estimated marketplace fee as percentage of selling price (e.g. Allegro ~10%).
  final double marketplaceFeePercent;

  /// Total fee % (marketplace + payment) for [platformId]. Used for P_min and margin checks.
  double getTotalFeePercent(String platformId, UserRules rules) {
    final marketplace = rules.marketplaceFees[platformId] ?? marketplaceFeePercent;
    final payment = rules.paymentFees[platformId] ?? 0.0;
    return marketplace + payment;
  }

  /// Minimum selling price P_min so that profit (after total fee) meets category min margin.
  /// Uses [rules.categoryMinProfitPercent][categoryId] or [rules.minProfitPercent].
  /// Formula: sourceCost * (1 + minMargin/100) / (1 - totalFee/100).
  double calculateMinimumSellingPrice(
    double sourceCost,
    UserRules rules,
    String platformId, {
    String? categoryId,
  }) {
    final minMarginPercent = categoryId != null
        ? (rules.categoryMinProfitPercent[categoryId] ?? rules.minProfitPercent)
        : rules.minProfitPercent;
    final totalFeePercent = getTotalFeePercent(platformId, rules);
    final margin = minMarginPercent / 100;
    final fee = totalFeePercent / 100;
    if (fee >= 1) return sourceCost * (1 + margin);
    return sourceCost * (1 + margin) / (1 - fee);
  }

  /// Phase 17: P_min with expected return cost. Use when strategy is [PricingStrategyId.returnRateAware]
  /// or when you want to ensure target margin on average with a given return rate.
  /// [returnRatePercent] e.g. 20 for 20% expected return rate.
  /// [returnCostPerUnit] = returnShippingCost + restockingFee (+ optional marketplace fee loss) per unit.
  /// Formula: expectedCost = sourceCost + (returnRatePercent/100) * returnCostPerUnit; then P_min from expectedCost.
  double calculateMinimumSellingPriceWithReturnRate(
    double sourceCost,
    double returnRatePercent,
    double returnCostPerUnit,
    UserRules rules,
    String platformId, {
    String? categoryId,
  }) {
    final expectedCost = sourceCost + (returnRatePercent / 100) * returnCostPerUnit;
    return calculateMinimumSellingPrice(expectedCost, rules, platformId, categoryId: categoryId);
  }

  /// Selling price so that after fee we keep [rules.defaultMarkupPercent] on top of source cost.
  /// Formula: we want profit = sourceCost * (markupPercent/100).
  /// sellingPrice = sourceCost + profit + fee, and fee = sellingPrice * (feePercent/100).
  /// So sellingPrice * (1 - feePercent/100) = sourceCost + profit = sourceCost * (1 + markupPercent/100).
  /// sellingPrice = sourceCost * (1 + markupPercent/100) / (1 - feePercent/100).
  double calculateSellingPrice(double sourceCost, UserRules rules) {
    final markup = rules.defaultMarkupPercent / 100;
    final fee = marketplaceFeePercent / 100;
    if (fee >= 1) return sourceCost * (1 + markup);
    return sourceCost * (1 + markup) / (1 - fee);
  }

  /// Profit (after fee) in absolute terms. Pass [platformId] and [rules] to use total fee (marketplace + payment).
  double profitAfterFee(double sellingPrice, double sourceCost, [String? platformId, UserRules? rules]) {
    final feePercent = (platformId != null && rules != null)
        ? getTotalFeePercent(platformId, rules)
        : marketplaceFeePercent;
    final fee = sellingPrice * (feePercent / 100);
    return sellingPrice - sourceCost - fee;
  }

  /// Profit margin (after fee) as percentage of selling price.
  double profitMarginPercent(double sellingPrice, double sourceCost, [String? platformId, UserRules? rules]) {
    final feePercent = (platformId != null && rules != null)
        ? getTotalFeePercent(platformId, rules)
        : marketplaceFeePercent;
    final fee = sellingPrice * (feePercent / 100);
    final profit = sellingPrice - sourceCost - fee;
    if (sellingPrice <= 0) return 0;
    return (profit / sellingPrice) * 100;
  }

  /// Whether the given selling price meets the minimum profit margin from rules.
  /// [categoryId] optional for per-category min margin.
  bool meetsMinProfit(double sellingPrice, double sourceCost, UserRules rules, [String? platformId, String? categoryId]) {
    final margin = platformId != null
        ? profitMarginPercent(sellingPrice, sourceCost, platformId, rules)
        : profitMarginPercent(sellingPrice, sourceCost);
    final minMargin = categoryId != null
        ? (rules.categoryMinProfitPercent[categoryId] ?? rules.minProfitPercent)
        : rules.minProfitPercent;
    return margin >= minMargin;
  }

  double getFeeForPlatform(String platformId, UserRules rules) {
    return rules.marketplaceFees[platformId] ?? marketplaceFeePercent;
  }

  double calculateSellingPriceForPlatform(double sourceCost, UserRules rules, String platformId) {
    final markup = rules.defaultMarkupPercent / 100;
    final fee = getFeeForPlatform(platformId, rules) / 100;
    if (fee >= 1) return sourceCost * (1 + markup);
    return sourceCost * (1 + markup) / (1 - fee);
  }

  /// Competitive target price from strategy. Returns null if no competitor price (use fixed_markup path).
  /// Caller must enforce target >= P_min via [decideCompetitivePrice].
  double? competitiveTargetPrice(
    CompetitivePricingInput input,
    UserRules rules,
    String platformId, {
    String? categoryId,
  }) =>
      _competitiveTargetPriceWithStrategy(input, rules, rules.pricingStrategy, platformId, categoryId: categoryId);

  double? _competitiveTargetPriceWithStrategy(
    CompetitivePricingInput input,
    UserRules rules,
    String strategy,
    String platformId, {
    String? categoryId,
  }) {
    final lowest = input.lowestCompetitorPrice;
    if (strategy == PricingStrategyId.matchLowest) {
      return lowest;
    }
    if (strategy == PricingStrategyId.alwaysBelowLowest ||
        strategy == PricingStrategyId.listAtMinEvenIfAboveLowest ||
        strategy == PricingStrategyId.returnRateAware) {
      final target = lowest - 0.01;
      return target < 0 ? 0.01 : target;
    }
    if (strategy == PricingStrategyId.premiumWhenBetterReviews) {
      final minSales = rules.minSalesCountForPremium;
      final ourSales = input.ourSalesCount ?? 0;
      final ourRating = input.ourRating;
      final avgRating = input.categoryOrSimilarAvgRating;
      final canPremium = ourSales >= minSales &&
          ourRating != null &&
          avgRating != null &&
          ourRating > avgRating;
      if (canPremium) {
        final premiumPercent = rules.premiumWhenBetterReviewsPercent / 100;
        return lowest * (1 + premiumPercent);
      }
      final target = lowest - 0.01;
      return target < 0 ? 0.01 : target;
    }
    return null;
  }

  /// Full decision: given source cost, platform, category, and optional competitor input,
  /// returns whether to create and at what price (or reject reason).
  /// When [rules.kpiDrivenStrategyEnabled] is true, pass [kpiSnapshot] to use KPI-derived strategy.
  PricingDecision decideCompetitivePrice({
    required double sourceCost,
    required UserRules rules,
    required String platformId,
    String? categoryId,
    CompetitivePricingInput? competitorInput,
    KpiStrategySnapshot? kpiSnapshot,
  }) {
    final strategy = effectivePricingStrategy(rules, kpiSnapshot);
    final pMin = strategy == PricingStrategyId.returnRateAware
        ? calculateMinimumSellingPriceWithReturnRate(
            sourceCost,
            rules.defaultReturnRatePercent ?? 0,
            rules.defaultReturnCostPerUnit ?? 0,
            rules,
            platformId,
            categoryId: categoryId,
          )
        : calculateMinimumSellingPrice(sourceCost, rules, platformId, categoryId: categoryId);
    if (sourceCost <= 0) {
      return const PricingDecision(rejectReason: 'Source cost must be positive');
    }
    if (competitorInput == null || strategy == PricingStrategyId.fixedMarkup) {
      final price = calculateSellingPriceForPlatform(sourceCost, rules, platformId);
      if (price < pMin) return PricingDecision(rejectReason: 'Fixed markup price below minimum margin', createAtPrice: null);
      return PricingDecision(createAtPrice: price);
    }
    final target = _competitiveTargetPriceWithStrategy(
      competitorInput,
      rules,
      strategy,
      platformId,
      categoryId: categoryId,
    );
    if (target == null) {
      final price = calculateSellingPriceForPlatform(sourceCost, rules, platformId);
      if (price < pMin) return PricingDecision(rejectReason: 'Price below minimum margin', createAtPrice: null);
      return PricingDecision(createAtPrice: price);
    }
    // For most strategies, if the target is below P_min we reject; we never want
    // to list at a price that violates the configured minimum margin.
    // For [listAtMinEvenIfAboveLowest], we instead clamp up to P_min and still list.
    double finalPrice = target;
    if (target < pMin) {
      if (strategy == PricingStrategyId.listAtMinEvenIfAboveLowest) {
        finalPrice = pMin;
      } else {
        return PricingDecision(
          rejectReason:
              'Market price too low for safe margin (target ${target.toStringAsFixed(2)} < P_min ${pMin.toStringAsFixed(2)})',
          createAtPrice: null,
        );
      }
    }
    return PricingDecision(createAtPrice: finalPrice);
  }

  /// Calculate minimum selling price that remains profitable even after a potential return.
  /// Accounts for: source cost + desired profit + marketplace fee + return risk buffer.
  /// returnRatePercent: expected return rate (e.g. 5.0 = 5%)
  double calculateSafeSellingPrice(
    double sourceCost,
    UserRules rules, {
    double returnRatePercent = 5.0,
    double avgReturnShippingCost = 20.0,
  }) {
    final basePrice = calculateSellingPrice(sourceCost, rules);
    final returnBuffer = (returnRatePercent / 100) * (basePrice + avgReturnShippingCost);
    return basePrice + returnBuffer;
  }

  /// Calculate the financial impact of a no-reason return.
  /// Returns the net loss: refund given minus what seller keeps.
  ReturnCostEstimate estimateReturnCost({
    required double sellingPrice,
    required double sourceCost,
    double returnShippingCost = 0,
    double restockingFeePercent = 0,
  }) {
    final restockingFee = sellingPrice * (restockingFeePercent / 100);
    final refundAmount = sellingPrice - restockingFee;
    final netLoss = refundAmount + returnShippingCost - restockingFee;
    return ReturnCostEstimate(
      refundAmount: refundAmount,
      restockingFee: restockingFee,
      returnShippingCost: returnShippingCost,
      netLoss: netLoss,
    );
  }
}

class ReturnCostEstimate {
  const ReturnCostEstimate({
    required this.refundAmount,
    required this.restockingFee,
    required this.returnShippingCost,
    required this.netLoss,
  });
  final double refundAmount;
  final double restockingFee;
  final double returnShippingCost;
  final double netLoss;
}
