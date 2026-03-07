import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';

class ApprovalScreen extends ConsumerWidget {
  const ApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingListings = ref.watch(pendingListingsProvider);
    final pendingOrders = ref.watch(pendingOrdersProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(pendingListingsProvider);
        ref.invalidate(pendingOrdersProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Pending listings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            pendingListings.when(
              data: (listings) => listings.isEmpty
                  ? const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No pending listings.')))
                  : Column(
                      children: listings.map((l) => _ListingApprovalTile(key: ValueKey(l.id), listing: l)).toList(),
                    ),
              loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              error: (e, _) => ErrorCard(
                message: 'Failed to load data. Please try again.',
                onRetry: () => ref.invalidate(pendingListingsProvider),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Pending orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            pendingOrders.when(
              data: (orders) => orders.isEmpty
                  ? const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No pending orders.')))
                  : Column(
                      children: orders.map((o) => _OrderApprovalTile(key: ValueKey(o.id), order: o)).toList(),
                    ),
              loading: () => const Card(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator())),
              error: (e, _) => ErrorCard(
                message: 'Failed to load data. Please try again.',
                onRetry: () => ref.invalidate(pendingOrdersProvider),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListingApprovalTile extends ConsumerWidget {
  const _ListingApprovalTile({super.key, required this.listing});
  final Listing listing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targets = ref.watch(targetsListProvider);
    final listingRepo = ref.read(listingRepositoryProvider);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(listing.id),
        subtitle: Text('${listing.sellingPrice.toStringAsFixed(2)} PLN · ${listing.sourceCost.toStringAsFixed(2)} cost'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () async {
                await listingRepo.updateStatus(listing.id, ListingStatus.draft);
                ref.invalidate(pendingListingsProvider);
                ref.invalidate(listingsProvider);
              },
              child: const Text('Reject'),
            ),
            FilledButton(
              onPressed: targets.isEmpty
                  ? null
                  : () async {
                      try {
                        final productRepo = ref.read(productRepositoryProvider);
                        final product = await productRepo.getByLocalId(listing.productId);
                        if (product == null) return;
                        final target = targets.first;
                        final draft = ListingDraft(
                          productId: listing.productId,
                          targetPlatformId: target.id,
                          title: product.title,
                          description: product.description ?? '',
                          sellingPrice: listing.sellingPrice,
                          sourceCost: listing.sourceCost,
                          imageUrls: product.imageUrls,
                          stock: product.variants.fold<int>(0, (s, v) => s + v.stock),
                        );
                        final offerId = await target.createListing(draft);
                        await listingRepo.updateStatus(listing.id, ListingStatus.active, targetListingId: offerId, publishedAt: DateTime.now());
                        ref.invalidate(pendingListingsProvider);
                        ref.invalidate(listingsProvider);
                      } catch (e) {
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
                      }
                    },
              child: const Text('Approve'),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderApprovalTile extends ConsumerWidget {
  const _OrderApprovalTile({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fulfillment = ref.read(fulfillmentServiceProvider);
    final orderRepo = ref.read(orderRepositoryProvider);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(order.targetOrderId),
        subtitle: Text('${order.sellingPrice.toStringAsFixed(2)} PLN · ${order.customerAddress.name}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () async {
                await orderRepo.updateStatus(order.id, OrderStatus.cancelled);
                ref.invalidate(pendingOrdersProvider);
                ref.invalidate(ordersProvider);
              },
              child: const Text('Reject'),
            ),
            FilledButton(
              onPressed: () async {
                try {
                  await fulfillment.fulfillOrder(order);
                  ref.invalidate(pendingOrdersProvider);
                  ref.invalidate(ordersProvider);
                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed.')));
                } catch (e) {
                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
                }
              },
              child: const Text('Approve & Fulfill'),
            ),
          ],
        ),
      ),
    );
  }
}
