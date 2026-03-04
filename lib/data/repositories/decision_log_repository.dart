import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/decision_log.dart';

/// Repository for decision audit log (why a product/order/supplier was chosen).
class DecisionLogRepository {
  DecisionLogRepository(this._db);
  final AppDatabase _db;

  static DecisionLogType _typeFromString(String s) {
    return DecisionLogType.values.firstWhere(
      (e) => e.name == s,
      orElse: () => DecisionLogType.listing,
    );
  }

  static DecisionLog _rowToLog(DecisionLogRow row) {
    return DecisionLog(
      id: row.localId,
      type: _typeFromString(row.type),
      entityId: row.entityId,
      reason: row.reason,
      criteriaSnapshot: row.criteriaSnapshot != null
          ? jsonDecode(row.criteriaSnapshot!) as Map<String, dynamic>
          : null,
      createdAt: row.createdAt,
    );
  }

  Future<List<DecisionLog>> getAll({int? limit}) async {
    var query = _db.select(_db.decisionLogs)..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    if (limit != null) query = query..limit(limit);
    final rows = await query.get();
    return rows.map(_rowToLog).toList();
  }

  Future<List<DecisionLog>> getByType(DecisionLogType type) async {
    final rows = await (_db.select(_db.decisionLogs)..where((t) => t.type.equals(type.name))).get();
    return rows.map(_rowToLog).toList();
  }

  Future<DecisionLog?> getByLocalId(String localId) async {
    final row = await (_db.select(_db.decisionLogs)..where((t) => t.localId.equals(localId))).getSingleOrNull();
    return row != null ? _rowToLog(row) : null;
  }

  Future<String> insert(DecisionLog log) async {
    final id = log.id;
    await _db.into(_db.decisionLogs).insert(
      DecisionLogsCompanion.insert(
        localId: id,
        type: log.type.name,
        entityId: log.entityId,
        reason: log.reason,
        criteriaSnapshot: Value(log.criteriaSnapshot != null ? jsonEncode(log.criteriaSnapshot) : null),
        createdAt: log.createdAt,
      ),
    );
    return id;
  }
}
