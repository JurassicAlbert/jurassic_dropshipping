import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/returned_stock_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/stock_state_repository.dart';

/// Phase 28: Refreshes the StockState table from current orders, returned stock, and (optionally) supplier data.
/// Run periodically or after offers/orders/returns change so InventoryService fast path has fresh data.
class StockStateRefreshService {
  StockStateRefreshService({
    required this.listingRepository,
    required this.orderRepository,
    required this.returnedStockRepository,
    required this.stockStateRepository,
  });

  final ListingRepository listingRepository;
  final OrderRepository orderRepository;
  final ReturnedStockRepository returnedStockRepository;
  final StockStateRepository stockStateRepository;

  /// Recompute and upsert stock state for all products that have active listings or returned stock.
  Future<int> refreshAll() async {
    final active = await listingRepository.getByStatus(ListingStatus.active);
    final productIdSet = active.map((l) => l.productId).toSet();
    final returned = await returnedStockRepository.getAll();
    for (final r in returned) {
      productIdSet.add(r.productId);
    }
    final uniqueProductIds = productIdSet.toList();

    var updated = 0;
    for (final productId in uniqueProductIds) {
      try {
        final returnedQty = await returnedStockRepository.getAvailableQuantity(productId);
        final reserved = await orderRepository.getReservedQuantityForProduct(productId);
        final supplierStock = null; // No DB source yet; can be filled when offers have stock
        final available = (supplierStock ?? 0) + returnedQty - reserved;
        final availableClamped = available < 0 ? 0 : available;
        await stockStateRepository.upsert(
          productId: productId,
          supplierId: null,
          supplierStock: supplierStock,
          returnedStock: returnedQty,
          reservedStock: reserved,
          availableStock: availableClamped,
        );
        updated++;
      } catch (e, st) {
        appLogger.e('StockStateRefresh: failed for product $productId', error: e, stackTrace: st);
      }
    }
    if (updated > 0) {
      appLogger.i('StockStateRefresh: updated $updated stock state row(s)');
    }
    return updated;
  }
}
