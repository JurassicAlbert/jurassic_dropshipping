import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';

/// Known marketplace display names.
const _marketplaceNames = <String, String>{
  'allegro': 'Allegro',
  'temu': 'Temu',
  'amazon': 'Amazon',
};

/// Marketplaces overview: shows stats per target platform and connection status.
class MarketplacesScreen extends ConsumerWidget {
  const MarketplacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);
    final targets = ref.watch(targetsListProvider);
    final registeredIds = targets.map((t) => t.id).toSet();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(ordersProvider);
      },
      child: ordersAsync.when(
        data: (orders) {
          final byPlatform = <String, _MarketplaceStats>{};
          for (final o in orders) {
            byPlatform.update(
              o.targetPlatformId,
              (s) => s.add(o.sellingPrice, o.sourceCost),
              ifAbsent: () => _MarketplaceStats.fromOrder(o.sellingPrice, o.sourceCost),
            );
          }

          final allIds = {...byPlatform.keys, ...registeredIds};
          final sortedIds = allIds.toList()..sort();

          if (sortedIds.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 120),
                Center(child: Text('No marketplace activity yet.')),
              ],
            );
          }

          return ListView.builder(
            itemCount: sortedIds.length,
            itemBuilder: (_, i) {
              final platformId = sortedIds[i];
              final stats = byPlatform[platformId];
              final isConnected = registeredIds.contains(platformId);
              final displayName = _marketplaceNames[platformId] ?? platformId;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ListTile(
                  leading: const Icon(Icons.public),
                  title: Row(
                    children: [
                      Text(displayName),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isConnected ? Colors.green.shade100 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isConnected ? 'Connected' : 'Not connected',
                          style: TextStyle(
                            fontSize: 11,
                            color: isConnected ? Colors.green.shade800 : Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: stats != null
                      ? Text(
                          'Orders: ${stats.count} · Revenue: ${stats.revenue.toStringAsFixed(2)} PLN · Profit: ${stats.profit.toStringAsFixed(2)} PLN',
                        )
                      : const Text('No orders yet'),
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
