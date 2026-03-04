import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

/// Stub for Temu as a source. Temu has no official dropshipping/seller API.
/// Implement when/if an official API becomes available.
class TemuStubSource implements SourcePlatform {
  @override
  String get id => 'temu';
  @override
  String get displayName => 'Temu (not supported)';

  @override
  Future<List<Product>> searchProducts(
    List<String> keywords, {
    SourceSearchFilters? filters,
  }) async {
    return [];
  }

  @override
  Future<Product?> getProduct(String sourceId) async => null;

  @override
  Future<Product?> getBestOffer(String productId) async => null;

  @override
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request) async {
    throw UnsupportedError('Temu has no official dropshipping API');
  }

  @override
  Future<SourceOrderResult?> getOrderStatus(String sourceOrderId) async => null;
}
