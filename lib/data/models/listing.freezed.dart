// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Listing _$ListingFromJson(Map<String, dynamic> json) {
  return _Listing.fromJson(json);
}

/// @nodoc
mixin _$Listing {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get targetPlatformId => throw _privateConstructorUsedError;
  String? get targetListingId => throw _privateConstructorUsedError;
  ListingStatus get status => throw _privateConstructorUsedError;
  double get sellingPrice => throw _privateConstructorUsedError;
  double get sourceCost => throw _privateConstructorUsedError;
  String? get decisionLogId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get publishedAt => throw _privateConstructorUsedError;

  /// Serializes this Listing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingCopyWith<Listing> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingCopyWith<$Res> {
  factory $ListingCopyWith(Listing value, $Res Function(Listing) then) =
      _$ListingCopyWithImpl<$Res, Listing>;
  @useResult
  $Res call({
    String id,
    String productId,
    String targetPlatformId,
    String? targetListingId,
    ListingStatus status,
    double sellingPrice,
    double sourceCost,
    String? decisionLogId,
    DateTime? createdAt,
    DateTime? publishedAt,
  });
}

/// @nodoc
class _$ListingCopyWithImpl<$Res, $Val extends Listing>
    implements $ListingCopyWith<$Res> {
  _$ListingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? targetPlatformId = null,
    Object? targetListingId = freezed,
    Object? status = null,
    Object? sellingPrice = null,
    Object? sourceCost = null,
    Object? decisionLogId = freezed,
    Object? createdAt = freezed,
    Object? publishedAt = freezed,
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
            targetPlatformId: null == targetPlatformId
                ? _value.targetPlatformId
                : targetPlatformId // ignore: cast_nullable_to_non_nullable
                      as String,
            targetListingId: freezed == targetListingId
                ? _value.targetListingId
                : targetListingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ListingStatus,
            sellingPrice: null == sellingPrice
                ? _value.sellingPrice
                : sellingPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            sourceCost: null == sourceCost
                ? _value.sourceCost
                : sourceCost // ignore: cast_nullable_to_non_nullable
                      as double,
            decisionLogId: freezed == decisionLogId
                ? _value.decisionLogId
                : decisionLogId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            publishedAt: freezed == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ListingImplCopyWith<$Res> implements $ListingCopyWith<$Res> {
  factory _$$ListingImplCopyWith(
    _$ListingImpl value,
    $Res Function(_$ListingImpl) then,
  ) = __$$ListingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String productId,
    String targetPlatformId,
    String? targetListingId,
    ListingStatus status,
    double sellingPrice,
    double sourceCost,
    String? decisionLogId,
    DateTime? createdAt,
    DateTime? publishedAt,
  });
}

/// @nodoc
class __$$ListingImplCopyWithImpl<$Res>
    extends _$ListingCopyWithImpl<$Res, _$ListingImpl>
    implements _$$ListingImplCopyWith<$Res> {
  __$$ListingImplCopyWithImpl(
    _$ListingImpl _value,
    $Res Function(_$ListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? targetPlatformId = null,
    Object? targetListingId = freezed,
    Object? status = null,
    Object? sellingPrice = null,
    Object? sourceCost = null,
    Object? decisionLogId = freezed,
    Object? createdAt = freezed,
    Object? publishedAt = freezed,
  }) {
    return _then(
      _$ListingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetPlatformId: null == targetPlatformId
            ? _value.targetPlatformId
            : targetPlatformId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetListingId: freezed == targetListingId
            ? _value.targetListingId
            : targetListingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ListingStatus,
        sellingPrice: null == sellingPrice
            ? _value.sellingPrice
            : sellingPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        sourceCost: null == sourceCost
            ? _value.sourceCost
            : sourceCost // ignore: cast_nullable_to_non_nullable
                  as double,
        decisionLogId: freezed == decisionLogId
            ? _value.decisionLogId
            : decisionLogId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        publishedAt: freezed == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingImpl implements _Listing {
  const _$ListingImpl({
    required this.id,
    required this.productId,
    required this.targetPlatformId,
    this.targetListingId,
    required this.status,
    required this.sellingPrice,
    required this.sourceCost,
    this.decisionLogId,
    this.createdAt,
    this.publishedAt,
  });

  factory _$ListingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String targetPlatformId;
  @override
  final String? targetListingId;
  @override
  final ListingStatus status;
  @override
  final double sellingPrice;
  @override
  final double sourceCost;
  @override
  final String? decisionLogId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? publishedAt;

  @override
  String toString() {
    return 'Listing(id: $id, productId: $productId, targetPlatformId: $targetPlatformId, targetListingId: $targetListingId, status: $status, sellingPrice: $sellingPrice, sourceCost: $sourceCost, decisionLogId: $decisionLogId, createdAt: $createdAt, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.targetPlatformId, targetPlatformId) ||
                other.targetPlatformId == targetPlatformId) &&
            (identical(other.targetListingId, targetListingId) ||
                other.targetListingId == targetListingId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.sourceCost, sourceCost) ||
                other.sourceCost == sourceCost) &&
            (identical(other.decisionLogId, decisionLogId) ||
                other.decisionLogId == decisionLogId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    targetPlatformId,
    targetListingId,
    status,
    sellingPrice,
    sourceCost,
    decisionLogId,
    createdAt,
    publishedAt,
  );

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingImplCopyWith<_$ListingImpl> get copyWith =>
      __$$ListingImplCopyWithImpl<_$ListingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingImplToJson(this);
  }
}

abstract class _Listing implements Listing {
  const factory _Listing({
    required final String id,
    required final String productId,
    required final String targetPlatformId,
    final String? targetListingId,
    required final ListingStatus status,
    required final double sellingPrice,
    required final double sourceCost,
    final String? decisionLogId,
    final DateTime? createdAt,
    final DateTime? publishedAt,
  }) = _$ListingImpl;

  factory _Listing.fromJson(Map<String, dynamic> json) = _$ListingImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  String get targetPlatformId;
  @override
  String? get targetListingId;
  @override
  ListingStatus get status;
  @override
  double get sellingPrice;
  @override
  double get sourceCost;
  @override
  String? get decisionLogId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get publishedAt;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingImplCopyWith<_$ListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
