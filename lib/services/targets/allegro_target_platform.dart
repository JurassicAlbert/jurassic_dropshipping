import 'package:jurassic_dropshipping/core/logger.dart';
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

   // For now, Allegro listings are always in PLN and located in PL.
   // Keeping this centralized makes it easier to support other currencies/countries later.
   String get _currency => 'PLN';
   String get _sellerCountryCode => 'PL';

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
          'currency': _currency,
        },
      },
      'stock': {'available': draft.stock ?? 99, 'unit': 'UNIT'},
      'images': draft.imageUrls
          .take(16)
          .map((url) => {'url': url})
          .toList(),
      'location': {'countryCode': _sellerCountryCode},
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
      if (lineItems.isEmpty) continue;
      final buyer = form['buyer'] as Map<String, dynamic>? ?? {};
      final delivery = form['delivery'] as Map<String, dynamic>? ?? {};
      final address = delivery['address'] as Map<String, dynamic>? ?? {};
      final total = form['summary']?['totalToPay'] as Map<String, dynamic>?;
      final totalAmount = total?['amount'] != null ? double.tryParse(total!['amount'].toString()) ?? 0.0 : 0.0;
      final createdAt = form['createdAt'] as String?;
      final created = createdAt != null ? DateTime.tryParse(createdAt) : null;
      final customerAddress = CustomerAddress(
        name: buyer['login'] as String? ?? address['fullName'] as String? ?? 'Customer',
        street: address['street'] as String? ?? '',
        city: address['city'] as String?,
        zip: address['zipCode'] as String? ?? '',
        countryCode: address['countryCode'] as String? ?? 'PL',
        phone: address['phoneNumber'] as String? ?? '',
        email: buyer['email'] as String?,
      );
      if (lineItems.length > 1) {
        appLogger.i('Allegro order $id has ${lineItems.length} line items, creating ${lineItems.length} local orders');
      }
      for (var idx = 0; idx < lineItems.length; idx++) {
        final line = lineItems[idx] as Map<String, dynamic>? ?? {};
        final offerId = line['offer']?['id']?.toString() ?? '';
        final quantity = line['quantity'] is num ? (line['quantity'] as num).toInt() : 1;
        final lineAmount = line['price']?['amount'];
        final linePrice = lineAmount != null ? double.tryParse(lineAmount.toString()) : null;
        final sellingPrice = linePrice ?? (lineItems.length > 1 ? totalAmount / lineItems.length : totalAmount);
        final orderId = lineItems.length == 1
            ? '${id}_$allegroPlatformId'
            : '${id}_${allegroPlatformId}_$idx';
        orders.add(Order(
          id: orderId,
          listingId: offerId,
          targetOrderId: id,
          targetPlatformId: allegroPlatformId,
          customerAddress: customerAddress,
          status: OrderStatus.pending,
          sourceCost: 0,
          sellingPrice: sellingPrice,
          quantity: quantity,
          createdAt: created ?? DateTime.now(),
        ));
      }
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

  // --- Phase 12: Returns & refunds ---

  @override
  Future<List<CustomerReturnSummary>> getCustomerReturns({DateTime? since}) async {
    return _client.getCustomerReturns(
      createdAtGte: since,
      limit: 100,
    );
  }

  @override
  Future<CustomerReturnDetails?> getCustomerReturn(String returnId) async {
    return _client.getCustomerReturn(returnId);
  }

  @override
  Future<void> rejectReturn(String returnId, String reason) async {
    await _client.rejectCustomerReturn(returnId, reason);
  }

  @override
  Future<void> issueRefund(String targetOrderId, double amount, String reason) async {
    final form = await _client.getCheckoutForm(targetOrderId);
    if (form == null) throw StateError('Allegro checkout form not found: $targetOrderId');
    final payment = form['payment'] as Map<String, dynamic>?;
    final paymentId = payment?['id'] as String?;
    if (paymentId == null || paymentId.isEmpty) {
      throw StateError('Allegro checkout form has no payment id; cannot issue refund');
    }
    final lineItemsRaw = form['lineItems'] as List<dynamic>? ?? [];
    final lineItems = lineItemsRaw.map((e) {
      final m = e as Map<String, dynamic>;
      final id = m['id'] as String? ?? '';
      final qty = (m['quantity'] as num?)?.toInt() ?? 1;
      return {'id': id, 'type': 'QUANTITY', 'quantity': qty, 'value': null};
    }).toList();
    await _client.createRefund(
      paymentId: paymentId,
      orderId: targetOrderId,
      reason: 'REFUND',
      lineItems: lineItems.isEmpty ? null : lineItems,
      sellerComment: reason,
    );
  }

  @override
  Future<Map<String, dynamic>?> getListingDetails(String listingId) async {
    return null;
  }
}
