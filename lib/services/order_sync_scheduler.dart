import 'dart:async';

import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';
import 'package:jurassic_dropshipping/services/order_sync_service.dart';

/// Periodically polls target platforms for new orders and optionally auto-fulfills them.
class OrderSyncScheduler {
  OrderSyncScheduler({
    required this.orderSyncService,
    required this.fulfillmentService,
    required this.rulesRepository,
  });

  final OrderSyncService orderSyncService;
  final FulfillmentService fulfillmentService;
  final RulesRepository rulesRepository;

  Timer? _timer;
  DateTime? _lastSyncTime;
  bool _running = false;

  bool get isRunning => _timer != null && _timer!.isActive;
  DateTime? get lastSyncTime => _lastSyncTime;

  /// Start the periodic sync. Interval is read from UserRules.scanIntervalMinutes.
  Future<void> start({Duration? overrideInterval}) async {
    if (isRunning) return;
    final rules = await rulesRepository.get();
    final interval = overrideInterval ?? Duration(minutes: rules.scanIntervalMinutes);
    appLogger.i('OrderSyncScheduler: starting with interval $interval');

    await _runOnce();

    _timer = Timer.periodic(interval, (_) => _runOnce());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    appLogger.i('OrderSyncScheduler: stopped');
  }

  Future<void> _runOnce() async {
    if (_running) return;
    _running = true;
    try {
      final since = _lastSyncTime ?? DateTime.now().subtract(const Duration(days: 1));
      final added = await orderSyncService.syncOrders(since);
      _lastSyncTime = DateTime.now();
      appLogger.i('OrderSyncScheduler: synced $added new orders');

      if (added > 0) {
        await _autoFulfillIfEnabled();
      }
    } catch (e, st) {
      appLogger.e('OrderSyncScheduler: sync failed', error: e, stackTrace: st);
    } finally {
      _running = false;
    }
  }

  Future<void> _autoFulfillIfEnabled() async {
    final rules = await rulesRepository.get();
    if (rules.manualApprovalOrders) return;

    final pendingOrders = await orderSyncService.orderRepository.getByStatus(
      OrderStatus.pending,
    );
    for (final order in pendingOrders) {
      try {
        await fulfillmentService.fulfillOrder(order);
        appLogger.i('OrderSyncScheduler: auto-fulfilled order ${order.id}');
      } catch (e, st) {
        appLogger.e('OrderSyncScheduler: auto-fulfill ${order.id} failed',
            error: e, stackTrace: st);
      }
    }
  }
}
