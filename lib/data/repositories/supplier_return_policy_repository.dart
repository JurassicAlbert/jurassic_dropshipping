import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/domain/post_order/supplier_return_policy.dart';

/// Repository for supplier return policies (Phase 2). Scoped by [tenantId].
class SupplierReturnPolicyRepository {
  SupplierReturnPolicyRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static SupplierReturnPolicy _rowToPolicy(SupplierReturnPolicyRow row) {
    return SupplierReturnPolicy(
      id: row.id,
      supplierId: row.supplierId,
      policyType: SupplierReturnPolicy.policyTypeFromString(row.policyType),
      returnWindowDays: row.returnWindowDays,
      restockingFeePercent: row.restockingFeePercent,
      returnShippingPaidBy:
          SupplierReturnPolicy.returnShippingPaidByFromString(row.returnShippingPaidBy),
      requiresRma: row.requiresRma,
      warehouseReturnSupported: row.warehouseReturnSupported,
      virtualRestockSupported: row.virtualRestockSupported,
    );
  }

  Future<List<SupplierReturnPolicy>> getAll() async {
    final rows = await (_db.select(_db.supplierReturnPolicies)
          ..where((t) => t.tenantId.equals(tenantId)))
        .get();
    return rows.map(_rowToPolicy).toList();
  }

  Future<SupplierReturnPolicy?> getBySupplierId(String supplierId) async {
    final row = await (_db.select(_db.supplierReturnPolicies)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.supplierId.equals(supplierId)))
        .getSingleOrNull();
    return row != null ? _rowToPolicy(row) : null;
  }

  Future<void> insert(SupplierReturnPolicy policy) async {
    await _db.into(_db.supplierReturnPolicies).insert(
      SupplierReturnPoliciesCompanion.insert(
        tenantId: Value(tenantId),
        supplierId: policy.supplierId,
        policyType: SupplierReturnPolicy.policyTypeToString(policy.policyType),
        returnWindowDays: Value(policy.returnWindowDays),
        restockingFeePercent: Value(policy.restockingFeePercent),
        returnShippingPaidBy: Value(SupplierReturnPolicy.returnShippingPaidByToString(
            policy.returnShippingPaidBy)),
        requiresRma: Value(policy.requiresRma),
        warehouseReturnSupported: Value(policy.warehouseReturnSupported),
        virtualRestockSupported: Value(policy.virtualRestockSupported),
      ),
    );
  }

  Future<void> update(SupplierReturnPolicy policy) async {
    await (_db.update(_db.supplierReturnPolicies)
          ..where((t) => t.tenantId.equals(tenantId) & t.id.equals(policy.id)))
        .write(
      SupplierReturnPoliciesCompanion(
        policyType: Value(SupplierReturnPolicy.policyTypeToString(policy.policyType)),
        returnWindowDays: Value(policy.returnWindowDays),
        restockingFeePercent: Value(policy.restockingFeePercent),
        returnShippingPaidBy: Value(SupplierReturnPolicy.returnShippingPaidByToString(
            policy.returnShippingPaidBy)),
        requiresRma: Value(policy.requiresRma),
        warehouseReturnSupported: Value(policy.warehouseReturnSupported),
        virtualRestockSupported: Value(policy.virtualRestockSupported),
      ),
    );
  }

  /// Upsert: insert or update by supplierId (one policy per supplier per tenant).
  Future<void> upsert(SupplierReturnPolicy policy) async {
    final existing = await getBySupplierId(policy.supplierId);
    if (existing != null) {
      await update(SupplierReturnPolicy(
        id: existing.id,
        supplierId: policy.supplierId,
        policyType: policy.policyType,
        returnWindowDays: policy.returnWindowDays,
        restockingFeePercent: policy.restockingFeePercent,
        returnShippingPaidBy: policy.returnShippingPaidBy,
        requiresRma: policy.requiresRma,
        warehouseReturnSupported: policy.warehouseReturnSupported,
        virtualRestockSupported: policy.virtualRestockSupported,
      ));
    } else {
      await insert(policy);
    }
  }
}
