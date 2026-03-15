/// Where a return is routed (Phase 4).
enum ReturnRoutingDestination {
  sellerAddress,
  supplierWarehouse,
  returnCenter,
  disposal,
}

extension ReturnRoutingDestinationExtension on ReturnRoutingDestination {
  String toDbString() {
    switch (this) {
      case ReturnRoutingDestination.sellerAddress:
        return 'SELLER_ADDRESS';
      case ReturnRoutingDestination.supplierWarehouse:
        return 'SUPPLIER_WAREHOUSE';
      case ReturnRoutingDestination.returnCenter:
        return 'RETURN_CENTER';
      case ReturnRoutingDestination.disposal:
        return 'DISPOSAL';
    }
  }

  static ReturnRoutingDestination fromDbString(String? s) {
    if (s == null) return ReturnRoutingDestination.sellerAddress;
    switch (s.toUpperCase()) {
      case 'SUPPLIER_WAREHOUSE':
        return ReturnRoutingDestination.supplierWarehouse;
      case 'RETURN_CENTER':
        return ReturnRoutingDestination.returnCenter;
      case 'DISPOSAL':
        return ReturnRoutingDestination.disposal;
      default:
        return ReturnRoutingDestination.sellerAddress;
    }
  }
}
