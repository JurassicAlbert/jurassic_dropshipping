import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';

/// Suppliers overview: shows all registered suppliers with key details.
class SuppliersScreen extends ConsumerWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliersAsync = ref.watch(suppliersProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(suppliersProvider);
      },
      child: suppliersAsync.when(
        data: (suppliers) {
          if (suppliers.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 120),
                Center(child: Text('No suppliers registered yet.')),
              ],
            );
          }
          return ListView.builder(
            itemCount: suppliers.length,
            itemBuilder: (_, i) => _SupplierTile(supplier: suppliers[i]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorCard(
          message: 'Failed to load data. Please try again.',
          onRetry: () => ref.invalidate(suppliersProvider),
        ),
      ),
    );
  }
}

class _SupplierTile extends StatelessWidget {
  const _SupplierTile({required this.supplier});
  final Supplier supplier;

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
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
