import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';

import '../../fixtures/test_database.dart';
import '../../fixtures/test_fixtures.dart';

void main() {
  late AppDatabase db;
  late ListingRepository repo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    repo = ListingRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ListingRepository', () {
    test('insert and getAll', () async {
      final listing = Fixtures.listing(id: 'lst_1');
      await repo.insert(listing);

      final all = await repo.getAll();
      expect(all, hasLength(1));
      expect(all.first.id, 'lst_1');
      expect(all.first.sellingPrice, listing.sellingPrice);
      expect(all.first.sourceCost, listing.sourceCost);
      expect(all.first.status, listing.status);
    });

    test('getByLocalId returns correct listing', () async {
      final l1 = Fixtures.listing(id: 'lst_a');
      final l2 = Fixtures.listing(id: 'lst_b', sellingPrice: 50.0);
      await repo.insert(l1);
      await repo.insert(l2);

      final found = await repo.getByLocalId('lst_b');
      expect(found, isNotNull);
      expect(found!.sellingPrice, 50.0);
    });

    test('getByLocalId returns null for non-existent id', () async {
      final found = await repo.getByLocalId('nonexistent');
      expect(found, isNull);
    });

    test('getByStatus filters by status', () async {
      final active = Fixtures.listing(id: 'lst_active', status: ListingStatus.active);
      final draft = Fixtures.draftListing(id: 'lst_draft');
      final pending = Fixtures.pendingListing(id: 'lst_pending');
      await repo.insert(active);
      await repo.insert(draft);
      await repo.insert(pending);

      final actives = await repo.getByStatus(ListingStatus.active);
      expect(actives, hasLength(1));
      expect(actives.first.id, 'lst_active');

      final drafts = await repo.getByStatus(ListingStatus.draft);
      expect(drafts, hasLength(1));
      expect(drafts.first.id, 'lst_draft');
    });

    test('getPendingApproval returns only pendingApproval listings', () async {
      final active = Fixtures.listing(id: 'lst_a2', status: ListingStatus.active);
      final pending1 = Fixtures.pendingListing(id: 'lst_p1');
      final pending2 = Fixtures.pendingListing(id: 'lst_p2');
      await repo.insert(active);
      await repo.insert(pending1);
      await repo.insert(pending2);

      final pendingList = await repo.getPendingApproval();
      expect(pendingList, hasLength(2));
      expect(pendingList.map((l) => l.id).toSet(), {'lst_p1', 'lst_p2'});
    });

    test('updateStatus changes listing status', () async {
      final listing = Fixtures.pendingListing(id: 'lst_status');
      await repo.insert(listing);

      await repo.updateStatus('lst_status', ListingStatus.active,
          targetListingId: 'target_123', publishedAt: DateTime(2025, 1, 1));

      final updated = await repo.getByLocalId('lst_status');
      expect(updated, isNotNull);
      expect(updated!.status, ListingStatus.active);
      expect(updated.targetListingId, 'target_123');
      expect(updated.publishedAt, DateTime(2025, 1, 1));
    });

    test('updateStatus without optional parameters only changes status', () async {
      final listing = Fixtures.listing(
        id: 'lst_stat2',
        status: ListingStatus.active,
      );
      await repo.insert(listing);

      await repo.updateStatus('lst_stat2', ListingStatus.soldOut);

      final updated = await repo.getByLocalId('lst_stat2');
      expect(updated!.status, ListingStatus.soldOut);
    });

    test('getByTargetListingId returns correct listing', () async {
      final listing = Fixtures.listing(
        id: 'lst_tgt',
        targetPlatformId: 'allegro',
      );
      await repo.insert(listing);
      await repo.updateStatus('lst_tgt', ListingStatus.active,
          targetListingId: 'allegro_offer_123');

      final found = await repo.getByTargetListingId('allegro', 'allegro_offer_123');
      expect(found, isNotNull);
      expect(found!.id, 'lst_tgt');
    });

    test('getByTargetListingId returns null when not found', () async {
      final found = await repo.getByTargetListingId('allegro', 'nonexistent');
      expect(found, isNull);
    });

    test('getAll returns listings ordered by createdAt descending', () async {
      final old = Fixtures.listing(
        id: 'lst_old',
        createdAt: DateTime(2024, 1, 1),
      );
      final recent = Fixtures.listing(
        id: 'lst_recent',
        createdAt: DateTime(2025, 6, 1),
      );
      await repo.insert(old);
      await repo.insert(recent);

      final all = await repo.getAll();
      expect(all.first.id, 'lst_recent');
      expect(all.last.id, 'lst_old');
    });

    test('getAll returns empty list when no listings', () async {
      final all = await repo.getAll();
      expect(all, isEmpty);
    });
  });
}
