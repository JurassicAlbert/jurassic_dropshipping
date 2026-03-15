// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserRules _$UserRulesFromJson(Map<String, dynamic> json) {
  return _UserRules.fromJson(json);
}

/// @nodoc
mixin _$UserRules {
  double get minProfitPercent => throw _privateConstructorUsedError;
  double? get maxSourcePrice => throw _privateConstructorUsedError;
  List<String> get preferredSupplierCountries =>
      throw _privateConstructorUsedError;
  bool get manualApprovalListings => throw _privateConstructorUsedError;
  bool get manualApprovalOrders => throw _privateConstructorUsedError;
  int get scanIntervalMinutes => throw _privateConstructorUsedError;
  List<String> get blacklistedProductIds => throw _privateConstructorUsedError;
  List<String> get blacklistedSupplierIds => throw _privateConstructorUsedError;
  double get defaultMarkupPercent => throw _privateConstructorUsedError;
  List<String> get searchKeywords => throw _privateConstructorUsedError;
  Map<String, double> get marketplaceFees => throw _privateConstructorUsedError;

  /// Per-platform payment processing fee % (e.g. card/PayU). Added to marketplace fee for P_min.
  Map<String, double> get paymentFees => throw _privateConstructorUsedError;
  Map<String, dynamic>? get sellerReturnAddress =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get marketplaceReturnPolicy =>
      throw _privateConstructorUsedError;

  /// When true, automation will not perform write operations on target marketplaces
  /// (no create/update listings, cancel orders, or push tracking). Use this as a
  /// global \"read-only\"/dry-run mode when connecting real accounts.
  bool get targetsReadOnly => throw _privateConstructorUsedError;

  /// Pricing strategy:
  /// - always_below_lowest
  /// - premium_when_better_reviews
  /// - match_lowest
  /// - fixed_markup
  /// - list_at_min_even_if_above_lowest (still list at P_min even when above lowest)
  String get pricingStrategy => throw _privateConstructorUsedError;

  /// Per-category min profit % (categoryId -> percent). Fallback: minProfitPercent.
  Map<String, double> get categoryMinProfitPercent =>
      throw _privateConstructorUsedError;

  /// When strategy is premium_when_better_reviews: allow this % above lowest competitor (e.g. 2.0 = 2%).
  double get premiumWhenBetterReviewsPercent =>
      throw _privateConstructorUsedError;

  /// Min sales count on our listing to consider premium (better reviews) pricing.
  int get minSalesCountForPremium => throw _privateConstructorUsedError;

  /// When true, app may suggest or auto-select strategy based on KPI (conversion, margin).
  bool get kpiDrivenStrategyEnabled => throw _privateConstructorUsedError;

  /// Per-platform API rate limit: platformId -> max requests per second (e.g. allegro: 5, cj: 10).
  Map<String, int> get rateLimitMaxRequestsPerSecond =>
      throw _privateConstructorUsedError;

  /// Phase 8: incident decision rules – JSON array of { "condition": "...", "action": "..." }. Nullable.
  String? get incidentRulesJson => throw _privateConstructorUsedError;

  /// Phase 16: if order risk score > this (0–100), set to pendingApproval. Null when disabled.
  double? get riskScoreThreshold => throw _privateConstructorUsedError;

  /// Phase 17: default expected return rate % for return-rate-aware P_min (e.g. 15 = 15%). Null when not used.
  double? get defaultReturnRatePercent => throw _privateConstructorUsedError;

  /// Phase 17: default return cost per unit (PLN) for return-rate-aware P_min. Null when not used.
  double? get defaultReturnCostPerUnit => throw _privateConstructorUsedError;

  /// When true, fulfillment is skipped when inventory availableToSell < order quantity (Phase 18).
  bool get blockFulfillWhenInsufficientStock =>
      throw _privateConstructorUsedError;

  /// Phase 20: when true, ProfitGuardService will set listing status to paused when margin < minProfitPercent.
  bool get autoPauseListingWhenMarginBelowThreshold =>
      throw _privateConstructorUsedError;

  /// Phase 21: default supplier processing time (days) before shipment. Used for delivery validation.
  int get defaultSupplierProcessingDays => throw _privateConstructorUsedError;

  /// Phase 21: default supplier shipping time (days) when product.estimatedDays is null.
  int get defaultSupplierShippingDays => throw _privateConstructorUsedError;

  /// Phase 21: when set, listing is rejected if expected delivery (processing + shipping) > this (marketplace max).
  int? get marketplaceMaxDeliveryDays => throw _privateConstructorUsedError;

  /// Phase 26: max return+incident rate % for listing health; when exceeded and auto-pause on, listing is paused. Null = no limit.
  double? get listingHealthMaxReturnRatePercent =>
      throw _privateConstructorUsedError;

  /// Phase 26: max late delivery rate % for listing health; when exceeded and auto-pause on, listing is paused. Null = no limit.
  double? get listingHealthMaxLateRatePercent =>
      throw _privateConstructorUsedError;

  /// Phase 26: when true, ListingHealthScoringService pauses listings whose return or late rate exceeds the above thresholds.
  bool get autoPauseListingWhenHealthPoor => throw _privateConstructorUsedError;

  /// Phase 19: reduce effective available-to-sell by this many units to account for supplier stock drift (list/fulfill more conservatively).
  int get safetyStockBuffer => throw _privateConstructorUsedError;

  /// Phase 25: max return rate % for customer; when exceeded, new orders from that customer get pendingApproval. Null = no check.
  double? get customerAbuseMaxReturnRatePercent =>
      throw _privateConstructorUsedError;

  /// Phase 25: max complaint (incident) rate % for customer; when exceeded, new orders get pendingApproval. Null = no check.
  double? get customerAbuseMaxComplaintRatePercent =>
      throw _privateConstructorUsedError;

  /// Per-warehouse/source price refresh interval (minutes). Key = sourcePlatformId, value = minutes (e.g. 720 = 12h).
  /// Warehouses publish new prices 1–2×/day at different times; we pull from XML/CSV/API when offers are stale for that source. Missing key uses default 720.
  Map<String, int> get priceRefreshIntervalMinutesBySource =>
      throw _privateConstructorUsedError;

  /// Serializes this UserRules to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserRules
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRulesCopyWith<UserRules> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRulesCopyWith<$Res> {
  factory $UserRulesCopyWith(UserRules value, $Res Function(UserRules) then) =
      _$UserRulesCopyWithImpl<$Res, UserRules>;
  @useResult
  $Res call({
    double minProfitPercent,
    double? maxSourcePrice,
    List<String> preferredSupplierCountries,
    bool manualApprovalListings,
    bool manualApprovalOrders,
    int scanIntervalMinutes,
    List<String> blacklistedProductIds,
    List<String> blacklistedSupplierIds,
    double defaultMarkupPercent,
    List<String> searchKeywords,
    Map<String, double> marketplaceFees,
    Map<String, double> paymentFees,
    Map<String, dynamic>? sellerReturnAddress,
    Map<String, dynamic> marketplaceReturnPolicy,
    bool targetsReadOnly,
    String pricingStrategy,
    Map<String, double> categoryMinProfitPercent,
    double premiumWhenBetterReviewsPercent,
    int minSalesCountForPremium,
    bool kpiDrivenStrategyEnabled,
    Map<String, int> rateLimitMaxRequestsPerSecond,
    String? incidentRulesJson,
    double? riskScoreThreshold,
    double? defaultReturnRatePercent,
    double? defaultReturnCostPerUnit,
    bool blockFulfillWhenInsufficientStock,
    bool autoPauseListingWhenMarginBelowThreshold,
    int defaultSupplierProcessingDays,
    int defaultSupplierShippingDays,
    int? marketplaceMaxDeliveryDays,
    double? listingHealthMaxReturnRatePercent,
    double? listingHealthMaxLateRatePercent,
    bool autoPauseListingWhenHealthPoor,
    int safetyStockBuffer,
    double? customerAbuseMaxReturnRatePercent,
    double? customerAbuseMaxComplaintRatePercent,
    Map<String, int> priceRefreshIntervalMinutesBySource,
  });
}

/// @nodoc
class _$UserRulesCopyWithImpl<$Res, $Val extends UserRules>
    implements $UserRulesCopyWith<$Res> {
  _$UserRulesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRules
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minProfitPercent = null,
    Object? maxSourcePrice = freezed,
    Object? preferredSupplierCountries = null,
    Object? manualApprovalListings = null,
    Object? manualApprovalOrders = null,
    Object? scanIntervalMinutes = null,
    Object? blacklistedProductIds = null,
    Object? blacklistedSupplierIds = null,
    Object? defaultMarkupPercent = null,
    Object? searchKeywords = null,
    Object? marketplaceFees = null,
    Object? paymentFees = null,
    Object? sellerReturnAddress = freezed,
    Object? marketplaceReturnPolicy = null,
    Object? targetsReadOnly = null,
    Object? pricingStrategy = null,
    Object? categoryMinProfitPercent = null,
    Object? premiumWhenBetterReviewsPercent = null,
    Object? minSalesCountForPremium = null,
    Object? kpiDrivenStrategyEnabled = null,
    Object? rateLimitMaxRequestsPerSecond = null,
    Object? incidentRulesJson = freezed,
    Object? riskScoreThreshold = freezed,
    Object? defaultReturnRatePercent = freezed,
    Object? defaultReturnCostPerUnit = freezed,
    Object? blockFulfillWhenInsufficientStock = null,
    Object? autoPauseListingWhenMarginBelowThreshold = null,
    Object? defaultSupplierProcessingDays = null,
    Object? defaultSupplierShippingDays = null,
    Object? marketplaceMaxDeliveryDays = freezed,
    Object? listingHealthMaxReturnRatePercent = freezed,
    Object? listingHealthMaxLateRatePercent = freezed,
    Object? autoPauseListingWhenHealthPoor = null,
    Object? safetyStockBuffer = null,
    Object? customerAbuseMaxReturnRatePercent = freezed,
    Object? customerAbuseMaxComplaintRatePercent = freezed,
    Object? priceRefreshIntervalMinutesBySource = null,
  }) {
    return _then(
      _value.copyWith(
            minProfitPercent: null == minProfitPercent
                ? _value.minProfitPercent
                : minProfitPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            maxSourcePrice: freezed == maxSourcePrice
                ? _value.maxSourcePrice
                : maxSourcePrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            preferredSupplierCountries: null == preferredSupplierCountries
                ? _value.preferredSupplierCountries
                : preferredSupplierCountries // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            manualApprovalListings: null == manualApprovalListings
                ? _value.manualApprovalListings
                : manualApprovalListings // ignore: cast_nullable_to_non_nullable
                      as bool,
            manualApprovalOrders: null == manualApprovalOrders
                ? _value.manualApprovalOrders
                : manualApprovalOrders // ignore: cast_nullable_to_non_nullable
                      as bool,
            scanIntervalMinutes: null == scanIntervalMinutes
                ? _value.scanIntervalMinutes
                : scanIntervalMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            blacklistedProductIds: null == blacklistedProductIds
                ? _value.blacklistedProductIds
                : blacklistedProductIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            blacklistedSupplierIds: null == blacklistedSupplierIds
                ? _value.blacklistedSupplierIds
                : blacklistedSupplierIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            defaultMarkupPercent: null == defaultMarkupPercent
                ? _value.defaultMarkupPercent
                : defaultMarkupPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            searchKeywords: null == searchKeywords
                ? _value.searchKeywords
                : searchKeywords // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            marketplaceFees: null == marketplaceFees
                ? _value.marketplaceFees
                : marketplaceFees // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            paymentFees: null == paymentFees
                ? _value.paymentFees
                : paymentFees // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            sellerReturnAddress: freezed == sellerReturnAddress
                ? _value.sellerReturnAddress
                : sellerReturnAddress // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            marketplaceReturnPolicy: null == marketplaceReturnPolicy
                ? _value.marketplaceReturnPolicy
                : marketplaceReturnPolicy // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            targetsReadOnly: null == targetsReadOnly
                ? _value.targetsReadOnly
                : targetsReadOnly // ignore: cast_nullable_to_non_nullable
                      as bool,
            pricingStrategy: null == pricingStrategy
                ? _value.pricingStrategy
                : pricingStrategy // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryMinProfitPercent: null == categoryMinProfitPercent
                ? _value.categoryMinProfitPercent
                : categoryMinProfitPercent // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            premiumWhenBetterReviewsPercent:
                null == premiumWhenBetterReviewsPercent
                ? _value.premiumWhenBetterReviewsPercent
                : premiumWhenBetterReviewsPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            minSalesCountForPremium: null == minSalesCountForPremium
                ? _value.minSalesCountForPremium
                : minSalesCountForPremium // ignore: cast_nullable_to_non_nullable
                      as int,
            kpiDrivenStrategyEnabled: null == kpiDrivenStrategyEnabled
                ? _value.kpiDrivenStrategyEnabled
                : kpiDrivenStrategyEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            rateLimitMaxRequestsPerSecond: null == rateLimitMaxRequestsPerSecond
                ? _value.rateLimitMaxRequestsPerSecond
                : rateLimitMaxRequestsPerSecond // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            incidentRulesJson: freezed == incidentRulesJson
                ? _value.incidentRulesJson
                : incidentRulesJson // ignore: cast_nullable_to_non_nullable
                      as String?,
            riskScoreThreshold: freezed == riskScoreThreshold
                ? _value.riskScoreThreshold
                : riskScoreThreshold // ignore: cast_nullable_to_non_nullable
                      as double?,
            defaultReturnRatePercent: freezed == defaultReturnRatePercent
                ? _value.defaultReturnRatePercent
                : defaultReturnRatePercent // ignore: cast_nullable_to_non_nullable
                      as double?,
            defaultReturnCostPerUnit: freezed == defaultReturnCostPerUnit
                ? _value.defaultReturnCostPerUnit
                : defaultReturnCostPerUnit // ignore: cast_nullable_to_non_nullable
                      as double?,
            blockFulfillWhenInsufficientStock:
                null == blockFulfillWhenInsufficientStock
                ? _value.blockFulfillWhenInsufficientStock
                : blockFulfillWhenInsufficientStock // ignore: cast_nullable_to_non_nullable
                      as bool,
            autoPauseListingWhenMarginBelowThreshold:
                null == autoPauseListingWhenMarginBelowThreshold
                ? _value.autoPauseListingWhenMarginBelowThreshold
                : autoPauseListingWhenMarginBelowThreshold // ignore: cast_nullable_to_non_nullable
                      as bool,
            defaultSupplierProcessingDays: null == defaultSupplierProcessingDays
                ? _value.defaultSupplierProcessingDays
                : defaultSupplierProcessingDays // ignore: cast_nullable_to_non_nullable
                      as int,
            defaultSupplierShippingDays: null == defaultSupplierShippingDays
                ? _value.defaultSupplierShippingDays
                : defaultSupplierShippingDays // ignore: cast_nullable_to_non_nullable
                      as int,
            marketplaceMaxDeliveryDays: freezed == marketplaceMaxDeliveryDays
                ? _value.marketplaceMaxDeliveryDays
                : marketplaceMaxDeliveryDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            listingHealthMaxReturnRatePercent:
                freezed == listingHealthMaxReturnRatePercent
                ? _value.listingHealthMaxReturnRatePercent
                : listingHealthMaxReturnRatePercent // ignore: cast_nullable_to_non_nullable
                      as double?,
            listingHealthMaxLateRatePercent:
                freezed == listingHealthMaxLateRatePercent
                ? _value.listingHealthMaxLateRatePercent
                : listingHealthMaxLateRatePercent // ignore: cast_nullable_to_non_nullable
                      as double?,
            autoPauseListingWhenHealthPoor:
                null == autoPauseListingWhenHealthPoor
                ? _value.autoPauseListingWhenHealthPoor
                : autoPauseListingWhenHealthPoor // ignore: cast_nullable_to_non_nullable
                      as bool,
            safetyStockBuffer: null == safetyStockBuffer
                ? _value.safetyStockBuffer
                : safetyStockBuffer // ignore: cast_nullable_to_non_nullable
                      as int,
            customerAbuseMaxReturnRatePercent:
                freezed == customerAbuseMaxReturnRatePercent
                ? _value.customerAbuseMaxReturnRatePercent
                : customerAbuseMaxReturnRatePercent // ignore: cast_nullable_to_non_nullable
                      as double?,
            customerAbuseMaxComplaintRatePercent:
                freezed == customerAbuseMaxComplaintRatePercent
                ? _value.customerAbuseMaxComplaintRatePercent
                : customerAbuseMaxComplaintRatePercent // ignore: cast_nullable_to_non_nullable
                      as double?,
            priceRefreshIntervalMinutesBySource:
                null == priceRefreshIntervalMinutesBySource
                ? _value.priceRefreshIntervalMinutesBySource
                : priceRefreshIntervalMinutesBySource // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserRulesImplCopyWith<$Res>
    implements $UserRulesCopyWith<$Res> {
  factory _$$UserRulesImplCopyWith(
    _$UserRulesImpl value,
    $Res Function(_$UserRulesImpl) then,
  ) = __$$UserRulesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double minProfitPercent,
    double? maxSourcePrice,
    List<String> preferredSupplierCountries,
    bool manualApprovalListings,
    bool manualApprovalOrders,
    int scanIntervalMinutes,
    List<String> blacklistedProductIds,
    List<String> blacklistedSupplierIds,
    double defaultMarkupPercent,
    List<String> searchKeywords,
    Map<String, double> marketplaceFees,
    Map<String, double> paymentFees,
    Map<String, dynamic>? sellerReturnAddress,
    Map<String, dynamic> marketplaceReturnPolicy,
    bool targetsReadOnly,
    String pricingStrategy,
    Map<String, double> categoryMinProfitPercent,
    double premiumWhenBetterReviewsPercent,
    int minSalesCountForPremium,
    bool kpiDrivenStrategyEnabled,
    Map<String, int> rateLimitMaxRequestsPerSecond,
    String? incidentRulesJson,
    double? riskScoreThreshold,
    double? defaultReturnRatePercent,
    double? defaultReturnCostPerUnit,
    bool blockFulfillWhenInsufficientStock,
    bool autoPauseListingWhenMarginBelowThreshold,
    int defaultSupplierProcessingDays,
    int defaultSupplierShippingDays,
    int? marketplaceMaxDeliveryDays,
    double? listingHealthMaxReturnRatePercent,
    double? listingHealthMaxLateRatePercent,
    bool autoPauseListingWhenHealthPoor,
    int safetyStockBuffer,
    double? customerAbuseMaxReturnRatePercent,
    double? customerAbuseMaxComplaintRatePercent,
    Map<String, int> priceRefreshIntervalMinutesBySource,
  });
}

/// @nodoc
class __$$UserRulesImplCopyWithImpl<$Res>
    extends _$UserRulesCopyWithImpl<$Res, _$UserRulesImpl>
    implements _$$UserRulesImplCopyWith<$Res> {
  __$$UserRulesImplCopyWithImpl(
    _$UserRulesImpl _value,
    $Res Function(_$UserRulesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserRules
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minProfitPercent = null,
    Object? maxSourcePrice = freezed,
    Object? preferredSupplierCountries = null,
    Object? manualApprovalListings = null,
    Object? manualApprovalOrders = null,
    Object? scanIntervalMinutes = null,
    Object? blacklistedProductIds = null,
    Object? blacklistedSupplierIds = null,
    Object? defaultMarkupPercent = null,
    Object? searchKeywords = null,
    Object? marketplaceFees = null,
    Object? paymentFees = null,
    Object? sellerReturnAddress = freezed,
    Object? marketplaceReturnPolicy = null,
    Object? targetsReadOnly = null,
    Object? pricingStrategy = null,
    Object? categoryMinProfitPercent = null,
    Object? premiumWhenBetterReviewsPercent = null,
    Object? minSalesCountForPremium = null,
    Object? kpiDrivenStrategyEnabled = null,
    Object? rateLimitMaxRequestsPerSecond = null,
    Object? incidentRulesJson = freezed,
    Object? riskScoreThreshold = freezed,
    Object? defaultReturnRatePercent = freezed,
    Object? defaultReturnCostPerUnit = freezed,
    Object? blockFulfillWhenInsufficientStock = null,
    Object? autoPauseListingWhenMarginBelowThreshold = null,
    Object? defaultSupplierProcessingDays = null,
    Object? defaultSupplierShippingDays = null,
    Object? marketplaceMaxDeliveryDays = freezed,
    Object? listingHealthMaxReturnRatePercent = freezed,
    Object? listingHealthMaxLateRatePercent = freezed,
    Object? autoPauseListingWhenHealthPoor = null,
    Object? safetyStockBuffer = null,
    Object? customerAbuseMaxReturnRatePercent = freezed,
    Object? customerAbuseMaxComplaintRatePercent = freezed,
    Object? priceRefreshIntervalMinutesBySource = null,
  }) {
    return _then(
      _$UserRulesImpl(
        minProfitPercent: null == minProfitPercent
            ? _value.minProfitPercent
            : minProfitPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        maxSourcePrice: freezed == maxSourcePrice
            ? _value.maxSourcePrice
            : maxSourcePrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        preferredSupplierCountries: null == preferredSupplierCountries
            ? _value._preferredSupplierCountries
            : preferredSupplierCountries // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        manualApprovalListings: null == manualApprovalListings
            ? _value.manualApprovalListings
            : manualApprovalListings // ignore: cast_nullable_to_non_nullable
                  as bool,
        manualApprovalOrders: null == manualApprovalOrders
            ? _value.manualApprovalOrders
            : manualApprovalOrders // ignore: cast_nullable_to_non_nullable
                  as bool,
        scanIntervalMinutes: null == scanIntervalMinutes
            ? _value.scanIntervalMinutes
            : scanIntervalMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        blacklistedProductIds: null == blacklistedProductIds
            ? _value._blacklistedProductIds
            : blacklistedProductIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        blacklistedSupplierIds: null == blacklistedSupplierIds
            ? _value._blacklistedSupplierIds
            : blacklistedSupplierIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        defaultMarkupPercent: null == defaultMarkupPercent
            ? _value.defaultMarkupPercent
            : defaultMarkupPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        searchKeywords: null == searchKeywords
            ? _value._searchKeywords
            : searchKeywords // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        marketplaceFees: null == marketplaceFees
            ? _value._marketplaceFees
            : marketplaceFees // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        paymentFees: null == paymentFees
            ? _value._paymentFees
            : paymentFees // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        sellerReturnAddress: freezed == sellerReturnAddress
            ? _value._sellerReturnAddress
            : sellerReturnAddress // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        marketplaceReturnPolicy: null == marketplaceReturnPolicy
            ? _value._marketplaceReturnPolicy
            : marketplaceReturnPolicy // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        targetsReadOnly: null == targetsReadOnly
            ? _value.targetsReadOnly
            : targetsReadOnly // ignore: cast_nullable_to_non_nullable
                  as bool,
        pricingStrategy: null == pricingStrategy
            ? _value.pricingStrategy
            : pricingStrategy // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryMinProfitPercent: null == categoryMinProfitPercent
            ? _value._categoryMinProfitPercent
            : categoryMinProfitPercent // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        premiumWhenBetterReviewsPercent: null == premiumWhenBetterReviewsPercent
            ? _value.premiumWhenBetterReviewsPercent
            : premiumWhenBetterReviewsPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        minSalesCountForPremium: null == minSalesCountForPremium
            ? _value.minSalesCountForPremium
            : minSalesCountForPremium // ignore: cast_nullable_to_non_nullable
                  as int,
        kpiDrivenStrategyEnabled: null == kpiDrivenStrategyEnabled
            ? _value.kpiDrivenStrategyEnabled
            : kpiDrivenStrategyEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        rateLimitMaxRequestsPerSecond: null == rateLimitMaxRequestsPerSecond
            ? _value._rateLimitMaxRequestsPerSecond
            : rateLimitMaxRequestsPerSecond // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        incidentRulesJson: freezed == incidentRulesJson
            ? _value.incidentRulesJson
            : incidentRulesJson // ignore: cast_nullable_to_non_nullable
                  as String?,
        riskScoreThreshold: freezed == riskScoreThreshold
            ? _value.riskScoreThreshold
            : riskScoreThreshold // ignore: cast_nullable_to_non_nullable
                  as double?,
        defaultReturnRatePercent: freezed == defaultReturnRatePercent
            ? _value.defaultReturnRatePercent
            : defaultReturnRatePercent // ignore: cast_nullable_to_non_nullable
                  as double?,
        defaultReturnCostPerUnit: freezed == defaultReturnCostPerUnit
            ? _value.defaultReturnCostPerUnit
            : defaultReturnCostPerUnit // ignore: cast_nullable_to_non_nullable
                  as double?,
        blockFulfillWhenInsufficientStock:
            null == blockFulfillWhenInsufficientStock
            ? _value.blockFulfillWhenInsufficientStock
            : blockFulfillWhenInsufficientStock // ignore: cast_nullable_to_non_nullable
                  as bool,
        autoPauseListingWhenMarginBelowThreshold:
            null == autoPauseListingWhenMarginBelowThreshold
            ? _value.autoPauseListingWhenMarginBelowThreshold
            : autoPauseListingWhenMarginBelowThreshold // ignore: cast_nullable_to_non_nullable
                  as bool,
        defaultSupplierProcessingDays: null == defaultSupplierProcessingDays
            ? _value.defaultSupplierProcessingDays
            : defaultSupplierProcessingDays // ignore: cast_nullable_to_non_nullable
                  as int,
        defaultSupplierShippingDays: null == defaultSupplierShippingDays
            ? _value.defaultSupplierShippingDays
            : defaultSupplierShippingDays // ignore: cast_nullable_to_non_nullable
                  as int,
        marketplaceMaxDeliveryDays: freezed == marketplaceMaxDeliveryDays
            ? _value.marketplaceMaxDeliveryDays
            : marketplaceMaxDeliveryDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        listingHealthMaxReturnRatePercent:
            freezed == listingHealthMaxReturnRatePercent
            ? _value.listingHealthMaxReturnRatePercent
            : listingHealthMaxReturnRatePercent // ignore: cast_nullable_to_non_nullable
                  as double?,
        listingHealthMaxLateRatePercent:
            freezed == listingHealthMaxLateRatePercent
            ? _value.listingHealthMaxLateRatePercent
            : listingHealthMaxLateRatePercent // ignore: cast_nullable_to_non_nullable
                  as double?,
        autoPauseListingWhenHealthPoor: null == autoPauseListingWhenHealthPoor
            ? _value.autoPauseListingWhenHealthPoor
            : autoPauseListingWhenHealthPoor // ignore: cast_nullable_to_non_nullable
                  as bool,
        safetyStockBuffer: null == safetyStockBuffer
            ? _value.safetyStockBuffer
            : safetyStockBuffer // ignore: cast_nullable_to_non_nullable
                  as int,
        customerAbuseMaxReturnRatePercent:
            freezed == customerAbuseMaxReturnRatePercent
            ? _value.customerAbuseMaxReturnRatePercent
            : customerAbuseMaxReturnRatePercent // ignore: cast_nullable_to_non_nullable
                  as double?,
        customerAbuseMaxComplaintRatePercent:
            freezed == customerAbuseMaxComplaintRatePercent
            ? _value.customerAbuseMaxComplaintRatePercent
            : customerAbuseMaxComplaintRatePercent // ignore: cast_nullable_to_non_nullable
                  as double?,
        priceRefreshIntervalMinutesBySource:
            null == priceRefreshIntervalMinutesBySource
            ? _value._priceRefreshIntervalMinutesBySource
            : priceRefreshIntervalMinutesBySource // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserRulesImpl implements _UserRules {
  const _$UserRulesImpl({
    this.minProfitPercent = 25.0,
    this.maxSourcePrice,
    final List<String> preferredSupplierCountries = const [],
    this.manualApprovalListings = true,
    this.manualApprovalOrders = true,
    this.scanIntervalMinutes = 1440,
    final List<String> blacklistedProductIds = const [],
    final List<String> blacklistedSupplierIds = const [],
    this.defaultMarkupPercent = 30.0,
    final List<String> searchKeywords = const [],
    final Map<String, double> marketplaceFees = const {},
    final Map<String, double> paymentFees = const {},
    final Map<String, dynamic>? sellerReturnAddress,
    final Map<String, dynamic> marketplaceReturnPolicy = const {},
    this.targetsReadOnly = false,
    this.pricingStrategy = 'always_below_lowest',
    final Map<String, double> categoryMinProfitPercent = const {},
    this.premiumWhenBetterReviewsPercent = 2.0,
    this.minSalesCountForPremium = 10,
    this.kpiDrivenStrategyEnabled = false,
    final Map<String, int> rateLimitMaxRequestsPerSecond = const {},
    this.incidentRulesJson,
    this.riskScoreThreshold,
    this.defaultReturnRatePercent,
    this.defaultReturnCostPerUnit,
    this.blockFulfillWhenInsufficientStock = false,
    this.autoPauseListingWhenMarginBelowThreshold = false,
    this.defaultSupplierProcessingDays = 2,
    this.defaultSupplierShippingDays = 7,
    this.marketplaceMaxDeliveryDays,
    this.listingHealthMaxReturnRatePercent,
    this.listingHealthMaxLateRatePercent,
    this.autoPauseListingWhenHealthPoor = false,
    this.safetyStockBuffer = 0,
    this.customerAbuseMaxReturnRatePercent,
    this.customerAbuseMaxComplaintRatePercent,
    final Map<String, int> priceRefreshIntervalMinutesBySource = const {},
  }) : _preferredSupplierCountries = preferredSupplierCountries,
       _blacklistedProductIds = blacklistedProductIds,
       _blacklistedSupplierIds = blacklistedSupplierIds,
       _searchKeywords = searchKeywords,
       _marketplaceFees = marketplaceFees,
       _paymentFees = paymentFees,
       _sellerReturnAddress = sellerReturnAddress,
       _marketplaceReturnPolicy = marketplaceReturnPolicy,
       _categoryMinProfitPercent = categoryMinProfitPercent,
       _rateLimitMaxRequestsPerSecond = rateLimitMaxRequestsPerSecond,
       _priceRefreshIntervalMinutesBySource =
           priceRefreshIntervalMinutesBySource;

  factory _$UserRulesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRulesImplFromJson(json);

  @override
  @JsonKey()
  final double minProfitPercent;
  @override
  final double? maxSourcePrice;
  final List<String> _preferredSupplierCountries;
  @override
  @JsonKey()
  List<String> get preferredSupplierCountries {
    if (_preferredSupplierCountries is EqualUnmodifiableListView)
      return _preferredSupplierCountries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredSupplierCountries);
  }

  @override
  @JsonKey()
  final bool manualApprovalListings;
  @override
  @JsonKey()
  final bool manualApprovalOrders;
  @override
  @JsonKey()
  final int scanIntervalMinutes;
  final List<String> _blacklistedProductIds;
  @override
  @JsonKey()
  List<String> get blacklistedProductIds {
    if (_blacklistedProductIds is EqualUnmodifiableListView)
      return _blacklistedProductIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blacklistedProductIds);
  }

  final List<String> _blacklistedSupplierIds;
  @override
  @JsonKey()
  List<String> get blacklistedSupplierIds {
    if (_blacklistedSupplierIds is EqualUnmodifiableListView)
      return _blacklistedSupplierIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blacklistedSupplierIds);
  }

  @override
  @JsonKey()
  final double defaultMarkupPercent;
  final List<String> _searchKeywords;
  @override
  @JsonKey()
  List<String> get searchKeywords {
    if (_searchKeywords is EqualUnmodifiableListView) return _searchKeywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchKeywords);
  }

  final Map<String, double> _marketplaceFees;
  @override
  @JsonKey()
  Map<String, double> get marketplaceFees {
    if (_marketplaceFees is EqualUnmodifiableMapView) return _marketplaceFees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_marketplaceFees);
  }

  /// Per-platform payment processing fee % (e.g. card/PayU). Added to marketplace fee for P_min.
  final Map<String, double> _paymentFees;

  /// Per-platform payment processing fee % (e.g. card/PayU). Added to marketplace fee for P_min.
  @override
  @JsonKey()
  Map<String, double> get paymentFees {
    if (_paymentFees is EqualUnmodifiableMapView) return _paymentFees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paymentFees);
  }

  final Map<String, dynamic>? _sellerReturnAddress;
  @override
  Map<String, dynamic>? get sellerReturnAddress {
    final value = _sellerReturnAddress;
    if (value == null) return null;
    if (_sellerReturnAddress is EqualUnmodifiableMapView)
      return _sellerReturnAddress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic> _marketplaceReturnPolicy;
  @override
  @JsonKey()
  Map<String, dynamic> get marketplaceReturnPolicy {
    if (_marketplaceReturnPolicy is EqualUnmodifiableMapView)
      return _marketplaceReturnPolicy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_marketplaceReturnPolicy);
  }

  /// When true, automation will not perform write operations on target marketplaces
  /// (no create/update listings, cancel orders, or push tracking). Use this as a
  /// global \"read-only\"/dry-run mode when connecting real accounts.
  @override
  @JsonKey()
  final bool targetsReadOnly;

  /// Pricing strategy:
  /// - always_below_lowest
  /// - premium_when_better_reviews
  /// - match_lowest
  /// - fixed_markup
  /// - list_at_min_even_if_above_lowest (still list at P_min even when above lowest)
  @override
  @JsonKey()
  final String pricingStrategy;

  /// Per-category min profit % (categoryId -> percent). Fallback: minProfitPercent.
  final Map<String, double> _categoryMinProfitPercent;

  /// Per-category min profit % (categoryId -> percent). Fallback: minProfitPercent.
  @override
  @JsonKey()
  Map<String, double> get categoryMinProfitPercent {
    if (_categoryMinProfitPercent is EqualUnmodifiableMapView)
      return _categoryMinProfitPercent;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryMinProfitPercent);
  }

  /// When strategy is premium_when_better_reviews: allow this % above lowest competitor (e.g. 2.0 = 2%).
  @override
  @JsonKey()
  final double premiumWhenBetterReviewsPercent;

  /// Min sales count on our listing to consider premium (better reviews) pricing.
  @override
  @JsonKey()
  final int minSalesCountForPremium;

  /// When true, app may suggest or auto-select strategy based on KPI (conversion, margin).
  @override
  @JsonKey()
  final bool kpiDrivenStrategyEnabled;

  /// Per-platform API rate limit: platformId -> max requests per second (e.g. allegro: 5, cj: 10).
  final Map<String, int> _rateLimitMaxRequestsPerSecond;

  /// Per-platform API rate limit: platformId -> max requests per second (e.g. allegro: 5, cj: 10).
  @override
  @JsonKey()
  Map<String, int> get rateLimitMaxRequestsPerSecond {
    if (_rateLimitMaxRequestsPerSecond is EqualUnmodifiableMapView)
      return _rateLimitMaxRequestsPerSecond;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rateLimitMaxRequestsPerSecond);
  }

  /// Phase 8: incident decision rules – JSON array of { "condition": "...", "action": "..." }. Nullable.
  @override
  final String? incidentRulesJson;

  /// Phase 16: if order risk score > this (0–100), set to pendingApproval. Null when disabled.
  @override
  final double? riskScoreThreshold;

  /// Phase 17: default expected return rate % for return-rate-aware P_min (e.g. 15 = 15%). Null when not used.
  @override
  final double? defaultReturnRatePercent;

  /// Phase 17: default return cost per unit (PLN) for return-rate-aware P_min. Null when not used.
  @override
  final double? defaultReturnCostPerUnit;

  /// When true, fulfillment is skipped when inventory availableToSell < order quantity (Phase 18).
  @override
  @JsonKey()
  final bool blockFulfillWhenInsufficientStock;

  /// Phase 20: when true, ProfitGuardService will set listing status to paused when margin < minProfitPercent.
  @override
  @JsonKey()
  final bool autoPauseListingWhenMarginBelowThreshold;

  /// Phase 21: default supplier processing time (days) before shipment. Used for delivery validation.
  @override
  @JsonKey()
  final int defaultSupplierProcessingDays;

  /// Phase 21: default supplier shipping time (days) when product.estimatedDays is null.
  @override
  @JsonKey()
  final int defaultSupplierShippingDays;

  /// Phase 21: when set, listing is rejected if expected delivery (processing + shipping) > this (marketplace max).
  @override
  final int? marketplaceMaxDeliveryDays;

  /// Phase 26: max return+incident rate % for listing health; when exceeded and auto-pause on, listing is paused. Null = no limit.
  @override
  final double? listingHealthMaxReturnRatePercent;

  /// Phase 26: max late delivery rate % for listing health; when exceeded and auto-pause on, listing is paused. Null = no limit.
  @override
  final double? listingHealthMaxLateRatePercent;

  /// Phase 26: when true, ListingHealthScoringService pauses listings whose return or late rate exceeds the above thresholds.
  @override
  @JsonKey()
  final bool autoPauseListingWhenHealthPoor;

  /// Phase 19: reduce effective available-to-sell by this many units to account for supplier stock drift (list/fulfill more conservatively).
  @override
  @JsonKey()
  final int safetyStockBuffer;

  /// Phase 25: max return rate % for customer; when exceeded, new orders from that customer get pendingApproval. Null = no check.
  @override
  final double? customerAbuseMaxReturnRatePercent;

  /// Phase 25: max complaint (incident) rate % for customer; when exceeded, new orders get pendingApproval. Null = no check.
  @override
  final double? customerAbuseMaxComplaintRatePercent;

  /// Per-warehouse/source price refresh interval (minutes). Key = sourcePlatformId, value = minutes (e.g. 720 = 12h).
  /// Warehouses publish new prices 1–2×/day at different times; we pull from XML/CSV/API when offers are stale for that source. Missing key uses default 720.
  final Map<String, int> _priceRefreshIntervalMinutesBySource;

  /// Per-warehouse/source price refresh interval (minutes). Key = sourcePlatformId, value = minutes (e.g. 720 = 12h).
  /// Warehouses publish new prices 1–2×/day at different times; we pull from XML/CSV/API when offers are stale for that source. Missing key uses default 720.
  @override
  @JsonKey()
  Map<String, int> get priceRefreshIntervalMinutesBySource {
    if (_priceRefreshIntervalMinutesBySource is EqualUnmodifiableMapView)
      return _priceRefreshIntervalMinutesBySource;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_priceRefreshIntervalMinutesBySource);
  }

  @override
  String toString() {
    return 'UserRules(minProfitPercent: $minProfitPercent, maxSourcePrice: $maxSourcePrice, preferredSupplierCountries: $preferredSupplierCountries, manualApprovalListings: $manualApprovalListings, manualApprovalOrders: $manualApprovalOrders, scanIntervalMinutes: $scanIntervalMinutes, blacklistedProductIds: $blacklistedProductIds, blacklistedSupplierIds: $blacklistedSupplierIds, defaultMarkupPercent: $defaultMarkupPercent, searchKeywords: $searchKeywords, marketplaceFees: $marketplaceFees, paymentFees: $paymentFees, sellerReturnAddress: $sellerReturnAddress, marketplaceReturnPolicy: $marketplaceReturnPolicy, targetsReadOnly: $targetsReadOnly, pricingStrategy: $pricingStrategy, categoryMinProfitPercent: $categoryMinProfitPercent, premiumWhenBetterReviewsPercent: $premiumWhenBetterReviewsPercent, minSalesCountForPremium: $minSalesCountForPremium, kpiDrivenStrategyEnabled: $kpiDrivenStrategyEnabled, rateLimitMaxRequestsPerSecond: $rateLimitMaxRequestsPerSecond, incidentRulesJson: $incidentRulesJson, riskScoreThreshold: $riskScoreThreshold, defaultReturnRatePercent: $defaultReturnRatePercent, defaultReturnCostPerUnit: $defaultReturnCostPerUnit, blockFulfillWhenInsufficientStock: $blockFulfillWhenInsufficientStock, autoPauseListingWhenMarginBelowThreshold: $autoPauseListingWhenMarginBelowThreshold, defaultSupplierProcessingDays: $defaultSupplierProcessingDays, defaultSupplierShippingDays: $defaultSupplierShippingDays, marketplaceMaxDeliveryDays: $marketplaceMaxDeliveryDays, listingHealthMaxReturnRatePercent: $listingHealthMaxReturnRatePercent, listingHealthMaxLateRatePercent: $listingHealthMaxLateRatePercent, autoPauseListingWhenHealthPoor: $autoPauseListingWhenHealthPoor, safetyStockBuffer: $safetyStockBuffer, customerAbuseMaxReturnRatePercent: $customerAbuseMaxReturnRatePercent, customerAbuseMaxComplaintRatePercent: $customerAbuseMaxComplaintRatePercent, priceRefreshIntervalMinutesBySource: $priceRefreshIntervalMinutesBySource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRulesImpl &&
            (identical(other.minProfitPercent, minProfitPercent) ||
                other.minProfitPercent == minProfitPercent) &&
            (identical(other.maxSourcePrice, maxSourcePrice) ||
                other.maxSourcePrice == maxSourcePrice) &&
            const DeepCollectionEquality().equals(
              other._preferredSupplierCountries,
              _preferredSupplierCountries,
            ) &&
            (identical(other.manualApprovalListings, manualApprovalListings) ||
                other.manualApprovalListings == manualApprovalListings) &&
            (identical(other.manualApprovalOrders, manualApprovalOrders) ||
                other.manualApprovalOrders == manualApprovalOrders) &&
            (identical(other.scanIntervalMinutes, scanIntervalMinutes) ||
                other.scanIntervalMinutes == scanIntervalMinutes) &&
            const DeepCollectionEquality().equals(
              other._blacklistedProductIds,
              _blacklistedProductIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._blacklistedSupplierIds,
              _blacklistedSupplierIds,
            ) &&
            (identical(other.defaultMarkupPercent, defaultMarkupPercent) ||
                other.defaultMarkupPercent == defaultMarkupPercent) &&
            const DeepCollectionEquality().equals(
              other._searchKeywords,
              _searchKeywords,
            ) &&
            const DeepCollectionEquality().equals(
              other._marketplaceFees,
              _marketplaceFees,
            ) &&
            const DeepCollectionEquality().equals(
              other._paymentFees,
              _paymentFees,
            ) &&
            const DeepCollectionEquality().equals(
              other._sellerReturnAddress,
              _sellerReturnAddress,
            ) &&
            const DeepCollectionEquality().equals(
              other._marketplaceReturnPolicy,
              _marketplaceReturnPolicy,
            ) &&
            (identical(other.targetsReadOnly, targetsReadOnly) ||
                other.targetsReadOnly == targetsReadOnly) &&
            (identical(other.pricingStrategy, pricingStrategy) ||
                other.pricingStrategy == pricingStrategy) &&
            const DeepCollectionEquality().equals(
              other._categoryMinProfitPercent,
              _categoryMinProfitPercent,
            ) &&
            (identical(
                  other.premiumWhenBetterReviewsPercent,
                  premiumWhenBetterReviewsPercent,
                ) ||
                other.premiumWhenBetterReviewsPercent ==
                    premiumWhenBetterReviewsPercent) &&
            (identical(
                  other.minSalesCountForPremium,
                  minSalesCountForPremium,
                ) ||
                other.minSalesCountForPremium == minSalesCountForPremium) &&
            (identical(
                  other.kpiDrivenStrategyEnabled,
                  kpiDrivenStrategyEnabled,
                ) ||
                other.kpiDrivenStrategyEnabled == kpiDrivenStrategyEnabled) &&
            const DeepCollectionEquality().equals(
              other._rateLimitMaxRequestsPerSecond,
              _rateLimitMaxRequestsPerSecond,
            ) &&
            (identical(other.incidentRulesJson, incidentRulesJson) ||
                other.incidentRulesJson == incidentRulesJson) &&
            (identical(other.riskScoreThreshold, riskScoreThreshold) ||
                other.riskScoreThreshold == riskScoreThreshold) &&
            (identical(
                  other.defaultReturnRatePercent,
                  defaultReturnRatePercent,
                ) ||
                other.defaultReturnRatePercent == defaultReturnRatePercent) &&
            (identical(
                  other.defaultReturnCostPerUnit,
                  defaultReturnCostPerUnit,
                ) ||
                other.defaultReturnCostPerUnit == defaultReturnCostPerUnit) &&
            (identical(
                  other.blockFulfillWhenInsufficientStock,
                  blockFulfillWhenInsufficientStock,
                ) ||
                other.blockFulfillWhenInsufficientStock ==
                    blockFulfillWhenInsufficientStock) &&
            (identical(
                  other.autoPauseListingWhenMarginBelowThreshold,
                  autoPauseListingWhenMarginBelowThreshold,
                ) ||
                other.autoPauseListingWhenMarginBelowThreshold ==
                    autoPauseListingWhenMarginBelowThreshold) &&
            (identical(
                  other.defaultSupplierProcessingDays,
                  defaultSupplierProcessingDays,
                ) ||
                other.defaultSupplierProcessingDays ==
                    defaultSupplierProcessingDays) &&
            (identical(
                  other.defaultSupplierShippingDays,
                  defaultSupplierShippingDays,
                ) ||
                other.defaultSupplierShippingDays ==
                    defaultSupplierShippingDays) &&
            (identical(
                  other.marketplaceMaxDeliveryDays,
                  marketplaceMaxDeliveryDays,
                ) ||
                other.marketplaceMaxDeliveryDays ==
                    marketplaceMaxDeliveryDays) &&
            (identical(
                  other.listingHealthMaxReturnRatePercent,
                  listingHealthMaxReturnRatePercent,
                ) ||
                other.listingHealthMaxReturnRatePercent ==
                    listingHealthMaxReturnRatePercent) &&
            (identical(
                  other.listingHealthMaxLateRatePercent,
                  listingHealthMaxLateRatePercent,
                ) ||
                other.listingHealthMaxLateRatePercent ==
                    listingHealthMaxLateRatePercent) &&
            (identical(
                  other.autoPauseListingWhenHealthPoor,
                  autoPauseListingWhenHealthPoor,
                ) ||
                other.autoPauseListingWhenHealthPoor ==
                    autoPauseListingWhenHealthPoor) &&
            (identical(other.safetyStockBuffer, safetyStockBuffer) ||
                other.safetyStockBuffer == safetyStockBuffer) &&
            (identical(
                  other.customerAbuseMaxReturnRatePercent,
                  customerAbuseMaxReturnRatePercent,
                ) ||
                other.customerAbuseMaxReturnRatePercent ==
                    customerAbuseMaxReturnRatePercent) &&
            (identical(
                  other.customerAbuseMaxComplaintRatePercent,
                  customerAbuseMaxComplaintRatePercent,
                ) ||
                other.customerAbuseMaxComplaintRatePercent ==
                    customerAbuseMaxComplaintRatePercent) &&
            const DeepCollectionEquality().equals(
              other._priceRefreshIntervalMinutesBySource,
              _priceRefreshIntervalMinutesBySource,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    minProfitPercent,
    maxSourcePrice,
    const DeepCollectionEquality().hash(_preferredSupplierCountries),
    manualApprovalListings,
    manualApprovalOrders,
    scanIntervalMinutes,
    const DeepCollectionEquality().hash(_blacklistedProductIds),
    const DeepCollectionEquality().hash(_blacklistedSupplierIds),
    defaultMarkupPercent,
    const DeepCollectionEquality().hash(_searchKeywords),
    const DeepCollectionEquality().hash(_marketplaceFees),
    const DeepCollectionEquality().hash(_paymentFees),
    const DeepCollectionEquality().hash(_sellerReturnAddress),
    const DeepCollectionEquality().hash(_marketplaceReturnPolicy),
    targetsReadOnly,
    pricingStrategy,
    const DeepCollectionEquality().hash(_categoryMinProfitPercent),
    premiumWhenBetterReviewsPercent,
    minSalesCountForPremium,
    kpiDrivenStrategyEnabled,
    const DeepCollectionEquality().hash(_rateLimitMaxRequestsPerSecond),
    incidentRulesJson,
    riskScoreThreshold,
    defaultReturnRatePercent,
    defaultReturnCostPerUnit,
    blockFulfillWhenInsufficientStock,
    autoPauseListingWhenMarginBelowThreshold,
    defaultSupplierProcessingDays,
    defaultSupplierShippingDays,
    marketplaceMaxDeliveryDays,
    listingHealthMaxReturnRatePercent,
    listingHealthMaxLateRatePercent,
    autoPauseListingWhenHealthPoor,
    safetyStockBuffer,
    customerAbuseMaxReturnRatePercent,
    customerAbuseMaxComplaintRatePercent,
    const DeepCollectionEquality().hash(_priceRefreshIntervalMinutesBySource),
  ]);

  /// Create a copy of UserRules
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRulesImplCopyWith<_$UserRulesImpl> get copyWith =>
      __$$UserRulesImplCopyWithImpl<_$UserRulesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRulesImplToJson(this);
  }
}

abstract class _UserRules implements UserRules {
  const factory _UserRules({
    final double minProfitPercent,
    final double? maxSourcePrice,
    final List<String> preferredSupplierCountries,
    final bool manualApprovalListings,
    final bool manualApprovalOrders,
    final int scanIntervalMinutes,
    final List<String> blacklistedProductIds,
    final List<String> blacklistedSupplierIds,
    final double defaultMarkupPercent,
    final List<String> searchKeywords,
    final Map<String, double> marketplaceFees,
    final Map<String, double> paymentFees,
    final Map<String, dynamic>? sellerReturnAddress,
    final Map<String, dynamic> marketplaceReturnPolicy,
    final bool targetsReadOnly,
    final String pricingStrategy,
    final Map<String, double> categoryMinProfitPercent,
    final double premiumWhenBetterReviewsPercent,
    final int minSalesCountForPremium,
    final bool kpiDrivenStrategyEnabled,
    final Map<String, int> rateLimitMaxRequestsPerSecond,
    final String? incidentRulesJson,
    final double? riskScoreThreshold,
    final double? defaultReturnRatePercent,
    final double? defaultReturnCostPerUnit,
    final bool blockFulfillWhenInsufficientStock,
    final bool autoPauseListingWhenMarginBelowThreshold,
    final int defaultSupplierProcessingDays,
    final int defaultSupplierShippingDays,
    final int? marketplaceMaxDeliveryDays,
    final double? listingHealthMaxReturnRatePercent,
    final double? listingHealthMaxLateRatePercent,
    final bool autoPauseListingWhenHealthPoor,
    final int safetyStockBuffer,
    final double? customerAbuseMaxReturnRatePercent,
    final double? customerAbuseMaxComplaintRatePercent,
    final Map<String, int> priceRefreshIntervalMinutesBySource,
  }) = _$UserRulesImpl;

  factory _UserRules.fromJson(Map<String, dynamic> json) =
      _$UserRulesImpl.fromJson;

  @override
  double get minProfitPercent;
  @override
  double? get maxSourcePrice;
  @override
  List<String> get preferredSupplierCountries;
  @override
  bool get manualApprovalListings;
  @override
  bool get manualApprovalOrders;
  @override
  int get scanIntervalMinutes;
  @override
  List<String> get blacklistedProductIds;
  @override
  List<String> get blacklistedSupplierIds;
  @override
  double get defaultMarkupPercent;
  @override
  List<String> get searchKeywords;
  @override
  Map<String, double> get marketplaceFees;

  /// Per-platform payment processing fee % (e.g. card/PayU). Added to marketplace fee for P_min.
  @override
  Map<String, double> get paymentFees;
  @override
  Map<String, dynamic>? get sellerReturnAddress;
  @override
  Map<String, dynamic> get marketplaceReturnPolicy;

  /// When true, automation will not perform write operations on target marketplaces
  /// (no create/update listings, cancel orders, or push tracking). Use this as a
  /// global \"read-only\"/dry-run mode when connecting real accounts.
  @override
  bool get targetsReadOnly;

  /// Pricing strategy:
  /// - always_below_lowest
  /// - premium_when_better_reviews
  /// - match_lowest
  /// - fixed_markup
  /// - list_at_min_even_if_above_lowest (still list at P_min even when above lowest)
  @override
  String get pricingStrategy;

  /// Per-category min profit % (categoryId -> percent). Fallback: minProfitPercent.
  @override
  Map<String, double> get categoryMinProfitPercent;

  /// When strategy is premium_when_better_reviews: allow this % above lowest competitor (e.g. 2.0 = 2%).
  @override
  double get premiumWhenBetterReviewsPercent;

  /// Min sales count on our listing to consider premium (better reviews) pricing.
  @override
  int get minSalesCountForPremium;

  /// When true, app may suggest or auto-select strategy based on KPI (conversion, margin).
  @override
  bool get kpiDrivenStrategyEnabled;

  /// Per-platform API rate limit: platformId -> max requests per second (e.g. allegro: 5, cj: 10).
  @override
  Map<String, int> get rateLimitMaxRequestsPerSecond;

  /// Phase 8: incident decision rules – JSON array of { "condition": "...", "action": "..." }. Nullable.
  @override
  String? get incidentRulesJson;

  /// Phase 16: if order risk score > this (0–100), set to pendingApproval. Null when disabled.
  @override
  double? get riskScoreThreshold;

  /// Phase 17: default expected return rate % for return-rate-aware P_min (e.g. 15 = 15%). Null when not used.
  @override
  double? get defaultReturnRatePercent;

  /// Phase 17: default return cost per unit (PLN) for return-rate-aware P_min. Null when not used.
  @override
  double? get defaultReturnCostPerUnit;

  /// When true, fulfillment is skipped when inventory availableToSell < order quantity (Phase 18).
  @override
  bool get blockFulfillWhenInsufficientStock;

  /// Phase 20: when true, ProfitGuardService will set listing status to paused when margin < minProfitPercent.
  @override
  bool get autoPauseListingWhenMarginBelowThreshold;

  /// Phase 21: default supplier processing time (days) before shipment. Used for delivery validation.
  @override
  int get defaultSupplierProcessingDays;

  /// Phase 21: default supplier shipping time (days) when product.estimatedDays is null.
  @override
  int get defaultSupplierShippingDays;

  /// Phase 21: when set, listing is rejected if expected delivery (processing + shipping) > this (marketplace max).
  @override
  int? get marketplaceMaxDeliveryDays;

  /// Phase 26: max return+incident rate % for listing health; when exceeded and auto-pause on, listing is paused. Null = no limit.
  @override
  double? get listingHealthMaxReturnRatePercent;

  /// Phase 26: max late delivery rate % for listing health; when exceeded and auto-pause on, listing is paused. Null = no limit.
  @override
  double? get listingHealthMaxLateRatePercent;

  /// Phase 26: when true, ListingHealthScoringService pauses listings whose return or late rate exceeds the above thresholds.
  @override
  bool get autoPauseListingWhenHealthPoor;

  /// Phase 19: reduce effective available-to-sell by this many units to account for supplier stock drift (list/fulfill more conservatively).
  @override
  int get safetyStockBuffer;

  /// Phase 25: max return rate % for customer; when exceeded, new orders from that customer get pendingApproval. Null = no check.
  @override
  double? get customerAbuseMaxReturnRatePercent;

  /// Phase 25: max complaint (incident) rate % for customer; when exceeded, new orders get pendingApproval. Null = no check.
  @override
  double? get customerAbuseMaxComplaintRatePercent;

  /// Per-warehouse/source price refresh interval (minutes). Key = sourcePlatformId, value = minutes (e.g. 720 = 12h).
  /// Warehouses publish new prices 1–2×/day at different times; we pull from XML/CSV/API when offers are stale for that source. Missing key uses default 720.
  @override
  Map<String, int> get priceRefreshIntervalMinutesBySource;

  /// Create a copy of UserRules
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRulesImplCopyWith<_$UserRulesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
