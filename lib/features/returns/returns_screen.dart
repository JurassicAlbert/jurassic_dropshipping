import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
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
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final r = filtered[index];
                        return _ReturnCard(returnRequest: r);
                      },
                    ),
            ),
          ],
        );
      },
    );
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
            Text('Reason: ${_reasonLabel(r.reason)}'),
            if (r.returnDestination != null)
              Text(
                'Return to: ${r.returnDestination == ReturnDestination.toSeller ? "Seller (you)" : "Supplier"}',
                style: Theme.of(context).textTheme.bodyMedium,
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
          ],
        ),
      ),
    );
  }
}
