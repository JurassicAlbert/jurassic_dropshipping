import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/domain/customer_abuse/customer_abuse_scoring_service.dart';
import 'package:jurassic_dropshipping/domain/observability/observability_metrics.dart';
import 'package:jurassic_dropshipping/domain/risk/order_risk_scoring_service.dart';
import 'package:jurassic_dropshipping/services/order_cancellation_service.dart';

/// Polls target platforms for new orders and persists them (with optional pending approval).
/// Also syncs status from targets to detect customer cancellations.
/// When [orderRiskScoringService] is set and [UserRules.riskScoreThreshold] is set, new orders are scored and set to pendingApproval if score > threshold (Phase 16).
/// Phase 25: when [customerAbuseScoringService] is set and customer return/complaint rate exceeds rules thresholds, new orders are set to pendingApproval.
/// Phase 32: when [observabilityMetrics] is set, records orders synced.
class OrderSyncService {
  OrderSyncService({
    required this.orderRepository,
    required this.rulesRepository,
    required this.targets,
    required this.orderCancellationService,
    this.orderRiskScoringService,
    this.customerAbuseScoringService,
    this.observabilityMetrics,
  });

  final OrderRepository orderRepository;
  final RulesRepository rulesRepository;
  final List<TargetPlatform> targets;
  final OrderCancellationService orderCancellationService;
  final OrderRiskScoringService? orderRiskScoringService;
  final CustomerAbuseScoringService? customerAbuseScoringService;
  final ObservabilityMetrics? observabilityMetrics;

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
          final existingByLocal = await orderRepository.getByLocalId(order.id);
          if (existingByLocal != null) continue;
          final existingByTargetLine = await orderRepository.getByTargetOrderIdAndListingId(
            target.id,
            order.targetOrderId,
            order.listingId,
          );
          if (existingByTargetLine != null) continue;
          final status = rules.manualApprovalOrders
              ? OrderStatus.pendingApproval
              : OrderStatus.pending;
          final toInsert = order.copyWith(
            status: status,
            createdAt: order.createdAt ?? DateTime.now(),
          );
          await orderRepository.insert(toInsert);
          added++;

          // Phase 16: risk scoring – if threshold set and score > threshold, set pendingApproval.
          final scorer = orderRiskScoringService;
          final threshold = rules.riskScoreThreshold;
          if (scorer != null && threshold != null) {
            try {
              final result = scorer.evaluate(toInsert);
              final setPending = result.score > threshold;
              await orderRepository.updateRiskScore(
                toInsert.id,
                result.score,
                result.factorsJson,
                setPendingApproval: setPending,
              );
            } catch (e, st) {
              appLogger.e('Order risk scoring failed for ${toInsert.id}', error: e, stackTrace: st);
            }
          }
          // Phase 25: customer abuse – if customer return/complaint rate exceeds threshold, set pendingApproval.
          final abuseService = customerAbuseScoringService;
          if (abuseService != null) {
            try {
              final customerId = CustomerAbuseScoringService.customerIdFromOrder(toInsert);
              final requireApproval = await abuseService.shouldRequireApproval(customerId, rules);
              if (requireApproval) {
                await orderRepository.updateStatus(toInsert.id, OrderStatus.pendingApproval);
                appLogger.i('OrderSync: order ${toInsert.id} set to pendingApproval (customer abuse: $customerId)');
              }
            } catch (e, st) {
              appLogger.e('OrderSync: customer abuse check failed for ${toInsert.id}', error: e, stackTrace: st);
            }
          }
        }
      } catch (e, st) {
        appLogger.e('OrderSync ${target.id} failed', error: e, stackTrace: st);
      }
    }
    await _syncCancelledOrders();
    if (added > 0) observabilityMetrics?.recordOrdersSynced(added);
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
