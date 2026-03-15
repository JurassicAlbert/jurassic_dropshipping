import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';

class SupplierOfferRepository {
  SupplierOfferRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static SupplierOffer _rowToOffer(SupplierOfferRow row) {
    return SupplierOffer(
      id: row.offerId,
      productId: row.productId,
      supplierId: row.supplierId,
      sourcePlatformId: row.sourcePlatformId,
      cost: row.cost,
      shippingCost: row.shippingCost,
      minEstimatedDays: row.minEstimatedDays,
      maxEstimatedDays: row.maxEstimatedDays,
      carrierCode: row.carrierCode,
      shippingMethodName: row.shippingMethodName,
      lastPriceRefreshAt: row.lastPriceRefreshAt,
      lastStockRefreshAt: row.lastStockRefreshAt,
    );
  }

  Future<List<SupplierOffer>> getAll() async {
    final rows = await (_db.select(_db.supplierOffers)..where((t) => t.tenantId.equals(tenantId))).get();
    return rows.map(_rowToOffer).toList();
  }

  Future<List<SupplierOffer>> getByProductId(String productId) async {
    final rows = await (_db.select(_db.supplierOffers)
          ..where((t) => t.tenantId.equals(tenantId) & t.productId.equals(productId)))
        .get();
    return rows.map(_rowToOffer).toList();
  }

  Future<List<SupplierOffer>> getBySupplierId(String supplierId) async {
    final rows = await (_db.select(_db.supplierOffers)
          ..where((t) => t.tenantId.equals(tenantId) & t.supplierId.equals(supplierId)))
        .get();
    return rows.map(_rowToOffer).toList();
  }

  Future<SupplierOffer?> getById(String offerId) async {
    final row = await (_db.select(_db.supplierOffers)
          ..where((t) => t.tenantId.equals(tenantId) & t.offerId.equals(offerId)))
        .getSingleOrNull();
    return row != null ? _rowToOffer(row) : null;
  }

  Future<void> upsert(SupplierOffer offer) async {
    final existing = await (_db.select(_db.supplierOffers)
          ..where((t) => t.tenantId.equals(tenantId) & t.offerId.equals(offer.id)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.supplierOffers)
            ..where((t) => t.tenantId.equals(tenantId) & t.offerId.equals(offer.id)))
          .write(SupplierOffersCompanion(
        productId: Value(offer.productId),
        supplierId: Value(offer.supplierId),
        sourcePlatformId: Value(offer.sourcePlatformId),
        cost: Value(offer.cost),
        shippingCost: Value(offer.shippingCost),
        minEstimatedDays: Value(offer.minEstimatedDays),
        maxEstimatedDays: Value(offer.maxEstimatedDays),
        carrierCode: Value(offer.carrierCode),
        shippingMethodName: Value(offer.shippingMethodName),
        lastPriceRefreshAt: Value(offer.lastPriceRefreshAt),
        lastStockRefreshAt: Value(offer.lastStockRefreshAt),
      ));
    } else {
      await _db.into(_db.supplierOffers).insert(SupplierOffersCompanion.insert(
        tenantId: Value(tenantId),
        offerId: offer.id,
        productId: offer.productId,
        supplierId: offer.supplierId,
        sourcePlatformId: offer.sourcePlatformId,
        cost: offer.cost,
        shippingCost: Value(offer.shippingCost),
        minEstimatedDays: Value(offer.minEstimatedDays),
        maxEstimatedDays: Value(offer.maxEstimatedDays),
        carrierCode: Value(offer.carrierCode),
        shippingMethodName: Value(offer.shippingMethodName),
        lastPriceRefreshAt: Value(offer.lastPriceRefreshAt),
        lastStockRefreshAt: Value(offer.lastStockRefreshAt),
      ));
    }
  }

  Future<void> delete(String offerId) async {
    await (_db.delete(_db.supplierOffers)
          ..where((t) => t.tenantId.equals(tenantId) & t.offerId.equals(offerId)))
        .go();
  }

  Future<List<SupplierOffer>> getStaleOffers(Duration staleDuration) async {
    final cutoff = DateTime.now().subtract(staleDuration);
    final rows = await (_db.select(_db.supplierOffers)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              (t.lastPriceRefreshAt.isNull() |
                  t.lastPriceRefreshAt.isSmallerThanValue(cutoff))))
        .get();
    return rows.map(_rowToOffer).toList();
  }

  /// Stale offers for a single source (warehouse). Used when each warehouse has its own refresh cadence (e.g. 1–2×/day).
  Future<List<SupplierOffer>> getStaleOffersForSource(
    String sourcePlatformId,
    Duration staleDuration,
  ) async {
    final cutoff = DateTime.now().subtract(staleDuration);
    final rows = await (_db.select(_db.supplierOffers)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.sourcePlatformId.equals(sourcePlatformId) &
              (t.lastPriceRefreshAt.isNull() |
                  t.lastPriceRefreshAt.isSmallerThanValue(cutoff))))
        .get();
    return rows.map(_rowToOffer).toList();
  }
}
