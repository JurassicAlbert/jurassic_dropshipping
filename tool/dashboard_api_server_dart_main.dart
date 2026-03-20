import 'dart:convert';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/financial_ledger_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/incident_record_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_health_metrics_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/marketplace_account_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/returned_stock_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_return_policy_repository.dart';
import 'package:jurassic_dropshipping/features/analytics/analytics_engine.dart';
import 'package:jurassic_dropshipping/services/seed_service.dart';
import 'package:path/path.dart' as p;

Future<void> main() async {
  const port = 4000;

  final dbFile = _defaultDbFile();
  final dbFolder = File(dbFile).parent;
  if (!await dbFolder.exists()) {
    await dbFolder.create(recursive: true);
  }

  final executor = NativeDatabase.createInBackground(File(dbFile));
  final database = AppDatabase.forTesting(executor);

  const tenantId = 1;

  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final listingRepo = ListingRepository(database, tenantId: tenantId);
  final returnRepo = ReturnRepository(database, tenantId: tenantId);
  final supplierRepo = SupplierRepository(database, tenantId: tenantId);

  // Ensure there's something to display.
  final existingOrders = await orderRepo.getAll();
  if (existingOrders.isEmpty) {
    // ignore: avoid_print
    print('DB empty: seeding demo data...');

    final productRepo = ProductRepository(database, tenantId: tenantId);
    final supplierOfferRepo = SupplierOfferRepository(database, tenantId: tenantId);
    final decisionLogRepo = DecisionLogRepository(database, tenantId: tenantId);
    final rulesRepo = RulesRepository(database, tenantId: tenantId);

    final seed = SeedService(
      db: database,
      productRepository: productRepo,
      listingRepository: listingRepo,
      orderRepository: orderRepo,
      supplierRepository: supplierRepo,
      supplierOfferRepository: supplierOfferRepo,
      returnRepository: returnRepo,
      decisionLogRepository: decisionLogRepo,
      rulesRepository: rulesRepo,
    );
    await seed.seedAll();
  }

  // ignore: avoid_print
  print('Dashboard API listening on http://127.0.0.1:$port');

  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
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
        final payload = await _computeDashboardPayload(
          database: database,
          tenantId: tenantId,
        );
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/orders') {
        final payload = await _computeOrdersPayload(
          database: database,
          tenantId: tenantId,
        );
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/products') {
        final payload = await _computeProductsPayload(
          database: database,
          tenantId: tenantId,
        );
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/suppliers') {
        final payload = await _computeSuppliersPayload(
          database: database,
          tenantId: tenantId,
        );
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/marketplaces') {
        final payload = await _computeMarketplacesPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/returns') {
        final payload = await _computeReturnsPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/incidents') {
        final payload = await _computeIncidentsPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/risk-dashboard') {
        final payload = await _computeRiskDashboardPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/returned-stock') {
        final payload = await _computeReturnedStockPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/capital') {
        final payload = await _computeCapitalPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/approval') {
        final payload = await _computeApprovalPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/decision-log') {
        final payload = await _computeDecisionLogPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/return-policies') {
        final payload = await _computeReturnPoliciesPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/profit-dashboard') {
        final payload = await _computeProfitDashboardPayload(database: database, tenantId: tenantId);
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(payload))
          ..close();
        continue;
      }

      if (request.uri.path == '/how-it-works') {
        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode({
            'sections': [
              {'title': 'Scanning', 'description': 'Scanner evaluates source catalog and applies decision rules.'},
              {'title': 'Pricing', 'description': 'Pricing calculator and strategy rules derive listing prices.'},
              {'title': 'Approvals', 'description': 'Manual approval queues can gate listing/order execution.'},
              {'title': 'Fulfillment', 'description': 'Orders progress through lifecycle and financial states.'},
              {'title': 'Risk', 'description': 'Risk and health scoring identify anomalies and auto-pausing signals.'},
            ],
            'placeholder': false,
          }))
          ..close();
        continue;
      }

      if (request.uri.pathSegments.length == 2 && request.uri.pathSegments.first == 'suppliers') {
        final supplierId = request.uri.pathSegments[1];
        final payload = await _computeSupplierDetailPayload(database: database, tenantId: tenantId, supplierId: supplierId);
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

Future<Map<String, dynamic>> _computeDashboardPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final listingRepo = ListingRepository(database, tenantId: tenantId);
  final returnRepo = ReturnRepository(database, tenantId: tenantId);
  final supplierRepo = SupplierRepository(database, tenantId: tenantId);

  final orders = await orderRepo.getAll();
  final listings = await listingRepo.getAll();
  final returns = await returnRepo.getAll();
  final suppliers = await supplierRepo.getAll();

  final engine = AnalyticsEngine(
    orders: orders,
    listings: listings,
    returns: returns,
    suppliers: suppliers,
  );

  final pausedCount = listings.where((l) => l.status.name == 'paused').length;

  // Compute high return rate from returns linked to orders.
  final ordersById = {for (final o in orders) o.id: o};
  final shippedOrDeliveredByListing = <String, int>{};
  final returnCountByListing = <String, int>{};

  for (final o in orders) {
    final listingId = o.listingId;
    final isShipped = o.status == OrderStatus.shipped || o.status == OrderStatus.delivered;
    if (!isShipped) continue;
    shippedOrDeliveredByListing.update(listingId, (v) => v + 1, ifAbsent: () => 1);
  }

  for (final r in returns) {
    final ord = ordersById[r.orderId];
    if (ord == null) continue;
    final listingId = ord.listingId;
    returnCountByListing.update(listingId, (v) => v + 1, ifAbsent: () => 1);
  }

  final highReturnRateCount = shippedOrDeliveredByListing.entries.where((e) {
    final shippedCount = e.value;
    if (shippedCount <= 0) return false;
    final ret = returnCountByListing[e.key] ?? 0;
    final ratePct = (ret / shippedCount) * 100;
    return ratePct >= 20.0;
  }).length;

  final queuedNow = orders.where((o) => o.queuedForCapital).length;

  // Recent orders (latest 8 by createdAt).
  final recentOrders = orders.take(8).map((o) {
    final profit = (o.sellingPrice - o.sourceCost) * o.quantity;
    final risk = o.riskScore ?? 0;
    final status = switch (o.status) {
      OrderStatus.shipped || OrderStatus.delivered => 'shipped',
      OrderStatus.failed || OrderStatus.failedOutOfStock => 'failed',
      _ => 'pending',
    };
    return {
      'orderId': o.targetOrderId,
      'platform': o.targetPlatformId,
      'status': status,
      'profit': profit,
      'risk': risk,
    };
  }).toList();

  final daily = engine.dailyProfit(days: 7);
  final profitPoints = daily.map((d) {
    return {
      'day': _weekdayShort(d.date),
      'profit': d.profit,
    };
  }).toList();

  final kpis = <Map<String, dynamic>>[
    {
      'label': 'Revenue (30d)',
      'value': '${engine.totalRevenue.toStringAsFixed(0)} PLN',
      'delta': '+0.0%',
      'chipTone': 'primary',
    },
    {
      'label': 'Profit (30d)',
      'value': '${engine.totalProfit.toStringAsFixed(0)} PLN',
      'delta': engine.totalProfit >= 0 ? '+0.0%' : '-0.0%',
      'chipTone': engine.totalProfit >= 0 ? 'success' : 'error',
    },
    {
      'label': 'Return rate',
      'value': '${engine.returnRatePercent.toStringAsFixed(1)}%',
      'delta': '+0.0%',
      'chipTone': engine.returnRatePercent <= 5 ? 'success' : 'warning',
    },
    {
      'label': 'Queued for capital',
      'value': '$queuedNow',
      'delta': '0',
      'chipTone': 'warning',
    },
  ];

  final signals = <Map<String, dynamic>>[
    {
      'title': 'Auto-paused listings',
      'subtitle': '$pausedCount listings paused in last 24h',
      'tone': 'primary',
    },
    {
      'title': 'Capital queue',
      'subtitle': '$queuedNow orders waiting for capital',
      'tone': 'warning',
    },
    {
      'title': 'High return rate',
      'subtitle': '$highReturnRateCount listings above threshold',
      'tone': 'error',
    },
  ];

  return {
    'kpis': kpis,
    'profitPoints': profitPoints,
    'profitByPlatform': engine.profitByPlatform.entries
        .map((e) => {
              'platformId': e.key,
              'revenue': e.value.revenue,
              'cost': e.value.cost,
              'profit': e.value.profit,
              'marginPercent': e.value.marginPercent,
              'orderCount': e.value.orderCount,
            })
        .toList(),
    'profitByMarginBand': engine.profitByMarginBand().entries
        .map((e) => {'band': e.key, 'profit': e.value})
        .toList(),
    'returnsByReason': engine.returnsByReason.entries
        .map((e) => {'reason': e.key.name, 'count': e.value})
        .toList(),
    'issues': engine.issues
        .map((i) => {
              'severity': i.severity.name,
              'title': i.title,
              'description': i.description,
              'entityId': i.entityId,
            })
        .toList(),
    'signals': signals,
    'recentOrders': recentOrders,
  };
}

String _weekdayShort(DateTime dt) {
  const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  return days[dt.weekday % 7 == 0 ? 0 : dt.weekday];
}

String _defaultDbFile() {
  final userProfile = Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'] ?? '.';
  return p.join(userProfile, '.jurassic_dropshipping', 'jurassic_dropshipping.db');
}

Future<Map<String, dynamic>> _computeOrdersPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final orders = await orderRepo.getAll();

  final statusCounts = <String, int>{};
  for (final o in orders) {
    statusCounts.update(o.status.name, (v) => v + 1, ifAbsent: () => 1);
  }

  final rows = orders.take(80).map((o) {
    final profit = (o.sellingPrice - o.sourceCost) * o.quantity;
    return {
      'id': o.id,
      'targetOrderId': o.targetOrderId,
      'platform': o.targetPlatformId,
      'listingId': o.listingId,
      'status': o.status.name,
      'quantity': o.quantity,
      'sellingPrice': o.sellingPrice,
      'sourceCost': o.sourceCost,
      'profit': profit,
      'riskScore': o.riskScore,
      'queuedForCapital': o.queuedForCapital,
      'createdAt': _toIso(o.createdAt),
      'approvedAt': _toIso(o.approvedAt),
      'deliveredAt': _toIso(o.deliveredAt),
    };
  }).toList();

  return {
    'summary': {
      'total': orders.length,
      'queuedForCapital': orders.where((o) => o.queuedForCapital).length,
      'statusCounts': statusCounts,
    },
    'rows': rows,
  };
}

Future<Map<String, dynamic>> _computeProductsPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final productRepo = ProductRepository(database, tenantId: tenantId);
  final listingRepo = ListingRepository(database, tenantId: tenantId);
  final products = await productRepo.getAll();
  final listings = await listingRepo.getAll();

  final listingsByProduct = <String, List<dynamic>>{};
  for (final l in listings) {
    listingsByProduct.putIfAbsent(l.productId, () => []).add(l);
  }

  final rows = products.map((p) {
    final productListings = (listingsByProduct[p.id] ?? []).cast<dynamic>();
    final listingCount = productListings.length;
    final activeCount = productListings.where((l) => _enumName(l.status) == 'active').length;

    double avgMarginPercent = 0;
    if (listingCount > 0) {
      final margins = productListings
          .map((l) => l.sellingPrice > 0 ? ((l.sellingPrice - l.sourceCost) / l.sellingPrice) * 100 : 0.0)
          .toList();
      avgMarginPercent = margins.reduce((a, b) => a + b) / listingCount;
    }

    return {
      'id': p.id,
      'title': p.title,
      'sourcePlatformId': p.sourcePlatformId,
      'supplierId': p.supplierId,
      'supplierCountry': p.supplierCountry,
      'basePrice': p.basePrice,
      'shippingCost': p.shippingCost,
      'currency': p.currency,
      'estimatedDays': p.estimatedDays,
      'listingCount': listingCount,
      'activeListingCount': activeCount,
      'avgMarginPercent': avgMarginPercent,
    };
  }).toList();

  return {
    'summary': {
      'total': products.length,
      'withActiveListings': rows.where((r) => (r['activeListingCount'] as int) > 0).length,
    },
    'rows': rows,
  };
}

Future<Map<String, dynamic>> _computeSuppliersPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final supplierRepo = SupplierRepository(database, tenantId: tenantId);
  final productRepo = ProductRepository(database, tenantId: tenantId);
  final listingRepo = ListingRepository(database, tenantId: tenantId);
  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final returnRepo = ReturnRepository(database, tenantId: tenantId);

  final suppliers = await supplierRepo.getAll();
  final products = await productRepo.getAll();
  final listings = await listingRepo.getAll();
  final orders = await orderRepo.getAll();
  final returns = await returnRepo.getAll();

  final productById = {for (final p in products) p.id: p};
  final productsBySupplier = <String, List<dynamic>>{};
  for (final p in products) {
    final sid = p.supplierId;
    if (sid == null || sid.isEmpty) continue;
    productsBySupplier.putIfAbsent(sid, () => []).add(p);
  }

  final listingsBySupplier = <String, List<dynamic>>{};
  for (final l in listings) {
    final p = productById[l.productId];
    final sid = p?.supplierId;
    if (sid == null || sid.isEmpty) continue;
    listingsBySupplier.putIfAbsent(sid, () => []).add(l);
  }

  final listingById = {for (final l in listings) l.id: l};
  final ordersBySupplier = <String, List<dynamic>>{};
  for (final o in orders) {
    final listing = listingById[o.listingId];
    final product = listing != null ? productById[listing.productId] : null;
    final sid = product?.supplierId;
    if (sid == null || sid.isEmpty) continue;
    ordersBySupplier.putIfAbsent(sid, () => []).add(o);
  }

  final returnsBySupplier = <String, int>{};
  for (final r in returns) {
    final sid = r.supplierId;
    if (sid == null || sid.isEmpty) continue;
    returnsBySupplier.update(sid, (v) => v + 1, ifAbsent: () => 1);
  }

  final rows = suppliers.map((s) {
    final supplierProducts = (productsBySupplier[s.id] ?? []).cast<dynamic>();
    final supplierListings = (listingsBySupplier[s.id] ?? []).cast<dynamic>();
    final supplierOrders = (ordersBySupplier[s.id] ?? []).cast<dynamic>();
    final returnCount = returnsBySupplier[s.id] ?? 0;

    final activeListings = supplierListings.where((l) => _enumName(l.status) == 'active').length;
    double avgOrderProfit = 0;
    if (supplierOrders.isNotEmpty) {
      final sum = supplierOrders
          .map((o) => (o.sellingPrice - o.sourceCost) * o.quantity)
          .fold<double>(0.0, (a, b) => a + b);
      avgOrderProfit = sum / supplierOrders.length;
    }

    return {
      'id': s.id,
      'name': s.name,
      'platformType': s.platformType,
      'countryCode': s.countryCode,
      'rating': s.rating,
      'productsCount': supplierProducts.length,
      'listingsCount': supplierListings.length,
      'activeListingsCount': activeListings,
      'ordersCount': supplierOrders.length,
      'returnsCount': returnCount,
      'avgOrderProfit': avgOrderProfit,
    };
  }).toList();

  return {
    'summary': {
      'total': suppliers.length,
      'withActiveListings': rows.where((r) => (r['activeListingsCount'] as int) > 0).length,
    },
    'rows': rows,
  };
}

String? _toIso(DateTime? value) => value?.toIso8601String();
String _enumName(Object value) => value.toString().split('.').last;

Future<Map<String, dynamic>> _computeMarketplacesPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final repo = MarketplaceAccountRepository(database, tenantId: tenantId);
  final accounts = await repo.getAll();
  return {
    'summary': {
      'total': accounts.length,
      'active': accounts.where((a) => a.isActive).length,
    },
    'rows': accounts
        .map((a) => {
              'id': a.id,
              'platformId': a.platformId,
              'displayName': a.displayName,
              'isActive': a.isActive,
              'connectedAt': _toIso(a.connectedAt),
            })
        .toList(),
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeReturnsPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final repo = ReturnRepository(database, tenantId: tenantId);
  final returns = await repo.getAll();
  final byStatus = <String, int>{};
  for (final r in returns) {
    byStatus.update(_enumName(r.status), (v) => v + 1, ifAbsent: () => 1);
  }
  return {
    'summary': {'total': returns.length, 'statusCounts': byStatus},
    'rows': returns
        .map((r) => {
              'id': r.id,
              'orderId': r.orderId,
              'status': _enumName(r.status),
              'reason': _enumName(r.reason),
              'refundAmount': r.refundAmount,
              'requestedAt': _toIso(r.requestedAt),
              'resolvedAt': _toIso(r.resolvedAt),
            })
        .toList(),
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeIncidentsPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final repo = IncidentRecordRepository(database, tenantId: tenantId);
  final incidents = await repo.getAll();
  return {
    'summary': {
      'total': incidents.length,
      'open': incidents.where((i) => _enumName(i.status) != 'resolved').length,
    },
    'rows': incidents
        .map((i) => {
              'id': i.id,
              'orderId': i.orderId,
              'incidentType': _enumName(i.incidentType),
              'status': _enumName(i.status),
              'financialImpact': i.financialImpact,
              'createdAt': _toIso(i.createdAt),
              'resolvedAt': _toIso(i.resolvedAt),
            })
        .toList(),
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeRiskDashboardPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final listingHealthRepo = ListingHealthMetricsRepository(database, tenantId: tenantId);
  final orders = await orderRepo.getAll();
  final listingHealth = await listingHealthRepo.getAll();

  final highRiskOrders = orders.where((o) => (o.riskScore ?? 0) >= 70).length;
  final mediumRiskOrders = orders.where((o) => (o.riskScore ?? 0) >= 40 && (o.riskScore ?? 0) < 70).length;
  final healthAlerts = listingHealth.where((h) => h.totalOrders > 0 && (h.returnOrIncidentCount / h.totalOrders) >= 0.2).length;

  return {
    'summary': {
      'highRiskOrders': highRiskOrders,
      'mediumRiskOrders': mediumRiskOrders,
      'listingHealthAlerts': healthAlerts,
    },
    'rows': orders
        .take(100)
        .map((o) => {
              'targetOrderId': o.targetOrderId,
              'platform': o.targetPlatformId,
              'status': _enumName(o.status),
              'riskScore': o.riskScore ?? 0,
            })
        .toList(),
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeReturnedStockPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final repo = ReturnedStockRepository(database, tenantId: tenantId);
  final stock = await repo.getAll();
  return {
    'summary': {
      'rows': stock.length,
      'restockableUnits': stock.where((s) => s.restockable).fold<int>(0, (a, b) => a + b.quantity),
    },
    'rows': stock
        .map((s) => {
              'id': s.id,
              'productId': s.productId,
              'supplierId': s.supplierId,
              'condition': s.condition,
              'quantity': s.quantity,
              'restockable': s.restockable,
              'createdAt': _toIso(s.createdAt),
            })
        .toList(),
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeCapitalPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final ledgerRepo = FinancialLedgerRepository(database, tenantId: tenantId);
  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final balance = await ledgerRepo.getBalance();
  final entries = await ledgerRepo.getRecentEntries(limit: 100);
  final orders = await orderRepo.getAll();

  return {
    'summary': {
      'balance': balance,
      'queuedForCapital': orders.where((o) => o.queuedForCapital).length,
      'entries': entries.length,
    },
    'rows': entries
        .map((e) => {
              'id': e.id,
              'type': e.type,
              'amount': e.amount,
              'currency': e.currency,
              'orderId': e.orderId,
              'createdAt': _toIso(e.createdAt),
            })
        .toList(),
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeApprovalPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final listingRepo = ListingRepository(database, tenantId: tenantId);
  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final listings = await listingRepo.getPendingApproval();
  final orders = await orderRepo.getPendingApproval();

  return {
    'summary': {
      'pendingListings': listings.length,
      'pendingOrders': orders.length,
    },
    'pendingListings': listings
        .map((l) => {
              'id': l.id,
              'productId': l.productId,
              'platform': l.targetPlatformId,
              'sellingPrice': l.sellingPrice,
            })
        .toList(),
    'pendingOrders': orders
        .map((o) => {
              'id': o.id,
              'targetOrderId': o.targetOrderId,
              'platform': o.targetPlatformId,
              'riskScore': o.riskScore ?? 0,
            })
        .toList(),
    'placeholder': true,
    'placeholderReason': 'Write actions (approve/reject) to be connected to external marketplace APIs.',
  };
}

Future<Map<String, dynamic>> _computeDecisionLogPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final repo = DecisionLogRepository(database, tenantId: tenantId);
  final logs = await repo.getAll(limit: 200);
  return {
    'summary': {'total': logs.length},
    'rows': logs
        .map((l) => {
              'id': l.id,
              'type': _enumName(l.type),
              'entityId': l.entityId,
              'reason': l.reason,
              'financialImpact': l.financialImpact,
              'createdAt': _toIso(l.createdAt),
            })
        .toList(),
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeReturnPoliciesPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final repo = SupplierReturnPolicyRepository(database, tenantId: tenantId);
  final policies = await repo.getAll();
  return {
    'summary': {'total': policies.length},
    'rows': policies
        .map((p) => {
              'id': p.id,
              'supplierId': p.supplierId,
              'policyType': _enumName(p.policyType),
              'returnWindowDays': p.returnWindowDays,
              'restockingFeePercent': p.restockingFeePercent,
              'returnShippingPaidBy': p.returnShippingPaidBy != null ? _enumName(p.returnShippingPaidBy!) : null,
              'requiresRma': p.requiresRma,
            })
        .toList(),
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeProfitDashboardPayload({
  required AppDatabase database,
  required int tenantId,
}) async {
  final dashboard = await _computeDashboardPayload(database: database, tenantId: tenantId);
  return {
    'summary': {
      'kpis': dashboard['kpis'],
      'profitByPlatform': dashboard['profitByPlatform'],
      'profitByMarginBand': dashboard['profitByMarginBand'],
    },
    'placeholder': false,
  };
}

Future<Map<String, dynamic>> _computeSupplierDetailPayload({
  required AppDatabase database,
  required int tenantId,
  required String supplierId,
}) async {
  final supplierRepo = SupplierRepository(database, tenantId: tenantId);
  final productRepo = ProductRepository(database, tenantId: tenantId);
  final listingRepo = ListingRepository(database, tenantId: tenantId);
  final orderRepo = OrderRepository(database, tenantId: tenantId);
  final policyRepo = SupplierReturnPolicyRepository(database, tenantId: tenantId);

  final supplier = await supplierRepo.getById(supplierId);
  final products = await productRepo.getAll();
  final listings = await listingRepo.getAll();
  final orders = await orderRepo.getAll();
  final policy = await policyRepo.getBySupplierId(supplierId);

  if (supplier == null) {
    return {'error': 'not_found', 'supplierId': supplierId};
  }

  final supplierProducts = products.where((p) => p.supplierId == supplierId).map((p) => p.id).toSet();
  final supplierListings = listings.where((l) => supplierProducts.contains(l.productId)).toList();
  final listingIds = supplierListings.map((l) => l.id).toSet();
  final supplierOrders = orders.where((o) => listingIds.contains(o.listingId)).toList();

  return {
    'supplier': {
      'id': supplier.id,
      'name': supplier.name,
      'platformType': supplier.platformType,
      'countryCode': supplier.countryCode,
      'rating': supplier.rating,
    },
    'summary': {
      'products': supplierProducts.length,
      'listings': supplierListings.length,
      'orders': supplierOrders.length,
      'activeListings': supplierListings.where((l) => _enumName(l.status) == 'active').length,
    },
    'policy': policy == null
        ? null
        : {
            'policyType': _enumName(policy.policyType),
            'returnWindowDays': policy.returnWindowDays,
            'requiresRma': policy.requiresRma,
            'returnShippingPaidBy': policy.returnShippingPaidBy != null ? _enumName(policy.returnShippingPaidBy!) : null,
          },
    'placeholder': false,
  };
}

