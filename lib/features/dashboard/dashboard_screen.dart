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
        ref.invalidate(listingHealthMetricsListProvider);
        ref.invalidate(customerMetricsListProvider);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // ─── Top KPI stat cards ───
                _buildTopKpis(context, listingsAsync, ordersAsync, returnsAsync, isWide),
                const SizedBox(height: 16),

                // ─── Responsive grid for chart + automation ───
                if (isWide)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ordersAsync.when(
                            data: (orders) => _ProfitChart(orders: orders),
                            loading: () => const SizedBox.shrink(),
                            error: (_, _) => const SizedBox.shrink(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: _AutomationCard(automation: automation),
                        ),
                      ],
                    ),
                  )
                else ...[
                  ordersAsync.when(
                    data: (orders) => _ProfitChart(orders: orders),
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 12),
                  _AutomationCard(automation: automation),
                ],

                const SizedBox(height: 16),

                // ─── Summary cards ───
                if (isWide)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: listingsAsync.when(
                            data: (listings) => _ListingsSummaryCard(listings: listings),
                            loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()))),
                            error: (e, _) => ErrorCard(
                              message: 'Failed to load data. Please try again.',
                              onRetry: () => ref.invalidate(listingsProvider),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ordersAsync.when(
                            data: (orders) => _OrdersSummaryCard(orders: orders),
                            loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()))),
                            error: (e, _) => ErrorCard(
                              message: 'Failed to load data. Please try again.',
                              onRetry: () => ref.invalidate(ordersProvider),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  listingsAsync.when(
                    data: (listings) => _ListingsSummaryCard(listings: listings),
                    loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()))),
                    error: (e, _) => ErrorCard(
                      message: 'Failed to load data. Please try again.',
                      onRetry: () => ref.invalidate(listingsProvider),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ordersAsync.when(
                    data: (orders) => _OrdersSummaryCard(orders: orders),
                    loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()))),
                    error: (e, _) => ErrorCard(
                      message: 'Failed to load data. Please try again.',
                      onRetry: () => ref.invalidate(ordersProvider),
                    ),
                  ),
                ],

                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () async {
                          await ref.read(listingHealthScoringServiceProvider).evaluateAll();
                          ref.invalidate(listingHealthMetricsListProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Listing health metrics refreshed')),
                            );
                          }
                        },
                        icon: const Icon(Icons.health_and_safety_outlined, size: 18),
                        label: const Text('Refresh listing health'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await ref.read(customerAbuseScoringServiceProvider).evaluateAll();
                          ref.invalidate(customerMetricsListProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Customer metrics refreshed')),
                            );
                          }
                        },
                        icon: const Icon(Icons.person_off_outlined, size: 18),
                        label: const Text('Refresh customer metrics'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await ref.read(stockStateRefreshServiceProvider).refreshAll();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Stock state refreshed (Phase 28)')),
                            );
                          }
                        },
                        icon: const Icon(Icons.inventory_2_outlined, size: 18),
                        label: const Text('Refresh stock state'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {
                          ref.read(observabilitySnapshotVersionProvider.notifier).state++;
                        },
                        icon: const Icon(Icons.insights_outlined, size: 18),
                        label: const Text('Refresh observability'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _ObservabilityCard(),
                const SizedBox(height: 8),
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
          );
        },
      ),
    );
  }

  static Widget _buildTopKpis(
    BuildContext context,
    AsyncValue<List<Listing>> listingsAsync,
    AsyncValue<List<Order>> ordersAsync,
    AsyncValue<List<ReturnRequest>> returnsAsync,
    bool isWide,
  ) {
    final listings = listingsAsync.valueOrNull;
    final orders = ordersAsync.valueOrNull;
    final returns = returnsAsync.valueOrNull;
    if (listings == null || orders == null || returns == null) {
      return const SizedBox.shrink();
    }

    final totalRevenue = orders.fold<double>(0, (s, o) => s + o.sellingPrice);
    final totalCost = orders.fold<double>(0, (s, o) => s + o.sourceCost);
    final totalProfit = totalRevenue - totalCost;
    final marginPct = totalRevenue > 0 ? (totalProfit / totalRevenue * 100) : 0.0;
    final shippedOrDelivered = orders.where((o) => o.status == OrderStatus.shipped || o.status == OrderStatus.delivered).length;
    final returnRate = shippedOrDelivered > 0 ? (returns.length / shippedOrDelivered * 100) : 0.0;

    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final twoWeeksAgo = now.subtract(const Duration(days: 14));
    final revenueThisWeek = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(weekAgo)).fold<double>(0, (s, o) => s + o.sellingPrice);
    final revenueLastWeek = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(twoWeeksAgo) && o.createdAt!.isBefore(weekAgo)).fold<double>(0, (s, o) => s + o.sellingPrice);
    final avgOrderValue = orders.isEmpty ? 0.0 : totalRevenue / orders.length;
    final avgOrderLastWeek = () {
      final lastWeekOrders = orders.where((o) => o.createdAt != null && o.createdAt!.isAfter(twoWeeksAgo) && o.createdAt!.isBefore(weekAgo)).toList();
      if (lastWeekOrders.isEmpty) return 0.0;
      return lastWeekOrders.fold<double>(0, (s, o) => s + o.sellingPrice) / lastWeekOrders.length;
    }();

    final cs = Theme.of(context).colorScheme;

    final kpis = [
      _StyledKpiData(
        icon: Icons.pie_chart,
        value: '${marginPct.toStringAsFixed(1)}%',
        label: 'Profit Margin',
        trendUp: marginPct >= 20,
        containerColor: cs.primaryContainer,
        onContainerColor: cs.onPrimaryContainer,
      ),
      _StyledKpiData(
        icon: Icons.assignment_return,
        value: '${returnRate.toStringAsFixed(1)}%',
        label: 'Return Rate',
        trendUp: returnRate <= 5,
        containerColor: cs.secondaryContainer,
        onContainerColor: cs.onSecondaryContainer,
      ),
      _StyledKpiData(
        icon: Icons.calendar_today,
        value: '${revenueThisWeek.toStringAsFixed(0)} PLN',
        label: 'Weekly Revenue',
        trendUp: revenueThisWeek >= revenueLastWeek,
        containerColor: cs.tertiaryContainer,
        onContainerColor: cs.onTertiaryContainer,
      ),
      _StyledKpiData(
        icon: Icons.shopping_bag,
        value: '${avgOrderValue.toStringAsFixed(0)} PLN',
        label: 'Avg Order Value',
        trendUp: avgOrderValue >= avgOrderLastWeek,
        containerColor: cs.errorContainer,
        onContainerColor: cs.onErrorContainer,
      ),
    ];

    if (isWide) {
      return Row(
        children: [
          for (var i = 0; i < kpis.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            Expanded(child: _StyledKpiCard(data: kpis[i])),
          ],
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _StyledKpiCard(data: kpis[0])),
            const SizedBox(width: 12),
            Expanded(child: _StyledKpiCard(data: kpis[1])),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _StyledKpiCard(data: kpis[2])),
            const SizedBox(width: 12),
            Expanded(child: _StyledKpiCard(data: kpis[3])),
          ],
        ),
      ],
    );
  }

  static String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }
}

// ─── Styled KPI Card ─────────────────────────────────────────────────────────

class _StyledKpiData {
  const _StyledKpiData({
    required this.icon,
    required this.value,
    required this.label,
    required this.trendUp,
    required this.containerColor,
    required this.onContainerColor,
  });
  final IconData icon;
  final String value;
  final String label;
  final bool trendUp;
  final Color containerColor;
  final Color onContainerColor;
}

class _StyledKpiCard extends StatelessWidget {
  const _StyledKpiCard({required this.data});
  final _StyledKpiData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: data.containerColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(data.icon, size: 20, color: data.onContainerColor),
                const Spacer(),
                Icon(
                  data.trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 18,
                  color: data.trendUp ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              data.value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: data.onContainerColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.label,
              style: TextStyle(fontSize: 13, color: data.onContainerColor.withAlpha(180)),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Listings Summary Card ───────────────────────────────────────────────────

class _ListingsSummaryCard extends StatelessWidget {
  const _ListingsSummaryCard({required this.listings});
  final List<Listing> listings;

  @override
  Widget build(BuildContext context) {
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
  }
}

// ─── Orders Summary Card ─────────────────────────────────────────────────────

class _OrdersSummaryCard extends StatelessWidget {
  const _OrdersSummaryCard({required this.orders});
  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
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
  }
}

// ─── Automation Card ─────────────────────────────────────────────────────────

class _AutomationCard extends StatelessWidget {
  const _AutomationCard({required this.automation});
  final dynamic automation;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}

class _ObservabilityCard extends ConsumerWidget {
  const _ObservabilityCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(observabilitySnapshotProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Observability (Phase 32)',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                _metricChip('orders/min', snapshot.ordersSyncedLastMinute),
                _metricChip('orders total', snapshot.ordersSyncedTotal),
                _metricChip('fulfill ok', snapshot.fulfillmentSuccessTotal),
                _metricChip('fulfill fail', snapshot.fulfillmentFailedTotal),
                _metricChip('listing enq', snapshot.listingUpdatesEnqueuedTotal),
                _metricChip('listing done', snapshot.listingUpdatesProcessedTotal),
                _metricChip('jobs ok', snapshot.jobsProcessedTotal),
                _metricChip('jobs fail', snapshot.jobsFailedTotal),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _metricChip(String label, int value) {
    return Chip(
      label: Text('$label: $value', style: const TextStyle(fontSize: 11)),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
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

class _DailyProfit {
  const _DailyProfit({required this.date, required this.profit});
  final DateTime date;
  final double profit;
}
