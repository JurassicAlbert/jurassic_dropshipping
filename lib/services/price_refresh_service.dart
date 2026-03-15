import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:jurassic_dropshipping/data/repositories/background_job_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/profit_guard_service.dart';

/// Refreshes stale supplier offer prices from source platforms (XML/CSV/API feeds).
/// Warehouses typically publish new prices 1–2×/day at different times; when [rulesRepository]
/// is set, each source uses its own refresh interval from [UserRules.priceRefreshIntervalMinutesBySource]
/// (default 720 min = 12h). Otherwise a single [staleDuration] is used for all sources.
/// When [jobRepository] is set (Phase 31), enqueues [BackgroundJobType.catalogEvent] per updated product
/// so the event handler can enqueue update_listing jobs (decouples refresh from listing sync).
class PriceRefreshService {
  PriceRefreshService({
    required this.supplierOfferRepository,
    required this.sources,
    this.profitGuard,
    this.rulesRepository,
    this.jobRepository,
  });

  final SupplierOfferRepository supplierOfferRepository;
  final List<SourcePlatform> sources;
  final ProfitGuardService? profitGuard;
  final RulesRepository? rulesRepository;
  final BackgroundJobRepository? jobRepository;

  /// Default interval when no per-source value is set (12h = 1–2×/day).
  static const int defaultRefreshIntervalMinutes = 720;

  /// Refresh offers older than [staleDuration]. Returns product IDs that were updated (Phase 29: enqueue listing updates).
  /// When [rulesRepository] is set, uses per-source interval so each warehouse is refreshed on its own cadence.
  Future<List<String>> refreshStaleOffers({
    Duration staleDuration = const Duration(hours: 6),
  }) async {
    if (rulesRepository != null) {
      final rules = await rulesRepository!.get();
      final allProductIds = <String>[];
      for (final source in sources) {
        final minutes = rules.priceRefreshIntervalMinutesBySource[source.id] ?? defaultRefreshIntervalMinutes;
        final ids = await refreshStaleOffersForSource(source.id, Duration(minutes: minutes));
        allProductIds.addAll(ids);
      }
      if (allProductIds.isNotEmpty && profitGuard != null) {
        await profitGuard!.checkActiveListings();
      }
      await _emitCatalogEvents(allProductIds);
      return allProductIds;
    }

    final stale = await supplierOfferRepository.getStaleOffers(staleDuration);
    final productIdsUpdated = await _refreshOffersList(stale);
    appLogger.i('PriceRefresh: refreshed ${productIdsUpdated.length} products (${stale.length} stale offers)');
    if (productIdsUpdated.isNotEmpty && profitGuard != null) {
      await profitGuard!.checkActiveListings();
    }
    await _emitCatalogEvents(productIdsUpdated);
    return productIdsUpdated;
  }

  /// Refresh only offers for [sourcePlatformId] that are older than [staleDuration]. Returns product IDs updated.
  Future<List<String>> refreshStaleOffersForSource(
    String sourcePlatformId,
    Duration staleDuration,
  ) async {
    final stale = await supplierOfferRepository.getStaleOffersForSource(sourcePlatformId, staleDuration);
    if (stale.isEmpty) return [];
    final source = sources.where((s) => s.id == sourcePlatformId).firstOrNull;
    if (source == null || !(await source.isConfigured())) return [];
    final productIdsUpdated = await _refreshOffersList(stale);
    if (productIdsUpdated.isNotEmpty) {
      appLogger.i('PriceRefresh: source $sourcePlatformId refreshed ${productIdsUpdated.length} products');
    }
    return productIdsUpdated;
  }

  /// Phase 31: enqueue catalog_event per product so handler can enqueue update_listing.
  Future<void> _emitCatalogEvents(List<String> productIds) async {
    if (productIds.isEmpty || jobRepository == null) return;
    for (final productId in productIds) {
      await jobRepository!.enqueue(BackgroundJobType.catalogEvent, {
        'eventType': CatalogEventType.supplierOfferChange,
        'productId': productId,
      });
    }
  }

  Future<List<String>> _refreshOffersList(Iterable<SupplierOffer> stale) async {
    final productIdsUpdated = <String>{};
    for (final offer in stale) {
      final source = sources.where((s) => s.id == offer.sourcePlatformId).firstOrNull;
      if (source == null || !(await source.isConfigured())) continue;

      try {
        final product = await source.getProduct(offer.productId);
        if (product == null) continue;

        final updated = offer.copyWith(
          cost: product.basePrice,
          shippingCost: product.shippingCost,
          lastPriceRefreshAt: DateTime.now(),
        );
        await supplierOfferRepository.upsert(updated);
        productIdsUpdated.add(offer.productId);
      } catch (e, st) {
        appLogger.e('PriceRefresh: failed for offer ${offer.id}', error: e, stackTrace: st);
      }
    }
    return productIdsUpdated.toList();
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
