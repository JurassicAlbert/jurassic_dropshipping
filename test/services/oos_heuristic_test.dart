import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/core/app_error.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';

void main() {
  group('isLikelyOutOfStock', () {
    test('returns true for CJ error code 1602002 (product removed)', () {
      final error = ApiError(1602002, 'Product removed');
      expect(FulfillmentService.isLikelyOutOfStock(error), isTrue);
    });

    test('returns true for CJ error code 1603102 (inventory deduction fail)', () {
      final error = ApiError(1603102, 'Inventory fail');
      expect(FulfillmentService.isLikelyOutOfStock(error), isTrue);
    });

    test('returns true for generic out of stock message', () {
      expect(FulfillmentService.isLikelyOutOfStock(Exception('out of stock')), isTrue);
    });

    test('returns true for insufficient stock message', () {
      expect(FulfillmentService.isLikelyOutOfStock(Exception('insufficient stock')), isTrue);
    });

    test('returns true for sold out message', () {
      expect(FulfillmentService.isLikelyOutOfStock(Exception('sold out')), isTrue);
    });

    test('returns false for generic error', () {
      expect(FulfillmentService.isLikelyOutOfStock(Exception('network timeout')), isFalse);
    });

    test('returns false for auth error', () {
      expect(FulfillmentService.isLikelyOutOfStock(Exception('unauthorized')), isFalse);
    });

    test('strict mode only matches CJ codes', () {
      final cjError = ApiError(1602002, 'removed');
      expect(FulfillmentService.isLikelyOutOfStock(cjError, null, true), isTrue);

      final genericOOS = Exception('out of stock');
      expect(FulfillmentService.isLikelyOutOfStock(genericOOS, null, true), isFalse);
    });

    test('strict mode false for ApiError without known code', () {
      final error = ApiError(999, 'out of stock');
      expect(FulfillmentService.isLikelyOutOfStock(error, null, true), isFalse);
    });
  });
}
