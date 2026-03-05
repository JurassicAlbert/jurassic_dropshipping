import 'package:freezed_annotation/freezed_annotation.dart';

part 'marketplace_account.freezed.dart';
part 'marketplace_account.g.dart';

@freezed
class MarketplaceAccount with _$MarketplaceAccount {
  const factory MarketplaceAccount({
    required String id,
    required String platformId,
    required String displayName,
    @Default(false) bool isActive,
    DateTime? connectedAt,
  }) = _MarketplaceAccount;

  factory MarketplaceAccount.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceAccountFromJson(json);
}
