import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';

import '../../fixtures/test_database.dart';
import '../../fixtures/test_fixtures.dart';

void main() {
  late AppDatabase db;
  late OrderRepository repo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    repo = OrderRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('OrderRepository', () {
    test('insert and getAll', () async {
      final order = Fixtures.order(id: 'ord_1');
      await repo.insert(order);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, 'ord_1');
      expect(all.first.sellingPrice, order.sellingPrice);
      expect(all.first.sourceCost, order.sourceCost);
      expect(all.first.customerAddress.name, 'Jan Kowalski');
    });

    test('getByLocalId returns correct order', () async {
      final o1 = Fixtures.order(id: 'ord_a');
      final o2 = Fixtures.order(id: 'ord_b', sellingPrice: 200.0);
      await repo.insert(o1);
      await repo.insert(o2);

      final found = await repo.getByLocalId('ord_b');
      expect(found, isNotNull);
      expect(found!.sellingPrice, 200.0);
    });

    test('getByLocalId returns null for non-existent id', () async {
      final found = await repo.getByLocalId('nonexistent');
      expect(found, isNull);
    });

    test('getByStatus filters correctly', () async {
      final pending = Fixtures.order(id: 'ord_p', status: OrderStatus.pending);
      final shipped = Fixtures.shippedOrder(id: 'ord_s');
      final failed = Fixtures.failedOrder(id: 'ord_f');
      await repo.insert(pending);
      await repo.insert(shipped);
      await repo.insert(failed);

      final pendingOrders = await repo.getByStatus(OrderStatus.pending);
      expect(pendingOrders, hasLength(1));
      expect(pendingOrders.first.id, 'ord_p');

      final shippedOrders = await repo.getByStatus(OrderStatus.shipped);
      expect(shippedOrders, hasLength(1));
      expect(shippedOrders.first.id, 'ord_s');
    });

    test('getPendingApproval returns only pendingApproval orders', () async {
      final pending = Fixtures.order(id: 'ord_pa1', status: OrderStatus.pendingApproval);
      final regular = Fixtures.order(id: 'ord_reg', status: OrderStatus.pending);
      await repo.insert(pending);
      await repo.insert(regular);

      final result = await repo.getPendingApproval();
      expect(result, hasLength(1));
      expect(result.first.id, 'ord_pa1');
    });

    test('updateStatus changes order status', () async {
      final order = Fixtures.order(id: 'ord_upd', status: OrderStatus.pending);
      await repo.insert(order);

      final now = DateTime.now();
      await repo.updateStatus('ord_upd', OrderStatus.sourceOrderPlaced,
          sourceOrderId: 'src_ord_123', approvedAt: now);

      final updated = await repo.getByLocalId('ord_upd');
      expect(updated, isNotNull);
      expect(updated!.status, OrderStatus.sourceOrderPlaced);
      expect(updated.sourceOrderId, 'src_ord_123');
    });

    test('updateStatus with tracking number', () async {
      final order = Fixtures.order(id: 'ord_trk', status: OrderStatus.sourceOrderPlaced);
      await repo.insert(order);

      await repo.updateStatus('ord_trk', OrderStatus.shipped,
          trackingNumber: 'PL999888777');

      final updated = await repo.getByLocalId('ord_trk');
      expect(updated!.status, OrderStatus.shipped);
      expect(updated.trackingNumber, 'PL999888777');
    });

    test('getAll returns orders ordered by createdAt descending', () async {
      final old = Fixtures.order(id: 'ord_old', createdAt: DateTime(2024, 1, 1));
      final recent = Fixtures.order(id: 'ord_new', createdAt: DateTime(2025, 6, 1));
      await repo.insert(old);
      await repo.insert(recent);

      final all = await repo.getAll();
      expect(all.first.id, 'ord_new');
      expect(all.last.id, 'ord_old');
    });

    test('getAll returns empty list when no orders', () async {
      final all = await repo.getAll();
      expect(all, isEmpty);
    });

    test('customer address is persisted correctly', () async {
      final addr = Fixtures.address(
        name: 'Anna Nowak',
        street: 'ul. Dluga 5',
        city: 'Krakow',
        zip: '30-001',
        countryCode: 'PL',
        phone: '+48987654321',
        email: 'anna@example.pl',
      );
      final order = Fixtures.order(id: 'ord_addr', customerAddress: addr);
      await repo.insert(order);

      final found = await repo.getByLocalId('ord_addr');
      expect(found!.customerAddress.name, 'Anna Nowak');
      expect(found.customerAddress.city, 'Krakow');
      expect(found.customerAddress.email, 'anna@example.pl');
    });
  });
}
