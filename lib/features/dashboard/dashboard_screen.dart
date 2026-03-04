import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    final ordersAsync = ref.watch(ordersProvider);
    final rulesAsync = ref.watch(rulesProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(listingsProvider);
        ref.invalidate(ordersProvider);
        ref.invalidate(rulesProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            listingsAsync.when(
              data: (listings) {
                final active = listings.where((l) => l.status.name == 'active').length;
                final pending = listings.where((l) => l.status.name == 'pendingApproval').length;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Listings', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text('Active: $active'),
                        Text('Pending approval: $pending'),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              error: (e, _) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Text('Error: $e'))),
            ),
            const SizedBox(height: 12),
            ordersAsync.when(
              data: (orders) {
                final pending = orders.where((o) => o.status.name == 'pending' || o.status.name == 'pendingApproval').length;
                final totalSales = orders.fold<double>(0, (s, o) => s + o.sellingPrice);
                final totalCost = orders.fold<double>(0, (s, o) => s + o.sourceCost);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Orders', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text('Pending: $pending'),
                        Text('Total sales: ${totalSales.toStringAsFixed(2)} PLN'),
                        Text('Total cost: ${totalCost.toStringAsFixed(2)} PLN'),
                        Text('Est. profit: ${(totalSales - totalCost).toStringAsFixed(2)} PLN'),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              error: (e, _) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Text('Error: $e'))),
            ),
            const SizedBox(height: 16),
            rulesAsync.when(
              data: (rules) => Card(
                child: ListTile(
                  title: const Text('Run scan'),
                  subtitle: Text('Keywords: ${rules.searchKeywords.join(", ").isEmpty ? "none" : rules.searchKeywords.join(", ")}'),
                  trailing: FilledButton(
                    onPressed: () async {
                      final scanner = ref.read(scannerProvider);
                      await scanner.run();
                      ref.invalidate(listingsProvider);
                    },
                    child: const Text('Scan'),
                  ),
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
