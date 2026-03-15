/// Phase 28: One row of materialized stock state (product/supplier).
class StockStateRecord {
  const StockStateRecord({
    required this.id,
    required this.productId,
    this.supplierId,
    this.supplierStock,
    required this.returnedStock,
    required this.reservedStock,
    required this.availableStock,
    required this.lastUpdatedAt,
  });

  final int id;
  final String productId;
  final String? supplierId;
  final int? supplierStock;
  final int returnedStock;
  final int reservedStock;
  final int availableStock;
  final DateTime lastUpdatedAt;
}
