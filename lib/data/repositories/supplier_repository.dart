import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';

class SupplierRepository {
  SupplierRepository(this._db);
  final AppDatabase _db;

  static Supplier _rowToSupplier(SupplierRow row) {
    return Supplier(
      id: row.supplierId,
      name: row.name,
      platformType: row.platformType,
      countryCode: row.countryCode,
      rating: row.rating,
      returnWindowDays: row.returnWindowDays,
      returnShippingCost: row.returnShippingCost,
      restockingFeePercent: row.restockingFeePercent,
      acceptsNoReasonReturns: row.acceptsNoReasonReturns,
      warehouseAddress: row.warehouseAddress,
      warehouseCity: row.warehouseCity,
      warehouseZip: row.warehouseZip,
      warehouseCountry: row.warehouseCountry,
      warehousePhone: row.warehousePhone,
      warehouseEmail: row.warehouseEmail,
      feedSource: row.feedSource,
      shopUrl: row.shopUrl,
    );
  }

  Future<List<Supplier>> getAll() async {
    final rows = await _db.select(_db.suppliers).get();
    return rows.map(_rowToSupplier).toList();
  }

  Future<Supplier?> getById(String supplierId) async {
    final row = await (_db.select(_db.suppliers)
          ..where((t) => t.supplierId.equals(supplierId)))
        .getSingleOrNull();
    return row != null ? _rowToSupplier(row) : null;
  }

  Future<void> upsert(Supplier supplier) async {
    final existing = await (_db.select(_db.suppliers)
          ..where((t) => t.supplierId.equals(supplier.id)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.suppliers)
            ..where((t) => t.supplierId.equals(supplier.id)))
          .write(SuppliersCompanion(
        name: Value(supplier.name),
        platformType: Value(supplier.platformType),
        countryCode: Value(supplier.countryCode),
        rating: Value(supplier.rating),
        returnWindowDays: Value(supplier.returnWindowDays),
        returnShippingCost: Value(supplier.returnShippingCost),
        restockingFeePercent: Value(supplier.restockingFeePercent),
        acceptsNoReasonReturns: Value(supplier.acceptsNoReasonReturns),
        warehouseAddress: Value(supplier.warehouseAddress),
        warehouseCity: Value(supplier.warehouseCity),
        warehouseZip: Value(supplier.warehouseZip),
        warehouseCountry: Value(supplier.warehouseCountry),
        warehousePhone: Value(supplier.warehousePhone),
        warehouseEmail: Value(supplier.warehouseEmail),
        feedSource: Value(supplier.feedSource),
        shopUrl: Value(supplier.shopUrl),
      ));
    } else {
      await _db.into(_db.suppliers).insert(SuppliersCompanion.insert(
        supplierId: supplier.id,
        name: supplier.name,
        platformType: supplier.platformType,
        countryCode: Value(supplier.countryCode),
        rating: Value(supplier.rating),
        returnWindowDays: Value(supplier.returnWindowDays),
        returnShippingCost: Value(supplier.returnShippingCost),
        restockingFeePercent: Value(supplier.restockingFeePercent),
        acceptsNoReasonReturns: Value(supplier.acceptsNoReasonReturns),
        warehouseAddress: Value(supplier.warehouseAddress),
        warehouseCity: Value(supplier.warehouseCity),
        warehouseZip: Value(supplier.warehouseZip),
        warehouseCountry: Value(supplier.warehouseCountry),
        warehousePhone: Value(supplier.warehousePhone),
        warehouseEmail: Value(supplier.warehouseEmail),
        feedSource: Value(supplier.feedSource),
        shopUrl: Value(supplier.shopUrl),
      ));
    }
  }

  Future<void> delete(String supplierId) async {
    await (_db.delete(_db.suppliers)
          ..where((t) => t.supplierId.equals(supplierId)))
        .go();
  }
}
