// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarketplaceAccountImpl _$$MarketplaceAccountImplFromJson(
  Map<String, dynamic> json,
) => _$MarketplaceAccountImpl(
  id: json['id'] as String,
  platformId: json['platformId'] as String,
  displayName: json['displayName'] as String,
  isActive: json['isActive'] as bool? ?? false,
  connectedAt: json['connectedAt'] == null
      ? null
      : DateTime.parse(json['connectedAt'] as String),
);

Map<String, dynamic> _$$MarketplaceAccountImplToJson(
  _$MarketplaceAccountImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'platformId': instance.platformId,
  'displayName': instance.displayName,
  'isActive': instance.isActive,
  'connectedAt': instance.connectedAt?.toIso8601String(),
};
