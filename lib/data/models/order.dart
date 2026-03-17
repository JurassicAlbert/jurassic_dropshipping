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
  failedOutOfStock,
  cancelled,
}

/// Post-order lifecycle state (Phase 1). Stored on Order; validated by PostOrderLifecycleEngine.
enum OrderLifecycleState {
  created,
  pendingApproval,
  approved,
  sentToSupplier,
  shipped,
  delivered,
  returnRequested,
  returnApproved,
  returned,
  complaintOpened,
  refunded,
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
    @Default(1) int quantity,
    String? trackingNumber,
    String? decisionLogId,
    String? marketplaceAccountId,
    DateTime? promisedDeliveryMin,
    DateTime? promisedDeliveryMax,
    DateTime? deliveredAt,
    DateTime? approvedAt,
    DateTime? createdAt,
    /// Post-order lifecycle; null until backfilled or set by lifecycle engine.
    String? lifecycleState,
    /// Phase 14: financial state (unpaid, supplier_paid, marketplace_released, refunded, loss). Nullable.
    String? financialState,
    /// Phase 14: true when order is waiting for capital before fulfillment.
    @Default(false) bool queuedForCapital,
    /// Phase 16: risk score 0–100; null until evaluated.
    double? riskScore,
    /// Phase 16: JSON array of factor names.
    String? riskFactorsJson,
    /// Buyer message / parcel comment (e.g. for warehouse). From Allegro when API provides it.
    String? buyerMessage,
    /// Delivery method name (e.g. InPost Locker). From Allegro when API provides it.
    String? deliveryMethodName,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
