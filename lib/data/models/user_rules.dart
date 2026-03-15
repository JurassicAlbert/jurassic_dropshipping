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
    /// Per-platform payment processing fee % (e.g. card/PayU). Added to marketplace fee for P_min.
    @Default({}) Map<String, double> paymentFees,
    Map<String, dynamic>? sellerReturnAddress,
    @Default({}) Map<String, dynamic> marketplaceReturnPolicy,
    /// When true, automation will not perform write operations on target marketplaces
    /// (no create/update listings, cancel orders, or push tracking). Use this as a
    /// global \"read-only\"/dry-run mode when connecting real accounts.
    @Default(false) bool targetsReadOnly,
    /// Pricing strategy:
    /// - always_below_lowest
    /// - premium_when_better_reviews
    /// - match_lowest
    /// - fixed_markup
    /// - list_at_min_even_if_above_lowest (still list at P_min even when above lowest)
    @Default('always_below_lowest') String pricingStrategy,
    /// Per-category min profit % (categoryId -> percent). Fallback: minProfitPercent.
    @Default({}) Map<String, double> categoryMinProfitPercent,
    /// When strategy is premium_when_better_reviews: allow this % above lowest competitor (e.g. 2.0 = 2%).
    @Default(2.0) double premiumWhenBetterReviewsPercent,
    /// Min sales count on our listing to consider premium (better reviews) pricing.
    @Default(10) int minSalesCountForPremium,
    /// When true, app may suggest or auto-select strategy based on KPI (conversion, margin).
    @Default(false) bool kpiDrivenStrategyEnabled,
    /// Per-platform API rate limit: platformId -> max requests per second (e.g. allegro: 5, cj: 10).
    @Default({}) Map<String, int> rateLimitMaxRequestsPerSecond,
    /// Phase 8: incident decision rules – JSON array of { "condition": "...", "action": "..." }. Nullable.
    String? incidentRulesJson,
    /// Phase 16: if order risk score > this (0–100), set to pendingApproval. Null when disabled.
    double? riskScoreThreshold,
    /// Phase 17: default expected return rate % for return-rate-aware P_min (e.g. 15 = 15%). Null when not used.
    double? defaultReturnRatePercent,
    /// Phase 17: default return cost per unit (PLN) for return-rate-aware P_min. Null when not used.
    double? defaultReturnCostPerUnit,
    /// When true, fulfillment is skipped when inventory availableToSell < order quantity (Phase 18).
    @Default(false) bool blockFulfillWhenInsufficientStock,
    /// Phase 20: when true, ProfitGuardService will set listing status to paused when margin < minProfitPercent.
    @Default(false) bool autoPauseListingWhenMarginBelowThreshold,
    /// Phase 21: default supplier processing time (days) before shipment. Used for delivery validation.
    @Default(2) int defaultSupplierProcessingDays,
    /// Phase 21: default supplier shipping time (days) when product.estimatedDays is null.
    @Default(7) int defaultSupplierShippingDays,
    /// Phase 21: when set, listing is rejected if expected delivery (processing + shipping) > this (marketplace max).
    int? marketplaceMaxDeliveryDays,
    /// Phase 26: max return+incident rate % for listing health; when exceeded and auto-pause on, listing is paused. Null = no limit.
    double? listingHealthMaxReturnRatePercent,
    /// Phase 26: max late delivery rate % for listing health; when exceeded and auto-pause on, listing is paused. Null = no limit.
    double? listingHealthMaxLateRatePercent,
    /// Phase 26: when true, ListingHealthScoringService pauses listings whose return or late rate exceeds the above thresholds.
    @Default(false) bool autoPauseListingWhenHealthPoor,
    /// Phase 19: reduce effective available-to-sell by this many units to account for supplier stock drift (list/fulfill more conservatively).
    @Default(0) int safetyStockBuffer,
    /// Phase 25: max return rate % for customer; when exceeded, new orders from that customer get pendingApproval. Null = no check.
    double? customerAbuseMaxReturnRatePercent,
    /// Phase 25: max complaint (incident) rate % for customer; when exceeded, new orders get pendingApproval. Null = no check.
    double? customerAbuseMaxComplaintRatePercent,
    /// Per-warehouse/source price refresh interval (minutes). Key = sourcePlatformId, value = minutes (e.g. 720 = 12h).
    /// Warehouses publish new prices 1–2×/day at different times; we pull from XML/CSV/API when offers are stale for that source. Missing key uses default 720.
    @Default({}) Map<String, int> priceRefreshIntervalMinutesBySource,
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
