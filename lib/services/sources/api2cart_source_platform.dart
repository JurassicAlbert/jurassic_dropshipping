import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/sources/api2cart_client.dart';

class Api2CartSourcePlatform implements SourcePlatform {
  Api2CartSourcePlatform(this._client);
  final Api2CartClient _client;

  @override
  String get id => 'api2cart';
  @override
  String get displayName => 'API2Cart';

  @override
  Future<List<Product>> searchProducts(List<String> keywords, {SourceSearchFilters? filters}) async {
    final results = <Product>[];
    for (final keyword in keywords) {
      final raw = await _client.searchProducts(keyword);
      for (final item in raw) {
        final product = _mapProduct(item);
        if (product != null) {
          if (filters?.maxPrice != null && product.basePrice > filters!.maxPrice!) continue;
          results.add(product);
        }
      }
    }
    return results;
  }

  @override
  Future<Product?> getProduct(String sourceId) async {
    final raw = await _client.getProduct(sourceId);
    return raw != null ? _mapProduct(raw) : null;
  }

  @override
  Future<Product?> getBestOffer(String productId) async {
    return getProduct(productId);
  }

  @override
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request) async {
    throw UnimplementedError('API2Cart does not support direct order placement');
  }

  @override
  Future<SourceOrderResult?> getOrderStatus(String sourceOrderId) async {
    return null;
  }

  Product? _mapProduct(Map<String, dynamic> raw) {
    final id = raw['id']?.toString();
    if (id == null) return null;
    final images = raw['images'] as List<dynamic>? ?? [];
    return Product(
      id: 'api2cart_$id',
      sourceId: id,
      sourcePlatformId: 'api2cart',
      title: raw['name'] as String? ?? '',
      basePrice: (raw['price'] as num?)?.toDouble() ?? 0.0,
      imageUrls: images.map((img) {
        if (img is Map) return img['http_path']?.toString() ?? '';
        return img.toString();
      }).where((u) => u.isNotEmpty).toList(),
      variants: [],
    );
  }
}
