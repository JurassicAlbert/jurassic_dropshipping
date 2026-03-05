import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Selects the best source offer when multiple sources have the same/similar product.
/// Applies rules: preferred countries, max delivery days, then lowest total cost.
class SupplierSelector {
  /// Pick the best product from a list of candidates (e.g. same product from different sources).
  /// Returns the chosen product and a short reason for the decision.
  ProductSelectionResult select(
    List<Product> candidates,
    UserRules rules,
  ) {
    if (candidates.isEmpty) {
      return ProductSelectionResult(
        product: null,
        reason: 'No candidates',
      );
    }
    if (candidates.length == 1) {
      return ProductSelectionResult(
        product: candidates.first,
        reason: 'Only one source',
      );
    }

    // Filter by blacklist
    var allowed = candidates.where((p) {
      if (p.supplierId != null && rules.blacklistedSupplierIds.contains(p.supplierId)) return false;
      if (rules.blacklistedProductIds.contains(p.id)) return false;
      return true;
    }).toList();
    if (allowed.isEmpty) {
      return ProductSelectionResult(
        product: null,
        reason: 'All candidates blacklisted',
      );
    }

    // Prefer preferred countries
    if (rules.preferredSupplierCountries.isNotEmpty) {
      final preferred = allowed.where((p) {
        if (p.supplierCountry == null) return false;
        final country = p.supplierCountry!.toLowerCase();
        return rules.preferredSupplierCountries.any((c) =>
            c.toLowerCase() == country || country.startsWith(c.toLowerCase()));
      }).toList();
      if (preferred.isNotEmpty) allowed = preferred;
    }

    // Max source price
    if (rules.maxSourcePrice != null) {
      allowed = allowed.where((p) {
        final total = p.basePrice + (p.shippingCost ?? 0);
        return total <= rules.maxSourcePrice!;
      }).toList();
      if (allowed.isEmpty) {
        return ProductSelectionResult(
          product: null,
          reason: 'All exceed max source price ${rules.maxSourcePrice}',
        );
      }
    }

    // Sort by total cost (price + shipping), then by estimated days
    allowed.sort((a, b) {
      final costA = a.basePrice + (a.shippingCost ?? 0);
      final costB = b.basePrice + (b.shippingCost ?? 0);
      final c = costA.compareTo(costB);
      if (c != 0) return c;
      final daysA = a.estimatedDays ?? 999;
      final daysB = b.estimatedDays ?? 999;
      return daysA.compareTo(daysB);
    });

    final chosen = allowed.first;
    final totalCost = chosen.basePrice + (chosen.shippingCost ?? 0);
    appLogger.d('SupplierSelector: chose ${chosen.sourcePlatformId}/${chosen.sourceId} total=$totalCost');
    return ProductSelectionResult(
      product: chosen,
      reason: 'Lowest total cost $totalCost ${chosen.supplierCountry ?? ""}',
    );
  }

  /// Pick the best offer from a list of SupplierOffer candidates.
  OfferSelectionResult selectFromOffers(
    List<SupplierOffer> offers,
    UserRules rules, {
    List<Supplier>? suppliers,
  }) {
    if (offers.isEmpty) {
      return OfferSelectionResult(offer: null, reason: 'No offers');
    }
    if (offers.length == 1) {
      return OfferSelectionResult(offer: offers.first, reason: 'Only one offer');
    }

    // Filter by blacklist
    var allowed = offers.where((o) {
      if (rules.blacklistedSupplierIds.contains(o.supplierId)) return false;
      if (rules.blacklistedProductIds.contains(o.productId)) return false;
      return true;
    }).toList();
    if (allowed.isEmpty) {
      return OfferSelectionResult(offer: null, reason: 'All offers blacklisted');
    }

    // Prefer preferred countries (if supplier info available)
    if (rules.preferredSupplierCountries.isNotEmpty && suppliers != null) {
      final supplierMap = {for (final s in suppliers) s.id: s};
      final preferred = allowed.where((o) {
        final s = supplierMap[o.supplierId];
        if (s?.countryCode == null) return false;
        return rules.preferredSupplierCountries.any(
          (c) => c.toLowerCase() == s!.countryCode!.toLowerCase(),
        );
      }).toList();
      if (preferred.isNotEmpty) allowed = preferred;
    }

    // Max source price
    if (rules.maxSourcePrice != null) {
      allowed = allowed.where((o) {
        final total = o.cost + (o.shippingCost ?? 0);
        return total <= rules.maxSourcePrice!;
      }).toList();
      if (allowed.isEmpty) {
        return OfferSelectionResult(
          offer: null,
          reason: 'All exceed max source price ${rules.maxSourcePrice}',
        );
      }
    }

    // Sort by total cost, then by estimated delivery
    allowed.sort((a, b) {
      final costA = a.cost + (a.shippingCost ?? 0);
      final costB = b.cost + (b.shippingCost ?? 0);
      final c = costA.compareTo(costB);
      if (c != 0) return c;
      final daysA = a.maxEstimatedDays ?? 999;
      final daysB = b.maxEstimatedDays ?? 999;
      return daysA.compareTo(daysB);
    });

    final chosen = allowed.first;
    final totalCost = chosen.cost + (chosen.shippingCost ?? 0);
    appLogger.d('SupplierSelector: chose offer ${chosen.id} total=$totalCost');
    return OfferSelectionResult(
      offer: chosen,
      reason: 'Lowest total cost $totalCost',
    );
  }
}

class ProductSelectionResult {
  const ProductSelectionResult({this.product, required this.reason});
  final Product? product;
  final String reason;
}

class OfferSelectionResult {
  const OfferSelectionResult({this.offer, required this.reason});
  final SupplierOffer? offer;
  final String reason;
}
