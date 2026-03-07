import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(listingsProvider),
      child: listingsAsync.when(
        data: (listings) => listings.isEmpty
            ? ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('No listings yet. Run a scan from Dashboard.')),
                ],
              )
            : ListView.builder(
                itemCount: listings.length,
                itemBuilder: (_, i) {
                  final l = listings[i];
                  final profit = l.sellingPrice - l.sourceCost;
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                      title: Text(l.id),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sell: ${l.sellingPrice.toStringAsFixed(2)} · '
                            'Cost: ${l.sourceCost.toStringAsFixed(2)} · '
                            'Profit: ${profit.toStringAsFixed(2)} PLN',
                          ),
                          if (l.promisedMinDays != null || l.promisedMaxDays != null)
                            Text(
                              'Delivery: ${l.promisedMinDays ?? "?"}–${l.promisedMaxDays ?? "?"}d',
                              style: const TextStyle(fontSize: 12),
                            ),
                        ],
                      ),
                      trailing: _statusChip(l.status),
                      isThreeLine: l.promisedMinDays != null || l.promisedMaxDays != null,
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorCard(
          message: 'Failed to load data. Please try again.',
          onRetry: () => ref.invalidate(listingsProvider),
        ),
      ),
    );
  }

  Widget _statusChip(ListingStatus status) {
    final Color color;
    switch (status) {
      case ListingStatus.active:
        color = Colors.green;
        break;
      case ListingStatus.pendingApproval:
        color = Colors.orange;
        break;
      case ListingStatus.draft:
        color = Colors.grey;
        break;
      case ListingStatus.soldOut:
        color = Colors.red;
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
