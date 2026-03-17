import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';

/// Phase 37: Centralized auto-pausing logger and (safe) auto-recovery.
///
/// Backward compatible:
/// - does not introduce new listing statuses
/// - "hard pause" maps to existing ListingStatus.paused
/// - "soft pause" only logs an event (no status change) so UI can surface warnings
class AutoPausingService {
  AutoPausingService({
    required this.db,
    required this.listingRepository,
    this.tenantId = 1,
  });

  final AppDatabase db;
  final ListingRepository listingRepository;
  final int tenantId;

  Future<void> recordSoftPause({
    required String listingId,
    required String reason,
    Map<String, dynamic>? metrics,
  }) async {
    await _insertEvent(
      listingId: listingId,
      pauseLevel: 'soft',
      reason: reason,
      metrics: metrics,
    );
  }

  Future<void> applyHardPause({
    required String listingId,
    required String reason,
    Map<String, dynamic>? metrics,
  }) async {
    await listingRepository.updateStatus(listingId, ListingStatus.paused);
    await _insertEvent(
      listingId: listingId,
      pauseLevel: 'hard',
      reason: reason,
      metrics: metrics,
    );
  }

  /// Auto-recovery for hard-paused listings: mark recovered + set Active.
  /// Only runs when listing is currently paused.
  Future<bool> tryRecoverHardPause({
    required String listingId,
    required String reason,
  }) async {
    final listing = await listingRepository.getByLocalId(listingId);
    if (listing == null || listing.status != ListingStatus.paused) return false;

    final activeEvent = await _latestUnrecoveredHardPause(listingId);
    if (activeEvent == null) return false;

    await listingRepository.updateStatus(listingId, ListingStatus.active);
    await (db.update(db.listingPauseEvents)..where((t) => t.id.equals(activeEvent.id))).write(
      ListingPauseEventsCompanion(recoveredAt: Value(DateTime.now())),
    );

    appLogger.i('AutoPause: recovered listing $listingId ($reason)');
    return true;
  }

  Future<void> _insertEvent({
    required String listingId,
    required String pauseLevel,
    required String reason,
    Map<String, dynamic>? metrics,
  }) async {
    // Deduplicate: if the latest unrecovered event has same level+reason, skip.
    final latest = await (db.select(db.listingPauseEvents)
          ..where((t) => t.tenantId.equals(tenantId) & t.listingId.equals(listingId) & t.recoveredAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (latest != null && latest.pauseLevel == pauseLevel && latest.reason == reason) return;

    await db.into(db.listingPauseEvents).insert(
          ListingPauseEventsCompanion.insert(
            tenantId: Value(tenantId),
            listingId: listingId,
            pauseLevel: pauseLevel,
            reason: reason,
            metricsJson: Value(metrics != null ? jsonEncode(metrics) : null),
            createdAt: DateTime.now(),
            recoveredAt: const Value.absent(),
          ),
        );
  }

  Future<ListingPauseEventRow?> _latestUnrecoveredHardPause(String listingId) async {
    return await (db.select(db.listingPauseEvents)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.listingId.equals(listingId) &
              t.pauseLevel.equals('hard') &
              t.recoveredAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
  }
}

