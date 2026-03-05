import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(ordersProvider),
      child: ordersAsync.when(
        data: (orders) => orders.isEmpty
            ? ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('No orders yet.')),
                ],
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (_, i) {
                  final o = orders[i];
                  final profit = o.sellingPrice - o.sourceCost;
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(o.targetOrderId)),
                          _statusChip(o.status),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sell: ${o.sellingPrice.toStringAsFixed(2)} · '
                            'Cost: ${o.sourceCost.toStringAsFixed(2)} · '
                            'Profit: ${profit.toStringAsFixed(2)} PLN',
                          ),
                          if (o.trackingNumber != null && o.trackingNumber!.isNotEmpty)
                            Text(
                              'Tracking: ${o.trackingNumber}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          if (o.promisedDeliveryMin != null || o.promisedDeliveryMax != null)
                            Text(
                              'Delivery: ${_formatDate(o.promisedDeliveryMin)} – ${_formatDate(o.promisedDeliveryMax)}',
                              style: const TextStyle(fontSize: 12),
                            ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '?';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  Widget _statusChip(OrderStatus status) {
    final Color color;
    switch (status) {
      case OrderStatus.pending:
        color = Colors.orange;
        break;
      case OrderStatus.pendingApproval:
        color = Colors.amber;
        break;
      case OrderStatus.sourceOrderPlaced:
        color = Colors.blue;
        break;
      case OrderStatus.shipped:
        color = Colors.teal;
        break;
      case OrderStatus.delivered:
        color = Colors.green;
        break;
      case OrderStatus.failed:
        color = Colors.red;
        break;
      case OrderStatus.cancelled:
        color = Colors.grey;
        break;
    }
    return Chip(
      label: Text(
        status.name,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
