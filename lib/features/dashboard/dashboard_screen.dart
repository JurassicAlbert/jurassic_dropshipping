import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    final ordersAsync = ref.watch(ordersProvider);
    final rulesAsync = ref.watch(rulesProvider);
    final automation = ref.watch(automationSchedulerProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(listingsProvider);
        ref.invalidate(ordersProvider);
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

class _DailyProfit {
  const _DailyProfit({required this.date, required this.profit});
  final DateTime date;
  final double profit;
}
