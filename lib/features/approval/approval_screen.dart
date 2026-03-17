import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/section_header.dart';

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
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionHeader(
              title: 'Approval Queue',
              icon: Icons.pending_actions,
              infoTooltip: 'Items waiting for your decision. Listings: Approve to publish on the marketplace, Reject to cancel or set back to draft. '
                  'Orders: Approve to send the order to the supplier, Reject to cancel on the marketplace.',
            ),
            const ScreenHelpSection(
            description: ScreenHelpTexts.approval,
            howToUse: 'How to use: Approve to publish a listing or place an order with the supplier. Reject to cancel or set back to draft.',
          ),
            const SizedBox(height: AppSpacing.sectionGap),
            const SectionHeader(title: 'Pending listings', icon: Icons.inventory_2),
            const SizedBox(height: AppSpacing.sm),
            pendingListings.when(
              data: (listings) => listings.isEmpty
                  ? const EmptyState(
                      icon: Icons.pending_actions,
                      title: 'Nothing pending',
                      subtitle: 'Listings and orders awaiting approval will appear here',
                    )
                  : Column(
                      children: listings.map((l) => _ListingApprovalTile(key: ValueKey(l.id), listing: l)).toList(),
                    ),
              loading: () => const SizedBox(height: 120, child: LoadingSkeleton(count: 2)),
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
                  ? const EmptyState(
                      icon: Icons.pending_actions,
                      title: 'Nothing pending',
                      subtitle: 'Listings and orders awaiting approval will appear here',
                    )
                  : Column(
                      children: orders.map((o) => _OrderApprovalTile(key: ValueKey(o.id), order: o)).toList(),
                    ),
              loading: () => const SizedBox(height: 120, child: LoadingSkeleton(count: 2)),
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
    final listingRepo = ref.read(listingRepositoryProvider);
    final targets = ref.watch(targetsListProvider);
    final stockAsync = ref.watch(listingStockAtSourceProvider(listing.id));
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(listing.id),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${listing.sellingPrice.toStringAsFixed(2)} PLN · ${listing.sourceCost.toStringAsFixed(2)} cost'),
            stockAsync.when(
              data: (stock) => stock != null
                  ? Text(
                      stock == 0 ? 'Out of stock at supplier' : 'Stock at supplier: $stock',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: stock == 0 ? Theme.of(context).colorScheme.error : null,
                          ),
                    )
                  : const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: 'Set listing back to draft; it will not be published.',
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                onPressed: () async {
                  await listingRepo.updateStatus(listing.id, ListingStatus.draft);
                  ref.invalidate(pendingListingsProvider);
                  ref.invalidate(listingsProvider);
                },
                child: const Text('Reject'),
              ),
            ),
            Tooltip(
              message: 'Publish this listing to the target marketplace.',
              child: FilledButton(
              onPressed: targets.any((t) => t.id == listing.targetPlatformId)
                  ? () async {
                      try {
                        final productRepo = ref.read(productRepositoryProvider);
                        final product = await productRepo.getByLocalId(listing.productId);
                        if (product == null) return;
                        final target = targets.firstWhere(
                          (t) => t.id == listing.targetPlatformId,
                          orElse: () => targets.first,
                        );
                        // If this listing is variant-specific, use that variant's stock only.
                        final int? variantStock = () {
                          if (listing.variantId == null) return null;
                          final variant = product.variants
                              .where((v) => v.id == listing.variantId)
                              .firstOrNull;
                          return variant?.stock;
                        }();

                        final draft = ListingDraft(
                          productId: listing.productId,
                          targetPlatformId: target.id,
                          title: product.title,
                          description: product.description ?? '',
                          sellingPrice: listing.sellingPrice,
                          sourceCost: listing.sourceCost,
                          imageUrls: product.imageUrls,
                          stock: variantStock ??
                              product.variants.fold<int>(0, (s, v) => s + v.stock),
                        );
                        final offerId = await target.createListing(draft);
                        await listingRepo.updateStatus(listing.id, ListingStatus.active, targetListingId: offerId, publishedAt: DateTime.now());
                        ref.invalidate(pendingListingsProvider);
                        ref.invalidate(listingsProvider);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed: $e')),
                          );
                        }
                      }
                    }
                  : null,
              child: const Text('Approve'),
            ),
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
    final orderCancellation = ref.read(orderCancellationServiceProvider);
    final stockAsync = ref.watch(orderStockAtSourceProvider(order.id));
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(order.targetOrderId),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${order.sellingPrice.toStringAsFixed(2)} PLN · ${order.customerAddress.name}'),
            if (order.deliveryMethodName != null && order.deliveryMethodName!.isNotEmpty)
              Text('Delivery: ${order.deliveryMethodName}', style: Theme.of(context).textTheme.bodySmall),
            if (order.buyerMessage != null && order.buyerMessage!.isNotEmpty)
              Text('Message: ${order.buyerMessage}', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
            stockAsync.when(
              data: (stock) => stock != null
                  ? Text(
                      stock == 0 ? 'Out of stock at supplier' : 'Stock at supplier: $stock',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: stock == 0 ? Theme.of(context).colorScheme.error : null,
                          ),
                    )
                  : const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: 'Cancel the order on the marketplace.',
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Reject order?'),
                      content: const Text(
                        'This will cancel the order on the marketplace. The customer may be notified. This cannot be undone.',
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                        FilledButton(
                          style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Reject & cancel'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed != true || !context.mounted) return;
                  final ok = await orderCancellation.cancelOrder(order);
                  ref.invalidate(pendingOrdersProvider);
                  ref.invalidate(ordersProvider);
                  if (context.mounted && !ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Could not cancel on marketplace. Please cancel the order manually on the marketplace.',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Reject'),
              ),
            ),
            Tooltip(
              message: 'Place the order with the supplier and enqueue fulfillment.',
              child: FilledButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
