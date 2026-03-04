import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/targets/allegro_client.dart';

const String allegroPlatformId = 'allegro';

/// Target platform implementation using Allegro REST API.
class AllegroTargetPlatform implements TargetPlatform {
  AllegroTargetPlatform(this._client);
  final AllegroClient _client;

  @override
  String get id => allegroPlatformId;
  @override
  String get displayName => 'Allegro';

  @override
  Future<String> createListing(ListingDraft draft) async {
    final body = {
      'name': draft.title,
      'description': {'sections': [
        {'items': [{'type': 'TEXT', 'content': draft.description}]}
      ]},
      'sellingMode': {'price': {'amount': draft.sellingPrice.toString(), 'currency': 'PLN'}},
      'stock': {'available': draft.stock ?? 99},
      'images': draft.imageUrls.take(10).map((url) => {'url': url}).toList(),
      if (draft.categoryId != null) 'category': {'id': draft.categoryId},
    };
    final offerId = await _client.createOffer(body);
    if (offerId == null) throw Exception('Allegro createOffer returned no id');
    return offerId;
  }

  @override
  Future<void> updateListing(String listingId, {double? price, int? stock}) async {
    await _client.updateOffer(listingId, price: price, stock: stock);
  }

  @override
  Future<List<Order>> getOrders(DateTime since) async {
    final res = await _client.getCheckoutForms(since: since);
    final orders = <Order>[];
    for (final form in res.checkoutForms) {
      final id = form['id'] as String?;
      if (id == null) continue;
      final lineItems = form['lineItems'] as List<dynamic>? ?? [];
      final first = lineItems.isNotEmpty ? lineItems.first as Map<String, dynamic>? : null;
      final buyer = form['buyer'] as Map<String, dynamic>? ?? {};
      final delivery = form['delivery'] as Map<String, dynamic>? ?? {};
      final address = delivery['address'] as Map<String, dynamic>? ?? {};
      final total = form['summary']?['totalToPay'] as Map<String, dynamic>?;
      final amount = total?['amount'] != null ? double.tryParse(total!['amount'].toString()) ?? 0.0 : 0.0;
      final createdAt = form['createdAt'] as String?;
      orders.add(Order(
        id: '${id}_$allegroPlatformId',
        listingId: first?['offer']?['id']?.toString() ?? '',
        targetOrderId: id,
        targetPlatformId: allegroPlatformId,
        customerAddress: CustomerAddress(
          name: buyer['login'] as String? ?? address['fullName'] as String? ?? 'Customer',
          street: address['street'] as String? ?? '',
          city: address['city'] as String?,
          zip: address['zipCode'] as String? ?? '',
          countryCode: address['countryCode'] as String? ?? 'PL',
          phone: address['phoneNumber'] as String? ?? '',
          email: buyer['email'] as String?,
        ),
        status: OrderStatus.pending,
        sourceCost: 0,
        sellingPrice: amount,
        createdAt: createdAt != null ? DateTime.tryParse(createdAt) : DateTime.now(),
      ));
    }
    return orders;
  }

  @override
  Future<void> updateTracking(String orderId, String trackingNumber) async {
    await _client.setShipmentTracking(orderId, trackingNumber, 'OTHER');
  }

  @override
  Future<Map<String, dynamic>?> getListingDetails(String listingId) async {
    return null;
  }
}
