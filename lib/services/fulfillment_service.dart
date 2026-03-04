import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

/// Places source orders and updates tracking on target.
class FulfillmentService {
  FulfillmentService({
    required this.orderRepository,
    required this.listingRepository,
    required this.productRepository,
    required this.sources,
    required this.targets,
  });

  final OrderRepository orderRepository;
  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final List<SourcePlatform> sources;
  final List<TargetPlatform> targets;

  /// Place source order for [order], update order status and optionally push tracking to target.
  /// [order.listingId] may be our local listing id or the target's offer/listing id.
  Future<void> fulfillOrder(Order order) async {
    final listing = await listingRepository.getByLocalId(order.listingId) ??
        await listingRepository.getByTargetListingId(order.targetPlatformId, order.listingId);
    if (listing == null) {
      appLogger.w('Fulfillment: listing ${order.listingId} not found');
      await orderRepository.updateStatus(order.id, OrderStatus.failed);
      return;
    }
    final product = await productRepository.getByLocalId(listing.productId);
    if (product == null || product.variants.isEmpty) {
      appLogger.w('Fulfillment: product ${listing.productId} not found or no variants');
      await orderRepository.updateStatus(order.id, OrderStatus.failed);
      return;
    }
    final source = sources.where((s) => s.id == product.sourcePlatformId).firstOrNull;
    final target = targets.where((t) => t.id == order.targetPlatformId).firstOrNull;
    if (source == null || target == null) {
      appLogger.w('Fulfillment: source or target not found');
      await orderRepository.updateStatus(order.id, OrderStatus.failed);
      return;
    }
    final variantId = product.variants.first.id;
    final request = PlaceOrderRequest(
      productId: product.id,
      variantId: variantId,
      quantity: 1,
      customerAddress: order.customerAddress,
      sourcePlatformId: source.id,
    );
    try {
      final result = await source.placeOrder(request);
      await orderRepository.updateStatus(
        order.id,
        OrderStatus.sourceOrderPlaced,
        sourceOrderId: result.sourceOrderId,
        approvedAt: DateTime.now(),
      );
      if (result.trackingNumber != null && result.trackingNumber!.isNotEmpty) {
        await target.updateTracking(order.targetOrderId, result.trackingNumber!);
        await orderRepository.updateStatus(
          order.id,
          OrderStatus.shipped,
          trackingNumber: result.trackingNumber,
        );
      }
    } catch (e, st) {
      appLogger.e('Fulfillment: placeOrder failed', error: e, stackTrace: st);
      await orderRepository.updateStatus(order.id, OrderStatus.failed);
    }
  }

  /// Update tracking on target and in local order.
  Future<void> updateTracking(String orderId, String trackingNumber) async {
    final order = await orderRepository.getByLocalId(orderId);
    if (order == null) return;
    final target = targets.where((t) => t.id == order.targetPlatformId).firstOrNull;
    if (target == null) return;
    await target.updateTracking(order.targetOrderId, trackingNumber);
    await orderRepository.updateStatus(orderId, OrderStatus.shipped, trackingNumber: trackingNumber);
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
