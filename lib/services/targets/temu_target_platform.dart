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

  @override
  Future<String> createListing(ListingDraft draft) async {
    final body = {
      'title': draft.title,
      'description': draft.description,
      'price': draft.sellingPrice,
      'currency': 'PLN',
      'stock': draft.stock ?? 99,
      'images': draft.imageUrls,
      if (draft.categoryId != null) 'categoryId': draft.categoryId,
    };
    final id = await _client.createListing(body);
    if (id == null) throw Exception('Temu createListing returned no id');
    return id;
  }

  @override
  Future<void> updateListing(String listingId, {double? price, int? stock}) async {
    await _client.updateListing(listingId, price: price, stock: stock);
  }

  @override
  Future<List<Order>> getOrders(DateTime since) async {
    final raw = await _client.getOrders(since: since);
    return raw.map((form) {
      final id = form['id'] as String? ?? '';
      final amount = (form['totalPrice'] as num?)?.toDouble() ?? 0.0;
      final addr = form['shippingAddress'] as Map<String, dynamic>? ?? {};
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
        createdAt: form['createdAt'] != null ? DateTime.tryParse(form['createdAt'] as String) : DateTime.now(),
      );
    }).toList();
  }

  @override
  Future<void> updateTracking(String orderId, String trackingNumber) async {
    await _client.updateTracking(orderId, trackingNumber);
  }

  @override
  Future<Map<String, dynamic>?> getListingDetails(String listingId) async {
    return null;
  }
}
