import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

/// Job types for the async queue (Phase B).
abstract final class BackgroundJobType {
  static const String scan = 'scan';
  static const String fulfillOrder = 'fulfill_order';
  static const String priceRefresh = 'price_refresh';
  /// Phase 37: product intelligence pipeline (matching, quality/risk, pricing inputs). Payload: { limit?: int, since?: iso8601 }.
  static const String catalogIntelligence = 'catalog_intelligence';
  /// Post-order: process one incident (suggest + apply decision). Payload: { incidentId: int }.
  static const String processIncident = 'process_incident';
  /// Phase 23: update one listing on marketplace (stock/title/description). Payload: { listingId: string }. Worker throttles rate.
  static const String updateListing = 'update_listing';
  /// Phase 29: refresh supplier offers from feeds/API and enqueue update_listing for affected listings. Payload: {}.
  static const String supplierFeedSync = 'supplier_feed_sync';
  /// Phase 31: event-driven catalog update. Payload: { eventType, productId?, listingId?, orderId? }. Handler enqueues update_listing etc.
  static const String catalogEvent = 'catalog_event';
}

/// Phase 31: catalog event types for [BackgroundJobType.catalog_event] payload.eventType.
abstract final class CatalogEventType {
  static const String supplierOfferChange = 'supplier_offer_change';
  static const String returnRestocked = 'return_restocked';
  static const String orderPlaced = 'order_placed';
  static const String orderShipped = 'order_shipped';
  static const String listingPaused = 'listing_paused';
}

/// Status of a background job.
abstract final class BackgroundJobStatus {
  static const String pending = 'pending';
  static const String running = 'running';
  static const String completed = 'completed';
  static const String failed = 'failed';
}

/// Repository for the background job queue. Scoped by [tenantId].
class BackgroundJobRepository {
  BackgroundJobRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  /// Enqueue a job. Returns the row id.
  Future<int> enqueue(String jobType, Map<String, dynamic> payload, {int maxAttempts = 3}) async {
    final row = await _db.into(_db.backgroundJobs).insert(
      BackgroundJobsCompanion.insert(
        tenantId: Value(tenantId),
        jobType: jobType,
        payloadJson: Value(jsonEncode(payload)),
        status: BackgroundJobStatus.pending,
        attempts: const Value(0),
        maxAttempts: Value(maxAttempts),
        createdAt: DateTime.now(),
      ),
    );
    return row;
  }

  /// Claim the next pending job (by createdAt) and set status to running. Returns null if none.
  Future<BackgroundJobRow?> claimNext() async {
    final row = await (_db.select(_db.backgroundJobs)
          ..where((t) => t.tenantId.equals(tenantId) & t.status.equals(BackgroundJobStatus.pending))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    await (_db.update(_db.backgroundJobs)
          ..where((t) => t.id.equals(row.id)))
        .write(BackgroundJobsCompanion(
      status: Value(BackgroundJobStatus.running),
      attempts: Value(row.attempts + 1),
      startedAt: Value(DateTime.now()),
    ));
    return row;
  }

  /// Mark job as completed.
  Future<void> markCompleted(int id) async {
    await (_db.update(_db.backgroundJobs)..where((t) => t.tenantId.equals(tenantId) & t.id.equals(id))).write(
      BackgroundJobsCompanion(
        status: Value(BackgroundJobStatus.completed),
        completedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Mark job as failed. If attempts >= maxAttempts, status = failed (dead-letter); else back to pending for retry.
  Future<void> markFailed(int id, String errorMessage) async {
    final row = await (_db.select(_db.backgroundJobs)
          ..where((t) => t.tenantId.equals(tenantId) & t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return;
    final isDeadLetter = row.attempts >= row.maxAttempts;
    await (_db.update(_db.backgroundJobs)..where((t) => t.tenantId.equals(tenantId) & t.id.equals(id))).write(
      BackgroundJobsCompanion(
        status: Value(isDeadLetter ? BackgroundJobStatus.failed : BackgroundJobStatus.pending),
        errorMessage: Value(errorMessage),
        completedAt: isDeadLetter ? Value(DateTime.now()) : const Value.absent(),
      ),
    );
  }

  /// Get pending count (for UI).
  Future<int> countPending() async {
    final rows = await (_db.select(_db.backgroundJobs)
          ..where((t) => t.tenantId.equals(tenantId) & t.status.equals(BackgroundJobStatus.pending)))
        .get();
    return rows.length;
  }

  /// Get failed jobs (dead-letter) for inspection.
  Future<List<BackgroundJobRow>> getFailed({int limit = 50}) async {
    return await (_db.select(_db.backgroundJobs)
          ..where((t) => t.tenantId.equals(tenantId) & t.status.equals(BackgroundJobStatus.failed))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }
}
