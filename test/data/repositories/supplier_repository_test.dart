import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_repository.dart';

import '../../fixtures/test_database.dart';
import '../../fixtures/test_fixtures.dart';

void main() {
  late AppDatabase db;
  late SupplierRepository repo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    repo = SupplierRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SupplierRepository', () {
    test('upsert inserts new supplier and getAll retrieves it', () async {
      final supplier = Fixtures.supplier(id: 'sup_1');
      await repo.upsert(supplier);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, 'sup_1');
      expect(all.first.name, supplier.name);
      expect(all.first.platformType, supplier.platformType);
    });

    test('upsert updates existing supplier', () async {
      final original = Fixtures.supplier(id: 'sup_u', name: 'Original Name', rating: 3.0);
      await repo.upsert(original);

      final updated = Fixtures.supplier(id: 'sup_u', name: 'Updated Name', rating: 4.9);
      await repo.upsert(updated);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.name, 'Updated Name');
      expect(all.first.rating, 4.9);
    });

    test('getById returns correct supplier', () async {
      final s1 = Fixtures.supplier(id: 'sup_a');
      final s2 = Fixtures.supplierPL(id: 'sup_b');
      await repo.upsert(s1);
      await repo.upsert(s2);

      final found = await repo.getById('sup_b');
      expect(found, isNotNull);
      expect(found!.name, 'Polish Warehouse');
      expect(found.countryCode, 'PL');
    });

    test('getById returns null for non-existent id', () async {
      final found = await repo.getById('nonexistent');
      expect(found, isNull);
    });

    test('delete removes the supplier', () async {
      final supplier = Fixtures.supplier(id: 'sup_del');
      await repo.upsert(supplier);
      expect(await repo.getAll(), hasLength(1));

      await repo.delete('sup_del');
      expect(await repo.getAll(), isEmpty);
    });

    test('delete does not throw for non-existent id', () async {
      await repo.delete('nonexistent');
      expect(await repo.getAll(), isEmpty);
    });

    test('getAll returns all suppliers', () async {
      await repo.upsert(Fixtures.supplier(id: 'sup_1'));
      await repo.upsert(Fixtures.supplierPL(id: 'sup_2'));
      await repo.upsert(Fixtures.supplierNoReturns(id: 'sup_3'));

      final all = await repo.getAll();
      expect(all, hasLength(3));
    });

    test('getAll returns empty list when no suppliers', () async {
      final all = await repo.getAll();
      expect(all, isEmpty);
    });

    test('upsert preserves return policy fields', () async {
      final supplier = Fixtures.supplier(
        id: 'sup_ret',
        returnWindowDays: 30,
        returnShippingCost: 15.0,
        restockingFeePercent: 10.0,
        acceptsNoReasonReturns: true,
      );
      await repo.upsert(supplier);

      final found = await repo.getById('sup_ret');
      expect(found!.returnWindowDays, 30);
      expect(found.returnShippingCost, 15.0);
      expect(found.restockingFeePercent, 10.0);
      expect(found.acceptsNoReasonReturns, true);
    });
  });
}
