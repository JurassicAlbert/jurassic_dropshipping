import 'package:jurassic_dropshipping/data/models/product.dart';

/// Phase 37: Deterministic quality and return-risk scoring for products.
///
/// Keep logic explainable and fast (no ML). Intended for the DEEP ANALYSIS stage.
class ProductQualityRiskResult {
  const ProductQualityRiskResult({
    required this.qualityScore,
    required this.returnRiskScore,
    required this.qualityFactors,
    required this.riskFactors,
  });

  final double qualityScore; // 0..100
  final double returnRiskScore; // 0..100
  final List<String> qualityFactors;
  final List<String> riskFactors;
}

class ProductQualityRiskScorer {
  const ProductQualityRiskScorer();

  ProductQualityRiskResult evaluate(Product p) {
    final qFactors = <String>[];
    final rFactors = <String>[];

    final title = p.title.trim();
    final desc = (p.description ?? '').trim();
    final imageCount = p.imageUrls.length;
    final avgAttrCount = p.variants.isEmpty
        ? 0.0
        : p.variants.map((v) => v.attributes.length).fold<int>(0, (a, b) => a + b) / p.variants.length;

    // --- Quality score (higher is better) ---
    var quality = 60.0;
    if (title.length < 20) {
      quality -= 10;
      qFactors.add('shortTitle');
    } else if (title.length > 80) {
      quality += 3;
      qFactors.add('descriptiveTitle');
    }
    if (desc.isEmpty) {
      quality -= 18;
      qFactors.add('missingDescription');
      rFactors.add('missingDescription');
    } else if (desc.length < 120) {
      quality -= 6;
      qFactors.add('thinDescription');
    } else {
      quality += 4;
      qFactors.add('hasDescription');
    }
    if (imageCount == 0) {
      quality -= 25;
      qFactors.add('noImages');
      rFactors.add('noImages');
    } else if (imageCount < 3) {
      quality -= 8;
      qFactors.add('fewImages');
      rFactors.add('fewImages');
    } else {
      quality += 4;
      qFactors.add('hasImages');
    }
    if (avgAttrCount < 2) {
      quality -= 10;
      qFactors.add('missingSpecs');
      rFactors.add('missingSpecs');
    } else if (avgAttrCount >= 6) {
      quality += 6;
      qFactors.add('richSpecs');
    }

    // --- Risk score (higher is riskier) ---
    var risk = 20.0;
    if (desc.isEmpty) risk += 25;
    if (imageCount == 0) risk += 40;
    if (imageCount > 0 && imageCount < 3) risk += 15;
    if (avgAttrCount < 2) risk += 12;

    // Regex + heuristics (fast, deterministic)
    final lower = '$title $desc'.toLowerCase();
    if (_containsAny(lower, const ['best', 'top', 'premium', '100%', 'original'])) {
      risk += 6;
      rFactors.add('marketingClaims');
    }
    if (_containsAny(lower, const ['???', 'n/a', 'unknown', 'various'])) {
      risk += 6;
      rFactors.add('vagueDescription');
    }
    if (_containsAny(lower, const ['replica', 'copy', 'inspired'])) {
      risk += 10;
      rFactors.add('authenticityRisk');
    }

    quality = quality.clamp(0.0, 100.0);
    risk = risk.clamp(0.0, 100.0);

    return ProductQualityRiskResult(
      qualityScore: quality,
      returnRiskScore: risk,
      qualityFactors: qFactors,
      riskFactors: rFactors,
    );
  }

  bool _containsAny(String haystack, List<String> needles) {
    for (final n in needles) {
      if (haystack.contains(n)) return true;
    }
    return false;
  }
}

