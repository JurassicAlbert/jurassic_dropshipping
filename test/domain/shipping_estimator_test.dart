import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/domain/shipping_estimator.dart';

void main() {
  group('ShippingEstimator', () {
    test('uses default handling days of 1', () {
      final estimator = ShippingEstimator();
      expect(estimator.handlingDays, 1);
    });

    test('uses custom handling days', () {
      final estimator = ShippingEstimator(handlingDays: 3);
      expect(estimator.handlingDays, 3);
    });

    test('calculates delivery window with known carrier days', () {
      final estimator = ShippingEstimator(handlingDays: 2);
      final orderDate = DateTime(2025, 6, 1);
      final result = estimator.estimate(
        minCarrierDays: 3,
        maxCarrierDays: 7,
        orderDate: orderDate,
      );
      expect(result.minDays, 5);
      expect(result.maxDays, 9);
      expect(result.earliestDelivery, DateTime(2025, 6, 6));
      expect(result.latestDelivery, DateTime(2025, 6, 10));
    });

    test('uses fallback carrier days when null', () {
      final estimator = ShippingEstimator(handlingDays: 1);
      final orderDate = DateTime(2025, 6, 1);
      final result = estimator.estimate(
        minCarrierDays: null,
        maxCarrierDays: null,
        orderDate: orderDate,
      );
      expect(result.minDays, 8);
      expect(result.maxDays, 22);
      expect(result.earliestDelivery, DateTime(2025, 6, 9));
      expect(result.latestDelivery, DateTime(2025, 6, 23));
    });

    test('uses current time when orderDate is null', () {
      final estimator = ShippingEstimator();
      final before = DateTime.now();
      final result = estimator.estimate(minCarrierDays: 1, maxCarrierDays: 2);
      final after = DateTime.now();
      expect(result.minDays, 2);
      expect(result.maxDays, 3);
      expect(result.earliestDelivery.isAfter(before) || result.earliestDelivery.isAtSameMomentAs(before), isTrue);
      expect(result.latestDelivery.isBefore(after.add(const Duration(days: 4))), isTrue);
    });
  });
}
