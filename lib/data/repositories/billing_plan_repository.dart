import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

/// Plan limits: -1 means unlimited.
class BillingPlan {
  const BillingPlan({
    required this.id,
    required this.name,
    required this.maxListings,
    required this.maxOrdersPerMonth,
    this.stripePriceId,
  });
  final int id;
  final String name;
  final int maxListings;
  final int maxOrdersPerMonth;
  final String? stripePriceId;

  bool get hasUnlimitedListings => maxListings < 0;
  bool get hasUnlimitedOrdersPerMonth => maxOrdersPerMonth < 0;
}

/// Repository for billing plans (read-only from app; plans are seeded or managed by backend).
class BillingPlanRepository {
  BillingPlanRepository(this._db);
  final AppDatabase _db;

  Future<BillingPlan?> getById(int id) async {
    final row = await (_db.select(_db.billingPlans)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row != null ? _rowToPlan(row) : null;
  }

  /// Default plan for new tenants (e.g. "free"). Returns first plan by id if none named "free".
  Future<BillingPlan> getDefaultPlan() async {
    final free = await (_db.select(_db.billingPlans)..where((t) => t.name.equals('free'))).getSingleOrNull();
    if (free != null) return _rowToPlan(free);
    final list = await (_db.select(_db.billingPlans)..orderBy([(t) => OrderingTerm.asc(t.id)])).get();
    if (list.isNotEmpty) return _rowToPlan(list.first);
    throw StateError('No billing plan in database. Run seed.');
  }

  Future<List<BillingPlan>> getAll() async {
    final rows = await (_db.select(_db.billingPlans)..orderBy([(t) => OrderingTerm.asc(t.id)])).get();
    return rows.map(_rowToPlan).toList();
  }

  static BillingPlan _rowToPlan(BillingPlanRow row) {
    return BillingPlan(
      id: row.id,
      name: row.name,
      maxListings: row.maxListings,
      maxOrdersPerMonth: row.maxOrdersPerMonth,
      stripePriceId: row.stripePriceId,
    );
  }
}
