import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/domain/post_order/return_routing.dart';
import 'package:jurassic_dropshipping/domain/post_order/returned_stock.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/info_icon.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/search_filter_bar.dart';

class ReturnsScreen extends ConsumerStatefulWidget {
  const ReturnsScreen({super.key});

  @override
  ConsumerState<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends ConsumerState<ReturnsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _statusFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ReturnRequest> _applyFilters(List<ReturnRequest> returns) {
    var filtered = returns;

    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered
          .where((r) => r.orderId.toLowerCase().contains(query))
          .toList();
    }

    if (_statusFilter != 'all') {
      filtered = filtered.where((r) {
        return switch (_statusFilter) {
          'requested' => r.status == ReturnStatus.requested,
          'approved' => r.status == ReturnStatus.approved,
          'refunded' => r.status == ReturnStatus.refunded,
          _ => true,
        };
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final returnsAsync = ref.watch(returnRequestsProvider);

    return returnsAsync.when(
      loading: () => const LoadingSkeleton(),
      error: (e, _) => ErrorCard(
        message: 'Failed to load data. Please try again.',
        onRetry: () => ref.invalidate(returnRequestsProvider),
      ),
      data: (returns) {
        final filtered = _applyFilters(returns);
        return Column(
          children: [
            const ScreenHelpSection(
              description: ScreenHelpTexts.returns,
              howToUse: 'How to use: Tap a return to edit. Update status, refund amount and routing. Use "Compute routing" in the edit dialog to determine where the return goes.',
            ),
            SearchFilterBar(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              hintText: 'Search by order ID...',
              filterChips: [
                for (final entry in {'all': 'All', 'requested': 'Requested', 'approved': 'Approved', 'refunded': 'Refunded'}.entries)
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
                  ? const EmptyState(
                      icon: Icons.assignment_return,
                      title: 'No returns',
                      subtitle: 'Returns from customers will appear here',
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.sm,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final r = filtered[index];
                        return InkWell(
                          onTap: () => _showEditDialog(context, r),
                          child: _ReturnCard(returnRequest: r),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showEditDialog(BuildContext context, ReturnRequest request) async {
    final repo = ref.read(returnRepositoryProvider);
    final orderRepo = ref.read(orderRepositoryProvider);
    final listingRepo = ref.read(listingRepositoryProvider);
    final productRepo = ref.read(productRepositoryProvider);
    final supplierRepo = ref.read(supplierRepositoryProvider);
    final policyRepo = ref.read(supplierReturnPolicyRepositoryProvider);
    final routingService = ref.read(returnRoutingServiceProvider);
    final notesController = TextEditingController(text: request.notes ?? '');
    final refundController = TextEditingController(
      text: request.refundAmount != null ? request.refundAmount!.toStringAsFixed(2) : '',
    );
    final shippingController = TextEditingController(
      text: request.returnShippingCost != null ? request.returnShippingCost!.toStringAsFixed(2) : '',
    );
    final restockingController = TextEditingController(
      text: request.restockingFee != null ? request.restockingFee!.toStringAsFixed(2) : '',
    );
    ReturnStatus status = request.status;
    ReturnRoutingDestination? dialogRouting = request.returnRoutingDestination;
    bool addToReturnedStock = false;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: Text('Edit return ${request.id}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<ReturnStatus>(
                      isExpanded: true,
                      value: status,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => status = value);
                        }
                      },
                      items: ReturnStatus.values
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.name),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: refundController,
                      decoration: const InputDecoration(
                        labelText: 'Refund amount',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: shippingController,
                      decoration: const InputDecoration(
                        labelText: 'Return shipping cost',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: restockingController,
                      decoration: const InputDecoration(
                        labelText: 'Restocking fee',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: notesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    if (dialogRouting != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Routing: ${_routingLabel(dialogRouting!)}',
                        style: Theme.of(ctx).textTheme.bodyMedium,
                      ),
                    ],
                    if (status == ReturnStatus.received) ...[
                      const SizedBox(height: 12),
                      CheckboxListTile(
                        value: addToReturnedStock,
                        onChanged: (v) => setState(() => addToReturnedStock = v ?? false),
                        title: const Text('Add to returned stock'),
                        subtitle: const Text('Create returned-stock entry for this return (1 unit)'),
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(ctx);
                        final order = await orderRepo.getByLocalId(request.orderId);
                        if (order == null) {
                          if (!ctx.mounted) return;
                          messenger.showSnackBar(
                            const SnackBar(content: Text('Order not found')),
                          );
                          return;
                        }
                        final listing = await listingRepo.getByLocalId(order.listingId) ??
                            await listingRepo.getByTargetListingId(order.targetPlatformId, order.listingId);
                        if (listing == null) {
                          if (!ctx.mounted) return;
                          messenger.showSnackBar(
                            const SnackBar(content: Text('Listing not found')),
                          );
                          return;
                        }
                        final product = await productRepo.getByLocalId(listing.productId);
                        final supplier = product?.supplierId != null
                            ? await supplierRepo.getById(product!.supplierId!)
                            : null;
                        final policy = product?.supplierId != null
                            ? await policyRepo.getBySupplierId(product!.supplierId!)
                            : null;
                        final dest = routingService.routeReturn(
                          request,
                          supplier: supplier,
                          policy: policy,
                        );
                        setState(() => dialogRouting = dest);
                      },
                      icon: const Icon(Icons.route, size: 18),
                      label: const Text('Compute routing'),
                    ),
                    const SizedBox(width: 6),
                    InfoIcon(
                      tooltip: 'Uses return policies and supplier data to suggest where this return should go: '
                          'seller address, supplier warehouse, return center, or disposal.',
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
                    final navigator = Navigator.of(context);
                    final messenger = ScaffoldMessenger.of(context);
                    final refund = double.tryParse(refundController.text.trim());
                    final shipping = double.tryParse(shippingController.text.trim());
                    final restocking = double.tryParse(restockingController.text.trim());
                    final updated = request.copyWith(
                      status: status,
                      notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
                      refundAmount: refund,
                      returnShippingCost: shipping,
                      restockingFee: restocking,
                      returnRoutingDestination: dialogRouting ?? request.returnRoutingDestination,
                      resolvedAt: status == ReturnStatus.refunded || status == ReturnStatus.rejected
                          ? (request.resolvedAt ?? DateTime.now())
                          : request.resolvedAt,
                    );
                    if (status == ReturnStatus.received && addToReturnedStock) {
                      final orderRepo = ref.read(orderRepositoryProvider);
                      final listingRepo = ref.read(listingRepositoryProvider);
                      final productRepo = ref.read(productRepositoryProvider);
                      final returnedStockRepo = ref.read(returnedStockRepositoryProvider);
                      final order = await orderRepo.getByLocalId(request.orderId);
                      if (order != null) {
                        final listing = await listingRepo.getByLocalId(order.listingId) ??
                            await listingRepo.getByTargetListingId(order.targetPlatformId, order.listingId);
                        if (listing != null) {
                          final product = await productRepo.getByLocalId(listing.productId);
                          final supplierId = product?.supplierId ?? request.supplierId ?? '';
                          if (supplierId.isNotEmpty) {
                            await returnedStockRepo.insert(ReturnedStock(
                              id: 0,
                              productId: listing.productId,
                              supplierId: supplierId,
                              quantity: 1,
                              sourceOrderId: order.id,
                              sourceReturnId: request.id,
                              createdAt: DateTime.now(),
                            ));
                            if (mounted) {
                              messenger.showSnackBar(
                                const SnackBar(content: Text('Return marked received and added to returned stock')),
                              );
                            }
                          }
                        }
                      }
                    }
                    await repo.update(updated);
                    if (!mounted) return;
                    ref.invalidate(returnRequestsProvider);
                    ref.invalidate(returnedStockListProvider);
                    navigator.pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    notesController.dispose();
    refundController.dispose();
    shippingController.dispose();
    restockingController.dispose();
  }

  static String _routingLabel(ReturnRoutingDestination d) {
    return switch (d) {
      ReturnRoutingDestination.sellerAddress => 'Seller address',
      ReturnRoutingDestination.supplierWarehouse => 'Supplier warehouse',
      ReturnRoutingDestination.returnCenter => 'Return center',
      ReturnRoutingDestination.disposal => 'Disposal',
    };
  }
}

class _ReturnCard extends StatelessWidget {
  const _ReturnCard({required this.returnRequest});
  final ReturnRequest returnRequest;

  Color _statusColor(ReturnStatus status) {
    return switch (status) {
      ReturnStatus.requested => Colors.orange,
      ReturnStatus.approved => Colors.blue,
      ReturnStatus.shipped => Colors.indigo,
      ReturnStatus.received => Colors.teal,
      ReturnStatus.refunded => Colors.green,
      ReturnStatus.rejected => Colors.red,
    };
  }

  String _reasonLabel(ReturnReason reason) {
    return switch (reason) {
      ReturnReason.noReason => 'No reason',
      ReturnReason.defective => 'Defective',
      ReturnReason.wrongItem => 'Wrong item',
      ReturnReason.damagedInTransit => 'Damaged in transit',
      ReturnReason.other => 'Other',
    };
  }

  @override
  Widget build(BuildContext context) {
    final r = returnRequest;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Return ${r.id}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Chip(
                  label: Text(
                    r.status.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  backgroundColor: _statusColor(r.status),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Order: ${r.orderId}'),
            if (r.reason == ReturnReason.noReason && (r.notes == null || r.notes!.isEmpty))
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  'Buyer sent parcel back (no reason or message provided)',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            Text('Reason: ${_reasonLabel(r.reason)}${r.reason == ReturnReason.noReason ? ' (parcel return only)' : ''}'),
            if (r.returnTrackingNumber != null && r.returnTrackingNumber!.isNotEmpty)
              Text(
                'Return tracking: ${r.returnTrackingNumber}${r.returnCarrier != null && r.returnCarrier!.isNotEmpty ? ' (${r.returnCarrier})' : ''}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            if (r.returnDestination != null)
              Text(
                'Return to: ${r.returnDestination == ReturnDestination.toSeller ? "Seller (you)" : "Supplier"}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            if (r.returnRoutingDestination != null)
              Text(
                'Destination: ${switch (r.returnRoutingDestination!) {
                  ReturnRoutingDestination.sellerAddress => 'Seller',
                  ReturnRoutingDestination.supplierWarehouse => 'Supplier',
                  ReturnRoutingDestination.returnCenter => 'Return center',
                  ReturnRoutingDestination.disposal => 'Disposal',
                }}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            if (r.status == ReturnStatus.received)
              Text(
                'Restock: eligible (add in edit dialog)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
            if (r.refundAmount != null)
              Text('Refund: \$${r.refundAmount!.toStringAsFixed(2)}'),
            if (r.returnShippingCost != null)
              Text(
                  'Return shipping: \$${r.returnShippingCost!.toStringAsFixed(2)}'),
            if (r.restockingFee != null)
              Text(
                  'Restocking fee: \$${r.restockingFee!.toStringAsFixed(2)}'),
            if (r.notes != null && r.notes!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('Notes: ${r.notes}',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ),
            if (r.requestedAt != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Requested: ${r.requestedAt!.toLocal().toString().substring(0, 16)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            if (r.resolvedAt != null)
              Text(
                'Resolved: ${r.resolvedAt!.toLocal().toString().substring(0, 16)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton.icon(
                onPressed: () => context.go('/incidents?orderId=${Uri.encodeComponent(r.orderId)}'),
                icon: const Icon(Icons.warning_amber, size: 18),
                label: const Text('View incidents for this order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
