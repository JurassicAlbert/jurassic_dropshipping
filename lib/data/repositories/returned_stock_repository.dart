import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/domain/post_order/returned_stock.dart';

/// Repository for returned stock (Phase 5). Scoped by [tenantId].
class ReturnedStockRepository {
  ReturnedStockRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static ReturnedStock _rowToStock(ReturnedStockRow row) {
    return ReturnedStock(
      id: row.id,
      productId: row.productId,
      supplierId: row.supplierId,
      condition: row.condition,
      quantity: row.quantity,
      restockable: row.restockable,
      sourceOrderId: row.sourceOrderId,
      sourceReturnId: row.sourceReturnId,
      createdAt: row.createdAt,
    );
  }

  Future<List<ReturnedStock>> getAll() async {
    final rows = await (_db.select(_db.returnedStocks)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_rowToStock).toList();
  }

  Future<List<ReturnedStock>> getByProductId(String productId) async {
    final rows = await (_db.select(_db.returnedStocks)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.productId.equals(productId)))
        .get();
    return rows.map(_rowToStock).toList();
  }

  Future<List<ReturnedStock>> getByProductAndSupplier(
    String productId,
    String supplierId,
  ) async {
    final rows = await (_db.select(_db.returnedStocks)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.productId.equals(productId) &
              t.supplierId.equals(supplierId)))
        .get();
    return rows.map(_rowToStock).toList();
  }

  /// Sum of restockable quantity for a product (optionally for a supplier).
  Future<int> getAvailableQuantity(String productId, {String? supplierId}) async {
    final rows = await (_db.select(_db.returnedStocks)
          ..where((t) {
            var e = t.tenantId.equals(tenantId) &
                t.productId.equals(productId) &
                t.restockable.equals(true);
            if (supplierId != null) {
              e = e & t.supplierId.equals(supplierId);
            }
            return e;
          }))
        .get();
    return rows.fold<int>(0, (s, r) => s + r.quantity);
  }

  Future<int> insert(ReturnedStock stock) async {
    return await _db.into(_db.returnedStocks).insert(
      ReturnedStocksCompanion.insert(
        tenantId: Value(tenantId),
        productId: stock.productId,
        supplierId: stock.supplierId,
        condition: Value(stock.condition),
        quantity: stock.quantity,
        restockable: Value(stock.restockable),
        sourceOrderId: Value(stock.sourceOrderId),
        sourceReturnId: Value(stock.sourceReturnId),
        createdAt: stock.createdAt,
      ),
    );
  }

  /// Mark row as not restockable (write-off). No longer used for fulfillment.
  Future<void> updateRestockable(int id, bool restockable) async {
    await (_db.update(_db.returnedStocks)
          ..where((t) => t.tenantId.equals(tenantId) & t.id.equals(id)))
        .write(ReturnedStocksCompanion(restockable: Value(restockable)));
  }

  /// Decrement quantity (e.g. when fulfilling from returned stock). Returns true if updated.
  Future<bool> decrementQuantity(int id, int amount) async {
    final row = await (_db.select(_db.returnedStocks)
          ..where((t) => t.tenantId.equals(tenantId) & t.id.equals(id)))
        .getSingleOrNull();
    if (row == null || row.quantity < amount) return false;
    final newQty = row.quantity - amount;
    await (_db.update(_db.returnedStocks)
          ..where((t) => t.tenantId.equals(tenantId) & t.id.equals(id)))
        .write(ReturnedStocksCompanion(quantity: Value(newQty)));
    return true;
  }

  /// Consume [quantity] from restockable rows for [productId] (FIFO). Returns true if full quantity was consumed.
  Future<bool> consumeForFulfillment(String productId, int quantity, {String? supplierId}) async {
    final rows = await (_db.select(_db.returnedStocks)
          ..where((t) {
            var e = t.tenantId.equals(tenantId) &
                t.productId.equals(productId) &
                t.restockable.equals(true);
            if (supplierId != null) e = e & t.supplierId.equals(supplierId);
            return e;
          })
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
    var remaining = quantity;
    for (final row in rows) {
      if (remaining <= 0) break;
      final take = remaining < row.quantity ? remaining : row.quantity;
      await decrementQuantity(row.id, take);
      remaining -= take;
    }
    return remaining == 0;
  }
}
