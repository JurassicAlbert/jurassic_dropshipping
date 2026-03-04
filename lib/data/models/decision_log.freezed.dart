// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DecisionLog _$DecisionLogFromJson(Map<String, dynamic> json) {
  return _DecisionLog.fromJson(json);
}

/// @nodoc
mixin _$DecisionLog {
  String get id => throw _privateConstructorUsedError;
  DecisionLogType get type => throw _privateConstructorUsedError;
  String get entityId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  Map<String, dynamic>? get criteriaSnapshot =>
      throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this DecisionLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DecisionLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DecisionLogCopyWith<DecisionLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionLogCopyWith<$Res> {
  factory $DecisionLogCopyWith(
    DecisionLog value,
    $Res Function(DecisionLog) then,
  ) = _$DecisionLogCopyWithImpl<$Res, DecisionLog>;
  @useResult
  $Res call({
    String id,
    DecisionLogType type,
    String entityId,
    String reason,
    Map<String, dynamic>? criteriaSnapshot,
    DateTime createdAt,
  });
}

/// @nodoc
class _$DecisionLogCopyWithImpl<$Res, $Val extends DecisionLog>
    implements $DecisionLogCopyWith<$Res> {
  _$DecisionLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DecisionLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? entityId = null,
    Object? reason = null,
    Object? criteriaSnapshot = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as DecisionLogType,
            entityId: null == entityId
                ? _value.entityId
                : entityId // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            criteriaSnapshot: freezed == criteriaSnapshot
                ? _value.criteriaSnapshot
                : criteriaSnapshot // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DecisionLogImplCopyWith<$Res>
    implements $DecisionLogCopyWith<$Res> {
  factory _$$DecisionLogImplCopyWith(
    _$DecisionLogImpl value,
    $Res Function(_$DecisionLogImpl) then,
  ) = __$$DecisionLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DecisionLogType type,
    String entityId,
    String reason,
    Map<String, dynamic>? criteriaSnapshot,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$DecisionLogImplCopyWithImpl<$Res>
    extends _$DecisionLogCopyWithImpl<$Res, _$DecisionLogImpl>
    implements _$$DecisionLogImplCopyWith<$Res> {
  __$$DecisionLogImplCopyWithImpl(
    _$DecisionLogImpl _value,
    $Res Function(_$DecisionLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DecisionLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? entityId = null,
    Object? reason = null,
    Object? criteriaSnapshot = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$DecisionLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as DecisionLogType,
        entityId: null == entityId
            ? _value.entityId
            : entityId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        criteriaSnapshot: freezed == criteriaSnapshot
            ? _value._criteriaSnapshot
            : criteriaSnapshot // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DecisionLogImpl implements _DecisionLog {
  const _$DecisionLogImpl({
    required this.id,
    required this.type,
    required this.entityId,
    required this.reason,
    final Map<String, dynamic>? criteriaSnapshot,
    required this.createdAt,
  }) : _criteriaSnapshot = criteriaSnapshot;

  factory _$DecisionLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$DecisionLogImplFromJson(json);

  @override
  final String id;
  @override
  final DecisionLogType type;
  @override
  final String entityId;
  @override
  final String reason;
  final Map<String, dynamic>? _criteriaSnapshot;
  @override
  Map<String, dynamic>? get criteriaSnapshot {
    final value = _criteriaSnapshot;
    if (value == null) return null;
    if (_criteriaSnapshot is EqualUnmodifiableMapView) return _criteriaSnapshot;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'DecisionLog(id: $id, type: $type, entityId: $entityId, reason: $reason, criteriaSnapshot: $criteriaSnapshot, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecisionLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            const DeepCollectionEquality().equals(
              other._criteriaSnapshot,
              _criteriaSnapshot,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    entityId,
    reason,
    const DeepCollectionEquality().hash(_criteriaSnapshot),
    createdAt,
  );

  /// Create a copy of DecisionLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecisionLogImplCopyWith<_$DecisionLogImpl> get copyWith =>
      __$$DecisionLogImplCopyWithImpl<_$DecisionLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DecisionLogImplToJson(this);
  }
}

abstract class _DecisionLog implements DecisionLog {
  const factory _DecisionLog({
    required final String id,
    required final DecisionLogType type,
    required final String entityId,
    required final String reason,
    final Map<String, dynamic>? criteriaSnapshot,
    required final DateTime createdAt,
  }) = _$DecisionLogImpl;

  factory _DecisionLog.fromJson(Map<String, dynamic> json) =
      _$DecisionLogImpl.fromJson;

  @override
  String get id;
  @override
  DecisionLogType get type;
  @override
  String get entityId;
  @override
  String get reason;
  @override
  Map<String, dynamic>? get criteriaSnapshot;
  @override
  DateTime get createdAt;

  /// Create a copy of DecisionLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecisionLogImplCopyWith<_$DecisionLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
