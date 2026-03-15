import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/domain/post_order/return_routing.dart';

class ReturnRepository {
  ReturnRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static ReturnStatus _statusFromString(String s) {
    return ReturnStatus.values.firstWhere(
      (e) => e.name == s,
      orElse: () => ReturnStatus.requested,
    );
  }

  static ReturnReason _reasonFromString(String s) {
    return ReturnReason.values.firstWhere(
      (e) => e.name == s,
      orElse: () => ReturnReason.noReason,
    );
  }

  static ReturnDestination? _returnDestinationFromString(String? s) {
    if (s == null || s.isEmpty) return null;
    return ReturnDestination.values.firstWhere(
      (e) => e.name == s,
      orElse: () => ReturnDestination.toSupplier,
    );
  }

  static ReturnRequest _rowToReturnRequest(ReturnRow row) {
    return ReturnRequest(
      id: row.returnId,
      orderId: row.orderId,
      reason: _reasonFromString(row.reason),
      status: _statusFromString(row.status),
      notes: row.notes,
      refundAmount: row.refundAmount,
      returnShippingCost: row.returnShippingCost,
      restockingFee: row.restockingFee,
      requestedAt: row.requestedAt,
      resolvedAt: row.resolvedAt,
      returnToAddress: row.returnToAddress,
      returnToCity: row.returnToCity,
      returnToCountry: row.returnToCountry,
      returnTrackingNumber: row.returnTrackingNumber,
      returnCarrier: row.returnCarrier,
      supplierId: row.supplierId,
      productId: row.productId,
      sourcePlatformId: row.sourcePlatformId,
      targetPlatformId: row.targetPlatformId,
      returnDestination: _returnDestinationFromString(row.returnDestination),
      returnRoutingDestination:
          ReturnRoutingDestinationExtension.fromDbString(row.returnRoutingDestination),
    );
  }

  Future<List<ReturnRequest>> getAll() async {
    final rows = await (_db.select(_db.returns)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.requestedAt)]))
        .get();
    return rows.map(_rowToReturnRequest).toList();
  }

  Future<List<ReturnRequest>> getByOrderId(String orderId) async {
    final rows = await (_db.select(_db.returns)
          ..where((t) => t.tenantId.equals(tenantId) & t.orderId.equals(orderId)))
        .get();
    return rows.map(_rowToReturnRequest).toList();
  }

  Future<void> insert(ReturnRequest returnRequest) async {
    await _db.into(_db.returns).insert(
      ReturnsCompanion.insert(
        tenantId: Value(tenantId),
        returnId: returnRequest.id,
        orderId: returnRequest.orderId,
        reason: returnRequest.reason.name,
        status: returnRequest.status.name,
        notes: Value(returnRequest.notes),
        refundAmount: Value(returnRequest.refundAmount),
        returnShippingCost: Value(returnRequest.returnShippingCost),
        restockingFee: Value(returnRequest.restockingFee),
        requestedAt: Value(returnRequest.requestedAt),
        resolvedAt: Value(returnRequest.resolvedAt),
        returnToAddress: Value(returnRequest.returnToAddress),
        returnToCity: Value(returnRequest.returnToCity),
        returnToCountry: Value(returnRequest.returnToCountry),
        returnTrackingNumber: Value(returnRequest.returnTrackingNumber),
        returnCarrier: Value(returnRequest.returnCarrier),
        supplierId: Value(returnRequest.supplierId),
        productId: Value(returnRequest.productId),
        sourcePlatformId: Value(returnRequest.sourcePlatformId),
        targetPlatformId: Value(returnRequest.targetPlatformId),
        returnDestination: Value(returnRequest.returnDestination?.name),
      ),
    );
  }

  Future<void> updateStatus(String returnId, ReturnStatus status,
      {double? refundAmount, DateTime? resolvedAt}) async {
    await (_db.update(_db.returns)
          ..where((t) => t.tenantId.equals(tenantId) & t.returnId.equals(returnId)))
        .write(
      ReturnsCompanion(
        status: Value(status.name),
        refundAmount:
            refundAmount != null ? Value(refundAmount) : const Value.absent(),
        resolvedAt:
            resolvedAt != null ? Value(resolvedAt) : const Value.absent(),
      ),
    );
  }

  /// Update editable fields of an existing return request (status, amounts, notes, metadata).
  Future<void> update(ReturnRequest r) async {
    await (_db.update(_db.returns)
          ..where((t) => t.tenantId.equals(tenantId) & t.returnId.equals(r.id)))
        .write(
      ReturnsCompanion(
        status: Value(r.status.name),
        notes: Value(r.notes),
        refundAmount: Value(r.refundAmount),
        returnShippingCost: Value(r.returnShippingCost),
        restockingFee: Value(r.restockingFee),
        resolvedAt: Value(r.resolvedAt),
        returnToAddress: Value(r.returnToAddress),
        returnToCity: Value(r.returnToCity),
        returnToCountry: Value(r.returnToCountry),
        returnTrackingNumber: Value(r.returnTrackingNumber),
        returnCarrier: Value(r.returnCarrier),
        supplierId: Value(r.supplierId),
        productId: Value(r.productId),
        sourcePlatformId: Value(r.sourcePlatformId),
        targetPlatformId: Value(r.targetPlatformId),
        returnDestination: Value(r.returnDestination?.name),
        returnRoutingDestination: Value(r.returnRoutingDestination?.toDbString()),
      ),
    );
  }
}
