import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/product_feed.dart';
import 'package:xml/xml.dart';

/// Product feed from an XML file (e.g. warehouse/depot export). Tag/attribute names may differ per warehouse;
/// use [FeedFieldMapping] to map element names to standard fields.
/// Expects structure: optional root, then repeated [itemTag] elements (e.g. &lt;product&gt;), each with child elements
/// whose local names match the mapping (e.g. &lt;ProductName&gt;, &lt;Price&gt;).
class XmlProductFeed implements ProductFeed {
  XmlProductFeed({
    required this.id,
    required this.displayName,
    required this.sourcePlatformId,
    required this.mapping,
    required this.xmlContent,
    this.itemTag = 'product',
    this.rootTag,
  });

  @override
  final String id;
  @override
  final String displayName;
  final String sourcePlatformId;
  final FeedFieldMapping mapping;
  final String xmlContent;
  /// Repeated element that represents one product (e.g. "product", "item").
  final String itemTag;
  /// Optional: only descend into this root first (e.g. "catalog").
  final String? rootTag;

  List<Product>? _cached;
  void invalidateCache() => _cached = null;

  @override
  Future<List<Product>> getProducts() async {
    if (_cached != null) return _cached!;
    final doc = XmlDocument.parse(xmlContent);
    var items = doc.findAllElements(itemTag);
    if (rootTag != null) {
      final root = doc.findAllElements(rootTag!).firstOrNull;
      if (root != null) items = root.findElements(itemTag).toList();
    }
    final products = <Product>[];
    for (final el in items) {
      final product = _elementToProduct(el);
      if (product != null) products.add(product);
    }
    _cached = products;
    return products;
  }

  @override
  Future<Product?> getProduct(String sourceId) async {
    final all = await getProducts();
    try {
      return all.firstWhere((p) => p.sourceId == sourceId);
    } catch (_) {
      return null;
    }
  }

  String? _get(XmlElement parent, String? tagOrAttribute) {
    if (tagOrAttribute == null) return null;
    final child = parent.findElements(tagOrAttribute).firstOrNull;
    if (child != null) return child.innerText.trim();
    final attr = parent.getAttribute(tagOrAttribute);
    return attr?.trim();
  }

  Product? _elementToProduct(XmlElement el) {
    final sourceId = _get(el, mapping.sourceId);
    if (sourceId == null || sourceId.isEmpty) return null;
    final title = _get(el, mapping.title) ?? 'Product';
    final priceStr = _get(el, mapping.basePrice);
    final price = double.tryParse(priceStr ?? '') ?? 0.0;
    final stockStr = _get(el, mapping.stock);
    final stock = int.tryParse(stockStr ?? '') ?? 0;
    final variantId = _get(el, mapping.variantId);
    final variantPriceStr = _get(el, mapping.variantPrice);
    final variantStockStr = _get(el, mapping.variantStock);
    final variantPrice = double.tryParse(variantPriceStr ?? '');
    final variantStock = int.tryParse(variantStockStr ?? '');
    final variant = ProductVariant(
      id: variantId ?? sourceId,
      productId: sourceId,
      attributes: {},
      price: variantPrice ?? price,
      stock: variantStock ?? stock,
    );
    final imageUrl = _get(el, mapping.imageUrl);
    return Product(
      id: sourceId,
      sourceId: sourceId,
      sourcePlatformId: sourcePlatformId,
      title: title,
      description: _get(el, mapping.description),
      imageUrls: imageUrl != null && imageUrl.isNotEmpty ? [imageUrl] : [],
      variants: [variant],
      basePrice: price,
      currency: _get(el, mapping.currency) ?? 'PLN',
      supplierId: _get(el, mapping.supplierId),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
