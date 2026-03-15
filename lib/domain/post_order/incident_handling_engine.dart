import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/incident_record_repository.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_decision.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_decision_context.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';
import 'package:jurassic_dropshipping/domain/post_order/non_collected_parcel_handler.dart';

/// Incident-handling engine (Phase 3). Suggests and applies decisions for incidents; logs to DecisionLog.
class IncidentHandlingEngine {
  IncidentHandlingEngine(
    this._incidentRecordRepository,
    this._decisionLogRepository, {
    String Function()? idGenerator,
    NonCollectedParcelHandler? nonCollectedParcelHandler,
  })  : _idGenerator = idGenerator ?? _defaultIdGenerator,
        _nonCollectedParcelHandler = nonCollectedParcelHandler ?? NonCollectedParcelHandler();

  final IncidentRecordRepository _incidentRecordRepository;
  final DecisionLogRepository _decisionLogRepository;
  final String Function() _idGenerator;
  final NonCollectedParcelHandler _nonCollectedParcelHandler;

  static String _defaultIdGenerator() =>
      'inc_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';

  /// Suggests a decision for [record] given [context]. Does not persist.
  IncidentDecision suggestDecision(IncidentRecord record, IncidentDecisionContext context) {
    if (record.incidentType == IncidentType.parcelNotCollected) {
      final result = _nonCollectedParcelHandler.handleNonCollected(
        context.order,
        policy: context.supplierReturnPolicy,
      );
      return IncidentDecision(
        reason: result.reason,
        automaticDecision: result.suggestedDecision,
        refundAmount: null,
        financialImpact: result.financialImpact,
      );
    }

    if (record.incidentType == IncidentType.damageClaim) {
      final policy = context.supplierReturnPolicy;
      final refund = context.order.sellingPrice;
      final policyTypeName = policy?.policyType.name;
      String automaticDecision;
      String reason;
      if (policy == null || policyTypeName == 'noReturns') {
        automaticDecision = 'refund_customer';
        reason = 'Damage claim: no returns policy; suggest full refund.';
      } else if (policyTypeName == 'defectOnly' && policy.requiresRma) {
        automaticDecision = 'request_rma_return';
        reason = 'Damage claim: defect-only policy with RMA; request return with RMA.';
      } else if (policyTypeName == 'defectOnly') {
        automaticDecision = 'refund_customer';
        reason = 'Damage claim: defect-only; suggest refund.';
      } else {
        automaticDecision = 'request_return';
        reason = 'Damage claim: policy allows return; suggest request return.';
      }
      final financialImpact = refund + context.returnShippingCost + context.restockingFee;
      return IncidentDecision(
        reason: reason,
        automaticDecision: automaticDecision,
        refundAmount: refund,
        financialImpact: financialImpact,
      );
    }

    final cost = context.sourceCost;
    final returnShipping = context.returnShippingCost;
    final restocking = context.restockingFee;
    final refund = (context.returnRequest?.refundAmount) ?? context.order.sellingPrice;
    final totalReturnCost = returnShipping + restocking + (refund);
    final financialImpact = totalReturnCost;

    // Phase 8: evaluate configurable rules first (first match wins).
    final rules = context.incidentRules;
    if (rules != null && rules.isNotEmpty) {
      for (final rule in rules) {
        final matches = _evaluateRuleCondition(rule.condition, context);
        if (matches) {
          return IncidentDecision(
            reason: 'Incident ${record.incidentType.name}: rule "${rule.condition}" → ${rule.action}',
            automaticDecision: rule.action,
            refundAmount: rule.action == 'pending_manual' ? null : refund,
            financialImpact: financialImpact,
          );
        }
      }
    }

    // Default: if return shipping > source cost, suggest refund-without-return (no physical return).
    String automaticDecision;
    if (returnShipping > cost && context.returnRequest != null) {
      automaticDecision = 'auto_refund_without_return';
    } else {
      automaticDecision = 'process_return';
    }

    return IncidentDecision(
      reason: 'Incident ${record.incidentType.name}: $automaticDecision',
      automaticDecision: automaticDecision,
      refundAmount: refund,
      financialImpact: financialImpact,
    );
  }

  static bool _evaluateRuleCondition(String condition, IncidentDecisionContext context) {
    switch (condition) {
      case 'return_shipping_gt_source_cost':
        return context.returnShippingCost > context.sourceCost;
      case 'defect_no_returns':
        final isDefect = context.returnRequest?.reason.name == 'defective';
        final noReturns = context.supplierReturnPolicy?.policyType.name == 'noReturns';
        return isDefect && noReturns;
      case 'default':
        return true;
      default:
        return false;
    }
  }

  /// Applies [decision] to [record]: creates a DecisionLog (type incident, incidentType, financialImpact)
  /// and updates [record] with decisionLogId, refundAmount, financialImpact, and status resolved.
  Future<String> applyDecision(IncidentRecord record, IncidentDecision decision) async {
    final logId = _idGenerator();
    await _decisionLogRepository.insert(DecisionLog(
      id: logId,
      type: DecisionLogType.incident,
      entityId: record.orderId,
      reason: decision.reason,
      criteriaSnapshot: null,
      createdAt: DateTime.now(),
      incidentType: IncidentRecord.typeToString(record.incidentType),
      financialImpact: decision.financialImpact,
    ));

    final updated = IncidentRecord(
      id: record.id,
      orderId: record.orderId,
      incidentType: record.incidentType,
      status: IncidentStatus.resolved,
      trigger: record.trigger,
      automaticDecision: decision.automaticDecision,
      supplierInteraction: record.supplierInteraction,
      marketplaceInteraction: record.marketplaceInteraction,
      refundAmount: decision.refundAmount,
      financialImpact: decision.financialImpact,
      decisionLogId: logId,
      createdAt: record.createdAt,
      resolvedAt: DateTime.now(),
      attachmentIds: record.attachmentIds,
    );
    await _incidentRecordRepository.update(updated);
    return logId;
  }

  /// Creates a new incident record. Returns the DB id.
  /// [attachmentIds] optional refs (e.g. photo IDs for damage claims). Phase 7.
  Future<int> createIncident({
    required String orderId,
    required IncidentType incidentType,
    String trigger = 'manual',
    List<String>? attachmentIds,
  }) async {
    final record = IncidentRecord(
      id: 0,
      orderId: orderId,
      incidentType: incidentType,
      status: IncidentStatus.open,
      trigger: trigger,
      createdAt: DateTime.now(),
      attachmentIds: attachmentIds,
    );
    return _incidentRecordRepository.insert(record);
  }
}
