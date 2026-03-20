import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/feature_flag_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_intelligence_state_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/listing_decider.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/supplier_selector.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/billing_service.dart';
import 'package:jurassic_dropshipping/services/competitor_pricing_service.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/quality_risk_scoring.dart';
import 'package:jurassic_dropshipping/app_providers.dart' show kFeatureFlagProductIntelligence;

/// Scans source platforms for products, applies rules, and creates draft/pending listings.
class Scanner {
  Scanner({
    required this.productRepository,
    required this.listingRepository,
    required this.decisionLogRepository,
    required this.rulesRepository,
    required this.pricingCalculator,
    required this.listingDecider,
    required this.supplierSelector,
    required this.sources,
    required this.featureFlagRepository,
    required this.productIntelligenceStateRepository,
    List<String> targetPlatformIds = const [],
    @Deprecated('Use targetPlatformIds instead') String targetPlatformId = '',
    this.competitorPricingService,
    this.billingService,
  }) : targetPlatformIds = targetPlatformIds.isNotEmpty
           ? targetPlatformIds
           : (targetPlatformId.isNotEmpty ? [targetPlatformId] : ['allegro']);

  final ProductRepository productRepository;
  final ListingRepository listingRepository;
  final DecisionLogRepository decisionLogRepository;
  final RulesRepository rulesRepository;
  final PricingCalculator pricingCalculator;
  final ListingDecider listingDecider;
  final SupplierSelector supplierSelector;
  final List<SourcePlatform> sources;
  final FeatureFlagRepository featureFlagRepository;
  final ProductIntelligenceStateRepository productIntelligenceStateRepository;
  final List<String> targetPlatformIds;
  final CompetitorPricingService? competitorPricingService;
  final BillingService? billingService;

  /// Run a scan: load rules, search each source, decide and persist listings.
  Future<ScanResult> run() async {
    final rules = await rulesRepository.get();
    final intelEnabled = await featureFlagRepository.get(kFeatureFlagProductIntelligence);
    final keywords = rules.searchKeywords;
    if (keywords.isEmpty) {
      appLogger.w('Scanner: no search keywords in rules');
      return ScanResult(candidatesFound: 0, listingsCreated: 0);
    }

    final filters = SourceSearchFilters(
      maxPrice: rules.maxSourcePrice,
      countryCodes: rules.preferredSupplierCountries.isNotEmpty
          ? rules.preferredSupplierCountries
          : null,
    );

    var candidatesFound = 0;
    var listingsCreated = 0;

    for (final source in sources) {
      try {
        final products = await source.searchProducts(keywords, filters: filters);
        candidatesFound += products.length;
        for (final product in products) {
          await productRepository.upsert(product);
          final selection = supplierSelector.select([product], rules);
          final chosen = selection.product;
          if (chosen == null) continue;

          ProductQualityRiskResult? qualityRisk;
          String? competitionLevel;
          if (intelEnabled) {
            final intel = await productIntelligenceStateRepository.getByProductId(chosen.id);
            if (intel != null) {
              qualityRisk = ProductQualityRiskResult(
                qualityScore: intel.qualityScore ?? 0.0,
                returnRiskScore: intel.returnRiskScore ?? 0.0,
                qualityFactors: const [],
                riskFactors: const [],
              );
              competitionLevel = intel.competitionLevel;
            }
          }

          // Evaluate listing decision per target platform so that:
          // - platform-specific fees (including payment fees) are applied, and
          // - pricing strategies (always_below_lowest, list_at_min_even_if_above_lowest, etc.)
          //   can reason about platform/category data.
          for (final targetId in targetPlatformIds) {
            CompetitivePricingInput? competitorInput;
            if (competitorPricingService != null) {
              competitorInput = await competitorPricingService!.getSnapshot(
                chosen,
                targetId,
              );
            }
            final decision = listingDecider.decide(
              chosen,
              rules,
              targetPlatformId: targetId,
              competitorInput: competitorInput,
              qualityRisk: qualityRisk,
              competitionLevel: competitionLevel,
            );
            if (decision is ListingDecisionReject) continue;
            final accept = decision as ListingDecisionAccept;
            final logId = 'log_${DateTime.now().millisecondsSinceEpoch}_$targetId';
            await decisionLogRepository.insert(DecisionLog(
              id: logId,
              type: DecisionLogType.listing,
              entityId: accept.listing.id,
              reason: accept.reason,
              criteriaSnapshot: accept.criteriaSnapshot,
              createdAt: DateTime.now(),
            ));
            if (billingService != null) {
              final canCreate = await billingService!.canCreateListing();
              if (!canCreate) {
                appLogger.w('Scanner: billing limit reached (listings), skipping new listing');
                continue;
              }
            }
            final listing = accept.listing.copyWith(
              targetPlatformId: targetId,
              decisionLogId: logId,
              id: '${accept.listing.id}_$targetId',
            );
            await listingRepository.insert(listing);
            listingsCreated++;
          }
        }
      } catch (e, st) {
        appLogger.e('Scanner: source ${source.id} failed', error: e, stackTrace: st);
      }
    }

    return ScanResult(
      candidatesFound: candidatesFound,
      listingsCreated: listingsCreated,
    );
  }
}

class ScanResult {
  const ScanResult({
    required this.candidatesFound,
    required this.listingsCreated,
  });
  final int candidatesFound;
  final int listingsCreated;
}
