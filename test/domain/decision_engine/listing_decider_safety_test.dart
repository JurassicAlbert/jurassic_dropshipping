import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/listing_decider.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';

void main() {
  late ListingDecider decider;
  late PricingCalculator calculator;

  setUp(() {
    calculator = PricingCalculator(marketplaceFeePercent: 10.0);
    decider = ListingDecider(pricingCalculator: calculator);
  });

  Product _product({
    double basePrice = 50.0,
    double? shippingCost = 5.0,
    String id = 'prod_safety',
  }) {
    return Product(
      id: id,
      sourceId: 'src_1',
      sourcePlatformId: 'cj',
      title: 'Safety Test Product',
      basePrice: basePrice,
      shippingCost: shippingCost,
      variants: const [
        ProductVariant(id: 'v1', productId: 'prod_safety', attributes: {}, price: 50.0, stock: 10),
      ],
    );
  }

  group('Safety guardrails', () {
    test('rejects when absolute profit is less than 5 PLN', () {
      final product = _product(basePrice: 3.0, shippingCost: 1.0);
      const rules = UserRules(
        minProfitPercent: 5.0,
        defaultMarkupPercent: 30.0,
      );

      final sourceCost = product.basePrice + (product.shippingCost ?? 0);
      final sellingPrice = calculator.calculateSellingPrice(sourceCost, rules);
      final absoluteProfit = calculator.profitAfterFee(sellingPrice, sourceCost);
      expect(absoluteProfit, lessThan(5.0));

      final decision = decider.decide(product, rules);
      expect(decision.isAccept, isFalse);
      expect(decision.reason, contains('Absolute profit'));
      expect(decision.reason, contains('< 5 PLN'));
    });

    test('rejects when selling price exceeds 10x source cost', () {
      final product = _product(basePrice: 1.0, shippingCost: 0.0);
      const rules = UserRules(
        minProfitPercent: 5.0,
        defaultMarkupPercent: 1000.0,
      );

      final sourceCost = product.basePrice + (product.shippingCost ?? 0);
      final sellingPrice = calculator.calculateSellingPrice(sourceCost, rules);
      expect(sellingPrice, greaterThan(sourceCost * 10));

      final decision = decider.decide(product, rules);
      expect(decision.isAccept, isFalse);
      expect(decision.reason, contains('10x source cost'));
    });

    test('accepts product with profit just above 5 PLN threshold', () {
      const rules = UserRules(
        minProfitPercent: 5.0,
        defaultMarkupPercent: 30.0,
      );

      final product = _product(basePrice: 25.0, shippingCost: 5.0);

      final sourceCost = product.basePrice + (product.shippingCost ?? 0);
      final sellingPrice = calculator.calculateSellingPrice(sourceCost, rules);
      final absoluteProfit = calculator.profitAfterFee(sellingPrice, sourceCost);
      expect(absoluteProfit, greaterThanOrEqualTo(5.0));

      final decision = decider.decide(product, rules);
      expect(decision.isAccept, isTrue);
    });

    test('accepts borderline margin just at threshold', () {
      const rules = UserRules(
        minProfitPercent: 20.0,
        defaultMarkupPercent: 30.0,
      );

      final product = _product(basePrice: 50.0, shippingCost: 5.0);
      final decision = decider.decide(product, rules);

      final sourceCost = product.basePrice + (product.shippingCost ?? 0);
      final sellingPrice = calculator.calculateSellingPrice(sourceCost, rules);
      final margin = calculator.profitMarginPercent(sellingPrice, sourceCost);

      expect(margin, greaterThanOrEqualTo(rules.minProfitPercent));
      expect(decision.isAccept, isTrue);
    });

    test('accepts selling price just under 10x threshold', () {
      const rules = UserRules(
        minProfitPercent: 5.0,
        defaultMarkupPercent: 700.0,
      );

      final product = _product(basePrice: 10.0, shippingCost: 0.0);
      final sourceCost = product.basePrice + (product.shippingCost ?? 0);
      final sellingPrice = calculator.calculateSellingPrice(sourceCost, rules);

      if (sellingPrice <= sourceCost * 10) {
        final decision = decider.decide(product, rules);
        expect(decision.isAccept, isTrue);
      } else {
        final decision = decider.decide(product, rules);
        expect(decision.isAccept, isFalse);
        expect(decision.reason, contains('10x'));
      }
    });

    test('rejects product below min profit even with safety checks passing', () {
      const rules = UserRules(
        minProfitPercent: 99.0,
        defaultMarkupPercent: 1.0,
      );

      final product = _product(basePrice: 50.0, shippingCost: 5.0);
      final decision = decider.decide(product, rules);

      expect(decision.isAccept, isFalse);
      expect(decision.reason, contains('<'));
    });
  });
}
