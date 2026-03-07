import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';

import '../../fixtures/test_database.dart';
import '../../fixtures/test_fixtures.dart';

void main() {
  late AppDatabase db;
  late ProductRepository repo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    repo = ProductRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ProductRepository', () {
    test('upsert inserts a new product and getAll retrieves it', () async {
      final product = Fixtures.product(id: 'prod_1');
      await repo.upsert(product);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, 'prod_1');
      expect(all.first.title, product.title);
      expect(all.first.basePrice, product.basePrice);
      expect(all.first.shippingCost, product.shippingCost);
      expect(all.first.currency, product.currency);
    });

    test('getByLocalId returns the correct product', () async {
      final p1 = Fixtures.product(id: 'prod_a');
      final p2 = Fixtures.product(id: 'prod_b', title: 'Second Product');
      await repo.upsert(p1);
      await repo.upsert(p2);

      final found = await repo.getByLocalId('prod_b');
      expect(found, isNotNull);
      expect(found!.title, 'Second Product');
    });

    test('getByLocalId returns null for non-existent id', () async {
      final found = await repo.getByLocalId('does_not_exist');
      expect(found, isNull);
    });

    test('getBySourceId returns matching product', () async {
      final product = Fixtures.product(
        id: 'prod_src',
        sourceId: 'src_abc',
        sourcePlatformId: 'cj',
      );
      await repo.upsert(product);

      final found = await repo.getBySourceId('cj', 'src_abc');
      expect(found, isNotNull);
      expect(found!.id, 'prod_src');
    });

    test('upsert updates existing product with same localId', () async {
      final original = Fixtures.product(
        id: 'prod_up',
        title: 'Original Title',
        basePrice: 10.0,
      );
      await repo.upsert(original);

      final updated = Fixtures.product(
        id: 'prod_up',
        title: 'Updated Title',
        basePrice: 20.0,
      );
      await repo.upsert(updated);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.title, 'Updated Title');
      expect(all.first.basePrice, 20.0);
    });

    test('getAll returns multiple products', () async {
      final p1 = Fixtures.product(id: 'prod_1');
      final p2 = Fixtures.product(id: 'prod_2');
      await repo.upsert(p1);
      await repo.upsert(p2);

      final all = await repo.getAll();
      expect(all, hasLength(2));
      final ids = all.map((p) => p.id).toSet();
      expect(ids, {'prod_1', 'prod_2'});
    });

    test('getAll returns empty list when no products exist', () async {
      final all = await repo.getAll();
      expect(all, isEmpty);
    });

    test('deleteByLocalId removes the product', () async {
      final product = Fixtures.product(id: 'prod_del');
      await repo.upsert(product);
      expect(await repo.getAll(), hasLength(1));

      await repo.deleteByLocalId('prod_del');
      expect(await repo.getAll(), isEmpty);
    });

    test('persists product variants correctly', () async {
      final product = Fixtures.product(
        id: 'prod_var',
        variants: [
          Fixtures.productVariant(id: 'v1', productId: 'prod_var', price: 10.0, stock: 5),
          Fixtures.productVariant(id: 'v2', productId: 'prod_var', price: 15.0, stock: 3),
        ],
      );
      await repo.upsert(product);

      final found = await repo.getByLocalId('prod_var');
      expect(found, isNotNull);
      expect(found!.variants, hasLength(2));
      expect(found.variants.first.id, 'v1');
      expect(found.variants.last.id, 'v2');
    });
  });
}
