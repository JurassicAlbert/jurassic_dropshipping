// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRulesImpl _$$UserRulesImplFromJson(
  Map<String, dynamic> json,
) => _$UserRulesImpl(
  minProfitPercent: (json['minProfitPercent'] as num?)?.toDouble() ?? 25.0,
  maxSourcePrice: (json['maxSourcePrice'] as num?)?.toDouble(),
  preferredSupplierCountries:
      (json['preferredSupplierCountries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  manualApprovalListings: json['manualApprovalListings'] as bool? ?? true,
  manualApprovalOrders: json['manualApprovalOrders'] as bool? ?? true,
  scanIntervalMinutes: (json['scanIntervalMinutes'] as num?)?.toInt() ?? 1440,
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
  marketplaceFees:
      (json['marketplaceFees'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const {},
  paymentFees:
      (json['paymentFees'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const {},
  sellerReturnAddress: json['sellerReturnAddress'] as Map<String, dynamic>?,
  marketplaceReturnPolicy:
      json['marketplaceReturnPolicy'] as Map<String, dynamic>? ?? const {},
  targetsReadOnly: json['targetsReadOnly'] as bool? ?? false,
  pricingStrategy: json['pricingStrategy'] as String? ?? 'always_below_lowest',
  categoryMinProfitPercent:
      (json['categoryMinProfitPercent'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const {},
  premiumWhenBetterReviewsPercent:
      (json['premiumWhenBetterReviewsPercent'] as num?)?.toDouble() ?? 2.0,
  minSalesCountForPremium:
      (json['minSalesCountForPremium'] as num?)?.toInt() ?? 10,
  kpiDrivenStrategyEnabled: json['kpiDrivenStrategyEnabled'] as bool? ?? false,
  rateLimitMaxRequestsPerSecond:
      (json['rateLimitMaxRequestsPerSecond'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  incidentRulesJson: json['incidentRulesJson'] as String?,
  riskScoreThreshold: (json['riskScoreThreshold'] as num?)?.toDouble(),
  defaultReturnRatePercent: (json['defaultReturnRatePercent'] as num?)
      ?.toDouble(),
  defaultReturnCostPerUnit: (json['defaultReturnCostPerUnit'] as num?)
      ?.toDouble(),
  blockFulfillWhenInsufficientStock:
      json['blockFulfillWhenInsufficientStock'] as bool? ?? false,
  autoPauseListingWhenMarginBelowThreshold:
      json['autoPauseListingWhenMarginBelowThreshold'] as bool? ?? false,
  defaultSupplierProcessingDays:
      (json['defaultSupplierProcessingDays'] as num?)?.toInt() ?? 2,
  defaultSupplierShippingDays:
      (json['defaultSupplierShippingDays'] as num?)?.toInt() ?? 7,
  marketplaceMaxDeliveryDays: (json['marketplaceMaxDeliveryDays'] as num?)
      ?.toInt(),
  listingHealthMaxReturnRatePercent:
      (json['listingHealthMaxReturnRatePercent'] as num?)?.toDouble(),
  listingHealthMaxLateRatePercent:
      (json['listingHealthMaxLateRatePercent'] as num?)?.toDouble(),
  autoPauseListingWhenHealthPoor:
      json['autoPauseListingWhenHealthPoor'] as bool? ?? false,
  safetyStockBuffer: (json['safetyStockBuffer'] as num?)?.toInt() ?? 0,
  customerAbuseMaxReturnRatePercent:
      (json['customerAbuseMaxReturnRatePercent'] as num?)?.toDouble(),
  customerAbuseMaxComplaintRatePercent:
      (json['customerAbuseMaxComplaintRatePercent'] as num?)?.toDouble(),
  priceRefreshIntervalMinutesBySource:
      (json['priceRefreshIntervalMinutesBySource'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, (e as num).toInt())) ??
      const {},
);

Map<String, dynamic> _$$UserRulesImplToJson(
  _$UserRulesImpl instance,
) => <String, dynamic>{
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
  'marketplaceFees': instance.marketplaceFees,
  'paymentFees': instance.paymentFees,
  'sellerReturnAddress': instance.sellerReturnAddress,
  'marketplaceReturnPolicy': instance.marketplaceReturnPolicy,
  'targetsReadOnly': instance.targetsReadOnly,
  'pricingStrategy': instance.pricingStrategy,
  'categoryMinProfitPercent': instance.categoryMinProfitPercent,
  'premiumWhenBetterReviewsPercent': instance.premiumWhenBetterReviewsPercent,
  'minSalesCountForPremium': instance.minSalesCountForPremium,
  'kpiDrivenStrategyEnabled': instance.kpiDrivenStrategyEnabled,
  'rateLimitMaxRequestsPerSecond': instance.rateLimitMaxRequestsPerSecond,
  'incidentRulesJson': instance.incidentRulesJson,
  'riskScoreThreshold': instance.riskScoreThreshold,
  'defaultReturnRatePercent': instance.defaultReturnRatePercent,
  'defaultReturnCostPerUnit': instance.defaultReturnCostPerUnit,
  'blockFulfillWhenInsufficientStock':
      instance.blockFulfillWhenInsufficientStock,
  'autoPauseListingWhenMarginBelowThreshold':
      instance.autoPauseListingWhenMarginBelowThreshold,
  'defaultSupplierProcessingDays': instance.defaultSupplierProcessingDays,
  'defaultSupplierShippingDays': instance.defaultSupplierShippingDays,
  'marketplaceMaxDeliveryDays': instance.marketplaceMaxDeliveryDays,
  'listingHealthMaxReturnRatePercent':
      instance.listingHealthMaxReturnRatePercent,
  'listingHealthMaxLateRatePercent': instance.listingHealthMaxLateRatePercent,
  'autoPauseListingWhenHealthPoor': instance.autoPauseListingWhenHealthPoor,
  'safetyStockBuffer': instance.safetyStockBuffer,
  'customerAbuseMaxReturnRatePercent':
      instance.customerAbuseMaxReturnRatePercent,
  'customerAbuseMaxComplaintRatePercent':
      instance.customerAbuseMaxComplaintRatePercent,
  'priceRefreshIntervalMinutesBySource':
      instance.priceRefreshIntervalMinutesBySource,
};
