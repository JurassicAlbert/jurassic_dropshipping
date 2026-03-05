import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing.freezed.dart';
part 'listing.g.dart';

enum ListingStatus {
  draft,
  pendingApproval,
  active,
  soldOut,
}

@freezed
class Listing with _$Listing {
  const factory Listing({
    required String id,
    required String productId,
    required String targetPlatformId,
    String? targetListingId,
    required ListingStatus status,
    required double sellingPrice,
    required double sourceCost,
    String? decisionLogId,
    String? marketplaceAccountId,
    DateTime? createdAt,
    DateTime? publishedAt,
  }) = _Listing;

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
}
