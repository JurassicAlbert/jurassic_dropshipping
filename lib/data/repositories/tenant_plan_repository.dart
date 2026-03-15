import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

/// Tenant's subscription: plan id and optional Stripe ids.
class TenantPlan {
  const TenantPlan({
    required this.tenantId,
    required this.planId,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.currentPeriodStart,
    this.currentPeriodEnd,
  });
  final int tenantId;
  final int planId;
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final DateTime? currentPeriodStart;
  final DateTime? currentPeriodEnd;
}

/// Repository for tenant–plan association (Phase B5).
class TenantPlanRepository {
  TenantPlanRepository(this._db);
  final AppDatabase _db;

  Future<TenantPlan?> getByTenantId(int tenantId) async {
    final row = await (_db.select(_db.tenantPlans)..where((t) => t.tenantId.equals(tenantId))).getSingleOrNull();
    return row != null ? _rowToTenantPlan(row) : null;
  }

  static TenantPlan _rowToTenantPlan(TenantPlanRow row) {
    return TenantPlan(
      tenantId: row.tenantId,
      planId: row.planId,
      stripeCustomerId: row.stripeCustomerId,
      stripeSubscriptionId: row.stripeSubscriptionId,
      currentPeriodStart: row.currentPeriodStart,
      currentPeriodEnd: row.currentPeriodEnd,
    );
  }

  /// Set or update the plan for a tenant.
  Future<void> setPlan(int tenantId, int planId, {
    String? stripeCustomerId,
    String? stripeSubscriptionId,
    DateTime? currentPeriodStart,
    DateTime? currentPeriodEnd,
  }) async {
    final existing = await getByTenantId(tenantId);
    if (existing != null) {
      await (_db.update(_db.tenantPlans)..where((t) => t.tenantId.equals(tenantId))).write(
        TenantPlansCompanion(
          planId: Value(planId),
          stripeCustomerId: stripeCustomerId != null ? Value(stripeCustomerId) : const Value.absent(),
          stripeSubscriptionId: stripeSubscriptionId != null ? Value(stripeSubscriptionId) : const Value.absent(),
          currentPeriodStart: currentPeriodStart != null ? Value(currentPeriodStart) : const Value.absent(),
          currentPeriodEnd: currentPeriodEnd != null ? Value(currentPeriodEnd) : const Value.absent(),
        ),
      );
    } else {
      await _db.into(_db.tenantPlans).insert(
        TenantPlansCompanion.insert(
          tenantId: Value(tenantId),
          planId: planId,
          stripeCustomerId: stripeCustomerId != null ? Value(stripeCustomerId) : const Value.absent(),
          stripeSubscriptionId: stripeSubscriptionId != null ? Value(stripeSubscriptionId) : const Value.absent(),
          currentPeriodStart: currentPeriodStart != null ? Value(currentPeriodStart) : const Value.absent(),
          currentPeriodEnd: currentPeriodEnd != null ? Value(currentPeriodEnd) : const Value.absent(),
        ),
      );
    }
  }
}
