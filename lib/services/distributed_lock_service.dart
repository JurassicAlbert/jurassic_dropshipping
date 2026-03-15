import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

/// Distributed lock (Phase B3). Uses DB table so multiple workers/processes
/// cannot double-fulfill the same order. Call acquire before fulfill, release after.
class DistributedLockService {
  DistributedLockService(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  /// Try to acquire lock [key]. Returns true if acquired, false if already held (and not expired).
  /// [ttl] is how long the lock is valid (e.g. 5 minutes).
  Future<bool> acquire(String key, Duration ttl) async {
    final now = DateTime.now();
    final expiresAt = now.add(ttl);
    final row = await (_db.select(_db.distributedLocks)
          ..where((t) => t.lockKey.equals(key) & t.tenantId.equals(tenantId)))
        .getSingleOrNull();
    if (row == null) {
      await _db.into(_db.distributedLocks).insert(
        DistributedLocksCompanion.insert(
          lockKey: key,
          tenantId: Value(tenantId),
          expiresAt: expiresAt,
        ),
      );
      return true;
    }
    if (row.expiresAt.isBefore(now)) {
      await (_db.update(_db.distributedLocks)
            ..where((t) => t.lockKey.equals(key) & t.tenantId.equals(tenantId)))
          .write(DistributedLocksCompanion(expiresAt: Value(expiresAt)));
      return true;
    }
    return false;
  }

  /// Release lock [key].
  Future<void> release(String key) async {
    await (_db.delete(_db.distributedLocks)
          ..where((t) => t.lockKey.equals(key) & t.tenantId.equals(tenantId)))
        .go();
  }

  /// Lock key for fulfilling an order (prevents double-fulfill).
  static String fulfillOrderLockKey(String orderId) => 'fulfill:order:$orderId';
}
