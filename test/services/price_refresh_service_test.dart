import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/services/price_refresh_service.dart';

import '../fixtures/test_database.dart';
import '../fixtures/test_fixtures.dart';
import '../mocks/mock_source_platform.dart';

void main() {
  late AppDatabase db;
  late SupplierOfferRepository offerRepo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    offerRepo = SupplierOfferRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('PriceRefreshService', () {
    test('refreshes stale offers from matching source platform', () async {
      final staleOffer = Fixtures.supplierOffer(
        id: 'off_stale',
        productId: 'prod_1',
        supplierId: 'sup_1',
        sourcePlatformId: 'mock_source',
        cost: 30.0,
        shippingCost: 5.0,
      ).copyWith(
        lastPriceRefreshAt: DateTime.now().subtract(const Duration(hours: 12)),
      );
      await offerRepo.upsert(staleOffer);

      final updatedProduct = Fixtures.product(
        id: 'prod_1',
        sourceId: 'prod_1',
        sourcePlatformId: 'mock_source',
        basePrice: 35.0,
        shippingCost: 6.0,
      );

      final mockSource = MockSourcePlatform(
        mockId: 'mock_source',
        products: [updatedProduct],
      );

      final service = PriceRefreshService(
        supplierOfferRepository: offerRepo,
        sources: [mockSource],
      );

      final refreshed = await service.refreshStaleOffers(
        staleDuration: const Duration(hours: 6),
      );

      expect(refreshed, ['prod_1']);

      final updated = await offerRepo.getById('off_stale');
      expect(updated, isNotNull);
      expect(updated!.cost, 35.0);
      expect(updated.shippingCost, 6.0);
    });

    test('skips offers with no matching source platform', () async {
      final staleOffer = Fixtures.supplierOffer(
        id: 'off_no_source',
        sourcePlatformId: 'unknown_platform',
        cost: 20.0,
      ).copyWith(
        lastPriceRefreshAt: DateTime.now().subtract(const Duration(hours: 12)),
      );
      await offerRepo.upsert(staleOffer);

      final service = PriceRefreshService(
        supplierOfferRepository: offerRepo,
        sources: [MockSourcePlatform(mockId: 'mock_source')],
      );

      final refreshed = await service.refreshStaleOffers(
        staleDuration: const Duration(hours: 6),
      );

      expect(refreshed, isEmpty);
    });

    test('returns 0 when no stale offers exist', () async {
      final freshOffer = Fixtures.supplierOffer(id: 'off_fresh');
      await offerRepo.upsert(freshOffer);

      final service = PriceRefreshService(
        supplierOfferRepository: offerRepo,
        sources: [MockSourcePlatform()],
      );

      final refreshed = await service.refreshStaleOffers(
        staleDuration: const Duration(hours: 6),
      );

      expect(refreshed, isEmpty);
    });

    test('skips offer when source returns null product', () async {
      final staleOffer = Fixtures.supplierOffer(
        id: 'off_null_prod',
        productId: 'unknown_product',
        sourcePlatformId: 'mock_source',
      ).copyWith(
        lastPriceRefreshAt: DateTime.now().subtract(const Duration(hours: 12)),
      );
      await offerRepo.upsert(staleOffer);

      final service = PriceRefreshService(
        supplierOfferRepository: offerRepo,
        sources: [MockSourcePlatform(mockId: 'mock_source', products: [])],
      );

      final refreshed = await service.refreshStaleOffers(
        staleDuration: const Duration(hours: 6),
      );

      expect(refreshed, isEmpty);
    });

    test('refreshes multiple stale offers', () async {
      final stale1 = Fixtures.supplierOffer(
        id: 'off_s1',
        productId: 'prod_a',
        sourcePlatformId: 'mock_source',
        cost: 10.0,
      ).copyWith(
        lastPriceRefreshAt: DateTime.now().subtract(const Duration(hours: 24)),
      );
      final stale2 = Fixtures.supplierOffer(
        id: 'off_s2',
        productId: 'prod_b',
        sourcePlatformId: 'mock_source',
        cost: 20.0,
      ).copyWith(
        lastPriceRefreshAt: DateTime.now().subtract(const Duration(hours: 24)),
      );
      await offerRepo.upsert(stale1);
      await offerRepo.upsert(stale2);

      final products = [
        Fixtures.product(id: 'prod_a', sourceId: 'prod_a', basePrice: 12.0),
        Fixtures.product(id: 'prod_b', sourceId: 'prod_b', basePrice: 22.0),
      ];

      final service = PriceRefreshService(
        supplierOfferRepository: offerRepo,
        sources: [MockSourcePlatform(mockId: 'mock_source', products: products)],
      );

      final refreshed = await service.refreshStaleOffers(
        staleDuration: const Duration(hours: 6),
      );

      expect(refreshed, containsAll(<String>['prod_a', 'prod_b']));
      expect(refreshed.length, 2);
    });
  });
}
