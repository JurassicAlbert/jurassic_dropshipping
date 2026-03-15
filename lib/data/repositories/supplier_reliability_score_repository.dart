import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/domain/supplier_reliability/supplier_reliability_score.dart';

/// Phase 24: Repository for supplier reliability scores.
class SupplierReliabilityScoreRepository {
  SupplierReliabilityScoreRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static SupplierReliabilityScore _rowToScore(SupplierReliabilityScoreRow row) {
    return SupplierReliabilityScore(
      id: row.id,
      supplierId: row.supplierId,
      score: row.score,
      metricsJson: row.metricsJson,
      lastEvaluatedAt: row.lastEvaluatedAt,
    );
  }

  Future<SupplierReliabilityScore?> getBySupplierId(String supplierId) async {
    final row = await (_db.select(_db.supplierReliabilityScores)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.supplierId.equals(supplierId)))
        .getSingleOrNull();
    return row != null ? _rowToScore(row) : null;
  }

  Future<List<SupplierReliabilityScore>> getAll() async {
    final rows = await (_db.select(_db.supplierReliabilityScores)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.score)]))
        .get();
    return rows.map(_rowToScore).toList();
  }

  Future<void> upsert(String supplierId, double score, String metricsJson) async {
    final existing = await (_db.select(_db.supplierReliabilityScores)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.supplierId.equals(supplierId)))
        .getSingleOrNull();
    final now = DateTime.now();
    if (existing != null) {
      await (_db.update(_db.supplierReliabilityScores)
            ..where((t) =>
                t.tenantId.equals(tenantId) & t.supplierId.equals(supplierId)))
          .write(SupplierReliabilityScoresCompanion(
        score: Value(score),
        metricsJson: Value(metricsJson),
        lastEvaluatedAt: Value(now),
      ));
    } else {
      await _db.into(_db.supplierReliabilityScores).insert(
            SupplierReliabilityScoresCompanion.insert(
              tenantId: Value(tenantId),
              supplierId: supplierId,
              score: score,
              metricsJson: Value(metricsJson),
              lastEvaluatedAt: now,
            ),
          );
    }
  }
}
