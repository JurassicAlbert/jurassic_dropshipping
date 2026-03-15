/// Phase 26: Per-listing health metrics (cancellation, late shipment, return/incident rate).
/// Named [ListingHealthRecord] to avoid clash with Drift table class [ListingHealthMetrics].
class ListingHealthRecord {
  const ListingHealthRecord({
    required this.id,
    required this.listingId,
    required this.totalOrders,
    required this.cancelledCount,
    required this.lateCount,
    required this.returnOrIncidentCount,
    required this.lastEvaluatedAt,
  });

  final int id;
  final String listingId;
  final int totalOrders;
  final int cancelledCount;
  final int lateCount;
  final int returnOrIncidentCount;
  final DateTime lastEvaluatedAt;

  double get cancellationRate => totalOrders > 0 ? cancelledCount / totalOrders : 0;
  double get lateRate => totalOrders > 0 ? lateCount / totalOrders : 0;
  double get returnRate => totalOrders > 0 ? returnOrIncidentCount / totalOrders : 0;
}
