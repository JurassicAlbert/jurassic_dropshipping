import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/domain/listing_health/listing_health_metrics.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/search_filter_bar.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _statusFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Listing> _applyFilters(List<Listing> listings) {
    var filtered = listings;

    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered
          .where((l) =>
              l.id.toLowerCase().contains(query) ||
              l.productId.toLowerCase().contains(query))
          .toList();
    }

    if (_statusFilter != 'all') {
      filtered = filtered.where((l) {
        return switch (_statusFilter) {
          'active' => l.status == ListingStatus.active,
          'pending' => l.status == ListingStatus.pendingApproval,
          'draft' => l.status == ListingStatus.draft,
          _ => true,
        };
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listingsAsync = ref.watch(listingsProvider);
    final healthAsync = ref.watch(listingHealthMetricsListProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(listingsProvider);
        ref.invalidate(listingHealthMetricsListProvider);
      },
      child: listingsAsync.when(
        data: (listings) {
          final filtered = _applyFilters(listings);
          final healthMap = healthAsync.valueOrNull != null
              ? {for (final h in healthAsync.valueOrNull!) h.listingId: h}
              : <String, ListingHealthRecord>{};
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
                child: ScreenHelpSection(
                  description: ScreenHelpTexts.products,
                  howToUse: 'How to use: Use the search bar and status chips to filter. Tap a listing to see details. Run a scan from Dashboard to add products.',
                ),
              ),
              SearchFilterBar(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                hintText: 'Search by listing ID or product ID...',
                filterChips: [
                  for (final entry in {'all': 'All', 'active': 'Active', 'pending': 'Pending', 'draft': 'Draft'}.entries)
                    Tooltip(
                      message: 'Filter listings by status: ${entry.value}',
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(entry.value),
                          selected: _statusFilter == entry.key,
                          onSelected: (_) => setState(() => _statusFilter = entry.key),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: filtered.isEmpty
                    ? EmptyState(
                        icon: Icons.inventory_2,
                        title: 'No products found',
                        subtitle: 'Run a supplier scan to import available products.',
                        action: FilledButton.icon(
                          onPressed: () => context.go('/dashboard'),
                          icon: const Icon(Icons.dashboard, size: 18),
                          label: const Text('Go to Dashboard'),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          AppSpacing.sm,
                          AppSpacing.lg,
                          AppSpacing.lg,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (_, i) {
                          final l = filtered[i];
                          final profit = l.sellingPrice - l.sourceCost;
                          final marginPct = l.sellingPrice > 0 ? (profit / l.sellingPrice * 100) : 0.0;
                          final health = healthMap[l.id];
                          final healthLabel = _healthLabel(l, health, marginPct);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(child: Text(l.id)),
                                  if (healthLabel != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Chip(
                                        label: Text(
                                          healthLabel.label,
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            color: theme.colorScheme.onSurface,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        backgroundColor: healthLabel.color,
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sell: ${l.sellingPrice.toStringAsFixed(2)} · '
                                    'Cost: ${l.sourceCost.toStringAsFixed(2)} · '
                                    'Profit: ${profit.toStringAsFixed(2)} PLN',
                                  ),
                                  if (l.promisedMinDays != null || l.promisedMaxDays != null)
                                    Text(
                                      'Delivery: ${l.promisedMinDays ?? "?"}–${l.promisedMaxDays ?? "?"}d',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                ],
                              ),
                              trailing: _statusChip(context, l.status),
                              isThreeLine: true,
                            ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const LoadingSkeleton(),
        error: (e, _) => ErrorCard(
          message: 'Failed to load data. Please try again.',
          onRetry: () => ref.invalidate(listingsProvider),
        ),
      ),
    );
  }

  ({String label, Color color})? _healthLabel(Listing l, ListingHealthRecord? health, double marginPct) {
    if (l.status == ListingStatus.paused) return (label: 'Paused', color: Colors.amber);
    if (l.status == ListingStatus.soldOut) return (label: 'Out of stock', color: Colors.red.shade700);
    if (marginPct < 0) return (label: 'Negative margin', color: Colors.red);
    if (marginPct < 10 && marginPct >= 0) return (label: 'Low margin', color: Colors.orange);
    if (health != null) {
      if (health.returnRate >= 0.2) return (label: 'High return rate', color: Colors.orange);
      if (health.lateRate >= 0.15) return (label: 'Late delivery risk', color: Colors.amber);
    }
    if (l.status == ListingStatus.active && health != null && health.returnRate < 0.1 && marginPct >= 10)
      return (label: 'Healthy', color: Colors.green.shade700);
    return null;
  }

  Widget _statusChip(BuildContext context, ListingStatus status) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final Color bg;
    final Color fg;
    switch (status) {
      case ListingStatus.active:
        bg = Colors.green.withValues(alpha: 0.15);
        fg = Colors.green.shade800;
        break;
      case ListingStatus.pendingApproval:
        bg = Colors.orange.withValues(alpha: 0.18);
        fg = Colors.orange.shade800;
        break;
      case ListingStatus.draft:
        bg = cs.surfaceContainerHighest;
        fg = cs.onSurfaceVariant;
        break;
      case ListingStatus.soldOut:
        bg = Colors.red.withValues(alpha: 0.15);
        fg = Colors.red.shade700;
        break;
      case ListingStatus.paused:
        bg = Colors.amber.withValues(alpha: 0.22);
        fg = Colors.brown.shade700;
        break;
    }
    return Chip(
      label: Text(
        status.name,
        style: theme.textTheme.labelLarge?.copyWith(
          color: fg,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: bg,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
