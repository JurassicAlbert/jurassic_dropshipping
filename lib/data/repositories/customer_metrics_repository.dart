import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/domain/customer_abuse/customer_metrics.dart';

/// Phase 25: Repository for customer abuse metrics (return/complaint/refund rate per customer).
class CustomerMetricsRepository {
  CustomerMetricsRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  Future<CustomerMetricsRecord?> getByCustomerId(String customerId) async {
    final row = await (_db.select(_db.customerMetrics)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.customerId.equals(customerId)))
        .getSingleOrNull();
    return row != null ? _rowToRecord(row) : null;
  }

  Future<List<CustomerMetricsRecord>> getAll() async {
    final rows = await (_db.select(_db.customerMetrics)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.windowEnd)]))
        .get();
    return rows.map(_rowToRecord).toList();
  }

  Future<void> upsert(
    String customerId,
    double returnRate,
    double complaintRate,
    double refundRate,
    int orderCount,
    DateTime windowEnd,
  ) async {
    final existing = await (_db.select(_db.customerMetrics)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.customerId.equals(customerId)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.customerMetrics)
            ..where((t) =>
                t.tenantId.equals(tenantId) & t.customerId.equals(customerId)))
          .write(CustomerMetricsCompanion(
        returnRate: Value(returnRate),
        complaintRate: Value(complaintRate),
        refundRate: Value(refundRate),
        orderCount: Value(orderCount),
        windowEnd: Value(windowEnd),
      ));
    } else {
      await _db.into(_db.customerMetrics).insert(
            CustomerMetricsCompanion.insert(
              tenantId: tenantId,
              customerId: customerId,
              returnRate: returnRate,
              complaintRate: complaintRate,
              refundRate: refundRate,
              orderCount: orderCount,
              windowEnd: windowEnd,
            ),
          );
    }
  }

  static CustomerMetricsRecord _rowToRecord(CustomerMetricsRow row) {
    return CustomerMetricsRecord(
      id: row.id,
      customerId: row.customerId,
      returnRate: row.returnRate,
      complaintRate: row.complaintRate,
      refundRate: row.refundRate,
      orderCount: row.orderCount,
      windowEnd: row.windowEnd,
    );
  }
}
