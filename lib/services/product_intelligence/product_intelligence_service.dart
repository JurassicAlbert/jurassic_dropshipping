import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_group_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/product_matching_engine.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/quality_risk_scoring.dart';
import 'package:jurassic_dropshipping/domain/observability/observability_metrics.dart';

/// Phase 37: Deterministic-first product intelligence pipeline core.
///
/// This is intentionally minimal at first:
/// - batch-based (limit)
/// - hash-based change detection (skip unchanged)
/// - idempotent writes to ProductIntelligenceStates
/// - deterministic outputs (placeholder scores for now)
class ProductIntelligenceService {
  ProductIntelligenceService({
    required this.db,
    required this.productRepository,
    required this.productGroupRepository,
    required this.supplierOfferRepository,
    this.tenantId = 1,
    this.observabilityMetrics,
  });

  final AppDatabase db;
  final ProductRepository productRepository;
  final ProductGroupRepository productGroupRepository;
  final SupplierOfferRepository supplierOfferRepository;
  final int tenantId;
  final ObservabilityMetrics? observabilityMetrics;

  Future<int> processBatch({int limit = 200, DateTime? since}) async {
    // Batch size safety limits: keep deterministic and bounded.
    final safeLimit = limit.clamp(50, 200);
    final products = await _getCandidateProducts(limit: safeLimit, since: since);
    var processed = 0;
    var skipped = 0;

    final matcher = ProductMatchingEngine(groupRepo: productGroupRepository);
    const scorer = ProductQualityRiskScorer();
    for (final p in products) {
      final hash = _contentHash(p);
      final existing = await (db.select(db.productIntelligenceStates)
            ..where((t) => t.tenantId.equals(tenantId) & t.productId.equals(p.id))
            ..limit(1))
          .getSingleOrNull();

      if (existing != null && existing.contentHash == hash) {
        skipped++;
        continue;
      }

      // Stage: Matching (deterministic) -> ProductGroup
      final match = await matcher.matchOne(p, tenantId: tenantId);

      final scored = scorer.evaluate(p);
      final qualityScore = scored.qualityScore;
      final returnRiskScore = scored.returnRiskScore;

      final competitionLevel = await _computeCompetitionLevel(match.groupId);

      final debug = <String, dynamic>{
        'hash': hash,
        'version': 1,
        'match': {
          'groupId': match.groupId,
          'matchedBy': match.matchedBy,
          'confidence': match.confidence,
        },
        'qualityFactors': scored.qualityFactors,
        'riskFactors': scored.riskFactors,
      };

      if (existing == null) {
        await db.into(db.productIntelligenceStates).insert(
              ProductIntelligenceStatesCompanion.insert(
                tenantId: Value(tenantId),
                productId: p.id,
                contentHash: hash,
                groupId: Value(match.groupId),
                qualityScore: Value(qualityScore),
                returnRiskScore: Value(returnRiskScore),
                competitionLevel: Value(competitionLevel),
                debugJson: Value(jsonEncode(debug)),
                lastProcessedAt: DateTime.now(),
              ),
            );
      } else {
        await (db.update(db.productIntelligenceStates)
              ..where((t) => t.tenantId.equals(tenantId) & t.productId.equals(p.id)))
            .write(
          ProductIntelligenceStatesCompanion(
            contentHash: Value(hash),
            groupId: Value(match.groupId),
            qualityScore: Value(qualityScore),
            returnRiskScore: Value(returnRiskScore),
            competitionLevel: Value(competitionLevel),
            debugJson: Value(jsonEncode(debug)),
            lastProcessedAt: Value(DateTime.now()),
          ),
        );
      }
      processed++;
    }

    appLogger.i('ProductIntelligence: processed=$processed skipped=$skipped limit=$safeLimit since=${since?.toIso8601String() ?? "null"}');
    observabilityMetrics?.recordIntelProcessed(processed, skipped);
    return processed;
  }

  Future<List<Product>> _getCandidateProducts({required int limit, DateTime? since}) async {
    if (since == null) {
      final all = await productRepository.getAll();
      return all.take(limit).toList();
    }
    // ProductRepository currently lacks a since-filter; do a simple filter in memory
    // (good enough for now, will be optimized with a dedicated query once pipeline is fully wired).
    final rows = await productRepository.getAll();
    final filtered = rows.where((p) {
      // We don't have product.updatedAt in domain model; treat all as candidates for now.
      // This will be upgraded to a DB query when we add updatedAt exposure in ProductRepository.
      return true;
    }).toList();
    return filtered.take(limit).toList();
  }

  String _contentHash(Product p) {
    final b = StringBuffer();
    b.write(p.sourcePlatformId);
    b.write('|');
    b.write(p.sourceId);
    b.write('|');
    b.write(_norm(p.title));
    b.write('|');
    b.write(_norm(p.description ?? ''));
    b.write('|');
    for (final url in (List<String>.from(p.imageUrls)..sort())) {
      b.write(url);
      b.write(',');
    }
    b.write('|');
    final variants = List<ProductVariant>.from(p.variants)
      ..sort((a, b) => a.id.compareTo(b.id));
    for (final v in variants) {
      b.write(v.id);
      b.write(':');
      b.write(v.price.toStringAsFixed(2));
      b.write(':');
      b.write(v.stock);
      b.write(':');
      b.write(_norm(v.sku ?? ''));
      b.write(':');
      final attrs = Map<String, String>.from(v.attributes);
      final keys = attrs.keys.toList()..sort();
      for (final k in keys) {
        b.write(_norm(k));
        b.write('=');
        b.write(_norm(attrs[k] ?? ''));
        b.write(';');
      }
      b.write('|');
    }
    final bytes = utf8.encode(b.toString());
    return sha256.convert(bytes).toString();
  }

  Future<String> _computeCompetitionLevel(String groupId) async {
    final members = await productGroupRepository.getMembers(groupId);
    final productIds = members.map((m) => m.productId).toSet().toList();
    final supplierIds = <String>{};
    final prices = <double>[];

    for (final pid in productIds) {
      final offers = await supplierOfferRepository.getByProductId(pid);
      for (final o in offers) {
        supplierIds.add(o.supplierId);
        prices.add(o.cost + (o.shippingCost ?? 0));
      }
    }

    final supplierCount = supplierIds.length;
    if (prices.isEmpty) {
      // Unknown -> treat as medium so we don't over-boost.
      return 'medium';
    }
    prices.sort();
    final minP = prices.first;
    final maxP = prices.last;
    final variancePct = minP > 0 ? ((maxP - minP) / minP) : 0.0;

    // Deterministic thresholds:
    // - high competition: many suppliers and tight price band
    // - low competition: few suppliers or wide variance
    if (supplierCount >= 6 && variancePct < 0.08) return 'high';
    if (supplierCount <= 2) return 'low';
    if (variancePct >= 0.25) return 'low';
    return 'medium';
  }

  String _norm(String s) => s.trim().toLowerCase();
}

