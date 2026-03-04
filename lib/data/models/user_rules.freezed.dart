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
  }) : _preferredSupplierCountries = preferredSupplierCountries,
       _blacklistedProductIds = blacklistedProductIds,
       _blacklistedSupplierIds = blacklistedSupplierIds,
       _searchKeywords = searchKeywords;

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

  @override
  String toString() {
    return 'UserRules(minProfitPercent: $minProfitPercent, maxSourcePrice: $maxSourcePrice, preferredSupplierCountries: $preferredSupplierCountries, manualApprovalListings: $manualApprovalListings, manualApprovalOrders: $manualApprovalOrders, scanIntervalMinutes: $scanIntervalMinutes, blacklistedProductIds: $blacklistedProductIds, blacklistedSupplierIds: $blacklistedSupplierIds, defaultMarkupPercent: $defaultMarkupPercent, searchKeywords: $searchKeywords)';
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
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
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
  );

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

  /// Create a copy of UserRules
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRulesImplCopyWith<_$UserRulesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
