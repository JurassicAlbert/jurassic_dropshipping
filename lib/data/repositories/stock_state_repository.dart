import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/domain/inventory/stock_state_record.dart';

/// Phase 28: Repository for materialized stock state (fast path for InventoryService).
class StockStateRepository {
  StockStateRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  Future<StockStateRecord?> getByProductAndSupplier(String productId, {String? supplierId}) async {
    final q = _db.select(_db.stockState)
      ..where((t) =>
          t.tenantId.equals(tenantId) &
          t.productId.equals(productId) &
          (supplierId == null ? t.supplierId.isNull() : t.supplierId.equals(supplierId)));
    final row = await q.getSingleOrNull();
    return row != null ? _rowToRecord(row) : null;
  }

  Future<void> upsert({
    required String productId,
    String? supplierId,
    int? supplierStock,
    required int returnedStock,
    required int reservedStock,
    required int availableStock,
  }) async {
    final now = DateTime.now();
    final existing = await (_db.select(_db.stockState)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.productId.equals(productId) &
              (supplierId == null ? t.supplierId.isNull() : t.supplierId.equals(supplierId))))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.stockState)
            ..where((t) => t.id.equals(existing.id)))
          .write(StockStateCompanion(
        supplierStock: Value(supplierStock),
        returnedStock: Value(returnedStock),
        reservedStock: Value(reservedStock),
        availableStock: Value(availableStock),
        lastUpdatedAt: Value(now),
      ));
    } else {
      await _db.into(_db.stockState).insert(
            StockStateCompanion.insert(
              tenantId: Value(tenantId),
              productId: productId,
              supplierId: Value(supplierId),
              supplierStock: Value(supplierStock),
              returnedStock: Value(returnedStock),
              reservedStock: Value(reservedStock),
              availableStock: Value(availableStock),
              lastUpdatedAt: now,
            ),
          );
    }
  }

  static StockStateRecord _rowToRecord(StockStateRow row) {
    return StockStateRecord(
      id: row.id,
      productId: row.productId,
      supplierId: row.supplierId,
      supplierStock: row.supplierStock,
      returnedStock: row.returnedStock,
      reservedStock: row.reservedStock,
      availableStock: row.availableStock,
      lastUpdatedAt: row.lastUpdatedAt,
    );
  }
}
