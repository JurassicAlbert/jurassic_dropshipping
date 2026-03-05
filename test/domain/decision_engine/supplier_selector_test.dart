import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/supplier_selector.dart';

void main() {
  late SupplierSelector selector;

  setUp(() {
    selector = SupplierSelector();
  });

  Product _product({
    String id = 'p1',
    double basePrice = 10.0,
    double? shippingCost = 5.0,
    String? supplierId,
    String? supplierCountry,
    int? estimatedDays,
  }) {
    return Product(
      id: id,
      sourceId: 'src_$id',
      sourcePlatformId: 'cj',
      title: 'Product $id',
      basePrice: basePrice,
      shippingCost: shippingCost,
      supplierId: supplierId,
      supplierCountry: supplierCountry,
      estimatedDays: estimatedDays,
      variants: const [],
    );
  }

  group('select', () {
    test('returns null product for empty list', () {
      final result = selector.select([], const UserRules());
      expect(result.product, isNull);
      expect(result.reason, 'No candidates');
    });

    test('returns single candidate directly', () {
      final product = _product();
      final result = selector.select([product], const UserRules());
      expect(result.product, equals(product));
      expect(result.reason, 'Only one source');
    });

    test('selects cheapest by total cost', () {
      final cheap = _product(id: 'cheap', basePrice: 5.0, shippingCost: 2.0);
      final expensive = _product(id: 'expensive', basePrice: 20.0, shippingCost: 5.0);
      final result = selector.select([expensive, cheap], const UserRules());
      expect(result.product?.id, 'cheap');
    });

    test('filters blacklisted suppliers', () {
      final good = _product(id: 'good', supplierId: 'ok', basePrice: 20.0);
      final bad = _product(id: 'bad', supplierId: 'blacklisted', basePrice: 5.0);
      const rules = UserRules(blacklistedSupplierIds: ['blacklisted']);
      final result = selector.select([bad, good], rules);
      expect(result.product?.id, 'good');
    });

    test('filters blacklisted products', () {
      final good = _product(id: 'good', basePrice: 20.0);
      final bad = _product(id: 'bad', basePrice: 5.0);
      const rules = UserRules(blacklistedProductIds: ['bad']);
      final result = selector.select([bad, good], rules);
      expect(result.product?.id, 'good');
    });

    test('returns null when all candidates blacklisted', () {
      final p1 = _product(id: 'p1', supplierId: 'bl');
      final p2 = _product(id: 'p2', supplierId: 'bl');
      const rules = UserRules(blacklistedSupplierIds: ['bl']);
      final result = selector.select([p1, p2], rules);
      expect(result.product, isNull);
      expect(result.reason, 'All candidates blacklisted');
    });

    test('prefers candidates from preferred countries', () {
      final pl = _product(id: 'pl', basePrice: 15.0, supplierCountry: 'PL');
      final cn = _product(id: 'cn', basePrice: 5.0, supplierCountry: 'CN');
      const rules = UserRules(preferredSupplierCountries: ['PL']);
      final result = selector.select([cn, pl], rules);
      expect(result.product?.id, 'pl');
    });

    test('falls back to all when no preferred country matches', () {
      final cn1 = _product(id: 'cn1', basePrice: 15.0, supplierCountry: 'CN');
      final cn2 = _product(id: 'cn2', basePrice: 5.0, supplierCountry: 'CN');
      const rules = UserRules(preferredSupplierCountries: ['PL']);
      final result = selector.select([cn1, cn2], rules);
      expect(result.product?.id, 'cn2');
    });

    test('filters by max source price', () {
      final cheap = _product(id: 'cheap', basePrice: 5.0, shippingCost: 2.0);
      final expensive = _product(id: 'expensive', basePrice: 20.0, shippingCost: 5.0);
      const rules = UserRules(maxSourcePrice: 10.0);
      final result = selector.select([expensive, cheap], rules);
      expect(result.product?.id, 'cheap');
    });

    test('returns null when all exceed max source price', () {
      final p1 = _product(id: 'p1', basePrice: 20.0, shippingCost: 5.0);
      final p2 = _product(id: 'p2', basePrice: 15.0, shippingCost: 5.0);
      const rules = UserRules(maxSourcePrice: 10.0);
      final result = selector.select([p1, p2], rules);
      expect(result.product, isNull);
    });

    test('breaks cost tie by estimated delivery days', () {
      final fast = _product(id: 'fast', basePrice: 10.0, shippingCost: 5.0, estimatedDays: 3);
      final slow = _product(id: 'slow', basePrice: 10.0, shippingCost: 5.0, estimatedDays: 14);
      final result = selector.select([slow, fast], const UserRules());
      expect(result.product?.id, 'fast');
    });
  });
}
