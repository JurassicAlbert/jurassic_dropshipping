// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReturnRequestImpl _$$ReturnRequestImplFromJson(Map<String, dynamic> json) =>
    _$ReturnRequestImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      reason: $enumDecode(_$ReturnReasonEnumMap, json['reason']),
      status: $enumDecode(_$ReturnStatusEnumMap, json['status']),
      notes: json['notes'] as String?,
      refundAmount: (json['refundAmount'] as num?)?.toDouble(),
      returnShippingCost: (json['returnShippingCost'] as num?)?.toDouble(),
      restockingFee: (json['restockingFee'] as num?)?.toDouble(),
      requestedAt: json['requestedAt'] == null
          ? null
          : DateTime.parse(json['requestedAt'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$$ReturnRequestImplToJson(_$ReturnRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'reason': _$ReturnReasonEnumMap[instance.reason]!,
      'status': _$ReturnStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'refundAmount': instance.refundAmount,
      'returnShippingCost': instance.returnShippingCost,
      'restockingFee': instance.restockingFee,
      'requestedAt': instance.requestedAt?.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

const _$ReturnReasonEnumMap = {
  ReturnReason.noReason: 'noReason',
  ReturnReason.defective: 'defective',
  ReturnReason.wrongItem: 'wrongItem',
  ReturnReason.damagedInTransit: 'damagedInTransit',
  ReturnReason.other: 'other',
};

const _$ReturnStatusEnumMap = {
  ReturnStatus.requested: 'requested',
  ReturnStatus.approved: 'approved',
  ReturnStatus.shipped: 'shipped',
  ReturnStatus.received: 'received',
  ReturnStatus.refunded: 'refunded',
  ReturnStatus.rejected: 'rejected',
};
