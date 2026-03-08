import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/search_filter_bar.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _statusFilter = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Listing> _applyFilters(List<Listing> listings) {
    var filtered = listings;

    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered
          .where((l) =>
              l.id.toLowerCase().contains(query) ||
              l.productId.toLowerCase().contains(query))
          .toList();
    }

    if (_statusFilter != 'all') {
      filtered = filtered.where((l) {
        return switch (_statusFilter) {
          'active' => l.status == ListingStatus.active,
          'pending' => l.status == ListingStatus.pendingApproval,
          'draft' => l.status == ListingStatus.draft,
          _ => true,
        };
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final listingsAsync = ref.watch(listingsProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(listingsProvider),
      child: listingsAsync.when(
        data: (listings) {
          final filtered = _applyFilters(listings);
          return Column(
            children: [
              SearchFilterBar(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                hintText: 'Search by listing ID or product ID...',
                filterChips: [
                  for (final entry in {'all': 'All', 'active': 'Active', 'pending': 'Pending', 'draft': 'Draft'}.entries)
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
                        icon: Icons.inventory_2,
                        title: 'No listings yet',
                        subtitle: 'Run a scan from Dashboard to find products',
                      )
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (_, i) {
                          final l = filtered[i];
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
              ),
            ],
          );
        },
        loading: () => const LoadingSkeleton(),
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
