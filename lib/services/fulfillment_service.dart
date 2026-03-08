import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/app_error.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/order_cancellation_service.dart';

/// Places source orders and updates tracking on target.
class FulfillmentService {
  FulfillmentService({
    required this.orderRepository,
    required this.listingRepository,
    required this.productRepository,
    required this.sources,
    required this.targets,
    required this.orderCancellationService,
  });

  final OrderRepository orderRepository;
  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final List<SourcePlatform> sources;
  final List<TargetPlatform> targets;
  final OrderCancellationService orderCancellationService;

  /// Whether [error] likely indicates out-of-stock or inventory at the source.
  ///
  /// Used to decide if we should set [OrderStatus.failedOutOfStock] and cancel on target.
  /// Considers: [ApiError] (e.g. CJ) message; [DioException] response body code/message;
  /// generic error string. Sources with explicit handling: CJ via [ApiError]. Others
  /// rely on response body and message heuristics (may false-positive or false-negative).
  static bool isLikelyOutOfStock(Object error, [StackTrace? stackTrace]) {
    if (error is ApiError) {
      final msg = (error.detail ?? '').toLowerCase();
      if (_messageIndicatesOOS(msg)) return true;
      return false;
    }
    final msg = error.toString().toLowerCase();
    if (_messageIndicatesOOS(msg)) return true;
    if (error is DioException && error.response?.data != null) {
      final data = error.response!.data;
      if (data is Map) {
        final body = data as Map<String, dynamic>;
        final code = body['code']?.toString() ?? body['errorCode']?.toString() ?? '';
        final message = (body['message'] ?? body['msg'] ?? body['error'] ?? '').toString().toLowerCase();
        if (code.toLowerCase().contains('stock') || code.toLowerCase().contains('inventory') || _messageIndicatesOOS(message)) {
          return true;
        }
      }
    }
    return false;
  }

  static bool _messageIndicatesOOS(String msg) {
    return msg.contains('out of stock') ||
        msg.contains('outofstock') ||
        msg.contains('insufficient stock') ||
        (msg.contains('stock') && (msg.contains('not available') || msg.contains('unavailable'))) ||
        (msg.contains('inventory') && msg.contains('0')) ||
        msg.contains('product unavailable') ||
        msg.contains('sold out');
  }

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
    const quantity = 1;
    final variantId = product.variants.first.id;
    final request = PlaceOrderRequest(
      productId: product.id,
      variantId: variantId,
      quantity: quantity,
      customerAddress: order.customerAddress,
      sourcePlatformId: source.id,
    );

    // Pre-check: refresh product from source; if variant is out of stock, cancel order and do not place.
    // - We use the same variant (variantId) as in PlaceOrderRequest when reading stock.
    // - If source does not expose stock or getProduct returns null/empty: skip pre-check and call placeOrder;
    //   rely on existing handling when placeOrder throws.
    // - If getProduct fails or times out: skip pre-check and try placeOrder (avoid blocking on transient API errors).
    try {
      final freshProduct = await source.getProduct(product.sourceId);
      if (freshProduct != null && freshProduct.variants.isNotEmpty) {
        final variant = freshProduct.variants.where((v) => v.id == variantId).firstOrNull
            ?? freshProduct.variants.first;
        if (variant.stock < quantity) {
          appLogger.w('Fulfillment: pre-check failed - variant $variantId out of stock (${variant.stock})');
          await orderRepository.updateStatus(order.id, OrderStatus.failedOutOfStock);
          try {
            await orderCancellationService.cancelOrder(order, updateLocalStatus: false);
          } catch (cancelErr, cancelSt) {
            appLogger.e('Fulfillment: cancel after out-of-stock failed', error: cancelErr, stackTrace: cancelSt);
          }
          return;
        }
      }
    } catch (e, st) {
      appLogger.d('Fulfillment: pre-check getProduct failed, proceeding to placeOrder', error: e, stackTrace: st);
    }

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
      final outOfStock = isLikelyOutOfStock(e, st);
      if (outOfStock) {
        await orderRepository.updateStatus(order.id, OrderStatus.failedOutOfStock);
        try {
          await orderCancellationService.cancelOrder(order, updateLocalStatus: false);
        } catch (cancelErr, cancelSt) {
          appLogger.e('Fulfillment: cancel after out-of-stock failed', error: cancelErr, stackTrace: cancelSt);
        }
      } else {
        await orderRepository.updateStatus(order.id, OrderStatus.failed);
      }
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
