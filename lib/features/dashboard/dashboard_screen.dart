import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/info_icon.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/dashboard/dashboard_kpi_provider.dart';
import 'package:jurassic_dropshipping/features/shared/section_header.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    final ordersAsync = ref.watch(ordersProvider);
    final returnsAsync = ref.watch(returnRequestsProvider);
    final incidentsAsync = ref.watch(incidentsProvider);
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
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(
                  title: 'Dashboard',
                  icon: Icons.dashboard,
                  infoTooltip: 'Overview of your business: KPIs, automation status, and quick actions. '
                      'Pull down to refresh data. Tap KPI cards to open the related screen. Use "Run scan" to discover new products from suppliers.',
                ),
                const ScreenHelpSection(
                  description: ScreenHelpTexts.dashboard,
                  howToUse: 'How to use: Pull to refresh. Use the buttons below to refresh metrics or run a scan. Tap KPI cards to open the related screen.',
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Layer 1: System state (automation status) ───
                _AutomationStatusPanel(automation: automation),
                const SizedBox(height: AppSpacing.cardGap),
                _AutomationTimelinePanel(automation: automation),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Layer 2: Financial overview ───
                const SectionHeader(title: 'Financial overview', icon: Icons.trending_up),
                _buildTopKpis(
                  context,
                  listingsAsync,
                  ordersAsync,
                  returnsAsync,
                  isWide,
                  tapRoutes: const ['/analytics', '/returns', '/analytics', '/orders'],
                ),
                const SizedBox(height: AppSpacing.sectionGap),

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

                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Summary cards ───
                if (isWide)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: listingsAsync.when(
                            data: (listings) => _ListingsSummaryCard(listings: listings),
                            loading: () => const Card(child: Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Center(child: CircularProgressIndicator()))),
                            error: (e, _) => ErrorCard(
                              message: 'Failed to load data. Please try again.',
                              onRetry: () => ref.invalidate(listingsProvider),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.cardGap),
                        Expanded(
                          child: ordersAsync.when(
                            data: (orders) => _OrdersSummaryCard(orders: orders),
                            loading: () => const Card(child: Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Center(child: CircularProgressIndicator()))),
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
                    loading: () => const Card(child: Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Center(child: CircularProgressIndicator()))),
                    error: (e, _) => ErrorCard(
                      message: 'Failed to load data. Please try again.',
                      onRetry: () => ref.invalidate(listingsProvider),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.cardGap),
                  ordersAsync.when(
                    data: (orders) => _OrdersSummaryCard(orders: orders),
                    loading: () => const Card(child: Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Center(child: CircularProgressIndicator()))),
                    error: (e, _) => ErrorCard(
                      message: 'Failed to load data. Please try again.',
                      onRetry: () => ref.invalidate(ordersProvider),
                    ),
                  ),
                ],

                // ─── Layer 3: Risk indicators ───
                const SectionHeader(title: 'Risk indicators', icon: Icons.warning_amber_outlined),
                _DashboardRiskLayer(
                  listingsAsync: listingsAsync,
                  ordersAsync: ordersAsync,
                  returnsAsync: returnsAsync,
                  incidentsAsync: incidentsAsync,
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Layer 4: Operational alerts ───
                const SectionHeader(title: 'Operational alerts', icon: Icons.notifications_active_outlined),
                _DashboardAlertsLayer(
                  listingsAsync: listingsAsync,
                  ordersAsync: ordersAsync,
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Tooltip(
                        message: 'Recalculates listing health metrics including margin, return rate and incident frequency.',
                        child: OutlinedButton.icon(
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
                      ),
                      Tooltip(
                        message: 'Updates customer return and complaint rates used for abuse checks.',
                        child: OutlinedButton.icon(
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
                      ),
                      Tooltip(
                        message: 'Refreshes inventory and sellability state for all listings.',
                        child: OutlinedButton.icon(
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
                      ),
                      Tooltip(
                        message: 'Refreshes Phase 32 observability metrics (sync, fulfillment, jobs).',
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ref.read(observabilitySnapshotVersionProvider.notifier).state++;
                          },
                          icon: const Icon(Icons.insights_outlined, size: 18),
                          label: const Text('Refresh observability'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _ObservabilityCard(),
                const SizedBox(height: 8),
                rulesAsync.when(
                  data: (rules) => Card(
                    child:                     ListTile(
                      title: const Text('Run scan'),
                      subtitle: Text('Keywords: ${rules.searchKeywords.join(", ").isEmpty ? "none" : rules.searchKeywords.join(", ")}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InfoIcon(
                            tooltip: 'Scans your connected suppliers using the search keywords from Settings. '
                                'Creates or updates listings; they will appear in Pending or Draft depending on your "Manual approval for listings" setting.',
                          ),
                          const SizedBox(width: 8),
                          Tooltip(
                            message: 'Scans supplier catalog and creates or updates listings based on search keywords.',
                            child: FilledButton(
                              onPressed: () async {
                                final scanner = ref.read(scannerProvider);
                                await scanner.run();
                                ref.invalidate(listingsProvider);
                              },
                              child: const Text('Scan'),
                            ),
                          ),
                        ],
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
    bool isWide, {
    List<String>? tapRoutes,
  }) {
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

    Widget card(int i) {
      final cardWidget = _StyledKpiCard(data: kpis[i]);
      final route = tapRoutes != null && i < tapRoutes.length ? tapRoutes[i] : null;
      if (route != null && route.isNotEmpty) {
        return InkWell(
          onTap: () => context.go(route),
          borderRadius: BorderRadius.circular(12),
          child: cardWidget,
        );
      }
      return cardWidget;
    }

    if (isWide) {
      return Row(
        children: [
          for (var i = 0; i < kpis.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            Expanded(child: card(i)),
          ],
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: card(0)),
            const SizedBox(width: 12),
            Expanded(child: card(1)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: card(2)),
            const SizedBox(width: 12),
            Expanded(child: card(3)),
          ],
        ),
      ],
    );
  }

  static String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }
}

// ─── Automation Status Panel (Layer 1: System state) ───────────────────────────

String _timeAgo(DateTime? dt) {
  if (dt == null) return '—';
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours} h ago';
  return '${diff.inDays} d ago';
}

class _AutomationStatusPanel extends ConsumerWidget {
  const _AutomationStatusPanel({required this.automation});
  final dynamic automation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobCountAsync = ref.watch(pendingJobCountProvider);
    final isActive = automation.isScanRunning || automation.isSyncRunning || automation.isPriceRefreshRunning || automation.isMarketplaceSyncRunning;
    final cs = Theme.of(context).colorScheme;
    const delayThresholdMinutes = 120; // 2 h
    bool isDelayed(DateTime? t) {
      if (t == null) return false;
      return DateTime.now().difference(t).inMinutes > delayThresholdMinutes;
    }
    final scanDelayed = isDelayed(automation.lastScanTime);
    final syncDelayed = isDelayed(automation.lastSyncTime);
    final anyDelayed = scanDelayed || syncDelayed;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings_suggest, color: cs.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'System status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: Icon(Icons.power_settings_new, size: 16, color: isActive ? cs.primary : cs.outline),
                  label: Text(isActive ? 'ACTIVE' : 'PAUSED'),
                  backgroundColor: isActive ? cs.primaryContainer : cs.surfaceContainerHighest,
                ),
                jobCountAsync.when(
                  data: (n) => Chip(
                    label: Text('Jobs queued: $n'),
                    backgroundColor: cs.surfaceContainerHighest,
                  ),
                  loading: () => const Chip(label: Text('Jobs: …')),
                  error: (_, _) => const Chip(label: Text('Jobs: ?')),
                ),
                ref.watch(dashboardKpiProvider).when(
                  data: (kpi) => Chip(
                    label: Text('Automation health: ${kpi.automationHealthLabel}'),
                    backgroundColor: kpi.automationHealthScore >= 80
                        ? cs.primaryContainer
                        : kpi.automationHealthScore >= 50
                            ? cs.tertiaryContainer
                            : cs.errorContainer,
                  ),
                  loading: () => const Chip(label: Text('Health: …')),
                  error: (_, _) => const Chip(label: Text('Health: ?')),
                ),
                Chip(
                  label: Text('Supplier sync: ${_timeAgo(automation.lastSyncTime)}'),
                  backgroundColor: syncDelayed ? cs.errorContainer : cs.surfaceContainerHighest,
                ),
                Chip(
                  label: Text('Marketplace sync: ${_timeAgo(automation.lastMarketplaceSyncTime)}'),
                  backgroundColor: cs.surfaceContainerHighest,
                ),
                Chip(
                  label: Text('Price refresh: ${_timeAgo(automation.lastPriceRefreshTime)}'),
                  backgroundColor: cs.surfaceContainerHighest,
                ),
                Chip(
                  label: Text('Scan: ${_timeAgo(automation.lastScanTime)}'),
                  backgroundColor: scanDelayed ? cs.errorContainer : cs.surfaceContainerHighest,
                ),
              ],
            ),
            if (anyDelayed) ...[
              const SizedBox(height: 8),
              Text(
                'Automation delayed. One or more tasks have not run recently. Check timers or run manually.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AutomationTimelinePanel extends StatelessWidget {
  const _AutomationTimelinePanel({required this.automation});
  final dynamic automation;

  @override
  Widget build(BuildContext context) {
    final entries = <_TimelineEntry>[
      if (automation.lastSyncTime != null)
        _TimelineEntry('Supplier sync finished', automation.lastSyncTime!),
      if (automation.lastMarketplaceSyncTime != null)
        _TimelineEntry('Marketplace sync finished', automation.lastMarketplaceSyncTime!),
      if (automation.lastPriceRefreshTime != null)
        _TimelineEntry('Price refresh completed', automation.lastPriceRefreshTime!),
      if (automation.lastScanTime != null)
        _TimelineEntry('Supplier scan completed', automation.lastScanTime!),
      if (automation.lastProductRefreshTime != null)
        _TimelineEntry('Product refresh completed', automation.lastProductRefreshTime!),
      if (automation.lastLowStockRefreshTime != null)
        _TimelineEntry('Low stock refresh completed', automation.lastLowStockRefreshTime!),
    ];
    entries.sort((a, b) => b.time.compareTo(a.time));
    final recent = entries.take(10).toList();
    if (recent.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.timeline, color: Theme.of(context).colorScheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Automation timeline',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'No automation events yet. Run a scan or sync to see recent activity.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timeline, color: Theme.of(context).colorScheme.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Automation timeline',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...recent.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, size: 16, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(child: Text(e.label, style: Theme.of(context).textTheme.bodyMedium)),
                  Text(_timeAgo(e.time), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class _TimelineEntry {
  _TimelineEntry(this.label, this.time);
  final String label;
  final DateTime time;
}

// ─── Layer 3: Risk indicators ─────────────────────────────────────────────────

class _DashboardRiskLayer extends StatelessWidget {
  const _DashboardRiskLayer({
    required this.listingsAsync,
    required this.ordersAsync,
    required this.returnsAsync,
    required this.incidentsAsync,
  });
  final AsyncValue<List<Listing>> listingsAsync;
  final AsyncValue<List<Order>> ordersAsync;
  final AsyncValue<List<ReturnRequest>> returnsAsync;
  final AsyncValue<List<IncidentRecord>> incidentsAsync;

  @override
  Widget build(BuildContext context) {
    final listings = listingsAsync.valueOrNull;
    final orders = ordersAsync.valueOrNull;
    final returns = returnsAsync.valueOrNull;
    final incidents = incidentsAsync.valueOrNull;
    if (listings == null || orders == null || returns == null || incidents == null) {
      return const Card(child: Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Center(child: CircularProgressIndicator())));
    }
    final shippedOrDelivered = orders.where((o) => o.status == OrderStatus.shipped || o.status == OrderStatus.delivered).length;
    final returnRate = shippedOrDelivered > 0 ? (returns.length / shippedOrDelivered * 100) : 0.0;
    final incidentRate = shippedOrDelivered > 0 ? (incidents.length / shippedOrDelivered * 100) : 0.0;
    final pausedCount = listings.where((l) => l.status == ListingStatus.paused).length;
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            InkWell(
              onTap: () => context.go('/returns'),
              borderRadius: BorderRadius.circular(8),
              child: Chip(
                label: Text('Return rate: ${returnRate.toStringAsFixed(1)}%'),
                backgroundColor: cs.surfaceContainerHighest,
              ),
            ),
            InkWell(
              onTap: () => context.go('/incidents'),
              borderRadius: BorderRadius.circular(8),
              child: Chip(
                label: Text('Incident rate: ${incidentRate.toStringAsFixed(1)}%'),
                backgroundColor: cs.surfaceContainerHighest,
              ),
            ),
            InkWell(
              onTap: () => context.go('/products'),
              borderRadius: BorderRadius.circular(8),
              child: Chip(
                label: Text('Listings paused: $pausedCount'),
                backgroundColor: pausedCount > 0 ? cs.errorContainer : cs.surfaceContainerHighest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Layer 4: Operational alerts ─────────────────────────────────────────────

class _DashboardAlertsLayer extends StatelessWidget {
  const _DashboardAlertsLayer({
    required this.listingsAsync,
    required this.ordersAsync,
  });
  final AsyncValue<List<Listing>> listingsAsync;
  final AsyncValue<List<Order>> ordersAsync;

  @override
  Widget build(BuildContext context) {
    final listings = listingsAsync.valueOrNull;
    final orders = ordersAsync.valueOrNull;
    if (listings == null || orders == null) {
      return const Card(child: Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Center(child: CircularProgressIndicator())));
    }
    final queuedForCapital = orders.where((o) => o.queuedForCapital).length;
    final pausedCount = listings.where((l) => l.status == ListingStatus.paused).length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (queuedForCapital > 0)
              ListTile(
                leading: const Icon(Icons.schedule),
                title: Text('Orders queued for capital: $queuedForCapital'),
                trailing: TextButton(
                  onPressed: () => context.go('/orders?queued=1'),
                  child: const Text('View in Orders'),
                ),
              ),
            if (pausedCount > 0)
              ListTile(
                leading: const Icon(Icons.pause_circle_outline),
                title: Text('Listings paused: $pausedCount'),
                trailing: TextButton(
                  onPressed: () => context.go('/products'),
                  child: const Text('View in Products'),
                ),
              ),
            if (queuedForCapital == 0 && pausedCount == 0)
              Text(
                'No operational alerts.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
          ],
        ),
      ),
    );
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
    final theme = Theme.of(context);
    return Card(
      color: data.containerColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(data.icon, size: 22, color: data.onContainerColor),
                const Spacer(),
                Icon(
                  data.trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 18,
                  color: data.trendUp ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              data.value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: data.onContainerColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              data.label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: data.onContainerColor.withValues(alpha: 0.8),
              ),
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
    final theme = Theme.of(context);
    final active = listings.where((l) => l.status.name == 'active').length;
    final pending = listings.where((l) => l.status.name == 'pendingApproval').length;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Listings', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Text('Active: $active', style: theme.textTheme.bodyLarge),
            Text('Pending approval: $pending', style: theme.textTheme.bodyLarge),
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
    final theme = Theme.of(context);
    final pending = orders.where((o) => o.status.name == 'pending' || o.status.name == 'pendingApproval').length;
    final totalSales = orders.fold<double>(0, (s, o) => s + o.sellingPrice);
    final totalCost = orders.fold<double>(0, (s, o) => s + o.sourceCost);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Orders', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Text('Pending: $pending', style: theme.textTheme.bodyLarge),
            Text('Total sales: ${totalSales.toStringAsFixed(2)} PLN', style: theme.textTheme.bodyLarge),
            Text('Total cost: ${totalCost.toStringAsFixed(2)} PLN', style: theme.textTheme.bodyLarge),
            Text('Est. profit: ${(totalSales - totalCost).toStringAsFixed(2)} PLN', style: theme.textTheme.bodyLarge),
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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: (automation.isScanRunning && automation.isSyncRunning)
                      ? null
                      : () => automation.startAll(),
                  child: const Text('Start all'),
                ),
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
      child: Wrap(
        spacing: 8,
        runSpacing: 2,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            running ? Icons.play_circle : Icons.stop_circle,
            size: 16,
            color: running ? Colors.green : Colors.grey,
          ),
          Text('$label: ${running ? "Running" : "Stopped"}'),
          if (lastTime != null)
            Text(
              '(last: ${DashboardScreen._formatTime(lastTime!)})',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
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
