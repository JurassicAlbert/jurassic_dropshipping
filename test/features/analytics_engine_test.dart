import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/features/analytics/analytics_engine.dart';
import '../fixtures/test_fixtures.dart';

void main() {
  setUp(() => Fixtures.reset());

  group('AnalyticsEngine — Summary KPIs', () {
    test('computes total revenue and profit', () {
      final engine = AnalyticsEngine(
        orders: [
          Fixtures.order(sellingPrice: 100, sourceCost: 60),
          Fixtures.order(sellingPrice: 50, sourceCost: 25),
        ],
        listings: [],
        returns: [],
        suppliers: [],
      );
      expect(engine.totalRevenue, 150);
      expect(engine.totalCost, 85);
      expect(engine.totalProfit, 65);
    });

    test('computes profit margin percent', () {
      final engine = AnalyticsEngine(
        orders: [Fixtures.order(sellingPrice: 100, sourceCost: 70)],
        listings: [],
        returns: [],
        suppliers: [],
      );
      expect(engine.profitMarginPercent, closeTo(30.0, 0.1));
    });

    test('returns 0 margin when no orders', () {
      final engine = AnalyticsEngine(orders: [], listings: [], returns: [], suppliers: []);
      expect(engine.profitMarginPercent, 0);
      expect(engine.returnRatePercent, 0);
    });

    test('computes return rate from shipped/delivered orders', () {
      final engine = AnalyticsEngine(
        orders: [
          Fixtures.order(status: OrderStatus.shipped),
          Fixtures.order(status: OrderStatus.shipped),
          Fixtures.order(status: OrderStatus.delivered),
          Fixtures.order(status: OrderStatus.pending),
        ],
        listings: [],
        returns: [Fixtures.returnRequest()],
        suppliers: [],
      );
      // 1 return / 3 shipped+delivered = 33.3%
      expect(engine.returnRatePercent, closeTo(33.3, 0.1));
    });
  });

  group('AnalyticsEngine — By Platform', () {
    test('groups profit by platform', () {
      final engine = AnalyticsEngine(
        orders: [
          Fixtures.order(targetPlatformId: 'allegro', sellingPrice: 100, sourceCost: 60),
          Fixtures.order(targetPlatformId: 'allegro', sellingPrice: 80, sourceCost: 50),
          Fixtures.order(targetPlatformId: 'temu', sellingPrice: 50, sourceCost: 30),
        ],
        listings: [],
        returns: [],
        suppliers: [],
      );
      final byPlatform = engine.profitByPlatform;
      expect(byPlatform['allegro']!.profit, 70);
      expect(byPlatform['allegro']!.orderCount, 2);
      expect(byPlatform['temu']!.profit, 20);
    });
  });

  group('AnalyticsEngine — By Product', () {
    test('returns top products sorted by profit', () {
      final engine = AnalyticsEngine(
        orders: [
          Fixtures.order(listingId: 'A', sellingPrice: 200, sourceCost: 50),
          Fixtures.order(listingId: 'B', sellingPrice: 100, sourceCost: 90),
          Fixtures.order(listingId: 'A', sellingPrice: 200, sourceCost: 50),
        ],
        listings: [],
        returns: [],
        suppliers: [],
      );
      final byProduct = engine.profitByProduct;
      expect(byProduct.first.listingId, 'A');
      expect(byProduct.first.profit, 300); // (200-50)*2
      expect(byProduct[1].listingId, 'B');
      expect(byProduct[1].profit, 10);
    });
  });

  group('AnalyticsEngine — Issues', () {
    test('detects negative profit products', () {
      final engine = AnalyticsEngine(
        orders: [
          Fixtures.order(listingId: 'bad', sellingPrice: 30, sourceCost: 50),
        ],
        listings: [Fixtures.listing(id: 'bad', sellingPrice: 30, sourceCost: 50)],
        returns: [],
        suppliers: [],
      );
      final issues = engine.issues;
      expect(issues.any((i) => i.severity == IssueSeverity.critical && i.title.contains('Negative')), isTrue);
    });

    test('detects failed orders', () {
      final engine = AnalyticsEngine(
        orders: [
          Fixtures.order(status: OrderStatus.failed),
          Fixtures.order(status: OrderStatus.failed),
        ],
        listings: [],
        returns: [],
        suppliers: [],
      );
      final issues = engine.issues;
      expect(issues.any((i) => i.title.contains('failed')), isTrue);
    });

    test('detects low margin listings', () {
      final listing = Fixtures.listing(id: 'low', sellingPrice: 100, sourceCost: 90);
      final engine = AnalyticsEngine(
        orders: [Fixtures.order(listingId: 'low', sellingPrice: 100, sourceCost: 90)],
        listings: [listing],
        returns: [],
        suppliers: [],
      );
      final issues = engine.issues;
      expect(issues.any((i) => i.title.contains('Low margin')), isTrue);
    });

    test('no issues when everything healthy', () {
      final engine = AnalyticsEngine(
        orders: [Fixtures.order(sellingPrice: 100, sourceCost: 40, status: OrderStatus.shipped)],
        listings: [Fixtures.listing(sellingPrice: 100, sourceCost: 40)],
        returns: [],
        suppliers: [],
      );
      expect(engine.issues, isEmpty);
    });
  });

  group('AnalyticsEngine — Returns analysis', () {
    test('computes returns by reason', () {
      final engine = AnalyticsEngine(
        orders: [],
        listings: [],
        returns: [
          Fixtures.returnRequest(reason: ReturnReason.noReason),
          Fixtures.returnRequest(reason: ReturnReason.noReason),
          Fixtures.returnRequest(reason: ReturnReason.defective),
        ],
        suppliers: [],
      );
      expect(engine.returnsByReason[ReturnReason.noReason], 2);
      expect(engine.returnsByReason[ReturnReason.defective], 1);
    });

    test('computes total return cost', () {
      final engine = AnalyticsEngine(
        orders: [],
        listings: [],
        returns: [
          Fixtures.returnRequest(refundAmount: 100, returnShippingCost: 20),
          Fixtures.returnRequest(refundAmount: 50, returnShippingCost: 15),
        ],
        suppliers: [],
      );
      expect(engine.totalReturnCost, 185);
    });
  });

  group('AnalyticsEngine — Daily profit', () {
    test('computes daily profit grouped by date', () {
      final now = DateTime.now();
      final engine = AnalyticsEngine(
        orders: [
          Fixtures.order(sellingPrice: 100, sourceCost: 60, createdAt: now),
          Fixtures.order(sellingPrice: 80, sourceCost: 50, createdAt: now),
          Fixtures.order(sellingPrice: 50, sourceCost: 30, createdAt: now.subtract(const Duration(days: 1))),
        ],
        listings: [],
        returns: [],
        suppliers: [],
      );
      final daily = engine.dailyProfit(days: 7);
      expect(daily.length, 2);
      // Today's profit: (100-60) + (80-50) = 70
      expect(daily.last.profit, 70);
    });
  });
}
