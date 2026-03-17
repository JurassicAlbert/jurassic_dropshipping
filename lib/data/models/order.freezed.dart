// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerAddress _$CustomerAddressFromJson(Map<String, dynamic> json) {
  return _CustomerAddress.fromJson(json);
}

/// @nodoc
mixin _$CustomerAddress {
  String get name => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String get zip => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this CustomerAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerAddressCopyWith<CustomerAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerAddressCopyWith<$Res> {
  factory $CustomerAddressCopyWith(
    CustomerAddress value,
    $Res Function(CustomerAddress) then,
  ) = _$CustomerAddressCopyWithImpl<$Res, CustomerAddress>;
  @useResult
  $Res call({
    String name,
    String street,
    String? city,
    String? state,
    String zip,
    String countryCode,
    String phone,
    String? email,
  });
}

/// @nodoc
class _$CustomerAddressCopyWithImpl<$Res, $Val extends CustomerAddress>
    implements $CustomerAddressCopyWith<$Res> {
  _$CustomerAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? street = null,
    Object? city = freezed,
    Object? state = freezed,
    Object? zip = null,
    Object? countryCode = null,
    Object? phone = null,
    Object? email = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            street: null == street
                ? _value.street
                : street // ignore: cast_nullable_to_non_nullable
                      as String,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String?,
            zip: null == zip
                ? _value.zip
                : zip // ignore: cast_nullable_to_non_nullable
                      as String,
            countryCode: null == countryCode
                ? _value.countryCode
                : countryCode // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerAddressImplCopyWith<$Res>
    implements $CustomerAddressCopyWith<$Res> {
  factory _$$CustomerAddressImplCopyWith(
    _$CustomerAddressImpl value,
    $Res Function(_$CustomerAddressImpl) then,
  ) = __$$CustomerAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String street,
    String? city,
    String? state,
    String zip,
    String countryCode,
    String phone,
    String? email,
  });
}

/// @nodoc
class __$$CustomerAddressImplCopyWithImpl<$Res>
    extends _$CustomerAddressCopyWithImpl<$Res, _$CustomerAddressImpl>
    implements _$$CustomerAddressImplCopyWith<$Res> {
  __$$CustomerAddressImplCopyWithImpl(
    _$CustomerAddressImpl _value,
    $Res Function(_$CustomerAddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? street = null,
    Object? city = freezed,
    Object? state = freezed,
    Object? zip = null,
    Object? countryCode = null,
    Object? phone = null,
    Object? email = freezed,
  }) {
    return _then(
      _$CustomerAddressImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        street: null == street
            ? _value.street
            : street // ignore: cast_nullable_to_non_nullable
                  as String,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String?,
        zip: null == zip
            ? _value.zip
            : zip // ignore: cast_nullable_to_non_nullable
                  as String,
        countryCode: null == countryCode
            ? _value.countryCode
            : countryCode // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerAddressImpl implements _CustomerAddress {
  const _$CustomerAddressImpl({
    required this.name,
    required this.street,
    this.city,
    this.state,
    required this.zip,
    required this.countryCode,
    required this.phone,
    this.email,
  });

  factory _$CustomerAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerAddressImplFromJson(json);

  @override
  final String name;
  @override
  final String street;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String zip;
  @override
  final String countryCode;
  @override
  final String phone;
  @override
  final String? email;

  @override
  String toString() {
    return 'CustomerAddress(name: $name, street: $street, city: $city, state: $state, zip: $zip, countryCode: $countryCode, phone: $phone, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerAddressImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zip, zip) || other.zip == zip) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    street,
    city,
    state,
    zip,
    countryCode,
    phone,
    email,
  );

  /// Create a copy of CustomerAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerAddressImplCopyWith<_$CustomerAddressImpl> get copyWith =>
      __$$CustomerAddressImplCopyWithImpl<_$CustomerAddressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerAddressImplToJson(this);
  }
}

abstract class _CustomerAddress implements CustomerAddress {
  const factory _CustomerAddress({
    required final String name,
    required final String street,
    final String? city,
    final String? state,
    required final String zip,
    required final String countryCode,
    required final String phone,
    final String? email,
  }) = _$CustomerAddressImpl;

  factory _CustomerAddress.fromJson(Map<String, dynamic> json) =
      _$CustomerAddressImpl.fromJson;

  @override
  String get name;
  @override
  String get street;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String get zip;
  @override
  String get countryCode;
  @override
  String get phone;
  @override
  String? get email;

  /// Create a copy of CustomerAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerAddressImplCopyWith<_$CustomerAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String get id => throw _privateConstructorUsedError;
  String get listingId => throw _privateConstructorUsedError;
  String get targetOrderId => throw _privateConstructorUsedError;
  String get targetPlatformId => throw _privateConstructorUsedError;
  CustomerAddress get customerAddress => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  String? get sourceOrderId => throw _privateConstructorUsedError;
  double get sourceCost => throw _privateConstructorUsedError;
  double get sellingPrice => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get trackingNumber => throw _privateConstructorUsedError;
  String? get decisionLogId => throw _privateConstructorUsedError;
  String? get marketplaceAccountId => throw _privateConstructorUsedError;
  DateTime? get promisedDeliveryMin => throw _privateConstructorUsedError;
  DateTime? get promisedDeliveryMax => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Post-order lifecycle; null until backfilled or set by lifecycle engine.
  String? get lifecycleState => throw _privateConstructorUsedError;

  /// Phase 14: financial state (unpaid, supplier_paid, marketplace_released, refunded, loss). Nullable.
  String? get financialState => throw _privateConstructorUsedError;

  /// Phase 14: true when order is waiting for capital before fulfillment.
  bool get queuedForCapital => throw _privateConstructorUsedError;

  /// Phase 16: risk score 0–100; null until evaluated.
  double? get riskScore => throw _privateConstructorUsedError;

  /// Phase 16: JSON array of factor names.
  String? get riskFactorsJson => throw _privateConstructorUsedError;

  /// Buyer message / parcel comment (e.g. for warehouse). From Allegro when API provides it.
  String? get buyerMessage => throw _privateConstructorUsedError;

  /// Delivery method name (e.g. InPost Locker). From Allegro when API provides it.
  String? get deliveryMethodName => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    String id,
    String listingId,
    String targetOrderId,
    String targetPlatformId,
    CustomerAddress customerAddress,
    OrderStatus status,
    String? sourceOrderId,
    double sourceCost,
    double sellingPrice,
    int quantity,
    String? trackingNumber,
    String? decisionLogId,
    String? marketplaceAccountId,
    DateTime? promisedDeliveryMin,
    DateTime? promisedDeliveryMax,
    DateTime? deliveredAt,
    DateTime? approvedAt,
    DateTime? createdAt,
    String? lifecycleState,
    String? financialState,
    bool queuedForCapital,
    double? riskScore,
    String? riskFactorsJson,
    String? buyerMessage,
    String? deliveryMethodName,
  });

  $CustomerAddressCopyWith<$Res> get customerAddress;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? targetOrderId = null,
    Object? targetPlatformId = null,
    Object? customerAddress = null,
    Object? status = null,
    Object? sourceOrderId = freezed,
    Object? sourceCost = null,
    Object? sellingPrice = null,
    Object? quantity = null,
    Object? trackingNumber = freezed,
    Object? decisionLogId = freezed,
    Object? marketplaceAccountId = freezed,
    Object? promisedDeliveryMin = freezed,
    Object? promisedDeliveryMax = freezed,
    Object? deliveredAt = freezed,
    Object? approvedAt = freezed,
    Object? createdAt = freezed,
    Object? lifecycleState = freezed,
    Object? financialState = freezed,
    Object? queuedForCapital = null,
    Object? riskScore = freezed,
    Object? riskFactorsJson = freezed,
    Object? buyerMessage = freezed,
    Object? deliveryMethodName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            listingId: null == listingId
                ? _value.listingId
                : listingId // ignore: cast_nullable_to_non_nullable
                      as String,
            targetOrderId: null == targetOrderId
                ? _value.targetOrderId
                : targetOrderId // ignore: cast_nullable_to_non_nullable
                      as String,
            targetPlatformId: null == targetPlatformId
                ? _value.targetPlatformId
                : targetPlatformId // ignore: cast_nullable_to_non_nullable
                      as String,
            customerAddress: null == customerAddress
                ? _value.customerAddress
                : customerAddress // ignore: cast_nullable_to_non_nullable
                      as CustomerAddress,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OrderStatus,
            sourceOrderId: freezed == sourceOrderId
                ? _value.sourceOrderId
                : sourceOrderId // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceCost: null == sourceCost
                ? _value.sourceCost
                : sourceCost // ignore: cast_nullable_to_non_nullable
                      as double,
            sellingPrice: null == sellingPrice
                ? _value.sellingPrice
                : sellingPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            trackingNumber: freezed == trackingNumber
                ? _value.trackingNumber
                : trackingNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            decisionLogId: freezed == decisionLogId
                ? _value.decisionLogId
                : decisionLogId // ignore: cast_nullable_to_non_nullable
                      as String?,
            marketplaceAccountId: freezed == marketplaceAccountId
                ? _value.marketplaceAccountId
                : marketplaceAccountId // ignore: cast_nullable_to_non_nullable
                      as String?,
            promisedDeliveryMin: freezed == promisedDeliveryMin
                ? _value.promisedDeliveryMin
                : promisedDeliveryMin // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            promisedDeliveryMax: freezed == promisedDeliveryMax
                ? _value.promisedDeliveryMax
                : promisedDeliveryMax // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            deliveredAt: freezed == deliveredAt
                ? _value.deliveredAt
                : deliveredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            approvedAt: freezed == approvedAt
                ? _value.approvedAt
                : approvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lifecycleState: freezed == lifecycleState
                ? _value.lifecycleState
                : lifecycleState // ignore: cast_nullable_to_non_nullable
                      as String?,
            financialState: freezed == financialState
                ? _value.financialState
                : financialState // ignore: cast_nullable_to_non_nullable
                      as String?,
            queuedForCapital: null == queuedForCapital
                ? _value.queuedForCapital
                : queuedForCapital // ignore: cast_nullable_to_non_nullable
                      as bool,
            riskScore: freezed == riskScore
                ? _value.riskScore
                : riskScore // ignore: cast_nullable_to_non_nullable
                      as double?,
            riskFactorsJson: freezed == riskFactorsJson
                ? _value.riskFactorsJson
                : riskFactorsJson // ignore: cast_nullable_to_non_nullable
                      as String?,
            buyerMessage: freezed == buyerMessage
                ? _value.buyerMessage
                : buyerMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            deliveryMethodName: freezed == deliveryMethodName
                ? _value.deliveryMethodName
                : deliveryMethodName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerAddressCopyWith<$Res> get customerAddress {
    return $CustomerAddressCopyWith<$Res>(_value.customerAddress, (value) {
      return _then(_value.copyWith(customerAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String listingId,
    String targetOrderId,
    String targetPlatformId,
    CustomerAddress customerAddress,
    OrderStatus status,
    String? sourceOrderId,
    double sourceCost,
    double sellingPrice,
    int quantity,
    String? trackingNumber,
    String? decisionLogId,
    String? marketplaceAccountId,
    DateTime? promisedDeliveryMin,
    DateTime? promisedDeliveryMax,
    DateTime? deliveredAt,
    DateTime? approvedAt,
    DateTime? createdAt,
    String? lifecycleState,
    String? financialState,
    bool queuedForCapital,
    double? riskScore,
    String? riskFactorsJson,
    String? buyerMessage,
    String? deliveryMethodName,
  });

  @override
  $CustomerAddressCopyWith<$Res> get customerAddress;
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? targetOrderId = null,
    Object? targetPlatformId = null,
    Object? customerAddress = null,
    Object? status = null,
    Object? sourceOrderId = freezed,
    Object? sourceCost = null,
    Object? sellingPrice = null,
    Object? quantity = null,
    Object? trackingNumber = freezed,
    Object? decisionLogId = freezed,
    Object? marketplaceAccountId = freezed,
    Object? promisedDeliveryMin = freezed,
    Object? promisedDeliveryMax = freezed,
    Object? deliveredAt = freezed,
    Object? approvedAt = freezed,
    Object? createdAt = freezed,
    Object? lifecycleState = freezed,
    Object? financialState = freezed,
    Object? queuedForCapital = null,
    Object? riskScore = freezed,
    Object? riskFactorsJson = freezed,
    Object? buyerMessage = freezed,
    Object? deliveryMethodName = freezed,
  }) {
    return _then(
      _$OrderImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        listingId: null == listingId
            ? _value.listingId
            : listingId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetOrderId: null == targetOrderId
            ? _value.targetOrderId
            : targetOrderId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetPlatformId: null == targetPlatformId
            ? _value.targetPlatformId
            : targetPlatformId // ignore: cast_nullable_to_non_nullable
                  as String,
        customerAddress: null == customerAddress
            ? _value.customerAddress
            : customerAddress // ignore: cast_nullable_to_non_nullable
                  as CustomerAddress,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OrderStatus,
        sourceOrderId: freezed == sourceOrderId
            ? _value.sourceOrderId
            : sourceOrderId // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceCost: null == sourceCost
            ? _value.sourceCost
            : sourceCost // ignore: cast_nullable_to_non_nullable
                  as double,
        sellingPrice: null == sellingPrice
            ? _value.sellingPrice
            : sellingPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        trackingNumber: freezed == trackingNumber
            ? _value.trackingNumber
            : trackingNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        decisionLogId: freezed == decisionLogId
            ? _value.decisionLogId
            : decisionLogId // ignore: cast_nullable_to_non_nullable
                  as String?,
        marketplaceAccountId: freezed == marketplaceAccountId
            ? _value.marketplaceAccountId
            : marketplaceAccountId // ignore: cast_nullable_to_non_nullable
                  as String?,
        promisedDeliveryMin: freezed == promisedDeliveryMin
            ? _value.promisedDeliveryMin
            : promisedDeliveryMin // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        promisedDeliveryMax: freezed == promisedDeliveryMax
            ? _value.promisedDeliveryMax
            : promisedDeliveryMax // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        deliveredAt: freezed == deliveredAt
            ? _value.deliveredAt
            : deliveredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        approvedAt: freezed == approvedAt
            ? _value.approvedAt
            : approvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lifecycleState: freezed == lifecycleState
            ? _value.lifecycleState
            : lifecycleState // ignore: cast_nullable_to_non_nullable
                  as String?,
        financialState: freezed == financialState
            ? _value.financialState
            : financialState // ignore: cast_nullable_to_non_nullable
                  as String?,
        queuedForCapital: null == queuedForCapital
            ? _value.queuedForCapital
            : queuedForCapital // ignore: cast_nullable_to_non_nullable
                  as bool,
        riskScore: freezed == riskScore
            ? _value.riskScore
            : riskScore // ignore: cast_nullable_to_non_nullable
                  as double?,
        riskFactorsJson: freezed == riskFactorsJson
            ? _value.riskFactorsJson
            : riskFactorsJson // ignore: cast_nullable_to_non_nullable
                  as String?,
        buyerMessage: freezed == buyerMessage
            ? _value.buyerMessage
            : buyerMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        deliveryMethodName: freezed == deliveryMethodName
            ? _value.deliveryMethodName
            : deliveryMethodName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl({
    required this.id,
    required this.listingId,
    required this.targetOrderId,
    required this.targetPlatformId,
    required this.customerAddress,
    required this.status,
    this.sourceOrderId,
    required this.sourceCost,
    required this.sellingPrice,
    this.quantity = 1,
    this.trackingNumber,
    this.decisionLogId,
    this.marketplaceAccountId,
    this.promisedDeliveryMin,
    this.promisedDeliveryMax,
    this.deliveredAt,
    this.approvedAt,
    this.createdAt,
    this.lifecycleState,
    this.financialState,
    this.queuedForCapital = false,
    this.riskScore,
    this.riskFactorsJson,
    this.buyerMessage,
    this.deliveryMethodName,
  });

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String id;
  @override
  final String listingId;
  @override
  final String targetOrderId;
  @override
  final String targetPlatformId;
  @override
  final CustomerAddress customerAddress;
  @override
  final OrderStatus status;
  @override
  final String? sourceOrderId;
  @override
  final double sourceCost;
  @override
  final double sellingPrice;
  @override
  @JsonKey()
  final int quantity;
  @override
  final String? trackingNumber;
  @override
  final String? decisionLogId;
  @override
  final String? marketplaceAccountId;
  @override
  final DateTime? promisedDeliveryMin;
  @override
  final DateTime? promisedDeliveryMax;
  @override
  final DateTime? deliveredAt;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? createdAt;

  /// Post-order lifecycle; null until backfilled or set by lifecycle engine.
  @override
  final String? lifecycleState;

  /// Phase 14: financial state (unpaid, supplier_paid, marketplace_released, refunded, loss). Nullable.
  @override
  final String? financialState;

  /// Phase 14: true when order is waiting for capital before fulfillment.
  @override
  @JsonKey()
  final bool queuedForCapital;

  /// Phase 16: risk score 0–100; null until evaluated.
  @override
  final double? riskScore;

  /// Phase 16: JSON array of factor names.
  @override
  final String? riskFactorsJson;

  /// Buyer message / parcel comment (e.g. for warehouse). From Allegro when API provides it.
  @override
  final String? buyerMessage;

  /// Delivery method name (e.g. InPost Locker). From Allegro when API provides it.
  @override
  final String? deliveryMethodName;

  @override
  String toString() {
    return 'Order(id: $id, listingId: $listingId, targetOrderId: $targetOrderId, targetPlatformId: $targetPlatformId, customerAddress: $customerAddress, status: $status, sourceOrderId: $sourceOrderId, sourceCost: $sourceCost, sellingPrice: $sellingPrice, quantity: $quantity, trackingNumber: $trackingNumber, decisionLogId: $decisionLogId, marketplaceAccountId: $marketplaceAccountId, promisedDeliveryMin: $promisedDeliveryMin, promisedDeliveryMax: $promisedDeliveryMax, deliveredAt: $deliveredAt, approvedAt: $approvedAt, createdAt: $createdAt, lifecycleState: $lifecycleState, financialState: $financialState, queuedForCapital: $queuedForCapital, riskScore: $riskScore, riskFactorsJson: $riskFactorsJson, buyerMessage: $buyerMessage, deliveryMethodName: $deliveryMethodName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.targetOrderId, targetOrderId) ||
                other.targetOrderId == targetOrderId) &&
            (identical(other.targetPlatformId, targetPlatformId) ||
                other.targetPlatformId == targetPlatformId) &&
            (identical(other.customerAddress, customerAddress) ||
                other.customerAddress == customerAddress) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sourceOrderId, sourceOrderId) ||
                other.sourceOrderId == sourceOrderId) &&
            (identical(other.sourceCost, sourceCost) ||
                other.sourceCost == sourceCost) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.trackingNumber, trackingNumber) ||
                other.trackingNumber == trackingNumber) &&
            (identical(other.decisionLogId, decisionLogId) ||
                other.decisionLogId == decisionLogId) &&
            (identical(other.marketplaceAccountId, marketplaceAccountId) ||
                other.marketplaceAccountId == marketplaceAccountId) &&
            (identical(other.promisedDeliveryMin, promisedDeliveryMin) ||
                other.promisedDeliveryMin == promisedDeliveryMin) &&
            (identical(other.promisedDeliveryMax, promisedDeliveryMax) ||
                other.promisedDeliveryMax == promisedDeliveryMax) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lifecycleState, lifecycleState) ||
                other.lifecycleState == lifecycleState) &&
            (identical(other.financialState, financialState) ||
                other.financialState == financialState) &&
            (identical(other.queuedForCapital, queuedForCapital) ||
                other.queuedForCapital == queuedForCapital) &&
            (identical(other.riskScore, riskScore) ||
                other.riskScore == riskScore) &&
            (identical(other.riskFactorsJson, riskFactorsJson) ||
                other.riskFactorsJson == riskFactorsJson) &&
            (identical(other.buyerMessage, buyerMessage) ||
                other.buyerMessage == buyerMessage) &&
            (identical(other.deliveryMethodName, deliveryMethodName) ||
                other.deliveryMethodName == deliveryMethodName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    listingId,
    targetOrderId,
    targetPlatformId,
    customerAddress,
    status,
    sourceOrderId,
    sourceCost,
    sellingPrice,
    quantity,
    trackingNumber,
    decisionLogId,
    marketplaceAccountId,
    promisedDeliveryMin,
    promisedDeliveryMax,
    deliveredAt,
    approvedAt,
    createdAt,
    lifecycleState,
    financialState,
    queuedForCapital,
    riskScore,
    riskFactorsJson,
    buyerMessage,
    deliveryMethodName,
  ]);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order({
    required final String id,
    required final String listingId,
    required final String targetOrderId,
    required final String targetPlatformId,
    required final CustomerAddress customerAddress,
    required final OrderStatus status,
    final String? sourceOrderId,
    required final double sourceCost,
    required final double sellingPrice,
    final int quantity,
    final String? trackingNumber,
    final String? decisionLogId,
    final String? marketplaceAccountId,
    final DateTime? promisedDeliveryMin,
    final DateTime? promisedDeliveryMax,
    final DateTime? deliveredAt,
    final DateTime? approvedAt,
    final DateTime? createdAt,
    final String? lifecycleState,
    final String? financialState,
    final bool queuedForCapital,
    final double? riskScore,
    final String? riskFactorsJson,
    final String? buyerMessage,
    final String? deliveryMethodName,
  }) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String get id;
  @override
  String get listingId;
  @override
  String get targetOrderId;
  @override
  String get targetPlatformId;
  @override
  CustomerAddress get customerAddress;
  @override
  OrderStatus get status;
  @override
  String? get sourceOrderId;
  @override
  double get sourceCost;
  @override
  double get sellingPrice;
  @override
  int get quantity;
  @override
  String? get trackingNumber;
  @override
  String? get decisionLogId;
  @override
  String? get marketplaceAccountId;
  @override
  DateTime? get promisedDeliveryMin;
  @override
  DateTime? get promisedDeliveryMax;
  @override
  DateTime? get deliveredAt;
  @override
  DateTime? get approvedAt;
  @override
  DateTime? get createdAt;

  /// Post-order lifecycle; null until backfilled or set by lifecycle engine.
  @override
  String? get lifecycleState;

  /// Phase 14: financial state (unpaid, supplier_paid, marketplace_released, refunded, loss). Nullable.
  @override
  String? get financialState;

  /// Phase 14: true when order is waiting for capital before fulfillment.
  @override
  bool get queuedForCapital;

  /// Phase 16: risk score 0–100; null until evaluated.
  @override
  double? get riskScore;

  /// Phase 16: JSON array of factor names.
  @override
  String? get riskFactorsJson;

  /// Buyer message / parcel comment (e.g. for warehouse). From Allegro when API provides it.
  @override
  String? get buyerMessage;

  /// Delivery method name (e.g. InPost Locker). From Allegro when API provides it.
  @override
  String? get deliveryMethodName;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
