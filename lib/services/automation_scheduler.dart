import 'dart:async';
import 'package:hive/hive.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/scanner.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';
import 'package:jurassic_dropshipping/services/marketplace_listing_sync_service.dart';
import 'package:jurassic_dropshipping/services/order_sync_service.dart';
import 'package:jurassic_dropshipping/services/price_refresh_service.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';

class AutomationScheduler {
  AutomationScheduler({
    required this.scanner,
    required this.orderSyncService,
    required this.fulfillmentService,
    required this.rulesRepository,
    required this.priceRefreshService,
    required this.marketplaceListingSyncService,
  });

  final Scanner scanner;
  final OrderSyncService orderSyncService;
  final FulfillmentService fulfillmentService;
  final RulesRepository rulesRepository;
  final PriceRefreshService priceRefreshService;
  final MarketplaceListingSyncService marketplaceListingSyncService;

  Timer? _scanTimer;
  Timer? _syncTimer;
  Timer? _priceRefreshTimer;
  Timer? _marketplaceSyncTimer;
  Timer? _productRefreshTimer;
  Timer? _lowStockRefreshTimer;

  DateTime? lastScanTime;
  DateTime? lastSyncTime;
  DateTime? lastPriceRefreshTime;
  DateTime? lastMarketplaceSyncTime;
  DateTime? lastProductRefreshTime;
  DateTime? lastLowStockRefreshTime;

  bool _scanning = false;
  bool _syncing = false;

  static const _boxName = 'automation_state';

  bool get isScanRunning => _scanTimer?.isActive ?? false;
  bool get isSyncRunning => _syncTimer?.isActive ?? false;
  bool get isPriceRefreshRunning => _priceRefreshTimer?.isActive ?? false;
  bool get isMarketplaceSyncRunning => _marketplaceSyncTimer?.isActive ?? false;
  bool get isProductRefreshRunning => _productRefreshTimer?.isActive ?? false;
  bool get isLowStockRefreshRunning => _lowStockRefreshTimer?.isActive ?? false;

  Future<void> _saveState() async {
    final box = await Hive.openBox(_boxName);
    if (lastScanTime != null) await box.put('lastScanTime', lastScanTime!.toIso8601String());
    if (lastSyncTime != null) await box.put('lastSyncTime', lastSyncTime!.toIso8601String());
    if (lastPriceRefreshTime != null) await box.put('lastPriceRefreshTime', lastPriceRefreshTime!.toIso8601String());
    if (lastMarketplaceSyncTime != null) await box.put('lastMarketplaceSyncTime', lastMarketplaceSyncTime!.toIso8601String());
    if (lastProductRefreshTime != null) await box.put('lastProductRefreshTime', lastProductRefreshTime!.toIso8601String());
    if (lastLowStockRefreshTime != null) await box.put('lastLowStockRefreshTime', lastLowStockRefreshTime!.toIso8601String());
  }

  Future<void> loadState() async {
    final box = await Hive.openBox(_boxName);
    final scan = box.get('lastScanTime') as String?;
    final sync = box.get('lastSyncTime') as String?;
    final refresh = box.get('lastPriceRefreshTime') as String?;
    final marketplaceSync = box.get('lastMarketplaceSyncTime') as String?;
    if (scan != null) lastScanTime = DateTime.parse(scan);
    if (sync != null) lastSyncTime = DateTime.parse(sync);
    if (refresh != null) lastPriceRefreshTime = DateTime.parse(refresh);
    if (marketplaceSync != null) lastMarketplaceSyncTime = DateTime.parse(marketplaceSync);
    final productRefresh = box.get('lastProductRefreshTime') as String?;
    if (productRefresh != null) lastProductRefreshTime = DateTime.parse(productRefresh);
    final lowStockRefresh = box.get('lastLowStockRefreshTime') as String?;
    if (lowStockRefresh != null) lastLowStockRefreshTime = DateTime.parse(lowStockRefresh);
  }

  Future<void> startAll() async {
    await loadState();
    final rules = await rulesRepository.get();
    final interval = Duration(minutes: rules.scanIntervalMinutes);
    
    startScanner(interval: interval);
    startOrderSync(interval: interval);
    startPriceRefresh(interval: const Duration(hours: 6));
    startMarketplaceListingSync(interval: const Duration(hours: 6));
    startProductRefresh(interval: const Duration(hours: 2));
    startLowStockRefresh(interval: const Duration(minutes: 30));
  }

  void stopAll() {
    _scanTimer?.cancel();
    _syncTimer?.cancel();
    _priceRefreshTimer?.cancel();
    _marketplaceSyncTimer?.cancel();
    _productRefreshTimer?.cancel();
    _lowStockRefreshTimer?.cancel();
    _scanTimer = null;
    _syncTimer = null;
    _priceRefreshTimer = null;
    _marketplaceSyncTimer = null;
    _productRefreshTimer = null;
    _lowStockRefreshTimer = null;
    appLogger.i('AutomationScheduler: all timers stopped');
  }

  void startScanner({Duration interval = const Duration(hours: 24)}) {
    _scanTimer?.cancel();
    _runScan();
    _scanTimer = Timer.periodic(interval, (_) => _runScan());
    appLogger.i('AutomationScheduler: scanner started with interval $interval');
  }

  void startOrderSync({Duration interval = const Duration(minutes: 30)}) {
    _syncTimer?.cancel();
    _runSync();
    _syncTimer = Timer.periodic(interval, (_) => _runSync());
    appLogger.i('AutomationScheduler: order sync started with interval $interval');
  }

  void startPriceRefresh({Duration interval = const Duration(hours: 6)}) {
    _priceRefreshTimer?.cancel();
    _runPriceRefresh();
    _priceRefreshTimer = Timer.periodic(interval, (_) => _runPriceRefresh());
    appLogger.i('AutomationScheduler: price refresh started with interval $interval');
  }

  void startMarketplaceListingSync({Duration interval = const Duration(hours: 6)}) {
    _marketplaceSyncTimer?.cancel();
    _runMarketplaceListingSync();
    _marketplaceSyncTimer = Timer.periodic(interval, (_) => _runMarketplaceListingSync());
    appLogger.i('AutomationScheduler: marketplace listing sync started with interval $interval');
  }

  Future<void> _runMarketplaceListingSync() async {
    try {
      final synced = await marketplaceListingSyncService.syncListingsStock();
      lastMarketplaceSyncTime = DateTime.now();
      await _saveState();
      if (synced > 0) {
        appLogger.i('AutomationScheduler: marketplace listing sync complete - $synced listings updated');
      }
    } catch (e, st) {
      appLogger.e('AutomationScheduler: marketplace listing sync failed', error: e, stackTrace: st);
    }
  }

  void startProductRefresh({Duration interval = const Duration(hours: 2)}) {
    _productRefreshTimer?.cancel();
    _runProductRefresh();
    _productRefreshTimer = Timer.periodic(interval, (_) => _runProductRefresh());
    appLogger.i('AutomationScheduler: product refresh from source started with interval $interval');
  }

  Future<void> _runProductRefresh() async {
    try {
      final refreshed = await marketplaceListingSyncService.refreshProductsFromSource();
      lastProductRefreshTime = DateTime.now();
      await _saveState();
      if (refreshed > 0) {
        appLogger.i('AutomationScheduler: product refresh complete - $refreshed products updated from source');
      }
    } catch (e, st) {
      appLogger.e('AutomationScheduler: product refresh failed', error: e, stackTrace: st);
    }
  }

  void startLowStockRefresh({Duration interval = const Duration(minutes: 30)}) {
    _lowStockRefreshTimer?.cancel();
    _runLowStockRefresh();
    _lowStockRefreshTimer = Timer.periodic(interval, (_) => _runLowStockRefresh());
    appLogger.i('AutomationScheduler: low-stock product refresh started with interval $interval');
  }

  Future<void> _runLowStockRefresh() async {
    try {
      final refreshed = await marketplaceListingSyncService.refreshProductsFromSourceLowStock(maxStock: 5);
      lastLowStockRefreshTime = DateTime.now();
      await _saveState();
      if (refreshed > 0) {
        appLogger.i('AutomationScheduler: low-stock refresh complete - $refreshed products updated');
      }
    } catch (e, st) {
      appLogger.e('AutomationScheduler: low-stock refresh failed', error: e, stackTrace: st);
    }
  }

  Future<void> _runPriceRefresh() async {
    try {
      final refreshed = await priceRefreshService.refreshStaleOffers();
      lastPriceRefreshTime = DateTime.now();
      await _saveState();
      appLogger.i('AutomationScheduler: price refresh complete - $refreshed offers refreshed');
    } catch (e, st) {
      appLogger.e('AutomationScheduler: price refresh failed', error: e, stackTrace: st);
    }
  }

  Future<void> _runScan() async {
    if (_scanning) return;
    _scanning = true;
    try {
      final result = await scanner.run();
      lastScanTime = DateTime.now();
      await _saveState();
      appLogger.i('AutomationScheduler: scan complete - ${result.candidatesFound} candidates, ${result.listingsCreated} listings');
    } catch (e, st) {
      appLogger.e('AutomationScheduler: scan failed', error: e, stackTrace: st);
    } finally {
      _scanning = false;
    }
  }

  Future<void> _runSync() async {
    if (_syncing) return;
    _syncing = true;
    try {
      final since = lastSyncTime ?? DateTime.now().subtract(const Duration(days: 1));
      final added = await orderSyncService.syncOrders(since);
      lastSyncTime = DateTime.now();
      await _saveState();
      appLogger.i('AutomationScheduler: synced $added new orders');

      final rules = await rulesRepository.get();
      if (!rules.manualApprovalOrders) {
        final pending = await orderSyncService.orderRepository.getByStatus(OrderStatus.pending);
        for (final order in pending) {
          try {
            await fulfillmentService.fulfillOrder(order);
          } catch (e) {
            appLogger.e('AutomationScheduler: auto-fulfill ${order.id} failed', error: e);
          }
        }
      }
    } catch (e, st) {
      appLogger.e('AutomationScheduler: sync failed', error: e, stackTrace: st);
    } finally {
      _syncing = false;
    }
  }
}
