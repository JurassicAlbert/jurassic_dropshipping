import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/section_header.dart';

class ProfitDashboardScreen extends ConsumerWidget {
  const ProfitDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    final ordersAsync = ref.watch(ordersProvider);
    final returnsAsync = ref.watch(returnRequestsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(listingsProvider);
        ref.invalidate(ordersProvider);
        ref.invalidate(returnRequestsProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(title: 'Profit intelligence', icon: Icons.trending_up),
            const ScreenHelpSection(
              description: ScreenHelpTexts.profitDashboard,
              howToUse: 'How to use: Tap KPI cards or list items to open Analytics, Orders, Returns or Products. Focus on margin risk and return loss.',
            ),
            const SizedBox(height: AppSpacing.sectionGap),

            listingsAsync.when(
              data: (listings) {
                return ordersAsync.when(
                  data: (orders) {
                    return returnsAsync.when(
                      data: (returns) {
                        final now = DateTime.now();
                        final todayStart = DateTime(now.year, now.month, now.day);
                        final todayEnd = todayStart.add(const Duration(days: 1));
                        final profitToday = orders
                            .where((o) {
                              final c = o.createdAt;
                              if (c == null) return false;
                              return !c.isBefore(todayStart) && c.isBefore(todayEnd);
                            })
                            .fold<double>(0, (s, o) => s + (o.sellingPrice - o.sourceCost) * (o.quantity));
                        final totalReturnLoss = returns.fold<double>(
                          0,
                          (s, r) => s + (r.refundAmount ?? 0) + (r.returnShippingCost ?? 0),
                        );
                        final avgMargin = listings.isEmpty
                            ? 0.0
                            : listings.fold<double>(0, (s, l) {
                                if (l.sourceCost <= 0) return s;
                                return s + (l.sellingPrice - l.sourceCost) / l.sourceCost;
                              }) / listings.length;
                        const marginThreshold = 0.10;
                        final belowThreshold = listings.where((l) {
                          if (l.sourceCost <= 0) return l.sellingPrice < l.sourceCost;
                          final margin = (l.sellingPrice - l.sourceCost) / l.sourceCost;
                          return margin < marginThreshold;
                        }).length;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _KpiCard(
                                    label: 'Avg. product margin',
                                    value: '${(avgMargin * 100).toStringAsFixed(1)}%',
                                    onTap: () => context.go('/analytics'),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.cardGap),
                                Expanded(
                                  child: _KpiCard(
                                    label: 'Profit today (orders)',
                                    value: profitToday.toStringAsFixed(0),
                                    onTap: () => context.go('/orders'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.cardGap),
                            Row(
                              children: [
                                Expanded(
                                  child: _KpiCard(
                                    label: 'Total loss from returns',
                                    value: totalReturnLoss.toStringAsFixed(0),
                                    onTap: () => context.go('/returns'),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.cardGap),
                                Expanded(
                                  child: _KpiCard(
                                    label: 'Listings below 10% margin',
                                    value: '$belowThreshold',
                                    onTap: () => context.go('/products'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sectionGap),
                            _ProfitLeadersSection(orders: orders),
                            const SizedBox(height: AppSpacing.sectionGap),
                            _MarginRiskSection(listings: listings),
                            const SizedBox(height: AppSpacing.sectionGap),
                            _ReturnCostSection(returns: returns),
                            const SizedBox(height: AppSpacing.sectionGap),
                            _ReturnLossBySupplierSection(returns: returns),
                          ],
                        );
                      },
                      loading: () => const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator())),
                      error: (e, _) => ErrorCard(message: 'Failed to load returns.', onRetry: () => ref.invalidate(returnRequestsProvider)),
                    );
                  },
                  loading: () => const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator())),
                  error: (e, _) => ErrorCard(message: 'Failed to load orders.', onRetry: () => ref.invalidate(ordersProvider)),
                );
              },
              loading: () => const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator())),
              error: (e, _) => ErrorCard(message: 'Failed to load listings.', onRetry: () => ref.invalidate(listingsProvider)),
            ),
          ],
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.label, required this.value, this.onTap});
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: card,
      );
    }
    return card;
  }
}

class _ProfitLeadersSection extends StatelessWidget {
  const _ProfitLeadersSection({required this.orders});
  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    final byListing = <String, double>{};
    for (final o in orders) {
      final profit = (o.sellingPrice - o.sourceCost) * (o.quantity);
      byListing[o.listingId] = (byListing[o.listingId] ?? 0) + profit;
    }
    final sorted = byListing.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted.take(10).toList();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.leaderboard, color: Theme.of(context).colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Profit leaders (by listing)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (top.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No order data yet.'),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final e = top[i];
                return ListTile(
                  title: Text(e.key),
                  trailing: Text(e.value.toStringAsFixed(2), style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  onTap: () => context.go('/products'),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _MarginRiskSection extends StatelessWidget {
  const _MarginRiskSection({required this.listings});
  final List<Listing> listings;

  static const _marginThreshold = 0.10;

  @override
  Widget build(BuildContext context) {
    final bad = listings.where((l) {
      if (l.sourceCost <= 0) return l.sellingPrice < l.sourceCost;
      final margin = (l.sellingPrice - l.sourceCost) / l.sourceCost;
      return margin < _marginThreshold;
    }).toList()
      ..sort((a, b) {
        final ma = a.sourceCost > 0 ? (a.sellingPrice - a.sourceCost) / a.sourceCost : -1.0;
        final mb = b.sourceCost > 0 ? (b.sellingPrice - b.sourceCost) / b.sourceCost : -1.0;
        return ma.compareTo(mb);
      });
    final top = bad.take(10).toList();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.warning_amber_outlined, color: Theme.of(context).colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Margin risk products',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('${bad.length}'),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  side: BorderSide.none,
                ),
              ],
            ),
          ),
          if (top.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No listings below margin threshold.'),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final l = top[i];
                final margin = l.sourceCost > 0 ? (l.sellingPrice - l.sourceCost) / l.sourceCost : 0.0;
                return ListTile(
                  title: Text(l.id),
                  subtitle: Text('Margin: ${(margin * 100).toStringAsFixed(1)}% · Price: ${l.sellingPrice.toStringAsFixed(2)}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => context.go('/products'),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ReturnCostSection extends StatelessWidget {
  const _ReturnCostSection({required this.returns});
  final List<ReturnRequest> returns;

  @override
  Widget build(BuildContext context) {
    final total = returns.fold<double>(0, (s, r) => s + (r.refundAmount ?? 0) + (r.returnShippingCost ?? 0));
    final byStatus = <ReturnStatus, double>{};
    for (final r in returns) {
      final cost = (r.refundAmount ?? 0) + (r.returnShippingCost ?? 0);
      byStatus[r.status] = (byStatus[r.status] ?? 0) + cost;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assignment_return, color: Theme.of(context).colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Return cost breakdown',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Total loss (refund + shipping): ${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            ...byStatus.entries.map((e) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('${e.key.name}: ${e.value.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodySmall),
                )),
          ],
        ),
      ),
    );
  }
}

class _ReturnLossBySupplierSection extends StatelessWidget {
  const _ReturnLossBySupplierSection({required this.returns});
  final List<ReturnRequest> returns;

  @override
  Widget build(BuildContext context) {
    final bySupplier = <String, double>{};
    for (final r in returns) {
      final supplierId = r.supplierId ?? 'Unknown';
      final cost = (r.refundAmount ?? 0) + (r.returnShippingCost ?? 0);
      bySupplier[supplierId] = (bySupplier[supplierId] ?? 0) + cost;
    }
    final sorted = bySupplier.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted.take(10).toList();

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.store, color: Theme.of(context).colorScheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Return loss by supplier',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          if (top.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No return cost data by supplier.'),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final e = top[i];
                return ListTile(
                  title: Text(e.key),
                  trailing: Text(e.value.toStringAsFixed(2), style: Theme.of(context).textTheme.titleSmall),
                  onTap: () => context.go('/suppliers'),
                );
              },
            ),
        ],
      ),
    );
  }
}
