import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    final ordersAsync = ref.watch(ordersProvider);
    final returnsAsync = ref.watch(returnRequestsProvider);
    final rulesAsync = ref.watch(rulesProvider);
    final automation = ref.watch(automationSchedulerProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(listingsProvider);
        ref.invalidate(ordersProvider);
        ref.invalidate(returnRequestsProvider);
        ref.invalidate(rulesProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            listingsAsync.when(
              data: (listings) {
                final active = listings.where((l) => l.status.name == 'active').length;
                final pending = listings.where((l) => l.status.name == 'pendingApproval').length;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Listings', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text('Active: $active'),
                        Text('Pending approval: $pending'),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              error: (e, _) => ErrorCard(
                message: 'Failed to load data. Please try again.',
                onRetry: () => ref.invalidate(listingsProvider),
              ),
            ),
            const SizedBox(height: 12),
            _buildKpiCard(listingsAsync, ordersAsync, returnsAsync),
            const SizedBox(height: 12),
            ordersAsync.when(
              data: (orders) {
                final pending = orders.where((o) => o.status.name == 'pending' || o.status.name == 'pendingApproval').length;
                final totalSales = orders.fold<double>(0, (s, o) => s + o.sellingPrice);
                final totalCost = orders.fold<double>(0, (s, o) => s + o.sourceCost);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Orders', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text('Pending: $pending'),
                        Text('Total sales: ${totalSales.toStringAsFixed(2)} PLN'),
                        Text('Total cost: ${totalCost.toStringAsFixed(2)} PLN'),
                        Text('Est. profit: ${(totalSales - totalCost).toStringAsFixed(2)} PLN'),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              error: (e, _) => ErrorCard(
                message: 'Failed to load data. Please try again.',
                onRetry: () => ref.invalidate(ordersProvider),
              ),
            ),
            const SizedBox(height: 12),
            _buildOrderKpis(ordersAsync, returnsAsync),
            const SizedBox(height: 12),
            ordersAsync.when(
              data: (orders) => _ProfitChart(orders: orders),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Automation', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    _StatusRow(label: 'Scanner', running: automation.isScanRunning, lastTime: automation.lastScanTime),
                    _StatusRow(label: 'Order Sync', running: automation.isSyncRunning, lastTime: automation.lastSyncTime),
                    _StatusRow(label: 'Price Refresh', running: automation.isPriceRefreshRunning, lastTime: automation.lastPriceRefreshTime),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        FilledButton(
                          onPressed: (automation.isScanRunning && automation.isSyncRunning)
                              ? null
                              : () => automation.startAll(),
                          child: const Text('Start all'),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: (automation.isScanRunning || automation.isSyncRunning || automation.isPriceRefreshRunning)
                              ? () => automation.stopAll()
                              : null,
                          child: const Text('Stop all'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            rulesAsync.when(
              data: (rules) => Card(
                child: ListTile(
                  title: const Text('Run scan'),
                  subtitle: Text('Keywords: ${rules.searchKeywords.join(", ").isEmpty ? "none" : rules.searchKeywords.join(", ")}'),
                  trailing: FilledButton(
                    onPressed: () async {
                      final scanner = ref.read(scannerProvider);
                      await scanner.run();
                      ref.invalidate(listingsProvider);
                    },
                    child: const Text('Scan'),
                  ),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildKpiCard(
    AsyncValue<List<Listing>> listingsAsync,
    AsyncValue<List<Order>> ordersAsync,
    AsyncValue<List<ReturnRequest>> returnsAsync,
  ) {
    final listings = listingsAsync.valueOrNull;
    final orders = ordersAsync.valueOrNull;
    final returns = returnsAsync.valueOrNull;
    if (listings == null || orders == null || returns == null) {
      return const SizedBox.shrink();
    }
    return _KpiCard(orders: orders, listings: listings, returns: returns);
  }

  static Widget _buildOrderKpis(
    AsyncValue<List<Order>> ordersAsync,
    AsyncValue<List<ReturnRequest>> returnsAsync,
  ) {
    final orders = ordersAsync.valueOrNull;
    final returns = returnsAsync.valueOrNull;
    if (orders == null || returns == null) {
      return const SizedBox.shrink();
    }
    return _OrderKpiGrid(orders: orders, returns: returns);
  }

  static String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label, required this.running, this.lastTime});
  final String label;
  final bool running;
  final DateTime? lastTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            running ? Icons.play_circle : Icons.stop_circle,
            size: 16,
            color: running ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 6),
          Text('$label: ${running ? "Running" : "Stopped"}'),
          if (lastTime != null) ...[
            const SizedBox(width: 8),
            Text(
              '(last: ${DashboardScreen._formatTime(lastTime!)})',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProfitChart extends StatefulWidget {
  const _ProfitChart({required this.orders});
  final List<Order> orders;

  @override
  State<_ProfitChart> createState() => _ProfitChartState();
}

class _ProfitChartState extends State<_ProfitChart> {
  int _selectedDays = 7;

  @override
  Widget build(BuildContext context) {
    final dailyProfit = _computeDailyProfit(widget.orders, _selectedDays);
    if (dailyProfit.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Profit Trend', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Text('No order data yet.'),
            ],
          ),
        ),
      );
    }

    final spots = <FlSpot>[];
    final labels = <int, String>{};
    for (var i = 0; i < dailyProfit.length; i++) {
      spots.add(FlSpot(i.toDouble(), dailyProfit[i].profit));
      labels[i] = '${dailyProfit[i].date.month}/${dailyProfit[i].date.day}';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Profit Trend (daily)', style: TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                ChoiceChip(
                  label: const Text('7 days'),
                  selected: _selectedDays == 7,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedDays = 7);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('30 days'),
                  selected: _selectedDays == 30,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedDays = 30);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 50),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, _) {
                          final idx = value.toInt();
                          return SideTitleWidget(
                            axisSide: AxisSide.bottom,
                            child: Text(labels[idx] ?? '', style: const TextStyle(fontSize: 10)),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            '${spot.y.toStringAsFixed(2)} PLN',
                            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      barWidth: 2,
                      color: Theme.of(context).colorScheme.primary,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).colorScheme.primary.withAlpha(51),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_DailyProfit> _computeDailyProfit(List<Order> orders, int days) {
    final map = <DateTime, double>{};
    for (final order in orders) {
      if (order.createdAt == null) continue;
      final day = DateTime(order.createdAt!.year, order.createdAt!.month, order.createdAt!.day);
      final profit = order.sellingPrice - order.sourceCost;
      map[day] = (map[day] ?? 0) + profit;
    }
    final sorted = map.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    final lastN = sorted.length > days ? sorted.sublist(sorted.length - days) : sorted;
    return lastN.map((e) => _DailyProfit(date: e.key, profit: e.value)).toList();
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.orders, required this.listings, required this.returns});
  final List<Order> orders;
  final List<Listing> listings;
  final List<ReturnRequest> returns;

  @override
  Widget build(BuildContext context) {
    final totalRevenue = orders.fold<double>(0, (s, o) => s + o.sellingPrice);
    final totalCost = orders.fold<double>(0, (s, o) => s + o.sourceCost);
    final totalProfit = totalRevenue - totalCost;
    final avgProfit = orders.isEmpty ? 0.0 : totalProfit / orders.length;
    final marginPct = totalRevenue > 0 ? (totalProfit / totalRevenue * 100) : 0.0;
    final returnRate = orders.isEmpty ? 0.0 : (returns.length / orders.length * 100);
    final activeListings = listings.where((l) => l.status == ListingStatus.active).length;

    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final twoWeeksAgo = now.subtract(const Duration(days: 14));
    final ordersThisWeek = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(weekAgo)).length;
    final ordersLastWeek = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(twoWeeksAgo) && o.createdAt!.isBefore(weekAgo)).length;

    final tiles = <_KpiTile>[
      _KpiTile(label: 'Total Profit', value: '${totalProfit.toStringAsFixed(2)} PLN', icon: Icons.trending_up),
      _KpiTile(label: 'Avg Profit / Order', value: '${avgProfit.toStringAsFixed(2)} PLN', icon: Icons.receipt_long),
      _KpiTile(label: 'Profit Margin', value: '${marginPct.toStringAsFixed(1)}%', icon: Icons.pie_chart),
      _KpiTile(label: 'Return Rate', value: '${returnRate.toStringAsFixed(1)}%', icon: Icons.assignment_return),
      _KpiTile(label: 'Active Listings', value: '$activeListings', icon: Icons.storefront),
      _KpiTile(
        label: 'Orders This Week',
        value: '$ordersThisWeek',
        icon: Icons.shopping_cart,
        trend: ordersLastWeek > 0
            ? '${ordersThisWeek >= ordersLastWeek ? '+' : ''}${ordersThisWeek - ordersLastWeek} vs last week'
            : null,
        trendUp: ordersThisWeek >= ordersLastWeek,
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Key Performance Indicators', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: tiles
                  .map((t) => SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(t.icon, size: 16, color: Theme.of(context).colorScheme.primary),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(t.label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(t.value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            if (t.trend != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                t.trend!,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: t.trendUp ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _KpiTile {
  const _KpiTile({
    required this.label,
    required this.value,
    required this.icon,
    this.trend,
    this.trendUp = true,
  });
  final String label;
  final String value;
  final IconData icon;
  final String? trend;
  final bool trendUp;
}

class _DailyProfit {
  const _DailyProfit({required this.date, required this.profit});
  final DateTime date;
  final double profit;
}

class _OrderKpiGrid extends StatelessWidget {
  const _OrderKpiGrid({required this.orders, required this.returns});
  final List<Order> orders;
  final List<ReturnRequest> returns;

  @override
  Widget build(BuildContext context) {
    final totalRevenue = orders.fold<double>(0, (s, o) => s + o.sellingPrice);
    final totalCost = orders.fold<double>(0, (s, o) => s + o.sourceCost);
    final marginPct = totalRevenue > 0 ? ((totalRevenue - totalCost) / totalRevenue * 100) : 0.0;

    final shippedOrDelivered = orders.where((o) =>
        o.status == OrderStatus.shipped || o.status == OrderStatus.delivered).length;
    final returnRate = shippedOrDelivered > 0
        ? (returns.length / shippedOrDelivered * 100)
        : 0.0;

    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final revenueThisWeek = orders
        .where((o) => o.createdAt != null && o.createdAt!.isAfter(weekAgo))
        .fold<double>(0, (s, o) => s + o.sellingPrice);

    final avgOrderValue = orders.isEmpty ? 0.0 : totalRevenue / orders.length;

    final cards = <_MiniKpi>[
      _MiniKpi(label: 'Profit Margin', value: '${marginPct.toStringAsFixed(1)}%', icon: Icons.pie_chart, color: Colors.indigo),
      _MiniKpi(label: 'Return Rate', value: '${returnRate.toStringAsFixed(1)}%', icon: Icons.assignment_return, color: Colors.orange),
      _MiniKpi(label: 'Revenue This Week', value: '${revenueThisWeek.toStringAsFixed(2)} PLN', icon: Icons.calendar_today, color: Colors.teal),
      _MiniKpi(label: 'Avg Order Value', value: '${avgOrderValue.toStringAsFixed(2)} PLN', icon: Icons.shopping_bag, color: Colors.deepPurple),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: cards.map((kpi) => SizedBox(
        width: 170,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(kpi.icon, size: 16, color: kpi.color),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(kpi.label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(kpi.value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      )).toList(),
    );
  }
}

class _MiniKpi {
  const _MiniKpi({required this.label, required this.value, required this.icon, required this.color});
  final String label;
  final String value;
  final IconData icon;
  final Color color;
}
