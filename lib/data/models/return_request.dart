import 'package:freezed_annotation/freezed_annotation.dart';

part 'return_request.freezed.dart';
part 'return_request.g.dart';

enum ReturnStatus { requested, approved, shipped, received, refunded, rejected }
enum ReturnReason { noReason, defective, wrongItem, damagedInTransit, other }

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
  }) = _ReturnRequest;

  factory ReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$ReturnRequestFromJson(json);
}
