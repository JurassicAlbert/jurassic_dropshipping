import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

class MockSourcePlatform implements SourcePlatform {
  MockSourcePlatform({this.products = const [], this.mockId = 'mock_source'});

  final List<Product> products;
  final String mockId;

  @override
  String get id => mockId;
  @override
  String get displayName => 'Mock Source';

  @override
  Future<bool> isConfigured() async => true;

  @override
  Future<List<Product>> searchProducts(List<String> keywords, {SourceSearchFilters? filters}) async {
    return products;
  }

  @override
  Future<Product?> getProduct(String sourceId) async {
    return products.where((p) => p.sourceId == sourceId).firstOrNull;
  }

  @override
  Future<Product?> getBestOffer(String productId) async {
    return products.where((p) => p.id == productId).firstOrNull;
  }

  @override
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request) async {
    return SourceOrderResult(sourceOrderId: 'mock_order_${request.productId}');
  }

  @override
  Future<SourceOrderResult?> getOrderStatus(String sourceOrderId) async {
    return SourceOrderResult(sourceOrderId: sourceOrderId);
  }

  @override
  Future<bool> cancelOrder(String sourceOrderId) async => true;
}
