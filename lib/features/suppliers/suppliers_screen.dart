import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/domain/supplier_reliability/supplier_reliability_score.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await ref.read(supplierReliabilityScoringServiceProvider).evaluateAll();
                    ref.invalidate(supplierReliabilityScoresProvider);
                  },
                  icon: const Icon(Icons.analytics_outlined, size: 18),
                  label: const Text('Refresh reliability scores'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: suppliers.length,
                  itemBuilder: (_, i) => _SupplierTile(
                    supplier: suppliers[i],
                    score: scoreMap[suppliers[i].id],
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
  const _SupplierTile({required this.supplier, this.score});
  final Supplier supplier;
  final SupplierReliabilityScore? score;

  @override
  Widget build(BuildContext context) {
    final ratingStr = supplier.rating != null
        ? supplier.rating!.toStringAsFixed(1)
        : '—';
    final country = supplier.countryCode ?? '—';
    final returnWindow = supplier.returnWindowDays != null
        ? '${supplier.returnWindowDays}d'
        : '—';
    final acceptsNoReason = supplier.acceptsNoReasonReturns;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            supplier.platformType.substring(0, supplier.platformType.length.clamp(0, 2)).toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(supplier.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${supplier.platformType} · $country'),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 2),
                Text(ratingStr, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                const Icon(Icons.refresh, size: 14),
                const SizedBox(width: 2),
                Text('Return: $returnWindow', style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                Icon(
                  acceptsNoReason ? Icons.check_circle : Icons.cancel,
                  size: 14,
                  color: acceptsNoReason ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 2),
                Text(
                  acceptsNoReason ? 'No-reason' : 'No no-reason',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            if (score != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Reliability: ${score!.score.toStringAsFixed(0)}/100',
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
