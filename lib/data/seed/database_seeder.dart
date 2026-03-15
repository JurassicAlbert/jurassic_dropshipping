import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/marketplace_account_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_repository.dart';
import 'package:jurassic_dropshipping/data/seed/seed_data.dart';

class DatabaseSeeder {
  DatabaseSeeder({
    required this.db,
    required this.productRepo,
    required this.listingRepo,
    required this.orderRepo,
    required this.supplierRepo,
    required this.supplierOfferRepo,
    required this.returnRepo,
    required this.decisionLogRepo,
    required this.rulesRepo,
    required this.marketplaceAccountRepo,
  });

  final AppDatabase db;
  final ProductRepository productRepo;
  final ListingRepository listingRepo;
  final OrderRepository orderRepo;
  final SupplierRepository supplierRepo;
  final SupplierOfferRepository supplierOfferRepo;
  final ReturnRepository returnRepo;
  final DecisionLogRepository decisionLogRepo;
  final RulesRepository rulesRepo;
  final MarketplaceAccountRepository marketplaceAccountRepo;

  Future<SeedResult> seed() async {
    var count = 0;

    await rulesRepo.save(DemoSeedData.rules);
    count++;

    for (final s in DemoSeedData.suppliers) {
      await supplierRepo.upsert(s);
      count++;
    }
    for (final p in DemoSeedData.products) {
      await productRepo.upsert(p);
      count++;
    }
    for (final o in DemoSeedData.offers) {
      await supplierOfferRepo.upsert(o);
      count++;
    }
    for (final l in DemoSeedData.listings) {
      await listingRepo.insert(l);
      count++;
    }
    for (final o in DemoSeedData.orders) {
      await orderRepo.insert(o);
      count++;
    }
    for (final r in DemoSeedData.returns) {
      await returnRepo.insert(r);
      count++;
    }
    for (final d in DemoSeedData.decisionLogs) {
      await decisionLogRepo.insert(d);
      count++;
    }
    for (final a in DemoSeedData.accounts) {
      await marketplaceAccountRepo.upsert(a);
      count++;
    }

    count += await _seedBillingIfEmpty();

    return SeedResult(entitiesCreated: count);
  }

  /// Phase B5: ensure default billing plans and tenant 1 on free plan. Returns number of entities created.
  Future<int> _seedBillingIfEmpty() async {
    final existing = await db.select(db.billingPlans).get();
    if (existing.isNotEmpty) return 0;
    await db.into(db.billingPlans).insert(BillingPlansCompanion.insert(
      name: 'free',
      maxListings: 10,
      maxOrdersPerMonth: 50,
    ));
    await db.into(db.billingPlans).insert(BillingPlansCompanion.insert(
      name: 'pro',
      maxListings: -1,
      maxOrdersPerMonth: -1,
    ));
    final freePlan = await (db.select(db.billingPlans)..where((t) => t.name.equals('free'))).getSingle();
    final tenantPlan = await (db.select(db.tenantPlans)..where((t) => t.tenantId.equals(1))).getSingleOrNull();
    if (tenantPlan == null) {
      await db.into(db.tenantPlans).insert(TenantPlansCompanion.insert(
        tenantId: Value(1),
        planId: freePlan.id,
      ));
      return 3; // 2 plans + 1 tenant_plan
    }
    return 2; // 2 plans only
  }

  Future<void> dropAll() async {
    await db.delete(db.returns).go();
    await db.delete(db.orders).go();
    await db.delete(db.listings).go();
    await db.delete(db.decisionLogs).go();
    await db.delete(db.supplierOffers).go();
    await db.delete(db.suppliers).go();
    await db.delete(db.products).go();
    await db.delete(db.marketplaceAccounts).go();
    await db.delete(db.userRulesTable).go();
  }
}

class SeedResult {
  const SeedResult({required this.entitiesCreated});
  final int entitiesCreated;
}
