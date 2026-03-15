import 'dart:convert';

/// A single configurable incident decision rule (Phase 8). Stored in UserRules.incidentRulesJson.
/// Condition types: return_shipping_gt_source_cost, defect_no_returns, default.
/// Action: auto_refund_without_return, process_return, request_rma, pending_manual.
class IncidentDecisionRule {
  const IncidentDecisionRule({
    required this.condition,
    required this.action,
  });

  final String condition;
  final String action;

  static List<IncidentDecisionRule> fromJsonString(String? json) {
    if (json == null || json.trim().isEmpty) return [];
    try {
      final list = jsonDecode(json) as List<dynamic>?;
      if (list == null) return [];
      return list
          .map((e) {
            final map = e as Map<String, dynamic>?;
            if (map == null) return null;
            final c = map['condition'] as String?;
            final a = map['action'] as String?;
            if (c == null || a == null) return null;
            return IncidentDecisionRule(condition: c, action: a);
          })
          .whereType<IncidentDecisionRule>()
          .toList();
    } catch (_) {
      return [];
    }
  }
}
