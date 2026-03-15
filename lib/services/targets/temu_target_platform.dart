import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/targets/temu_seller_client.dart';

const String temuPlatformId = 'temu';

class TemuTargetPlatform implements TargetPlatform {
  TemuTargetPlatform(this._client);
  final TemuSellerClient _client;

  @override
  String get id => temuPlatformId;
  @override
  String get displayName => 'Temu';

  // For now, Temu listings are always in PLN. Centralized here to make it
  // easier to support multiple currencies in the future.
  String get _currency => 'PLN';

  @override
  Future<bool> isConfigured() async => false;

  @override
  Future<String> createListing(ListingDraft draft) async {
    final body = {
      'title': draft.title,
      'description': draft.description,
      'price': draft.sellingPrice,
      'currency': _currency,
      'stock': draft.stock ?? 99,
      'images': draft.imageUrls,
      if (draft.categoryId != null) 'categoryId': draft.categoryId,
    };
    final id = await _client.createListing(body);
    if (id == null) throw Exception('Temu createListing returned no id');
    return id;
  }

  @override
  Future<void> updateListing(String listingId, {double? price, int? stock, String? title, String? description}) async {
    await _client.updateListing(listingId, price: price, stock: stock, title: title, description: description);
  }

  /// Fetches orders from Temu. Assumes one line item per raw order (form).
  /// If the API later returns multiple line items per order (e.g. form['lineItems']),
  /// expand to one [Order] per line with stable ids (see AllegroTargetPlatform.getOrders).
  @override
  Future<List<Order>> getOrders(DateTime since) async {
    final raw = await _client.getOrders(since: since);
    return raw.map((form) {
      final id = form['id'] as String? ?? '';
      final amount = (form['totalPrice'] as num?)?.toDouble() ?? 0.0;
      final addr = form['shippingAddress'] as Map<String, dynamic>? ?? {};
      final quantity = form['quantity'] is num ? (form['quantity'] as num).toInt() : 1;
      return Order(
        id: '${id}_$temuPlatformId',
        listingId: form['listingId'] as String? ?? '',
        targetOrderId: id,
        targetPlatformId: temuPlatformId,
        customerAddress: CustomerAddress(
          name: addr['name'] as String? ?? 'Customer',
          street: addr['street'] as String? ?? '',
          city: addr['city'] as String?,
          zip: addr['zipCode'] as String? ?? '',
          countryCode: addr['countryCode'] as String? ?? 'PL',
          phone: addr['phone'] as String? ?? '',
          email: addr['email'] as String?,
        ),
        status: OrderStatus.pending,
        sourceCost: 0,
        sellingPrice: amount,
        quantity: quantity,
        createdAt: form['createdAt'] != null ? DateTime.tryParse(form['createdAt'] as String) : DateTime.now(),
      );
    }).toList();
  }

  @override
  Future<void> updateTracking(String orderId, String trackingNumber) async {
    await _client.updateTracking(orderId, trackingNumber);
  }

  @override
  Future<void> cancelOrder(String targetOrderId) async {
    await _client.cancelOrder(targetOrderId);
  }

  @override
  Future<OrderStatus?> getOrderStatus(String targetOrderId) async {
    return _client.getOrderStatus(targetOrderId);
  }

  @override
  Future<Map<String, dynamic>?> getListingDetails(String listingId) async {
    return null;
  }
}
