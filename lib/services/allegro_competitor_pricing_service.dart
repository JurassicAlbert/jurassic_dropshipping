import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/repositories/feature_flag_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/services/competitor_pricing_service.dart';
import 'package:jurassic_dropshipping/services/targets/allegro_client.dart';

/// Feature flag key for live competitor pricing (Allegro listing search).
const String kFeatureFlagCompetitorPricingLive = 'competitor_pricing_live';

/// Live implementation: fetches lowest competitor price from Allegro listing API when enabled.
class AllegroCompetitorPricingService implements CompetitorPricingService {
  AllegroCompetitorPricingService({
    required this.allegroClient,
    required this.featureFlagRepository,
  });

  final AllegroClient allegroClient;
  final FeatureFlagRepository featureFlagRepository;

  @override
  Future<CompetitivePricingInput?> getSnapshot(
    Product product,
    String targetPlatformId, {
    String? categoryId,
  }) async {
    if (targetPlatformId != 'allegro') return null;
    final enabled = await featureFlagRepository.get(kFeatureFlagCompetitorPricingLive);
    if (!enabled) return null;
    final configured = await allegroClient.isConfigured();
    if (!configured) return null;

    final phrase = product.title.length > 100 ? product.title.substring(0, 100) : product.title;
    final lowest = await allegroClient.getListingOffersLowestPrice(phrase, categoryId: categoryId);
    if (lowest == null) return null;
    return CompetitivePricingInput(lowestCompetitorPrice: lowest);
  }
}
