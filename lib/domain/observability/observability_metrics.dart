/// Phase 32: Lightweight operational metrics for observability (counters, optional rate).
/// Instrument services add data; snapshot can be logged or exposed for alerting/capacity planning.
class ObservabilityMetrics {
  ObservabilityMetrics();

  int _ordersSyncedTotal = 0;
  DateTime? _ordersSyncedMinuteStart;
  int _ordersSyncedLastMinute = 0;

  int _fulfillmentSuccessTotal = 0;
  int _fulfillmentFailedTotal = 0;

  int _listingUpdatesEnqueuedTotal = 0;
  int _listingUpdatesProcessedTotal = 0;

  int _supplierApiSuccessTotal = 0;
  int _supplierApiFailedTotal = 0;

  int _jobsProcessedTotal = 0;
  int _jobsFailedTotal = 0;

  void recordOrdersSynced(int count) {
    if (count <= 0) return;
    _ordersSyncedTotal += count;
    final now = DateTime.now();
    final minuteStart = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    if (_ordersSyncedMinuteStart == minuteStart) {
      _ordersSyncedLastMinute += count;
    } else {
      _ordersSyncedMinuteStart = minuteStart;
      _ordersSyncedLastMinute = count;
    }
  }

  void recordFulfillmentSuccess() {
    _fulfillmentSuccessTotal++;
  }

  void recordFulfillmentFailed() {
    _fulfillmentFailedTotal++;
  }

  void recordListingUpdatesEnqueued(int count) {
    _listingUpdatesEnqueuedTotal += count;
  }

  void recordListingUpdateProcessed() {
    _listingUpdatesProcessedTotal++;
  }

  void recordSupplierApiSuccess() {
    _supplierApiSuccessTotal++;
  }

  void recordSupplierApiFailed() {
    _supplierApiFailedTotal++;
  }

  void recordJobProcessed() {
    _jobsProcessedTotal++;
  }

  void recordJobFailed() {
    _jobsFailedTotal++;
  }

  /// Snapshot for logging or metrics endpoint. Keys are stable for parsing.
  ObservabilitySnapshot getSnapshot() {
    return ObservabilitySnapshot(
      ordersSyncedTotal: _ordersSyncedTotal,
      ordersSyncedLastMinute: _ordersSyncedLastMinute,
      fulfillmentSuccessTotal: _fulfillmentSuccessTotal,
      fulfillmentFailedTotal: _fulfillmentFailedTotal,
      listingUpdatesEnqueuedTotal: _listingUpdatesEnqueuedTotal,
      listingUpdatesProcessedTotal: _listingUpdatesProcessedTotal,
      supplierApiSuccessTotal: _supplierApiSuccessTotal,
      supplierApiFailedTotal: _supplierApiFailedTotal,
      jobsProcessedTotal: _jobsProcessedTotal,
      jobsFailedTotal: _jobsFailedTotal,
      at: DateTime.now(),
    );
  }

  /// One-line summary for logs.
  String toLogLine() {
    final s = getSnapshot();
    return 'Observability: orders/min=${s.ordersSyncedLastMinute} orders_total=${s.ordersSyncedTotal} '
        'fulfill_ok=${s.fulfillmentSuccessTotal} fulfill_fail=${s.fulfillmentFailedTotal} '
        'listing_enqueued=${s.listingUpdatesEnqueuedTotal} listing_processed=${s.listingUpdatesProcessedTotal} '
        'supplier_ok=${s.supplierApiSuccessTotal} supplier_fail=${s.supplierApiFailedTotal} '
        'jobs_ok=${s.jobsProcessedTotal} jobs_fail=${s.jobsFailedTotal}';
  }
}

/// Immutable snapshot of current metrics (Phase 32).
class ObservabilitySnapshot {
  const ObservabilitySnapshot({
    required this.ordersSyncedTotal,
    required this.ordersSyncedLastMinute,
    required this.fulfillmentSuccessTotal,
    required this.fulfillmentFailedTotal,
    required this.listingUpdatesEnqueuedTotal,
    required this.listingUpdatesProcessedTotal,
    required this.supplierApiSuccessTotal,
    required this.supplierApiFailedTotal,
    required this.jobsProcessedTotal,
    required this.jobsFailedTotal,
    required this.at,
  });

  final int ordersSyncedTotal;
  final int ordersSyncedLastMinute;
  final int fulfillmentSuccessTotal;
  final int fulfillmentFailedTotal;
  final int listingUpdatesEnqueuedTotal;
  final int listingUpdatesProcessedTotal;
  final int supplierApiSuccessTotal;
  final int supplierApiFailedTotal;
  final int jobsProcessedTotal;
  final int jobsFailedTotal;
  final DateTime at;
}
