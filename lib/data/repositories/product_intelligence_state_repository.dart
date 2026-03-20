import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

class ProductIntelligenceStateRepository {
  ProductIntelligenceStateRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  Future<ProductIntelligenceStateRow?> getByProductId(String productId) async {
    return (_db.select(_db.productIntelligenceStates)
          ..where((t) => t.tenantId.equals(tenantId) & t.productId.equals(productId))
          ..limit(1))
        .getSingleOrNull();
  }
}

