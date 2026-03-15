import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';

/// Phase 30: Optional in-memory cache for product, listing, and supplier offer data.
/// Reduces DB reads on hot paths (e.g. listing sync, fulfillment). TTL and invalidation on update.
/// Can be disabled for small catalogs (pass null or do not wire).
class CatalogCache {
  CatalogCache({
    this.ttl = const Duration(minutes: 5),
  });

  final Duration ttl;

  final Map<String, _Entry<Product>> _products = {};
  final Map<String, _Entry<Listing>> _listings = {};
  final Map<String, _Entry<SupplierOffer>> _offers = {};

  Product? getProduct(String productId) => _get(_products, productId);
  void putProduct(String productId, Product value) => _put(_products, productId, value);
  void invalidateProduct(String productId) => _products.remove(productId);

  Listing? getListing(String listingId) => _get(_listings, listingId);
  void putListing(String listingId, Listing value) => _put(_listings, listingId, value);
  void invalidateListing(String listingId) => _listings.remove(listingId);

  SupplierOffer? getOffer(String offerId) => _get(_offers, offerId);
  void putOffer(String offerId, SupplierOffer value) => _put(_offers, offerId, value);
  void invalidateOffer(String offerId) => _offers.remove(offerId);

  /// Invalidate all entries for a product (e.g. after catalog_event supplier_offer_change).
  /// Call [invalidateListingsForProduct] with the list of listing ids for that product to clear listing cache too.
  void invalidateProductAndListings(String productId, Iterable<String> listingIds) {
    invalidateProduct(productId);
    for (final id in listingIds) {
      invalidateListing(id);
    }
  }

  T? _get<T>(Map<String, _Entry<T>> map, String key) {
    final entry = map[key];
    if (entry == null) return null;
    if (DateTime.now().isAfter(entry.expiresAt)) {
      map.remove(key);
      return null;
    }
    return entry.value;
  }

  void _put<T>(Map<String, _Entry<T>> map, String key, T value) {
    map[key] = _Entry(value, DateTime.now().add(ttl));
  }

  /// Clear all entries (e.g. for tests or manual refresh).
  void clear() {
    _products.clear();
    _listings.clear();
    _offers.clear();
  }
}

class _Entry<T> {
  _Entry(this.value, this.expiresAt);
  final T value;
  final DateTime expiresAt;
}
