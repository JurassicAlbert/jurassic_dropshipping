import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/order_cancellation_service.dart';

/// Polls target platforms for new orders and persists them (with optional pending approval).
/// Also syncs status from targets to detect customer cancellations.
class OrderSyncService {
  OrderSyncService({
    required this.orderRepository,
    required this.rulesRepository,
    required this.targets,
    required this.orderCancellationService,
  });

  final OrderRepository orderRepository;
  final RulesRepository rulesRepository;
  final List<TargetPlatform> targets;
  final OrderCancellationService orderCancellationService;

  static const int _maxStatusSyncPerRun = 20;

  /// Fetch orders from all targets since [since], insert new ones, and sync status for existing orders.
  /// If manual approval is ON, new orders get status [OrderStatus.pendingApproval].
  Future<int> syncOrders(DateTime since) async {
    var added = 0;
    final rules = await rulesRepository.get();
    for (final target in targets) {
      if (!(await target.isConfigured())) continue;
      try {
        final orders = await target.getOrders(since);
        for (final order in orders) {
          final existing = await orderRepository.getByLocalId(order.id);
          if (existing != null) continue;
          final status = rules.manualApprovalOrders
              ? OrderStatus.pendingApproval
              : OrderStatus.pending;
          final toInsert = order.copyWith(
            status: status,
            createdAt: order.createdAt ?? DateTime.now(),
          );
          await orderRepository.insert(toInsert);
          added++;
        }
      } catch (e, st) {
        appLogger.e('OrderSync ${target.id} failed', error: e, stackTrace: st);
      }
    }
    await _syncCancelledOrders();
    return added;
  }

  /// Check existing pending/sourceOrderPlaced orders against target; if cancelled, update local and cancel at source.
  Future<void> _syncCancelledOrders() async {
    final all = await orderRepository.getAll();
    final toCheck = all
        .where((o) =>
            o.status == OrderStatus.pending ||
            o.status == OrderStatus.pendingApproval ||
            o.status == OrderStatus.sourceOrderPlaced)
        .take(_maxStatusSyncPerRun)
        .toList();
    for (final order in toCheck) {
      final target = targets.where((t) => t.id == order.targetPlatformId).firstOrNull;
      if (target == null || !(await target.isConfigured())) continue;
      await orderCancellationService.syncOrderStatusFromTarget(order);
    }
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
