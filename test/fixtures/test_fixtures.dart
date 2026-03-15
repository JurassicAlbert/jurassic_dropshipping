import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/marketplace_account.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Centralized test fixture factory for all domain models.
/// Every test should use these factories to ensure consistent, realistic data.
class Fixtures {
  static int _counter = 0;
  static String _uid() => '${++_counter}';

  // ─── Products ──────────────────────────────────────────────

  static Product product({
    String? id,
    String sourceId = 'cj_12345',
    String sourcePlatformId = 'cj',
    String title = 'Wireless Bluetooth Earbuds',
    String? description = 'High quality wireless earbuds with noise cancellation',
    double basePrice = 45.50,
    double? shippingCost = 8.20,
    String currency = 'PLN',
    String? supplierId = 'supplier_cj_001',
    String? supplierCountry = 'CN',
    int? estimatedDays = 14,
    List<ProductVariant>? variants,
  }) {
    return Product(
      id: id ?? 'prod_${_uid()}',
      sourceId: sourceId,
      sourcePlatformId: sourcePlatformId,
      title: title,
      description: description,
      basePrice: basePrice,
      shippingCost: shippingCost,
      currency: currency,
      supplierId: supplierId,
      supplierCountry: supplierCountry,
      estimatedDays: estimatedDays,
      variants: variants ?? [
        productVariant(productId: id ?? 'prod_$_counter'),
      ],
    );
  }

  static ProductVariant productVariant({
    String? id,
    String? productId,
    double price = 45.50,
    int stock = 100,
    String? sku,
    Map<String, String> attributes = const {'color': 'black'},
  }) {
    return ProductVariant(
      id: id ?? 'var_${_uid()}',
      productId: productId ?? 'prod_1',
      price: price,
      stock: stock,
      sku: sku,
      attributes: attributes,
    );
  }

  // ─── Suppliers ─────────────────────────────────────────────

  static Supplier supplier({
    String? id,
    String name = 'CJ Electronics',
    String platformType = 'cj',
    String? countryCode = 'CN',
    double? rating = 4.5,
    int? returnWindowDays = 14,
    double? returnShippingCost = 25.0,
    double? restockingFeePercent = 0.0,
    bool acceptsNoReasonReturns = true,
    String? warehouseAddress,
    String? warehouseCity,
    String? warehouseZip,
    String? warehouseCountry,
    String? warehousePhone,
    String? warehouseEmail,
    String? feedSource,
    String? shopUrl,
  }) {
    return Supplier(
      id: id ?? 'sup_${_uid()}',
      name: name,
      platformType: platformType,
      countryCode: countryCode,
      rating: rating,
      returnWindowDays: returnWindowDays,
      returnShippingCost: returnShippingCost,
      restockingFeePercent: restockingFeePercent,
      acceptsNoReasonReturns: acceptsNoReasonReturns,
      warehouseAddress: warehouseAddress,
      warehouseCity: warehouseCity,
      warehouseZip: warehouseZip,
      warehouseCountry: warehouseCountry,
      warehousePhone: warehousePhone,
      warehouseEmail: warehouseEmail,
      feedSource: feedSource,
      shopUrl: shopUrl,
    );
  }

  static Supplier supplierPL({String? id}) => supplier(
    id: id,
    name: 'Polish Warehouse',
    platformType: 'local',
    countryCode: 'PL',
    rating: 4.8,
    returnWindowDays: 14,
    returnShippingCost: 10.0,
    acceptsNoReasonReturns: true,
  );

  static Supplier supplierNoReturns({String? id}) => supplier(
    id: id,
    name: 'No Returns Co',
    platformType: 'api2cart',
    countryCode: 'TR',
    acceptsNoReasonReturns: false,
    returnWindowDays: 0,
  );

  // ─── Supplier Offers ───────────────────────────────────────

  static SupplierOffer supplierOffer({
    String? id,
    String? productId,
    String? supplierId,
    String sourcePlatformId = 'cj',
    double cost = 45.50,
    double? shippingCost = 8.20,
    int? minEstimatedDays = 7,
    int? maxEstimatedDays = 14,
    String? carrierCode = 'CJ_PACKET',
    String? shippingMethodName = 'CJ Packet',
  }) {
    return SupplierOffer(
      id: id ?? 'offer_${_uid()}',
      productId: productId ?? 'prod_1',
      supplierId: supplierId ?? 'sup_1',
      sourcePlatformId: sourcePlatformId,
      cost: cost,
      shippingCost: shippingCost,
      minEstimatedDays: minEstimatedDays,
      maxEstimatedDays: maxEstimatedDays,
      carrierCode: carrierCode,
      shippingMethodName: shippingMethodName,
      lastPriceRefreshAt: DateTime.now(),
      lastStockRefreshAt: DateTime.now(),
    );
  }

  static SupplierOffer cheapOffer({String? productId}) => supplierOffer(
    productId: productId, cost: 20.0, shippingCost: 3.0, minEstimatedDays: 10, maxEstimatedDays: 21,
  );

  static SupplierOffer expensiveFastOffer({String? productId}) => supplierOffer(
    productId: productId, cost: 60.0, shippingCost: 15.0, minEstimatedDays: 2, maxEstimatedDays: 5,
  );

  // ─── Listings ──────────────────────────────────────────────

  static Listing listing({
    String? id,
    String productId = 'prod_1',
    String targetPlatformId = 'allegro',
    String? targetListingId,
    ListingStatus status = ListingStatus.active,
    double sellingPrice = 99.90,
    double sourceCost = 53.70,
    int? promisedMinDays = 8,
    int? promisedMaxDays = 15,
    DateTime? createdAt,
    String? variantId,
  }) {
    return Listing(
      id: id ?? 'listing_${_uid()}',
      productId: productId,
      targetPlatformId: targetPlatformId,
      targetListingId: targetListingId,
      status: status,
      sellingPrice: sellingPrice,
      sourceCost: sourceCost,
      promisedMinDays: promisedMinDays,
      promisedMaxDays: promisedMaxDays,
      createdAt: createdAt ?? DateTime.now(),
      variantId: variantId,
    );
  }

  static Listing pendingListing({String? id}) => listing(
    id: id, status: ListingStatus.pendingApproval, targetListingId: null,
  );

  static Listing draftListing({String? id}) => listing(
    id: id, status: ListingStatus.draft, sellingPrice: 79.90, sourceCost: 40.0,
  );

  // ─── Orders ────────────────────────────────────────────────

  static CustomerAddress address({
    String name = 'Jan Kowalski',
    String street = 'ul. Marszalkowska 1',
    String? city = 'Warszawa',
    String zip = '00-001',
    String countryCode = 'PL',
    String phone = '+48123456789',
    String? email = 'jan@example.pl',
  }) {
    return CustomerAddress(
      name: name, street: street, city: city, zip: zip,
      countryCode: countryCode, phone: phone, email: email,
    );
  }

  static Order order({
    String? id,
    String listingId = 'listing_1',
    String targetOrderId = 'allegro_ord_001',
    String targetPlatformId = 'allegro',
    OrderStatus status = OrderStatus.pending,
    double sourceCost = 53.70,
    double sellingPrice = 99.90,
    int quantity = 1,
    String? trackingNumber,
    CustomerAddress? customerAddress,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? 'order_${_uid()}',
      listingId: listingId,
      targetOrderId: targetOrderId,
      targetPlatformId: targetPlatformId,
      customerAddress: customerAddress ?? address(),
      status: status,
      sourceCost: sourceCost,
      sellingPrice: sellingPrice,
      quantity: quantity,
      trackingNumber: trackingNumber,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  static Order shippedOrder({String? id}) => order(
    id: id, status: OrderStatus.shipped, trackingNumber: 'PL123456789',
  );

  static Order failedOrder({String? id}) => order(
    id: id, status: OrderStatus.failed, sourceCost: 53.70, sellingPrice: 99.90,
  );

  // ─── Returns ───────────────────────────────────────────────

  static ReturnRequest returnRequest({
    String? id,
    String orderId = 'order_1',
    ReturnReason reason = ReturnReason.noReason,
    ReturnStatus status = ReturnStatus.requested,
    double? refundAmount = 99.90,
    double? returnShippingCost = 25.0,
    double? restockingFee = 0.0,
    String? returnToAddress,
    String? returnToCity,
    String? returnToCountry,
    String? returnTrackingNumber,
    String? returnCarrier,
    String? supplierId,
    String? productId,
    String? sourcePlatformId,
    String? targetPlatformId,
  }) {
    return ReturnRequest(
      id: id ?? 'ret_${_uid()}',
      orderId: orderId,
      reason: reason,
      status: status,
      refundAmount: refundAmount,
      returnShippingCost: returnShippingCost,
      restockingFee: restockingFee,
      requestedAt: DateTime.now(),
      returnToAddress: returnToAddress,
      returnToCity: returnToCity,
      returnToCountry: returnToCountry,
      returnTrackingNumber: returnTrackingNumber,
      returnCarrier: returnCarrier,
      supplierId: supplierId,
      productId: productId,
      sourcePlatformId: sourcePlatformId,
      targetPlatformId: targetPlatformId,
    );
  }

  // ─── Decision Logs ─────────────────────────────────────────

  static DecisionLog decisionLog({
    String? id,
    DecisionLogType type = DecisionLogType.listing,
    String entityId = 'listing_1',
    String reason = 'Profit margin 27.3% >= 25%',
    Map<String, dynamic>? criteriaSnapshot,
  }) {
    return DecisionLog(
      id: id ?? 'log_${_uid()}',
      type: type,
      entityId: entityId,
      reason: reason,
      criteriaSnapshot: criteriaSnapshot ?? {
        'sourceCost': 53.70,
        'sellingPrice': 99.90,
        'marginPercent': 27.3,
        'minProfitPercent': 25.0,
      },
      createdAt: DateTime.now(),
    );
  }

  // ─── User Rules ────────────────────────────────────────────

  static const UserRules defaultRules = UserRules(
    minProfitPercent: 25.0,
    defaultMarkupPercent: 30.0,
    scanIntervalMinutes: 1440,
    searchKeywords: ['electronics', 'bluetooth', 'headphones'],
    manualApprovalListings: true,
    manualApprovalOrders: true,
  );

  static const UserRules aggressiveRules = UserRules(
    minProfitPercent: 10.0,
    defaultMarkupPercent: 15.0,
    maxSourcePrice: 200.0,
    scanIntervalMinutes: 60,
    searchKeywords: ['gadgets'],
    manualApprovalListings: false,
    manualApprovalOrders: false,
  );

  static const UserRules conservativeRules = UserRules(
    minProfitPercent: 40.0,
    defaultMarkupPercent: 50.0,
    maxSourcePrice: 50.0,
    preferredSupplierCountries: ['PL', 'DE'],
    searchKeywords: ['premium'],
    manualApprovalListings: true,
    manualApprovalOrders: true,
    blacklistedSupplierIds: ['bad_supplier'],
  );

  // ─── Marketplace Accounts ──────────────────────────────────

  static MarketplaceAccount marketplaceAccount({
    String? id,
    String platformId = 'allegro',
    String displayName = 'My Allegro Store',
    bool isActive = true,
  }) {
    return MarketplaceAccount(
      id: id ?? 'mkt_${_uid()}',
      platformId: platformId,
      displayName: displayName,
      isActive: isActive,
      connectedAt: DateTime.now(),
    );
  }

  /// Reset counter between test files
  static void reset() => _counter = 0;

  // ─── Seed data: a full set of related entities ─────────────

  static SeedData fullSeedData() {
    final sup1 = supplier(id: 'sup_cj', name: 'CJ Electronics', countryCode: 'CN');
    final sup2 = supplierPL(id: 'sup_pl');
    final prod1 = product(id: 'prod_earbuds', supplierId: 'sup_cj', title: 'Bluetooth Earbuds', basePrice: 45.0, shippingCost: 8.0);
    final prod2 = product(id: 'prod_case', supplierId: 'sup_pl', title: 'Phone Case', basePrice: 12.0, shippingCost: 3.0);
    final offer1 = supplierOffer(id: 'offer_earbuds_cj', productId: 'prod_earbuds', supplierId: 'sup_cj', cost: 45.0, shippingCost: 8.0);
    final offer2 = supplierOffer(id: 'offer_case_pl', productId: 'prod_case', supplierId: 'sup_pl', cost: 12.0, shippingCost: 3.0, minEstimatedDays: 1, maxEstimatedDays: 3);
    final list1 = listing(id: 'listing_earbuds', productId: 'prod_earbuds', sellingPrice: 99.90, sourceCost: 53.0, status: ListingStatus.active);
    final list2 = listing(id: 'listing_case', productId: 'prod_case', sellingPrice: 29.90, sourceCost: 15.0, status: ListingStatus.active, targetPlatformId: 'temu');
    final ord1 = order(id: 'order_1', listingId: 'listing_earbuds', sellingPrice: 99.90, sourceCost: 53.0, status: OrderStatus.shipped, trackingNumber: 'PL111');
    final ord2 = order(id: 'order_2', listingId: 'listing_case', sellingPrice: 29.90, sourceCost: 15.0, status: OrderStatus.pending, targetPlatformId: 'temu');
    final ret1 = returnRequest(id: 'ret_1', orderId: 'order_1', refundAmount: 99.90, returnShippingCost: 25.0);
    final log1 = decisionLog(id: 'log_earbuds', entityId: 'listing_earbuds');
    final log2 = decisionLog(id: 'log_case', entityId: 'listing_case', reason: 'Profit margin 36.8% >= 25%');

    return SeedData(
      suppliers: [sup1, sup2],
      products: [prod1, prod2],
      offers: [offer1, offer2],
      listings: [list1, list2],
      orders: [ord1, ord2],
      returns: [ret1],
      logs: [log1, log2],
      rules: defaultRules,
    );
  }
}

class SeedData {
  const SeedData({
    required this.suppliers,
    required this.products,
    required this.offers,
    required this.listings,
    required this.orders,
    required this.returns,
    required this.logs,
    required this.rules,
  });
  final List<Supplier> suppliers;
  final List<Product> products;
  final List<SupplierOffer> offers;
  final List<Listing> listings;
  final List<Order> orders;
  final List<ReturnRequest> returns;
  final List<DecisionLog> logs;
  final UserRules rules;
}
