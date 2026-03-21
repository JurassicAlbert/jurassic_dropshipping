import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/repositories/returned_stock_repository.dart';
import 'package:jurassic_dropshipping/domain/post_order/returned_stock.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/info_icon.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';

/// Returned stock management (Phase 11). List by product/supplier; quantity, condition, restockable; reduce or write off.
class ReturnedStockScreen extends ConsumerWidget {
  const ReturnedStockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(returnedStockListProvider);

    return async.when(
      loading: () => const LoadingSkeleton(),
      error: (e, _) => ErrorCard(
        message: 'Failed to load returned stock.',
        onRetry: () => ref.invalidate(returnedStockListProvider),
      ),
      data: (list) {
        if (list.isEmpty) {
          return const EmptyState(
            icon: Icons.inventory_2_outlined,
            title: 'No returned stock',
            subtitle: 'Stock from customer/supplier returns will appear here for fulfillment',
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg),
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.sectionGap),
                child: ScreenHelpSection(
                  description: ScreenHelpTexts.returnedStock,
                  howToUse: 'How to use: Reduce quantity when you fulfill from this stock; use Write off for items that cannot be restocked.',
                ),
              );
            }
            final s = list[index - 1];
            return _StockCard(stock: s);
          },
        );
      },
    );
  }
}

class _StockCard extends ConsumerWidget {
  const _StockCard({required this.stock});

  final ReturnedStock stock;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final repo = ref.watch(returnedStockRepositoryProvider);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    stock.productId,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!stock.restockable)
                  Chip(
                    label: Text('Not restockable', style: theme.textTheme.labelSmall),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: theme.colorScheme.errorContainer,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Supplier: ${stock.supplierId}', style: theme.textTheme.bodySmall),
            Text('Quantity: ${stock.quantity} · Condition: ${stock.condition}', style: theme.textTheme.bodySmall),
            if (stock.sourceOrderId != null || stock.sourceReturnId != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Text(
                      'From order: ${stock.sourceOrderId ?? "—"}  Return: ${stock.sourceReturnId ?? "—"}',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                    ),
                    if (stock.sourceOrderId != null && stock.sourceOrderId!.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => context.go('/orders?orderId=${Uri.encodeComponent(stock.sourceOrderId!)}'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text('View order', style: theme.textTheme.bodySmall),
                      ),
                    ],
                  ],
                ),
              ),
            Text(
              'Added: ${stock.createdAt.toLocal().toString().substring(0, 16)}',
              style: theme.textTheme.bodySmall,
            ),
            if (stock.restockable && stock.quantity > 0) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Tooltip(
                    message: 'Reduce quantity when you fulfill from this returned stock',
                    child: TextButton.icon(
                      onPressed: () => _showReduceDialog(context, ref, repo, stock),
                      icon: const Icon(Icons.remove_circle_outline, size: 18),
                      label: const Text('Reduce'),
                    ),
                  ),
                  Tooltip(
                    message: 'Write off this stock (cannot be restocked). Use for damaged or lost items.',
                    child: OutlinedButton.icon(
                      onPressed: () => _writeOff(context, ref, repo, stock),
                      icon: const Icon(Icons.block, size: 18),
                      label: const Text('Write off'),
                    ),
                  ),
                  InfoIcon(
                    tooltip: 'Reduce: use when you sell or use this returned item (quantity goes down). '
                        'Write off: use when the item cannot be resold (e.g. damaged); it will no longer count as available stock.',
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showReduceDialog(BuildContext context, WidgetRef ref, ReturnedStockRepository repo, ReturnedStock stock) async {
    final amountController = TextEditingController(text: '1');
    final maxQty = stock.quantity;

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reduce quantity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current quantity: $maxQty'),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount to deduct (1–$maxQty)',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final amount = int.tryParse(amountController.text.trim()) ?? 0;
              if (amount <= 0 || amount > maxQty) return;
              final navigator = Navigator.of(ctx);
              final messenger = ScaffoldMessenger.of(context);
              final ok = await repo.decrementQuantity(stock.id, amount);
              if (!context.mounted) return;
              if (ok) {
                ref.invalidate(returnedStockListProvider);
                navigator.pop();
              } else {
                messenger.showSnackBar(
                  const SnackBar(content: Text('Could not reduce quantity')),
                );
              }
            },
            child: const Text('Reduce'),
          ),
        ],
      ),
    );
    amountController.dispose();
  }

  Future<void> _writeOff(BuildContext context, WidgetRef ref, ReturnedStockRepository repo, ReturnedStock stock) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Write off'),
        content: const Text(
          'Mark this stock as not restockable? It will no longer be used for fulfillment.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Write off'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    await repo.updateRestockable(stock.id, false);
    if (!context.mounted) return;
    ref.invalidate(returnedStockListProvider);
    messenger.showSnackBar(
      const SnackBar(content: Text('Marked as not restockable')),
    );
  }
}
