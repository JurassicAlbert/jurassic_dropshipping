import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/models/supplier.dart';
import 'package:jurassic_dropshipping/data/models/supplier_offer.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/supplier_selector.dart';

void main() {
  late SupplierSelector selector;

  setUp(() {
    selector = SupplierSelector();
  });

  SupplierOffer _offer({
    String id = 'o1',
    String productId = 'p1',
    String supplierId = 's1',
    double cost = 10.0,
    double? shippingCost = 5.0,
    int? maxEstimatedDays,
  }) {
    return SupplierOffer(
      id: id,
      productId: productId,
      supplierId: supplierId,
      sourcePlatformId: 'cj',
      cost: cost,
      shippingCost: shippingCost,
      maxEstimatedDays: maxEstimatedDays,
    );
  }

  group('selectFromOffers', () {
    test('returns null for empty offers list', () {
      final result = selector.selectFromOffers([], const UserRules());
      expect(result.offer, isNull);
      expect(result.reason, 'No offers');
    });

    test('returns single offer directly', () {
      final offer = _offer();
      final result = selector.selectFromOffers([offer], const UserRules());
      expect(result.offer, equals(offer));
      expect(result.reason, 'Only one offer');
    });

    test('selects cheapest by total cost', () {
      final cheap = _offer(id: 'cheap', cost: 5.0, shippingCost: 2.0);
      final expensive = _offer(id: 'expensive', cost: 20.0, shippingCost: 5.0);
      final result = selector.selectFromOffers([expensive, cheap], const UserRules());
      expect(result.offer?.id, 'cheap');
    });

    test('filters blacklisted suppliers', () {
      final good = _offer(id: 'good', supplierId: 'ok', cost: 20.0);
      final bad = _offer(id: 'bad', supplierId: 'blacklisted', cost: 5.0);
      const rules = UserRules(blacklistedSupplierIds: ['blacklisted']);
      final result = selector.selectFromOffers([bad, good], rules);
      expect(result.offer?.id, 'good');
    });

    test('filters by max source price', () {
      final cheap = _offer(id: 'cheap', cost: 5.0, shippingCost: 2.0);
      final expensive = _offer(id: 'expensive', cost: 20.0, shippingCost: 5.0);
      const rules = UserRules(maxSourcePrice: 10.0);
      final result = selector.selectFromOffers([expensive, cheap], rules);
      expect(result.offer?.id, 'cheap');
    });

    test('prefers preferred countries when supplier info available', () {
      final plOffer = _offer(id: 'pl', supplierId: 'spl', cost: 15.0);
      final cnOffer = _offer(id: 'cn', supplierId: 'scn', cost: 5.0);
      const plSupplier = Supplier(id: 'spl', name: 'PL Supplier', platformType: 'local', countryCode: 'PL');
      const cnSupplier = Supplier(id: 'scn', name: 'CN Supplier', platformType: 'cj', countryCode: 'CN');
      const rules = UserRules(preferredSupplierCountries: ['PL']);
      final result = selector.selectFromOffers(
        [cnOffer, plOffer],
        rules,
        suppliers: [plSupplier, cnSupplier],
      );
      expect(result.offer?.id, 'pl');
    });

    test('breaks cost tie by estimated delivery days', () {
      final fast = _offer(id: 'fast', cost: 10.0, shippingCost: 5.0, maxEstimatedDays: 3);
      final slow = _offer(id: 'slow', cost: 10.0, shippingCost: 5.0, maxEstimatedDays: 14);
      final result = selector.selectFromOffers([slow, fast], const UserRules());
      expect(result.offer?.id, 'fast');
    });
  });
}
