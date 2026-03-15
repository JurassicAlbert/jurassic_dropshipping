import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/domain/listing_health/listing_health_metrics.dart';

/// Phase 26: Repository for listing health metrics.
class ListingHealthMetricsRepository {
  ListingHealthMetricsRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static ListingHealthRecord _rowToRecord(ListingHealthMetricsRow row) {
    return ListingHealthRecord(
      id: row.id,
      listingId: row.listingId,
      totalOrders: row.totalOrders,
      cancelledCount: row.cancelledCount,
      lateCount: row.lateCount,
      returnOrIncidentCount: row.returnOrIncidentCount,
      lastEvaluatedAt: row.lastEvaluatedAt,
    );
  }

  Future<ListingHealthRecord?> getByListingId(String listingId) async {
    final row = await (_db.select(_db.listingHealthMetrics)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.listingId.equals(listingId)))
        .getSingleOrNull();
    return row != null ? _rowToRecord(row) : null;
  }

  Future<List<ListingHealthRecord>> getAll() async {
    final rows = await (_db.select(_db.listingHealthMetrics)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.lastEvaluatedAt)]))
        .get();
    return rows.map(_rowToRecord).toList();
  }

  Future<void> upsert(
    String listingId,
    int totalOrders,
    int cancelledCount,
    int lateCount,
    int returnOrIncidentCount,
  ) async {
    final now = DateTime.now();
    final existing = await (_db.select(_db.listingHealthMetrics)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.listingId.equals(listingId)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.listingHealthMetrics)
            ..where((t) =>
                t.tenantId.equals(tenantId) & t.listingId.equals(listingId)))
          .write(ListingHealthMetricsCompanion(
        totalOrders: Value(totalOrders),
        cancelledCount: Value(cancelledCount),
        lateCount: Value(lateCount),
        returnOrIncidentCount: Value(returnOrIncidentCount),
        lastEvaluatedAt: Value(now),
      ));
    } else {
      await _db.into(_db.listingHealthMetrics).insert(
            ListingHealthMetricsCompanion.insert(
              tenantId: Value(tenantId),
              listingId: listingId,
              totalOrders: totalOrders,
              cancelledCount: cancelledCount,
              lateCount: lateCount,
              returnOrIncidentCount: returnOrIncidentCount,
              lastEvaluatedAt: now,
            ),
          );
    }
  }
}
