import 'dart:math';

import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_repository.dart';

/// Seeds the database with realistic demo data for development and testing.
/// Call [seedAll] to populate, [dropAll] to clear everything.
class SeedService {
  SeedService({
    required this.db,
    required this.productRepository,
    required this.listingRepository,
    required this.orderRepository,
    required this.supplierRepository,
    required this.supplierOfferRepository,
    required this.returnRepository,
    required this.decisionLogRepository,
    required this.rulesRepository,
  });

  final AppDatabase db;
  final ProductRepository productRepository;
  final ListingRepository listingRepository;
  final OrderRepository orderRepository;
  final SupplierRepository supplierRepository;
  final SupplierOfferRepository supplierOfferRepository;
  final ReturnRepository returnRepository;
  final DecisionLogRepository decisionLogRepository;
  final RulesRepository rulesRepository;

  static final _rng = Random(42);

  /// Drop ALL data from every table.
  Future<void> dropAll() async {
    await db.delete(db.returns).go();
    await db.delete(db.orders).go();
    await db.delete(db.listings).go();
    await db.delete(db.decisionLogs).go();
    await db.delete(db.supplierOffers).go();
    await db.delete(db.suppliers).go();
    await db.delete(db.products).go();
    await db.delete(db.marketplaceAccounts).go();
    await db.delete(db.userRulesTable).go();
    appLogger.i('SeedService: all data dropped');
  }

  /// Seed realistic demo data: suppliers, products, offers, listings, 30 days of orders, returns, decision logs, rules.
  Future<SeedResult> seedAll() async {
    final now = DateTime.now();

    // ── Rules ──
    await rulesRepository.save(const UserRules(
      minProfitPercent: 25.0,
      defaultMarkupPercent: 30.0,
      scanIntervalMinutes: 1440,
      searchKeywords: ['electronics', 'bluetooth', 'phone accessories', 'gadgets'],
      manualApprovalListings: true,
      manualApprovalOrders: false,
      preferredSupplierCountries: ['PL', 'DE', 'CN'],
      marketplaceFees: {'allegro': 10.0, 'temu': 8.0},
    ));

    // ── Suppliers ──
    final suppliers = [
      Supplier(id: 'sup_cj', name: 'CJ Electronics', platformType: 'cj', countryCode: 'CN', rating: 4.3, returnWindowDays: 14, returnShippingCost: 30.0, restockingFeePercent: 0, acceptsNoReasonReturns: true, warehouseAddress: '88 Keyuan Road, Nanshan District', warehouseCity: 'Shenzhen', warehouseZip: '518057', warehouseCountry: 'CN', warehousePhone: '+86-755-8600-0088', warehouseEmail: 'returns@cjelectronics.cn', feedSource: 'cj_api', shopUrl: 'https://cjdropshipping.com/supplier/cj-electronics'),
      Supplier(id: 'sup_pl_warehouse', name: 'Warsaw Wholesale', platformType: 'local', countryCode: 'PL', rating: 4.8, returnWindowDays: 14, returnShippingCost: 10.0, restockingFeePercent: 0, acceptsNoReasonReturns: true, warehouseAddress: 'ul. Annopol 3', warehouseCity: 'Warszawa', warehouseZip: '03-236', warehouseCountry: 'PL', warehousePhone: '+48-22-100-2000', warehouseEmail: 'magazyn@warsawwholesale.pl', feedSource: 'manual', shopUrl: 'https://warsawwholesale.pl'),
      Supplier(id: 'sup_de_tech', name: 'Berlin Tech Supply', platformType: 'api2cart', countryCode: 'DE', rating: 4.6, returnWindowDays: 30, returnShippingCost: 15.0, restockingFeePercent: 5.0, acceptsNoReasonReturns: true, warehouseAddress: 'Industriestr. 12', warehouseCity: 'Berlin', warehouseZip: '10317', warehouseCountry: 'DE', warehousePhone: '+49-30-5500-1234', warehouseEmail: 'retouren@berlintechsupply.de', feedSource: 'api2cart_shopify', shopUrl: 'https://berlintechsupply.de'),
      Supplier(id: 'sup_cn_gadgets', name: 'Shenzhen Gadgets', platformType: 'cj', countryCode: 'CN', rating: 3.9, returnWindowDays: 7, returnShippingCost: 40.0, restockingFeePercent: 10.0, acceptsNoReasonReturns: false, warehouseAddress: '168 Baoan Blvd, Baoan District', warehouseCity: 'Shenzhen', warehouseZip: '518101', warehouseCountry: 'CN', warehousePhone: '+86-755-2900-1688', warehouseEmail: 'rma@shenzhengadgets.cn', feedSource: 'cj_api', shopUrl: 'https://cjdropshipping.com/supplier/sz-gadgets'),
      Supplier(id: 'sup_tr_bulk', name: 'Istanbul Bulk Trader', platformType: 'api2cart', countryCode: 'TR', rating: 4.1, returnWindowDays: 0, returnShippingCost: 0, restockingFeePercent: 0, acceptsNoReasonReturns: false, warehouseAddress: 'Organize Sanayi Bolgesi 5. Cadde No:22', warehouseCity: 'Istanbul', warehouseZip: '34953', warehouseCountry: 'TR', warehousePhone: '+90-212-444-2200', warehouseEmail: 'iade@istanbulbulk.com.tr', feedSource: 'api2cart_shopify', shopUrl: 'https://istanbulbulk.com.tr'),
    ];
    for (final s in suppliers) {
      await supplierRepository.upsert(s);
    }

    // ── Products (10 realistic Polish-market dropshipping products) ──
    final products = <Product>[
      _product('prod_earbuds', 'Bluetooth Earbuds TWS Pro', 42.0, 8.0, 'sup_cj', 'CN', 14),
      _product('prod_phone_case', 'iPhone 15 Silicone Case', 8.50, 2.50, 'sup_pl_warehouse', 'PL', 2),
      _product('prod_usb_hub', 'USB-C Hub 7-in-1', 55.0, 12.0, 'sup_de_tech', 'DE', 5),
      _product('prod_led_strip', 'RGB LED Strip 5m WiFi', 25.0, 6.0, 'sup_cn_gadgets', 'CN', 18),
      _product('prod_power_bank', 'Power Bank 20000mAh PD', 65.0, 10.0, 'sup_cj', 'CN', 12),
      _product('prod_webcam', 'Webcam 1080p Autofocus', 38.0, 7.0, 'sup_de_tech', 'DE', 4),
      _product('prod_mouse_pad', 'XL Gaming Mouse Pad', 15.0, 4.0, 'sup_pl_warehouse', 'PL', 1),
      _product('prod_cable_organizer', 'Cable Organizer Box', 12.0, 3.0, 'sup_cn_gadgets', 'CN', 20),
      _product('prod_screen_protector', 'Tempered Glass Samsung S24', 5.0, 1.50, 'sup_tr_bulk', 'TR', 10),
      _product('prod_smart_plug', 'WiFi Smart Plug Alexa', 22.0, 5.0, 'sup_cj', 'CN', 15),
    ];
    for (final p in products) {
      await productRepository.upsert(p);
    }

    // ── Supplier Offers (1-2 per product) ──
    final offers = <SupplierOffer>[];
    for (final p in products) {
      offers.add(SupplierOffer(
        id: 'offer_${p.id}_primary',
        productId: p.id,
        supplierId: p.supplierId ?? 'sup_cj',
        sourcePlatformId: p.sourcePlatformId,
        cost: p.basePrice,
        shippingCost: p.shippingCost,
        minEstimatedDays: (p.estimatedDays ?? 10) ~/ 2,
        maxEstimatedDays: p.estimatedDays,
        carrierCode: 'STANDARD',
        shippingMethodName: 'Standard Shipping',
        lastPriceRefreshAt: now.subtract(Duration(hours: _rng.nextInt(48))),
        lastStockRefreshAt: now.subtract(Duration(hours: _rng.nextInt(24))),
      ));
      // Some products have a second cheaper/slower offer
      if (_rng.nextBool()) {
        offers.add(SupplierOffer(
          id: 'offer_${p.id}_alt',
          productId: p.id,
          supplierId: 'sup_cn_gadgets',
          sourcePlatformId: 'cj',
          cost: p.basePrice * 0.85,
          shippingCost: (p.shippingCost ?? 5) * 1.5,
          minEstimatedDays: 14,
          maxEstimatedDays: 28,
          carrierCode: 'ECONOMY',
          shippingMethodName: 'Economy Shipping',
          lastPriceRefreshAt: now.subtract(Duration(hours: _rng.nextInt(72))),
          lastStockRefreshAt: now.subtract(Duration(hours: _rng.nextInt(48))),
        ));
      }
    }
    for (final o in offers) {
      await supplierOfferRepository.upsert(o);
    }

    // ── Listings (most products listed on Allegro, some on Temu) ──
    final listings = <Listing>[];
    final statuses = [ListingStatus.active, ListingStatus.active, ListingStatus.active, ListingStatus.pendingApproval, ListingStatus.draft, ListingStatus.soldOut];
    for (var i = 0; i < products.length; i++) {
      final p = products[i];
      final sourceCost = p.basePrice + (p.shippingCost ?? 0);
      final sellingPrice = sourceCost * 1.3 / 0.9; // 30% markup, 10% fee
      final status = statuses[i % statuses.length];
      listings.add(Listing(
        id: 'listing_${p.id}_allegro',
        productId: p.id,
        targetPlatformId: 'allegro',
        targetListingId: status == ListingStatus.active ? 'allegro_offer_${i + 1000}' : null,
        status: status,
        sellingPrice: double.parse(sellingPrice.toStringAsFixed(2)),
        sourceCost: sourceCost,
        promisedMinDays: (p.estimatedDays ?? 10) ~/ 2 + 1,
        promisedMaxDays: (p.estimatedDays ?? 10) + 1,
        createdAt: now.subtract(Duration(days: 30 - i)),
        publishedAt: status == ListingStatus.active ? now.subtract(Duration(days: 28 - i)) : null,
      ));
      // Half the products also on Temu
      if (i % 2 == 0) {
        listings.add(Listing(
          id: 'listing_${p.id}_temu',
          productId: p.id,
          targetPlatformId: 'temu',
          targetListingId: status == ListingStatus.active ? 'temu_item_${i + 2000}' : null,
          status: i < 4 ? ListingStatus.active : ListingStatus.draft,
          sellingPrice: double.parse((sellingPrice * 0.95).toStringAsFixed(2)),
          sourceCost: sourceCost,
          promisedMinDays: (p.estimatedDays ?? 10) ~/ 2 + 1,
          promisedMaxDays: (p.estimatedDays ?? 10) + 1,
          createdAt: now.subtract(Duration(days: 25 - i)),
        ));
      }
    }
    for (final l in listings) {
      await listingRepository.insert(l);
    }

    // ── Orders (spread over 30 days, varied statuses, realistic PLN amounts) ──
    final orderStatuses = [OrderStatus.shipped, OrderStatus.shipped, OrderStatus.delivered, OrderStatus.pending, OrderStatus.pendingApproval, OrderStatus.sourceOrderPlaced, OrderStatus.failed];
    final orders = <Order>[];
    final activeListings = listings.where((l) => l.status == ListingStatus.active).toList();
    for (var day = 0; day < 30; day++) {
      final ordersThisDay = 1 + _rng.nextInt(4); // 1-4 orders per day
      for (var j = 0; j < ordersThisDay; j++) {
        final listing = activeListings[_rng.nextInt(activeListings.length)];
        final status = orderStatuses[_rng.nextInt(orderStatuses.length)];
        final orderId = 'order_d${day}_$j';
        final createdAt = now.subtract(Duration(days: 30 - day, hours: _rng.nextInt(12)));
        orders.add(Order(
          id: orderId,
          listingId: listing.id,
          targetOrderId: '${listing.targetPlatformId}_checkout_${day * 10 + j}',
          targetPlatformId: listing.targetPlatformId,
          customerAddress: _randomAddress(),
          status: status,
          sourceCost: listing.sourceCost,
          sellingPrice: listing.sellingPrice,
          trackingNumber: status == OrderStatus.shipped || status == OrderStatus.delivered
              ? 'PL${100000000 + _rng.nextInt(900000000)}'
              : null,
          approvedAt: status != OrderStatus.pendingApproval ? createdAt.add(const Duration(hours: 1)) : null,
          createdAt: createdAt,
        ));
      }
    }
    for (final o in orders) {
      await orderRepository.insert(o);
    }

    // ── Returns (some orders have returns — ~8% return rate) ──
    final listingMap = {for (final l in listings) l.id: l};
    final productMap = {for (final p in products) p.id: p};
    final supplierMap = {for (final s in suppliers) s.id: s};
    final returnCarriers = ['DPD', 'InPost', 'DHL', 'GLS', 'Poczta Polska'];
    final shippedOrDelivered = orders.where((o) => o.status == OrderStatus.shipped || o.status == OrderStatus.delivered).toList();
    final returns = <ReturnRequest>[];
    for (final o in shippedOrDelivered) {
      if (_rng.nextInt(100) < 8) {
        final reasons = [ReturnReason.noReason, ReturnReason.defective, ReturnReason.wrongItem, ReturnReason.damagedInTransit];
        final returnStatuses = [ReturnStatus.requested, ReturnStatus.approved, ReturnStatus.refunded, ReturnStatus.shipped];
        final listing = listingMap[o.listingId];
        final product = listing != null ? productMap[listing.productId] : null;
        final supId = product?.supplierId;
        final sup = supId != null ? supplierMap[supId] : null;
        returns.add(ReturnRequest(
          id: 'ret_${o.id}',
          orderId: o.id,
          reason: reasons[_rng.nextInt(reasons.length)],
          status: returnStatuses[_rng.nextInt(returnStatuses.length)],
          refundAmount: o.sellingPrice,
          returnShippingCost: 15.0 + _rng.nextInt(20).toDouble(),
          restockingFee: 0,
          requestedAt: o.createdAt?.add(Duration(days: 3 + _rng.nextInt(10))),
          returnToAddress: sup?.warehouseAddress,
          returnToCity: sup?.warehouseCity,
          returnToCountry: sup?.warehouseCountry,
          returnTrackingNumber: 'RET${100000000 + _rng.nextInt(900000000)}',
          returnCarrier: returnCarriers[_rng.nextInt(returnCarriers.length)],
          supplierId: supId,
          productId: product?.id,
          sourcePlatformId: product?.sourcePlatformId,
          targetPlatformId: listing?.targetPlatformId,
        ));
      }
    }
    for (final r in returns) {
      await returnRepository.insert(r);
    }

    // ── Decision Logs (one per listing) ──
    for (final l in listings) {
      await decisionLogRepository.insert(DecisionLog(
        id: 'log_${l.id}',
        type: DecisionLogType.listing,
        entityId: l.id,
        reason: l.status == ListingStatus.active || l.status == ListingStatus.pendingApproval
            ? 'Profit margin ${((l.sellingPrice - l.sourceCost) / l.sellingPrice * 100).toStringAsFixed(1)}% >= 25%'
            : 'Draft — awaiting review',
        criteriaSnapshot: {
          'sourceCost': l.sourceCost,
          'sellingPrice': l.sellingPrice,
          'marginPercent': (l.sellingPrice - l.sourceCost) / l.sellingPrice * 100,
          'minProfitPercent': 25.0,
        },
        createdAt: l.createdAt ?? now,
      ));
    }

    final result = SeedResult(
      suppliers: suppliers.length,
      products: products.length,
      offers: offers.length,
      listings: listings.length,
      orders: orders.length,
      returns: returns.length,
    );
    appLogger.i('SeedService: seeded ${result.total} entities');
    return result;
  }

  /// Seed a heavier dataset for KPI/analytics testing.
  ///
  /// This does NOT aim for absolute realism; it focuses on volume so that charts
  /// and aggregates have enough data points. It reuses the same suppliers and
  /// rules as [seedAll], but generates many synthetic products/listings/orders.
  ///
  /// Target scale (approx):
  /// - ~200 products
  /// - ~800–1000 listings across Allegro/Temu
  /// - ~20,000 orders spread across the last 90 days
  Future<SeedResult> seedHeavy() async {
    final now = DateTime.now();

    // Ensure base rules exist (including marketplace + payment fees).
    await rulesRepository.save(const UserRules(
      minProfitPercent: 25.0,
      defaultMarkupPercent: 30.0,
      scanIntervalMinutes: 1440,
      searchKeywords: ['electronics', 'bluetooth', 'phone accessories', 'gadgets'],
      manualApprovalListings: false,
      manualApprovalOrders: false,
      preferredSupplierCountries: ['PL', 'DE', 'CN'],
      marketplaceFees: {'allegro': 10.0, 'temu': 8.0},
      paymentFees: {'allegro': 1.5, 'temu': 1.0},
      pricingStrategy: 'always_below_lowest',
    ));

    // Reuse or insert suppliers from seedAll (idempotent upsert).
    final baseSuppliers = [
      Supplier(id: 'sup_cj', name: 'CJ Electronics', platformType: 'cj', countryCode: 'CN', rating: 4.3, returnWindowDays: 14, returnShippingCost: 30.0, restockingFeePercent: 0, acceptsNoReasonReturns: true, warehouseAddress: '88 Keyuan Road, Nanshan District', warehouseCity: 'Shenzhen', warehouseZip: '518057', warehouseCountry: 'CN', warehousePhone: '+86-755-8600-0088', warehouseEmail: 'returns@cjelectronics.cn', feedSource: 'cj_api', shopUrl: 'https://cjdropshipping.com/supplier/cj-electronics'),
      Supplier(id: 'sup_pl_warehouse', name: 'Warsaw Wholesale', platformType: 'local', countryCode: 'PL', rating: 4.8, returnWindowDays: 14, returnShippingCost: 10.0, restockingFeePercent: 0, acceptsNoReasonReturns: true, warehouseAddress: 'ul. Annopol 3', warehouseCity: 'Warszawa', warehouseZip: '03-236', warehouseCountry: 'PL', warehousePhone: '+48-22-100-2000', warehouseEmail: 'magazyn@warsawwholesale.pl', feedSource: 'manual', shopUrl: 'https://warsawwholesale.pl'),
      Supplier(id: 'sup_de_tech', name: 'Berlin Tech Supply', platformType: 'api2cart', countryCode: 'DE', rating: 4.6, returnWindowDays: 30, returnShippingCost: 15.0, restockingFeePercent: 5.0, acceptsNoReasonReturns: true, warehouseAddress: 'Industriestr. 12', warehouseCity: 'Berlin', warehouseZip: '10317', warehouseCountry: 'DE', warehousePhone: '+49-30-5500-1234', warehouseEmail: 'retouren@berlintechsupply.de', feedSource: 'api2cart_shopify', shopUrl: 'https://berlintechsupply.de'),
      Supplier(id: 'sup_cn_gadgets', name: 'Shenzhen Gadgets', platformType: 'cj', countryCode: 'CN', rating: 3.9, returnWindowDays: 7, returnShippingCost: 40.0, restockingFeePercent: 10.0, acceptsNoReasonReturns: false, warehouseAddress: '168 Baoan Blvd, Baoan District', warehouseCity: 'Shenzhen', warehouseZip: '518101', warehouseCountry: 'CN', warehousePhone: '+86-755-2900-1688', warehouseEmail: 'rma@shenzhengadgets.cn', feedSource: 'cj_api', shopUrl: 'https://cjdropshipping.com/supplier/sz-gadgets'),
      Supplier(id: 'sup_tr_bulk', name: 'Istanbul Bulk Trader', platformType: 'api2cart', countryCode: 'TR', rating: 4.1, returnWindowDays: 0, returnShippingCost: 0, restockingFeePercent: 0, acceptsNoReasonReturns: false, warehouseAddress: 'Organize Sanayi Bolgesi 5. Cadde No:22', warehouseCity: 'Istanbul', warehouseZip: '34953', warehouseCountry: 'TR', warehousePhone: '+90-212-444-2200', warehouseEmail: 'iade@istanbulbulk.com.tr', feedSource: 'api2cart_shopify', shopUrl: 'https://istanbulbulk.com.tr'),
    ];
    for (final s in baseSuppliers) {
      await supplierRepository.upsert(s);
    }

    // Generate synthetic products.
    const productCount = 200;
    final suppliers = baseSuppliers;
    final products = <Product>[];
    for (var i = 0; i < productCount; i++) {
      final s = suppliers[_rng.nextInt(suppliers.length)];
      final basePrice = 10 + _rng.nextInt(190) + _rng.nextDouble(); // 10–200 PLN
      final shippingCost = 5 + _rng.nextInt(40) + _rng.nextDouble(); // 5–45 PLN
      final days = 3 + _rng.nextInt(21); // 3–24 days
      final id = 'prod_auto_$i';
      products.add(Product(
        id: id,
        sourceId: 'src_$id',
        sourcePlatformId: s.platformType == 'api2cart' ? 'api2cart' : 'cj',
        title: 'Demo product $i',
        description: 'Synthetic demo product $i for KPI testing',
        basePrice: double.parse(basePrice.toStringAsFixed(2)),
        shippingCost: double.parse(shippingCost.toStringAsFixed(2)),
        supplierId: s.id,
        supplierCountry: s.countryCode,
        estimatedDays: days,
        variants: [
          ProductVariant(
            id: 'var_${id}_default',
            productId: id,
            attributes: const {'size': 'standard'},
            price: double.parse(basePrice.toStringAsFixed(2)),
            stock: 20 + _rng.nextInt(200),
          ),
        ],
      ));
    }
    for (final p in products) {
      await productRepository.upsert(p);
    }

    // Supplier offers (primary + optional alternative) for heavy set.
    final offers = <SupplierOffer>[];
    for (final p in products) {
      offers.add(SupplierOffer(
        id: 'offer_${p.id}_primary',
        productId: p.id,
        supplierId: p.supplierId ?? 'sup_cj',
        sourcePlatformId: p.sourcePlatformId,
        cost: p.basePrice,
        shippingCost: p.shippingCost,
        minEstimatedDays: (p.estimatedDays ?? 10) ~/ 2,
        maxEstimatedDays: p.estimatedDays,
        carrierCode: 'STANDARD',
        shippingMethodName: 'Standard Shipping',
        lastPriceRefreshAt: now.subtract(Duration(hours: _rng.nextInt(48))),
        lastStockRefreshAt: now.subtract(Duration(hours: _rng.nextInt(24))),
      ));
      if (_rng.nextBool()) {
        offers.add(SupplierOffer(
          id: 'offer_${p.id}_alt',
          productId: p.id,
          supplierId: 'sup_cn_gadgets',
          sourcePlatformId: 'cj',
          cost: p.basePrice * (0.7 + _rng.nextDouble() * 0.3), // 70–100% of base
          shippingCost: (p.shippingCost ?? 5) * (0.8 + _rng.nextDouble() * 0.8),
          minEstimatedDays: 7 + _rng.nextInt(10),
          maxEstimatedDays: 20 + _rng.nextInt(10),
          carrierCode: 'ECONOMY',
          shippingMethodName: 'Economy Shipping',
          lastPriceRefreshAt: now.subtract(Duration(hours: _rng.nextInt(72))),
          lastStockRefreshAt: now.subtract(Duration(hours: _rng.nextInt(48))),
        ));
      }
    }
    for (final o in offers) {
      await supplierOfferRepository.upsert(o);
    }

    // Listings: Allegro + some Temu per product.
    final listings = <Listing>[];
    final statuses = [
      ListingStatus.active,
      ListingStatus.active,
      ListingStatus.active,
      ListingStatus.pendingApproval,
      ListingStatus.draft,
      ListingStatus.soldOut,
    ];
    for (var i = 0; i < products.length; i++) {
      final p = products[i];
      final sourceCost = p.basePrice + (p.shippingCost ?? 0);
      final sellingPrice = sourceCost * (1.2 + _rng.nextDouble() * 0.6); // 20–80% markup
      final status = statuses[i % statuses.length];
      listings.add(Listing(
        id: 'listing_${p.id}_allegro',
        productId: p.id,
        targetPlatformId: 'allegro',
        targetListingId: status == ListingStatus.active ? 'allegro_offer_${i + 5000}' : null,
        status: status,
        sellingPrice: double.parse(sellingPrice.toStringAsFixed(2)),
        sourceCost: double.parse(sourceCost.toStringAsFixed(2)),
        promisedMinDays: (p.estimatedDays ?? 10) ~/ 2 + 1,
        promisedMaxDays: (p.estimatedDays ?? 10) + 1,
        createdAt: now.subtract(Duration(days: 90 - (i % 90))),
        publishedAt: status == ListingStatus.active ? now.subtract(Duration(days: 88 - (i % 88))) : null,
      ));
      if (i % 2 == 0) {
        listings.add(Listing(
          id: 'listing_${p.id}_temu',
          productId: p.id,
          targetPlatformId: 'temu',
          targetListingId: status == ListingStatus.active ? 'temu_item_${i + 8000}' : null,
          status: i % 3 == 0 ? ListingStatus.active : ListingStatus.draft,
          sellingPrice: double.parse((sellingPrice * (0.9 + _rng.nextDouble() * 0.1)).toStringAsFixed(2)),
          sourceCost: double.parse(sourceCost.toStringAsFixed(2)),
          promisedMinDays: (p.estimatedDays ?? 10) ~/ 2 + 1,
          promisedMaxDays: (p.estimatedDays ?? 10) + 1,
          createdAt: now.subtract(Duration(days: 60 - (i % 60))),
        ));
      }
    }
    for (final l in listings) {
      await listingRepository.insert(l);
    }

    // Orders: ~20k orders over last 90 days.
    final activeListings = listings.where((l) => l.status == ListingStatus.active).toList();
    final orders = <Order>[];
    final orderStatuses = [
      OrderStatus.shipped,
      OrderStatus.shipped,
      OrderStatus.delivered,
      OrderStatus.pending,
      OrderStatus.pendingApproval,
      OrderStatus.sourceOrderPlaced,
      OrderStatus.failed,
    ];
    const targetOrderCount = 20000;
    var orderIndex = 0;
    for (var day = 0; day < 90 && orderIndex < targetOrderCount; day++) {
      final ordersThisDay = 50 + _rng.nextInt(100); // 50–149 per day
      for (var j = 0; j < ordersThisDay && orderIndex < targetOrderCount; j++) {
        final listing = activeListings[_rng.nextInt(activeListings.length)];
        final status = orderStatuses[_rng.nextInt(orderStatuses.length)];
        final orderId = 'order_h_${day}_$j';
        final createdAt = now.subtract(Duration(days: 90 - day, hours: _rng.nextInt(12)));
        orders.add(Order(
          id: orderId,
          listingId: listing.id,
          targetOrderId: '${listing.targetPlatformId}_checkout_h_${day * 100 + j}',
          targetPlatformId: listing.targetPlatformId,
          customerAddress: _randomAddress(),
          status: status,
          sourceCost: listing.sourceCost,
          sellingPrice: listing.sellingPrice,
          trackingNumber: status == OrderStatus.shipped || status == OrderStatus.delivered
              ? 'PL${100000000 + _rng.nextInt(900000000)}'
              : null,
          approvedAt: status != OrderStatus.pendingApproval ? createdAt.add(const Duration(hours: 1)) : null,
          createdAt: createdAt,
        ));
        orderIndex++;
      }
    }
    for (final o in orders) {
      await orderRepository.insert(o);
    }

    // Returns (~8% of shipped/delivered orders).
    final listingMap = {for (final l in listings) l.id: l};
    final productMap = {for (final p in products) p.id: p};
    final supplierMap = {for (final s in baseSuppliers) s.id: s};
    final returnCarriers = ['DPD', 'InPost', 'DHL', 'GLS', 'Poczta Polska'];
    final shippedOrDelivered = orders.where((o) => o.status == OrderStatus.shipped || o.status == OrderStatus.delivered).toList();
    final returns = <ReturnRequest>[];
    for (final o in shippedOrDelivered) {
      if (_rng.nextInt(100) < 8) {
        final reasons = [ReturnReason.noReason, ReturnReason.defective, ReturnReason.wrongItem, ReturnReason.damagedInTransit];
        final returnStatuses = [ReturnStatus.requested, ReturnStatus.approved, ReturnStatus.refunded, ReturnStatus.shipped];
        final listing = listingMap[o.listingId];
        final product = listing != null ? productMap[listing.productId] : null;
        final supId = product?.supplierId;
        final sup = supId != null ? supplierMap[supId] : null;
        returns.add(ReturnRequest(
          id: 'ret_h_${o.id}',
          orderId: o.id,
          reason: reasons[_rng.nextInt(reasons.length)],
          status: returnStatuses[_rng.nextInt(returnStatuses.length)],
          refundAmount: o.sellingPrice,
          returnShippingCost: 15.0 + _rng.nextInt(20).toDouble(),
          restockingFee: 0,
          requestedAt: o.createdAt?.add(Duration(days: 3 + _rng.nextInt(10))),
          returnToAddress: sup?.warehouseAddress,
          returnToCity: sup?.warehouseCity,
          returnToCountry: sup?.warehouseCountry,
          returnTrackingNumber: 'RET${100000000 + _rng.nextInt(900000000)}',
          returnCarrier: returnCarriers[_rng.nextInt(returnCarriers.length)],
          supplierId: supId,
          productId: product?.id,
          sourcePlatformId: product?.sourcePlatformId,
          targetPlatformId: listing?.targetPlatformId,
        ));
      }
    }
    for (final r in returns) {
      await returnRepository.insert(r);
    }

    // Decision logs (one per listing).
    for (final l in listings) {
      final marginPercent = (l.sellingPrice - l.sourceCost) / l.sellingPrice * 100;
      await decisionLogRepository.insert(DecisionLog(
        id: 'log_h_${l.id}',
        type: DecisionLogType.listing,
        entityId: l.id,
        reason: l.status == ListingStatus.active || l.status == ListingStatus.pendingApproval
            ? 'Profit margin ${marginPercent.toStringAsFixed(1)}% >= 25%'
            : 'Draft — awaiting review',
        criteriaSnapshot: {
          'sourceCost': l.sourceCost,
          'sellingPrice': l.sellingPrice,
          'marginPercent': marginPercent,
          'minProfitPercent': 25.0,
        },
        createdAt: l.createdAt ?? now,
      ));
    }

    final result = SeedResult(
      suppliers: baseSuppliers.length,
      products: products.length,
      offers: offers.length,
      listings: listings.length,
      orders: orders.length,
      returns: returns.length,
    );
    appLogger.i('SeedService: seeded HEAVY dataset with ${result.total} entities '
        '(${result.orders} orders, ${result.listings} listings, ${result.products} products).');
    return result;
  }

  static Product _product(String id, String title, double basePrice, double shippingCost, String supplierId, String country, int days) {
    return Product(
      id: id,
      sourceId: 'src_$id',
      sourcePlatformId: supplierId.contains('api2cart') || supplierId == 'sup_de_tech' ? 'api2cart' : 'cj',
      title: title,
      description: 'High quality $title for the Polish market',
      basePrice: basePrice,
      shippingCost: shippingCost,
      supplierId: supplierId,
      supplierCountry: country,
      estimatedDays: days,
      variants: [
        ProductVariant(id: 'var_${id}_default', productId: id, attributes: const {'size': 'standard'}, price: basePrice, stock: 50 + _rng.nextInt(200)),
      ],
    );
  }

  static final _names = ['Anna Nowak', 'Piotr Kowalski', 'Maria Wisniewska', 'Jan Wojciechowski', 'Katarzyna Kaminska', 'Tomasz Lewandowski', 'Agnieszka Zielinska', 'Marek Szymanski', 'Ewa Wozniak', 'Krzysztof Dabrowski'];
  static final _cities = ['Warszawa', 'Krakow', 'Wroclaw', 'Poznan', 'Gdansk', 'Szczecin', 'Lodz', 'Katowice', 'Lublin', 'Bialystok'];
  static final _streets = ['ul. Marszalkowska', 'ul. Dluga', 'ul. Kwiatowa', 'ul. Polna', 'ul. Lesna', 'al. Niepodleglosci', 'ul. Mickiewicza', 'ul. Slowackiego', 'ul. Sienkiewicza', 'ul. Pilsudskiego'];

  static CustomerAddress _randomAddress() {
    final name = _names[_rng.nextInt(_names.length)];
    final city = _cities[_rng.nextInt(_cities.length)];
    final street = '${_streets[_rng.nextInt(_streets.length)]} ${1 + _rng.nextInt(150)}';
    final zip = '${10 + _rng.nextInt(89)}-${100 + _rng.nextInt(899)}';
    return CustomerAddress(
      name: name,
      street: street,
      city: city,
      zip: zip,
      countryCode: 'PL',
      phone: '+48${500000000 + _rng.nextInt(400000000)}',
      email: '${name.toLowerCase().replaceAll(' ', '.')}@example.pl',
    );
  }
}

class SeedResult {
  const SeedResult({
    required this.suppliers,
    required this.products,
    required this.offers,
    required this.listings,
    required this.orders,
    required this.returns,
  });
  final int suppliers;
  final int products;
  final int offers;
  final int listings;
  final int orders;
  final int returns;

  int get total => suppliers + products + offers + listings + orders + returns;
}
