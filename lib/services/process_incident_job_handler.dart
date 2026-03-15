import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/data/repositories/incident_record_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/return_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_return_policy_repository.dart';
import 'package:jurassic_dropshipping/domain/capital/capital_management_service.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_decision_context.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_decision_rule.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_handling_engine.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';

/// Handles process_incident background job: load incident, build context, suggest and apply decision (Phase 10).
/// When [capitalManagementService] is set, posts refunds and losses to the financial ledger (Phase 14/15).
/// When [targets] is set and decision includes refund, calls target.issueRefund if supported (Phase 12).
class ProcessIncidentJobHandler {
  ProcessIncidentJobHandler({
    required this.incidentRecordRepository,
    required this.incidentHandlingEngine,
    required this.orderRepository,
    required this.returnRepository,
    required this.listingRepository,
    required this.productRepository,
    required this.supplierReturnPolicyRepository,
    required this.rulesRepository,
    this.capitalManagementService,
    this.targets = const [],
  });

  final IncidentRecordRepository incidentRecordRepository;
  final IncidentHandlingEngine incidentHandlingEngine;
  final OrderRepository orderRepository;
  final ReturnRepository returnRepository;
  final ListingRepository listingRepository;
  final ProductRepository productRepository;
  final SupplierReturnPolicyRepository supplierReturnPolicyRepository;
  final RulesRepository rulesRepository;
  final CapitalManagementService? capitalManagementService;
  final List<TargetPlatform> targets;

  /// Process incident by id. Idempotent: if incident already resolved, no-op. Throws on missing incident/order.
  Future<void> run(int incidentId) async {
    final record = await incidentRecordRepository.getById(incidentId);
    if (record == null) {
      throw StateError('Incident not found: $incidentId');
    }
    if (record.status == IncidentStatus.resolved) {
      return; // idempotent
    }

    final order = await orderRepository.getByLocalId(record.orderId);
    if (order == null) {
      throw StateError('Order not found for incident: ${record.orderId}');
    }

    final returnsForOrder = await returnRepository.getByOrderId(record.orderId);
    final returnRequest = returnsForOrder.isNotEmpty ? returnsForOrder.first : null;

    String? supplierId;
    final listing = await listingRepository.getByLocalId(order.listingId)
        ?? await listingRepository.getByTargetListingId(order.targetPlatformId, order.listingId);
    if (listing != null) {
      final product = await productRepository.getByLocalId(listing.productId);
      supplierId = product?.supplierId;
    }

    final policy = supplierId != null
        ? await supplierReturnPolicyRepository.getBySupplierId(supplierId)
        : null;

    final userRules = await rulesRepository.get();
    final incidentRules = IncidentDecisionRule.fromJsonString(userRules.incidentRulesJson);

    final context = IncidentDecisionContext(
      order: order,
      returnRequest: returnRequest,
      supplierReturnPolicy: policy,
      sourceCost: order.sourceCost,
      returnShippingCost: returnRequest?.returnShippingCost ?? 0,
      restockingFee: returnRequest?.restockingFee ?? 0,
      incidentRules: incidentRules.isEmpty ? null : incidentRules,
    );

    final decision = incidentHandlingEngine.suggestDecision(record, context);
    await incidentHandlingEngine.applyDecision(record, decision);

    // Phase 14/15: post to financial ledger when capital management is enabled.
    final capital = capitalManagementService;
    if (capital != null) {
      if (decision.refundAmount != null && decision.refundAmount! > 0) {
        await capital.recordRefund(
          record.orderId,
          decision.refundAmount!,
          referenceId: 'incident_${record.id}',
        );
      } else if (record.incidentType == IncidentType.parcelNotCollected &&
          decision.financialImpact != null &&
          decision.financialImpact! > 0) {
        await capital.recordLoss(
          record.orderId,
          decision.financialImpact!,
          referenceId: 'incident_${record.id}_non_collected',
        );
      }
    }

    // Phase 12: issue refund on marketplace when target supports it.
    if (decision.refundAmount != null && decision.refundAmount! > 0 && targets.isNotEmpty) {
      TargetPlatform? target;
      for (final t in targets) {
        if (t.id == order.targetPlatformId) {
          target = t;
          break;
        }
      }
      if (target != null) {
        try {
          await target.issueRefund(
            order.targetOrderId,
            decision.refundAmount!,
            decision.reason,
          );
        } on UnsupportedError catch (_) {
          // Target does not support issueRefund; refund is only recorded in ledger.
        } catch (e, st) {
          appLogger.w('ProcessIncident: issueRefund on ${target.id} failed (refund recorded in ledger)', error: e, stackTrace: st);
        }
      }
    }
  }
}
