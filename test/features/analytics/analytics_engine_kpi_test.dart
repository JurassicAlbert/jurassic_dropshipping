import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/domain/listing_health/listing_health_metrics.dart';
import 'package:jurassic_dropshipping/features/analytics/analytics_engine.dart';
import 'package:flutter_test/flutter_test.dart';

Order _o({
  required String listingId,
  double? risk,
  OrderStatus status = OrderStatus.shipped,
  double selling = 100,
  double cost = 60,
}) {
  return Order(
    id: 'o_${listingId}_${risk ?? 0}',
    listingId: listingId,
    targetOrderId: 't_${listingId}',
    targetPlatformId: 'allegro',
    customerAddress: const CustomerAddress(
      name: 'n',
      street: 's',
      zip: '00-000',
      countryCode: 'PL',
      phone: '1',
    ),
    status: status,
    sourceCost: cost,
    sellingPrice: selling,
    createdAt: DateTime.now(),
    deliveredAt: DateTime.now().add(const Duration(days: 2)),
    riskScore: risk,
  );
}

void main() {
  test('lowMarginHighRiskCount counts orders with risk>50 and margin<15%', () {
    final orders = <Order>[
      _o(listingId: 'a', risk: 60, selling: 100, cost: 90),
      _o(listingId: 'b', risk: 40, selling: 100, cost: 90),
      _o(listingId: 'c', risk: 80, selling: 100, cost: 80),
    ];
    final engine = AnalyticsEngine(
      orders: orders,
      listings: const [],
      returns: const [],
      suppliers: const [],
    );
    expect(engine.lowMarginHighRiskCount, 1);
  });

  test('listingHealthHistogram buckets returnOrIncidentCount', () {
    final records = [
      ListingHealthRecord(
        id: 1,
        listingId: 'l1',
        totalOrders: 5,
        cancelledCount: 0,
        lateCount: 0,
        returnOrIncidentCount: 0,
        lastEvaluatedAt: DateTime.now(),
      ),
      ListingHealthRecord(
        id: 2,
        listingId: 'l2',
        totalOrders: 3,
        cancelledCount: 0,
        lateCount: 0,
        returnOrIncidentCount: 1,
        lastEvaluatedAt: DateTime.now(),
      ),
      ListingHealthRecord(
        id: 3,
        listingId: 'l3',
        totalOrders: 2,
        cancelledCount: 0,
        lateCount: 0,
        returnOrIncidentCount: 3,
        lastEvaluatedAt: DateTime.now(),
      ),
    ];
    final engine = AnalyticsEngine(orders: const [], listings: const [], returns: const [], suppliers: const []);
    final h = engine.listingHealthHistogram(records);
    expect(h[0]['count'], 1);
    expect(h[1]['count'], 1);
    expect(h[2]['count'], 1);
  });

  test('failedOrderRate30d respects window', () {
    final old = Order(
      id: 'old_fail',
      listingId: 'x',
      targetOrderId: 't_old',
      targetPlatformId: 'allegro',
      customerAddress: const CustomerAddress(
        name: 'n',
        street: 's',
        zip: '00-000',
        countryCode: 'PL',
        phone: '1',
      ),
      status: OrderStatus.failed,
      sourceCost: 50,
      sellingPrice: 100,
      createdAt: DateTime.now().subtract(const Duration(days: 40)),
      riskScore: 10,
    );
    final engine = AnalyticsEngine(
      orders: [old],
      listings: const [],
      returns: const [],
      suppliers: const [],
    );
    final r = engine.failedOrderRate30d();
    expect(r['total'], 0);
  });
}
