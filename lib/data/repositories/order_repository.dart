import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';

/// Repository for orders (customer order from target marketplace, linked to source order).
class OrderRepository {
  OrderRepository(this._db);
  final AppDatabase _db;

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
      trackingNumber: row.trackingNumber,
      decisionLogId: row.decisionLogId,
      promisedDeliveryMin: row.promisedDeliveryMin,
      promisedDeliveryMax: row.promisedDeliveryMax,
      approvedAt: row.approvedAt,
      createdAt: row.createdAt,
    );
  }

  Future<List<Order>> getAll() async {
    final rows = await (_db.select(_db.orders)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
    return rows.map(_rowToOrder).toList();
  }

  Future<List<Order>> getByStatus(OrderStatus status) async {
    final rows = await (_db.select(_db.orders)..where((t) => t.status.equals(status.name))).get();
    return rows.map(_rowToOrder).toList();
  }

  Future<List<Order>> getPendingApproval() async {
    return getByStatus(OrderStatus.pendingApproval);
  }

  Future<Order?> getByLocalId(String localId) async {
    final row = await (_db.select(_db.orders)..where((t) => t.localId.equals(localId))).getSingleOrNull();
    return row != null ? _rowToOrder(row) : null;
  }

  Future<void> insert(Order order) async {
    await _db.into(_db.orders).insert(
      OrdersCompanion.insert(
        localId: order.id,
        listingId: order.listingId,
        targetOrderId: order.targetOrderId,
        targetPlatformId: order.targetPlatformId,
        customerAddressJson: jsonEncode(order.customerAddress.toJson()),
        status: order.status.name,
        sourceOrderId: Value(order.sourceOrderId),
        sourceCost: order.sourceCost,
        sellingPrice: order.sellingPrice,
        trackingNumber: Value(order.trackingNumber),
        decisionLogId: Value(order.decisionLogId),
        marketplaceAccountId: Value(order.marketplaceAccountId),
        promisedDeliveryMin: Value(order.promisedDeliveryMin),
        promisedDeliveryMax: Value(order.promisedDeliveryMax),
        approvedAt: Value(order.approvedAt),
        createdAt: order.createdAt ?? DateTime.now(),
      ),
    );
  }

  Future<void> updateStatus(String localId, OrderStatus status,
      {String? sourceOrderId, String? trackingNumber, DateTime? approvedAt}) async {
    await (_db.update(_db.orders)..where((t) => t.localId.equals(localId))).write(
      OrdersCompanion(
        status: Value(status.name),
        sourceOrderId: sourceOrderId != null ? Value(sourceOrderId) : const Value.absent(),
        trackingNumber: trackingNumber != null ? Value(trackingNumber) : const Value.absent(),
        approvedAt: approvedAt != null ? Value(approvedAt) : const Value.absent(),
      ),
    );
  }
}
