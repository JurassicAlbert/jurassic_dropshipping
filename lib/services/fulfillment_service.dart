import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/app_error.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/returned_stock_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/domain/capital/capital_management_service.dart';
import 'package:jurassic_dropshipping/domain/inventory/inventory_service.dart';
import 'package:jurassic_dropshipping/domain/observability/observability_metrics.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/distributed_lock_service.dart';
import 'package:jurassic_dropshipping/services/order_cancellation_service.dart';
import 'package:jurassic_dropshipping/services/resilient_source_platform.dart';

/// Sentinel sourceOrderId when order was fulfilled from returned stock (Phase 5).
const String kSourceOrderIdFromReturnedStock = 'returned_stock';

/// Places source orders and updates tracking on target.
class FulfillmentService {
  FulfillmentService({
    required this.orderRepository,
    required this.listingRepository,
    required this.productRepository,
    required this.decisionLogRepository,
    required this.sources,
    required this.targets,
    required this.orderCancellationService,
    this.returnedStockRepository,
    this.distributedLockService,
    this.capitalManagementService,
    this.inventoryService,
    this.rulesRepository,
    this.observabilityMetrics,
  });

  final OrderRepository orderRepository;
  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final DecisionLogRepository decisionLogRepository;
  final List<SourcePlatform> sources;
  final List<TargetPlatform> targets;
  final OrderCancellationService orderCancellationService;
  /// When set, fulfillment may use returned stock before placing supplier order (Phase 5).
  final ReturnedStockRepository? returnedStockRepository;
  /// When set, acquires a distributed lock per order so multiple workers cannot double-fulfill (Phase B3).
  final DistributedLockService? distributedLockService;
  /// Phase 14: when set, checks available capital before placing supplier order; queues order if insufficient.
  final CapitalManagementService? capitalManagementService;
  /// Phase 18: when set, logs a warning if unified available-to-sell is below order quantity (no block by default).
  final InventoryService? inventoryService;
  /// When set, used with [blockFulfillWhenInsufficientStock] to skip fulfillment when availableToSell < quantity.
  final RulesRepository? rulesRepository;
  /// Phase 32: when set, records fulfillment success/failure for observability.
  final ObservabilityMetrics? observabilityMetrics;

  /// CJ Dropshipping API error codes that indicate out-of-stock / inventory (CJ docs Appendix 1).
  /// 1602002 = Product removed from shelves, 1602003 = Variant removed from shelves,
  /// 1603102 = Inventory deduction fail.
  static const Set<int> _cjOosErrorCodes = {1602002, 1602003, 1603102};

  /// Whether [error] likely indicates out-of-stock or inventory at the source.
  ///
  /// Used to decide if we should set [OrderStatus.failedOutOfStock] and cancel on target.
  /// **Source-specific (confident):** CJ – [ApiError] with statusCode in [_cjOosErrorCodes].
  /// **Heuristics:** [ApiError].detail and [DioException] body message/code; generic string.
  /// When [strictMode] is true, only returns true for known CJ codes; use to avoid cancelling
  /// on non-OOS when message heuristics are ambiguous.
  static bool isLikelyOutOfStock(Object error, [StackTrace? stackTrace, bool strictMode = false]) {
    if (error is ApiError) {
      if (_cjOosErrorCodes.contains(error.statusCode)) return true;
      if (strictMode) return false;
      final msg = (error.detail ?? '').toLowerCase();
      return _messageIndicatesOOS(msg);
    }
    if (strictMode) return false;
    final msg = error.toString().toLowerCase();
    if (_messageIndicatesOOS(msg)) return true;
    if (error is DioException && error.response?.data != null) {
      final data = error.response!.data;
      if (data is Map) {
        final body = data as Map<String, dynamic>;
        final codeRaw = body['code'];
        final codeInt = codeRaw is int ? codeRaw : int.tryParse(codeRaw?.toString() ?? '');
        if (codeInt != null && _cjOosErrorCodes.contains(codeInt)) return true;
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
  /// Idempotent: if [order] already has [sourceOrderId] set, skips placeOrder (no duplicate source orders).
  Future<void> fulfillOrder(Order order) async {
    if (order.sourceOrderId != null && order.sourceOrderId!.isNotEmpty) {
      appLogger.d('Fulfillment: order ${order.id} already has sourceOrderId ${order.sourceOrderId}, skipping (idempotent)');
      return;
    }
    if (distributedLockService != null) {
      final key = DistributedLockService.fulfillOrderLockKey(order.id);
      final acquired = await distributedLockService!.acquire(key, const Duration(minutes: 5));
      if (!acquired) {
        appLogger.d('Fulfillment: order ${order.id} lock not acquired, skipping (another worker may be fulfilling)');
        return;
      }
      try {
        await _fulfillOrderImpl(order);
      } finally {
        await distributedLockService!.release(key);
      }
      return;
    }
    await _fulfillOrderImpl(order);
  }

  Future<void> _fulfillOrderImpl(Order order) async {
    final listing = await listingRepository.getByLocalId(order.listingId) ??
        await listingRepository.getByTargetListingId(order.targetPlatformId, order.listingId);
    if (listing == null) {
      appLogger.w('Fulfillment: listing ${order.listingId} not found');
      await orderRepository.updateStatus(order.id, OrderStatus.failed);
      await _logMappingFailure(
        order: order,
        reason: 'Listing not found for order ${order.id}',
        details: {
          'orderId': order.id,
          'listingId': order.listingId,
          'targetPlatformId': order.targetPlatformId,
          'failureType': 'listing_not_found',
        },
      );
      return;
    }
    final product = await productRepository.getByLocalId(listing.productId);
    if (product == null || product.variants.isEmpty) {
      appLogger.w('Fulfillment: product ${listing.productId} not found or no variants');
      await orderRepository.updateStatus(order.id, OrderStatus.failed);
       await _logMappingFailure(
        order: order,
        reason: 'Product not found or has no variants for listing ${listing.id}',
        details: {
          'orderId': order.id,
          'listingId': listing.id,
          'productId': listing.productId,
          'failureType': 'product_not_found_or_no_variants',
        },
      );
      return;
    }
    final source = sources.where((s) => s.id == product.sourcePlatformId).firstOrNull;
    final target = targets.where((t) => t.id == order.targetPlatformId).firstOrNull;
    if (source == null || target == null) {
      appLogger.w('Fulfillment: source or target not found');
      await orderRepository.updateStatus(order.id, OrderStatus.failed);
      await _logMappingFailure(
        order: order,
        reason: 'Source or target platform not found',
        details: {
          'orderId': order.id,
          'listingId': listing.id,
          'productId': listing.productId,
          'sourcePlatformId': product.sourcePlatformId,
          'targetPlatformId': order.targetPlatformId,
          'failureType': 'platform_not_found',
        },
      );
      return;
    }
    final quantity = order.quantity;

    // Phase 18: optional inventory check — log warning or skip when available-to-sell is below order quantity.
    // Phase 19: apply safetyStockBuffer from rules when computing availableToSell.
    if (inventoryService != null) {
      try {
        final buffer = rulesRepository != null ? (await rulesRepository!.get()).safetyStockBuffer : 0;
        final snapshot = await inventoryService!.availableToSell(
          listing.productId,
          order.listingId,
          supplierId: product.supplierId,
          safetyStockBuffer: buffer > 0 ? buffer : null,
        );
        if (snapshot.availableToSell < quantity) {
          final block = rulesRepository != null &&
              (await rulesRepository!.get()).blockFulfillWhenInsufficientStock;
          if (block) {
            appLogger.w(
              'Fulfillment: skipped — insufficient stock (availableToSell ${snapshot.availableToSell} < $quantity); '
              'order ${order.id} remains unfulfilled (rule: blockFulfillWhenInsufficientStock)',
            );
            return;
          }
          appLogger.w(
            'Fulfillment: inventory check — availableToSell ${snapshot.availableToSell} < order quantity $quantity '
            '(product ${listing.productId}, order ${order.id}); reserved=${snapshot.reservedStock}, returned=${snapshot.returnedStock}',
          );
        }
      } catch (e, st) {
        appLogger.d('Fulfillment: inventory check failed (proceeding)', error: e, stackTrace: st);
      }
    }

    // Phase 5: fulfill from returned stock if available (no supplier call).
    if (returnedStockRepository != null) {
      final available = await returnedStockRepository!.getAvailableQuantity(
        listing.productId,
        supplierId: product.supplierId,
      );
      if (available >= quantity) {
        final consumed = await returnedStockRepository!.consumeForFulfillment(
          listing.productId,
          quantity,
          supplierId: product.supplierId,
        );
        if (consumed) {
          appLogger.d('Fulfillment: order ${order.id} fulfilled from returned stock');
          await orderRepository.updateStatus(
            order.id,
            OrderStatus.sourceOrderPlaced,
            sourceOrderId: '${kSourceOrderIdFromReturnedStock}_${DateTime.now().millisecondsSinceEpoch}',
            approvedAt: DateTime.now(),
          );
          return;
        }
      }
    }

    // Phase 14: capital check before placing supplier order (skip when fulfilling from returned stock).
    if (capitalManagementService != null) {
      final canFulfill = await capitalManagementService!.canFulfillOrder(order.sourceCost);
      if (!canFulfill) {
        appLogger.d('Fulfillment: order ${order.id} queued for capital (insufficient balance)');
        await orderRepository.setQueuedForCapital(order.id, true);
        return;
      }
      await orderRepository.setQueuedForCapital(order.id, false);
    }

    final variantId = listing.variantId ?? product.variants.first.id;
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
          await _logMappingFailure(
            order: order,
            reason: 'Pre-check: variant $variantId out of stock at source',
            details: {
              'orderId': order.id,
              'listingId': listing.id,
              'productId': listing.productId,
              'variantId': variantId,
              'availableStock': variant.stock,
              'requestedQuantity': quantity,
              'failureType': 'precheck_out_of_stock',
            },
          );
          try {
            await orderCancellationService.cancelOrder(order, updateLocalStatus: false);
          } catch (cancelErr, cancelSt) {
            appLogger.e('Fulfillment: cancel after out-of-stock failed', error: cancelErr, stackTrace: cancelSt);
          }
          observabilityMetrics?.recordFulfillmentFailed();
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
      await capitalManagementService?.recordSupplierPaid(
        order.id,
        order.sourceCost,
        referenceId: result.sourceOrderId,
      );
      if (result.trackingNumber != null && result.trackingNumber!.isNotEmpty) {
        await target.updateTracking(order.targetOrderId, result.trackingNumber!);
        await orderRepository.updateStatus(
          order.id,
          OrderStatus.shipped,
          trackingNumber: result.trackingNumber,
        );
      }
      observabilityMetrics?.recordFulfillmentSuccess();
    } catch (e, st) {
      if (e is CircuitOpenException) {
        appLogger.w('Fulfillment: circuit open for ${e.sourceId}, order ${order.id} not fulfilled this run (will retry when circuit closes)');
        observabilityMetrics?.recordFulfillmentFailed();
        return;
      }
      observabilityMetrics?.recordFulfillmentFailed();
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
        await _logMappingFailure(
          order: order,
          reason: 'Place order failed for order ${order.id}: $e',
          details: {
            'orderId': order.id,
            'listingId': listing.id,
            'productId': listing.productId,
            'sourcePlatformId': product.sourcePlatformId,
            'targetPlatformId': order.targetPlatformId,
            'failureType': 'place_order_error',
          },
        );
      }
    }
  }

  Future<void> _logMappingFailure({
    required Order order,
    required String reason,
    Map<String, dynamic>? details,
  }) async {
    try {
      final logId = 'order_${order.id}_${DateTime.now().millisecondsSinceEpoch}';
      await decisionLogRepository.insert(DecisionLog(
        id: logId,
        type: DecisionLogType.order,
        entityId: order.id,
        reason: reason,
        criteriaSnapshot: details,
        createdAt: DateTime.now(),
      ));
      await orderRepository.attachDecisionLog(order.id, logId);
    } catch (e, st) {
      appLogger.e('Fulfillment: failed to write decision log for mapping failure', error: e, stackTrace: st);
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
