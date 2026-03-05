import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';

void main() {
  late PricingCalculator calculator;

  setUp(() {
    calculator = PricingCalculator(marketplaceFeePercent: 10.0);
  });

  group('calculateSellingPrice', () {
    test('computes price with default 30% markup and 10% fee', () {
      const rules = UserRules(defaultMarkupPercent: 30.0);
      final price = calculator.calculateSellingPrice(100.0, rules);
      // 100 * 1.30 / 0.90 = 144.44...
      expect(price, closeTo(144.44, 0.01));
    });

    test('computes price with zero markup', () {
      const rules = UserRules(defaultMarkupPercent: 0.0);
      final price = calculator.calculateSellingPrice(100.0, rules);
      // 100 * 1.0 / 0.90 = 111.11...
      expect(price, closeTo(111.11, 0.01));
    });

    test('handles zero source cost', () {
      const rules = UserRules(defaultMarkupPercent: 30.0);
      final price = calculator.calculateSellingPrice(0.0, rules);
      expect(price, equals(0.0));
    });

    test('handles fee >= 100% gracefully', () {
      final calc = PricingCalculator(marketplaceFeePercent: 100.0);
      const rules = UserRules(defaultMarkupPercent: 30.0);
      final price = calc.calculateSellingPrice(100.0, rules);
      expect(price, closeTo(130.0, 0.01));
    });
  });

  group('profitAfterFee', () {
    test('returns correct profit after marketplace fee', () {
      final profit = calculator.profitAfterFee(144.44, 100.0);
      // 144.44 - 100 - 14.444 = 29.996
      expect(profit, closeTo(30.0, 0.1));
    });

    test('returns negative when selling below cost', () {
      final profit = calculator.profitAfterFee(90.0, 100.0);
      // 90 - 100 - 9 = -19
      expect(profit, lessThan(0));
    });
  });

  group('profitMarginPercent', () {
    test('returns margin as percent of selling price', () {
      final margin = calculator.profitMarginPercent(144.44, 100.0);
      // profit ~30 / 144.44 * 100 ≈ 20.77%
      expect(margin, closeTo(20.77, 0.1));
    });

    test('returns 0 when selling price is zero', () {
      final margin = calculator.profitMarginPercent(0.0, 100.0);
      expect(margin, equals(0.0));
    });
  });

  group('meetsMinProfit', () {
    test('returns true when margin exceeds min', () {
      const rules = UserRules(minProfitPercent: 15.0);
      // margin ~20.77% >= 15%
      expect(calculator.meetsMinProfit(144.44, 100.0, rules), isTrue);
    });

    test('returns false when margin below min', () {
      const rules = UserRules(minProfitPercent: 25.0);
      // margin ~20.77% < 25%
      expect(calculator.meetsMinProfit(144.44, 100.0, rules), isFalse);
    });
  });
}
