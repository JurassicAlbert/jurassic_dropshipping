import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';

/// Post-order lifecycle engine (Phase 1). Validates and applies [OrderLifecycleState] transitions.
class PostOrderLifecycleEngine {
  PostOrderLifecycleEngine(this._orderRepository);
  final OrderRepository _orderRepository;

  /// Parses stored [lifecycleState] string to enum. Returns null if null or unknown.
  static OrderLifecycleState? lifecycleStateFromString(String? lifecycleState) {
    if (lifecycleState == null || lifecycleState.isEmpty) return null;
    for (final e in OrderLifecycleState.values) {
      if (e.name == lifecycleState) return e;
    }
    return null;
  }

  /// Current lifecycle state of [order]; null if not set.
  static OrderLifecycleState? currentState(Order order) {
    return lifecycleStateFromString(order.lifecycleState);
  }

  /// Whether transitioning from [from] to [to] is allowed. When [from] is null (no state set),
  /// only allows setting to a state that can be used as initial (e.g. from backfill).
  bool canTransition(OrderLifecycleState? from, OrderLifecycleState to) {
    if (from == null) {
      // Backfill / initial set: allow any state (caller should derive from status/returns).
      return true;
    }
    if (from == to) return true;

    // Allowed transitions (plan: delivered → returnRequested → returnApproved → returned → refunded; etc.)
    const allowed = <OrderLifecycleState, List<OrderLifecycleState>>{
      OrderLifecycleState.created: [
        OrderLifecycleState.pendingApproval,
        OrderLifecycleState.cancelled,
        OrderLifecycleState.failed,
      ],
      OrderLifecycleState.pendingApproval: [
        OrderLifecycleState.approved,
        OrderLifecycleState.cancelled,
      ],
      OrderLifecycleState.approved: [
        OrderLifecycleState.sentToSupplier,
        OrderLifecycleState.cancelled,
      ],
      OrderLifecycleState.sentToSupplier: [
        OrderLifecycleState.shipped,
        OrderLifecycleState.failed,
      ],
      OrderLifecycleState.shipped: [
        OrderLifecycleState.delivered,
        OrderLifecycleState.returnRequested,
        OrderLifecycleState.failed,
      ],
      OrderLifecycleState.delivered: [
        OrderLifecycleState.returnRequested,
        OrderLifecycleState.complaintOpened,
        OrderLifecycleState.refunded,
      ],
      OrderLifecycleState.returnRequested: [
        OrderLifecycleState.returnApproved,
        OrderLifecycleState.refunded,
        OrderLifecycleState.cancelled,
      ],
      OrderLifecycleState.returnApproved: [
        OrderLifecycleState.returned,
        OrderLifecycleState.refunded,
      ],
      OrderLifecycleState.returned: [
        OrderLifecycleState.refunded,
      ],
      OrderLifecycleState.complaintOpened: [
        OrderLifecycleState.refunded,
        OrderLifecycleState.returnRequested,
      ],
      OrderLifecycleState.refunded: [], // terminal
      OrderLifecycleState.failed: [],   // terminal
      OrderLifecycleState.cancelled: [], // terminal
    };

    final next = allowed[from];
    return next != null && next.contains(to);
  }

  /// Applies transition to [toState]. Returns true if updated; false if transition not allowed.
  Future<bool> transition(Order order, OrderLifecycleState toState) async {
    final from = currentState(order);
    if (!canTransition(from, toState)) return false;
    await _orderRepository.updateLifecycleState(order.id, toState.name);
    return true;
  }

  /// Derives a suggested lifecycle state from [order] and optional [returnsForOrder].
  /// Use for backfill when [order.lifecycleState] is null.
  static OrderLifecycleState deriveLifecycleState(
    Order order,
    List<ReturnRequest> returnsForOrder,
  ) {
    // If there are return requests, derive from latest return status.
    if (returnsForOrder.isNotEmpty) {
      final latest = returnsForOrder.first; // assume ordered by requestedAt desc
      switch (latest.status) {
        case ReturnStatus.requested:
          return OrderLifecycleState.returnRequested;
        case ReturnStatus.approved:
        case ReturnStatus.shipped:
          return OrderLifecycleState.returnApproved;
        case ReturnStatus.received:
          return OrderLifecycleState.returned;
        case ReturnStatus.refunded:
          return OrderLifecycleState.refunded;
        case ReturnStatus.rejected:
          return OrderLifecycleState.delivered;
      }
    }

    // From order status.
    switch (order.status) {
      case OrderStatus.pending:
        return OrderLifecycleState.created;
      case OrderStatus.pendingApproval:
        return OrderLifecycleState.pendingApproval;
      case OrderStatus.sourceOrderPlaced:
        return OrderLifecycleState.sentToSupplier;
      case OrderStatus.shipped:
        return OrderLifecycleState.shipped;
      case OrderStatus.delivered:
        return OrderLifecycleState.delivered;
      case OrderStatus.failed:
      case OrderStatus.failedOutOfStock:
        return OrderLifecycleState.failed;
      case OrderStatus.cancelled:
        return OrderLifecycleState.cancelled;
    }
  }

  /// Backfills [order] lifecycle state if null, using [returnsForOrder] and status. Returns true if updated.
  Future<bool> backfillIfNeeded(
    Order order,
    List<ReturnRequest> returnsForOrder,
  ) async {
    if (order.lifecycleState != null && order.lifecycleState!.isNotEmpty) {
      return false;
    }
    final derived = deriveLifecycleState(order, returnsForOrder);
    await _orderRepository.updateLifecycleState(order.id, derived.name);
    return true;
  }
}
