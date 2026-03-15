import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:jurassic_dropshipping/domain/post_order/return_routing.dart';

part 'return_request.freezed.dart';
part 'return_request.g.dart';

/// JSON converter for [ReturnRoutingDestination] (DB string: SELLER_ADDRESS, etc.). Missing key => null.
ReturnRoutingDestination? _returnRoutingFromJson(String? v) =>
    v == null ? null : ReturnRoutingDestinationExtension.fromDbString(v);
String? _returnRoutingToJson(ReturnRoutingDestination? v) => v?.toDbString();

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
    /// Routing target: seller address, supplier warehouse, return center, disposal (Phase 4).
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: _returnRoutingFromJson, toJson: _returnRoutingToJson)
    ReturnRoutingDestination? returnRoutingDestination,
  }) = _ReturnRequest;

  factory ReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$ReturnRequestFromJson(json);
}
