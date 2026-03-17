import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

/// Phase 37: repository for ProductGroups and ProductGroupMembers. Scoped by [tenantId].
class ProductGroupRepository {
  ProductGroupRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  Future<ProductGroupRow?> getGroup(String groupId) async {
    return await (_db.select(_db.productGroups)
          ..where((t) => t.tenantId.equals(tenantId) & t.groupId.equals(groupId))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Upsert a group by (tenantId, groupId).
  Future<void> upsertGroup({
    required String groupId,
    required String canonicalProductId,
    String? ean,
    String? sku,
    String? titleNormalized,
    String? attributesHash,
    String? imageHash,
    int matchVersion = 1,
  }) async {
    final existing = await getGroup(groupId);
    if (existing == null) {
      await _db.into(_db.productGroups).insert(
            ProductGroupsCompanion.insert(
              tenantId: Value(tenantId),
              groupId: groupId,
              canonicalProductId: canonicalProductId,
              ean: Value(ean),
              sku: Value(sku),
              titleNormalized: Value(titleNormalized),
              attributesHash: Value(attributesHash),
              imageHash: Value(imageHash),
              matchVersion: Value(matchVersion),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
      return;
    }
    await (_db.update(_db.productGroups)
          ..where((t) => t.tenantId.equals(tenantId) & t.groupId.equals(groupId)))
        .write(
      ProductGroupsCompanion(
        canonicalProductId: Value(canonicalProductId),
        ean: Value(ean),
        sku: Value(sku),
        titleNormalized: Value(titleNormalized),
        attributesHash: Value(attributesHash),
        imageHash: Value(imageHash),
        matchVersion: Value(matchVersion),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Idempotently add/update a membership record for (tenantId, groupId, productId).
  Future<void> upsertMember({
    required String groupId,
    required String productId,
    required double confidence,
    required String matchedBy,
  }) async {
    final existing = await (_db.select(_db.productGroupMembers)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.groupId.equals(groupId) &
              t.productId.equals(productId))
          ..limit(1))
        .getSingleOrNull();

    if (existing == null) {
      await _db.into(_db.productGroupMembers).insert(
            ProductGroupMembersCompanion.insert(
              tenantId: Value(tenantId),
              groupId: groupId,
              productId: productId,
              confidence: Value(confidence),
              matchedBy: Value(matchedBy),
              createdAt: DateTime.now(),
            ),
          );
      return;
    }

    await (_db.update(_db.productGroupMembers)
          ..where((t) => t.id.equals(existing.id)))
        .write(
      ProductGroupMembersCompanion(
        confidence: Value(confidence),
        matchedBy: Value(matchedBy),
      ),
    );
  }

  Future<List<ProductGroupMemberRow>> getMembers(String groupId) async {
    return await (_db.select(_db.productGroupMembers)
          ..where((t) => t.tenantId.equals(tenantId) & t.groupId.equals(groupId))
          ..orderBy([(t) => OrderingTerm.desc(t.confidence)]))
        .get();
  }
}

