import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier_offer.freezed.dart';
part 'supplier_offer.g.dart';

/// A concrete offer from a supplier for a given product.
@freezed
class SupplierOffer with _$SupplierOffer {
  const factory SupplierOffer({
    required String id,
    required String productId,
    required String supplierId,
    required String sourcePlatformId,
    required double cost,
    double? shippingCost,
    int? minEstimatedDays,
    int? maxEstimatedDays,
    String? carrierCode,
    String? shippingMethodName,
    DateTime? lastPriceRefreshAt,
    DateTime? lastStockRefreshAt,
  }) = _SupplierOffer;

  factory SupplierOffer.fromJson(Map<String, dynamic> json) =>
      _$SupplierOfferFromJson(json);
}

