/// Supplier return policy type (Phase 2).
enum SupplierReturnPolicyType {
  noReturns,
  defectOnly,
  returnWindow,
  fullReturns,
  returnToWarehouse,
  sellerHandlesReturns,
}

/// Who pays for return shipping.
enum ReturnShippingPaidBy {
  seller,
  customer,
  supplier,
}

/// Domain model for supplier return policy. Maps from [SupplierReturnPolicyRow].
class SupplierReturnPolicy {
  const SupplierReturnPolicy({
    required this.id,
    required this.supplierId,
    required this.policyType,
    this.returnWindowDays,
    this.restockingFeePercent,
    this.returnShippingPaidBy,
    this.requiresRma = false,
    this.warehouseReturnSupported = false,
    this.virtualRestockSupported = false,
  });

  final int id;
  final String supplierId;
  final SupplierReturnPolicyType policyType;
  final int? returnWindowDays;
  final double? restockingFeePercent;
  final ReturnShippingPaidBy? returnShippingPaidBy;
  final bool requiresRma;
  final bool warehouseReturnSupported;
  final bool virtualRestockSupported;

  static SupplierReturnPolicyType policyTypeFromString(String? s) {
    if (s == null) return SupplierReturnPolicyType.returnWindow;
    switch (s.toUpperCase()) {
      case 'NO_RETURNS':
        return SupplierReturnPolicyType.noReturns;
      case 'DEFECT_ONLY':
        return SupplierReturnPolicyType.defectOnly;
      case 'RETURN_WINDOW':
        return SupplierReturnPolicyType.returnWindow;
      case 'FULL_RETURNS':
        return SupplierReturnPolicyType.fullReturns;
      case 'RETURN_TO_WAREHOUSE':
        return SupplierReturnPolicyType.returnToWarehouse;
      case 'SELLER_HANDLES_RETURNS':
        return SupplierReturnPolicyType.sellerHandlesReturns;
      default:
        return SupplierReturnPolicyType.returnWindow;
    }
  }

  static String policyTypeToString(SupplierReturnPolicyType t) {
    switch (t) {
      case SupplierReturnPolicyType.noReturns:
        return 'NO_RETURNS';
      case SupplierReturnPolicyType.defectOnly:
        return 'DEFECT_ONLY';
      case SupplierReturnPolicyType.returnWindow:
        return 'RETURN_WINDOW';
      case SupplierReturnPolicyType.fullReturns:
        return 'FULL_RETURNS';
      case SupplierReturnPolicyType.returnToWarehouse:
        return 'RETURN_TO_WAREHOUSE';
      case SupplierReturnPolicyType.sellerHandlesReturns:
        return 'SELLER_HANDLES_RETURNS';
    }
  }

  static ReturnShippingPaidBy? returnShippingPaidByFromString(String? s) {
    if (s == null) return null;
    switch (s.toUpperCase()) {
      case 'SELLER':
        return ReturnShippingPaidBy.seller;
      case 'CUSTOMER':
        return ReturnShippingPaidBy.customer;
      case 'SUPPLIER':
        return ReturnShippingPaidBy.supplier;
      default:
        return null;
    }
  }

  static String? returnShippingPaidByToString(ReturnShippingPaidBy? v) {
    if (v == null) return null;
    return v.name.toUpperCase();
  }
}
