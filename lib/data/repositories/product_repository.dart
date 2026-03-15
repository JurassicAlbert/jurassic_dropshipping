import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';

/// Repository for cached/sourced products. Maps between DB rows and domain [Product].
/// All reads/writes are scoped by [tenantId].
class ProductRepository {
  ProductRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static Product _rowToProduct(ProductRow row) {
    final imageUrls = (jsonDecode(row.imageUrls) as List<dynamic>)
        .map((e) => e as String)
        .toList();
    final variantsList = jsonDecode(row.variantsJson) as List<dynamic>?;
    final variants = (variantsList ?? [])
        .map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
        .toList();
    return Product(
      id: row.localId,
      sourceId: row.sourceId,
      sourcePlatformId: row.sourcePlatformId,
      title: row.title,
      description: row.description,
      imageUrls: imageUrls,
      variants: variants,
      basePrice: row.basePrice,
      shippingCost: row.shippingCost,
      currency: row.currency,
      supplierId: row.supplierId,
      supplierCountry: row.supplierCountry,
      estimatedDays: row.estimatedDays,
      rawJson: row.rawJson != null ? jsonDecode(row.rawJson!) as Map<String, dynamic> : null,
    );
  }

  Future<List<Product>> getAll() async {
    final rows = await (_db.select(_db.products)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();
    return rows.map(_rowToProduct).toList();
  }

  Future<Product?> getByLocalId(String localId) async {
    final row = await (_db.select(_db.products)
          ..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId)))
        .getSingleOrNull();
    return row != null ? _rowToProduct(row) : null;
  }

  Future<Product?> getBySourceId(String sourcePlatformId, String sourceId) async {
    final row = await (_db.select(_db.products)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.sourcePlatformId.equals(sourcePlatformId) &
              t.sourceId.equals(sourceId)))
        .getSingleOrNull();
    return row != null ? _rowToProduct(row) : null;
  }

  Future<void> upsert(Product product) async {
    await deleteByLocalId(product.id);
    await _db.into(_db.products).insert(
      ProductsCompanion.insert(
        tenantId: Value(tenantId),
        localId: product.id,
        sourceId: product.sourceId,
        sourcePlatformId: product.sourcePlatformId,
        title: product.title,
        description: Value(product.description),
        imageUrls: jsonEncode(product.imageUrls),
        variantsJson: jsonEncode(product.variants.map((v) => v.toJson()).toList()),
        basePrice: product.basePrice,
        shippingCost: Value(product.shippingCost),
        currency: Value(product.currency),
        supplierId: Value(product.supplierId),
        supplierCountry: Value(product.supplierCountry),
        estimatedDays: Value(product.estimatedDays),
        rawJson: Value(product.rawJson != null ? jsonEncode(product.rawJson) : null),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> deleteByLocalId(String localId) async {
    await (_db.delete(_db.products)
          ..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId)))
        .go();
  }
}
