import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/post_order/supplier_return_policy.dart';

/// Result of handling a non-collected parcel (Phase 6).
class NonCollectedParcelResult {
  const NonCollectedParcelResult({
    required this.financialImpact,
    required this.suggestedDecision,
    required this.reason,
  });

  final double financialImpact;
  /// One of: relist, addToReturnedStock, discard.
  final String suggestedDecision;
  final String reason;
}

/// Handles non-collected parcel flow (Phase 6): compute financial impact and suggest
/// decision (relist | addToReturnedStock | discard). Trigger: manual or when
/// marketplace/carrier signals "returned to sender" / "not collected".
class NonCollectedParcelHandler {
  /// Computes financial impact and suggested decision for a non-collected parcel.
  ///
  /// [order] – the order that was not collected.
  /// [policy] – optional supplier return policy (for restocking fee and restock support).
  /// [estimatedReturnShippingCost] – cost to get the parcel back (default 0).
  /// [marketplaceFeeLossPercent] – e.g. 0.1 for 10% of selling price as fee loss (default 0.1).
  NonCollectedParcelResult handleNonCollected(
    Order order, {
    SupplierReturnPolicy? policy,
    double estimatedReturnShippingCost = 0,
    double marketplaceFeeLossPercent = 0.1,
  }) {
    final restockingFeePercent = policy?.restockingFeePercent ?? 0;
    final restockingFee = (restockingFeePercent / 100) * order.sourceCost;
    final marketplaceFeeLoss = marketplaceFeeLossPercent * order.sellingPrice;

    // Plan: shippingCost + returnCost + supplierRestockingFee + marketplaceFeeLoss.
    // We treat sourceCost as product cost at risk; add return shipping, restocking, fee loss.
    final financialImpact = order.sourceCost +
        estimatedReturnShippingCost +
        restockingFee +
        marketplaceFeeLoss;

    final canRestock = policy != null &&
        (policy.virtualRestockSupported || policy.warehouseReturnSupported);

    String suggestedDecision;
    String reason;
    if (canRestock) {
      suggestedDecision = 'addToReturnedStock';
      reason =
          'Non-collected parcel: product can be restocked (policy supports warehouse/virtual restock).';
    } else if (policy != null && policy.policyType != SupplierReturnPolicyType.noReturns) {
      suggestedDecision = 'relist';
      reason =
          'Non-collected parcel: item may be returned; relist when received.';
    } else {
      suggestedDecision = 'discard';
      reason =
          'Non-collected parcel: no restock support; treat as loss/discard.';
    }

    return NonCollectedParcelResult(
      financialImpact: financialImpact,
      suggestedDecision: suggestedDecision,
      reason: reason,
    );
  }
}
