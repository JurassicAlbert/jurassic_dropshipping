import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(ordersProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(ordersProvider),
      child: async.when(
        data: (orders) => orders.isEmpty
            ? const Center(child: Text('No orders yet.'))
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (_, i) {
                  final o = orders[i];
                  return ListTile(
                    title: Text(o.targetOrderId),
                    subtitle: Text('${o.status.name} · ${o.sellingPrice.toStringAsFixed(2)} PLN'),
                    trailing: Text(o.trackingNumber ?? '—'),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
