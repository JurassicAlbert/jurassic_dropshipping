import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/sources/cj_dropshipping_client.dart';

const String cjPlatformId = 'cj';

/// Source platform implementation using CJ Dropshipping API.
class CjSourcePlatform implements SourcePlatform {
  CjSourcePlatform(this._client);
  final CjDropshippingClient _client;

  @override
  String get id => cjPlatformId;
  @override
  String get displayName => 'CJ Dropshipping';

  static int? _parseDeliveryDays(String? deliveryCycle) {
    if (deliveryCycle == null || deliveryCycle.isEmpty) return null;
    final parts = deliveryCycle.split(RegExp(r'[^\d]'));
    final nums = parts.where((e) => e.isNotEmpty).map(int.tryParse).whereType<int>().toList();
    if (nums.isEmpty) return null;
    return nums.reduce((a, b) => a > b ? a : b);
  }

  @override
  Future<List<Product>> searchProducts(
    List<String> keywords, {
    SourceSearchFilters? filters,
  }) async {
    final keyWord = keywords.isNotEmpty ? keywords.join(' ') : null;
    if (keyWord == null || keyWord.isEmpty) return [];
    final list = <Product>[];
    var page = 1;
    const size = 50;
    while (true) {
      final res = await _client.productListV2(
        keyWord: keyWord,
        page: page,
        size: size,
        countryCode: filters?.countryCodes?.isNotEmpty == true ? filters!.countryCodes!.first : null,
        startSellPrice: filters?.maxPrice != null ? 0 : null,
        endSellPrice: filters?.maxPrice,
      );
      for (final item in res.content) {
        final product = _itemToProduct(item);
        if (product != null) list.add(product);
      }
      if (res.content.length < size) break;
      page++;
      if (page > 10) break;
    }
    return list;
  }

  Product? _itemToProduct(CjProductItem item) {
    final price = (item.nowPrice != null && item.nowPrice! > 0) ? item.nowPrice! : item.sellPrice;
    final productId = '${cjPlatformId}_${item.id}';
    return Product(
      id: productId,
      sourceId: item.id,
      sourcePlatformId: cjPlatformId,
      title: item.nameEn,
      description: item.description,
      imageUrls: item.bigImage != null ? [item.bigImage!] : [],
      variants: [
        ProductVariant(
          id: item.id,
          productId: productId,
          attributes: {},
          price: price,
          stock: item.warehouseInventoryNum ?? 0,
          sku: item.sku,
        ),
      ],
      basePrice: price,
      shippingCost: null,
      currency: 'USD',
      supplierCountry: null,
      estimatedDays: _parseDeliveryDays(item.deliveryCycle),
      rawJson: null,
    );
  }

  @override
  Future<Product?> getProduct(String sourceId) async {
    final detail = await _client.getProductDetail(sourceId);
    if (detail == null) return null;
    final items = await _client.productListV2(keyWord: sourceId, size: 1);
    final item = items.content.isNotEmpty ? items.content.first : null;
    if (item == null) return null;
    final base = _itemToProduct(item)!;
    final variants = detail.variants
        .map((v) => ProductVariant(
              id: v.vid,
              productId: base.id,
              attributes: {},
              price: v.sellPrice,
              stock: v.inventoryNum ?? 0,
              sku: v.sku,
            ))
        .toList();
    return base.copyWith(variants: variants, imageUrls: detail.imageList.isNotEmpty ? detail.imageList : base.imageUrls);
  }

  @override
  Future<Product?> getBestOffer(String productId) async {
    final sourceId = productId.replaceFirst('${cjPlatformId}_', '');
    return getProduct(sourceId);
  }

  @override
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request) async {
    final body = CjCreateOrderRequest(
      orderNumber: '${request.customerAddress.phone}_${DateTime.now().millisecondsSinceEpoch}',
      shippingCountryCode: request.customerAddress.countryCode,
      shippingCountry: request.customerAddress.countryCode,
      shippingProvince: request.customerAddress.state ?? '',
      shippingCity: request.customerAddress.city ?? '',
      shippingCustomerName: request.customerAddress.name,
      shippingAddress: request.customerAddress.street,
      shippingPhone: request.customerAddress.phone,
      shippingZip: request.customerAddress.zip,
      email: request.customerAddress.email,
      products: [
        CjOrderProduct(
          vid: request.variantId,
          quantity: request.quantity,
          storeLineItemId: request.productId,
        ),
      ],
    );
    final res = await _client.createOrderV2(body);
    return SourceOrderResult(
      sourceOrderId: res.orderId ?? res.orderNumber ?? '',
    );
  }

  @override
  Future<SourceOrderResult?> getOrderStatus(String sourceOrderId) async {
    return SourceOrderResult(sourceOrderId: sourceOrderId);
  }
}
