/// Phase 25: Per-customer abuse metrics over a time window (return, complaint, refund rate).
class CustomerMetricsRecord {
  const CustomerMetricsRecord({
    required this.id,
    required this.customerId,
    required this.returnRate,
    required this.complaintRate,
    required this.refundRate,
    required this.orderCount,
    required this.windowEnd,
  });

  final int id;
  final String customerId;
  /// Return rate 0.0–1.0 (returns / orderCount).
  final double returnRate;
  /// Complaint rate 0.0–1.0 (incidents / orderCount).
  final double complaintRate;
  /// Refund rate 0.0–1.0 (orders with refund / orderCount).
  final double refundRate;
  final int orderCount;
  final DateTime windowEnd;
}
