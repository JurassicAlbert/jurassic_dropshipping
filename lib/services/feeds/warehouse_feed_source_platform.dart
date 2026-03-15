import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/domain/product_feed.dart';

/// Exposes a [ProductFeed] (warehouse/depot CSV, XML, or API) as a [SourcePlatform] so the scanner and
/// sync services can use it like CJ/API2Cart. Use when sourcing directly from product origin instead of a middleman.
/// Order placement is not supported (catalog-only); fulfillment would require a separate warehouse API integration.
class WarehouseFeedSourcePlatform implements SourcePlatform {
  WarehouseFeedSourcePlatform({
    required this.feed,
  });

  final ProductFeed feed;

  @override
  String get id => feed.id;

  @override
  String get displayName => feed.displayName;

  @override
  Future<bool> isConfigured() async => true;

  @override
  Future<List<Product>> searchProducts(
    List<String> keywords, {
    SourceSearchFilters? filters,
  }) async {
    final all = await feed.getProducts();
    if (keywords.isEmpty) return all;
    final lowerKeywords = keywords.map((k) => k.toLowerCase()).toList();
    return all.where((p) {
      final title = p.title.toLowerCase();
      final desc = (p.description ?? '').toLowerCase();
      return lowerKeywords.any((k) => title.contains(k) || desc.contains(k));
    }).toList();
  }

  @override
  Future<Product?> getProduct(String sourceId) => feed.getProduct(sourceId);

  @override
  Future<Product?> getBestOffer(String productId) => feed.getProduct(productId);

  @override
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request) {
    throw UnimplementedError(
      'Warehouse feed ($id) is catalog-only; place order via warehouse API or another source.',
    );
  }

  @override
  Future<SourceOrderResult?> getOrderStatus(String sourceOrderId) async =>
      null;

  @override
  Future<bool> cancelOrder(String sourceOrderId) async => false;
}
