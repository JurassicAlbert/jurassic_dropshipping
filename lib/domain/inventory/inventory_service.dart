import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/returned_stock_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/stock_state_repository.dart';
import 'package:jurassic_dropshipping/domain/inventory/inventory_snapshot.dart';

/// Phase 18: Unified inventory view to prevent overselling.
/// Aggregates supplier stock (optional), returned stock, reserved (orders), and marketplace stock.
/// Phase 28: When [stockStateRepository] is set, uses materialized StockState for fast path when not stale.
class InventoryService {
  InventoryService({
    required this.orderRepository,
    required this.returnedStockRepository,
    this.stockStateRepository,
    this.stockStateMaxStaleness = const Duration(minutes: 5),
  });

  final OrderRepository orderRepository;
  final ReturnedStockRepository returnedStockRepository;
  final StockStateRepository? stockStateRepository;
  /// When using StockState fast path, skip if lastUpdatedAt is older than this (Phase 28).
  final Duration stockStateMaxStaleness;

  /// Supplier/source stock for a product. Returns null when unknown (no local cache or API).
  /// Callers can inject stock via [availableToSell] overrides.
  Future<int?> supplierStock(String productId, String sourcePlatformId) async {
    // No stored supplier quantity in current schema; source platforms report at order time.
    return null;
  }

  /// Returned restockable quantity for a product (optionally for a supplier).
  Future<int> returnedStock(String productId, {String? supplierId}) async {
    return returnedStockRepository.getAvailableQuantity(productId, supplierId: supplierId);
  }

  /// Quantity reserved by orders in sourceOrderPlaced or shipped for this product.
  Future<int> reservedStock(String productId) async {
    return orderRepository.getReservedQuantityForProduct(productId);
  }

  /// Marketplace/target listing stock. Returns null when unknown (target may not expose stock API).
  Future<int?> marketplaceStock(String listingId) async {
    return null;
  }

  /// Unified available-to-sell: (supplier + returned - reserved), capped by marketplace stock when known.
  /// Pass [supplierStockOverride] / [marketplaceStockOverride] when you have external values (e.g. from API).
  /// Phase 19: [safetyStockBuffer] reduces effective available-to-sell by that many units (stock drift guard).
  /// [lastStockCheckAt] can be set when supplier stock comes from a known refresh time (e.g. SupplierOffer.lastStockRefreshAt).
  Future<InventorySnapshot> availableToSell(
    String productId,
    String listingId, {
    String? supplierId,
    int? supplierStockOverride,
    int? marketplaceStockOverride,
    int? safetyStockBuffer,
    DateTime? lastStockCheckAt,
  }) async {
    int returned;
    int reserved;
    int? supplier;
    final marketplace = marketplaceStockOverride ?? await marketplaceStock(listingId);
    final marketplaceStockUnknown = marketplace == null && marketplaceStockOverride == null;

    final state = stockStateRepository != null
        ? await stockStateRepository!.getByProductAndSupplier(productId, supplierId: supplierId)
        : null;
    final useState = state != null &&
        DateTime.now().difference(state.lastUpdatedAt) <= stockStateMaxStaleness;

    if (useState) {
      final s = state;
      returned = s.returnedStock;
      reserved = s.reservedStock;
      supplier = supplierStockOverride ?? s.supplierStock;
    } else {
      returned = await returnedStock(productId, supplierId: supplierId);
      reserved = await reservedStock(productId);
      supplier = supplierStockOverride ?? await supplierStock(productId, '');
    }

    final supplierStockUnknown = supplier == null && supplierStockOverride == null;

    var pool = (supplier ?? 0) + returned - reserved;
    var available = marketplace != null
        ? (pool < marketplace ? pool : marketplace)
        : (pool < 0 ? 0 : pool);
    final buffer = safetyStockBuffer ?? 0;
    if (buffer > 0) available = available > buffer ? available - buffer : 0;

    return InventorySnapshot(
      supplierStock: supplier,
      returnedStock: returned,
      reservedStock: reserved,
      marketplaceStock: marketplace,
      availableToSell: available,
      supplierStockUnknown: supplierStockUnknown,
      marketplaceStockUnknown: marketplaceStockUnknown,
      lastStockCheckAt: lastStockCheckAt ?? (useState ? state.lastUpdatedAt : null),
    );
  }
}
