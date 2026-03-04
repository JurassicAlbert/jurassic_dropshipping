// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListingImpl _$$ListingImplFromJson(Map<String, dynamic> json) =>
    _$ListingImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      targetPlatformId: json['targetPlatformId'] as String,
      targetListingId: json['targetListingId'] as String?,
      status: $enumDecode(_$ListingStatusEnumMap, json['status']),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      sourceCost: (json['sourceCost'] as num).toDouble(),
      decisionLogId: json['decisionLogId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$$ListingImplToJson(_$ListingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'targetPlatformId': instance.targetPlatformId,
      'targetListingId': instance.targetListingId,
      'status': _$ListingStatusEnumMap[instance.status]!,
      'sellingPrice': instance.sellingPrice,
      'sourceCost': instance.sourceCost,
      'decisionLogId': instance.decisionLogId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'publishedAt': instance.publishedAt?.toIso8601String(),
    };

const _$ListingStatusEnumMap = {
  ListingStatus.draft: 'draft',
  ListingStatus.pendingApproval: 'pendingApproval',
  ListingStatus.active: 'active',
  ListingStatus.soldOut: 'soldOut',
};
