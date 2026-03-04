import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(listingsProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(listingsProvider),
      child: async.when(
        data: (listings) => listings.isEmpty
            ? const Center(child: Text('No listings yet. Run a scan from Dashboard.'))
            : ListView.builder(
                itemCount: listings.length,
                itemBuilder: (_, i) {
                  final l = listings[i];
                  return ListTile(
                    title: Text(l.id),
                    subtitle: Text('${l.status.name} · ${l.sellingPrice.toStringAsFixed(2)} PLN'),
                    trailing: Chip(label: Text(l.status.name)),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
