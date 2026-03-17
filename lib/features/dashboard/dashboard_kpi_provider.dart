import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';

/// Aggregated KPIs for dashboard and other views.
class DashboardKpiData {
  const DashboardKpiData({
    required this.revenueToday,
    required this.revenue7d,
    required this.revenue30d,
    required this.ordersToday,
    required this.pendingOrdersCount,
    required this.queuedForCapitalCount,
    required this.avgMarginPercent,
    required this.returnRatePercent,
    required this.incidentRatePercent,
    required this.automationHealthScore,
    required this.automationHealthLabel,
  });

  final double revenueToday;
  final double revenue7d;
  final double revenue30d;
  final int ordersToday;
  final int pendingOrdersCount;
  final int queuedForCapitalCount;
  final double avgMarginPercent;
  final double returnRatePercent;
  final double incidentRatePercent;
  /// 0-100; higher is better.
  final int automationHealthScore;
  /// 'Good' | 'Degraded' | 'Poor'
  final String automationHealthLabel;
}

/// Central KPI provider for dashboard. Combines orders, listings, returns, incidents, observability, automation.
final dashboardKpiProvider = FutureProvider<DashboardKpiData>((ref) async {
  final orders = await ref.watch(ordersProvider.future);
  await ref.watch(listingsProvider.future);
  final returns = await ref.watch(returnRequestsProvider.future);
  final incidents = await ref.watch(incidentsProvider.future);
  final snapshot = ref.read(observabilitySnapshotProvider);
  final automation = ref.read(automationSchedulerProvider);
  final pendingJobs = await ref.read(pendingJobCountProvider.future);

  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);
  final day7 = now.subtract(const Duration(days: 7));
  final day30 = now.subtract(const Duration(days: 30));

  final revenueToday = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(todayStart)).fold<double>(0, (s, o) => s + o.sellingPrice);
  final revenue7d = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(day7)).fold<double>(0, (s, o) => s + o.sellingPrice);
  final revenue30d = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(day30)).fold<double>(0, (s, o) => s + o.sellingPrice);
  final ordersToday = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(todayStart)).length;
  final pendingOrdersCount = orders.where((o) => o.status == OrderStatus.pending || o.status == OrderStatus.pendingApproval).length;
  final queuedForCapitalCount = orders.where((o) => o.queuedForCapital).length;

  final totalRevenue = orders.fold<double>(0, (s, o) => s + o.sellingPrice);
  final totalCost = orders.fold<double>(0, (s, o) => s + o.sourceCost);
  final totalProfit = totalRevenue - totalCost;
  final avgMarginPercent = totalRevenue > 0 ? (totalProfit / totalRevenue * 100) : 0.0;

  final shippedOrDelivered = orders.where((o) => o.status == OrderStatus.shipped || o.status == OrderStatus.delivered).length;
  final returnRatePercent = shippedOrDelivered > 0 ? (returns.length / shippedOrDelivered * 100) : 0.0;
  final incidentRatePercent = shippedOrDelivered > 0 ? (incidents.length / shippedOrDelivered * 100) : 0.0;

  // Automation health: 0-100. Deduct for failures, sync delay, backlog.
  int health = 100;
  final totalFulfill = snapshot.fulfillmentSuccessTotal + snapshot.fulfillmentFailedTotal;
  if (totalFulfill > 0 && snapshot.fulfillmentFailedTotal > 0) {
    health -= (snapshot.fulfillmentFailedTotal / totalFulfill * 30).clamp(0, 30).round();
  }
  final totalSupplier = snapshot.supplierApiSuccessTotal + snapshot.supplierApiFailedTotal;
  if (totalSupplier > 0 && snapshot.supplierApiFailedTotal > 0) {
    health -= (snapshot.supplierApiFailedTotal / totalSupplier * 20).clamp(0, 20).round();
  }
  if (pendingJobs > 50) health -= 15;
  else if (pendingJobs > 20) health -= 5;
  final lastSync = automation.lastSyncTime;
  if (lastSync != null && now.difference(lastSync).inMinutes > 120) health -= 20;
  final openIncidents = incidents.where((i) => i.status == IncidentStatus.open).length;
  if (openIncidents > 20) health -= 10;
  health = health.clamp(0, 100);

  String label;
  if (health >= 80) label = 'Good';
  else if (health >= 50) label = 'Degraded';
  else label = 'Poor';

  return DashboardKpiData(
    revenueToday: revenueToday,
    revenue7d: revenue7d,
    revenue30d: revenue30d,
    ordersToday: ordersToday,
    pendingOrdersCount: pendingOrdersCount,
    queuedForCapitalCount: queuedForCapitalCount,
    avgMarginPercent: avgMarginPercent,
    returnRatePercent: returnRatePercent,
    incidentRatePercent: incidentRatePercent,
    automationHealthScore: health,
    automationHealthLabel: label,
  );
});
