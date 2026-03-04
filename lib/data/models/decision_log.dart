import 'package:freezed_annotation/freezed_annotation.dart';

part 'decision_log.freezed.dart';
part 'decision_log.g.dart';

enum DecisionLogType {
  listing,
  order,
  supplier,
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
  }) = _DecisionLog;

  factory DecisionLog.fromJson(Map<String, dynamic> json) =>
      _$DecisionLogFromJson(json);
}
