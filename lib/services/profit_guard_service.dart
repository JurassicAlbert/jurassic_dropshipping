import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/auto_pausing_service.dart';
import 'package:uuid/uuid.dart';

/// After price refresh or marketplace sync, checks active listings for margin drops
/// and writes profit_alert decision logs when margin falls below rules threshold.
class ProfitGuardService {
  ProfitGuardService({
    required this.rulesRepository,
    required this.listingRepository,
    required this.productRepository,
    required this.supplierOfferRepository,
    required this.decisionLogRepository,
    required this.pricingCalculator,
    this.autoPausingService,
  });

  final RulesRepository rulesRepository;
  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final SupplierOfferRepository supplierOfferRepository;
  final DecisionLogRepository decisionLogRepository;
  final PricingCalculator pricingCalculator;
  final AutoPausingService? autoPausingService;

  static const double _minAbsoluteProfitPln = 5.0;

  /// Checks all active listings: if current source cost (from offer or product) makes
  /// margin below rules minimum or absolute profit below 5 PLN, writes a profit_alert
  /// DecisionLog. Returns the number of alerts written.
  Future<int> checkActiveListings() async {
    final rules = await rulesRepository.get();
    final active = await listingRepository.getByStatus(ListingStatus.active);
    var alertsWritten = 0;

    for (final listing in active) {
      final product = await productRepository.getByLocalId(listing.productId);
      if (product == null) continue;

      final offers = await supplierOfferRepository.getByProductId(listing.productId);
      final bestOffer = offers.isEmpty
          ? null
          : offers.reduce((a, b) => (a.cost + (a.shippingCost ?? 0)) <= (b.cost + (b.shippingCost ?? 0)) ? a : b);
      final currentCost = bestOffer != null
          ? (bestOffer.cost + (bestOffer.shippingCost ?? 0))
          : product.basePrice + (product.shippingCost ?? 0);

      final margin = pricingCalculator.profitMarginPercent(
        listing.sellingPrice,
        currentCost,
        listing.targetPlatformId,
        rules,
      );
      final absoluteProfit = listing.sellingPrice - currentCost;

      final belowMargin = margin < rules.minProfitPercent;
      final belowAbsolute = absoluteProfit < _minAbsoluteProfitPln;
      if (!belowMargin && !belowAbsolute) continue;

      final reason = belowAbsolute
          ? 'Absolute profit ${absoluteProfit.toStringAsFixed(2)} PLN < $_minAbsoluteProfitPln PLN minimum'
          : 'Profit margin ${margin.toStringAsFixed(1)}% < ${rules.minProfitPercent}% (source cost rose)';

      final snapshot = {
        'listingId': listing.id,
        'productId': listing.productId,
        'sellingPrice': listing.sellingPrice,
        'currentSourceCost': currentCost,
        'marginPercent': margin,
        'minProfitPercent': rules.minProfitPercent,
        'absoluteProfit': absoluteProfit,
      };

      try {
        await decisionLogRepository.insert(DecisionLog(
          id: const Uuid().v4(),
          type: DecisionLogType.profitAlert,
          entityId: listing.id,
          reason: reason,
          criteriaSnapshot: snapshot,
          createdAt: DateTime.now(),
        ));
        alertsWritten++;
        // Phase 20: optionally auto-pause listing when margin below threshold (price drift protection).
        if (rules.autoPauseListingWhenMarginBelowThreshold) {
          try {
            if (autoPausingService != null) {
              await autoPausingService!.applyHardPause(
                listingId: listing.id,
                reason: 'negative_margin',
                metrics: snapshot,
              );
            } else {
              await listingRepository.updateStatus(listing.id, ListingStatus.paused);
            }
            appLogger.i('ProfitGuard: paused listing ${listing.id} (margin ${margin.toStringAsFixed(1)}% < ${rules.minProfitPercent}%)');
          } catch (e, st) {
            appLogger.e('ProfitGuard: failed to pause listing ${listing.id}', error: e, stackTrace: st);
          }
        }
      } catch (e, st) {
        appLogger.e('ProfitGuard: failed to write alert for listing ${listing.id}', error: e, stackTrace: st);
      }
    }

    // Auto-recovery (safe): if listing is paused and is now above thresholds, resume.
    if (rules.autoPauseListingWhenMarginBelowThreshold && autoPausingService != null) {
      final paused = await listingRepository.getByStatus(ListingStatus.paused);
      for (final listing in paused) {
        final product = await productRepository.getByLocalId(listing.productId);
        if (product == null) continue;
        final offers = await supplierOfferRepository.getByProductId(listing.productId);
        final bestOffer = offers.isEmpty
            ? null
            : offers.reduce((a, b) => (a.cost + (a.shippingCost ?? 0)) <= (b.cost + (b.shippingCost ?? 0)) ? a : b);
        final currentCost = bestOffer != null
            ? (bestOffer.cost + (bestOffer.shippingCost ?? 0))
            : product.basePrice + (product.shippingCost ?? 0);
        final margin = pricingCalculator.profitMarginPercent(
          listing.sellingPrice,
          currentCost,
          listing.targetPlatformId,
          rules,
        );
        final absoluteProfit = listing.sellingPrice - currentCost;
        final ok = margin >= rules.minProfitPercent && absoluteProfit >= _minAbsoluteProfitPln;
        if (ok) {
          await autoPausingService!.tryRecoverHardPause(
            listingId: listing.id,
            reason: 'margin_recovered',
          );
        }
      }
    }

    if (alertsWritten > 0) {
      appLogger.i('ProfitGuard: wrote $alertsWritten profit_alert(s) for active listings');
    }
    return alertsWritten;
  }
}
