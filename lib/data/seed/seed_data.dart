import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/marketplace_account.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

class DemoSeedData {
  static final now = DateTime.now();
  static DateTime _daysAgo(int d) => now.subtract(Duration(days: d));

  static const rules = UserRules(
    minProfitPercent: 25.0,
    defaultMarkupPercent: 30.0,
    scanIntervalMinutes: 1440,
    searchKeywords: ['electronics', 'bluetooth', 'phone accessories', 'smart home'],
    manualApprovalListings: true,
    manualApprovalOrders: true,
    marketplaceFees: {'allegro': 10.0, 'temu': 8.0},
  );

  static List<Supplier> get suppliers => [
    const Supplier(id: 'sup_cj_01', name: 'CJ Electronics Shenzhen', platformType: 'cj', countryCode: 'CN', rating: 4.5, returnWindowDays: 14, returnShippingCost: 30.0, restockingFeePercent: 0, acceptsNoReasonReturns: true),
    const Supplier(id: 'sup_cj_02', name: 'CJ Home & Garden', platformType: 'cj', countryCode: 'CN', rating: 4.2, returnWindowDays: 14, returnShippingCost: 35.0, restockingFeePercent: 5, acceptsNoReasonReturns: true),
    const Supplier(id: 'sup_pl_01', name: 'Hurtownia Polska', platformType: 'local', countryCode: 'PL', rating: 4.8, returnWindowDays: 14, returnShippingCost: 10.0, restockingFeePercent: 0, acceptsNoReasonReturns: true),
    const Supplier(id: 'sup_api2c_01', name: 'TechShop EU (API2Cart)', platformType: 'api2cart', countryCode: 'DE', rating: 4.6, returnWindowDays: 30, returnShippingCost: 15.0, restockingFeePercent: 0, acceptsNoReasonReturns: true),
    const Supplier(id: 'sup_tr_01', name: 'Istanbul Wholesale', platformType: 'api2cart', countryCode: 'TR', rating: 3.9, returnWindowDays: 0, returnShippingCost: 0, restockingFeePercent: 0, acceptsNoReasonReturns: false),
  ];

  static List<Product> get products {
    final p = <Product>[];
    final items = [
      ('Wireless Bluetooth Earbuds TWS', 42.0, 7.5, 'sup_cj_01', 'cj_earbuds_001'),
      ('USB-C Fast Charging Cable 2m', 8.50, 2.0, 'sup_cj_01', 'cj_cable_002'),
      ('Smart LED Light Bulb WiFi', 22.0, 5.0, 'sup_cj_02', 'cj_bulb_003'),
      ('Phone Case Silicone iPhone 15', 6.0, 1.5, 'sup_cj_01', 'cj_case_004'),
      ('Bluetooth Speaker Portable', 55.0, 10.0, 'sup_cj_01', 'cj_speaker_005'),
      ('Wireless Mouse Ergonomic', 28.0, 4.0, 'sup_cj_02', 'cj_mouse_006'),
      ('Laptop Stand Adjustable', 35.0, 8.0, 'sup_cj_02', 'cj_stand_007'),
      ('Mini Portable Projector', 180.0, 15.0, 'sup_cj_01', 'cj_proj_008'),
      ('Smart Watch Fitness Tracker', 65.0, 8.0, 'sup_cj_01', 'cj_watch_009'),
      ('USB Hub 7-Port', 18.0, 3.0, 'sup_cj_02', 'cj_hub_010'),
      ('Etui na telefon Samsung S24', 8.0, 2.0, 'sup_pl_01', 'pl_etui_011'),
      ('Kabel Lightning 1m', 12.0, 2.5, 'sup_pl_01', 'pl_kabel_012'),
      ('Powerbank 20000mAh', 45.0, 5.0, 'sup_pl_01', 'pl_power_013'),
      ('Webcam HD 1080p', 38.0, 6.0, 'sup_api2c_01', 'a2c_webcam_014'),
      ('Mechanical Keyboard RGB', 85.0, 12.0, 'sup_api2c_01', 'a2c_keyb_015'),
      ('Ring Light 10 inch', 30.0, 8.0, 'sup_tr_01', 'tr_ring_016'),
      ('Phone Tripod Flexible', 15.0, 4.0, 'sup_tr_01', 'tr_tripod_017'),
      ('Wireless Charger Pad 15W', 20.0, 3.0, 'sup_cj_01', 'cj_charger_018'),
      ('HDMI Cable 4K 2m', 10.0, 2.0, 'sup_api2c_01', 'a2c_hdmi_019'),
      ('Noise Cancelling Headphones', 120.0, 10.0, 'sup_cj_01', 'cj_headph_020'),
    ];
    for (final (title, price, ship, supId, srcId) in items) {
      final platform = supId.startsWith('sup_cj')
          ? 'cj'
          : supId.startsWith('sup_pl')
              ? 'local'
              : supId.startsWith('sup_api2c')
                  ? 'api2cart'
                  : 'api2cart';
      final country = supId.startsWith('sup_cj')
          ? 'CN'
          : supId.startsWith('sup_pl')
              ? 'PL'
              : supId.startsWith('sup_api2c')
                  ? 'DE'
                  : 'TR';
      final days = country == 'PL'
          ? 2
          : country == 'DE'
              ? 5
              : country == 'CN'
                  ? 14
                  : 10;
      p.add(Product(
        id: 'prod_$srcId',
        sourceId: srcId,
        sourcePlatformId: platform,
        title: title,
        basePrice: price,
        shippingCost: ship,
        supplierId: supId,
        supplierCountry: country,
        estimatedDays: days,
        variants: [
          ProductVariant(
            id: 'var_$srcId',
            productId: 'prod_$srcId',
            attributes: const {},
            price: price,
            stock: 50,
          ),
        ],
      ));
    }
    return p;
  }

  static List<SupplierOffer> get offers {
    return products
        .map((p) => SupplierOffer(
              id: 'offer_${p.sourceId}',
              productId: p.id,
              supplierId: p.supplierId ?? '',
              sourcePlatformId: p.sourcePlatformId,
              cost: p.basePrice,
              shippingCost: p.shippingCost,
              minEstimatedDays: (p.estimatedDays ?? 7) ~/ 2,
              maxEstimatedDays: p.estimatedDays,
              carrierCode: p.supplierCountry == 'PL' ? 'INPOST' : 'DHL',
              shippingMethodName: p.supplierCountry == 'PL' ? 'InPost Paczkomaty' : 'DHL Express',
              lastPriceRefreshAt: now,
              lastStockRefreshAt: now,
            ))
        .toList();
  }

  static List<Listing> get listings {
    final l = <Listing>[];
    final prods = products;
    for (var i = 0; i < prods.length; i++) {
      final p = prods[i];
      final cost = p.basePrice + (p.shippingCost ?? 0);
      final selling = cost * 1.30 / 0.90;
      final status = i < 12
          ? ListingStatus.active
          : i < 15
              ? ListingStatus.pendingApproval
              : ListingStatus.draft;
      final target = i % 3 == 0 ? 'temu' : 'allegro';
      l.add(Listing(
        id: 'listing_${p.sourceId}',
        productId: p.id,
        targetPlatformId: target,
        targetListingId: status == ListingStatus.active ? 'ext_${p.sourceId}' : null,
        status: status,
        sellingPrice: double.parse(selling.toStringAsFixed(2)),
        sourceCost: cost,
        promisedMinDays: (p.estimatedDays ?? 7) ~/ 2 + 1,
        promisedMaxDays: (p.estimatedDays ?? 14) + 1,
        createdAt: _daysAgo(30 - i),
        publishedAt: status == ListingStatus.active ? _daysAgo(28 - i) : null,
      ));
    }
    return l;
  }

  static List<Order> get orders {
    final o = <Order>[];
    final activeListings = listings.where((l) => l.status == ListingStatus.active).toList();
    final statuses = [
      OrderStatus.shipped,
      OrderStatus.shipped,
      OrderStatus.shipped,
      OrderStatus.delivered,
      OrderStatus.delivered,
      OrderStatus.pending,
      OrderStatus.pending,
      OrderStatus.sourceOrderPlaced,
      OrderStatus.pendingApproval,
      OrderStatus.failed,
    ];
    final names = [
      'Jan Kowalski',
      'Anna Nowak',
      'Piotr Wiśniewski',
      'Maria Zielińska',
      'Tomasz Lewandowski',
      'Katarzyna Wójcik',
      'Michał Kamiński',
      'Agnieszka Szymańska',
      'Andrzej Woźniak',
      'Ewa Dąbrowska',
    ];
    final cities = [
      'Warszawa',
      'Kraków',
      'Wrocław',
      'Poznań',
      'Gdańsk',
      'Łódź',
      'Katowice',
      'Lublin',
      'Szczecin',
      'Bydgoszcz',
    ];

    for (var i = 0; i < 30 && i < activeListings.length * 3; i++) {
      final listing = activeListings[i % activeListings.length];
      final status = statuses[i % statuses.length];
      final dayOffset = (30 - i).clamp(0, 29);
      o.add(Order(
        id: 'order_${i + 1}',
        listingId: listing.id,
        targetOrderId: '${listing.targetPlatformId}_checkout_${1000 + i}',
        targetPlatformId: listing.targetPlatformId,
        customerAddress: CustomerAddress(
          name: names[i % names.length],
          street: 'ul. Testowa ${i + 1}',
          city: cities[i % cities.length],
          zip: '${(i * 11 + 10).toString().padLeft(2, '0')}-${(i * 7 + 100).toString().padLeft(3, '0')}',
          countryCode: 'PL',
          phone: '+4812345${i.toString().padLeft(4, '0')}',
          email: '${names[i % names.length].toLowerCase().replaceAll(' ', '.')}@example.pl',
        ),
        status: status,
        sourceCost: listing.sourceCost,
        sellingPrice: listing.sellingPrice,
        trackingNumber: status == OrderStatus.shipped || status == OrderStatus.delivered
            ? 'PL${(100000 + i * 111)}'
            : null,
        createdAt: _daysAgo(dayOffset),
        approvedAt: status != OrderStatus.pendingApproval ? _daysAgo(dayOffset) : null,
      ));
    }
    return o;
  }

  static List<ReturnRequest> get returns {
    final shipped = orders
        .where((o) => o.status == OrderStatus.shipped || o.status == OrderStatus.delivered)
        .toList();
    final r = <ReturnRequest>[];
    for (var i = 0; i < 5 && i < shipped.length; i++) {
      final o = shipped[i];
      final reasons = [
        ReturnReason.noReason,
        ReturnReason.defective,
        ReturnReason.wrongItem,
        ReturnReason.damagedInTransit,
        ReturnReason.noReason,
      ];
      final returnStatuses = [
        ReturnStatus.requested,
        ReturnStatus.approved,
        ReturnStatus.refunded,
        ReturnStatus.shipped,
        ReturnStatus.requested,
      ];
      r.add(ReturnRequest(
        id: 'ret_${i + 1}',
        orderId: o.id,
        reason: reasons[i],
        status: returnStatuses[i],
        refundAmount: o.sellingPrice,
        returnShippingCost: 25.0,
        restockingFee: 0,
        requestedAt: _daysAgo(i * 2),
      ));
    }
    return r;
  }

  static List<DecisionLog> get decisionLogs {
    return listings
        .map((l) => DecisionLog(
              id: 'log_${l.id}',
              type: DecisionLogType.listing,
              entityId: l.id,
              reason:
                  'Profit margin ${((l.sellingPrice - l.sourceCost) / l.sellingPrice * 100).toStringAsFixed(1)}% >= ${rules.minProfitPercent}%',
              criteriaSnapshot: {
                'sourceCost': l.sourceCost,
                'sellingPrice': l.sellingPrice,
              },
              createdAt: l.createdAt ?? now,
            ))
        .toList();
  }

  static List<MarketplaceAccount> get accounts => [
    MarketplaceAccount(id: 'mkt_allegro_1', platformId: 'allegro', displayName: 'Jurasic Store PL', isActive: true, connectedAt: _daysAgo(60)),
    MarketplaceAccount(id: 'mkt_temu_1', platformId: 'temu', displayName: 'Jurasic Temu', isActive: true, connectedAt: _daysAgo(30)),
  ];
}
