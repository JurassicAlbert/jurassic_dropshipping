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
  Future<String> createListing(ListingDraft draft) async {
    throw UnsupportedError('Amazon SP-API integration not yet implemented');
  }

  @override
  Future<void> updateListing(String listingId, {double? price, int? stock}) async {}

  @override
  Future<List<Order>> getOrders(DateTime since) async => [];

  @override
  Future<void> updateTracking(String orderId, String trackingNumber) async {}

  @override
  Future<Map<String, dynamic>?> getListingDetails(String listingId) async => null;
}
