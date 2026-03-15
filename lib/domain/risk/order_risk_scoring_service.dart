import 'dart:convert';

import 'package:jurassic_dropshipping/data/models/order.dart';

/// Result of evaluating order risk (Phase 16).
class OrderRiskResult {
  const OrderRiskResult({
    required this.score,
    required this.factors,
  });

  final double score;
  final List<String> factors;

  String get factorsJson => jsonEncode(factors);
}

/// Evaluates order risk and can apply threshold rule (set pendingApproval). Phase 16.
class OrderRiskScoringService {
  OrderRiskScoringService({
    this.highValueThreshold = 400,
    this.mediumValueThreshold = 200,
    this.highValuePoints = 40,
    this.mediumValuePoints = 20,
  });

  /// Selling price (total) above this adds [highValuePoints] to score.
  final double highValueThreshold;
  /// Selling price above this adds [mediumValuePoints] to score.
  final double mediumValueThreshold;
  final double highValuePoints;
  final double mediumValuePoints;

  /// Evaluates [order] and returns score 0–100 and factor names.
  OrderRiskResult evaluate(Order order) {
    final factors = <String>[];
    var score = 0.0;

    final total = order.sellingPrice * order.quantity;
    if (total >= highValueThreshold) {
      factors.add('highValue');
      score += highValuePoints;
    } else if (total >= mediumValueThreshold) {
      factors.add('mediumValue');
      score += mediumValuePoints;
    }

    // Clamp to 0–100
    score = score.clamp(0.0, 100.0);
    return OrderRiskResult(score: score, factors: factors);
  }
}
