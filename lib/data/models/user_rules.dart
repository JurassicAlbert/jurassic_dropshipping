import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_rules.freezed.dart';
part 'user_rules.g.dart';

/// Seller's address for returns when customer sends package to seller (not to supplier).
class SellerReturnAddress {
  const SellerReturnAddress({
    this.street,
    this.city,
    this.zip,
    this.countryCode,
  });
  final String? street;
  final String? city;
  final String? zip;
  final String? countryCode;

  Map<String, dynamic> toJson() => {
        if (street != null) 'street': street,
        if (city != null) 'city': city,
        if (zip != null) 'zip': zip,
        if (countryCode != null) 'countryCode': countryCode,
      };

  factory SellerReturnAddress.fromJson(Map<String, dynamic> json) =>
      SellerReturnAddress(
        street: json['street'] as String?,
        city: json['city'] as String?,
        zip: json['zip'] as String?,
        countryCode: json['countryCode'] as String?,
      );
}

/// Per-marketplace return policy: window, grace days, reject after grace.
class MarketplaceReturnPolicy {
  const MarketplaceReturnPolicy({
    this.returnWindowDays = 14,
    this.graceDays = 2,
    this.rejectAfterGrace = true,
  });
  final int returnWindowDays;
  final int graceDays;
  final bool rejectAfterGrace;

  Map<String, dynamic> toJson() => {
        'returnWindowDays': returnWindowDays,
        'graceDays': graceDays,
        'rejectAfterGrace': rejectAfterGrace,
      };

  factory MarketplaceReturnPolicy.fromJson(Map<String, dynamic> json) =>
      MarketplaceReturnPolicy(
        returnWindowDays: (json['returnWindowDays'] as num?)?.toInt() ?? 14,
        graceDays: (json['graceDays'] as num?)?.toInt() ?? 2,
        rejectAfterGrace: json['rejectAfterGrace'] as bool? ?? true,
      );
}

@freezed
class UserRules with _$UserRules {
  const factory UserRules({
    @Default(25.0) double minProfitPercent,
    double? maxSourcePrice,
    @Default([]) List<String> preferredSupplierCountries,
    @Default(true) bool manualApprovalListings,
    @Default(true) bool manualApprovalOrders,
    @Default(1440) int scanIntervalMinutes,
    @Default([]) List<String> blacklistedProductIds,
    @Default([]) List<String> blacklistedSupplierIds,
    @Default(30.0) double defaultMarkupPercent,
    @Default([]) List<String> searchKeywords,
    @Default({}) Map<String, double> marketplaceFees,
    Map<String, dynamic>? sellerReturnAddress,
    @Default({}) Map<String, dynamic> marketplaceReturnPolicy,
  }) = _UserRules;

  factory UserRules.fromJson(Map<String, dynamic> json) =>
      _$UserRulesFromJson(json);
}

/// Extension to parse nested rule data.
extension UserRulesParsed on UserRules {
  /// Parsed seller return address, or null if not set.
  SellerReturnAddress? get sellerReturnAddressParsed =>
      sellerReturnAddress != null && sellerReturnAddress!.isNotEmpty
          ? SellerReturnAddress.fromJson(sellerReturnAddress!)
          : null;

  /// Parsed per-platform return policies.
  Map<String, MarketplaceReturnPolicy> get marketplaceReturnPolicyParsed =>
      marketplaceReturnPolicy.map(
        (k, v) => MapEntry(k, MarketplaceReturnPolicy.fromJson(v as Map<String, dynamic>)),
      );
}
