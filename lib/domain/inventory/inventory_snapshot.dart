/// Phase 18: Snapshot of inventory components for a product/listing.
/// Use [InventoryService.availableToSell] to compute.
class InventorySnapshot {
  const InventorySnapshot({
    required this.supplierStock,
    required this.returnedStock,
    required this.reservedStock,
    required this.marketplaceStock,
    required this.availableToSell,
    this.supplierStockUnknown = false,
    this.marketplaceStockUnknown = false,
    this.lastStockCheckAt,
  });

  /// Supplier/source stock (null if unknown).
  final int? supplierStock;

  /// Returned restockable quantity (from ReturnedStock).
  final int returnedStock;

  /// Quantity reserved by orders (sourceOrderPlaced/shipped).
  final int reservedStock;

  /// Marketplace listing stock (null if unknown).
  final int? marketplaceStock;

  /// Computed: effectively (supplierStock ?? 0) + returnedStock - reservedStock, capped by marketplaceStock if known.
  final int availableToSell;

  /// True when [supplierStock] is null because source does not report stock.
  final bool supplierStockUnknown;

  /// True when [marketplaceStock] is null because target does not report stock.
  final bool marketplaceStockUnknown;

  /// Phase 19: when supplier stock came from a stored value (e.g. SupplierOffer), when it was last checked. Null when unknown.
  final DateTime? lastStockCheckAt;
}
