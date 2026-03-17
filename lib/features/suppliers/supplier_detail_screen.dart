import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/domain/post_order/supplier_return_policy.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/section_header.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

/// Single supplier by ID. Used by supplierDetailProvider.
final supplierDetailProvider =
    FutureProvider.family<Supplier?, String>((ref, id) => ref.read(supplierRepositoryProvider).getById(id));

/// Return policy for a supplier. Used by supplier detail screen.
final supplierReturnPolicyForProvider = FutureProvider.family<SupplierReturnPolicy?, String>(
    (ref, supplierId) => ref.read(supplierReturnPolicyRepositoryProvider).getBySupplierId(supplierId));

/// Order count and total profit for orders that went through this supplier (listing → product → supplierId).
class SupplierStats {
  const SupplierStats({this.orderCount = 0, this.totalProfit = 0});
  final int orderCount;
  final double totalProfit;
}

final supplierStatsProvider = FutureProvider.family<SupplierStats, String>((ref, supplierId) async {
  final orders = await ref.watch(ordersProvider.future);
  final listings = await ref.watch(listingsProvider.future);
  final products = await ref.read(productRepositoryProvider).getAll();
  final productIdToSupplier = {for (final p in products) p.id: p.supplierId};
  final listingIdToProductId = {for (final l in listings) l.id: l.productId};
  var orderCount = 0;
  var totalProfit = 0.0;
  for (final o in orders) {
    final productId = listingIdToProductId[o.listingId];
    if (productId == null) continue;
    final sid = productIdToSupplier[productId];
    if (sid != supplierId) continue;
    orderCount++;
    totalProfit += (o.sellingPrice - o.sourceCost) * (o.quantity);
  }
  return SupplierStats(orderCount: orderCount, totalProfit: totalProfit);
});

class SupplierDetailScreen extends ConsumerWidget {
  const SupplierDetailScreen({super.key, required this.supplierId});
  final String supplierId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierAsync = ref.watch(supplierDetailProvider(supplierId));
    final policyAsync = ref.watch(supplierReturnPolicyForProvider(supplierId));
    final scoreAsync = ref.watch(supplierReliabilityScoresProvider);
    final statsAsync = ref.watch(supplierStatsProvider(supplierId));

    return supplierAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorCard(
        message: 'Failed to load supplier.',
        onRetry: () => ref.invalidate(supplierDetailProvider(supplierId)),
      ),
      data: (supplier) {
        if (supplier == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.store_outlined, size: 48),
                const SizedBox(height: 16),
                Text('Supplier not found', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => context.go('/suppliers'),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to suppliers'),
                ),
              ],
            ),
          );
        }
        final score = scoreAsync.valueOrNull?.where((s) => s.supplierId == supplierId).firstOrNull;

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(supplierDetailProvider(supplierId));
            ref.invalidate(supplierReturnPolicyForProvider(supplierId));
            ref.invalidate(supplierReliabilityScoresProvider);
            ref.invalidate(supplierStatsProvider(supplierId));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.go('/suppliers'),
                      tooltip: 'Back to suppliers list',
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        supplier.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const ScreenHelpSection(
                  description: ScreenHelpTexts.suppliers,
                  howToUse: 'This page shows full details, return policy, reliability and benefit from this supplier.',
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Overview card ───
                SectionHeader(title: 'Overview', icon: Icons.info_outline),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _row(context, 'ID', supplier.id),
                        _row(context, 'Platform', supplier.platformType),
                        _row(context, 'Country', supplier.countryCode ?? '—'),
                        if (supplier.rating != null) _row(context, 'Rating', supplier.rating!.toStringAsFixed(1)),
                        _row(context, 'Feed / source', supplier.feedSource ?? '—'),
                        if (supplier.shopUrl != null && supplier.shopUrl!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 140, child: Text('Shop / site', style: _labelStyle(context))),
                                Expanded(
                                  child: LinkButton(
                                    label: supplier.shopUrl!,
                                    url: supplier.shopUrl!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Regulations & links ───
                SectionHeader(title: 'Regulations & links', icon: Icons.link),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (supplier.regulationsUrl != null && supplier.regulationsUrl!.isNotEmpty)
                          LinkButton(label: 'Regulations', url: supplier.regulationsUrl!),
                        if (supplier.termsUrl != null && supplier.termsUrl!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: LinkButton(label: 'Terms & conditions', url: supplier.termsUrl!),
                          ),
                        if (supplier.returnPolicyUrl != null && supplier.returnPolicyUrl!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: LinkButton(label: 'Return policy (document)', url: supplier.returnPolicyUrl!),
                          ),
                        if (supplier.shopUrl != null && supplier.shopUrl!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: LinkButton(label: 'Shop / website', url: supplier.shopUrl!),
                          ),
                        if ((supplier.regulationsUrl == null || supplier.regulationsUrl!.isEmpty) &&
                            (supplier.termsUrl == null || supplier.termsUrl!.isEmpty) &&
                            (supplier.returnPolicyUrl == null || supplier.returnPolicyUrl!.isEmpty) &&
                            (supplier.shopUrl == null || supplier.shopUrl!.isEmpty))
                          Text(
                            'No links stored. Add regulations, terms and return policy URLs when editing this supplier (e.g. in Settings).',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Return policy (from Supplier + SupplierReturnPolicy) ───
                SectionHeader(title: 'Return policy', icon: Icons.assignment_return),
                policyAsync.when(
                  loading: () => const Card(child: Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Center(child: CircularProgressIndicator()))),
                  error: (_, _) => Card(child: Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: Text('Could not load return policy.', style: Theme.of(context).textTheme.bodySmall))),
                  data: (policy) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _row(context, 'Return window (supplier)', supplier.returnWindowDays != null ? '${supplier.returnWindowDays} days' : '—'),
                            // ignore: unnecessary_string_interpolations
                            _row(context, 'Return shipping cost (approx)', supplier.returnShippingCost != null ? '${supplier.returnShippingCost!.toStringAsFixed(2)}' : '—'),
                            _row(context, 'Restocking fee %', supplier.restockingFeePercent != null ? '${supplier.restockingFeePercent!.toStringAsFixed(1)}%' : '—'),
                            _row(context, 'Accepts no-reason returns', supplier.acceptsNoReasonReturns ? 'Yes' : 'No'),
                            if (policy != null) ...[
                              const Divider(height: 24),
                              Text('Policy (from Return policies)', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              _row(context, 'Policy type', policy.policyType.name),
                              if (policy.returnWindowDays != null) _row(context, 'Policy return window', '${policy.returnWindowDays} days'),
                              if (policy.restockingFeePercent != null) _row(context, 'Restocking fee', '${policy.restockingFeePercent!.toStringAsFixed(1)}%'),
                              _row(context, 'Return shipping paid by', policy.returnShippingPaidBy?.name ?? '—'),
                              _row(context, 'Requires RMA', policy.requiresRma ? 'Yes' : 'No'),
                              _row(context, 'Warehouse return', policy.warehouseReturnSupported ? 'Yes' : 'No'),
                              _row(context, 'Virtual restock', policy.virtualRestockSupported ? 'Yes' : 'No'),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Warehouse / return address ───
                SectionHeader(title: 'Warehouse / return address', icon: Icons.location_on_outlined),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (supplier.warehouseAddress != null || supplier.warehouseCity != null) ...[
                          if (supplier.warehouseAddress != null) Text(supplier.warehouseAddress!, style: Theme.of(context).textTheme.bodyMedium),
                          if (supplier.warehouseCity != null || supplier.warehouseZip != null)
                            Text(
                              [supplier.warehouseCity, supplier.warehouseZip].whereType<String>().join(' '),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          if (supplier.warehouseCountry != null) Text(supplier.warehouseCountry!, style: Theme.of(context).textTheme.bodyMedium),
                          if (supplier.warehousePhone != null) _row(context, 'Phone', supplier.warehousePhone!),
                          if (supplier.warehouseEmail != null) _row(context, 'Email', supplier.warehouseEmail!),
                        ] else
                          Text(
                            'No warehouse address stored.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Reliability ───
                SectionHeader(title: 'Reliability', icon: Icons.analytics_outlined),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: score != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _row(context, 'Score', '${score.score.toStringAsFixed(0)} / 100'),
                              _row(context, 'Last evaluated', score.lastEvaluatedAt.toLocal().toString().substring(0, 16)),
                              if (score.metricsJson.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Metrics (JSON)', style: Theme.of(context).textTheme.labelMedium),
                                      SelectableText(score.metricsJson, style: Theme.of(context).textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                            ],
                          )
                        : Text(
                            'No reliability score yet. Use "Refresh reliability scores" on the Suppliers list.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                // ─── Products we benefit from ───
                SectionHeader(title: 'Orders & profit from this supplier', icon: Icons.trending_up),
                statsAsync.when(
                  loading: () => const Card(child: Padding(padding: EdgeInsets.all(AppSpacing.lg), child: Center(child: CircularProgressIndicator()))),
                  error: (_, _) => Card(child: Padding(padding: const EdgeInsets.all(AppSpacing.lg), child: Text('Could not load stats.', style: Theme.of(context).textTheme.bodySmall))),
                  data: (stats) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _row(context, 'Orders (fulfilled via this supplier)', '$stats.orderCount'),
                          _row(context, 'Total profit (PLN)', stats.totalProfit.toStringAsFixed(2)),
                          if (stats.orderCount == 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Orders are linked to suppliers via listing → product. Run orders and have products with this supplier to see benefit.',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        );
      },
    );
  }

  TextStyle? _labelStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w500);

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 180, child: Text(label, style: _labelStyle(context))),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class LinkButton extends StatelessWidget {
  const LinkButton({super.key, required this.label, required this.url});
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(url);
    final useUrl = uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    return InkWell(
      onTap: useUrl ? () => _openUrl(url) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.open_in_new, size: 18, color: useUrl ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Flexible(child: Text(useUrl ? url : label, style: TextStyle(color: useUrl ? Theme.of(context).colorScheme.primary : null), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  static Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await launcher.canLaunchUrl(uri)) {
      await launcher.launchUrl(uri, mode: launcher.LaunchMode.externalApplication);
    }
  }
}
