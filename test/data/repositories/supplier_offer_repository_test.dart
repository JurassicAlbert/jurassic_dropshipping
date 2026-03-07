import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';

import '../../fixtures/test_database.dart';
import '../../fixtures/test_fixtures.dart';

void main() {
  late AppDatabase db;
  late SupplierOfferRepository repo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    repo = SupplierOfferRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('SupplierOfferRepository', () {
    test('upsert inserts new offer and getAll retrieves it', () async {
      final offer = Fixtures.supplierOffer(id: 'off_1', productId: 'prod_1', supplierId: 'sup_1');
      await repo.upsert(offer);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, 'off_1');
      expect(all.first.cost, offer.cost);
      expect(all.first.shippingCost, offer.shippingCost);
    });

    test('upsert updates existing offer', () async {
      final original = Fixtures.supplierOffer(id: 'off_u', cost: 10.0);
      await repo.upsert(original);

      final updated = original.copyWith(cost: 20.0, shippingCost: 5.0);
      await repo.upsert(updated);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.cost, 20.0);
      expect(all.first.shippingCost, 5.0);
    });

    test('getByProductId returns offers for the given product', () async {
      final o1 = Fixtures.supplierOffer(id: 'off_a', productId: 'prod_1');
      final o2 = Fixtures.supplierOffer(id: 'off_b', productId: 'prod_1');
      final o3 = Fixtures.supplierOffer(id: 'off_c', productId: 'prod_2');
      await repo.upsert(o1);
      await repo.upsert(o2);
      await repo.upsert(o3);

      final result = await repo.getByProductId('prod_1');
      expect(result, hasLength(2));
      expect(result.map((o) => o.id).toSet(), {'off_a', 'off_b'});
    });

    test('getBySupplierId returns offers for the given supplier', () async {
      final o1 = Fixtures.supplierOffer(id: 'off_s1', supplierId: 'sup_a');
      final o2 = Fixtures.supplierOffer(id: 'off_s2', supplierId: 'sup_b');
      final o3 = Fixtures.supplierOffer(id: 'off_s3', supplierId: 'sup_a');
      await repo.upsert(o1);
      await repo.upsert(o2);
      await repo.upsert(o3);

      final result = await repo.getBySupplierId('sup_a');
      expect(result, hasLength(2));
      expect(result.map((o) => o.id).toSet(), {'off_s1', 'off_s3'});
    });

    test('getStaleOffers returns offers with null or old lastPriceRefreshAt', () async {
      final fresh = Fixtures.supplierOffer(id: 'off_fresh');
      await repo.upsert(fresh);

      final stale = Fixtures.supplierOffer(id: 'off_stale').copyWith(
        lastPriceRefreshAt: DateTime.now().subtract(const Duration(hours: 12)),
      );
      await repo.upsert(stale);

      final nullRefresh = Fixtures.supplierOffer(id: 'off_null').copyWith(
        lastPriceRefreshAt: null,
      );
      await repo.upsert(nullRefresh);

      final staleOffers = await repo.getStaleOffers(const Duration(hours: 6));
      expect(staleOffers.length, greaterThanOrEqualTo(2));
      final staleIds = staleOffers.map((o) => o.id).toSet();
      expect(staleIds, contains('off_stale'));
      expect(staleIds, contains('off_null'));
    });

    test('delete removes the offer', () async {
      final offer = Fixtures.supplierOffer(id: 'off_del');
      await repo.upsert(offer);
      expect(await repo.getAll(), hasLength(1));

      await repo.delete('off_del');
      expect(await repo.getAll(), isEmpty);
    });

    test('delete does not throw for non-existent id', () async {
      await repo.delete('nonexistent');
      expect(await repo.getAll(), isEmpty);
    });

    test('getAll returns empty list when no offers', () async {
      final all = await repo.getAll();
      expect(all, isEmpty);
    });

    test('getByProductId returns empty list for unknown product', () async {
      final result = await repo.getByProductId('unknown');
      expect(result, isEmpty);
    });

    test('upsert preserves shipping method fields', () async {
      final offer = Fixtures.supplierOffer(
        id: 'off_ship',
        carrierCode: 'DHL',
        shippingMethodName: 'DHL Express',
        minEstimatedDays: 2,
        maxEstimatedDays: 5,
      );
      await repo.upsert(offer);

      final found = await repo.getById('off_ship');
      expect(found, isNotNull);
      expect(found!.carrierCode, 'DHL');
      expect(found.shippingMethodName, 'DHL Express');
      expect(found.minEstimatedDays, 2);
      expect(found.maxEstimatedDays, 5);
    });
  });
}
