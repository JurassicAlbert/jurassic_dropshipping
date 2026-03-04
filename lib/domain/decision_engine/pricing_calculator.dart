import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Calculates selling price from source cost + markup + marketplace fee estimate.
class PricingCalculator {
  PricingCalculator({this.marketplaceFeePercent = 10.0});

  /// Estimated marketplace fee as percentage of selling price (e.g. Allegro ~10%).
  final double marketplaceFeePercent;

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

  /// Profit (after fee) in absolute terms.
  double profitAfterFee(double sellingPrice, double sourceCost) {
    final fee = sellingPrice * (marketplaceFeePercent / 100);
    return sellingPrice - sourceCost - fee;
  }

  /// Profit margin (after fee) as percentage of selling price.
  double profitMarginPercent(double sellingPrice, double sourceCost) {
    final profit = profitAfterFee(sellingPrice, sourceCost);
    if (sellingPrice <= 0) return 0;
    return (profit / sellingPrice) * 100;
  }

  /// Whether the given selling price meets the minimum profit margin from rules.
  bool meetsMinProfit(double sellingPrice, double sourceCost, UserRules rules) {
    return profitMarginPercent(sellingPrice, sourceCost) >= rules.minProfitPercent;
  }
}
