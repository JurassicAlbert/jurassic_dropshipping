// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'return_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReturnRequest _$ReturnRequestFromJson(Map<String, dynamic> json) {
  return _ReturnRequest.fromJson(json);
}

/// @nodoc
mixin _$ReturnRequest {
  String get id => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  ReturnReason get reason => throw _privateConstructorUsedError;
  ReturnStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  double? get refundAmount => throw _privateConstructorUsedError;
  double? get returnShippingCost => throw _privateConstructorUsedError;
  double? get restockingFee => throw _privateConstructorUsedError;
  DateTime? get requestedAt => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Serializes this ReturnRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReturnRequestCopyWith<ReturnRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReturnRequestCopyWith<$Res> {
  factory $ReturnRequestCopyWith(
    ReturnRequest value,
    $Res Function(ReturnRequest) then,
  ) = _$ReturnRequestCopyWithImpl<$Res, ReturnRequest>;
  @useResult
  $Res call({
    String id,
    String orderId,
    ReturnReason reason,
    ReturnStatus status,
    String? notes,
    double? refundAmount,
    double? returnShippingCost,
    double? restockingFee,
    DateTime? requestedAt,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class _$ReturnRequestCopyWithImpl<$Res, $Val extends ReturnRequest>
    implements $ReturnRequestCopyWith<$Res> {
  _$ReturnRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? reason = null,
    Object? status = null,
    Object? notes = freezed,
    Object? refundAmount = freezed,
    Object? returnShippingCost = freezed,
    Object? restockingFee = freezed,
    Object? requestedAt = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as ReturnReason,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ReturnStatus,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            refundAmount: freezed == refundAmount
                ? _value.refundAmount
                : refundAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            returnShippingCost: freezed == returnShippingCost
                ? _value.returnShippingCost
                : returnShippingCost // ignore: cast_nullable_to_non_nullable
                      as double?,
            restockingFee: freezed == restockingFee
                ? _value.restockingFee
                : restockingFee // ignore: cast_nullable_to_non_nullable
                      as double?,
            requestedAt: freezed == requestedAt
                ? _value.requestedAt
                : requestedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReturnRequestImplCopyWith<$Res>
    implements $ReturnRequestCopyWith<$Res> {
  factory _$$ReturnRequestImplCopyWith(
    _$ReturnRequestImpl value,
    $Res Function(_$ReturnRequestImpl) then,
  ) = __$$ReturnRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String orderId,
    ReturnReason reason,
    ReturnStatus status,
    String? notes,
    double? refundAmount,
    double? returnShippingCost,
    double? restockingFee,
    DateTime? requestedAt,
    DateTime? resolvedAt,
  });
}

/// @nodoc
class __$$ReturnRequestImplCopyWithImpl<$Res>
    extends _$ReturnRequestCopyWithImpl<$Res, _$ReturnRequestImpl>
    implements _$$ReturnRequestImplCopyWith<$Res> {
  __$$ReturnRequestImplCopyWithImpl(
    _$ReturnRequestImpl _value,
    $Res Function(_$ReturnRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderId = null,
    Object? reason = null,
    Object? status = null,
    Object? notes = freezed,
    Object? refundAmount = freezed,
    Object? returnShippingCost = freezed,
    Object? restockingFee = freezed,
    Object? requestedAt = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(
      _$ReturnRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as ReturnReason,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReturnStatus,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        refundAmount: freezed == refundAmount
            ? _value.refundAmount
            : refundAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        returnShippingCost: freezed == returnShippingCost
            ? _value.returnShippingCost
            : returnShippingCost // ignore: cast_nullable_to_non_nullable
                  as double?,
        restockingFee: freezed == restockingFee
            ? _value.restockingFee
            : restockingFee // ignore: cast_nullable_to_non_nullable
                  as double?,
        requestedAt: freezed == requestedAt
            ? _value.requestedAt
            : requestedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReturnRequestImpl implements _ReturnRequest {
  const _$ReturnRequestImpl({
    required this.id,
    required this.orderId,
    required this.reason,
    required this.status,
    this.notes,
    this.refundAmount,
    this.returnShippingCost,
    this.restockingFee,
    this.requestedAt,
    this.resolvedAt,
  });

  factory _$ReturnRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReturnRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String orderId;
  @override
  final ReturnReason reason;
  @override
  final ReturnStatus status;
  @override
  final String? notes;
  @override
  final double? refundAmount;
  @override
  final double? returnShippingCost;
  @override
  final double? restockingFee;
  @override
  final DateTime? requestedAt;
  @override
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'ReturnRequest(id: $id, orderId: $orderId, reason: $reason, status: $status, notes: $notes, refundAmount: $refundAmount, returnShippingCost: $returnShippingCost, restockingFee: $restockingFee, requestedAt: $requestedAt, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReturnRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.refundAmount, refundAmount) ||
                other.refundAmount == refundAmount) &&
            (identical(other.returnShippingCost, returnShippingCost) ||
                other.returnShippingCost == returnShippingCost) &&
            (identical(other.restockingFee, restockingFee) ||
                other.restockingFee == restockingFee) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orderId,
    reason,
    status,
    notes,
    refundAmount,
    returnShippingCost,
    restockingFee,
    requestedAt,
    resolvedAt,
  );

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReturnRequestImplCopyWith<_$ReturnRequestImpl> get copyWith =>
      __$$ReturnRequestImplCopyWithImpl<_$ReturnRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReturnRequestImplToJson(this);
  }
}

abstract class _ReturnRequest implements ReturnRequest {
  const factory _ReturnRequest({
    required final String id,
    required final String orderId,
    required final ReturnReason reason,
    required final ReturnStatus status,
    final String? notes,
    final double? refundAmount,
    final double? returnShippingCost,
    final double? restockingFee,
    final DateTime? requestedAt,
    final DateTime? resolvedAt,
  }) = _$ReturnRequestImpl;

  factory _ReturnRequest.fromJson(Map<String, dynamic> json) =
      _$ReturnRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get orderId;
  @override
  ReturnReason get reason;
  @override
  ReturnStatus get status;
  @override
  String? get notes;
  @override
  double? get refundAmount;
  @override
  double? get returnShippingCost;
  @override
  double? get restockingFee;
  @override
  DateTime? get requestedAt;
  @override
  DateTime? get resolvedAt;

  /// Create a copy of ReturnRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReturnRequestImplCopyWith<_$ReturnRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
