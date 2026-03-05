// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SupplierOffer _$SupplierOfferFromJson(Map<String, dynamic> json) {
  return _SupplierOffer.fromJson(json);
}

/// @nodoc
mixin _$SupplierOffer {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get supplierId => throw _privateConstructorUsedError;
  String get sourcePlatformId => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  double? get shippingCost => throw _privateConstructorUsedError;
  int? get minEstimatedDays => throw _privateConstructorUsedError;
  int? get maxEstimatedDays => throw _privateConstructorUsedError;
  String? get carrierCode => throw _privateConstructorUsedError;
  String? get shippingMethodName => throw _privateConstructorUsedError;
  DateTime? get lastPriceRefreshAt => throw _privateConstructorUsedError;
  DateTime? get lastStockRefreshAt => throw _privateConstructorUsedError;

  /// Serializes this SupplierOffer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SupplierOffer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierOfferCopyWith<SupplierOffer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierOfferCopyWith<$Res> {
  factory $SupplierOfferCopyWith(
    SupplierOffer value,
    $Res Function(SupplierOffer) then,
  ) = _$SupplierOfferCopyWithImpl<$Res, SupplierOffer>;
  @useResult
  $Res call({
    String id,
    String productId,
    String supplierId,
    String sourcePlatformId,
    double cost,
    double? shippingCost,
    int? minEstimatedDays,
    int? maxEstimatedDays,
    String? carrierCode,
    String? shippingMethodName,
    DateTime? lastPriceRefreshAt,
    DateTime? lastStockRefreshAt,
  });
}

/// @nodoc
class _$SupplierOfferCopyWithImpl<$Res, $Val extends SupplierOffer>
    implements $SupplierOfferCopyWith<$Res> {
  _$SupplierOfferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupplierOffer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? supplierId = null,
    Object? sourcePlatformId = null,
    Object? cost = null,
    Object? shippingCost = freezed,
    Object? minEstimatedDays = freezed,
    Object? maxEstimatedDays = freezed,
    Object? carrierCode = freezed,
    Object? shippingMethodName = freezed,
    Object? lastPriceRefreshAt = freezed,
    Object? lastStockRefreshAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            supplierId: null == supplierId
                ? _value.supplierId
                : supplierId // ignore: cast_nullable_to_non_nullable
                      as String,
            sourcePlatformId: null == sourcePlatformId
                ? _value.sourcePlatformId
                : sourcePlatformId // ignore: cast_nullable_to_non_nullable
                      as String,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
            shippingCost: freezed == shippingCost
                ? _value.shippingCost
                : shippingCost // ignore: cast_nullable_to_non_nullable
                      as double?,
            minEstimatedDays: freezed == minEstimatedDays
                ? _value.minEstimatedDays
                : minEstimatedDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            maxEstimatedDays: freezed == maxEstimatedDays
                ? _value.maxEstimatedDays
                : maxEstimatedDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            carrierCode: freezed == carrierCode
                ? _value.carrierCode
                : carrierCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            shippingMethodName: freezed == shippingMethodName
                ? _value.shippingMethodName
                : shippingMethodName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPriceRefreshAt: freezed == lastPriceRefreshAt
                ? _value.lastPriceRefreshAt
                : lastPriceRefreshAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastStockRefreshAt: freezed == lastStockRefreshAt
                ? _value.lastStockRefreshAt
                : lastStockRefreshAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SupplierOfferImplCopyWith<$Res>
    implements $SupplierOfferCopyWith<$Res> {
  factory _$$SupplierOfferImplCopyWith(
    _$SupplierOfferImpl value,
    $Res Function(_$SupplierOfferImpl) then,
  ) = __$$SupplierOfferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String productId,
    String supplierId,
    String sourcePlatformId,
    double cost,
    double? shippingCost,
    int? minEstimatedDays,
    int? maxEstimatedDays,
    String? carrierCode,
    String? shippingMethodName,
    DateTime? lastPriceRefreshAt,
    DateTime? lastStockRefreshAt,
  });
}

/// @nodoc
class __$$SupplierOfferImplCopyWithImpl<$Res>
    extends _$SupplierOfferCopyWithImpl<$Res, _$SupplierOfferImpl>
    implements _$$SupplierOfferImplCopyWith<$Res> {
  __$$SupplierOfferImplCopyWithImpl(
    _$SupplierOfferImpl _value,
    $Res Function(_$SupplierOfferImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupplierOffer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? supplierId = null,
    Object? sourcePlatformId = null,
    Object? cost = null,
    Object? shippingCost = freezed,
    Object? minEstimatedDays = freezed,
    Object? maxEstimatedDays = freezed,
    Object? carrierCode = freezed,
    Object? shippingMethodName = freezed,
    Object? lastPriceRefreshAt = freezed,
    Object? lastStockRefreshAt = freezed,
  }) {
    return _then(
      _$SupplierOfferImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        supplierId: null == supplierId
            ? _value.supplierId
            : supplierId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourcePlatformId: null == sourcePlatformId
            ? _value.sourcePlatformId
            : sourcePlatformId // ignore: cast_nullable_to_non_nullable
                  as String,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
        shippingCost: freezed == shippingCost
            ? _value.shippingCost
            : shippingCost // ignore: cast_nullable_to_non_nullable
                  as double?,
        minEstimatedDays: freezed == minEstimatedDays
            ? _value.minEstimatedDays
            : minEstimatedDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        maxEstimatedDays: freezed == maxEstimatedDays
            ? _value.maxEstimatedDays
            : maxEstimatedDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        carrierCode: freezed == carrierCode
            ? _value.carrierCode
            : carrierCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        shippingMethodName: freezed == shippingMethodName
            ? _value.shippingMethodName
            : shippingMethodName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPriceRefreshAt: freezed == lastPriceRefreshAt
            ? _value.lastPriceRefreshAt
            : lastPriceRefreshAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastStockRefreshAt: freezed == lastStockRefreshAt
            ? _value.lastStockRefreshAt
            : lastStockRefreshAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierOfferImpl implements _SupplierOffer {
  const _$SupplierOfferImpl({
    required this.id,
    required this.productId,
    required this.supplierId,
    required this.sourcePlatformId,
    required this.cost,
    this.shippingCost,
    this.minEstimatedDays,
    this.maxEstimatedDays,
    this.carrierCode,
    this.shippingMethodName,
    this.lastPriceRefreshAt,
    this.lastStockRefreshAt,
  });

  factory _$SupplierOfferImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierOfferImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String supplierId;
  @override
  final String sourcePlatformId;
  @override
  final double cost;
  @override
  final double? shippingCost;
  @override
  final int? minEstimatedDays;
  @override
  final int? maxEstimatedDays;
  @override
  final String? carrierCode;
  @override
  final String? shippingMethodName;
  @override
  final DateTime? lastPriceRefreshAt;
  @override
  final DateTime? lastStockRefreshAt;

  @override
  String toString() {
    return 'SupplierOffer(id: $id, productId: $productId, supplierId: $supplierId, sourcePlatformId: $sourcePlatformId, cost: $cost, shippingCost: $shippingCost, minEstimatedDays: $minEstimatedDays, maxEstimatedDays: $maxEstimatedDays, carrierCode: $carrierCode, shippingMethodName: $shippingMethodName, lastPriceRefreshAt: $lastPriceRefreshAt, lastStockRefreshAt: $lastStockRefreshAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierOfferImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.sourcePlatformId, sourcePlatformId) ||
                other.sourcePlatformId == sourcePlatformId) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.shippingCost, shippingCost) ||
                other.shippingCost == shippingCost) &&
            (identical(other.minEstimatedDays, minEstimatedDays) ||
                other.minEstimatedDays == minEstimatedDays) &&
            (identical(other.maxEstimatedDays, maxEstimatedDays) ||
                other.maxEstimatedDays == maxEstimatedDays) &&
            (identical(other.carrierCode, carrierCode) ||
                other.carrierCode == carrierCode) &&
            (identical(other.shippingMethodName, shippingMethodName) ||
                other.shippingMethodName == shippingMethodName) &&
            (identical(other.lastPriceRefreshAt, lastPriceRefreshAt) ||
                other.lastPriceRefreshAt == lastPriceRefreshAt) &&
            (identical(other.lastStockRefreshAt, lastStockRefreshAt) ||
                other.lastStockRefreshAt == lastStockRefreshAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    supplierId,
    sourcePlatformId,
    cost,
    shippingCost,
    minEstimatedDays,
    maxEstimatedDays,
    carrierCode,
    shippingMethodName,
    lastPriceRefreshAt,
    lastStockRefreshAt,
  );

  /// Create a copy of SupplierOffer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierOfferImplCopyWith<_$SupplierOfferImpl> get copyWith =>
      __$$SupplierOfferImplCopyWithImpl<_$SupplierOfferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierOfferImplToJson(this);
  }
}

abstract class _SupplierOffer implements SupplierOffer {
  const factory _SupplierOffer({
    required final String id,
    required final String productId,
    required final String supplierId,
    required final String sourcePlatformId,
    required final double cost,
    final double? shippingCost,
    final int? minEstimatedDays,
    final int? maxEstimatedDays,
    final String? carrierCode,
    final String? shippingMethodName,
    final DateTime? lastPriceRefreshAt,
    final DateTime? lastStockRefreshAt,
  }) = _$SupplierOfferImpl;

  factory _SupplierOffer.fromJson(Map<String, dynamic> json) =
      _$SupplierOfferImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  String get supplierId;
  @override
  String get sourcePlatformId;
  @override
  double get cost;
  @override
  double? get shippingCost;
  @override
  int? get minEstimatedDays;
  @override
  int? get maxEstimatedDays;
  @override
  String? get carrierCode;
  @override
  String? get shippingMethodName;
  @override
  DateTime? get lastPriceRefreshAt;
  @override
  DateTime? get lastStockRefreshAt;

  /// Create a copy of SupplierOffer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierOfferImplCopyWith<_$SupplierOfferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
