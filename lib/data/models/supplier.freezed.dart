// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Supplier _$SupplierFromJson(Map<String, dynamic> json) {
  return _Supplier.fromJson(json);
}

/// @nodoc
mixin _$Supplier {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// e.g. 'cj', 'api2cart', 'local'
  String get platformType => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;

  /// Days for no-reason return window offered by the supplier.
  int? get returnWindowDays => throw _privateConstructorUsedError;

  /// Cost to ship a return back to the supplier (approx).
  double? get returnShippingCost => throw _privateConstructorUsedError;

  /// Restocking fee percent (0-100).
  double? get restockingFeePercent => throw _privateConstructorUsedError;

  /// Whether supplier accepts no-reason returns.
  bool get acceptsNoReasonReturns => throw _privateConstructorUsedError;

  /// Warehouse/return address where customers ship returns directly
  String? get warehouseAddress => throw _privateConstructorUsedError;
  String? get warehouseCity => throw _privateConstructorUsedError;
  String? get warehouseZip => throw _privateConstructorUsedError;
  String? get warehouseCountry => throw _privateConstructorUsedError;

  /// Contact info for the warehouse
  String? get warehousePhone => throw _privateConstructorUsedError;
  String? get warehouseEmail => throw _privateConstructorUsedError;

  /// The feed/source used to connect to this supplier (e.g. 'cj_api', 'api2cart_shopify', 'manual')
  String? get feedSource => throw _privateConstructorUsedError;

  /// External shop URL or identifier
  String? get shopUrl => throw _privateConstructorUsedError;

  /// Serializes this Supplier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierCopyWith<Supplier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierCopyWith<$Res> {
  factory $SupplierCopyWith(Supplier value, $Res Function(Supplier) then) =
      _$SupplierCopyWithImpl<$Res, Supplier>;
  @useResult
  $Res call({
    String id,
    String name,
    String platformType,
    String? countryCode,
    double? rating,
    int? returnWindowDays,
    double? returnShippingCost,
    double? restockingFeePercent,
    bool acceptsNoReasonReturns,
    String? warehouseAddress,
    String? warehouseCity,
    String? warehouseZip,
    String? warehouseCountry,
    String? warehousePhone,
    String? warehouseEmail,
    String? feedSource,
    String? shopUrl,
  });
}

/// @nodoc
class _$SupplierCopyWithImpl<$Res, $Val extends Supplier>
    implements $SupplierCopyWith<$Res> {
  _$SupplierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? platformType = null,
    Object? countryCode = freezed,
    Object? rating = freezed,
    Object? returnWindowDays = freezed,
    Object? returnShippingCost = freezed,
    Object? restockingFeePercent = freezed,
    Object? acceptsNoReasonReturns = null,
    Object? warehouseAddress = freezed,
    Object? warehouseCity = freezed,
    Object? warehouseZip = freezed,
    Object? warehouseCountry = freezed,
    Object? warehousePhone = freezed,
    Object? warehouseEmail = freezed,
    Object? feedSource = freezed,
    Object? shopUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            platformType: null == platformType
                ? _value.platformType
                : platformType // ignore: cast_nullable_to_non_nullable
                      as String,
            countryCode: freezed == countryCode
                ? _value.countryCode
                : countryCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double?,
            returnWindowDays: freezed == returnWindowDays
                ? _value.returnWindowDays
                : returnWindowDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            returnShippingCost: freezed == returnShippingCost
                ? _value.returnShippingCost
                : returnShippingCost // ignore: cast_nullable_to_non_nullable
                      as double?,
            restockingFeePercent: freezed == restockingFeePercent
                ? _value.restockingFeePercent
                : restockingFeePercent // ignore: cast_nullable_to_non_nullable
                      as double?,
            acceptsNoReasonReturns: null == acceptsNoReasonReturns
                ? _value.acceptsNoReasonReturns
                : acceptsNoReasonReturns // ignore: cast_nullable_to_non_nullable
                      as bool,
            warehouseAddress: freezed == warehouseAddress
                ? _value.warehouseAddress
                : warehouseAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            warehouseCity: freezed == warehouseCity
                ? _value.warehouseCity
                : warehouseCity // ignore: cast_nullable_to_non_nullable
                      as String?,
            warehouseZip: freezed == warehouseZip
                ? _value.warehouseZip
                : warehouseZip // ignore: cast_nullable_to_non_nullable
                      as String?,
            warehouseCountry: freezed == warehouseCountry
                ? _value.warehouseCountry
                : warehouseCountry // ignore: cast_nullable_to_non_nullable
                      as String?,
            warehousePhone: freezed == warehousePhone
                ? _value.warehousePhone
                : warehousePhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            warehouseEmail: freezed == warehouseEmail
                ? _value.warehouseEmail
                : warehouseEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            feedSource: freezed == feedSource
                ? _value.feedSource
                : feedSource // ignore: cast_nullable_to_non_nullable
                      as String?,
            shopUrl: freezed == shopUrl
                ? _value.shopUrl
                : shopUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SupplierImplCopyWith<$Res>
    implements $SupplierCopyWith<$Res> {
  factory _$$SupplierImplCopyWith(
    _$SupplierImpl value,
    $Res Function(_$SupplierImpl) then,
  ) = __$$SupplierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String platformType,
    String? countryCode,
    double? rating,
    int? returnWindowDays,
    double? returnShippingCost,
    double? restockingFeePercent,
    bool acceptsNoReasonReturns,
    String? warehouseAddress,
    String? warehouseCity,
    String? warehouseZip,
    String? warehouseCountry,
    String? warehousePhone,
    String? warehouseEmail,
    String? feedSource,
    String? shopUrl,
  });
}

/// @nodoc
class __$$SupplierImplCopyWithImpl<$Res>
    extends _$SupplierCopyWithImpl<$Res, _$SupplierImpl>
    implements _$$SupplierImplCopyWith<$Res> {
  __$$SupplierImplCopyWithImpl(
    _$SupplierImpl _value,
    $Res Function(_$SupplierImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? platformType = null,
    Object? countryCode = freezed,
    Object? rating = freezed,
    Object? returnWindowDays = freezed,
    Object? returnShippingCost = freezed,
    Object? restockingFeePercent = freezed,
    Object? acceptsNoReasonReturns = null,
    Object? warehouseAddress = freezed,
    Object? warehouseCity = freezed,
    Object? warehouseZip = freezed,
    Object? warehouseCountry = freezed,
    Object? warehousePhone = freezed,
    Object? warehouseEmail = freezed,
    Object? feedSource = freezed,
    Object? shopUrl = freezed,
  }) {
    return _then(
      _$SupplierImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        platformType: null == platformType
            ? _value.platformType
            : platformType // ignore: cast_nullable_to_non_nullable
                  as String,
        countryCode: freezed == countryCode
            ? _value.countryCode
            : countryCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: freezed == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double?,
        returnWindowDays: freezed == returnWindowDays
            ? _value.returnWindowDays
            : returnWindowDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        returnShippingCost: freezed == returnShippingCost
            ? _value.returnShippingCost
            : returnShippingCost // ignore: cast_nullable_to_non_nullable
                  as double?,
        restockingFeePercent: freezed == restockingFeePercent
            ? _value.restockingFeePercent
            : restockingFeePercent // ignore: cast_nullable_to_non_nullable
                  as double?,
        acceptsNoReasonReturns: null == acceptsNoReasonReturns
            ? _value.acceptsNoReasonReturns
            : acceptsNoReasonReturns // ignore: cast_nullable_to_non_nullable
                  as bool,
        warehouseAddress: freezed == warehouseAddress
            ? _value.warehouseAddress
            : warehouseAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        warehouseCity: freezed == warehouseCity
            ? _value.warehouseCity
            : warehouseCity // ignore: cast_nullable_to_non_nullable
                  as String?,
        warehouseZip: freezed == warehouseZip
            ? _value.warehouseZip
            : warehouseZip // ignore: cast_nullable_to_non_nullable
                  as String?,
        warehouseCountry: freezed == warehouseCountry
            ? _value.warehouseCountry
            : warehouseCountry // ignore: cast_nullable_to_non_nullable
                  as String?,
        warehousePhone: freezed == warehousePhone
            ? _value.warehousePhone
            : warehousePhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        warehouseEmail: freezed == warehouseEmail
            ? _value.warehouseEmail
            : warehouseEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        feedSource: freezed == feedSource
            ? _value.feedSource
            : feedSource // ignore: cast_nullable_to_non_nullable
                  as String?,
        shopUrl: freezed == shopUrl
            ? _value.shopUrl
            : shopUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierImpl implements _Supplier {
  const _$SupplierImpl({
    required this.id,
    required this.name,
    required this.platformType,
    this.countryCode,
    this.rating,
    this.returnWindowDays,
    this.returnShippingCost,
    this.restockingFeePercent,
    this.acceptsNoReasonReturns = false,
    this.warehouseAddress,
    this.warehouseCity,
    this.warehouseZip,
    this.warehouseCountry,
    this.warehousePhone,
    this.warehouseEmail,
    this.feedSource,
    this.shopUrl,
  });

  factory _$SupplierImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  /// e.g. 'cj', 'api2cart', 'local'
  @override
  final String platformType;
  @override
  final String? countryCode;
  @override
  final double? rating;

  /// Days for no-reason return window offered by the supplier.
  @override
  final int? returnWindowDays;

  /// Cost to ship a return back to the supplier (approx).
  @override
  final double? returnShippingCost;

  /// Restocking fee percent (0-100).
  @override
  final double? restockingFeePercent;

  /// Whether supplier accepts no-reason returns.
  @override
  @JsonKey()
  final bool acceptsNoReasonReturns;

  /// Warehouse/return address where customers ship returns directly
  @override
  final String? warehouseAddress;
  @override
  final String? warehouseCity;
  @override
  final String? warehouseZip;
  @override
  final String? warehouseCountry;

  /// Contact info for the warehouse
  @override
  final String? warehousePhone;
  @override
  final String? warehouseEmail;

  /// The feed/source used to connect to this supplier (e.g. 'cj_api', 'api2cart_shopify', 'manual')
  @override
  final String? feedSource;

  /// External shop URL or identifier
  @override
  final String? shopUrl;

  @override
  String toString() {
    return 'Supplier(id: $id, name: $name, platformType: $platformType, countryCode: $countryCode, rating: $rating, returnWindowDays: $returnWindowDays, returnShippingCost: $returnShippingCost, restockingFeePercent: $restockingFeePercent, acceptsNoReasonReturns: $acceptsNoReasonReturns, warehouseAddress: $warehouseAddress, warehouseCity: $warehouseCity, warehouseZip: $warehouseZip, warehouseCountry: $warehouseCountry, warehousePhone: $warehousePhone, warehouseEmail: $warehouseEmail, feedSource: $feedSource, shopUrl: $shopUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.platformType, platformType) ||
                other.platformType == platformType) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.returnWindowDays, returnWindowDays) ||
                other.returnWindowDays == returnWindowDays) &&
            (identical(other.returnShippingCost, returnShippingCost) ||
                other.returnShippingCost == returnShippingCost) &&
            (identical(other.restockingFeePercent, restockingFeePercent) ||
                other.restockingFeePercent == restockingFeePercent) &&
            (identical(other.acceptsNoReasonReturns, acceptsNoReasonReturns) ||
                other.acceptsNoReasonReturns == acceptsNoReasonReturns) &&
            (identical(other.warehouseAddress, warehouseAddress) ||
                other.warehouseAddress == warehouseAddress) &&
            (identical(other.warehouseCity, warehouseCity) ||
                other.warehouseCity == warehouseCity) &&
            (identical(other.warehouseZip, warehouseZip) ||
                other.warehouseZip == warehouseZip) &&
            (identical(other.warehouseCountry, warehouseCountry) ||
                other.warehouseCountry == warehouseCountry) &&
            (identical(other.warehousePhone, warehousePhone) ||
                other.warehousePhone == warehousePhone) &&
            (identical(other.warehouseEmail, warehouseEmail) ||
                other.warehouseEmail == warehouseEmail) &&
            (identical(other.feedSource, feedSource) ||
                other.feedSource == feedSource) &&
            (identical(other.shopUrl, shopUrl) || other.shopUrl == shopUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    platformType,
    countryCode,
    rating,
    returnWindowDays,
    returnShippingCost,
    restockingFeePercent,
    acceptsNoReasonReturns,
    warehouseAddress,
    warehouseCity,
    warehouseZip,
    warehouseCountry,
    warehousePhone,
    warehouseEmail,
    feedSource,
    shopUrl,
  );

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierImplCopyWith<_$SupplierImpl> get copyWith =>
      __$$SupplierImplCopyWithImpl<_$SupplierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierImplToJson(this);
  }
}

abstract class _Supplier implements Supplier {
  const factory _Supplier({
    required final String id,
    required final String name,
    required final String platformType,
    final String? countryCode,
    final double? rating,
    final int? returnWindowDays,
    final double? returnShippingCost,
    final double? restockingFeePercent,
    final bool acceptsNoReasonReturns,
    final String? warehouseAddress,
    final String? warehouseCity,
    final String? warehouseZip,
    final String? warehouseCountry,
    final String? warehousePhone,
    final String? warehouseEmail,
    final String? feedSource,
    final String? shopUrl,
  }) = _$SupplierImpl;

  factory _Supplier.fromJson(Map<String, dynamic> json) =
      _$SupplierImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// e.g. 'cj', 'api2cart', 'local'
  @override
  String get platformType;
  @override
  String? get countryCode;
  @override
  double? get rating;

  /// Days for no-reason return window offered by the supplier.
  @override
  int? get returnWindowDays;

  /// Cost to ship a return back to the supplier (approx).
  @override
  double? get returnShippingCost;

  /// Restocking fee percent (0-100).
  @override
  double? get restockingFeePercent;

  /// Whether supplier accepts no-reason returns.
  @override
  bool get acceptsNoReasonReturns;

  /// Warehouse/return address where customers ship returns directly
  @override
  String? get warehouseAddress;
  @override
  String? get warehouseCity;
  @override
  String? get warehouseZip;
  @override
  String? get warehouseCountry;

  /// Contact info for the warehouse
  @override
  String? get warehousePhone;
  @override
  String? get warehouseEmail;

  /// The feed/source used to connect to this supplier (e.g. 'cj_api', 'api2cart_shopify', 'manual')
  @override
  String? get feedSource;

  /// External shop URL or identifier
  @override
  String? get shopUrl;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierImplCopyWith<_$SupplierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
