import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/repositories/product_group_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_offer_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_reliability_score_repository.dart';
import 'package:jurassic_dropshipping/domain/observability/observability_metrics.dart';

class SupplierSwitchDecision {
  const SupplierSwitchDecision({
    required this.groupId,
    required this.fromSupplierId,
    required this.toSupplierId,
    required this.toProductId,
    required this.reason,
  });

  final String groupId;
  final String? fromSupplierId;
  final String toSupplierId;
  final String toProductId;
  final String reason;
}

/// Phase 37: Supplier switching engine.
///
/// Goal: find an alternative supplier/product for a ProductGroup when problems occur (OOS, rejection, delays).
/// Deterministic ranking and loop avoidance. Logs to supplier_switch_events.
class SupplierSwitchingEngine {
  SupplierSwitchingEngine({
    required this.db,
    required this.productGroupRepository,
    required this.productRepository,
    required this.supplierOfferRepository,
    required this.supplierReliabilityScoreRepository,
    this.tenantId = 1,
    this.cooldown = const Duration(hours: 24),
    this.observabilityMetrics,
  });

  final AppDatabase db;
  final ProductGroupRepository productGroupRepository;
  final ProductRepository productRepository;
  final SupplierOfferRepository supplierOfferRepository;
  final SupplierReliabilityScoreRepository supplierReliabilityScoreRepository;
  final int tenantId;
  final Duration cooldown;
  final ObservabilityMetrics? observabilityMetrics;

  Future<SupplierSwitchDecision?> chooseAlternativeForOutOfStock({
    required String currentProductId,
    required String listingId,
    required int quantity,
  }) async {
    final groupId = await _groupIdForProduct(currentProductId);
    if (groupId == null || groupId.isEmpty) return null;

    // Loop avoidance: if we switched this group recently, do not switch again.
    final recentlySwitched = await _hasRecentSwitch(groupId);
    if (recentlySwitched) return null;

    final members = await productGroupRepository.getMembers(groupId);
    if (members.isEmpty) return null;

    final currentProduct = await productRepository.getByLocalId(currentProductId);
    final fromSupplierId = currentProduct?.supplierId;

    // Build candidate products (exclude current).
    final candidateProductIds = members.map((m) => m.productId).where((id) => id != currentProductId).toList();
    if (candidateProductIds.isEmpty) return null;

    // Rank candidates by: reliability score desc, in-stock hint, total cost asc, delivery asc.
    _Candidate? best;
    for (final pid in candidateProductIds) {
      final p = await productRepository.getByLocalId(pid);
      if (p == null) continue;

      final offers = await supplierOfferRepository.getByProductId(pid);
      if (offers.isEmpty) continue;
      // For now, choose cheapest offer for this product.
      final offer = offers.reduce((a, b) => _offerTotal(a) <= _offerTotal(b) ? a : b);

      // Soft stock hint: if lastStockRefreshAt exists, assume offer is usable; we don't have per-offer stock in model yet.
      // Deterministic-first: we still allow switching; the pre-check/placeOrder will catch OOS.
      final reliability = await supplierReliabilityScoreRepository.getBySupplierId(p.supplierId ?? offer.supplierId);
      final relScore = reliability?.score ?? 50.0;
      final delivery = offer.maxEstimatedDays ?? p.estimatedDays ?? 999;
      final totalCost = _offerTotal(offer);

      final c = _Candidate(
        productId: pid,
        supplierId: offer.supplierId,
        reliabilityScore: relScore,
        deliveryDays: delivery,
        totalCost: totalCost,
      );
      if (best == null || c.isBetterThan(best)) best = c;
    }

    if (best == null) return null;
    if (best.supplierId.isEmpty) return null;

    final decision = SupplierSwitchDecision(
      groupId: groupId,
      fromSupplierId: fromSupplierId,
      toSupplierId: best.supplierId,
      toProductId: best.productId,
      reason: 'out_of_stock',
    );

    await db.into(db.supplierSwitchEvents).insert(
          SupplierSwitchEventsCompanion.insert(
            tenantId: Value(tenantId),
            groupId: decision.groupId,
            fromSupplierId: Value(decision.fromSupplierId),
            toSupplierId: decision.toSupplierId,
            reason: decision.reason,
            marginBeforePercent: const Value.absent(),
            marginAfterPercent: const Value.absent(),
            listingId: Value(listingId),
            orderId: const Value.absent(),
            createdAt: DateTime.now(),
          ),
        );

    appLogger.i('SupplierSwitch: group=$groupId listing=$listingId $fromSupplierId -> ${decision.toSupplierId} (product ${decision.toProductId})');
    observabilityMetrics?.recordSupplierSwitch();
    return decision;
  }

  Future<String?> _groupIdForProduct(String productId) async {
    final row = await (db.select(db.productIntelligenceStates)
          ..where((t) => t.tenantId.equals(tenantId) & t.productId.equals(productId))
          ..limit(1))
        .getSingleOrNull();
    return row?.groupId;
  }

  Future<bool> _hasRecentSwitch(String groupId) async {
    final cutoff = DateTime.now().subtract(cooldown);
    final row = await (db.select(db.supplierSwitchEvents)
          ..where((t) =>
              t.tenantId.equals(tenantId) &
              t.groupId.equals(groupId) &
              t.createdAt.isBiggerOrEqualValue(cutoff))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    return row != null;
  }

  double _offerTotal(dynamic offer) {
    // SupplierOffer model: cost + optional shippingCost
    final cost = offer.cost as double;
    final ship = (offer.shippingCost as double?) ?? 0.0;
    return cost + ship;
  }
}

class _Candidate {
  const _Candidate({
    required this.productId,
    required this.supplierId,
    required this.reliabilityScore,
    required this.deliveryDays,
    required this.totalCost,
  });

  final String productId;
  final String supplierId;
  final double reliabilityScore;
  final int deliveryDays;
  final double totalCost;

  bool isBetterThan(_Candidate other) {
    // Primary: reliability, then cost, then delivery.
    if (reliabilityScore != other.reliabilityScore) return reliabilityScore > other.reliabilityScore;
    if (totalCost != other.totalCost) return totalCost < other.totalCost;
    return deliveryDays < other.deliveryDays;
  }
}

