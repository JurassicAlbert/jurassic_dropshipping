import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/info_icon.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/section_header.dart';

/// Capital / ledger screen (Phase 14). Shows available balance, add adjustment, orders queued for capital.
class CapitalScreen extends ConsumerStatefulWidget {
  const CapitalScreen({super.key});

  @override
  ConsumerState<CapitalScreen> createState() => _CapitalScreenState();
}

class _CapitalScreenState extends ConsumerState<CapitalScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balanceAsync = ref.watch(capitalBalanceProvider);
    final ordersAsync = ref.watch(ordersProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: 'Capital',
            icon: Icons.account_balance,
            subtitle: 'Track available funds and orders waiting for capital.',
          ),
          const ScreenHelpSection(
            description: ScreenHelpTexts.capital,
            howToUse: 'How to use: Record adjustments to correct balance. View orders queued for capital and open them from here.',
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          balanceAsync.when(
            loading: () => const LoadingSkeleton(),
            error: (e, _) => ErrorCard(
              message: 'Failed to load balance.',
              onRetry: () => ref.invalidate(capitalBalanceProvider),
            ),
            data: (balance) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available capital',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${balance.toStringAsFixed(2)} PLN',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: balance >= 0
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        'Add adjustment',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(width: 6),
                      InfoIcon(
                        tooltip: 'Use this to set your starting capital or correct the balance (e.g. money in, bank error). '
                            'Positive amount increases available capital; negative decreases it. Orders "Queued for capital" need enough balance before fulfillment.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Record initial capital or a correction (positive or negative amount in PLN).',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount (PLN)',
                      hintText: 'e.g. 1000 or -50',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Note (optional)',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Tooltip(
                    message: 'Add a capital adjustment (positive or negative) to correct your balance. Used for initial funding or corrections.',
                    child: FilledButton.icon(
                      onPressed: () => _addAdjustment(context),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Record adjustment'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          const _RecentLedgerActivity(),
          const SizedBox(height: AppSpacing.sectionGap),
          ordersAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (orders) {
              final queued = orders.where((o) => o.queuedForCapital).toList();
              if (queued.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Text(
                      'No orders queued for capital.',
                      style: Theme.of(context).textTheme.bodyMedium,
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
                          Text(
                            'Orders queued for capital (${queued.length})',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => context.go('/orders?queued=1'),
                            child: const Text('View in Orders'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...queued.take(5).map(
                            (o) => ListTile(
                              dense: true,
                              title: Text(o.targetOrderId),
                              subtitle: Text(
                                'Cost: ${o.sourceCost.toStringAsFixed(2)} PLN',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                              onTap: () => context.go('/orders?orderId=${Uri.encodeComponent(o.id)}'),
                            ),
                          ),
                      if (queued.length > 5)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '... and ${queued.length - 5} more',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addAdjustment(BuildContext context) async {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a non-zero amount')),
      );
      return;
    }
    final note = _noteController.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final capital = ref.read(capitalManagementServiceProvider);
    await capital.recordAdjustment(amount, referenceId: note.isEmpty ? null : note);
    _amountController.clear();
    _noteController.clear();
    ref.invalidate(capitalBalanceProvider);
    ref.invalidate(ledgerRecentEntriesProvider);
    if (mounted) {
      messenger.showSnackBar(
        SnackBar(content: Text('Adjustment recorded: ${amount >= 0 ? '+' : ''}${amount.toStringAsFixed(2)} PLN')),
      );
    }
  }
}

/// Provider for current capital balance (Phase 14).
final capitalBalanceProvider = FutureProvider<double>((ref) {
  return ref.watch(capitalManagementServiceProvider).getAvailableCapital();
});

/// Provider for recent ledger entries (Capital screen activity list).
final ledgerRecentEntriesProvider = FutureProvider<List<FinancialLedgerRow>>((ref) {
  return ref.watch(financialLedgerRepositoryProvider).getRecentEntries(limit: 30);
});

/// Recent ledger activity card.
class _RecentLedgerActivity extends ConsumerWidget {
  const _RecentLedgerActivity();

  static Future<void> _exportLedgerCsv(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(financialLedgerRepositoryProvider);
    final entries = await repo.getRecentEntries(limit: 5000);
    final buffer = StringBuffer();
    buffer.writeln('type,orderId,amount,currency,referenceId,createdAt');
    for (final r in entries) {
      final orderId = r.orderId ?? '';
      final refId = (r.referenceId ?? '').replaceAll('"', '""');
      final createdAt = r.createdAt.toIso8601String();
      buffer.writeln('${r.type},"$orderId",${r.amount},${r.currency},"$refId",$createdAt');
    }
    final csv = buffer.toString();
    if (!context.mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ledger export (CSV)'),
        content: SizedBox(
          width: double.maxFinite,
          height: 320,
          child: SingleChildScrollView(
            child: SelectableText(
              entries.isEmpty ? 'No entries.' : csv,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Close')),
          FilledButton.icon(
            icon: const Icon(Icons.copy, size: 18),
            label: const Text('Copy to clipboard'),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: csv));
              if (ctx.mounted) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('CSV copied to clipboard')),
                );
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  static String _typeLabel(String type) {
    return type
        .replaceAll('_', ' ')
        .replaceAllMapped(RegExp(r'^(\w)'), (m) => m.group(1)!.toUpperCase());
  }

  static String _formatDate(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entryDay = DateTime(d.year, d.month, d.day);
    if (entryDay == today) {
      return 'Today ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    }
    return '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(ledgerRecentEntriesProvider);
    return entriesAsync.when(
      loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: LoadingSkeleton())),
      error: (e, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Could not load activity.', style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
      data: (entries) {
        if (entries.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No ledger activity yet. Add an adjustment or fulfill orders to see entries here.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        }
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Recent activity',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    TextButton.icon(
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('Export CSV'),
                      onPressed: () => _exportLedgerCsv(context, ref),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: entries.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final r = entries[i];
                    final isInflow = r.amount >= 0;
                    return ListTile(
                      dense: true,
                      title: Text(_typeLabel(r.type)),
                      subtitle: Text(
                        [
                          if (r.orderId != null) 'Order: ${r.orderId}',
                          if (r.referenceId != null && r.referenceId!.isNotEmpty) r.referenceId,
                          _formatDate(r.createdAt),
                        ].join(' · '),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Text(
                        '${isInflow ? '+' : ''}${r.amount.toStringAsFixed(2)} PLN',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isInflow
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.error,
                            ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
