import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';

import 'package:jurassic_dropshipping/domain/post_order/incident_decision_rule.dart';
import 'package:jurassic_dropshipping/domain/post_order/supplier_return_policy.dart';

/// Context for suggesting an incident decision (Phase 3). Built from order, return, policy, and costs.
class IncidentDecisionContext {
  const IncidentDecisionContext({
    required this.order,
    this.returnRequest,
    this.supplierReturnPolicy,
    this.sourceCost = 0,
    this.returnShippingCost = 0,
    this.restockingFee = 0,
    this.incidentRules,
  });

  final Order order;
  final ReturnRequest? returnRequest;
  final SupplierReturnPolicy? supplierReturnPolicy;
  final double sourceCost;
  final double returnShippingCost;
  final double restockingFee;
  /// Phase 8: configurable rules from UserRules.incidentRulesJson. Evaluated in order; first match wins.
  final List<IncidentDecisionRule>? incidentRules;
}
