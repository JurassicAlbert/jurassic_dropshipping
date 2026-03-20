import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/domain/supplier_reliability/supplier_reliability_score.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/info_icon.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';

/// Suppliers overview: shows all registered suppliers with key details.
class SuppliersScreen extends ConsumerWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliersAsync = ref.watch(suppliersProvider);
    final scoresAsync = ref.watch(supplierReliabilityScoresProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(suppliersProvider);
        ref.invalidate(supplierReliabilityScoresProvider);
      },
      child: suppliersAsync.when(
        data: (suppliers) {
          if (suppliers.isEmpty) {
            return const EmptyState(
              icon: Icons.store,
              title: 'No suppliers',
              subtitle: 'Load demo data from Settings to see suppliers',
            );
          }
          final scoreMap = scoresAsync.valueOrNull != null
              ? {for (final s in scoresAsync.valueOrNull!) s.supplierId: s}
              : <String, SupplierReliabilityScore>{};
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, 0),
                child: ScreenHelpSection(
                  description: ScreenHelpTexts.suppliers,
                  howToUse: 'How to use: Tap "Refresh reliability scores" to re-evaluate all suppliers. Tap a supplier to see details.',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Re-evaluate reliability for all suppliers (orders, cancellations, late shipments).',
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await ref.read(supplierReliabilityScoringServiceProvider).evaluateAll();
                          ref.invalidate(supplierReliabilityScoresProvider);
                        },
                        icon: const Icon(Icons.analytics_outlined, size: 18),
                        label: const Text('Refresh reliability scores'),
                      ),
                    ),
                    InfoIcon(
                      tooltip: 'Recalculates a reliability score for each supplier based on order history, '
                          'cancellations and late shipments. Tap a supplier row to see the score and details.',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  itemCount: suppliers.length,
                  itemBuilder: (_, i) => _SupplierTile(
                    supplier: suppliers[i],
                    score: scoreMap[suppliers[i].id],
                    onTap: () => context.go('/suppliers/${Uri.encodeComponent(suppliers[i].id)}'),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const LoadingSkeleton(),
        error: (e, _) => ErrorCard(
          message: 'Failed to load data. Please try again.',
          onRetry: () => ref.invalidate(suppliersProvider),
        ),
      ),
    );
  }
}

class _SupplierTile extends StatelessWidget {
  const _SupplierTile({required this.supplier, this.score, this.onTap});
  final Supplier supplier;
  final SupplierReliabilityScore? score;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratingStr = supplier.rating != null
        ? supplier.rating!.toStringAsFixed(1)
        : '—';
    final country = supplier.countryCode ?? '—';
    final returnWindow = supplier.returnWindowDays != null
        ? '${supplier.returnWindowDays}d'
        : '—';
    final acceptsNoReason = supplier.acceptsNoReasonReturns;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            supplier.platformType.substring(0, supplier.platformType.length.clamp(0, 2)).toUpperCase(),
            style: TextStyle(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(supplier.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${supplier.platformType} · $country'),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(ratingStr, style: theme.textTheme.bodySmall),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.policy, size: 14, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text('Return: $returnWindow', style: theme.textTheme.bodySmall),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      acceptsNoReason ? Icons.check_circle : Icons.cancel,
                      size: 14,
                      color: acceptsNoReason ? Colors.green : theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      acceptsNoReason ? 'No-reason' : 'No no-reason',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            if (score != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Reliability: ${score!.score.toStringAsFixed(0)}/100',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.tertiary),
                ),
              ),
          ],
        ),
        isThreeLine: true,
      ),
      ),
    );
  }
}
