import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

/// Template for notifying customer when they cancel after product was already sent.
const String cancelAfterShippedMessageTemplate =
    'Your cancellation was registered. The product has already been sent; '
    'please return it to the address we provide. We will refund you according to '
    'marketplace rules once we receive the return.';

/// Handles cancelling orders on target and source when customer cancels or we cannot fulfill.
class OrderCancellationService {
  OrderCancellationService({
    required this.orderRepository,
    required this.listingRepository,
    required this.productRepository,
    required this.returnRepository,
    required this.targets,
    required this.sources,
  });

  final OrderRepository orderRepository;
  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final ReturnRepository returnRepository;
  final List<TargetPlatform> targets;
  final List<SourcePlatform> sources;

  /// Cancel order on marketplace (target) and optionally at source.
  /// When [updateLocalStatus] is true (default), sets local status to cancelled after target cancel succeeds.
  /// Returns true if target cancel succeeded (or there was no target); false if target cancel failed.
  Future<bool> cancelOrder(Order order, {bool updateLocalStatus = true}) async {
    final target = targets.where((t) => t.id == order.targetPlatformId).firstOrNull;
    if (target != null) {
      try {
        await target.cancelOrder(order.targetOrderId);
      } catch (e, st) {
        appLogger.e('OrderCancellation: target cancel failed', error: e, stackTrace: st);
        return false;
      }
    }
    if (order.sourceOrderId != null && order.sourceOrderId!.isNotEmpty) {
      final source = await _getSourceForOrder(order);
      if (source != null) {
        try {
          await source.cancelOrder(order.sourceOrderId!);
        } catch (e, st) {
          appLogger.e('OrderCancellation: source cancel failed', error: e, stackTrace: st);
        }
      }
    }
    if (updateLocalStatus) {
      await orderRepository.updateStatus(order.id, OrderStatus.cancelled);
    }
    return true;
  }

  /// Sync status from target: if order is cancelled on marketplace, update local and try to cancel at source.
  Future<void> syncOrderStatusFromTarget(Order order) async {
    final target = targets.where((t) => t.id == order.targetPlatformId).firstOrNull;
    if (target == null) return;
    OrderStatus? status;
    try {
      status = await target.getOrderStatus(order.targetOrderId);
    } catch (e, st) {
      appLogger.e('OrderCancellation: getOrderStatus failed', error: e, stackTrace: st);
      return;
    }
    if (status == OrderStatus.cancelled) {
      final alreadyShipped = order.status == OrderStatus.shipped || order.status == OrderStatus.delivered;
      if (alreadyShipped) {
        await _createReturnRequestForCancelAfterShipped(order);
      } else if (order.sourceOrderId != null && order.sourceOrderId!.isNotEmpty) {
        final source = await _getSourceForOrder(order);
        if (source != null) {
          try {
            await source.cancelOrder(order.sourceOrderId!);
          } catch (_) {}
        }
      }
      await orderRepository.updateStatus(order.id, OrderStatus.cancelled);
    }
  }

  /// When customer cancels but we already shipped: create a return request so seller can track and refund after return.
  Future<void> _createReturnRequestForCancelAfterShipped(Order order) async {
    final existing = await returnRepository.getByOrderId(order.id);
    if (existing.isNotEmpty) return;
    final returnId = 'ret_cancel_${order.id}_${DateTime.now().millisecondsSinceEpoch}';
    final req = ReturnRequest(
      id: returnId,
      orderId: order.id,
      reason: ReturnReason.other,
      status: ReturnStatus.requested,
      notes: 'Customer cancelled after shipment; request return for refund.',
      requestedAt: DateTime.now(),
      targetPlatformId: order.targetPlatformId,
      returnDestination: ReturnDestination.toSupplier,
    );
    await returnRepository.insert(req);
    appLogger.i('OrderCancellation: created return request $returnId for order ${order.id} (cancel after shipped)');
  }

  Future<SourcePlatform?> _getSourceForOrder(Order order) async {
    final listing = await listingRepository.getByLocalId(order.listingId) ??
        await listingRepository.getByTargetListingId(order.targetPlatformId, order.listingId);
    if (listing == null) return null;
    final product = await productRepository.getByLocalId(listing.productId);
    if (product == null) return null;
    return sources.where((s) => s.id == product.sourcePlatformId).firstOrNull;
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
