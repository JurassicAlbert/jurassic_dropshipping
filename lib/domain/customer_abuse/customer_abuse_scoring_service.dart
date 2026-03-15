import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/customer_metrics_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/incident_record_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Phase 25: Computes per-customer abuse metrics (return/complaint/refund rate) and supports approval gating.
class CustomerAbuseScoringService {
  CustomerAbuseScoringService({
    required this.orderRepository,
    required this.returnRepository,
    required this.incidentRecordRepository,
    required this.metricsRepository,
    required this.rulesRepository,
  });

  final OrderRepository orderRepository;
  final ReturnRepository returnRepository;
  final IncidentRecordRepository incidentRecordRepository;
  final CustomerMetricsRepository metricsRepository;
  final RulesRepository rulesRepository;

  /// Derives a stable customer id from an order (platform + email or phone).
  static String customerIdFromOrder(Order order) {
    final email = order.customerAddress.email?.trim().toLowerCase();
    final phone = order.customerAddress.phone.trim().toLowerCase();
    final key = email ?? phone;
    return '${order.targetPlatformId}:${key.isEmpty ? 'unknown' : key}';
  }

  /// Evaluates all customers with orders since [window] and upserts metrics.
  Future<int> evaluateAll({Duration window = const Duration(days: 90)}) async {
    final since = DateTime.now().subtract(window);
    final orders = await orderRepository.getCreatedSince(since);
    final returns = await returnRepository.getAll();
    final incidents = await incidentRecordRepository.getAll();

    final orderIdToCustomerId = <String, String>{};
    final customerOrderCount = <String, int>{};
    for (final order in orders) {
      final cid = customerIdFromOrder(order);
      orderIdToCustomerId[order.id] = cid;
      customerOrderCount[cid] = (customerOrderCount[cid] ?? 0) + 1;
    }

    final customerReturnCount = <String, int>{};
    for (final r in returns) {
      final cid = orderIdToCustomerId[r.orderId];
      if (cid == null || !customerOrderCount.containsKey(cid)) continue;
      customerReturnCount[cid] = (customerReturnCount[cid] ?? 0) + 1;
    }

    final customerIncidentCount = <String, int>{};
    final customerRefundCount = <String, int>{};
    for (final inc in incidents) {
      final cid = orderIdToCustomerId[inc.orderId];
      if (cid == null || !customerOrderCount.containsKey(cid)) continue;
      customerIncidentCount[cid] = (customerIncidentCount[cid] ?? 0) + 1;
      if ((inc.refundAmount ?? 0) > 0) {
        customerRefundCount[cid] = (customerRefundCount[cid] ?? 0) + 1;
      }
    }
    for (final r in returns) {
      if ((r.refundAmount ?? 0) <= 0) continue;
      final cid = orderIdToCustomerId[r.orderId];
      if (cid == null) continue;
      customerRefundCount[cid] = (customerRefundCount[cid] ?? 0) + 1;
    }

    final windowEnd = DateTime.now();
    var updated = 0;
    for (final entry in customerOrderCount.entries) {
      final customerId = entry.key;
      final orderCount = entry.value;
      if (orderCount == 0) continue;
      final returnCount = customerReturnCount[customerId] ?? 0;
      final incidentCount = customerIncidentCount[customerId] ?? 0;
      final refundCount = customerRefundCount[customerId] ?? 0;
      final returnRate = returnCount / orderCount;
      final complaintRate = incidentCount / orderCount;
      final refundRate = refundCount / orderCount;
      try {
        await metricsRepository.upsert(
          customerId,
          returnRate,
          complaintRate,
          refundRate,
          orderCount,
          windowEnd,
        );
        updated++;
      } catch (e, st) {
        appLogger.e('CustomerAbuseScoring: failed to upsert $customerId', error: e, stackTrace: st);
      }
    }
    if (updated > 0) {
      appLogger.i('CustomerAbuseScoring: updated $updated customer metric(s)');
    }
    return updated;
  }

  /// Returns true if this customer's metrics exceed rules thresholds and should require manual approval.
  Future<bool> shouldRequireApproval(String customerId, UserRules rules) async {
    if (rules.customerAbuseMaxReturnRatePercent == null &&
        rules.customerAbuseMaxComplaintRatePercent == null) {
      return false;
    }
    final metrics = await metricsRepository.getByCustomerId(customerId);
    if (metrics == null) return false;
    if (rules.customerAbuseMaxReturnRatePercent != null &&
        metrics.returnRate * 100 > rules.customerAbuseMaxReturnRatePercent!) {
      return true;
    }
    if (rules.customerAbuseMaxComplaintRatePercent != null &&
        metrics.complaintRate * 100 > rules.customerAbuseMaxComplaintRatePercent!) {
      return true;
    }
    return false;
  }
}
