import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/product_group_repository.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/product_matching_engine.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';

void main() {
  setUp(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  test('matches by EAN when available', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final repo = ProductGroupRepository(db);
    final engine = ProductMatchingEngine(groupRepo: repo);

    final p = Product(
      id: 'p1',
      sourceId: 's1',
      sourcePlatformId: 'cj',
      title: 'Test product',
      basePrice: 10,
      rawJson: {'ean': '5901234123457'},
    );

    final r = await engine.matchOne(p, tenantId: 1);
    expect(r.groupId, 'ean_5901234123457');
    expect(r.matchedBy, 'ean');
    expect(r.confidence, 1.0);
  });

  test('matches by SKU when EAN missing', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final repo = ProductGroupRepository(db);
    final engine = ProductMatchingEngine(groupRepo: repo);

    final p = Product(
      id: 'p1',
      sourceId: 's1',
      sourcePlatformId: 'cj',
      title: 'Test product',
      basePrice: 10,
      variants: const [
        ProductVariant(
          id: 'v1',
          productId: 'p1',
          attributes: {'Color': 'Black'},
          price: 10,
          stock: 5,
          sku: 'SKU-123',
        ),
      ],
    );

    final r = await engine.matchOne(p, tenantId: 1);
    expect(r.groupId, startsWith('sku_'));
    expect(r.matchedBy, 'sku');
    expect(r.confidence, greaterThan(0.9));
  });

  test('fallback hash is deterministic for same normalized input', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final repo = ProductGroupRepository(db);
    final engine = ProductMatchingEngine(groupRepo: repo);

    final p1 = Product(
      id: 'p1',
      sourceId: 's1',
      sourcePlatformId: 'cj',
      title: '  TEST Product  ',
      description: 'Desc',
      basePrice: 10,
      imageUrls: const ['b', 'a'],
      variants: const [
        ProductVariant(
          id: 'v1',
          productId: 'p1',
          attributes: {'Size': 'M'},
          price: 10,
          stock: 5,
        ),
      ],
    );
    final p2 = p1.copyWith(id: 'p2', title: 'test product', imageUrls: const ['a', 'b']);

    final r1 = await engine.matchOne(p1, tenantId: 1);
    final r2 = await engine.matchOne(p2, tenantId: 1);
    expect(r1.groupId, r2.groupId);
    expect(r1.matchedBy, 'hash');
  });
}

