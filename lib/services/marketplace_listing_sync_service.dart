import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

/// Refreshes product stock from sources and pushes updates to marketplace listings (Allegro, Temu, etc.)
/// so seller offers stay in sync with supplier availability.
class MarketplaceListingSyncService {
  MarketplaceListingSyncService({
    required this.listingRepository,
    required this.productRepository,
    required this.sources,
    required this.targets,
  });

  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final List<SourcePlatform> sources;
  final List<TargetPlatform> targets;

  /// Refresh product from source for each active listing with [targetListingId], then update
  /// the listing on the marketplace with new stock. Optionally upsert product so local cache stays fresh.
  /// Returns the number of listings successfully synced.
  Future<int> syncListingsStock({bool updateLocalProduct = true}) async {
    final active = await listingRepository.getByStatus(ListingStatus.active);
    final withTargetId = active.where((l) => l.targetListingId != null && l.targetListingId!.isNotEmpty).toList();
    var synced = 0;

    for (final listing in withTargetId) {
      final product = await productRepository.getByLocalId(listing.productId);
      if (product == null || product.variants.isEmpty) continue;

      final sourceList = sources.where((s) => s.id == product.sourcePlatformId).toList();
      final source = sourceList.isEmpty ? null : sourceList.first;
      if (source == null || !(await source.isConfigured())) continue;

      try {
        final fresh = await source.getProduct(product.sourceId);
        if (fresh == null || fresh.variants.isEmpty) continue;

        final totalStock = fresh.variants.fold<int>(0, (s, v) => s + v.stock);
        final targetList = targets.where((t) => t.id == listing.targetPlatformId).toList();
        final target = targetList.isEmpty ? null : targetList.first;
        if (target == null || !(await target.isConfigured())) continue;

        final titleChanged = fresh.title != product.title;
        final descriptionChanged = (fresh.description ?? '') != (product.description ?? '');
        await target.updateListing(
          listing.targetListingId!,
          stock: totalStock,
          title: titleChanged ? fresh.title : null,
          description: descriptionChanged ? (fresh.description ?? '') : null,
        );
        synced++;

        if (updateLocalProduct) {
          await productRepository.upsert(fresh.copyWith(id: product.id));
        }
      } catch (e, st) {
        appLogger.e(
          'MarketplaceListingSync: failed for listing ${listing.id} (${listing.targetListingId})',
          error: e,
          stackTrace: st,
        );
      }
    }

    if (synced > 0) {
      appLogger.i('MarketplaceListingSync: synced stock for $synced listings');
    }
    return synced;
  }

  /// Refresh product data from sources for all products that are linked to at least one active listing.
  /// Updates local product cache only (no marketplace API calls). Use this to keep stock/price
  /// fresh from feeds for pre-check and display. Returns the number of products refreshed.
  Future<int> refreshProductsFromSource() async {
    final active = await listingRepository.getByStatus(ListingStatus.active);
    final productIds = active.map((l) => l.productId).toSet().toList();
    var refreshed = 0;

    for (final productId in productIds) {
      final product = await productRepository.getByLocalId(productId);
      if (product == null || product.variants.isEmpty) continue;

      final sourceList = sources.where((s) => s.id == product.sourcePlatformId).toList();
      final source = sourceList.isEmpty ? null : sourceList.first;
      if (source == null || !(await source.isConfigured())) continue;

      try {
        final fresh = await source.getProduct(product.sourceId);
        if (fresh == null || fresh.variants.isEmpty) continue;

        await productRepository.upsert(fresh.copyWith(id: product.id));
        refreshed++;
      } catch (e, st) {
        appLogger.e(
          'MarketplaceListingSync: refresh product ${product.id} failed',
          error: e,
          stackTrace: st,
        );
      }
    }

    if (refreshed > 0) {
      appLogger.i('MarketplaceListingSync: refreshed $refreshed products from source');
    }
    return refreshed;
  }

  /// Refresh product data from source only for products linked to active listings where
  /// current total stock is at or below [maxStock]. Run this more often (e.g. every 30 min)
  /// so we detect OOS or restock quickly. Returns the number of products refreshed.
  Future<int> refreshProductsFromSourceLowStock({int maxStock = 5}) async {
    final active = await listingRepository.getByStatus(ListingStatus.active);
    final productIds = active.map((l) => l.productId).toSet().toList();
    final lowStockIds = <String>[];

    for (final productId in productIds) {
      final product = await productRepository.getByLocalId(productId);
      if (product == null || product.variants.isEmpty) continue;
      final total = product.variants.fold<int>(0, (s, v) => s + v.stock);
      if (total <= maxStock) lowStockIds.add(productId);
    }

    if (lowStockIds.isEmpty) return 0;

    var refreshed = 0;
    for (final productId in lowStockIds) {
      final product = await productRepository.getByLocalId(productId);
      if (product == null || product.variants.isEmpty) continue;

      final sourceList = sources.where((s) => s.id == product.sourcePlatformId).toList();
      final source = sourceList.isEmpty ? null : sourceList.first;
      if (source == null || !(await source.isConfigured())) continue;

      try {
        final fresh = await source.getProduct(product.sourceId);
        if (fresh == null || fresh.variants.isEmpty) continue;

        await productRepository.upsert(fresh.copyWith(id: product.id));
        refreshed++;
      } catch (e, st) {
        appLogger.e(
          'MarketplaceListingSync: refresh low-stock product ${product.id} failed',
          error: e,
          stackTrace: st,
        );
      }
    }

    if (refreshed > 0) {
      appLogger.d('MarketplaceListingSync: refreshed $refreshed low-stock products from source');
    }
    return refreshed;
  }
}
