import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

class MockTargetPlatform implements TargetPlatform {
  MockTargetPlatform({this.mockId = 'mock_target'});
  final String mockId;
  String? lastTrackingOrderId;
  String? lastTrackingNumber;

  @override
  String get id => mockId;
  @override
  String get displayName => 'Mock Target';

  @override
  Future<bool> isConfigured() async => true;

  @override
  Future<String> createListing(ListingDraft draft) async => 'mock_listing_id';

  @override
  Future<void> updateListing(String listingId, {double? price, int? stock, String? title, String? description}) async {}

  @override
  Future<List<Order>> getOrders(DateTime since) async => [];

  @override
  Future<void> updateTracking(String orderId, String trackingNumber) async {
    lastTrackingOrderId = orderId;
    lastTrackingNumber = trackingNumber;
  }

  @override
  Future<Map<String, dynamic>?> getListingDetails(String listingId) async => null;

  @override
  Future<void> cancelOrder(String targetOrderId) async {}

  @override
  Future<OrderStatus?> getOrderStatus(String targetOrderId) async => null;
}
