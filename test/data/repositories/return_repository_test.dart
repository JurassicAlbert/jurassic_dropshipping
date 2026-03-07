import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';

import '../../fixtures/test_database.dart';
import '../../fixtures/test_fixtures.dart';

void main() {
  late AppDatabase db;
  late ReturnRepository repo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    repo = ReturnRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ReturnRepository', () {
    test('insert and getAll', () async {
      final ret = Fixtures.returnRequest(id: 'ret_1', orderId: 'order_1');
      await repo.insert(ret);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, 'ret_1');
      expect(all.first.orderId, 'order_1');
      expect(all.first.reason, ReturnReason.noReason);
      expect(all.first.status, ReturnStatus.requested);
    });

    test('getByOrderId returns returns for specific order', () async {
      final r1 = Fixtures.returnRequest(id: 'ret_a', orderId: 'order_1');
      final r2 = Fixtures.returnRequest(id: 'ret_b', orderId: 'order_2');
      final r3 = Fixtures.returnRequest(id: 'ret_c', orderId: 'order_1');
      await repo.insert(r1);
      await repo.insert(r2);
      await repo.insert(r3);

      final result = await repo.getByOrderId('order_1');
      expect(result, hasLength(2));
      expect(result.map((r) => r.id).toSet(), {'ret_a', 'ret_c'});
    });

    test('getByOrderId returns empty list for unknown order', () async {
      final result = await repo.getByOrderId('unknown');
      expect(result, isEmpty);
    });

    test('updateStatus changes return status', () async {
      final ret = Fixtures.returnRequest(id: 'ret_upd');
      await repo.insert(ret);

      final resolvedAt = DateTime(2025, 6, 15);
      await repo.updateStatus('ret_upd', ReturnStatus.refunded,
          refundAmount: 89.90, resolvedAt: resolvedAt);

      final all = await repo.getAll();
      expect(all.first.status, ReturnStatus.refunded);
      expect(all.first.refundAmount, 89.90);
      expect(all.first.resolvedAt, resolvedAt);
    });

    test('updateStatus without optional parameters only changes status', () async {
      final ret = Fixtures.returnRequest(id: 'ret_stat');
      await repo.insert(ret);

      await repo.updateStatus('ret_stat', ReturnStatus.approved);

      final all = await repo.getAll();
      expect(all.first.status, ReturnStatus.approved);
    });

    test('getAll returns multiple returns', () async {
      final r1 = Fixtures.returnRequest(id: 'ret_1', orderId: 'order_1');
      final r2 = Fixtures.returnRequest(id: 'ret_2', orderId: 'order_2');
      await repo.insert(r1);
      await repo.insert(r2);

      final all = await repo.getAll();
      expect(all, hasLength(2));
      final ids = all.map((r) => r.id).toSet();
      expect(ids, {'ret_1', 'ret_2'});
    });

    test('getAll returns empty list when no returns', () async {
      final all = await repo.getAll();
      expect(all, isEmpty);
    });

    test('insert preserves all fields', () async {
      final ret = Fixtures.returnRequest(
        id: 'ret_full',
        orderId: 'order_99',
        reason: ReturnReason.defective,
        status: ReturnStatus.approved,
        refundAmount: 150.0,
        returnShippingCost: 20.0,
        restockingFee: 5.0,
      );
      await repo.insert(ret);

      final all = await repo.getAll();
      final found = all.first;
      expect(found.id, 'ret_full');
      expect(found.reason, ReturnReason.defective);
      expect(found.status, ReturnStatus.approved);
      expect(found.refundAmount, 150.0);
      expect(found.returnShippingCost, 20.0);
      expect(found.restockingFee, 5.0);
    });
  });
}
