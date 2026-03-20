import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

/// Stub for Amazon as a target. Use SP-API (Listings Items, Orders) for a full implementation.
/// Add OAuth/LWA and implement createListing, getOrders, updateTracking when integrating.
class AmazonStubTarget implements TargetPlatform {
  @override
  String get id => 'amazon';
  @override
  String get displayName => 'Amazon (coming soon)';

  @override
  Future<bool> isConfigured() async => false;

  @override
  Future<String> createListing(ListingDraft draft) async {
    throw UnsupportedError('Amazon SP-API integration not yet implemented');
  }

  @override
  Future<void> updateListing(String listingId, {double? price, int? stock, String? title, String? description}) async {}

  @override
  Future<List<Order>> getOrders(DateTime since) async => [];

  @override
  Future<void> updateTracking(String orderId, String trackingNumber) async {}

  @override
  Future<Map<String, dynamic>?> getListingDetails(String listingId) async => null;

  @override
  Future<void> cancelOrder(String targetOrderId) async {}

  @override
  Future<OrderStatus?> getOrderStatus(String targetOrderId) async => null;

  @override
  Future<List<CustomerReturnSummary>> getCustomerReturns({DateTime? since}) async => [];

  @override
  Future<CustomerReturnDetails?> getCustomerReturn(String returnId) async => null;

  @override
  Future<void> rejectReturn(String returnId, String reason) async {
    throw UnsupportedError('rejectReturn not supported on $id');
  }

  @override
  Future<void> issueRefund(String targetOrderId, double amount, String reason) async {
    throw UnsupportedError('issueRefund not supported on $id');
  }
}
