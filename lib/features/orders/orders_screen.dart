import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/search_filter_bar.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _statusFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Order> _applyFilters(List<Order> orders) {
    var filtered = orders;

    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered
          .where((o) =>
              o.targetOrderId.toLowerCase().contains(query) ||
              (o.trackingNumber?.toLowerCase().contains(query) ?? false))
          .toList();
    }

    if (_statusFilter != 'all') {
      filtered = filtered.where((o) {
        return switch (_statusFilter) {
          'pending' => o.status == OrderStatus.pending,
          'shipped' => o.status == OrderStatus.shipped,
          'failed' => o.status == OrderStatus.failed,
          _ => true,
        };
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(ordersProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(ordersProvider),
      child: ordersAsync.when(
        data: (orders) {
          final filtered = _applyFilters(orders);
          return Column(
            children: [
              SearchFilterBar(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                hintText: 'Search by order ID or tracking number...',
                filterChips: [
                  for (final entry in {'all': 'All', 'pending': 'Pending', 'shipped': 'Shipped', 'failed': 'Failed'}.entries)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(entry.value),
                        selected: _statusFilter == entry.key,
                        onSelected: (_) => setState(() => _statusFilter = entry.key),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: filtered.isEmpty
                    ? ListView(
                        children: const [
                          SizedBox(height: 120),
                          Center(child: Text('No orders match your filters.')),
                        ],
                      )
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (_, i) {
                          final o = filtered[i];
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
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorCard(
          message: 'Failed to load data. Please try again.',
          onRetry: () => ref.invalidate(ordersProvider),
        ),
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
