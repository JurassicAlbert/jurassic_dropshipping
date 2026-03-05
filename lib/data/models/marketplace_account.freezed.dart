// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marketplace_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MarketplaceAccount _$MarketplaceAccountFromJson(Map<String, dynamic> json) {
  return _MarketplaceAccount.fromJson(json);
}

/// @nodoc
mixin _$MarketplaceAccount {
  String get id => throw _privateConstructorUsedError;
  String get platformId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get connectedAt => throw _privateConstructorUsedError;

  /// Serializes this MarketplaceAccount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketplaceAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketplaceAccountCopyWith<MarketplaceAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketplaceAccountCopyWith<$Res> {
  factory $MarketplaceAccountCopyWith(
    MarketplaceAccount value,
    $Res Function(MarketplaceAccount) then,
  ) = _$MarketplaceAccountCopyWithImpl<$Res, MarketplaceAccount>;
  @useResult
  $Res call({
    String id,
    String platformId,
    String displayName,
    bool isActive,
    DateTime? connectedAt,
  });
}

/// @nodoc
class _$MarketplaceAccountCopyWithImpl<$Res, $Val extends MarketplaceAccount>
    implements $MarketplaceAccountCopyWith<$Res> {
  _$MarketplaceAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketplaceAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? platformId = null,
    Object? displayName = null,
    Object? isActive = null,
    Object? connectedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            platformId: null == platformId
                ? _value.platformId
                : platformId // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            connectedAt: freezed == connectedAt
                ? _value.connectedAt
                : connectedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarketplaceAccountImplCopyWith<$Res>
    implements $MarketplaceAccountCopyWith<$Res> {
  factory _$$MarketplaceAccountImplCopyWith(
    _$MarketplaceAccountImpl value,
    $Res Function(_$MarketplaceAccountImpl) then,
  ) = __$$MarketplaceAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String platformId,
    String displayName,
    bool isActive,
    DateTime? connectedAt,
  });
}

/// @nodoc
class __$$MarketplaceAccountImplCopyWithImpl<$Res>
    extends _$MarketplaceAccountCopyWithImpl<$Res, _$MarketplaceAccountImpl>
    implements _$$MarketplaceAccountImplCopyWith<$Res> {
  __$$MarketplaceAccountImplCopyWithImpl(
    _$MarketplaceAccountImpl _value,
    $Res Function(_$MarketplaceAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarketplaceAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? platformId = null,
    Object? displayName = null,
    Object? isActive = null,
    Object? connectedAt = freezed,
  }) {
    return _then(
      _$MarketplaceAccountImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        platformId: null == platformId
            ? _value.platformId
            : platformId // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        connectedAt: freezed == connectedAt
            ? _value.connectedAt
            : connectedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketplaceAccountImpl implements _MarketplaceAccount {
  const _$MarketplaceAccountImpl({
    required this.id,
    required this.platformId,
    required this.displayName,
    this.isActive = false,
    this.connectedAt,
  });

  factory _$MarketplaceAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketplaceAccountImplFromJson(json);

  @override
  final String id;
  @override
  final String platformId;
  @override
  final String displayName;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? connectedAt;

  @override
  String toString() {
    return 'MarketplaceAccount(id: $id, platformId: $platformId, displayName: $displayName, isActive: $isActive, connectedAt: $connectedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketplaceAccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.platformId, platformId) ||
                other.platformId == platformId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.connectedAt, connectedAt) ||
                other.connectedAt == connectedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    platformId,
    displayName,
    isActive,
    connectedAt,
  );

  /// Create a copy of MarketplaceAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketplaceAccountImplCopyWith<_$MarketplaceAccountImpl> get copyWith =>
      __$$MarketplaceAccountImplCopyWithImpl<_$MarketplaceAccountImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketplaceAccountImplToJson(this);
  }
}

abstract class _MarketplaceAccount implements MarketplaceAccount {
  const factory _MarketplaceAccount({
    required final String id,
    required final String platformId,
    required final String displayName,
    final bool isActive,
    final DateTime? connectedAt,
  }) = _$MarketplaceAccountImpl;

  factory _MarketplaceAccount.fromJson(Map<String, dynamic> json) =
      _$MarketplaceAccountImpl.fromJson;

  @override
  String get id;
  @override
  String get platformId;
  @override
  String get displayName;
  @override
  bool get isActive;
  @override
  DateTime? get connectedAt;

  /// Create a copy of MarketplaceAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketplaceAccountImplCopyWith<_$MarketplaceAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
