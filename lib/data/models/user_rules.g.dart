// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRulesImpl _$$UserRulesImplFromJson(Map<String, dynamic> json) =>
    _$UserRulesImpl(
      minProfitPercent: (json['minProfitPercent'] as num?)?.toDouble() ?? 25.0,
      maxSourcePrice: (json['maxSourcePrice'] as num?)?.toDouble(),
      preferredSupplierCountries:
          (json['preferredSupplierCountries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      manualApprovalListings: json['manualApprovalListings'] as bool? ?? true,
      manualApprovalOrders: json['manualApprovalOrders'] as bool? ?? true,
      scanIntervalMinutes:
          (json['scanIntervalMinutes'] as num?)?.toInt() ?? 1440,
      blacklistedProductIds:
          (json['blacklistedProductIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      blacklistedSupplierIds:
          (json['blacklistedSupplierIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      defaultMarkupPercent:
          (json['defaultMarkupPercent'] as num?)?.toDouble() ?? 30.0,
      searchKeywords:
          (json['searchKeywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserRulesImplToJson(_$UserRulesImpl instance) =>
    <String, dynamic>{
      'minProfitPercent': instance.minProfitPercent,
      'maxSourcePrice': instance.maxSourcePrice,
      'preferredSupplierCountries': instance.preferredSupplierCountries,
      'manualApprovalListings': instance.manualApprovalListings,
      'manualApprovalOrders': instance.manualApprovalOrders,
      'scanIntervalMinutes': instance.scanIntervalMinutes,
      'blacklistedProductIds': instance.blacklistedProductIds,
      'blacklistedSupplierIds': instance.blacklistedSupplierIds,
      'defaultMarkupPercent': instance.defaultMarkupPercent,
      'searchKeywords': instance.searchKeywords,
    };
