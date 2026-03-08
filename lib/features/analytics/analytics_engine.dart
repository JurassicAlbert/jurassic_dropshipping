import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';

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
  double get totalRevenue => orders.fold(0, (s, o) => s + o.sellingPrice);
  double get totalCost => orders.fold(0, (s, o) => s + o.sourceCost);
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
        (s) => s.addOrder(o.sellingPrice, o.sourceCost),
        ifAbsent: () => PlatformStats(o.targetPlatformId)
          ..addOrder(o.sellingPrice, o.sourceCost),
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
        (s) => s..addOrder(o.sellingPrice, o.sourceCost),
        ifAbsent: () =>
            ProductStats(o.listingId)..addOrder(o.sellingPrice, o.sourceCost),
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
      byProduct.update(o.listingId, (v) => v + (o.sellingPrice - o.sourceCost),
          ifAbsent: () => o.sellingPrice - o.sourceCost);
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
      final profit = o.sellingPrice - o.sourceCost;
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
