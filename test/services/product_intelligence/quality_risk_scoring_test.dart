import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/services/product_intelligence/quality_risk_scoring.dart';

void main() {
  const scorer = ProductQualityRiskScorer();

  test('missing description and images increases risk', () {
    final p = Product(
      id: 'p1',
      sourceId: 's1',
      sourcePlatformId: 'cj',
      title: 'Test product',
      description: '',
      imageUrls: const [],
      basePrice: 10,
      variants: const [],
    );

    final r = scorer.evaluate(p);
    expect(r.returnRiskScore, greaterThan(50));
    expect(r.riskFactors, contains('missingDescription'));
    expect(r.riskFactors, contains('noImages'));
  });

  test('rich specs and images improves quality', () {
    final p = Product(
      id: 'p1',
      sourceId: 's1',
      sourcePlatformId: 'cj',
      title: 'High quality winter jacket size M waterproof',
      description: 'A detailed description that is long enough to be considered useful.' * 4,
      imageUrls: const ['1', '2', '3', '4'],
      basePrice: 10,
      variants: const [
        ProductVariant(
          id: 'v1',
          productId: 'p1',
          attributes: {'Size': 'M', 'Material': 'Polyester', 'Color': 'Black', 'Gender': 'Unisex', 'Season': 'Winter', 'Fit': 'Regular'},
          price: 10,
          stock: 5,
        ),
      ],
    );

    final r = scorer.evaluate(p);
    expect(r.qualityScore, greaterThan(70));
    expect(r.qualityFactors, contains('richSpecs'));
    expect(r.qualityFactors, contains('hasImages'));
  });
}

