// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductVariantImpl _$$ProductVariantImplFromJson(Map<String, dynamic> json) =>
    _$ProductVariantImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      attributes: Map<String, String>.from(json['attributes'] as Map),
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      sku: json['sku'] as String?,
    );

Map<String, dynamic> _$$ProductVariantImplToJson(
  _$ProductVariantImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'attributes': instance.attributes,
  'price': instance.price,
  'stock': instance.stock,
  'sku': instance.sku,
};

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      sourceId: json['sourceId'] as String,
      sourcePlatformId: json['sourcePlatformId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      basePrice: (json['basePrice'] as num).toDouble(),
      shippingCost: (json['shippingCost'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'PLN',
      supplierId: json['supplierId'] as String?,
      supplierCountry: json['supplierCountry'] as String?,
      estimatedDays: (json['estimatedDays'] as num?)?.toInt(),
      rawJson: json['rawJson'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceId': instance.sourceId,
      'sourcePlatformId': instance.sourcePlatformId,
      'title': instance.title,
      'description': instance.description,
      'imageUrls': instance.imageUrls,
      'variants': instance.variants,
      'basePrice': instance.basePrice,
      'shippingCost': instance.shippingCost,
      'currency': instance.currency,
      'supplierId': instance.supplierId,
      'supplierCountry': instance.supplierCountry,
      'estimatedDays': instance.estimatedDays,
      'rawJson': instance.rawJson,
    };
