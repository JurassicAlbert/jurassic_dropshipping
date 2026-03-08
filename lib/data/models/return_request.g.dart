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
      returnToAddress: json['returnToAddress'] as String?,
      returnToCity: json['returnToCity'] as String?,
      returnToCountry: json['returnToCountry'] as String?,
      returnTrackingNumber: json['returnTrackingNumber'] as String?,
      returnCarrier: json['returnCarrier'] as String?,
      supplierId: json['supplierId'] as String?,
      productId: json['productId'] as String?,
      sourcePlatformId: json['sourcePlatformId'] as String?,
      targetPlatformId: json['targetPlatformId'] as String?,
      returnDestination: $enumDecodeNullable(
        _$ReturnDestinationEnumMap,
        json['returnDestination'],
      ),
    );

Map<String, dynamic> _$$ReturnRequestImplToJson(
  _$ReturnRequestImpl instance,
) => <String, dynamic>{
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
  'returnToAddress': instance.returnToAddress,
  'returnToCity': instance.returnToCity,
  'returnToCountry': instance.returnToCountry,
  'returnTrackingNumber': instance.returnTrackingNumber,
  'returnCarrier': instance.returnCarrier,
  'supplierId': instance.supplierId,
  'productId': instance.productId,
  'sourcePlatformId': instance.sourcePlatformId,
  'targetPlatformId': instance.targetPlatformId,
  'returnDestination': _$ReturnDestinationEnumMap[instance.returnDestination],
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

const _$ReturnDestinationEnumMap = {
  ReturnDestination.toSupplier: 'toSupplier',
  ReturnDestination.toSeller: 'toSeller',
};
