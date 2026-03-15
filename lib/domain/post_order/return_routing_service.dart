import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';

import 'package:jurassic_dropshipping/domain/post_order/return_routing.dart';
import 'package:jurassic_dropshipping/domain/post_order/supplier_return_policy.dart';

/// Return routing service (Phase 4). Computes where a return should be sent from policy and context.
class ReturnRoutingService {
  /// Computes routing destination from [returnRequest], optional [supplier] and [policy].
  /// When [policy] is null, falls back to [supplier] return fields; when both null, defaults to [ReturnRoutingDestination.sellerAddress].
  /// [isRestockable] – when false and routing would be to supplier, can use [ReturnRoutingDestination.disposal] if policy supports it.
  ReturnRoutingDestination routeReturn(
    ReturnRequest returnRequest, {
    Supplier? supplier,
    SupplierReturnPolicy? policy,
    bool? isRestockable = true,
  }) {
    final type = policy?.policyType;
    final defectReturn = _isDefectReason(returnRequest.reason);

    if (type != null) {
      switch (type) {
        case SupplierReturnPolicyType.returnToWarehouse:
          return ReturnRoutingDestination.supplierWarehouse;
        case SupplierReturnPolicyType.sellerHandlesReturns:
          return ReturnRoutingDestination.sellerAddress;
        case SupplierReturnPolicyType.noReturns:
          if (isRestockable == false) return ReturnRoutingDestination.disposal;
          return ReturnRoutingDestination.sellerAddress;
        case SupplierReturnPolicyType.defectOnly:
          if (!defectReturn) {
            if (isRestockable == false) return ReturnRoutingDestination.disposal;
            return ReturnRoutingDestination.sellerAddress;
          }
          return (policy!.warehouseReturnSupported)
              ? ReturnRoutingDestination.supplierWarehouse
              : ReturnRoutingDestination.sellerAddress;
        case SupplierReturnPolicyType.returnWindow:
        case SupplierReturnPolicyType.fullReturns:
          return (policy!.warehouseReturnSupported)
              ? ReturnRoutingDestination.supplierWarehouse
              : ReturnRoutingDestination.sellerAddress;
      }
    }

    // No policy: infer from supplier
    if (supplier != null) {
      if (supplier.warehouseAddress != null &&
          (supplier.acceptsNoReasonReturns || defectReturn)) {
        return ReturnRoutingDestination.supplierWarehouse;
      }
    }

    return ReturnRoutingDestination.sellerAddress;
  }

  static bool _isDefectReason(ReturnReason reason) {
    switch (reason) {
      case ReturnReason.defective:
      case ReturnReason.damagedInTransit:
      case ReturnReason.wrongItem:
        return true;
      case ReturnReason.noReason:
      case ReturnReason.other:
        return false;
    }
  }
}
