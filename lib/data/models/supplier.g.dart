// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupplierImpl _$$SupplierImplFromJson(Map<String, dynamic> json) =>
    _$SupplierImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      platformType: json['platformType'] as String,
      countryCode: json['countryCode'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      returnWindowDays: (json['returnWindowDays'] as num?)?.toInt(),
      returnShippingCost: (json['returnShippingCost'] as num?)?.toDouble(),
      restockingFeePercent: (json['restockingFeePercent'] as num?)?.toDouble(),
      acceptsNoReasonReturns: json['acceptsNoReasonReturns'] as bool? ?? false,
    );

Map<String, dynamic> _$$SupplierImplToJson(_$SupplierImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'platformType': instance.platformType,
      'countryCode': instance.countryCode,
      'rating': instance.rating,
      'returnWindowDays': instance.returnWindowDays,
      'returnShippingCost': instance.returnShippingCost,
      'restockingFeePercent': instance.restockingFeePercent,
      'acceptsNoReasonReturns': instance.acceptsNoReasonReturns,
    };
