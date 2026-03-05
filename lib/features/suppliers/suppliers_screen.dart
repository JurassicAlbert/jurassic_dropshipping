import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';

/// Suppliers overview: shows basic aggregated stats per supplier.
/// Detailed supplier analytics will be added when Supplier and SupplierOffer
/// models are introduced.
class SuppliersScreen extends ConsumerWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(listingsProvider);
      },
      child: listingsAsync.when(
        data: (listings) {
          // For now, group by sourcePlatformId as a proxy for supplier.
          final byPlatform = <String, int>{};
          for (final l in listings) {
            byPlatform.update(l.targetPlatformId, (v) => v + 1, ifAbsent: () => 1);
          }
          final entries = byPlatform.entries.toList()
            ..sort((a, b) => b.value.compareTo(a.value));
          if (entries.isEmpty) {
            return const Center(child: Text('No supplier data yet.'));
          }
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (_, i) {
              final e = entries[i];
              return ListTile(
                leading: const Icon(Icons.store),
                title: Text(e.key),
                subtitle: Text('Active listings: ${e.value}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

