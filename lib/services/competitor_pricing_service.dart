import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';

/// Provides competitor price and optional "our" listing stats for competitive pricing strategies.
/// When live API is not available or disabled, use [StubCompetitorPricingService] (returns null).
abstract class CompetitorPricingService {
  /// Returns competitive snapshot for the product on the given target platform, or null if unavailable.
  Future<CompetitivePricingInput?> getSnapshot(
    Product product,
    String targetPlatformId, {
    String? categoryId,
  });
}

/// Stub implementation that always returns null (no competitor data).
/// Use when live competitor API is not yet integrated or is behind a feature flag.
class StubCompetitorPricingService implements CompetitorPricingService {
  @override
  Future<CompetitivePricingInput?> getSnapshot(
    Product product,
    String targetPlatformId, {
    String? categoryId,
  }) async =>
      null;
}
