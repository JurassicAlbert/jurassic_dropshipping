import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';

/// Filters for searching products on a source platform.
class SourceSearchFilters {
  const SourceSearchFilters({
    this.maxPrice,
    this.minStock,
    this.countryCodes,
    this.maxEstimatedDays,
  });
  final double? maxPrice;
  final int? minStock;
  final List<String>? countryCodes;
  final int? maxEstimatedDays;
}

/// Request to place an order with a source supplier.
class PlaceOrderRequest {
  const PlaceOrderRequest({
    required this.productId,
    required this.variantId,
    required this.quantity,
    required this.customerAddress,
    required this.sourcePlatformId,
    this.shippingMethod,
  });
  final String productId;
  final String variantId;
  final int quantity;
  final CustomerAddress customerAddress;
  final String sourcePlatformId;
  final String? shippingMethod;
}

/// Result of placing an order with a source (order id + optional tracking when available).
class SourceOrderResult {
  const SourceOrderResult({
    required this.sourceOrderId,
    this.trackingNumber,
  });
  final String sourceOrderId;
  final String? trackingNumber;
}

/// Draft for creating a listing on a target marketplace.
class ListingDraft {
  const ListingDraft({
    required this.productId,
    required this.targetPlatformId,
    required this.title,
    required this.description,
    required this.sellingPrice,
    required this.sourceCost,
    required this.imageUrls,
    this.stock,
    this.categoryId,
  });
  final String productId;
  final String targetPlatformId;
  final String title;
  final String description;
  final double sellingPrice;
  final double sourceCost;
  final List<String> imageUrls;
  final int? stock;
  final String? categoryId;
}

/// Source platform (e.g. CJ, AliExpress via CJ). All data via official API only.
abstract class SourcePlatform {
  String get id;
  String get displayName;

  /// True if credentials are set so API calls can be made. When false, callers should skip this platform.
  Future<bool> isConfigured() async => true;

  /// Search products by keywords; optional filters.
  Future<List<Product>> searchProducts(
    List<String> keywords, {
    SourceSearchFilters? filters,
  });

  /// Get a single product by source id.
  Future<Product?> getProduct(String sourceId);

  /// Get best offer (e.g. cheapest variant/shipping) for a product.
  Future<Product?> getBestOffer(String productId);

  /// Place order with the source; returns source order id.
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request);

  /// Get current status / tracking for a source order.
  Future<SourceOrderResult?> getOrderStatus(String sourceOrderId);

  /// Cancel order at the source (e.g. before shipment). Returns true if cancelled, false if not supported.
  Future<bool> cancelOrder(String sourceOrderId);
}

/// Target (selling) platform (e.g. Allegro, Amazon). Listings and orders.
abstract class TargetPlatform {
  String get id;
  String get displayName;

  /// True if credentials are set so API calls can be made. When false, callers should skip this platform.
  Future<bool> isConfigured() async => true;

  /// Create a listing from a draft. Returns the target's listing/offer id.
  Future<String> createListing(ListingDraft draft);

  /// Update listing (e.g. price, stock, title, description). Omit params to leave unchanged.
  Future<void> updateListing(String listingId, {double? price, int? stock, String? title, String? description});

  /// Get orders since the given time.
  Future<List<Order>> getOrders(DateTime since);

  /// Update tracking number for an order.
  Future<void> updateTracking(String orderId, String trackingNumber);

  /// Get listing details (e.g. for sync).
  Future<Map<String, dynamic>?> getListingDetails(String listingId);

  /// Cancel order on the marketplace (seller-initiated, e.g. out of stock). May throw if not supported.
  Future<void> cancelOrder(String targetOrderId);

  /// Get current order status from the marketplace (to detect buyer cancellation).
  Future<OrderStatus?> getOrderStatus(String targetOrderId);
}
