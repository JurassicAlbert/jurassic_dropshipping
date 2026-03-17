import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/repositories/background_job_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart' as platforms;
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/search_filter_bar.dart';

/// Incidents dashboard (Phase 11). Lists incident records; create new or enqueue process job.
class IncidentsScreen extends ConsumerStatefulWidget {
  const IncidentsScreen({super.key, this.filterOrderId});

  /// When set, only incidents for this order are shown (e.g. from /incidents?orderId=xyz).
  final String? filterOrderId;

  @override
  ConsumerState<IncidentsScreen> createState() => _IncidentsScreenState();
}

class _IncidentsScreenState extends ConsumerState<IncidentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _statusFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<IncidentRecord> _applyFilters(List<IncidentRecord> incidents) {
    var list = widget.filterOrderId != null
        ? incidents.where((r) => r.orderId == widget.filterOrderId).toList()
        : List<IncidentRecord>.from(incidents);
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((r) => r.orderId.toLowerCase().contains(query)).toList();
    }
    if (_statusFilter != 'all') {
      list = list.where((r) {
        return _statusFilter == 'open' ? r.status == IncidentStatus.open : r.status == IncidentStatus.resolved;
      }).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final incidentsAsync = ref.watch(incidentsProvider);

    return incidentsAsync.when(
      loading: () => const LoadingSkeleton(),
      error: (e, _) => ErrorCard(
        message: 'Failed to load incidents.',
        onRetry: () => ref.invalidate(incidentsProvider),
      ),
      data: (incidents) {
        final filtered = _applyFilters(incidents);
        if (filtered.isEmpty) {
          return Column(
            children: [
              if (widget.filterOrderId != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      Chip(
                        label: Text('Order: ${widget.filterOrderId}'),
                        onDeleted: () => context.go('/incidents'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => context.go('/incidents'),
                        child: const Text('Show all'),
                      ),
                    ],
                  ),
                ),
              const Expanded(
                child: EmptyState(
                  icon: Icons.warning_amber_outlined,
                  title: 'No incidents',
                  subtitle: 'Post-order incidents (returns, complaints, damage) will appear here',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  onPressed: () => _showCreateDialog(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('Create incident'),
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            const ScreenHelpSection(
            description: ScreenHelpTexts.incidents,
            howToUse: 'How to use: Filter by status or order. Tap an incident to view details and link to the order or decision log.',
          ),
            if (widget.filterOrderId != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    Chip(
                      label: Text('Order: ${widget.filterOrderId}'),
                      onDeleted: () => context.go('/incidents'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () => context.go('/incidents'),
                      child: const Text('Show all'),
                    ),
                  ],
                ),
              ),
            SearchFilterBar(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              hintText: 'Search by order ID...',
              filterChips: [
                for (final entry in {'all': 'All', 'open': 'Open', 'resolved': 'Resolved'}.entries)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(entry.value),
                      selected: _statusFilter == entry.key,
                      onSelected: (_) => setState(() => _statusFilter = entry.key),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final r = filtered[index];
                  return _IncidentCard(record: r);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  FilledButton.icon(
                    onPressed: () => _showCreateDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Create incident'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => _showFetchAllegroReturnsDialog(context, ref),
                    icon: const Icon(Icons.download),
                    label: const Text('Fetch Allegro returns'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final orderIdController = TextEditingController();
    final attachmentIdsController = TextEditingController();
    var incidentType = IncidentType.customerReturn14d;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: const Text('Create incident'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: orderIdController,
                      decoration: const InputDecoration(
                        labelText: 'Order ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<IncidentType>(
                      initialValue: incidentType,
                      decoration: const InputDecoration(
                        labelText: 'Incident type',
                        border: OutlineInputBorder(),
                      ),
                      items: IncidentType.values
                          .map((t) => DropdownMenuItem(
                                value: t,
                                child: Text(_formatType(t.name)),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => incidentType = v ?? incidentType),
                    ),
                    if (incidentType == IncidentType.damageClaim) ...[
                      const SizedBox(height: 12),
                      TextField(
                        controller: attachmentIdsController,
                        decoration: const InputDecoration(
                          labelText: 'Attachment IDs (optional, comma-separated)',
                          border: OutlineInputBorder(),
                          hintText: 'e.g. photo_1, photo_2',
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
                FilledButton(
                  onPressed: () async {
                    final orderId = orderIdController.text.trim();
                    if (orderId.isEmpty) return;
                    final attachmentIdsStr = attachmentIdsController.text.trim();
                    final attachmentIds = attachmentIdsStr.isEmpty
                        ? null
                        : attachmentIdsStr
                            .split(',')
                            .map((s) => s.trim())
                            .where((s) => s.isNotEmpty)
                            .toList();
                    final navigator = Navigator.of(ctx);
                    final messenger = ScaffoldMessenger.of(context);
                    final engine = ref.read(incidentHandlingEngineProvider);
                    await engine.createIncident(
                      orderId: orderId,
                      incidentType: incidentType,
                      attachmentIds: attachmentIds?.isEmpty == true ? null : attachmentIds,
                    );
                    if (!context.mounted) return;
                    ref.invalidate(incidentsProvider);
                    navigator.pop();
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Incident created')),
                    );
                  },
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );
    orderIdController.dispose();
    attachmentIdsController.dispose();
  }

  Future<void> _showFetchAllegroReturnsDialog(BuildContext context, WidgetRef ref) async {
    final targets = ref.read(targetsListProvider);
    final allegro = targets.where((t) => t.id == 'allegro').firstOrNull;
    if (allegro == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Allegro target not configured')),
        );
      }
      return;
    }
    List<platforms.CustomerReturnSummary> returns;
    try {
      returns = await allegro.getCustomerReturns(since: DateTime.now().subtract(const Duration(days: 90)));
    } on UnsupportedError catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Allegro returns API not supported or not configured')),
        );
      }
      return;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch Allegro returns: $e')),
        );
      }
      return;
    }
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Allegro customer returns'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: returns.isEmpty
              ? const Center(child: Text('No customer returns in the last 90 days.'))
              : ListView.builder(
                  itemCount: returns.length,
                  itemBuilder: (_, i) {
                    final r = returns[i];
                    return ListTile(
                      title: Text(r.orderId),
                      subtitle: Text('${r.status} · ${r.createdAt != null ? r.createdAt!.toIso8601String().substring(0, 10) : ''}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final orderRepo = ref.read(orderRepositoryProvider);
                              final ourOrder = await orderRepo.getByTargetOrderId('allegro', r.orderId);
                              final orderIdForIncident = ourOrder?.id ?? r.orderId;
                              final engine = ref.read(incidentHandlingEngineProvider);
                              await engine.createIncident(orderId: orderIdForIncident, incidentType: IncidentType.customerReturn14d);
                              if (!ctx.mounted) return;
                              ref.invalidate(incidentsProvider);
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Incident created for order $orderIdForIncident')),
                              );
                            },
                            child: const Text('Create incident'),
                          ),
                          TextButton(
                            onPressed: () => _showRejectReturnDialog(ctx, ref, allegro, r),
                            child: const Text('Reject'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Close')),
        ],
      ),
    );
  }

  static Future<void> _showRejectReturnDialog(
    BuildContext context,
    WidgetRef ref,
    platforms.TargetPlatform allegro,
    platforms.CustomerReturnSummary r,
  ) async {
    final reasonController = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reject return refund'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            labelText: 'Reason (e.g. Item damaged on return)',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) return;
              try {
                await allegro.rejectReturn(r.id, reason);
                if (!ctx.mounted) return;
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Return rejected on Allegro')),
                );
              } on UnsupportedError catch (_) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reject not supported')),
                  );
                }
              } catch (e) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reject failed: $e')),
                  );
                }
              }
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
    reasonController.dispose();
  }

  static String _formatType(String name) {
    return name
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)!.toLowerCase()}')
        .replaceAll('_', ' ')
        .trim();
  }
}

class _IncidentCard extends ConsumerWidget {
  const _IncidentCard({required this.record});

  final IncidentRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final statusColor = switch (record.status) {
      IncidentStatus.open => theme.colorScheme.error,
      IncidentStatus.resolved => theme.colorScheme.primary,
      _ => theme.colorScheme.outline,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.go('/incidents/${record.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber, color: statusColor, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _formatType(record.incidentType.name),
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    record.status.name,
                    style: theme.textTheme.labelMedium?.copyWith(color: statusColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/orders?orderId=${Uri.encodeComponent(record.orderId)}'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                'Order: ${record.orderId}',
                style: theme.textTheme.bodySmall,
              ),
            ),
            if (record.financialImpact != null) ...[
              const SizedBox(height: 4),
              Text(
                'Impact: ${record.financialImpact!.toStringAsFixed(2)}',
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (record.resolvedAt != null)
              Text(
                'Resolved: ${record.resolvedAt}',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
              ),
            if (record.status == IncidentStatus.open) ...[
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: () => _enqueueProcess(context, ref),
                icon: const Icon(Icons.play_arrow, size: 18),
                label: const Text('Process (enqueue job)'),
              ),
            ],
          ],
        ),
        ),
      ),
    );
  }

  Future<void> _enqueueProcess(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final jobRepo = ref.read(backgroundJobRepositoryProvider);
    await jobRepo.enqueue(BackgroundJobType.processIncident, {'incidentId': record.id});
    if (!context.mounted) return;
    ref.invalidate(incidentsProvider);
    messenger.showSnackBar(
      const SnackBar(content: Text('Process incident job enqueued')),
    );
  }

  static String _formatType(String name) {
    return name
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)!.toLowerCase()}')
        .replaceAll('_', ' ')
        .trim();
  }
}
