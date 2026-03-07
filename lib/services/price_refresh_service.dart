import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

/// Refreshes stale supplier offer prices from source platforms.
class PriceRefreshService {
  PriceRefreshService({
    required this.supplierOfferRepository,
    required this.sources,
  });

  final SupplierOfferRepository supplierOfferRepository;
  final List<SourcePlatform> sources;

  /// Refresh offers older than [staleDuration].
  Future<int> refreshStaleOffers({
    Duration staleDuration = const Duration(hours: 6),
  }) async {
    final stale = await supplierOfferRepository.getStaleOffers(staleDuration);
    var refreshed = 0;

    for (final offer in stale) {
      final source = sources.where((s) => s.id == offer.sourcePlatformId).firstOrNull;
      if (source == null) continue;

      try {
        final product = await source.getProduct(offer.productId);
        if (product == null) continue;

        final updated = offer.copyWith(
          cost: product.basePrice,
          shippingCost: product.shippingCost,
          lastPriceRefreshAt: DateTime.now(),
        );
        await supplierOfferRepository.upsert(updated);
        refreshed++;
      } catch (e, st) {
        appLogger.e('PriceRefresh: failed for offer ${offer.id}', error: e, stackTrace: st);
      }
    }

    appLogger.i('PriceRefresh: refreshed $refreshed of ${stale.length} stale offers');
    return refreshed;
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
