import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/dynamic_pricing_engine.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/quality_risk_scoring.dart';

/// Decides whether to list a product and creates draft/pending_approval listing + decision log.
class ListingDecider {
  ListingDecider({
    required this.pricingCalculator,
    this.dynamicPricingEngine,
  });

  final PricingCalculator pricingCalculator;
  final DynamicPricingEngine? dynamicPricingEngine;

  /// Returns a listing decision: if profitable and within rules, returns [ListingDecision.accept] with
  /// draft listing and reason; otherwise [ListingDecision.reject] with reason.
  /// When [targetPlatformId] and [competitorInput] are provided, uses competitive pricing strategy
  /// (e.g. 0.01 below lowest or premium when better reviews) and P_min including payment fees.
  ListingDecision decide(
    Product product,
    UserRules rules, {
    String? targetPlatformId,
    String? categoryId,
    CompetitivePricingInput? competitorInput,
    ProductQualityRiskResult? qualityRisk,
    String? competitionLevel,
  }) {
    final sourceCost = product.basePrice + (product.shippingCost ?? 0);

    if (rules.maxSourcePrice != null && sourceCost > rules.maxSourcePrice!) {
      return ListingDecisionReject(
        reason: 'Source cost $sourceCost exceeds max ${rules.maxSourcePrice}',
      );
    }
    if (product.supplierId != null && rules.blacklistedSupplierIds.contains(product.supplierId!)) {
      return ListingDecisionReject(reason: 'Supplier blacklisted');
    }
    if (rules.blacklistedProductIds.contains(product.id)) {
      return ListingDecisionReject(reason: 'Product blacklisted');
    }

    // Phase 21: shipping validation — reject if expected delivery exceeds marketplace max.
    if (rules.marketplaceMaxDeliveryDays != null) {
      final processingDays = rules.defaultSupplierProcessingDays;
      final shippingDays = product.estimatedDays ?? rules.defaultSupplierShippingDays;
      final expectedMaxDays = processingDays + shippingDays;
      if (expectedMaxDays > rules.marketplaceMaxDeliveryDays!) {
        return ListingDecisionReject(
          reason: 'Expected delivery $expectedMaxDays days (processing $processingDays + shipping $shippingDays) '
              'exceeds marketplace max ${rules.marketplaceMaxDeliveryDays} days',
        );
      }
    }

    double sellingPrice;
    String reason;
    double margin;
    var dynamicPricingAdjusted = false;

    if (targetPlatformId != null &&
        (competitorInput != null || rules.pricingStrategy == PricingStrategyId.fixedMarkup)) {
      final decision = pricingCalculator.decideCompetitivePrice(
        sourceCost: sourceCost,
        rules: rules,
        platformId: targetPlatformId,
        categoryId: categoryId,
        competitorInput: competitorInput,
      );
      if (!decision.shouldCreate || decision.createAtPrice == null) {
        return ListingDecisionReject(
          reason: decision.rejectReason ?? 'Pricing decision: do not create',
        );
      }

      sellingPrice = decision.createAtPrice!;

      final dyn = dynamicPricingEngine;
      if (dyn != null && (qualityRisk != null || competitionLevel != null)) {
        final adjusted = dyn.decide(
          sourceCost: sourceCost,
          rules: rules,
          platformId: targetPlatformId,
          categoryId: categoryId,
          competitorInput: competitorInput,
          qualityRisk: qualityRisk,
          competitionLevel: competitionLevel,
        );
        if (adjusted.shouldCreate && adjusted.createAtPrice != null) {
          final next = adjusted.createAtPrice!;
          dynamicPricingAdjusted = (next - sellingPrice).abs() >= 0.005;
          sellingPrice = next;
        }
      }

      reason = 'Competitive price ${sellingPrice.toStringAsFixed(2)} (strategy: ${rules.pricingStrategy})';
      margin = pricingCalculator.profitMarginPercent(sellingPrice, sourceCost, targetPlatformId, rules);
    } else {
      sellingPrice = targetPlatformId != null
          ? pricingCalculator.calculateSellingPriceForPlatform(sourceCost, rules, targetPlatformId)
          : pricingCalculator.calculateSellingPrice(sourceCost, rules);
      margin = targetPlatformId != null
          ? pricingCalculator.profitMarginPercent(sellingPrice, sourceCost, targetPlatformId, rules)
          : pricingCalculator.profitMarginPercent(sellingPrice, sourceCost);

      if (!pricingCalculator.meetsMinProfit(sellingPrice, sourceCost, rules, targetPlatformId, categoryId)) {
        final minMargin = categoryId != null
            ? (rules.categoryMinProfitPercent[categoryId] ?? rules.minProfitPercent)
            : rules.minProfitPercent;
        return ListingDecisionReject(
          reason: 'Profit margin ${margin.toStringAsFixed(1)}% < $minMargin%',
        );
      }
      reason = 'Profit margin ${margin.toStringAsFixed(1)}% >= ${rules.minProfitPercent}%';
    }

    final absoluteProfit = targetPlatformId != null
        ? pricingCalculator.profitAfterFee(sellingPrice, sourceCost, targetPlatformId, rules)
        : pricingCalculator.profitAfterFee(sellingPrice, sourceCost);
    if (absoluteProfit < 5.0) {
      return ListingDecisionReject(
        reason: 'Absolute profit ${absoluteProfit.toStringAsFixed(2)} PLN < 5 PLN minimum',
      );
    }

    if (sellingPrice > sourceCost * 10) {
      return ListingDecisionReject(
        reason: 'Selling price ${sellingPrice.toStringAsFixed(2)} exceeds 10x source cost ${sourceCost.toStringAsFixed(2)} — possible data error',
      );
    }

    final minMargin = categoryId != null
        ? (rules.categoryMinProfitPercent[categoryId] ?? rules.minProfitPercent)
        : rules.minProfitPercent;
    if (margin >= minMargin && margin < minMargin + 5) {
      appLogger.w(
        'ListingDecider: borderline margin ${margin.toStringAsFixed(1)}% for product ${product.id} '
        '(min $minMargin%, threshold ${(minMargin + 5).toStringAsFixed(1)}%)',
      );
    }

    final listingId = 'listing_${product.sourcePlatformId}_${product.sourceId}_${DateTime.now().millisecondsSinceEpoch}';
    final String? variantId =
        product.variants.isNotEmpty ? product.variants.first.id : null;
    final listing = Listing(
      id: listingId,
      productId: product.id,
      targetPlatformId: targetPlatformId ?? '',
      status: rules.manualApprovalListings ? ListingStatus.pendingApproval : ListingStatus.draft,
      sellingPrice: sellingPrice,
      sourceCost: sourceCost,
      createdAt: DateTime.now(),
      variantId: variantId,
    );
    return ListingDecisionAccept(
      listing: listing,
      reason: reason,
      criteriaSnapshot: {
        'sourceCost': sourceCost,
        'sellingPrice': sellingPrice,
        'marginPercent': margin,
        'minProfitPercent': minMargin,
        if (qualityRisk != null) 'qualityScore': qualityRisk.qualityScore,
        if (qualityRisk != null) 'returnRiskScore': qualityRisk.returnRiskScore,
        'competitionLevel': ?competitionLevel,
        if (targetPlatformId != null && (qualityRisk != null || competitionLevel != null))
          'dynamicPricingAdjusted': dynamicPricingAdjusted,
        ...? (targetPlatformId != null ? {'platformId': targetPlatformId} : null),
        ...? (rules.pricingStrategy.isNotEmpty ? {'pricingStrategy': rules.pricingStrategy} : null),
      },
    );
  }
}

sealed class ListingDecision {
  const ListingDecision();
}

class ListingDecisionAccept extends ListingDecision {
  const ListingDecisionAccept({
    required this.listing,
    required this.reason,
    this.criteriaSnapshot,
  });
  final Listing listing;
  final String reason;
  final Map<String, dynamic>? criteriaSnapshot;
}

class ListingDecisionReject extends ListingDecision {
  const ListingDecisionReject({required this.reason});
  final String reason;
}

/// Extension to make pattern matching / usage easier.
extension ListingDecisionX on ListingDecision {
  Listing? get listingOrNull =>
      this is ListingDecisionAccept ? (this as ListingDecisionAccept).listing : null;
  String get reason =>
      this is ListingDecisionAccept
          ? (this as ListingDecisionAccept).reason
          : (this as ListingDecisionReject).reason;
  bool get isAccept => this is ListingDecisionAccept;
}
