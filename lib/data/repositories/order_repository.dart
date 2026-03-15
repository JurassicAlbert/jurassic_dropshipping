import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';

/// Repository for orders (customer order from target marketplace, linked to source order). Scoped by [tenantId].
class OrderRepository {
  OrderRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static OrderStatus _statusFromString(String s) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == s,
      orElse: () => OrderStatus.pending,
    );
  }

  static Order _rowToOrder(OrderRow row) {
    final addressJson = jsonDecode(row.customerAddressJson) as Map<String, dynamic>;
    return Order(
      id: row.localId,
      listingId: row.listingId,
      targetOrderId: row.targetOrderId,
      targetPlatformId: row.targetPlatformId,
      customerAddress: CustomerAddress.fromJson(addressJson),
      status: _statusFromString(row.status),
      sourceOrderId: row.sourceOrderId,
      sourceCost: row.sourceCost,
      sellingPrice: row.sellingPrice,
      quantity: row.quantity,
      trackingNumber: row.trackingNumber,
      decisionLogId: row.decisionLogId,
      promisedDeliveryMin: row.promisedDeliveryMin,
      promisedDeliveryMax: row.promisedDeliveryMax,
      deliveredAt: row.deliveredAt,
      approvedAt: row.approvedAt,
      createdAt: row.createdAt,
      lifecycleState: row.lifecycleState,
      financialState: row.financialState,
      queuedForCapital: row.queuedForCapital,
      riskScore: row.riskScore,
      riskFactorsJson: row.riskFactorsJson,
    );
  }

  Future<List<Order>> getAll() async {
    final rows = await (_db.select(_db.orders)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_rowToOrder).toList();
  }

  /// Orders created on or after [since] (e.g. for reliability scoring window).
  Future<List<Order>> getCreatedSince(DateTime since) async {
    final rows = await (_db.select(_db.orders)
          ..where((t) => t.tenantId.equals(tenantId) & t.createdAt.isBiggerOrEqualValue(since))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_rowToOrder).toList();
  }

  /// Orders created in the current calendar month (for billing usage).
  Future<int> countThisMonth() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    final rows = await (_db.select(_db.orders)
          ..where((t) => t.tenantId.equals(tenantId) & t.createdAt.isBiggerOrEqualValue(start)))
        .get();
    return rows.length;
  }

  Future<List<Order>> getByStatus(OrderStatus status) async {
    final rows = await (_db.select(_db.orders)
          ..where((t) => t.tenantId.equals(tenantId) & t.status.equals(status.name)))
        .get();
    return rows.map(_rowToOrder).toList();
  }

  Future<List<Order>> getPendingApproval() async {
    return getByStatus(OrderStatus.pendingApproval);
  }

  Future<Order?> getByLocalId(String localId) async {
    final row = await (_db.select(_db.orders)
          ..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId)))
        .getSingleOrNull();
    return row != null ? _rowToOrder(row) : null;
  }

  /// Returns the first order matching target platform and target order id (e.g. Allegro checkout form id).
  Future<Order?> getByTargetOrderId(String targetPlatformId, String targetOrderId) async {
    final row = await (_db.select(_db.orders)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.targetPlatformId.equals(targetPlatformId) &
              t.targetOrderId.equals(targetOrderId))
          ..limit(1))
        .getSingleOrNull();
    return row != null ? _rowToOrder(row) : null;
  }

  /// Returns existing order for the same target order line (idempotency for sync).
  Future<Order?> getByTargetOrderIdAndListingId(
    String targetPlatformId,
    String targetOrderId,
    String listingId,
  ) async {
    final row = await (_db.select(_db.orders)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.targetPlatformId.equals(targetPlatformId) &
              t.targetOrderId.equals(targetOrderId) &
              t.listingId.equals(listingId)))
        .getSingleOrNull();
    return row != null ? _rowToOrder(row) : null;
  }

  Future<void> insert(Order order) async {
    await _db.into(_db.orders).insert(
      OrdersCompanion.insert(
        tenantId: Value(tenantId),
        localId: order.id,
        listingId: order.listingId,
        targetOrderId: order.targetOrderId,
        targetPlatformId: order.targetPlatformId,
        customerAddressJson: jsonEncode(order.customerAddress.toJson()),
        status: order.status.name,
        sourceOrderId: Value(order.sourceOrderId),
        sourceCost: order.sourceCost,
        sellingPrice: order.sellingPrice,
        quantity: Value(order.quantity),
        trackingNumber: Value(order.trackingNumber),
        decisionLogId: Value(order.decisionLogId),
        marketplaceAccountId: Value(order.marketplaceAccountId),
        promisedDeliveryMin: Value(order.promisedDeliveryMin),
        promisedDeliveryMax: Value(order.promisedDeliveryMax),
        deliveredAt: Value(order.deliveredAt),
        approvedAt: Value(order.approvedAt),
        createdAt: order.createdAt ?? DateTime.now(),
        lifecycleState: Value(order.lifecycleState),
        financialState: Value(order.financialState),
        queuedForCapital: Value(order.queuedForCapital),
        riskScore: Value(order.riskScore),
        riskFactorsJson: Value(order.riskFactorsJson),
      ),
    );
  }

  /// Phase 16: set risk score and factors; optionally set status to pendingApproval.
  Future<void> updateRiskScore(String localId, double score, String? factorsJson, {bool setPendingApproval = false}) async {
    final companion = OrdersCompanion(
      riskScore: Value(score),
      riskFactorsJson: Value(factorsJson),
      status: setPendingApproval ? Value(OrderStatus.pendingApproval.name) : const Value.absent(),
    );
    await (_db.update(_db.orders)..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId))).write(companion);
  }

  Future<void> updateStatus(String localId, OrderStatus status,
      {String? sourceOrderId, String? trackingNumber, DateTime? approvedAt, DateTime? deliveredAt}) async {
    await (_db.update(_db.orders)..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId))).write(
      OrdersCompanion(
        status: Value(status.name),
        sourceOrderId: sourceOrderId != null ? Value(sourceOrderId) : const Value.absent(),
        trackingNumber: trackingNumber != null ? Value(trackingNumber) : const Value.absent(),
        approvedAt: approvedAt != null ? Value(approvedAt) : const Value.absent(),
        deliveredAt: deliveredAt != null ? Value(deliveredAt) : const Value.absent(),
      ),
    );
  }

  /// Attach a decision log id to an existing order (for diagnostics).
  Future<void> attachDecisionLog(String localId, String decisionLogId) async {
    await (_db.update(_db.orders)..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId))).write(
      OrdersCompanion(
        decisionLogId: Value(decisionLogId),
      ),
    );
  }

  /// Update post-order lifecycle state (Phase 1).
  Future<void> updateLifecycleState(String localId, String lifecycleState) async {
    await (_db.update(_db.orders)..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId))).write(
      OrdersCompanion(lifecycleState: Value(lifecycleState)),
    );
  }

  /// Phase 14: set order queued-for-capital flag (when capital insufficient to fulfill).
  Future<void> setQueuedForCapital(String localId, bool queued) async {
    await (_db.update(_db.orders)..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId))).write(
      OrdersCompanion(queuedForCapital: Value(queued)),
    );
  }

  /// Phase 14: set order financial state (e.g. supplier_paid, refunded).
  Future<void> updateFinancialState(String localId, String? financialState) async {
    await (_db.update(_db.orders)..where((t) => t.tenantId.equals(tenantId) & t.localId.equals(localId))).write(
      OrdersCompanion(financialState: Value(financialState)),
    );
  }

  /// Phase 18: sum of order quantities for orders in sourceOrderPlaced/shipped that reference a listing for [productId].
  Future<int> getReservedQuantityForProduct(String productId) async {
    final result = await _db.customSelect(
      'SELECT COALESCE(SUM(o.quantity), 0) AS total FROM orders o '
      'INNER JOIN listings l ON o.listing_id = l.local_id AND o.tenant_id = l.tenant_id '
      'WHERE o.tenant_id = ? AND l.product_id = ? AND o.status IN (?, ?)',
      variables: [
        Variable.withInt(tenantId),
        Variable.withString(productId),
        Variable.withString(OrderStatus.sourceOrderPlaced.name),
        Variable.withString(OrderStatus.shipped.name),
      ],
      readsFrom: {_db.orders, _db.listings},
    ).getSingle();
    final total = result.read<int>('total');
    return total;
  }
}
