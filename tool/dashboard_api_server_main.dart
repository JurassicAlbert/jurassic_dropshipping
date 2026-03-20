import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_health_metrics_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_repository.dart';
import 'package:jurassic_dropshipping/features/analytics/analytics_engine.dart';

/// Run a tiny local HTTP server for the Next.js dashboard to consume.
///
/// Usage:
///   flutter run -d windows -t tool/dashboard_api_server_main.dart
/// Then:
///   GET http://127.0.0.1:4000/dashboard
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const port = 4000;
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
  // ignore: avoid_print
  print('Dashboard API listening on http://127.0.0.1:$port');

  await for (final request in server) {
    try {
      if (request.uri.path == '/health') {
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode({'ok': true}))
          ..close();
        continue;
      }

      if (request.uri.path == '/dashboard') {
        final payload = await _computeDashboardPayload();
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      request.response
        ..statusCode = 404
        ..headers.contentType = ContentType.json
        ..write(jsonEncode({'error': 'not_found'}))
        ..close();
    } catch (e, st) {
      // ignore: avoid_print
      print('Dashboard API error: $e\n$st');
      request.response
        ..statusCode = 500
        ..headers.contentType = ContentType.json
        ..write(jsonEncode({'error': 'internal_error'}))
        ..close();
    }
  }
}

Future<Map<String, dynamic>> _computeDashboardPayload() async {
  // This uses your existing Drift database wiring (IO storage path).
  final database = AppDatabase();
  const tenantId = 1;

  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final listingRepo = ListingRepository(database, tenantId: tenantId);
  final returnRepo = ReturnRepository(database, tenantId: tenantId);
  final supplierRepo = SupplierRepository(database, tenantId: tenantId);
  final listingHealthRepo = ListingHealthMetricsRepository(database, tenantId: tenantId);

  final orders = await orderRepo.getAll();
  final listings = await listingRepo.getAll();
  final returns = await returnRepo.getAll();
  final suppliers = await supplierRepo.getAll();
  final listingHealth = await listingHealthRepo.getAll();

  final engine = AnalyticsEngine(
    orders: orders,
    listings: listings,
    returns: returns,
    suppliers: suppliers,
  );

  final now = DateTime.now();
  final period = const Duration(days: 30);
  final prevStart = now.subtract(period * 2);
  final prevEnd = now.subtract(period);

  final ordersThis = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(now.subtract(period))).toList();
  final ordersPrev = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(prevStart) && o.createdAt!.isBefore(prevEnd)).toList();

  double revenueSum(List ordersList) =>
      ordersList.fold<double>(0, (s, o) => s + (o.sellingPrice * o.quantity));
  double costSum(List ordersList) =>
      ordersList.fold<double>(0, (s, o) => s + (o.sourceCost * o.quantity));

  final revenueThis = revenueSum(ordersThis);
  final costThis = costSum(ordersThis);
  final profitThis = revenueThis - costThis;

  final revenuePrev = revenueSum(ordersPrev);
  final costPrev = costSum(ordersPrev);
  final profitPrev = revenuePrev - costPrev;

  // Return rate delta uses the same logic as Flutter: returns / shipped_or_delivered.
  int shippedOrDeliveredCount(List<Order> ords) =>
      ords.where((o) => o.status == OrderStatus.shipped || o.status == OrderStatus.delivered).length;

  // We don't have dedicated return period query; approximate by matching return's order shipping date isn't available here.
  // For dashboard wiring, we keep return KPIs as current totals.
  final shippedOrDeliveredThis = shippedOrDeliveredCount(ordersThis);
  final shippedOrDeliveredPrev = shippedOrDeliveredCount(ordersPrev);

  final returnRateThis = shippedOrDeliveredThis > 0 ? (returns.length / shippedOrDeliveredThis) * 100 : 0.0;
  final returnRatePrev = shippedOrDeliveredPrev > 0 ? (returns.length / shippedOrDeliveredPrev) * 100 : 0.0;

  double pctDelta(double curr, double prev) {
    if (prev == 0) return curr == 0 ? 0 : 100;
    return ((curr - prev) / prev) * 100;
  }

  int queuedNow = orders.where((o) => o.queuedForCapital).length;
  // queuedForCapital doesn't have a historical column; so we show 0 delta.
  int queuedPrev = queuedNow;

  Map<String, dynamic> kpi(String label, String value, String delta, String chipTone, {bool trimPlus = true}) {
    return {'label': label, 'value': value, 'delta': delta, 'chipTone': chipTone};
  }

  String formatPct(double v) {
    final s = v >= 0 ? '+' : '';
    return '$s${v.toStringAsFixed(1)}%';
  }

  final kpis = <Map<String, dynamic>>[
    kpi(
      'Revenue (30d)',
      '${engine.totalRevenue.toStringAsFixed(0)} PLN',
      formatPct(pctDelta(revenueThis, revenuePrev)),
      'primary',
    ),
    kpi(
      'Profit (30d)',
      '${profitThis.toStringAsFixed(0)} PLN',
      formatPct(pctDelta(profitThis, profitPrev)),
      'success',
    ),
    kpi(
      'Return rate',
      '${engine.returnRatePercent.toStringAsFixed(1)}%',
      formatPct(pctDelta(returnRateThis, returnRatePrev)),
      returnRateThis <= returnRatePrev ? 'success' : 'warning',
    ),
    kpi(
      'Queued for capital',
      '$queuedNow',
      queuedNow == queuedPrev ? '0' : (queuedNow > queuedPrev ? '+${queuedNow - queuedPrev}' : '${queuedNow - queuedPrev}'),
      'warning',
    ),
  ];

  final daily = engine.dailyProfit(days: 7);
  final profitPoints = daily
      .map((d) => {
            'day': _weekdayShort(d.date),
            'profit': d.profit,
          })
      .toList();

  // Operational signals:
  // - auto-paused listings: listings currently paused
  // - capital queue: queuedForCapital orders
  // - high return rate: returnOrIncidentRate >= 20% among evaluated listing health records
  final pausedCount = listings.where((l) => l.status.name == 'paused').length;

  final healthByListing = {for (final r in listingHealth) r.listingId: r};
  final highReturnRateCount = healthByListing.values.where((h) {
    if (h.totalOrders <= 0) return false;
    final rate = (h.returnOrIncidentCount / h.totalOrders) * 100;
    return rate >= 20.0;
  }).length;

  final signals = <Map<String, dynamic>>[
    {'title': 'Auto-paused listings', 'subtitle': '$pausedCount listings paused in last 24h', 'tone': 'primary'},
    {'title': 'Capital queue', 'subtitle': '$queuedNow orders waiting for capital', 'tone': 'warning'},
    {'title': 'High return rate', 'subtitle': '$highReturnRateCount listings above threshold', 'tone': 'error'},
  ];

  // Recent orders (Latest 8):
  final recent = orders.take(8).toList();
  final recentOrders = recent.map((o) {
    final profit = (o.sellingPrice - o.sourceCost) * o.quantity;
    final risk = o.riskScore ?? 0;
    final status = switch (o.status) {
      OrderStatus.shipped || OrderStatus.delivered => 'shipped',
      OrderStatus.failed || OrderStatus.failedOutOfStock => 'failed',
      _ => 'pending'
    };
    return {
      'orderId': o.targetOrderId,
      'platform': o.targetPlatformId,
      'status': status,
      'profit': profit,
      'risk': risk,
    };
  }).toList();

  return {
    'kpis': kpis,
    'profitPoints': profitPoints,
    'signals': signals,
    'recentOrders': recentOrders,
  };
}

String _weekdayShort(DateTime dt) {
  const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  return days[dt.weekday % 7 == 0 ? 0 : dt.weekday];
}

