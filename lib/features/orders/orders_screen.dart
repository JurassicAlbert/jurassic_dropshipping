import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/domain/post_order/post_order_lifecycle_engine.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/marketplace_names.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/info_icon.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/search_filter_bar.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key, this.highlightOrderId, this.initialQueuedForCapitalFilter});

  final String? highlightOrderId;
  /// When true, "Queued for capital" filter is selected on load (e.g. from Capital screen).
  final bool? initialQueuedForCapitalFilter;

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _statusFilter = 'all';
  bool _queuedForCapitalOnly = false;

  @override
  void initState() {
    super.initState();
    if (widget.highlightOrderId != null && widget.highlightOrderId!.isNotEmpty) {
      _searchController.text = widget.highlightOrderId!;
    }
    if (widget.initialQueuedForCapitalFilter == true) {
      _queuedForCapitalOnly = true;
    }
  }

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
          'failed' => o.status == OrderStatus.failed || o.status == OrderStatus.failedOutOfStock,
          _ => true,
        };
      }).toList();
    }

    if (_queuedForCapitalOnly) {
      filtered = filtered.where((o) => o.queuedForCapital).toList();
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
          final inventoryKey = filtered.isEmpty ? '' : filtered.take(30).map((o) => o.id).join(',');
          final inventoryMapAsync = ref.watch(orderInventoryMapProvider(inventoryKey));
          return Column(
            children: [
              const ScreenHelpSection(
              description: ScreenHelpTexts.orders,
              howToUse: 'How to use: Search by order ID or tracking. Use "Backfill lifecycle" to sync state from marketplace. Tap an order to see details.',
            ),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: const Text('Queued for capital'),
                      selected: _queuedForCapitalOnly,
                      onSelected: (_) => setState(() => _queuedForCapitalOnly = !_queuedForCapitalOnly),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: filtered.isEmpty ? null : () => _runBackfillLifecycle(context),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Backfill lifecycle'),
                    ),
                    const SizedBox(width: 4),
                    InfoIcon(
                      tooltip: 'Sync order status from the marketplace (e.g. Shipped, Delivered, Cancelled). '
                          'Use this when you want the app to match what the marketplace shows.',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const EmptyState(
                        icon: Icons.shopping_cart,
                        title: 'No orders yet',
                        subtitle: 'Orders will appear here when customers buy your listings',
                      )
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (_, i) {
                          final o = filtered[i];
                          final profit = o.sellingPrice - o.sourceCost;
                          final snap = inventoryMapAsync.valueOrNull?[o.id];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(child: Text(o.targetOrderId)),
                                  IconButton(
                                    icon: const Icon(Icons.copy, size: 18),
                                    tooltip: 'Copy order ID',
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: o.targetOrderId));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Order ID copied')),
                                      );
                                    },
                                  ),
                                  _statusChip(o.status),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${marketplaceDisplayName(o.targetPlatformId)} · '
                                    'Sell: ${o.sellingPrice.toStringAsFixed(2)} · '
                                    'Cost: ${o.sourceCost.toStringAsFixed(2)} · '
                                    'Profit: ${profit.toStringAsFixed(2)} PLN',
                                  ),
                                  if (o.lifecycleState != null && o.lifecycleState!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        'Lifecycle: ${_lifecycleLabel(o.lifecycleState!)}',
                                        style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  if (o.queuedForCapital)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Chip(
                                        label: const Text('Capital locked: YES'),
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    ),
                                  if (snap != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        'Available to sell: ${snap.availableToSell}'
                                        '${snap.supplierStockUnknown || snap.marketplaceStockUnknown ? ' (partial)' : ''}',
                                        style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.tertiary),
                                      ),
                                    ),
                                  if (o.riskScore != null)
                                    Text(
                                      'Risk: ${o.riskScore!.toStringAsFixed(0)}${o.riskFactorsJson != null && o.riskFactorsJson!.trim().isNotEmpty && o.riskFactorsJson != '[]' ? ' (${o.riskFactorsJson!.replaceAll('"', '').replaceAll('[', '').replaceAll(']', '')})' : ''}',
                                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.tertiary),
                                    ),
                                  if (o.financialState != null && o.financialState!.isNotEmpty)
                                    Text(
                                      'Financial: ${o.financialState!.replaceAll('_', ' ')}',
                                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  TextButton.icon(
                                    onPressed: () => _showSetLifecycleDialog(context, o),
                                    icon: const Icon(Icons.loop, size: 14),
                                    label: Text(
                                      o.lifecycleState != null && o.lifecycleState!.isNotEmpty
                                          ? 'Change lifecycle'
                                          : 'Set lifecycle',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 0),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
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
                                  if (o.deliveryMethodName != null && o.deliveryMethodName!.isNotEmpty)
                                    Text(
                                      'Delivery method: ${o.deliveryMethodName}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  if (o.buyerMessage != null && o.buyerMessage!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        'Buyer message: ${o.buyerMessage}',
                                        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.primary),
                                      ),
                                    ),
                                  if ((o.status == OrderStatus.failed || o.status == OrderStatus.failedOutOfStock) &&
                                      o.decisionLogId != null)
                                    TextButton.icon(
                                      onPressed: () => _showFailureReason(context, o),
                                      icon: const Icon(Icons.info_outline, size: 16),
                                      label: const Text(
                                        'View failure reason',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(0, 0),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                  TextButton.icon(
                                    onPressed: () => _showCreateReturnDialog(context, o),
                                    icon: const Icon(Icons.assignment_return, size: 16),
                                    label: const Text(
                                      'Create return / complaint',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 0),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => context.go('/incidents?orderId=${Uri.encodeComponent(o.id)}'),
                                    icon: const Icon(Icons.warning_amber_outlined, size: 14),
                                    label: const Text('View incidents', style: TextStyle(fontSize: 12)),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 0),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
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
        loading: () => const LoadingSkeleton(),
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

  static String _lifecycleLabel(String state) {
    const labels = {
      'created': 'Created',
      'pendingApproval': 'Pending approval',
      'approved': 'Approved',
      'sentToSupplier': 'Sent to supplier',
      'shipped': 'Shipped',
      'delivered': 'Delivered',
      'returnRequested': 'Return requested',
      'returnApproved': 'Return approved',
      'returned': 'Returned',
      'complaintOpened': 'Incident opened',
      'refunded': 'Refunded',
      'failed': 'Failed',
      'cancelled': 'Cancelled',
    };
    return labels[state] ?? state;
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
      case OrderStatus.failedOutOfStock:
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

  Future<void> _showSetLifecycleDialog(BuildContext context, Order order) async {
    final engine = ref.read(postOrderLifecycleEngineProvider);
    var selected = PostOrderLifecycleEngine.currentState(order) ?? OrderLifecycleState.created;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: const Text('Set lifecycle'),
              content: DropdownButtonFormField<OrderLifecycleState>(
                value: selected,
                decoration: const InputDecoration(
                  labelText: 'Lifecycle state',
                  border: OutlineInputBorder(),
                ),
                items: OrderLifecycleState.values
                    .map((s) => DropdownMenuItem(value: s, child: Text(s.name)))
                    .toList(),
                onChanged: (v) => setState(() => selected = v ?? selected),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
                FilledButton(
                  onPressed: () async {
                    final navigator = Navigator.of(ctx);
                    final messenger = ScaffoldMessenger.of(context);
                    final ok = await engine.transition(order, selected);
                    if (!mounted) return;
                    ref.invalidate(ordersProvider);
                    navigator.pop();
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(ok ? 'Lifecycle set to ${selected.name}' : 'Transition not allowed'),
                      ),
                    );
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _runBackfillLifecycle(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final orderRepo = ref.read(orderRepositoryProvider);
    final returnRepo = ref.read(returnRepositoryProvider);
    final engine = ref.read(postOrderLifecycleEngineProvider);
    final orders = await orderRepo.getAll();
    final allReturns = await returnRepo.getAll();
    final returnsByOrder = <String, List<ReturnRequest>>{};
    for (final r in allReturns) {
      returnsByOrder.putIfAbsent(r.orderId, () => []).add(r);
    }
    var updated = 0;
    for (final order in orders) {
      if (order.lifecycleState == null || order.lifecycleState!.isEmpty) {
        final list = returnsByOrder[order.id] ?? [];
        final ok = await engine.backfillIfNeeded(order, list);
        if (ok) updated++;
      }
    }
    if (!mounted) return;
    ref.invalidate(ordersProvider);
    messenger.showSnackBar(
      SnackBar(content: Text(updated > 0 ? 'Lifecycle backfilled for $updated order(s)' : 'No orders needed backfill')),
    );
  }

  Future<void> _showFailureReason(BuildContext context, Order order) async {
    final logId = order.decisionLogId;
    if (logId == null) {
      return;
    }
    final repo = ref.read(decisionLogRepositoryProvider);
    final log = await repo.getByLocalId(logId);
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Failure reason'),
          content: Text(log?.reason ?? 'No diagnostic details available for this order.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCreateReturnDialog(BuildContext context, Order order) async {
    final notesController = TextEditingController();
    final refundController = TextEditingController();
    ReturnReason selectedReason = ReturnReason.other;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: const Text('Create return / complaint'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Reason'),
                    const SizedBox(height: 4),
                    DropdownButton<ReturnReason>(
                      isExpanded: true,
                      value: selectedReason,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedReason = value);
                        }
                      },
                      items: ReturnReason.values
                          .map(
                            (r) => DropdownMenuItem(
                              value: r,
                              child: Text(r.name),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: refundController,
                      decoration: const InputDecoration(
                        labelText: 'Planned refund amount (optional)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: notesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes (what customer said / agreed)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    final repo = ref.read(returnRepositoryProvider);
                    final now = DateTime.now();
                    final id = 'ret_${order.id}_${now.millisecondsSinceEpoch}';
                    final refundText = refundController.text.trim();
                    final refund = double.tryParse(refundText.isEmpty ? '0' : refundText);
                    final req = ReturnRequest(
                      id: id,
                      orderId: order.id,
                      reason: selectedReason,
                      status: ReturnStatus.requested,
                      notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
                      refundAmount: refund != null && refund > 0 ? refund : null,
                      requestedAt: now,
                      targetPlatformId: order.targetPlatformId,
                      sourcePlatformId: null,
                      returnDestination: ReturnDestination.toSupplier,
                    );
                    await repo.insert(req);
                    if (!mounted) return;
                    ref.invalidate(returnRequestsProvider);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );

    notesController.dispose();
    refundController.dispose();
  }
}
