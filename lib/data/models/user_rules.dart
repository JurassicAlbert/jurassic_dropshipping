import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_rules.freezed.dart';
part 'user_rules.g.dart';

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
  }) = _UserRules;

  factory UserRules.fromJson(Map<String, dynamic> json) =>
      _$UserRulesFromJson(json);
}
