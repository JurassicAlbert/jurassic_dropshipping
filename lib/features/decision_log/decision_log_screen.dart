import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';

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
              if (filterEntityId != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        Chip(
                          label: Text('Order: $filterEntityId'),
                          onDeleted: () => context.go('/decision-log'),
                        ),
                        const SizedBox(width: 8),
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
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        title: Text(log.reason),
                        subtitle: Text('${log.type.name} · ${log.entityId}'),
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
