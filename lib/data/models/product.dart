import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductVariant with _$ProductVariant {
  const factory ProductVariant({
    required String id,
    required String productId,
    required Map<String, String> attributes,
    required double price,
    required int stock,
    String? sku,
  }) = _ProductVariant;

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String sourceId,
    required String sourcePlatformId,
    required String title,
    String? description,
    @Default([]) List<String> imageUrls,
    @Default([]) List<ProductVariant> variants,
    required double basePrice,
    double? shippingCost,
    @Default('PLN') String currency,
    String? supplierId,
    String? supplierCountry,
    int? estimatedDays,
    Map<String, dynamic>? rawJson,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
