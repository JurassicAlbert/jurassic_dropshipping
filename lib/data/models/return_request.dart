import 'package:freezed_annotation/freezed_annotation.dart';

part 'return_request.freezed.dart';
part 'return_request.g.dart';

enum ReturnStatus { requested, approved, shipped, received, refunded, rejected }
enum ReturnReason { noReason, defective, wrongItem, damagedInTransit, other }

/// Where the customer sends the return package.
enum ReturnDestination { toSupplier, toSeller }

@freezed
class ReturnRequest with _$ReturnRequest {
  const factory ReturnRequest({
    required String id,
    required String orderId,
    required ReturnReason reason,
    required ReturnStatus status,
    String? notes,
    double? refundAmount,
    double? returnShippingCost,
    double? restockingFee,
    DateTime? requestedAt,
    DateTime? resolvedAt,
    /// Customer sends return to this address (supplier's warehouse)
    String? returnToAddress,
    String? returnToCity,
    String? returnToCountry,
    /// Tracking number for the return shipment (customer → supplier)
    String? returnTrackingNumber,
    String? returnCarrier,
    /// The supplier who receives the return
    String? supplierId,
    /// Product that was returned
    String? productId,
    /// Which feed/source platform the original order came through
    String? sourcePlatformId,
    /// Which marketplace the customer bought from
    String? targetPlatformId,
    /// Where customer sends the return (supplier warehouse vs seller address)
    ReturnDestination? returnDestination,
  }) = _ReturnRequest;

  factory ReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$ReturnRequestFromJson(json);
}
