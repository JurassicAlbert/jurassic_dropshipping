import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';

/// Repository for listings (product listed on a target marketplace).
class ListingRepository {
  ListingRepository(this._db);
  final AppDatabase _db;

  static ListingStatus _statusFromString(String s) {
    return ListingStatus.values.firstWhere(
      (e) => e.name == s,
      orElse: () => ListingStatus.draft,
    );
  }

  static Listing _rowToListing(ListingRow row) {
    return Listing(
      id: row.localId,
      productId: row.productId,
      targetPlatformId: row.targetPlatformId,
      targetListingId: row.targetListingId,
      status: _statusFromString(row.status),
      sellingPrice: row.sellingPrice,
      sourceCost: row.sourceCost,
      decisionLogId: row.decisionLogId,
      promisedMinDays: row.promisedMinDays,
      promisedMaxDays: row.promisedMaxDays,
      createdAt: row.createdAt,
      publishedAt: row.publishedAt,
    );
  }

  Future<List<Listing>> getAll() async {
    final rows = await (_db.select(_db.listings)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
    return rows.map(_rowToListing).toList();
  }

  Future<List<Listing>> getByStatus(ListingStatus status) async {
    final rows = await (_db.select(_db.listings)..where((t) => t.status.equals(status.name))).get();
    return rows.map(_rowToListing).toList();
  }

  Future<List<Listing>> getPendingApproval() async {
    return getByStatus(ListingStatus.pendingApproval);
  }

  Future<Listing?> getByLocalId(String localId) async {
    final row = await (_db.select(_db.listings)..where((t) => t.localId.equals(localId))).getSingleOrNull();
    return row != null ? _rowToListing(row) : null;
  }

  Future<Listing?> getByTargetListingId(String targetPlatformId, String targetListingId) async {
    final row = await (_db.select(_db.listings)
          ..where((t) => t.targetPlatformId.equals(targetPlatformId) & t.targetListingId.equals(targetListingId)))
        .getSingleOrNull();
    return row != null ? _rowToListing(row) : null;
  }

  Future<void> insert(Listing listing) async {
    await _db.into(_db.listings).insert(
      ListingsCompanion.insert(
        localId: listing.id,
        productId: listing.productId,
        targetPlatformId: listing.targetPlatformId,
        targetListingId: Value(listing.targetListingId),
        status: listing.status.name,
        sellingPrice: listing.sellingPrice,
        sourceCost: listing.sourceCost,
        decisionLogId: Value(listing.decisionLogId),
        marketplaceAccountId: Value(listing.marketplaceAccountId),
        promisedMinDays: Value(listing.promisedMinDays),
        promisedMaxDays: Value(listing.promisedMaxDays),
        createdAt: listing.createdAt ?? DateTime.now(),
        publishedAt: Value(listing.publishedAt),
      ),
    );
  }

  Future<void> updateStatus(String localId, ListingStatus status, {String? targetListingId, DateTime? publishedAt}) async {
    await (_db.update(_db.listings)..where((t) => t.localId.equals(localId))).write(
      ListingsCompanion(
        status: Value(status.name),
        targetListingId: targetListingId != null ? Value(targetListingId) : const Value.absent(),
        publishedAt: publishedAt != null ? Value(publishedAt) : const Value.absent(),
      ),
    );
  }
}
