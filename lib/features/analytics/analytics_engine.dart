import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/domain/listing_health/listing_health_metrics.dart';

class AnalyticsEngine {
  AnalyticsEngine({
    required this.orders,
    required this.listings,
    required this.returns,
    required this.suppliers,
  });

  final List<Order> orders;
  final List<Listing> listings;
  final List<ReturnRequest> returns;
  final List<Supplier> suppliers;

  // ─── Summary KPIs ──────────────────────────────────
  double get totalRevenue => orders.fold(0, (s, o) => s + (o.sellingPrice * o.quantity));
  double get totalCost => orders.fold(0, (s, o) => s + (o.sourceCost * o.quantity));
  double get totalProfit => totalRevenue - totalCost;
  double get profitMarginPercent =>
      totalRevenue > 0 ? (totalProfit / totalRevenue) * 100 : 0;

  int get shippedOrDeliveredCount => orders
      .where(
          (o) => o.status == OrderStatus.shipped || o.status == OrderStatus.delivered)
      .length;
  double get returnRatePercent => shippedOrDeliveredCount > 0
      ? (returns.length / shippedOrDeliveredCount) * 100
      : 0;

  // ─── By Platform ──────────────────────────────────
  Map<String, PlatformStats> get profitByPlatform {
    final map = <String, PlatformStats>{};
    for (final o in orders) {
      map.update(
        o.targetPlatformId,
        (s) => s.addOrder(o.sellingPrice * o.quantity, o.sourceCost * o.quantity),
        ifAbsent: () => PlatformStats(o.targetPlatformId)
          ..addOrder(o.sellingPrice * o.quantity, o.sourceCost * o.quantity),
      );
    }
    return map;
  }

  // ─── By Product ──────────────────────────────────
  List<ProductStats> get profitByProduct {
    final map = <String, ProductStats>{};
    for (final o in orders) {
      map.update(
        o.listingId,
        (s) => s..addOrder(o.sellingPrice * o.quantity, o.sourceCost * o.quantity),
        ifAbsent: () =>
            ProductStats(o.listingId)..addOrder(o.sellingPrice * o.quantity, o.sourceCost * o.quantity),
      );
    }
    final sorted = map.values.toList()
      ..sort((a, b) => b.profit.compareTo(a.profit));
    return sorted.take(10).toList();
  }

  // ─── Issues Detection ──────────────────────────────
  List<AnalyticsIssue> get issues {
    final result = <AnalyticsIssue>[];

    final byProduct = <String, double>{};
    for (final o in orders) {
      byProduct.update(
        o.listingId,
        (v) => v + ((o.sellingPrice - o.sourceCost) * o.quantity),
        ifAbsent: () => (o.sellingPrice - o.sourceCost) * o.quantity,
      );
    }
    for (final entry in byProduct.entries) {
      if (entry.value < 0) {
        result.add(AnalyticsIssue(
          severity: IssueSeverity.critical,
          title: 'Negative profit on ${entry.key}',
          description: 'Total loss: ${entry.value.toStringAsFixed(2)} PLN',
          entityId: entry.key,
        ));
      }
    }

    final failedCount =
        orders.where((o) =>
            o.status == OrderStatus.failed ||
            o.status == OrderStatus.failedOutOfStock).length;
    if (failedCount > 0) {
      result.add(AnalyticsIssue(
        severity: IssueSeverity.warning,
        title: '$failedCount failed orders',
        description:
            'Orders that could not be fulfilled. Check source availability.',
      ));
    }

    for (final entry in byProduct.entries) {
      final listing = listings.where((l) => l.id == entry.key).firstOrNull;
      if (listing != null && listing.sellingPrice > 0) {
        final margin =
            (listing.sellingPrice - listing.sourceCost) / listing.sellingPrice *
                100;
        if (margin > 0 && margin < 15) {
          result.add(AnalyticsIssue(
            severity: IssueSeverity.warning,
            title: 'Low margin on ${entry.key}',
            description:
                'Margin: ${margin.toStringAsFixed(1)}% \u2014 consider raising price',
            entityId: entry.key,
          ));
        }
      }
    }

    return result;
  }

  // ─── Returns by Supplier ──────────────────────────
  Map<String, int> get returnsBySupplierId {
    final map = <String, int>{};
    for (final r in returns) {
      final key = r.supplierId ?? 'unknown';
      map.update(key, (v) => v + 1, ifAbsent: () => 1);
    }
    return map;
  }

  // ─── Returns by Reason ────────────────────────────
  Map<ReturnReason, int> get returnsByReason {
    final map = <ReturnReason, int>{};
    for (final r in returns) {
      map.update(r.reason, (v) => v + 1, ifAbsent: () => 1);
    }
    return map;
  }

  double get totalReturnCost {
    return returns.fold(
        0.0, (s, r) => s + (r.refundAmount ?? 0) + (r.returnShippingCost ?? 0));
  }

  // ─── Margin strategy KPIs ─────────────────────────
  /// Orders within [period] from now.
  List<Order> _ordersInPeriod(Duration period) {
    final since = DateTime.now().subtract(period);
    return orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(since)).toList();
  }

  /// Realized profit margin % for an order.
  static double orderMarginPercent(Order o) {
    if (o.sellingPrice <= 0) return 0;
    return ((o.sellingPrice - o.sourceCost) / o.sellingPrice) * 100;
  }

  /// Recommended minimum margin % so we stay profitable: use the minimum realized margin among orders that had positive profit in [period], or 0 if none.
  double recommendedMinMarginPercent({Duration period = const Duration(days: 30)}) {
    final list = _ordersInPeriod(period)
        .map((o) => orderMarginPercent(o))
        .where((m) => m > 0)
        .toList();
    if (list.isEmpty) return 0;
    list.sort();
    return list.first;
  }

  /// For a given product/listing: recommended min margin % from its orders in [period].
  double recommendedMinMarginForListing(String listingId, {Duration period = const Duration(days: 30)}) {
    final list = _ordersInPeriod(period)
        .where((o) => o.listingId == listingId)
        .map((o) => orderMarginPercent(o))
        .where((m) => m > 0)
        .toList();
    if (list.isEmpty) return 0;
    list.sort();
    return list.first;
  }

  /// Profit by margin band (e.g. "10-20%") for [period]. Keys are band labels, values are total profit in that band.
  Map<String, double> profitByMarginBand({Duration period = const Duration(days: 30)}) {
    const bands = [0.0, 10.0, 15.0, 20.0, 25.0, 50.0, 100.0];
    final result = <String, double>{};
    for (var i = 0; i < bands.length - 1; i++) {
      result['${bands[i].toInt()}-${bands[i + 1].toInt()}%'] = 0;
    }
    for (final o in _ordersInPeriod(period)) {
      final m = orderMarginPercent(o);
      final profit = (o.sellingPrice - o.sourceCost) * o.quantity;
      for (var i = 0; i < bands.length - 1; i++) {
        if (m >= bands[i] && m < bands[i + 1]) {
          result['${bands[i].toInt()}-${bands[i + 1].toInt()}%'] =
              (result['${bands[i].toInt()}-${bands[i + 1].toInt()}%'] ?? 0) + profit;
          break;
        }
      }
    }
    return result;
  }

  // ─── Daily profit for chart ───────────────────────
  List<DailyProfit> dailyProfit({int days = 30}) {
    final map = <DateTime, double>{};
    for (final o in orders) {
      if (o.createdAt == null) continue;
      final day =
          DateTime(o.createdAt!.year, o.createdAt!.month, o.createdAt!.day);
      map.update(day, (v) => v + (o.sellingPrice - o.sourceCost),
          ifAbsent: () => o.sellingPrice - o.sourceCost);
    }
    final sorted = map.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final lastN =
        sorted.length > days ? sorted.sublist(sorted.length - days) : sorted;
    return lastN
        .map((e) => DailyProfit(date: e.key, profit: e.value))
        .toList();
  }

  /// Per-day revenue, profit, and margin % (for admin charts).
  List<DailyRevenueProfit> dailyRevenueProfitSeries({int days = 30}) {
    final profitMap = <DateTime, double>{};
    final revenueMap = <DateTime, double>{};
    for (final o in orders) {
      if (o.createdAt == null) continue;
      final day =
          DateTime(o.createdAt!.year, o.createdAt!.month, o.createdAt!.day);
      final rev = o.sellingPrice * o.quantity;
      final cost = o.sourceCost * o.quantity;
      final p = rev - cost;
      profitMap.update(day, (v) => v + p, ifAbsent: () => p);
      revenueMap.update(day, (v) => v + rev, ifAbsent: () => rev);
    }
    final sortedKeys = profitMap.keys.toList()..sort();
    final lastN = sortedKeys.length > days
        ? sortedKeys.sublist(sortedKeys.length - days)
        : sortedKeys;
    return lastN
        .map((d) {
          final rev = revenueMap[d] ?? 0;
          final prof = profitMap[d] ?? 0;
          return DailyRevenueProfit(date: d, revenue: rev, profit: prof);
        })
        .toList();
  }

  Map<String, int> orderStatusCounts() {
    final m = <String, int>{};
    for (final o in orders) {
      m.update(o.status.name, (v) => v + 1, ifAbsent: () => 1);
    }
    return m;
  }

  /// Risk score buckets (0–100) for histogram.
  List<MapEntry<String, int>> riskScoreHistogramBuckets() {
    const labels = ['0–20', '21–40', '41–60', '61–80', '81–100'];
    final buckets = List<int>.filled(5, 0);
    for (final o in orders) {
      final r = o.riskScore ?? 0;
      final idx = (r / 20).floor();
      final i = idx < 0
          ? 0
          : idx > 4
              ? 4
              : idx;
      buckets[i]++;
    }
    return List.generate(5, (i) => MapEntry(labels[i], buckets[i]));
  }

  Map<String, int> listingStatusNameCounts() {
    final m = <String, int>{};
    for (final l in listings) {
      m.update(l.status.name, (v) => v + 1, ifAbsent: () => 1);
    }
    return m;
  }

  /// All listings with aggregate negative profit (from orders).
  List<ProductStats> lossMakingProducts() {
    final map = <String, ProductStats>{};
    for (final o in orders) {
      map.update(
        o.listingId,
        (s) => s..addOrder(o.sellingPrice * o.quantity, o.sourceCost * o.quantity),
        ifAbsent: () =>
            ProductStats(o.listingId)..addOrder(o.sellingPrice * o.quantity, o.sourceCost * o.quantity),
      );
    }
    final neg = map.values.where((p) => p.profit < 0).toList()
      ..sort((a, b) => a.profit.compareTo(b.profit));
    return neg;
  }

  /// Daily return rate % = returns that day / shipped+delivered orders that day (×100), capped sensibly.
  List<Map<String, dynamic>> dailyReturnRateSeries({int days = 30}) {
    final returnByDay = <DateTime, int>{};
    for (final r in returns) {
      final t = r.requestedAt ?? r.resolvedAt;
      if (t == null) continue;
      final day = DateTime(t.year, t.month, t.day);
      returnByDay.update(day, (v) => v + 1, ifAbsent: () => 1);
    }
    final shippedByDay = <DateTime, int>{};
    for (final o in orders) {
      if (o.createdAt == null) continue;
      if (o.status != OrderStatus.shipped && o.status != OrderStatus.delivered) {
        continue;
      }
      final day = DateTime(
        o.createdAt!.year,
        o.createdAt!.month,
        o.createdAt!.day,
      );
      shippedByDay.update(day, (v) => v + 1, ifAbsent: () => 1);
    }
    final allDays = {...returnByDay.keys, ...shippedByDay.keys}.toList()..sort();
    final lastN = allDays.length > days
        ? allDays.sublist(allDays.length - days)
        : allDays;
    return lastN.map((d) {
      final rc = returnByDay[d] ?? 0;
      final sc = shippedByDay[d] ?? 0;
      final rate = sc > 0 ? (rc / sc) * 100 : 0.0;
      return {
        'dayLabel': '${d.month}/${d.day}',
        'returnCount': rc,
        'shippedCount': sc,
        'returnRatePercent': rate,
      };
    }).toList();
  }

  /// Refund + shipping cost aggregated by return reason.
  List<Map<String, dynamic>> returnCostByReason() {
    final m = <ReturnReason, double>{};
    for (final r in returns) {
      final cost = (r.refundAmount ?? 0) + (r.returnShippingCost ?? 0);
      m.update(r.reason, (v) => v + cost, ifAbsent: () => cost);
    }
    return m.entries
        .map((e) => {'reason': e.key.name, 'costPln': e.value})
        .toList();
  }

  /// Orders with risk > 50 and margin < 15% (expectation gap proxy).
  int get lowMarginHighRiskCount {
    var n = 0;
    for (final o in orders) {
      final r = o.riskScore ?? 0;
      final m = AnalyticsEngine.orderMarginPercent(o);
      if (r > 50 && m < 15) n++;
    }
    return n;
  }

  Map<String, dynamic> fulfillmentStats30d() {
    final since = DateTime.now().subtract(const Duration(days: 30));
    final durations = <double>[];
    for (final o in orders) {
      if (o.deliveredAt == null || o.createdAt == null) continue;
      if (o.createdAt!.isBefore(since)) continue;
      durations.add(o.deliveredAt!.difference(o.createdAt!).inHours / 24.0);
    }
    if (durations.isEmpty) {
      return {'medianDays': 0.0, 'avgDays': 0.0, 'sampleCount': 0};
    }
    durations.sort();
    final mid = durations.length ~/ 2;
    final median = durations.length.isOdd
        ? durations[mid]
        : (durations[mid - 1] + durations[mid]) / 2;
    final avg = durations.fold<double>(0, (a, b) => a + b) / durations.length;
    return {
      'medianDays': median,
      'avgDays': avg,
      'sampleCount': durations.length,
    };
  }

  Map<String, dynamic> failedOrderRate30d() {
    final since = DateTime.now().subtract(const Duration(days: 30));
    var failed = 0;
    var total = 0;
    for (final o in orders) {
      if (o.createdAt == null || o.createdAt!.isBefore(since)) continue;
      total++;
      if (o.status == OrderStatus.failed ||
          o.status == OrderStatus.failedOutOfStock) {
        failed++;
      }
    }
    final rate = total > 0 ? (failed / total) * 100 : 0.0;
    return {'failed': failed, 'total': total, 'ratePercent': rate};
  }

  /// Simplified funnel: pending → in-flight → shipped/delivered → failed/cancelled.
  List<Map<String, dynamic>> orderFunnelStages() {
    var pending = 0;
    var inFlight = 0;
    var done = 0;
    var bad = 0;
    for (final o in orders) {
      switch (o.status) {
        case OrderStatus.pending:
        case OrderStatus.pendingApproval:
          pending++;
          break;
        case OrderStatus.sourceOrderPlaced:
          inFlight++;
          break;
        case OrderStatus.shipped:
        case OrderStatus.delivered:
          done++;
          break;
        case OrderStatus.failed:
        case OrderStatus.failedOutOfStock:
        case OrderStatus.cancelled:
          bad++;
          break;
      }
    }
    return [
      {'stage': 'pending', 'count': pending},
      {'stage': 'supplier', 'count': inFlight},
      {'stage': 'fulfilled', 'count': done},
      {'stage': 'failed_cancel', 'count': bad},
    ];
  }

  /// Top listings by average risk score (orders with risk set).
  List<Map<String, dynamic>> topRiskListings({int limit = 5}) {
    final byListing = <String, List<double>>{};
    for (final o in orders) {
      if (o.riskScore == null) continue;
      byListing.putIfAbsent(o.listingId, () => []).add(o.riskScore!);
    }
    final rows = byListing.entries.map((e) {
      final rs = e.value;
      final avg = rs.fold<double>(0, (a, b) => a + b) / rs.length;
      return {'listingId': e.key, 'avgRisk': avg, 'orderCount': rs.length};
    }).toList()
      ..sort((a, b) => (b['avgRisk'] as double).compareTo(a['avgRisk'] as double));
    return rows.take(limit).toList();
  }

  /// Order counts per supplier id (listing → supplier mapping supplied by caller).
  Map<String, int> supplierOrderCounts(Map<String, String> listingIdToSupplierId) {
    final m = <String, int>{};
    for (final o in orders) {
      final sid = listingIdToSupplierId[o.listingId];
      if (sid == null) continue;
      m.update(sid, (v) => v + 1, ifAbsent: () => 1);
    }
    return m;
  }

  /// Listing health histogram: buckets by returnOrIncident rate (0, 1, 2+).
  List<Map<String, dynamic>> listingHealthHistogram(List<ListingHealthRecord> records) {
    var b0 = 0;
    var b1 = 0;
    var b2 = 0;
    for (final r in records) {
      final x = r.returnOrIncidentCount;
      if (x <= 0) {
        b0++;
      } else if (x == 1) {
        b1++;
      } else {
        b2++;
      }
    }
    return [
      {'bucket': '0 issues', 'count': b0},
      {'bucket': '1 issue', 'count': b1},
      {'bucket': '2+ issues', 'count': b2},
    ];
  }
}

class DailyRevenueProfit {
  const DailyRevenueProfit({
    required this.date,
    required this.revenue,
    required this.profit,
  });
  final DateTime date;
  final double revenue;
  final double profit;
  double get marginPercent => revenue > 0 ? (profit / revenue) * 100 : 0;
}

class PlatformStats {
  PlatformStats(this.platformId);
  final String platformId;
  double revenue = 0;
  double cost = 0;
  int orderCount = 0;

  double get profit => revenue - cost;
  double get marginPercent => revenue > 0 ? (profit / revenue) * 100 : 0;

  PlatformStats addOrder(double sellingPrice, double sourceCost) {
    revenue += sellingPrice;
    cost += sourceCost;
    orderCount++;
    return this;
  }
}

class ProductStats {
  ProductStats(this.listingId);
  final String listingId;
  double revenue = 0;
  double cost = 0;
  int orderCount = 0;

  double get profit => revenue - cost;
  double get marginPercent => revenue > 0 ? (profit / revenue) * 100 : 0;

  void addOrder(double sellingPrice, double sourceCost) {
    revenue += sellingPrice;
    cost += sourceCost;
    orderCount++;
  }
}

enum IssueSeverity { critical, warning, info }

class AnalyticsIssue {
  const AnalyticsIssue({
    required this.severity,
    required this.title,
    required this.description,
    this.entityId,
  });
  final IssueSeverity severity;
  final String title;
  final String description;
  final String? entityId;
}

class DailyProfit {
  const DailyProfit({required this.date, required this.profit});
  final DateTime date;
  final double profit;
}
