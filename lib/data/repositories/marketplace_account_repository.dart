import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/marketplace_account.dart';

class MarketplaceAccountRepository {
  MarketplaceAccountRepository(this._db);
  final AppDatabase _db;

  static MarketplaceAccount _rowToAccount(MarketplaceAccountRow row) {
    return MarketplaceAccount(
      id: row.accountId,
      platformId: row.platformId,
      displayName: row.displayName,
      isActive: row.isActive,
      connectedAt: row.connectedAt,
    );
  }

  Future<List<MarketplaceAccount>> getAll() async {
    final rows = await _db.select(_db.marketplaceAccounts).get();
    return rows.map(_rowToAccount).toList();
  }

  Future<MarketplaceAccount?> getById(String accountId) async {
    final row = await (_db.select(_db.marketplaceAccounts)
          ..where((t) => t.accountId.equals(accountId)))
        .getSingleOrNull();
    return row != null ? _rowToAccount(row) : null;
  }

  Future<List<MarketplaceAccount>> getByPlatformId(String platformId) async {
    final rows = await (_db.select(_db.marketplaceAccounts)
          ..where((t) => t.platformId.equals(platformId)))
        .get();
    return rows.map(_rowToAccount).toList();
  }

  Future<void> upsert(MarketplaceAccount account) async {
    final existing = await (_db.select(_db.marketplaceAccounts)
          ..where((t) => t.accountId.equals(account.id)))
        .getSingleOrNull();
    if (existing != null) {
      await (_db.update(_db.marketplaceAccounts)
            ..where((t) => t.accountId.equals(account.id)))
          .write(MarketplaceAccountsCompanion(
        platformId: Value(account.platformId),
        displayName: Value(account.displayName),
        isActive: Value(account.isActive),
        connectedAt: Value(account.connectedAt),
      ));
    } else {
      await _db.into(_db.marketplaceAccounts).insert(
        MarketplaceAccountsCompanion.insert(
          accountId: account.id,
          platformId: account.platformId,
          displayName: account.displayName,
          isActive: Value(account.isActive),
          connectedAt: Value(account.connectedAt),
        ),
      );
    }
  }

  Future<void> delete(String accountId) async {
    await (_db.delete(_db.marketplaceAccounts)
          ..where((t) => t.accountId.equals(accountId)))
        .go();
  }
}
