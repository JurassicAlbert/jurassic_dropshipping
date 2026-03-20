import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';

class DecisionLogScreen extends ConsumerWidget {
  const DecisionLogScreen({super.key, this.filterEntityId});

  /// When set, only show logs whose entityId matches (e.g. from incident detail).
  final String? filterEntityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(decisionLogsProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(decisionLogsProvider),
      child: async.when(
        data: (logs) {
          final filtered = filterEntityId != null
              ? logs.where((l) => l.entityId == filterEntityId).toList()
              : logs;
          if (filtered.isEmpty) {
            return EmptyState(
              icon: Icons.list_alt,
              title: filterEntityId != null ? 'No decisions for this order' : 'No decisions logged',
              subtitle: filterEntityId != null
                  ? 'No log entries for entity $filterEntityId'
                  : 'Decision logs are created when the scanner runs',
            );
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
                  child: const ScreenHelpSection(
                    description: ScreenHelpTexts.decisionLog,
                    howToUse: 'How to use: Each entry shows why a listing or order was accepted, rejected or paused. Filter by order from an incident or order detail.',
                  ),
                ),
              ),
              if (filterEntityId != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          label: Text('Order: $filterEntityId'),
                          onDeleted: () => context.go('/decision-log'),
                        ),
                        TextButton(
                          onPressed: () => context.go('/decision-log'),
                          child: const Text('Show all'),
                        ),
                      ],
                    ),
                  ),
                ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) {
                    final log = filtered[i];
                    final snap = log.criteriaSnapshot ?? const <String, dynamic>{};
                    final hasIntel = snap.containsKey('returnRiskScore') ||
                        snap.containsKey('qualityScore') ||
                        snap.containsKey('competitionLevel') ||
                        snap.containsKey('dynamicPricingAdjusted');
                    final intelParts = <String>[
                      if (snap['returnRiskScore'] != null) 'risk ${snap['returnRiskScore']}',
                      if (snap['competitionLevel'] != null) 'comp ${snap['competitionLevel']}',
                      if (snap['dynamicPricingAdjusted'] != null) 'dyn ${snap['dynamicPricingAdjusted']}',
                    ];
                    return Card(
                      margin: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        title: Text(log.reason),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${log.type.name} · ${log.entityId}'),
                            if (hasIntel && intelParts.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: [
                                    for (final p in intelParts)
                                      Chip(
                                        label: Text(p),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        trailing: Text(_formatDate(log.createdAt)),
                      ),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ],
          );
        },
        loading: () => const LoadingSkeleton(),
        error: (e, _) => ErrorCard(
          message: 'Failed to load data. Please try again.',
          onRetry: () => ref.invalidate(decisionLogsProvider),
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day}/${d.month}/${d.year}';
  }
}
