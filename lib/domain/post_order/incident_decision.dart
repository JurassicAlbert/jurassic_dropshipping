/// Suggested decision for an incident (Phase 3). Applied by [IncidentHandlingEngine].
class IncidentDecision {
  const IncidentDecision({
    required this.reason,
    this.automaticDecision,
    this.refundAmount,
    this.financialImpact,
  });

  final String reason;
  final String? automaticDecision;
  final double? refundAmount;
  final double? financialImpact;
}
