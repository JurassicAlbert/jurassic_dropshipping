import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/domain/listing_health/listing_health_metrics.dart';
import 'package:jurassic_dropshipping/domain/supplier_reliability/supplier_reliability_score.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/section_header.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

class RiskDashboardScreen extends ConsumerWidget {
  const RiskDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    final healthAsync = ref.watch(listingHealthMetricsListProvider);
    final suppliersAsync = ref.watch(supplierReliabilityScoresProvider);
    final ordersAsync = ref.watch(ordersProvider);
    final pausesAsync = ref.watch(recentListingPauseEventsProvider);
    final switchesAsync = ref.watch(recentSupplierSwitchEventsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(listingsProvider);
        ref.invalidate(listingHealthMetricsListProvider);
        ref.invalidate(supplierReliabilityScoresProvider);
        ref.invalidate(ordersProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(title: 'Risk dashboard', icon: Icons.warning_amber),
            const ScreenHelpSection(
              description: ScreenHelpTexts.riskDashboard,
              howToUse: 'How to use: Tap a risk card to open the related screen (Products, Orders, Suppliers). Address high-severity items first.',
            ),
            const SizedBox(height: AppSpacing.sectionGap),

            listingsAsync.when(
              data: (listings) {
                return healthAsync.when(
                  data: (healthList) {
                    return suppliersAsync.when(
                      data: (scores) {
                        return ordersAsync.when(
                          data: (_) {
                            final listingMap = {for (var l in listings) l.id: l};
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _NegativeMarginSection(listings: listings),
                                const SizedBox(height: AppSpacing.sectionGap),
                                _PausedListingsSection(listings: listings, pausesAsync: pausesAsync),
                                const SizedBox(height: AppSpacing.sectionGap),
                                _RecentSupplierSwitchesSection(switchesAsync: switchesAsync),
                                const SizedBox(height: AppSpacing.sectionGap),
                                _HighReturnRateSection(
                                  healthList: healthList,
                                  listingMap: listingMap,
                                ),
                                const SizedBox(height: AppSpacing.sectionGap),
                                _HighIncidentRateSection(
                                  healthList: healthList,
                                  listingMap: listingMap,
                                ),
                                const SizedBox(height: AppSpacing.sectionGap),
                                _SupplierReliabilitySection(scores: scores),
                                const SizedBox(height: AppSpacing.sectionGap),
                                _DeliveryDelaySection(
                                  healthList: healthList,
                                  listingMap: listingMap,
                                ),
                              ],
                            );
                          },
                          loading: () => const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator())),
                          error: (e, _) => ErrorCard(message: 'Failed to load orders.', onRetry: () => ref.invalidate(ordersProvider)),
                        );
                      },
                      loading: () => const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator())),
                      error: (e, _) => ErrorCard(message: 'Failed to load supplier scores.', onRetry: () => ref.invalidate(supplierReliabilityScoresProvider)),
                    );
                  },
                  loading: () => const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator())),
                  error: (e, _) => ErrorCard(message: 'Failed to load listing health.', onRetry: () => ref.invalidate(listingHealthMetricsListProvider)),
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

class _NegativeMarginSection extends StatelessWidget {
  const _NegativeMarginSection({required this.listings});
  final List<Listing> listings;

  @override
  Widget build(BuildContext context) {
    final bad = listings.where((l) => l.sellingPrice < l.sourceCost).toList();
    return _RiskSectionCard(
      title: 'Negative margin products',
      subtitle: 'Listings where selling price is below cost',
      count: bad.length,
      severity: bad.isEmpty ? null : (bad.length > 5 ? 'High' : 'Medium'),
      recommendedAction: 'Review pricing or pause listing',
      child: bad.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No negative margin listings.'),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bad.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final l = bad[i];
                final margin = l.sellingPrice - l.sourceCost;
                return ListTile(
                  title: Text('Listing ${l.id}'),
                  subtitle: Text('Margin: ${margin.toStringAsFixed(2)} · Price: ${l.sellingPrice.toStringAsFixed(2)}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => context.go('/products'),
                );
              },
            ),
    );
  }
}

class _PausedListingsSection extends StatelessWidget {
  const _PausedListingsSection({
    required this.listings,
    required this.pausesAsync,
  });

  final List<Listing> listings;
  final AsyncValue<List<ListingPauseEventRow>> pausesAsync;

  @override
  Widget build(BuildContext context) {
    final paused = listings.where((l) => l.status == ListingStatus.paused).toList();
    return _RiskSectionCard(
      title: 'Paused listings (auto-protection)',
      subtitle: 'Hard pauses are applied by ProfitGuard / Health scoring. Soft pauses are warnings only.',
      count: paused.length,
      severity: paused.isEmpty ? null : (paused.length > 5 ? 'High' : 'Medium'),
      recommendedAction: 'Open Products to review paused items and reasons',
      child: pausesAsync.when(
        data: (events) {
          final top = events.take(10).toList();
          if (top.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No pause events recorded yet.'),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: top.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final e = top[i];
              final recovered = e.recoveredAt != null;
              return ListTile(
                title: Text('Listing ${e.listingId}'),
                subtitle: Text('${e.pauseLevel.toUpperCase()} · ${e.reason}${recovered ? ' · recovered' : ''}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => context.go('/products'),
              );
            },
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: CircularProgressIndicator(),
        ),
        error: (_, _) => const Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Text('Could not load pause events.'),
        ),
      ),
    );
  }
}

class _RecentSupplierSwitchesSection extends StatelessWidget {
  const _RecentSupplierSwitchesSection({required this.switchesAsync});

  final AsyncValue<List<SupplierSwitchEventRow>> switchesAsync;

  @override
  Widget build(BuildContext context) {
    return _RiskSectionCard(
      title: 'Recent supplier switches',
      subtitle: 'Automatic switches to protect fulfillment (loop-protected)',
      count: switchesAsync.valueOrNull?.length ?? 0,
      severity: null,
      recommendedAction: 'Review if switches affect margin or quality',
      child: switchesAsync.when(
        data: (events) {
          final top = events.take(10).toList();
          if (top.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No supplier switches recorded yet.'),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: top.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final e = top[i];
              return ListTile(
                title: Text('Group ${e.groupId}'),
                subtitle: Text('${e.fromSupplierId ?? '—'} → ${e.toSupplierId} · ${e.reason}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () => context.go('/suppliers'),
              );
            },
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: CircularProgressIndicator(),
        ),
        error: (_, _) => const Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Text('Could not load switch events.'),
        ),
      ),
    );
  }
}

class _HighReturnRateSection extends StatelessWidget {
  const _HighReturnRateSection({
    required this.healthList,
    required this.listingMap,
  });
  final List<ListingHealthRecord> healthList;
  final Map<String, Listing> listingMap;

  static const _returnRateThreshold = 0.15;

  @override
  Widget build(BuildContext context) {
    final bad = healthList
        .where((h) => h.totalOrders >= 5 && h.returnRate >= _returnRateThreshold)
        .toList()
      ..sort((a, b) => b.returnRate.compareTo(a.returnRate));
    final top = bad.take(10).toList();
    return _RiskSectionCard(
      title: 'High return rate products',
      subtitle: 'Return/incident rate ≥ ${(_returnRateThreshold * 100).toInt()}% (min 5 orders)',
      count: bad.length,
      severity: bad.isEmpty ? null : (bad.length > 10 ? 'High' : 'Medium'),
      recommendedAction: 'Pause listing or review supplier',
      child: bad.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No high return rate listings.'),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final h = top[i];
                final listing = listingMap[h.listingId];
                return ListTile(
                  title: Text(listing != null ? 'Listing ${listing.id}' : h.listingId),
                  subtitle: Text('Return rate: ${(h.returnRate * 100).toStringAsFixed(1)}% (${h.returnOrIncidentCount}/${h.totalOrders})'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => context.go('/products'),
                );
              },
            ),
    );
  }
}

class _HighIncidentRateSection extends StatelessWidget {
  const _HighIncidentRateSection({
    required this.healthList,
    required this.listingMap,
  });
  final List<ListingHealthRecord> healthList;
  final Map<String, Listing> listingMap;

  static const _incidentRateThreshold = 0.10;

  @override
  Widget build(BuildContext context) {
    final bad = healthList
        .where((h) => h.totalOrders >= 3 && h.returnRate >= _incidentRateThreshold)
        .toList()
      ..sort((a, b) => b.returnRate.compareTo(a.returnRate));
    final top = bad.take(10).toList();
    return _RiskSectionCard(
      title: 'Listings with high incident rates',
      subtitle: 'Return/incident rate ≥ ${(_incidentRateThreshold * 100).toInt()}%',
      count: bad.length,
      severity: bad.isEmpty ? null : 'Medium',
      recommendedAction: 'Review incidents and supplier quality',
      child: bad.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No high incident rate listings.'),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final h = top[i];
                final listing = listingMap[h.listingId];
                return ListTile(
                  title: Text(listing != null ? 'Listing ${listing.id}' : h.listingId),
                  subtitle: Text('Incident/return: ${(h.returnRate * 100).toStringAsFixed(1)}%'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => context.go('/incidents'),
                );
              },
            ),
    );
  }
}

class _SupplierReliabilitySection extends StatelessWidget {
  const _SupplierReliabilitySection({required this.scores});
  final List<SupplierReliabilityScore> scores;

  static const _lowScoreThreshold = 60.0;

  @override
  Widget build(BuildContext context) {
    final bad = scores.where((s) => s.score < _lowScoreThreshold).toList()
      ..sort((a, b) => a.score.compareTo(b.score));
    final top = bad.take(10).toList();
    return _RiskSectionCard(
      title: 'Supplier reliability issues',
      subtitle: 'Suppliers with score < $_lowScoreThreshold',
      count: bad.length,
      severity: bad.isEmpty ? null : (bad.any((s) => s.score < 40) ? 'High' : 'Medium'),
      recommendedAction: 'Review supplier performance and orders',
      child: bad.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No low-reliability suppliers.'),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final s = top[i];
                return ListTile(
                  title: Text(s.supplierId),
                  subtitle: Text('Score: ${s.score.toStringAsFixed(0)}/100'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => context.go('/suppliers'),
                );
              },
            ),
    );
  }
}

class _DeliveryDelaySection extends StatelessWidget {
  const _DeliveryDelaySection({
    required this.healthList,
    required this.listingMap,
  });
  final List<ListingHealthRecord> healthList;
  final Map<String, Listing> listingMap;

  static const _lateRateThreshold = 0.20;

  @override
  Widget build(BuildContext context) {
    final bad = healthList
        .where((h) => h.totalOrders >= 3 && h.lateRate >= _lateRateThreshold)
        .toList()
      ..sort((a, b) => b.lateRate.compareTo(a.lateRate));
    final top = bad.take(10).toList();
    return _RiskSectionCard(
      title: 'Delivery delay risks',
      subtitle: 'Listings with late delivery rate ≥ ${(_lateRateThreshold * 100).toInt()}%',
      count: bad.length,
      severity: bad.isEmpty ? null : 'Medium',
      recommendedAction: 'Review promised delivery and supplier lead time',
      child: bad.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('No listings with high late delivery rate.'),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: top.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final h = top[i];
                final listing = listingMap[h.listingId];
                return ListTile(
                  title: Text(listing != null ? 'Listing ${listing.id}' : h.listingId),
                  subtitle: Text('Late rate: ${(h.lateRate * 100).toStringAsFixed(1)}% (${h.lateCount}/${h.totalOrders})'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => context.go('/orders'),
                );
              },
            ),
    );
  }
}

class _RiskSectionCard extends StatelessWidget {
  const _RiskSectionCard({
    required this.title,
    required this.subtitle,
    required this.count,
    required this.severity,
    required this.recommendedAction,
    required this.child,
  });
  final String title;
  final String subtitle;
  final int count;
  final String? severity;
  final String recommendedAction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_outlined, color: cs.primary, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (severity != null)
                      Chip(
                        label: Text(severity!),
                        backgroundColor: severity == 'High' ? cs.errorContainer : cs.tertiaryContainer,
                        side: BorderSide.none,
                      ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('$count'),
                      backgroundColor: cs.surfaceContainerHighest,
                      side: BorderSide.none,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  'Recommended: $recommendedAction',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
