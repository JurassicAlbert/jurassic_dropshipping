import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_repository.dart';
import 'package:jurassic_dropshipping/services/seed_service.dart';
import '../fixtures/test_database.dart';

_Setup _create() {
  final db = createTestDatabase();
  return _Setup(
    db: db,
    seed: SeedService(
      db: db,
      productRepository: ProductRepository(db),
      listingRepository: ListingRepository(db),
      orderRepository: OrderRepository(db),
      supplierRepository: SupplierRepository(db),
      supplierOfferRepository: SupplierOfferRepository(db),
      returnRepository: ReturnRepository(db),
      decisionLogRepository: DecisionLogRepository(db),
      rulesRepository: RulesRepository(db),
    ),
    products: ProductRepository(db),
    listings: ListingRepository(db),
    orders: OrderRepository(db),
    suppliers: SupplierRepository(db),
    offers: SupplierOfferRepository(db),
    returns: ReturnRepository(db),
    logs: DecisionLogRepository(db),
  );
}

void main() {
  group('SeedService', () {
    test('seedAll populates all tables', () async {
      final s = _create();
      final result = await s.seed.seedAll();

      expect(result.suppliers, greaterThan(0));
      expect(result.products, greaterThan(0));
      expect(result.offers, greaterThan(0));
      expect(result.listings, greaterThan(0));
      expect(result.orders, greaterThan(0));
      expect(result.total, greaterThan(50));

      expect(await s.products.getAll(), hasLength(result.products));
      expect(await s.suppliers.getAll(), hasLength(result.suppliers));
      expect(await s.orders.getAll(), hasLength(result.orders));
      expect(await s.listings.getAll(), hasLength(result.listings));

      await s.db.close();
    });

    test('dropAll clears all tables', () async {
      final s = _create();
      await s.seed.seedAll();
      expect(await s.orders.getAll(), isNotEmpty);

      await s.seed.dropAll();

      expect(await s.products.getAll(), isEmpty);
      expect(await s.suppliers.getAll(), isEmpty);
      expect(await s.offers.getAll(), isEmpty);
      expect(await s.listings.getAll(), isEmpty);
      expect(await s.orders.getAll(), isEmpty);
      expect(await s.returns.getAll(), isEmpty);
      expect(await s.logs.getAll(), isEmpty);

      await s.db.close();
    });

    test('re-seed after drop works', () async {
      final s = _create();
      await s.seed.seedAll();
      await s.seed.dropAll();
      final result = await s.seed.seedAll();

      expect(result.total, greaterThan(50));
      expect(await s.orders.getAll(), hasLength(result.orders));

      await s.db.close();
    });

    test('seeded orders span multiple days', () async {
      final s = _create();
      await s.seed.seedAll();

      final orders = await s.orders.getAll();
      final days = orders
          .where((o) => o.createdAt != null)
          .map((o) => DateTime(o.createdAt!.year, o.createdAt!.month, o.createdAt!.day))
          .toSet();
      expect(days.length, greaterThan(15));

      await s.db.close();
    });

    test('seeded data has multiple suppliers and platforms', () async {
      final s = _create();
      await s.seed.seedAll();

      final suppliers = await s.suppliers.getAll();
      final countries = suppliers.map((sup) => sup.countryCode).toSet();
      expect(countries.length, greaterThan(2));

      final listings = await s.listings.getAll();
      final platforms = listings.map((l) => l.targetPlatformId).toSet();
      expect(platforms, contains('allegro'));

      await s.db.close();
    });
  });
}

class _Setup {
  _Setup({
    required this.db,
    required this.seed,
    required this.products,
    required this.listings,
    required this.orders,
    required this.suppliers,
    required this.offers,
    required this.returns,
    required this.logs,
  });
  final AppDatabase db;
  final SeedService seed;
  final ProductRepository products;
  final ListingRepository listings;
  final OrderRepository orders;
  final SupplierRepository suppliers;
  final SupplierOfferRepository offers;
  final ReturnRepository returns;
  final DecisionLogRepository logs;
}
