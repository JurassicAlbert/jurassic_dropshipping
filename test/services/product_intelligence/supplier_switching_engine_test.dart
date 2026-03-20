import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/product_group_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_reliability_score_repository.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/supplier_switching_engine.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:drift/drift.dart' as drift;
import 'package:jurassic_dropshipping/services/product_intelligence/product_intelligence_service.dart';
import 'package:jurassic_dropshipping/domain/observability/observability_metrics.dart';

void main() {
  setUp(() {
    // Silence drift multi-db warning in unit tests.
    drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  test('chooses alternative product within group and logs switch event', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final productRepo = ProductRepository(db);
    final groupRepo = ProductGroupRepository(db);
    final offerRepo = SupplierOfferRepository(db);
    final relRepo = SupplierReliabilityScoreRepository(db);

    // Seed intelligence state with groupId for current product.
    await db.into(db.productIntelligenceStates).insert(
          ProductIntelligenceStatesCompanion.insert(
            tenantId: const drift.Value(1),
            productId: 'p1',
            contentHash: 'h1',
            groupId: const drift.Value('g1'),
            lastProcessedAt: DateTime.now(),
          ),
        );

    // Seed group members.
    await db.into(db.productGroupMembers).insert(
          ProductGroupMembersCompanion.insert(
            tenantId: const drift.Value(1),
            groupId: 'g1',
            productId: 'p1',
            confidence: const drift.Value(1.0),
            matchedBy: const drift.Value('ean'),
            createdAt: DateTime.now(),
          ),
        );
    await db.into(db.productGroupMembers).insert(
          ProductGroupMembersCompanion.insert(
            tenantId: const drift.Value(1),
            groupId: 'g1',
            productId: 'p2',
            confidence: const drift.Value(0.9),
            matchedBy: const drift.Value('sku'),
            createdAt: DateTime.now(),
          ),
        );

    // Seed products + offers.
    await productRepo.upsert(Product(
      id: 'p1',
      sourceId: 's1',
      sourcePlatformId: 'cj',
      title: 'A',
      basePrice: 10,
      variants: const [ProductVariant(id: 'v1', productId: 'p1', attributes: {}, price: 10, stock: 1)],
      supplierId: 'supA',
    ));
    await productRepo.upsert(Product(
      id: 'p2',
      sourceId: 's2',
      sourcePlatformId: 'cj',
      title: 'B',
      basePrice: 9,
      variants: const [ProductVariant(id: 'v2', productId: 'p2', attributes: {}, price: 9, stock: 5)],
      supplierId: 'supB',
    ));
    await offerRepo.upsert(const SupplierOffer(
      id: 'o2',
      productId: 'p2',
      supplierId: 'supB',
      sourcePlatformId: 'cj',
      cost: 9,
    ));
    await relRepo.upsert('supB', 80, '{}');

    final engine = SupplierSwitchingEngine(
      db: db,
      productGroupRepository: groupRepo,
      productRepository: productRepo,
      supplierOfferRepository: offerRepo,
      supplierReliabilityScoreRepository: relRepo,
    );

    final d = await engine.chooseAlternativeForOutOfStock(
      currentProductId: 'p1',
      listingId: 'l1',
      quantity: 1,
    );

    expect(d, isA<SupplierSwitchDecision>());
    expect(d!.toProductId, 'p2');
    final events = await (db.select(db.supplierSwitchEvents)..where((t) => t.groupId.equals('g1'))).get();
    expect(events.length, 1);
    expect(events.first.toSupplierId, 'supB');
  });

  test('intelligence sets competitionLevel based on offers', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final productRepo = ProductRepository(db);
    final groupRepo = ProductGroupRepository(db);
    final offerRepo = SupplierOfferRepository(db);

    await productRepo.upsert(Product(
      id: 'p1',
      sourceId: 's1',
      sourcePlatformId: 'cj',
      title: 'A',
      basePrice: 10,
      variants: const [ProductVariant(id: 'v1', productId: 'p1', attributes: {}, price: 10, stock: 1)],
      rawJson: {'ean': '5901234123457'},
    ));
    await offerRepo.upsert(const SupplierOffer(id: 'o1', productId: 'p1', supplierId: 'sA', sourcePlatformId: 'cj', cost: 10));
    await offerRepo.upsert(const SupplierOffer(id: 'o2', productId: 'p1', supplierId: 'sB', sourcePlatformId: 'cj', cost: 11));

    final intel = ProductIntelligenceService(
      db: db,
      productRepository: productRepo,
      productGroupRepository: groupRepo,
      supplierOfferRepository: offerRepo,
      observabilityMetrics: ObservabilityMetrics(),
    );

    await intel.processBatch(limit: 50);
    final row = await (db.select(db.productIntelligenceStates)..where((t) => t.productId.equals('p1'))).getSingle();
    expect(row.competitionLevel, isNotNull);
  });
}

