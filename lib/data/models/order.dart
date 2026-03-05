import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class CustomerAddress with _$CustomerAddress {
  const factory CustomerAddress({
    required String name,
    required String street,
    String? city,
    String? state,
    required String zip,
    required String countryCode,
    required String phone,
    String? email,
  }) = _CustomerAddress;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressFromJson(json);
}

enum OrderStatus {
  pending,
  pendingApproval,
  sourceOrderPlaced,
  shipped,
  delivered,
  failed,
  cancelled,
}

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String listingId,
    required String targetOrderId,
    required String targetPlatformId,
    required CustomerAddress customerAddress,
    required OrderStatus status,
    String? sourceOrderId,
    required double sourceCost,
    required double sellingPrice,
    String? trackingNumber,
    String? decisionLogId,
    String? marketplaceAccountId,
    DateTime? promisedDeliveryMin,
    DateTime? promisedDeliveryMax,
    DateTime? approvedAt,
    DateTime? createdAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
