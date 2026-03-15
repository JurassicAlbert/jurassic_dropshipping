import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/repositories/background_job_repository.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';

/// Incident detail: type, status, order link, decision, financial impact, actions.
class IncidentDetailScreen extends ConsumerWidget {
  const IncidentDetailScreen({super.key, required this.incidentId});

  final int incidentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(incidentDetailProvider(incidentId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/incidents'),
        ),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Failed to load incident: $e', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => ref.invalidate(incidentDetailProvider(incidentId)),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (record) {
          if (record == null) {
            return const Center(child: Text('Incident not found'));
          }
          return _IncidentDetailBody(record: record);
        },
      ),
    );
  }
}

class _IncidentDetailBody extends ConsumerWidget {
  const _IncidentDetailBody({required this.record});

  final IncidentRecord record;

  static String _formatType(String name) {
    return name
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)!.toLowerCase()}')
        .replaceAll('_', ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final statusColor = switch (record.status) {
      IncidentStatus.open => theme.colorScheme.error,
      IncidentStatus.resolved => theme.colorScheme.primary,
      _ => theme.colorScheme.outline,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber, color: statusColor, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _formatType(record.incidentType.name),
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          record.status.name,
                          style: theme.textTheme.labelLarge?.copyWith(color: statusColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _DetailRow(label: 'Order', value: record.orderId),
                  _DetailRow(label: 'Trigger', value: record.trigger),
                  _DetailRow(label: 'Created', value: record.createdAt.toIso8601String()),
                  if (record.resolvedAt != null)
                    _DetailRow(label: 'Resolved', value: record.resolvedAt!.toIso8601String()),
                  if (record.automaticDecision != null)
                    _DetailRow(label: 'Decision', value: record.automaticDecision!),
                  if (record.refundAmount != null)
                    _DetailRow(label: 'Refund amount', value: '${record.refundAmount!.toStringAsFixed(2)} PLN'),
                  if (record.financialImpact != null)
                    _DetailRow(label: 'Financial impact', value: '${record.financialImpact!.toStringAsFixed(2)} PLN'),
                  if (record.attachmentIds != null && record.attachmentIds!.isNotEmpty)
                    _DetailRow(label: 'Attachments', value: record.attachmentIds!.join(', ')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.go('/orders?orderId=${Uri.encodeComponent(record.orderId)}'),
            icon: const Icon(Icons.receipt_long),
            label: const Text('View order'),
          ),
          if (record.decisionLogId != null) ...[
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => context.go('/decision-log?entityId=${Uri.encodeComponent(record.orderId)}'),
              icon: const Icon(Icons.assignment_outlined, size: 18),
              label: const Text('View decision log'),
            ),
          ],
          if (record.status == IncidentStatus.open) ...[
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                await ref.read(backgroundJobRepositoryProvider).enqueue(
                      BackgroundJobType.processIncident,
                      {'incidentId': record.id},
                    );
                if (!context.mounted) return;
                ref.invalidate(incidentDetailProvider(record.id));
                ref.invalidate(incidentsProvider);
                messenger.showSnackBar(
                  const SnackBar(content: Text('Process incident job enqueued')),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Process (enqueue job)'),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
