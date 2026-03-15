import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/incident_record_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_health_metrics_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';

/// Phase 26: Computes per-listing health metrics and optionally pauses listings when thresholds exceeded.
class ListingHealthScoringService {
  ListingHealthScoringService({
    required this.orderRepository,
    required this.listingRepository,
    required this.incidentRecordRepository,
    required this.returnRepository,
    required this.metricsRepository,
    required this.rulesRepository,
  });

  final OrderRepository orderRepository;
  final ListingRepository listingRepository;
  final IncidentRecordRepository incidentRecordRepository;
  final ReturnRepository returnRepository;
  final ListingHealthMetricsRepository metricsRepository;
  final RulesRepository rulesRepository;

  /// Evaluates all listings that have orders since [window] and upserts metrics.
  /// If rules enable auto-pause and return/late rate exceed thresholds, pauses listing.
  Future<int> evaluateAll({Duration window = const Duration(days: 90)}) async {
    final since = DateTime.now().subtract(window);
    final orders = await orderRepository.getCreatedSince(since);
    final incidents = await incidentRecordRepository.getAll();
    final returns = await returnRepository.getAll();

    final orderIdToListingId = <String, String>{};
    final listingCounts = <String, ({int total, int cancelled, int late, int returnOrIncident})>{};
    for (final order in orders) {
      orderIdToListingId[order.id] = order.listingId;
      final listingId = order.listingId;
      listingCounts.putIfAbsent(
        listingId,
        () => (total: 0, cancelled: 0, late: 0, returnOrIncident: 0),
      );
      final c = listingCounts[listingId]!;
      listingCounts[listingId] = (
        total: c.total + 1,
        cancelled: c.cancelled +
            (order.status == OrderStatus.failed ||
                    order.status == OrderStatus.failedOutOfStock ||
                    order.status == OrderStatus.cancelled
                ? 1
                : 0),
        late: c.late + (_isLateDelivery(order) ? 1 : 0),
        returnOrIncident: c.returnOrIncident,
      );
    }
    for (final incident in incidents) {
      final listingId = orderIdToListingId[incident.orderId];
      if (listingId == null || !listingCounts.containsKey(listingId)) continue;
      final cur = listingCounts[listingId]!;
      listingCounts[listingId] = (total: cur.total, cancelled: cur.cancelled, late: cur.late, returnOrIncident: cur.returnOrIncident + 1);
    }
    for (final r in returns) {
      final listingId = orderIdToListingId[r.orderId];
      if (listingId == null || !listingCounts.containsKey(listingId)) continue;
      final cur = listingCounts[listingId]!;
      listingCounts[listingId] = (total: cur.total, cancelled: cur.cancelled, late: cur.late, returnOrIncident: cur.returnOrIncident + 1);
    }

    final rules = await rulesRepository.get();
    var updated = 0;
    for (final entry in listingCounts.entries) {
      final listingId = entry.key;
      final c = entry.value;
      if (c.total == 0) continue;
      try {
        await metricsRepository.upsert(listingId, c.total, c.cancelled, c.late, c.returnOrIncident);
        updated++;
        // Phase 26 optional auto-pause: if rules enable it and rates exceed thresholds, pause active listing
        if (rules.autoPauseListingWhenHealthPoor) {
          final returnRatePercent = c.total > 0 ? (c.returnOrIncident / c.total * 100) : 0.0;
          final lateRatePercent = c.total > 0 ? (c.late / c.total * 100) : 0.0;
          final overReturn = rules.listingHealthMaxReturnRatePercent != null &&
              returnRatePercent > rules.listingHealthMaxReturnRatePercent!;
          final overLate = rules.listingHealthMaxLateRatePercent != null &&
              lateRatePercent > rules.listingHealthMaxLateRatePercent!;
          if (overReturn || overLate) {
            final listing = await listingRepository.getByLocalId(listingId);
            if (listing != null && listing.status == ListingStatus.active) {
              await listingRepository.updateStatus(listingId, ListingStatus.paused);
              appLogger.i(
                'ListingHealthScoring: paused listing $listingId (return ${returnRatePercent.toStringAsFixed(1)}%, late ${lateRatePercent.toStringAsFixed(1)}%)',
              );
            }
          }
        }
      } catch (e, st) {
        appLogger.e('ListingHealthScoring: failed to upsert $listingId', error: e, stackTrace: st);
      }
    }
    if (updated > 0) {
      appLogger.i('ListingHealthScoring: updated $updated listing health metric(s)');
    }
    return updated;
  }

  bool _isLateDelivery(Order order) {
    if (order.deliveredAt == null || order.promisedDeliveryMax == null) return false;
    return order.deliveredAt!.isAfter(order.promisedDeliveryMax!);
  }
}