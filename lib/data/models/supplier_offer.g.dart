// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupplierOfferImpl _$$SupplierOfferImplFromJson(Map<String, dynamic> json) =>
    _$SupplierOfferImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      supplierId: json['supplierId'] as String,
      sourcePlatformId: json['sourcePlatformId'] as String,
      cost: (json['cost'] as num).toDouble(),
      shippingCost: (json['shippingCost'] as num?)?.toDouble(),
      minEstimatedDays: (json['minEstimatedDays'] as num?)?.toInt(),
      maxEstimatedDays: (json['maxEstimatedDays'] as num?)?.toInt(),
      carrierCode: json['carrierCode'] as String?,
      shippingMethodName: json['shippingMethodName'] as String?,
      lastPriceRefreshAt: json['lastPriceRefreshAt'] == null
          ? null
          : DateTime.parse(json['lastPriceRefreshAt'] as String),
      lastStockRefreshAt: json['lastStockRefreshAt'] == null
          ? null
          : DateTime.parse(json['lastStockRefreshAt'] as String),
    );

Map<String, dynamic> _$$SupplierOfferImplToJson(_$SupplierOfferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'supplierId': instance.supplierId,
      'sourcePlatformId': instance.sourcePlatformId,
      'cost': instance.cost,
      'shippingCost': instance.shippingCost,
      'minEstimatedDays': instance.minEstimatedDays,
      'maxEstimatedDays': instance.maxEstimatedDays,
      'carrierCode': instance.carrierCode,
      'shippingMethodName': instance.shippingMethodName,
      'lastPriceRefreshAt': instance.lastPriceRefreshAt?.toIso8601String(),
      'lastStockRefreshAt': instance.lastStockRefreshAt?.toIso8601String(),
    };
