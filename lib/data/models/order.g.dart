// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerAddressImpl _$$CustomerAddressImplFromJson(
  Map<String, dynamic> json,
) => _$CustomerAddressImpl(
  name: json['name'] as String,
  street: json['street'] as String,
  city: json['city'] as String?,
  state: json['state'] as String?,
  zip: json['zip'] as String,
  countryCode: json['countryCode'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String?,
);

Map<String, dynamic> _$$CustomerAddressImplToJson(
  _$CustomerAddressImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'zip': instance.zip,
  'countryCode': instance.countryCode,
  'phone': instance.phone,
  'email': instance.email,
};

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
  id: json['id'] as String,
  listingId: json['listingId'] as String,
  targetOrderId: json['targetOrderId'] as String,
  targetPlatformId: json['targetPlatformId'] as String,
  customerAddress: CustomerAddress.fromJson(
    json['customerAddress'] as Map<String, dynamic>,
  ),
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  sourceOrderId: json['sourceOrderId'] as String?,
  sourceCost: (json['sourceCost'] as num).toDouble(),
  sellingPrice: (json['sellingPrice'] as num).toDouble(),
  trackingNumber: json['trackingNumber'] as String?,
  decisionLogId: json['decisionLogId'] as String?,
  marketplaceAccountId: json['marketplaceAccountId'] as String?,
  promisedDeliveryMin: json['promisedDeliveryMin'] == null
      ? null
      : DateTime.parse(json['promisedDeliveryMin'] as String),
  promisedDeliveryMax: json['promisedDeliveryMax'] == null
      ? null
      : DateTime.parse(json['promisedDeliveryMax'] as String),
  deliveredAt: json['deliveredAt'] == null
      ? null
      : DateTime.parse(json['deliveredAt'] as String),
  approvedAt: json['approvedAt'] == null
      ? null
      : DateTime.parse(json['approvedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listingId': instance.listingId,
      'targetOrderId': instance.targetOrderId,
      'targetPlatformId': instance.targetPlatformId,
      'customerAddress': instance.customerAddress,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'sourceOrderId': instance.sourceOrderId,
      'sourceCost': instance.sourceCost,
      'sellingPrice': instance.sellingPrice,
      'trackingNumber': instance.trackingNumber,
      'decisionLogId': instance.decisionLogId,
      'marketplaceAccountId': instance.marketplaceAccountId,
      'promisedDeliveryMin': instance.promisedDeliveryMin?.toIso8601String(),
      'promisedDeliveryMax': instance.promisedDeliveryMax?.toIso8601String(),
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.pendingApproval: 'pendingApproval',
  OrderStatus.sourceOrderPlaced: 'sourceOrderPlaced',
  OrderStatus.shipped: 'shipped',
  OrderStatus.delivered: 'delivered',
  OrderStatus.failed: 'failed',
  OrderStatus.failedOutOfStock: 'failedOutOfStock',
  OrderStatus.cancelled: 'cancelled',
};
