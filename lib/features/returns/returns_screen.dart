import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';

class ReturnsScreen extends ConsumerWidget {
  const ReturnsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final returnsAsync = ref.watch(returnRequestsProvider);

    return returnsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorCard(
        message: 'Failed to load data. Please try again.',
        onRetry: () => ref.invalidate(returnRequestsProvider),
      ),
      data: (returns) {
        if (returns.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.assignment_return, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No return requests yet.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Return requests from customers will appear here.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: returns.length,
          itemBuilder: (context, index) {
            final r = returns[index];
            return _ReturnCard(returnRequest: r);
          },
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
