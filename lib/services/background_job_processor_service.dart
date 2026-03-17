import 'dart:convert';

import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/repositories/background_job_repository.dart';
import 'package:jurassic_dropshipping/domain/catalog/catalog_cache.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/scanner.dart';
import 'package:jurassic_dropshipping/domain/observability/observability_metrics.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/product_intelligence_service.dart';
import 'package:jurassic_dropshipping/services/marketplace_listing_sync_service.dart';
import 'package:jurassic_dropshipping/services/price_refresh_service.dart';
import 'package:jurassic_dropshipping/services/process_incident_job_handler.dart';

/// Processes background jobs from the queue (Phase B). Run periodically or from a timer.
/// Phase 23: update_listing jobs are throttled with [listingUpdateDelay] between each.
class BackgroundJobProcessorService {
  BackgroundJobProcessorService({
    required this.jobRepository,
    required this.scanner,
    required this.fulfillmentService,
    required this.priceRefreshService,
    required this.productIntelligenceService,
    required this.processIncidentJobHandler,
    required this.marketplaceListingSyncService,
    this.listingUpdateDelay = const Duration(seconds: 2),
    this.observabilityMetrics,
    this.catalogCache,
  });

  final BackgroundJobRepository jobRepository;
  final Scanner scanner;
  final FulfillmentService fulfillmentService;
  final PriceRefreshService priceRefreshService;
  final ProductIntelligenceService productIntelligenceService;
  final ProcessIncidentJobHandler processIncidentJobHandler;
  final MarketplaceListingSyncService marketplaceListingSyncService;
  /// Delay after each update_listing job to respect marketplace rate limits (Phase 23).
  final Duration listingUpdateDelay;
  /// Phase 32: when set, records job processed/failed and listing update processed.
  final ObservabilityMetrics? observabilityMetrics;
  /// Phase 30: when set, invalidated on catalog_event so next read gets fresh data.
  final CatalogCache? catalogCache;

  /// Process one job if any pending. Returns true if a job was processed.
  Future<bool> processNext() async {
    final job = await jobRepository.claimNext();
    if (job == null) return false;

    try {
      final payload = jsonDecode(job.payloadJson) as Map<String, dynamic>? ?? {};
      switch (job.jobType) {
        case BackgroundJobType.scan:
          await scanner.run();
          break;
        case BackgroundJobType.catalogIntelligence:
          final limitRaw = payload['limit'];
          final limit = limitRaw is int ? limitRaw : 200;
          final sinceRaw = payload['since'] as String?;
          final since = sinceRaw != null ? DateTime.tryParse(sinceRaw) : null;
          await productIntelligenceService.processBatch(limit: limit, since: since);
          break;
        case BackgroundJobType.fulfillOrder:
          final orderId = payload['orderId'] as String?;
          if (orderId == null || orderId.isEmpty) {
            throw ArgumentError('fulfill_order job requires payload.orderId');
          }
          final order = await fulfillmentService.orderRepository.getByLocalId(orderId);
          if (order == null) {
            throw StateError('Order not found: $orderId');
          }
          await fulfillmentService.fulfillOrder(order);
          break;
        case BackgroundJobType.priceRefresh:
          await priceRefreshService.refreshStaleOffers();
          break;
        case BackgroundJobType.processIncident:
          final incidentId = payload['incidentId'];
          if (incidentId is! int) {
            throw ArgumentError('process_incident job requires payload.incidentId (int)');
          }
          await processIncidentJobHandler.run(incidentId);
          break;
        case BackgroundJobType.updateListing:
          final listingId = payload['listingId'] as String?;
          if (listingId == null || listingId.isEmpty) {
            throw ArgumentError('update_listing job requires payload.listingId');
          }
          await marketplaceListingSyncService.syncOneListing(listingId);
          await Future<void>.delayed(listingUpdateDelay);
          break;
        case BackgroundJobType.supplierFeedSync:
          // Phase 29/31: refresh offers; PriceRefreshService enqueues catalog_event per product, handler enqueues update_listing.
          await priceRefreshService.refreshStaleOffers();
          break;
        case BackgroundJobType.catalogEvent:
          // Phase 31: event-driven catalog – enqueue update_listing for affected listings.
          // Phase 30: invalidate catalog cache so next read gets fresh product/listing data.
          final eventType = payload['eventType'] as String?;
          final productId = payload['productId'] as String?;
          if ((eventType == CatalogEventType.supplierOfferChange ||
                  eventType == CatalogEventType.returnRestocked) &&
              productId != null &&
              productId.isNotEmpty) {
            final listings = await marketplaceListingSyncService.listingRepository.getByProductId(productId);
            final listingIds = listings.map((l) => l.id).toList();
            catalogCache?.invalidateProductAndListings(productId, listingIds);
            var enqueued = 0;
            for (final l in listings.where((l) => l.targetListingId != null && l.targetListingId!.isNotEmpty)) {
              await jobRepository.enqueue(BackgroundJobType.updateListing, {'listingId': l.id});
              enqueued++;
            }
            if (enqueued > 0) {
              observabilityMetrics?.recordListingUpdatesEnqueued(enqueued);
            }
          }
          // order_placed, order_shipped, listing_paused: future handlers (e.g. StockState refresh).
          break;
        default:
          throw UnsupportedError('Unknown job type: ${job.jobType}');
      }
      await jobRepository.markCompleted(job.id);
      observabilityMetrics?.recordJobProcessed();
      if (job.jobType == BackgroundJobType.updateListing) {
        observabilityMetrics?.recordListingUpdateProcessed();
      }
      appLogger.i('BackgroundJobProcessor: completed job ${job.id} (${job.jobType})');
      return true;
    } catch (e, st) {
      observabilityMetrics?.recordJobFailed();
      final message = e.toString();
      appLogger.e('BackgroundJobProcessor: job ${job.id} (${job.jobType}) failed', error: e, stackTrace: st);
      await jobRepository.markFailed(job.id, message);
      return true; // we did process (and failed)
    }
  }

  /// Process jobs until queue is empty (or [maxJobs] reached).
  Future<int> processUntilEmpty({int maxJobs = 100}) async {
    var processed = 0;
    while (processed < maxJobs) {
      final didOne = await processNext();
      if (!didOne) break;
      processed++;
    }
    return processed;
  }
}
