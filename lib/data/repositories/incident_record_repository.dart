import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';

/// Repository for incident records (Phase 3). Scoped by [tenantId].
class IncidentRecordRepository {
  IncidentRecordRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static IncidentRecord _rowToRecord(IncidentRecordRow row) {
    return IncidentRecord(
      id: row.id,
      orderId: row.orderId,
      incidentType: IncidentRecord.typeFromString(row.incidentType),
      status: IncidentRecord.statusFromString(row.status),
      trigger: row.trigger,
      automaticDecision: row.automaticDecision,
      supplierInteraction: row.supplierInteraction,
      marketplaceInteraction: row.marketplaceInteraction,
      refundAmount: row.refundAmount,
      financialImpact: row.financialImpact,
      decisionLogId: row.decisionLogId,
      createdAt: row.createdAt,
      resolvedAt: row.resolvedAt,
      attachmentIds: IncidentRecord.attachmentIdsFromJson(row.attachmentIds),
    );
  }

  Future<List<IncidentRecord>> getAll() async {
    final rows = await (_db.select(_db.incidentRecords)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_rowToRecord).toList();
  }

  Future<List<IncidentRecord>> getByOrderId(String orderId) async {
    final rows = await (_db.select(_db.incidentRecords)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.orderId.equals(orderId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_rowToRecord).toList();
  }

  Future<List<IncidentRecord>> getByStatus(IncidentStatus status) async {
    final rows = await (_db.select(_db.incidentRecords)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.status.equals(IncidentRecord.statusToString(status)))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_rowToRecord).toList();
  }

  Future<IncidentRecord?> getById(int id) async {
    final row = await (_db.select(_db.incidentRecords)
          ..where((t) => t.tenantId.equals(tenantId) & t.id.equals(id)))
        .getSingleOrNull();
    return row != null ? _rowToRecord(row) : null;
  }

  Future<int> insert(IncidentRecord record) async {
    return await _db.into(_db.incidentRecords).insert(
      IncidentRecordsCompanion.insert(
        tenantId: Value(tenantId),
        orderId: record.orderId,
        incidentType: IncidentRecord.typeToString(record.incidentType),
        status: IncidentRecord.statusToString(record.status),
        trigger: Value(record.trigger),
        automaticDecision: Value(record.automaticDecision),
        supplierInteraction: Value(record.supplierInteraction),
        marketplaceInteraction: Value(record.marketplaceInteraction),
        refundAmount: Value(record.refundAmount),
        financialImpact: Value(record.financialImpact),
        decisionLogId: Value(record.decisionLogId),
        createdAt: record.createdAt,
        resolvedAt: Value(record.resolvedAt),
        attachmentIds: Value(IncidentRecord.attachmentIdsToJson(record.attachmentIds)),
      ),
    );
  }

  Future<void> update(IncidentRecord record) async {
    await (_db.update(_db.incidentRecords)
          ..where((t) => t.tenantId.equals(tenantId) & t.id.equals(record.id)))
        .write(
      IncidentRecordsCompanion(
        status: Value(IncidentRecord.statusToString(record.status)),
        automaticDecision: Value(record.automaticDecision),
        supplierInteraction: Value(record.supplierInteraction),
        marketplaceInteraction: Value(record.marketplaceInteraction),
        refundAmount: Value(record.refundAmount),
        financialImpact: Value(record.financialImpact),
        decisionLogId: Value(record.decisionLogId),
        resolvedAt: Value(record.resolvedAt),
        attachmentIds: Value(IncidentRecord.attachmentIdsToJson(record.attachmentIds)),
      ),
    );
  }
}
