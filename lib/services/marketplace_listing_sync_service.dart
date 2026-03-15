import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/domain/catalog/catalog_cache.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/profit_guard_service.dart';

/// Refreshes product stock from sources and pushes updates to marketplace listings (Allegro, Temu, etc.)
/// so seller offers stay in sync with supplier availability.
/// Phase 30: when [catalogCache] is set, listing and product reads use cache (TTL + invalidation on update).
class MarketplaceListingSyncService {
  MarketplaceListingSyncService({
    required this.listingRepository,
    required this.productRepository,
    required this.sources,
    required this.targets,
    this.profitGuard,
    this.catalogCache,
  });

  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final List<SourcePlatform> sources;
  final List<TargetPlatform> targets;
  final ProfitGuardService? profitGuard;
  final CatalogCache? catalogCache;

  /// Tracks products that recently reappeared after being out of stock (total stock 0 -> > 0).
  /// Used to keep refreshing them on the fast (low-stock) schedule for a limited time window.
  final Map<String, DateTime> _reappearedProducts = {};

  /// Returns IDs of products that reappeared within the given [window], cleaning up older entries.
  List<String> _recentReappearedProductIds(Duration window) {
    final now = DateTime.now();
    _reappearedProducts.removeWhere((_, ts) => now.difference(ts) > window);
    return _reappearedProducts.keys.toList();
  }

  void _trackReappearanceIfNeeded(String productId, int oldTotalStock, int newTotalStock) {
    // Previously OOS (0) and now back in stock (> 0) – mark as reappeared.
    if (oldTotalStock == 0 && newTotalStock > 0) {
      _reappearedProducts[productId] = DateTime.now();
    }
    // If we went back to 0 stock, we can drop it from the reappeared set; low-stock
    // refresh will still handle OOS items via the stock threshold.
    if (newTotalStock == 0) {
      _reappearedProducts.remove(productId);
    }
  }

  /// Phase 23: Sync a single listing by id (fetch product from source, update marketplace). Returns true if updated.
  /// Use for throttled queue worker; errors are logged.
  Future<bool> syncOneListing(String listingId, {bool updateLocalProduct = true}) async {
    Listing? listing = catalogCache?.getListing(listingId);
    listing ??= await listingRepository.getByLocalId(listingId);
    if (listing != null && catalogCache != null) catalogCache!.putListing(listingId, listing);
    if (listing == null || listing.targetListingId == null || listing.targetListingId!.isEmpty) return false;
    if (listing.status != ListingStatus.active) return false;
    final list = listing;

    var product = catalogCache?.getProduct(list.productId);
    product ??= await productRepository.getByLocalId(list.productId);
    if (product != null && catalogCache != null) catalogCache!.putProduct(list.productId, product);
    if (product == null || product.variants.isEmpty) return false;
    final p = product;

    final sourceList = sources.where((s) => s.id == p.sourcePlatformId).toList();
    final source = sourceList.isEmpty ? null : sourceList.first;
    if (source == null || !(await source.isConfigured())) return false;

      try {
      final fresh = await source.getProduct(p.sourceId);
      if (fresh == null || fresh.variants.isEmpty) return false;

      final oldTotalStock = p.variants.fold<int>(0, (s, v) => s + v.stock);
      final totalStock = fresh.variants.fold<int>(0, (s, v) => s + v.stock);
      _trackReappearanceIfNeeded(p.id, oldTotalStock, totalStock);

      final targetList = targets.where((t) => t.id == list.targetPlatformId).toList();
      final target = targetList.isEmpty ? null : targetList.first;
      if (target == null || !(await target.isConfigured())) return false;

      final titleChanged = fresh.title != p.title;
      final descriptionChanged = (fresh.description ?? '') != (p.description ?? '');
      await target.updateListing(
        list.targetListingId!,
        stock: totalStock,
        title: titleChanged ? fresh.title : null,
        description: descriptionChanged ? (fresh.description ?? '') : null,
      );
      if (updateLocalProduct) {
        await productRepository.upsert(fresh.copyWith(id: p.id));
        catalogCache?.invalidateProduct(p.id);
        catalogCache?.invalidateListing(listingId);
      }
      return true;
    } catch (e, st) {
      appLogger.e(
        'MarketplaceListingSync: failed for listing $listingId (${list.targetListingId})',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }

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

        final oldTotalStock = product.variants.fold<int>(0, (s, v) => s + v.stock);
        final totalStock = fresh.variants.fold<int>(0, (s, v) => s + v.stock);
        _trackReappearanceIfNeeded(product.id, oldTotalStock, totalStock);

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
      if (profitGuard != null) await profitGuard!.checkActiveListings();
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

        final oldTotalStock = product.variants.fold<int>(0, (s, v) => s + v.stock);
        final newTotalStock = fresh.variants.fold<int>(0, (s, v) => s + v.stock);
        _trackReappearanceIfNeeded(product.id, oldTotalStock, newTotalStock);

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
      if (profitGuard != null) await profitGuard!.checkActiveListings();
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

    // Also include products that recently reappeared after being fully OOS
    // so they stay on the fast refresh schedule for a while (e.g. 24h).
    final recentlyReappeared = _recentReappearedProductIds(const Duration(hours: 24));
    final targetIds = <String>{
      ...lowStockIds,
      ...recentlyReappeared.where(productIds.contains),
    }.toList();

    if (targetIds.isEmpty) return 0;

    var refreshed = 0;
    for (final productId in targetIds) {
      final product = await productRepository.getByLocalId(productId);
      if (product == null || product.variants.isEmpty) continue;

      final sourceList = sources.where((s) => s.id == product.sourcePlatformId).toList();
      final source = sourceList.isEmpty ? null : sourceList.first;
      if (source == null || !(await source.isConfigured())) continue;

      try {
        final fresh = await source.getProduct(product.sourceId);
        if (fresh == null || fresh.variants.isEmpty) continue;

        final oldTotalStock = product.variants.fold<int>(0, (s, v) => s + v.stock);
        final newTotalStock = fresh.variants.fold<int>(0, (s, v) => s + v.stock);
        _trackReappearanceIfNeeded(product.id, oldTotalStock, newTotalStock);

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
