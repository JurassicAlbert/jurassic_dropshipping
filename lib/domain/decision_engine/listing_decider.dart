import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';

/// Decides whether to list a product and creates draft/pending_approval listing + decision log.
class ListingDecider {
  ListingDecider({
    required this.pricingCalculator,
  });

  final PricingCalculator pricingCalculator;

  /// Returns a listing decision: if profitable and within rules, returns [ListingDecision.accept] with
  /// draft listing and reason; otherwise [ListingDecision.reject] with reason.
  ListingDecision decide(Product product, UserRules rules) {
    final sourceCost = product.basePrice + (product.shippingCost ?? 0);

    if (rules.maxSourcePrice != null && sourceCost > rules.maxSourcePrice!) {
      return ListingDecisionReject(
        reason: 'Source cost $sourceCost exceeds max ${rules.maxSourcePrice}',
      );
    }
    if (product.supplierId != null && rules.blacklistedSupplierIds.contains(product.supplierId!)) {
      return ListingDecisionReject(reason: 'Supplier blacklisted');
    }
    if (rules.blacklistedProductIds.contains(product.id)) {
      return ListingDecisionReject(reason: 'Product blacklisted');
    }

    final sellingPrice = pricingCalculator.calculateSellingPrice(sourceCost, rules);
    final margin = pricingCalculator.profitMarginPercent(sellingPrice, sourceCost);

    if (!pricingCalculator.meetsMinProfit(sellingPrice, sourceCost, rules)) {
      return ListingDecisionReject(
        reason: 'Profit margin ${margin.toStringAsFixed(1)}% < ${rules.minProfitPercent}%',
      );
    }

    final listingId = 'listing_${product.sourcePlatformId}_${product.sourceId}_${DateTime.now().millisecondsSinceEpoch}';
    final listing = Listing(
      id: listingId,
      productId: product.id,
      targetPlatformId: '', // filled by caller when target is chosen
      status: rules.manualApprovalListings ? ListingStatus.pendingApproval : ListingStatus.draft,
      sellingPrice: sellingPrice,
      sourceCost: sourceCost,
      createdAt: DateTime.now(),
    );
    final reason = 'Profit margin ${margin.toStringAsFixed(1)}% >= ${rules.minProfitPercent}%';
    return ListingDecisionAccept(
      listing: listing,
      reason: reason,
      criteriaSnapshot: {
        'sourceCost': sourceCost,
        'sellingPrice': sellingPrice,
        'marginPercent': margin,
        'minProfitPercent': rules.minProfitPercent,
      },
    );
  }
}

sealed class ListingDecision {
  const ListingDecision();
}

class ListingDecisionAccept extends ListingDecision {
  const ListingDecisionAccept({
    required this.listing,
    required this.reason,
    this.criteriaSnapshot,
  });
  final Listing listing;
  final String reason;
  final Map<String, dynamic>? criteriaSnapshot;
}

class ListingDecisionReject extends ListingDecision {
  const ListingDecisionReject({required this.reason});
  final String reason;
}

/// Extension to make pattern matching / usage easier.
extension ListingDecisionX on ListingDecision {
  Listing? get listingOrNull =>
      this is ListingDecisionAccept ? (this as ListingDecisionAccept).listing : null;
  String get reason =>
      this is ListingDecisionAccept
          ? (this as ListingDecisionAccept).reason
          : (this as ListingDecisionReject).reason;
  bool get isAccept => this is ListingDecisionAccept;
}
