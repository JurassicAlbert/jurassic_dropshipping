import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';

class DecisionLogScreen extends ConsumerWidget {
  const DecisionLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(decisionLogsProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(decisionLogsProvider),
      child: async.when(
        data: (logs) => logs.isEmpty
            ? const Center(child: Text('No decision logs yet.'))
            : ListView.builder(
                itemCount: logs.length,
                itemBuilder: (_, i) {
                  final log = logs[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ListTile(
                      title: Text(log.reason),
                      subtitle: Text('${log.type.name} · ${log.entityId}'),
                      trailing: Text(_formatDate(log.createdAt)),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
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
