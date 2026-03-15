import 'package:jurassic_dropshipping/data/models/product.dart';

/// Standard field names used when mapping warehouse feed columns/elements to [Product].
/// Use these keys in [FeedFieldMapping] so different CSV/XML schemas can map to the same model.
class FeedFields {
  FeedFields._();
  static const sourceId = 'sourceId';
  static const title = 'title';
  static const description = 'description';
  static const basePrice = 'basePrice';
  static const stock = 'stock';
  static const imageUrl = 'imageUrl';
  static const currency = 'currency';
  static const supplierId = 'supplierId';
  static const variantId = 'variantId';
  static const variantPrice = 'variantPrice';
  static const variantStock = 'variantStock';
}

/// Mapping from feed-specific column names (CSV) or element names/paths (XML) to [FeedFields].
/// Warehouses use different headers; e.g. CSV might have "Product Name" -> title, "Unit Price" -> basePrice.
class FeedFieldMapping {
  const FeedFieldMapping({
    this.sourceId,
    this.title,
    this.description,
    this.basePrice,
    this.stock,
    this.imageUrl,
    this.currency,
    this.supplierId,
    this.variantId,
    this.variantPrice,
    this.variantStock,
  });

  /// CSV column name or XML tag/path for product identifier (required).
  final String? sourceId;
  final String? title;
  final String? description;
  final String? basePrice;
  final String? stock;
  final String? imageUrl;
  final String? currency;
  final String? supplierId;
  /// For multi-variant rows: column/tag for variant id.
  final String? variantId;
  final String? variantPrice;
  final String? variantStock;

  /// Example: CSV with headers "SKU", "Product Name", "Price", "Qty", "Image"
  static const FeedFieldMapping csvExample = FeedFieldMapping(
    sourceId: 'SKU',
    title: 'Product Name',
    basePrice: 'Price',
    stock: 'Qty',
    imageUrl: 'Image',
  );
}

/// Product catalog from a warehouse/depot (origin) – API, CSV, or XML.
/// Use this when sourcing directly from wholesaler/warehouse instead of a middleman (CJ, API2Cart).
/// Feeds differ per warehouse; use [FeedFieldMapping] to map columns/elements to [Product].
abstract class ProductFeed {
  /// Unique id for this feed (e.g. "warehouse_alpha", "depot_csv").
  String get id;

  /// Human-readable name.
  String get displayName;

  /// Load all products from the feed. May be large; consider paging or streaming in future.
  Future<List<Product>> getProducts();

  /// Load a single product by source id, or null if not found.
  Future<Product?> getProduct(String sourceId);
}
