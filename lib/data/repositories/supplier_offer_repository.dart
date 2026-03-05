import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';

class SupplierOfferRepository {
  SupplierOfferRepository(this._db);
  final AppDatabase _db;

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
    final rows = await _db.select(_db.supplierOffers).get();
    return rows.map(_rowToOffer).toList();
  }

  Future<List<SupplierOffer>> getByProductId(String productId) async {
    final rows = await (_db.select(_db.supplierOffers)
          ..where((t) => t.productId.equals(productId)))
        .get();
    return rows.map(_rowToOffer).toList();
  }

  Future<List<SupplierOffer>> getBySupplierId(String supplierId) async {
    final rows = await (_db.select(_db.supplierOffers)
          ..where((t) => t.supplierId.equals(supplierId)))
        .get();
    return rows.map(_rowToOffer).toList();
  }

  Future<SupplierOffer?> getById(String offerId) async {
    final row = await (_db.select(_db.supplierOffers)
          ..where((t) => t.offerId.equals(offerId)))
        .getSingleOrNull();
    return row != null ? _rowToOffer(row) : null;
  }

  Future<void> upsert(SupplierOffer offer) async {
    final existing = await (_db.select(_db.supplierOffers)
          ..where((t) => t.offerId.equals(offer.id)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.supplierOffers)
            ..where((t) => t.offerId.equals(offer.id)))
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
          ..where((t) => t.offerId.equals(offerId)))
        .go();
  }

  Future<List<SupplierOffer>> getStaleOffers(Duration staleDuration) async {
    final cutoff = DateTime.now().subtract(staleDuration);
    final rows = await (_db.select(_db.supplierOffers)
          ..where((t) =>
              t.lastPriceRefreshAt.isNull() |
              t.lastPriceRefreshAt.isSmallerThanValue(cutoff)))
        .get();
    return rows.map(_rowToOffer).toList();
  }
}
