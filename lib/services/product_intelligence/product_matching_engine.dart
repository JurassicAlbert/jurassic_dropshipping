import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/data/repositories/product_group_repository.dart';

/// Result of matching one product into a deterministic ProductGroup.
class ProductMatchResult {
  const ProductMatchResult({
    required this.groupId,
    required this.matchedBy,
    required this.confidence,
    this.ean,
    this.sku,
  });

  final String groupId;
  final String matchedBy;
  final double confidence; // 0..1
  final String? ean;
  final String? sku;
}

/// Phase 37: Multi-layer deterministic product matching.
///
/// Matching priority:
/// 1) EAN/GTIN/barcode (highest confidence)
/// 2) SKU (variant sku or model-like attribute)
/// 3) Fallback hash of normalized title + stable attributes + image hash placeholder
class ProductMatchingEngine {
  ProductMatchingEngine({required this.groupRepo, this.matchVersion = 1});

  final ProductGroupRepository groupRepo;
  final int matchVersion;

  Future<ProductMatchResult> matchOne(Product product, {required int tenantId}) async {
    final ean = _extractEan(product);
    final sku = _extractSku(product);
    final titleNorm = _norm(product.title);
    final attrsHash = _attributesHash(product);
    final imgHash = _imageHash(product);

    late final String groupId;
    late final String matchedBy;
    late final double confidence;

    if (ean != null && ean.isNotEmpty) {
      groupId = 'ean_$ean';
      matchedBy = 'ean';
      confidence = 1.0;
    } else if (sku != null && sku.isNotEmpty) {
      groupId = 'sku_${_shortSafe(sku)}';
      matchedBy = 'sku';
      confidence = 0.92;
    } else {
      // Fallback: deterministic hash key. Keep it stable across runs.
      final key = 't:$titleNorm|a:$attrsHash|i:$imgHash';
      groupId = 'h_${sha256.convert(utf8.encode(key)).toString().substring(0, 24)}';
      matchedBy = 'hash';
      confidence = 0.65;
    }

    await groupRepo.upsertGroup(
      groupId: groupId,
      canonicalProductId: product.id,
      ean: ean,
      sku: sku,
      titleNormalized: titleNorm,
      attributesHash: attrsHash,
      imageHash: imgHash,
      matchVersion: matchVersion,
    );
    await groupRepo.upsertMember(
      groupId: groupId,
      productId: product.id,
      confidence: confidence,
      matchedBy: matchedBy,
    );

    return ProductMatchResult(
      groupId: groupId,
      matchedBy: matchedBy,
      confidence: confidence,
      ean: ean,
      sku: sku,
    );
  }

  String? _extractEan(Product p) {
    // Try rawJson keys first.
    final raw = p.rawJson;
    String? val;
    if (raw != null) {
      val = _firstString(raw, const ['ean', 'gtin', 'barcode', 'upc']);
    }
    // Try variant attributes.
    val ??= _firstVariantAttribute(p, const ['ean', 'gtin', 'barcode', 'upc']);
    if (val == null) return null;
    final digits = val.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 8) return null;
    return digits;
  }

  String? _extractSku(Product p) {
    // Prefer explicit variant.sku if present.
    for (final v in p.variants) {
      final s = (v.sku ?? '').trim();
      if (s.isNotEmpty) return s;
    }
    // Try rawJson keys commonly used.
    final raw = p.rawJson;
    final s = raw != null ? _firstString(raw, const ['sku', 'model', 'mpn']) : null;
    if (s != null && s.trim().isNotEmpty) return s.trim();
    // Try variant attributes.
    return _firstVariantAttribute(p, const ['sku', 'model', 'mpn']);
  }

  String _attributesHash(Product p) {
    final map = <String, String>{};
    // Aggregate a stable subset across variants.
    for (final v in p.variants) {
      v.attributes.forEach((k, v) {
        final kk = _norm(k);
        if (kk.isEmpty) return;
        // Keep first-seen to remain deterministic.
        map.putIfAbsent(kk, () => _norm(v));
      });
    }
    final keys = map.keys.toList()..sort();
    final b = StringBuffer();
    for (final k in keys) {
      b.write(k);
      b.write('=');
      b.write(map[k]);
      b.write(';');
    }
    return sha256.convert(utf8.encode(b.toString())).toString().substring(0, 24);
  }

  String _imageHash(Product p) {
    final urls = List<String>.from(p.imageUrls)..sort();
    final joined = urls.join('|');
    if (joined.isEmpty) return 'none';
    return sha256.convert(utf8.encode(joined)).toString().substring(0, 16);
  }

  String? _firstVariantAttribute(Product p, List<String> keys) {
    final keySet = keys.map(_norm).toSet();
    for (final v in p.variants) {
      for (final entry in v.attributes.entries) {
        final k = _norm(entry.key);
        if (keySet.contains(k)) {
          final val = entry.value.trim();
          if (val.isNotEmpty) return val;
        }
      }
    }
    return null;
  }

  String? _firstString(Map<String, dynamic> raw, List<String> keys) {
    for (final k in keys) {
      final v = raw[k];
      if (v is String && v.trim().isNotEmpty) return v.trim();
      if (v is num) return v.toString();
    }
    return null;
  }

  String _shortSafe(String s) {
    final cleaned = s.trim();
    if (cleaned.length <= 64) return cleaned;
    return cleaned.substring(0, 64);
  }

  String _norm(String s) => s.trim().toLowerCase();
}

