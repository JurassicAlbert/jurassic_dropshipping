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
  Future<bool> isConfigured() => _client.isConfigured();

  @override
  Future<String> createListing(ListingDraft draft) async {
    final body = <String, dynamic>{
      'name': draft.title,
      'productSet': [
        {
          'product': {
            if (draft.categoryId != null) 'category': {'id': draft.categoryId},
            'parameters': <Map<String, dynamic>>[],
          },
          'quantity': {'value': draft.stock ?? 99},
        },
      ],
      'description': {
        'sections': [
          {
            'items': [
              {'type': 'TEXT', 'content': draft.description},
            ],
          },
        ],
      },
      'sellingMode': {
        'format': 'BUY_NOW',
        'price': {
          'amount': draft.sellingPrice.toStringAsFixed(2),
          'currency': 'PLN',
        },
      },
      'stock': {'available': draft.stock ?? 99, 'unit': 'UNIT'},
      'images': draft.imageUrls
          .take(16)
          .map((url) => {'url': url})
          .toList(),
      'location': {'countryCode': 'PL'},
      'delivery': {
        'shippingRates': null,
        'handlingTime': 'PT72H',
      },
      'payments': {'invoice': 'NO_INVOICE'},
    };
    final offerId = await _client.createOffer(body);
    if (offerId == null) throw Exception('Allegro createOffer returned no id');
    return offerId;
  }

  @override
  Future<void> updateListing(String listingId, {double? price, int? stock, String? title, String? description}) async {
    await _client.updateOffer(listingId, price: price, stock: stock, title: title, description: description);
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
  Future<void> cancelOrder(String targetOrderId) async {
    await _client.putFulfillmentStatus(targetOrderId, 'CANCELLED');
  }

  @override
  Future<OrderStatus?> getOrderStatus(String targetOrderId) async {
    final form = await _client.getCheckoutForm(targetOrderId);
    if (form == null) return null;
    final status = form['status'] as String?;
    final fulfillment = form['fulfillment'] as Map<String, dynamic>?;
    final fulfillmentStatus = fulfillment?['status'] as String?;
    if (status == 'CANCELLED') return OrderStatus.cancelled;
    if (fulfillmentStatus == 'CANCELLED') return OrderStatus.cancelled;
    if (fulfillmentStatus == 'SENT') return OrderStatus.shipped;
    if (fulfillmentStatus == 'READY_FOR_SHIPMENT' ||
        fulfillmentStatus == 'PROCESSING' ||
        fulfillmentStatus == 'NEW') {
      return OrderStatus.sourceOrderPlaced;
    }
    return OrderStatus.pending;
  }

  @override
  Future<Map<String, dynamic>?> getListingDetails(String listingId) async {
    return null;
  }
}
