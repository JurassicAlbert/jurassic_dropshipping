import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';

/// Marketplaces overview: shows basic stats per target platform.
class MarketplacesScreen extends ConsumerWidget {
  const MarketplacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(ordersProvider);
      },
      child: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return const Center(child: Text('No marketplace activity yet.'));
          }
          final byPlatform = <String, _MarketplaceStats>{};
          for (final o in orders) {
            byPlatform.update(
              o.targetPlatformId,
              (s) => s.add(o.sellingPrice, o.sourceCost),
              ifAbsent: () => _MarketplaceStats.fromOrder(o.sellingPrice, o.sourceCost),
            );
          }
          final entries = byPlatform.entries.toList()
            ..sort((a, b) => b.value.profit.compareTo(a.value.profit));
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (_, i) {
              final e = entries[i];
              final stats = e.value;
              return ListTile(
                leading: const Icon(Icons.public),
                title: Text(e.key),
                subtitle: Text(
                  'Orders: ${stats.count} · Profit: ${stats.profit.toStringAsFixed(2)} PLN',
                ),
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

class _MarketplaceStats {
  _MarketplaceStats({required this.count, required this.revenue, required this.cost});

  final int count;
  final double revenue;
  final double cost;

  double get profit => revenue - cost;

  _MarketplaceStats add(double sellingPrice, double sourceCost) {
    return _MarketplaceStats(
      count: count + 1,
      revenue: revenue + sellingPrice,
      cost: cost + sourceCost,
    );
  }

  factory _MarketplaceStats.fromOrder(double sellingPrice, double sourceCost) {
    return _MarketplaceStats(count: 1, revenue: sellingPrice, cost: sourceCost);
  }
}

