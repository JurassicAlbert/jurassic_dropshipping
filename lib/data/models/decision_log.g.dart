// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DecisionLogImpl _$$DecisionLogImplFromJson(Map<String, dynamic> json) =>
    _$DecisionLogImpl(
      id: json['id'] as String,
      type: $enumDecode(_$DecisionLogTypeEnumMap, json['type']),
      entityId: json['entityId'] as String,
      reason: json['reason'] as String,
      criteriaSnapshot: json['criteriaSnapshot'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      incidentType: json['incidentType'] as String?,
      financialImpact: (json['financialImpact'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$DecisionLogImplToJson(_$DecisionLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$DecisionLogTypeEnumMap[instance.type]!,
      'entityId': instance.entityId,
      'reason': instance.reason,
      'criteriaSnapshot': instance.criteriaSnapshot,
      'createdAt': instance.createdAt.toIso8601String(),
      'incidentType': instance.incidentType,
      'financialImpact': instance.financialImpact,
    };

const _$DecisionLogTypeEnumMap = {
  DecisionLogType.listing: 'listing',
  DecisionLogType.order: 'order',
  DecisionLogType.supplier: 'supplier',
  DecisionLogType.profitAlert: 'profitAlert',
  DecisionLogType.incident: 'incident',
};
