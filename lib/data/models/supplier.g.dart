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
      warehouseAddress: json['warehouseAddress'] as String?,
      warehouseCity: json['warehouseCity'] as String?,
      warehouseZip: json['warehouseZip'] as String?,
      warehouseCountry: json['warehouseCountry'] as String?,
      warehousePhone: json['warehousePhone'] as String?,
      warehouseEmail: json['warehouseEmail'] as String?,
      feedSource: json['feedSource'] as String?,
      shopUrl: json['shopUrl'] as String?,
      regulationsUrl: json['regulationsUrl'] as String?,
      termsUrl: json['termsUrl'] as String?,
      returnPolicyUrl: json['returnPolicyUrl'] as String?,
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
      'warehouseAddress': instance.warehouseAddress,
      'warehouseCity': instance.warehouseCity,
      'warehouseZip': instance.warehouseZip,
      'warehouseCountry': instance.warehouseCountry,
      'warehousePhone': instance.warehousePhone,
      'warehouseEmail': instance.warehouseEmail,
      'feedSource': instance.feedSource,
      'shopUrl': instance.shopUrl,
      'regulationsUrl': instance.regulationsUrl,
      'termsUrl': instance.termsUrl,
      'returnPolicyUrl': instance.returnPolicyUrl,
    };
