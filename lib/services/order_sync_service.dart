import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';

/// Polls target platforms for new orders and persists them (with optional pending approval).
class OrderSyncService {
  OrderSyncService({
    required this.orderRepository,
    required this.rulesRepository,
    required this.targets,
  });

  final OrderRepository orderRepository;
  final RulesRepository rulesRepository;
  final List<TargetPlatform> targets;

  /// Fetch orders from all targets since [since] and insert new ones.
  /// If manual approval is ON, new orders get status [OrderStatus.pendingApproval].
  Future<int> syncOrders(DateTime since) async {
    var added = 0;
    final rules = await rulesRepository.get();
    for (final target in targets) {
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
    return added;
  }
}
