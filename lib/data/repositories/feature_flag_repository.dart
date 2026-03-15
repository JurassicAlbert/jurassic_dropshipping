import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

/// Repository for feature flags (name -> enabled). Used to toggle features without code deploy. Scoped by [tenantId].
class FeatureFlagRepository {
  FeatureFlagRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  /// Returns true if the flag is enabled, false otherwise. Missing flag defaults to false.
  Future<bool> get(String name) async {
    final row = await (_db.select(_db.featureFlags)
          ..where((t) => t.tenantId.equals(tenantId) & t.name.equals(name)))
        .getSingleOrNull();
    return row?.enabled ?? false;
  }

  /// Sets a flag. Creates or updates.
  Future<void> set(String name, bool enabled) async {
    final exists = await (_db.select(_db.featureFlags)
          ..where((t) => t.tenantId.equals(tenantId) & t.name.equals(name)))
        .getSingleOrNull();
    if (exists != null) {
      await (_db.update(_db.featureFlags)
            ..where((t) => t.tenantId.equals(tenantId) & t.name.equals(name)))
          .write(FeatureFlagsCompanion(enabled: Value(enabled)));
    } else {
      await _db.into(_db.featureFlags).insert(
        FeatureFlagsCompanion.insert(tenantId: Value(tenantId), name: name, enabled: Value(enabled)),
      );
    }
  }

  /// Returns all flags as a map. Useful for loading once.
  Future<Map<String, bool>> getAll() async {
    final rows = await (_db.select(_db.featureFlags)..where((t) => t.tenantId.equals(tenantId))).get();
    return {for (final r in rows) r.name: r.enabled};
  }
}
