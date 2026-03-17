import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/auto_pausing_service.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:drift/drift.dart' as drift;

void main() {
  setUp(() {
    drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  test('hard pause writes event and can recover', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final listingRepo = ListingRepository(db);
    final svc = AutoPausingService(db: db, listingRepository: listingRepo);

    await listingRepo.insert(Listing(
      id: 'l1',
      productId: 'p1',
      targetPlatformId: 'allegro',
      status: ListingStatus.active,
      sellingPrice: 100,
      sourceCost: 50,
      createdAt: DateTime.now(),
    ));

    await svc.applyHardPause(listingId: 'l1', reason: 'negative_margin', metrics: {'x': 1});
    final paused = await listingRepo.getByLocalId('l1');
    expect(paused!.status, ListingStatus.paused);

    final events = await (db.select(db.listingPauseEvents)..where((t) => t.listingId.equals('l1'))).get();
    expect(events.length, 1);
    expect(events.first.pauseLevel, 'hard');

    final recovered = await svc.tryRecoverHardPause(listingId: 'l1', reason: 'recovered');
    expect(recovered, true);
    final active = await listingRepo.getByLocalId('l1');
    expect(active!.status, ListingStatus.active);
  });
}

