import 'dart:convert';

import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/incident_record_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_reliability_score_repository.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';
import 'package:jurassic_dropshipping/domain/supplier_reliability/supplier_reliability_score.dart';

/// Phase 24: Computes supplier reliability scores from orders and incidents.
class SupplierReliabilityScoringService {
  SupplierReliabilityScoringService({
    required this.orderRepository,
    required this.listingRepository,
    required this.productRepository,
    required this.incidentRecordRepository,
    required this.scoreRepository,
  });

  final OrderRepository orderRepository;
  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final IncidentRecordRepository incidentRecordRepository;
  final SupplierReliabilityScoreRepository scoreRepository;

  /// Incident types that count as "wrong item" or supplier-related failure.
  static const Set<IncidentType> wrongItemTypes = {
    IncidentType.wrongItemSupplier,
    IncidentType.supplierOos,
    IncidentType.itemMissingInParcel,
  };

  /// Evaluates all suppliers that appear in orders since [since] and upserts scores.
  /// Default window: last 90 days.
  Future<int> evaluateAll({Duration window = const Duration(days: 90)}) async {
    final since = DateTime.now().subtract(window);
    final orders = await orderRepository.getCreatedSince(since);
    final incidents = await incidentRecordRepository.getAll();
    final orderIdToSupplierId = <String, String>{};
    final supplierMetrics = <String, SupplierReliabilityMetrics>{};

    for (final order in orders) {
      final listing = await listingRepository.getByLocalId(order.listingId) ??
          await listingRepository.getByTargetListingId(
            order.targetPlatformId,
            order.listingId,
          );
      if (listing == null) continue;
      final product = await productRepository.getByLocalId(listing.productId);
      final supplierId = product?.supplierId;
      if (supplierId == null || supplierId.isEmpty) continue;

      orderIdToSupplierId[order.id] = supplierId;
      supplierMetrics.putIfAbsent(
        supplierId,
        () => const SupplierReliabilityMetrics(),
      );
      final m = supplierMetrics[supplierId]!;
      supplierMetrics[supplierId] = SupplierReliabilityMetrics(
        totalOrders: m.totalOrders + 1,
        cancelledOrFailedCount: m.cancelledOrFailedCount +
            (order.status == OrderStatus.failed ||
                    order.status == OrderStatus.failedOutOfStock ||
                    order.status == OrderStatus.cancelled
                ? 1
                : 0),
        lateShipmentsCount: m.lateShipmentsCount +
            (_isLateDelivery(order) ? 1 : 0),
        wrongItemIncidentsCount: m.wrongItemIncidentsCount,
        averageShippingDays: m.averageShippingDays,
      );
    }

    for (final incident in incidents) {
      if (!wrongItemTypes.contains(incident.incidentType)) continue;
      final supplierId = orderIdToSupplierId[incident.orderId];
      if (supplierId == null) continue;
      final m = supplierMetrics[supplierId];
      if (m == null) continue;
      supplierMetrics[supplierId] = SupplierReliabilityMetrics(
        totalOrders: m.totalOrders,
        cancelledOrFailedCount: m.cancelledOrFailedCount,
        lateShipmentsCount: m.lateShipmentsCount,
        wrongItemIncidentsCount: m.wrongItemIncidentsCount + 1,
        averageShippingDays: m.averageShippingDays,
      );
    }

    var updated = 0;
    for (final entry in supplierMetrics.entries) {
      final supplierId = entry.key;
      final m = entry.value;
      if (m.totalOrders == 0) continue;
      final score = _computeScore(m);
      final metricsJson = jsonEncode({
        'totalOrders': m.totalOrders,
        'cancelledOrFailedCount': m.cancelledOrFailedCount,
        'lateShipmentsCount': m.lateShipmentsCount,
        'wrongItemIncidentsCount': m.wrongItemIncidentsCount,
        if (m.averageShippingDays != null) 'averageShippingDays': m.averageShippingDays,
      });
      try {
        await scoreRepository.upsert(supplierId, score, metricsJson);
        updated++;
      } catch (e, st) {
        appLogger.e('SupplierReliabilityScoring: failed to upsert $supplierId', error: e, stackTrace: st);
      }
    }
    if (updated > 0) {
      appLogger.i('SupplierReliabilityScoring: updated $updated supplier score(s)');
    }
    return updated;
  }

  bool _isLateDelivery(Order order) {
    if (order.deliveredAt == null || order.promisedDeliveryMax == null) return false;
    return order.deliveredAt!.isAfter(order.promisedDeliveryMax!);
  }

  double _computeScore(SupplierReliabilityMetrics m) {
    if (m.totalOrders == 0) return 100;
    final penalty = m.cancellationRate * 25 + m.lateRate * 25 + m.wrongItemRate * 30;
    return (100 - penalty).clamp(0.0, 100.0);
  }
}
