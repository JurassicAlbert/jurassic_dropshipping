import 'dart:async';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/scanner.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';
import 'package:jurassic_dropshipping/services/order_sync_service.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';

class AutomationScheduler {
  AutomationScheduler({
    required this.scanner,
    required this.orderSyncService,
    required this.fulfillmentService,
    required this.rulesRepository,
  });

  final Scanner scanner;
  final OrderSyncService orderSyncService;
  final FulfillmentService fulfillmentService;
  final RulesRepository rulesRepository;

  Timer? _scanTimer;
  Timer? _syncTimer;
  Timer? _priceRefreshTimer;
  
  DateTime? lastScanTime;
  DateTime? lastSyncTime;
  DateTime? lastPriceRefreshTime;
  
  bool _scanning = false;
  bool _syncing = false;

  bool get isScanRunning => _scanTimer?.isActive ?? false;
  bool get isSyncRunning => _syncTimer?.isActive ?? false;
  bool get isPriceRefreshRunning => _priceRefreshTimer?.isActive ?? false;

  Future<void> startAll() async {
    final rules = await rulesRepository.get();
    final interval = Duration(minutes: rules.scanIntervalMinutes);
    
    startScanner(interval: interval);
    startOrderSync(interval: interval);
    startPriceRefresh(interval: const Duration(hours: 6));
  }

  void stopAll() {
    _scanTimer?.cancel();
    _syncTimer?.cancel();
    _priceRefreshTimer?.cancel();
    _scanTimer = null;
    _syncTimer = null;
    _priceRefreshTimer = null;
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
    _priceRefreshTimer = Timer.periodic(interval, (_) {
      lastPriceRefreshTime = DateTime.now();
      appLogger.i('AutomationScheduler: price refresh tick (placeholder)');
    });
    appLogger.i('AutomationScheduler: price refresh started with interval $interval');
  }

  Future<void> _runScan() async {
    if (_scanning) return;
    _scanning = true;
    try {
      final result = await scanner.run();
      lastScanTime = DateTime.now();
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
      appLogger.i('AutomationScheduler: synced $added new orders');
      
      if (added > 0) {
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
      }
    } catch (e, st) {
      appLogger.e('AutomationScheduler: sync failed', error: e, stackTrace: st);
    } finally {
      _syncing = false;
    }
  }
}
