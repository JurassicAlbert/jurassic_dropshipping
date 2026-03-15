/// Phase 24: Supplier reliability metrics and score (0–100).
class SupplierReliabilityScore {
  const SupplierReliabilityScore({
    required this.id,
    required this.supplierId,
    required this.score,
    required this.metricsJson,
    required this.lastEvaluatedAt,
  });

  final int id;
  final String supplierId;
  final double score;
  final String metricsJson;
  final DateTime lastEvaluatedAt;
}

/// Metrics used to compute the score (stored as JSON).
class SupplierReliabilityMetrics {
  const SupplierReliabilityMetrics({
    this.totalOrders = 0,
    this.cancelledOrFailedCount = 0,
    this.lateShipmentsCount = 0,
    this.wrongItemIncidentsCount = 0,
    this.averageShippingDays,
  });

  final int totalOrders;
  final int cancelledOrFailedCount;
  final int lateShipmentsCount;
  final int wrongItemIncidentsCount;
  final double? averageShippingDays;

  double get cancellationRate => totalOrders > 0 ? cancelledOrFailedCount / totalOrders : 0;
  double get lateRate => totalOrders > 0 ? lateShipmentsCount / totalOrders : 0;
  double get wrongItemRate => totalOrders > 0 ? wrongItemIncidentsCount / totalOrders : 0;
}
