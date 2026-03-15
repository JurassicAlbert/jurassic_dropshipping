import 'package:freezed_annotation/freezed_annotation.dart';

part 'decision_log.freezed.dart';
part 'decision_log.g.dart';

enum DecisionLogType {
  listing,
  order,
  supplier,
  /// Alert when an active listing's margin drops below threshold (e.g. after source cost rise).
  profitAlert,
  /// Post-order incident decision (refund, return, dispute, etc.).
  incident,
}

@freezed
class DecisionLog with _$DecisionLog {
  const factory DecisionLog({
    required String id,
    required DecisionLogType type,
    required String entityId,
    required String reason,
    Map<String, dynamic>? criteriaSnapshot,
    required DateTime createdAt,
    /// For incident decisions: incident type (e.g. damage_claim, parcel_not_collected).
    String? incidentType,
    /// For incident decisions: total cost impact (refund + shipping + fees).
    double? financialImpact,
  }) = _DecisionLog;

  factory DecisionLog.fromJson(Map<String, dynamic> json) =>
      _$DecisionLogFromJson(json);
}
