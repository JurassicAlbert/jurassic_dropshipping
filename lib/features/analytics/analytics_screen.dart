import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/features/analytics/analytics_engine.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);
    final listingsAsync = ref.watch(listingsProvider);
    final suppliersAsync = ref.watch(suppliersProvider);
    final returnsAsync = ref.watch(returnRequestsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(ordersProvider);
        ref.invalidate(listingsProvider);
        ref.invalidate(suppliersProvider);
        ref.invalidate(returnRequestsProvider);
      },
      child: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: ErrorCard(
            message: 'Failed to load analytics data.',
            onRetry: () {
              ref.invalidate(ordersProvider);
              ref.invalidate(listingsProvider);
              ref.invalidate(suppliersProvider);
              ref.invalidate(returnRequestsProvider);
            },
          ),
        ),
        data: (orders) {
          final listings = listingsAsync.valueOrNull ?? [];
          final suppliers = suppliersAsync.valueOrNull ?? [];
          final returns = returnsAsync.valueOrNull ?? [];

          final engine = AnalyticsEngine(
            orders: orders,
            listings: listings,
            returns: returns,
            suppliers: suppliers,
          );

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Analytics',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _SummaryKpiRow(engine: engine),
                const SizedBox(height: 16),
                _ProfitByPlatformChart(engine: engine),
                const SizedBox(height: 16),
                _ProfitByProductList(engine: engine),
                const SizedBox(height: 16),
                _IssuesAlerts(engine: engine),
                const SizedBox(height: 16),
                _ProfitTrendChart(engine: engine),
                const SizedBox(height: 16),
                _ReturnsAnalysis(engine: engine),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── Section 1: Summary KPI Row ──────────────────────────────────────────────

class _SummaryKpiRow extends StatelessWidget {
  const _SummaryKpiRow({required this.engine});
  final AnalyticsEngine engine;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final profitColor = engine.totalProfit >= 0 ? Colors.green : Colors.red;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _KpiMetricCard(
          label: 'Total Revenue',
          value: '${engine.totalRevenue.toStringAsFixed(2)} PLN',
          icon: Icons.attach_money,
          color: cs.primary,
        ),
        _KpiMetricCard(
          label: 'Total Profit',
          value: '${engine.totalProfit.toStringAsFixed(2)} PLN',
          icon: Icons.trending_up,
          color: profitColor,
        ),
        _KpiMetricCard(
          label: 'Profit Margin',
          value: '${engine.profitMarginPercent.toStringAsFixed(1)}%',
          icon: Icons.pie_chart,
          color: cs.tertiary,
        ),
        _KpiMetricCard(
          label: 'Return Rate',
          value: '${engine.returnRatePercent.toStringAsFixed(1)}%',
          icon: Icons.assignment_return,
          color: Colors.orange,
        ),
      ],
    );
  }
}

class _KpiMetricCard extends StatelessWidget {
  const _KpiMetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18, color: color),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Section 2: Profit by Platform (bar chart) ──────────────────────────────

class _ProfitByPlatformChart extends StatelessWidget {
  const _ProfitByPlatformChart({required this.engine});
  final AnalyticsEngine engine;

  static const _platformColors = <String, Color>{
    'allegro': Colors.blue,
    'temu': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    final stats = engine.profitByPlatform;
    if (stats.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Profit by Platform',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Text('No order data yet.'),
            ],
          ),
        ),
      );
    }

    final entries = stats.entries.toList();
    final maxProfit = entries
        .map((e) => e.value.profit.abs())
        .reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Profit by Platform',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxProfit * 1.2,
                  minY: entries.any((e) => e.value.profit < 0)
                      ? -maxProfit * 0.3
                      : 0,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final entry = entries[group.x.toInt()];
                        return BarTooltipItem(
                          '${entry.key}\n${entry.value.profit.toStringAsFixed(2)} PLN\n${entry.value.orderCount} orders',
                          const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 60),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, _) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= entries.length) {
                            return const SizedBox.shrink();
                          }
                          return SideTitleWidget(
                            axisSide: AxisSide.bottom,
                            child: Text(entries[idx].key,
                                style: const TextStyle(fontSize: 12)),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(entries.length, (i) {
                    final key = entries[i].key.toLowerCase();
                    final color = _platformColors[key] ?? Colors.grey;
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: entries[i].value.profit,
                          color: color,
                          width: 32,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4)),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              children: entries.map((e) {
                final key = e.key.toLowerCase();
                final color = _platformColors[key] ?? Colors.grey;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 12, height: 12, color: color),
                    const SizedBox(width: 4),
                    Text(
                      '${e.key}: ${e.value.profit.toStringAsFixed(2)} PLN (${e.value.orderCount} orders)',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section 3: Profit by Product ───────────────────────────────────────────

class _ProfitByProductList extends StatelessWidget {
  const _ProfitByProductList({required this.engine});
  final AnalyticsEngine engine;

  @override
  Widget build(BuildContext context) {
    final products = engine.profitByProduct;
    if (products.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Profit by Product (Top 10)',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              Text('No product data yet.'),
            ],
          ),
        ),
      );
    }

    final maxRevenue = products
        .map((p) => p.revenue)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Profit by Product (Top 10)',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...products.map((p) => _ProductRow(
                  product: p,
                  maxRevenue: maxRevenue,
                )),
          ],
        ),
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({required this.product, required this.maxRevenue});
  final ProductStats product;
  final double maxRevenue;

  Color _marginColor(double margin) {
    if (margin < 0) return Colors.red;
    if (margin < 15) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final margin = product.marginPercent;
    final barColor = _marginColor(margin);
    final barWidth = maxRevenue > 0 ? (product.revenue / maxRevenue) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  product.listingId,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${product.profit.toStringAsFixed(2)} PLN',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: product.profit >= 0 ? Colors.green[700] : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                'Rev: ${product.revenue.toStringAsFixed(0)}  Cost: ${product.cost.toStringAsFixed(0)}  Margin: ${margin.toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: barWidth.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[200],
              color: barColor,
              minHeight: 6,
            ),
          ),
          const Divider(height: 12),
        ],
      ),
    );
  }
}

// ─── Section 4: Issues / Alerts ─────────────────────────────────────────────

class _IssuesAlerts extends StatelessWidget {
  const _IssuesAlerts({required this.engine});
  final AnalyticsEngine engine;

  @override
  Widget build(BuildContext context) {
    final issues = engine.issues;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber, size: 20),
                const SizedBox(width: 6),
                const Text('Issues & Alerts',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                if (issues.isEmpty)
                  Chip(
                    label: const Text('All clear'),
                    backgroundColor: Colors.green[50],
                    labelStyle: const TextStyle(color: Colors.green),
                  )
                else
                  Chip(
                    label: Text('${issues.length} issue${issues.length == 1 ? '' : 's'}'),
                    backgroundColor: Colors.red[50],
                    labelStyle: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
            if (issues.isEmpty) ...[
              const SizedBox(height: 8),
              const Text('No issues detected. All metrics look healthy.',
                  style: TextStyle(color: Colors.grey)),
            ] else ...[
              const SizedBox(height: 12),
              ...issues.map((issue) => _IssueRow(issue: issue)),
            ],
          ],
        ),
      ),
    );
  }
}

class _IssueRow extends StatelessWidget {
  const _IssueRow({required this.issue});
  final AnalyticsIssue issue;

  @override
  Widget build(BuildContext context) {
    final isCritical = issue.severity == IssueSeverity.critical;
    final icon = isCritical ? Icons.error : Icons.warning;
    final color = isCritical ? Colors.red : Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                    fontSize: 13,
                  ),
                ),
                Text(
                  issue.description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                if (issue.entityId != null)
                  Text(
                    'Entity: ${issue.entityId}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section 5: Profit Trend (30-day default) ───────────────────────────────

class _ProfitTrendChart extends StatefulWidget {
  const _ProfitTrendChart({required this.engine});
  final AnalyticsEngine engine;

  @override
  State<_ProfitTrendChart> createState() => _ProfitTrendChartState();
}

class _ProfitTrendChartState extends State<_ProfitTrendChart> {
  int _selectedDays = 30;

  @override
  Widget build(BuildContext context) {
    final dailyProfit = widget.engine.dailyProfit(days: _selectedDays);
    if (dailyProfit.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Profit Trend',
                  style: TextStyle(fontWeight: FontWeight.w600)),
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

    final interval = math.max(1, (dailyProfit.length / 8).ceil());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Profit Trend (daily)',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                ChoiceChip(
                  label: const Text('7d'),
                  selected: _selectedDays == 7,
                  onSelected: (s) {
                    if (s) setState(() => _selectedDays = 7);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('30d'),
                  selected: _selectedDays == 30,
                  onSelected: (s) {
                    if (s) setState(() => _selectedDays = 30);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('90d'),
                  selected: _selectedDays == 90,
                  onSelected: (s) {
                    if (s) setState(() => _selectedDays = 90);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 55),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: interval.toDouble(),
                        getTitlesWidget: (value, _) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= dailyProfit.length) {
                            return const SizedBox.shrink();
                          }
                          return SideTitleWidget(
                            axisSide: AxisSide.bottom,
                            child: Text(labels[idx] ?? '',
                                style: const TextStyle(fontSize: 10)),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final idx = spot.x.toInt();
                          final dateLabel = labels[idx] ?? '';
                          return LineTooltipItem(
                            '$dateLabel\n${spot.y.toStringAsFixed(2)} PLN',
                            const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                      dotData: FlDotData(show: dailyProfit.length <= 30),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(51),
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
}

// ─── Section 6: Returns Analysis ────────────────────────────────────────────

class _ReturnsAnalysis extends StatelessWidget {
  const _ReturnsAnalysis({required this.engine});
  final AnalyticsEngine engine;

  static const _reasonLabels = <ReturnReason, String>{
    ReturnReason.noReason: 'No Reason',
    ReturnReason.defective: 'Defective',
    ReturnReason.wrongItem: 'Wrong Item',
    ReturnReason.damagedInTransit: 'Damaged in Transit',
    ReturnReason.other: 'Other',
  };

  static const _reasonColors = <ReturnReason, Color>{
    ReturnReason.noReason: Colors.blueGrey,
    ReturnReason.defective: Colors.red,
    ReturnReason.wrongItem: Colors.orange,
    ReturnReason.damagedInTransit: Colors.purple,
    ReturnReason.other: Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    final bySupplier = engine.returnsBySupplierId;
    final byReason = engine.returnsByReason;
    final totalReturnCost = engine.totalReturnCost;
    final hasData = engine.returns.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Returns Analysis',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            if (!hasData) ...[
              const Text('No return data yet.',
                  style: TextStyle(color: Colors.grey)),
            ] else ...[
              Text(
                'Total Return Cost: ${totalReturnCost.toStringAsFixed(2)} PLN',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Return Rate by Supplier',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14)),
              const SizedBox(height: 8),
              ...bySupplier.entries.map((e) {
                final supplierName = engine.suppliers
                        .where((s) => s.id == e.key)
                        .map((s) => s.name)
                        .firstOrNull ??
                    e.key;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      const Icon(Icons.store, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                          child: Text(supplierName,
                              style: const TextStyle(fontSize: 13))),
                      Text('${e.value} returns',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.red[700])),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text('Returns by Reason',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14)),
              const SizedBox(height: 8),
              if (byReason.isNotEmpty)
                SizedBox(
                  height: 180,
                  child: Row(
                    children: [
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 30,
                            sections: byReason.entries.map((e) {
                              final color =
                                  _reasonColors[e.key] ?? Colors.grey;
                              return PieChartSectionData(
                                value: e.value.toDouble(),
                                title: '${e.value}',
                                color: color,
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: byReason.entries.map((e) {
                          final color =
                              _reasonColors[e.key] ?? Colors.grey;
                          final label =
                              _reasonLabels[e.key] ?? e.key.name;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    width: 10, height: 10, color: color),
                                const SizedBox(width: 6),
                                Text('$label (${e.value})',
                                    style:
                                        const TextStyle(fontSize: 12)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
