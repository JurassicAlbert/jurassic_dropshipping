import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart';

/// A supplier (e.g. CJ, API2Cart-connected store, local wholesaler).
@freezed
class Supplier with _$Supplier {
  const factory Supplier({
    required String id,
    required String name,
    /// e.g. 'cj', 'api2cart', 'local'
    required String platformType,
    String? countryCode,
    double? rating,
    /// Days for no-reason return window offered by the supplier.
    int? returnWindowDays,
    /// Cost to ship a return back to the supplier (approx).
    double? returnShippingCost,
    /// Restocking fee percent (0-100).
    double? restockingFeePercent,
    /// Whether supplier accepts no-reason returns.
    @Default(false) bool acceptsNoReasonReturns,
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);
}

