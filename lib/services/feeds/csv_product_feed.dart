import 'dart:convert';

import 'package:jurassic_dropshipping/data/models/product.dart';
import 'package:jurassic_dropshipping/domain/product_feed.dart';

/// Product feed from a CSV file (e.g. warehouse/depot export). Column names may differ per warehouse;
/// use [FeedFieldMapping] to map headers to standard fields.
class CsvProductFeed implements ProductFeed {
  CsvProductFeed({
    required this.id,
    required this.displayName,
    required this.sourcePlatformId,
    required this.mapping,
    required this.csvContent,
    this.delimiter = ',',
    this.hasHeaderRow = true,
    this.encoding = utf8,
  });

  @override
  final String id;
  @override
  final String displayName;
  /// Used as [Product.sourcePlatformId] for all products from this feed.
  final String sourcePlatformId;
  final FeedFieldMapping mapping;
  /// Raw CSV string (file content or downloaded body).
  final String csvContent;
  /// Column delimiter (e.g. ',', ';', '\t').
  final String delimiter;
  final bool hasHeaderRow;
  final Encoding encoding;

  List<Product>? _cached;
  void invalidateCache() => _cached = null;

  @override
  Future<List<Product>> getProducts() async {
    if (_cached != null) return _cached!;
    final rows = _parseRows();
    if (rows.isEmpty) return [];
    final headers = hasHeaderRow ? rows.first : null;
    final dataRows = hasHeaderRow ? rows.skip(1).toList() : rows;
    final columnIndex = _columnIndex(headers, dataRows);
    final products = <Product>[];
    for (var i = 0; i < dataRows.length; i++) {
      final product = _rowToProduct(dataRows[i], columnIndex, i);
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

  List<List<String>> _parseRows() {
    final lines = LineSplitter.split(csvContent).toList();
    final rows = <List<String>>[];
    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      rows.add(_splitCsvLine(line));
    }
    return rows;
  }

  List<String> _splitCsvLine(String line) {
    final result = <String>[];
    var current = StringBuffer();
    var inQuotes = false;
    for (var i = 0; i < line.length; i++) {
      final c = line[i];
      if (c == '"') {
        inQuotes = !inQuotes;
      } else if (inQuotes) {
        current.write(c);
      } else if (delimiter.length == 1 && c == delimiter[0]) {
        result.add(current.toString().trim());
        current = StringBuffer();
      } else {
        current.write(c);
      }
    }
    result.add(current.toString().trim());
    return result;
  }

  Map<String, int> _columnIndex(List<String>? headers, List<List<String>> dataRows) {
    final map = <String, String>{};
    if (mapping.sourceId != null) map[mapping.sourceId!] = FeedFields.sourceId;
    if (mapping.title != null) map[mapping.title!] = FeedFields.title;
    if (mapping.description != null) map[mapping.description!] = FeedFields.description;
    if (mapping.basePrice != null) map[mapping.basePrice!] = FeedFields.basePrice;
    if (mapping.stock != null) map[mapping.stock!] = FeedFields.stock;
    if (mapping.imageUrl != null) map[mapping.imageUrl!] = FeedFields.imageUrl;
    if (mapping.currency != null) map[mapping.currency!] = FeedFields.currency;
    if (mapping.supplierId != null) map[mapping.supplierId!] = FeedFields.supplierId;
    if (mapping.variantId != null) map[mapping.variantId!] = FeedFields.variantId;
    if (mapping.variantPrice != null) map[mapping.variantPrice!] = FeedFields.variantPrice;
    if (mapping.variantStock != null) map[mapping.variantStock!] = FeedFields.variantStock;

    List<String> headerNames;
    if (headers != null && headers.isNotEmpty) {
      headerNames = headers;
    } else if (dataRows.isNotEmpty) {
      headerNames = List.generate(dataRows.first.length, (i) => 'col_$i');
    } else {
      return {};
    }

    final columnIndex = <String, int>{};
    for (var i = 0; i < headerNames.length; i++) {
      final header = headerNames[i].trim();
      final standardField = map[header];
      if (standardField != null) columnIndex[standardField] = i;
    }
    return columnIndex;
  }

  Product? _rowToProduct(List<String> row, Map<String, int> columnIndex, int rowIndex) {
    final get = (String field) {
      final i = columnIndex[field];
      if (i == null || i >= row.length) return null;
      final v = row[i].trim();
      return v.isEmpty ? null : v;
    };
    final sourceId = get(FeedFields.sourceId);
    if (sourceId == null) return null;
    final title = get(FeedFields.title) ?? 'Product $rowIndex';
    final price = double.tryParse(get(FeedFields.basePrice) ?? '') ?? 0.0;
    final stock = int.tryParse(get(FeedFields.stock) ?? '') ?? 0;
    final variantId = get(FeedFields.variantId);
    final variantPrice = double.tryParse(get(FeedFields.variantPrice) ?? '');
    final variantStock = int.tryParse(get(FeedFields.variantStock) ?? '');
    final variant = (variantId != null || variantPrice != null || variantStock != null)
        ? ProductVariant(
            id: variantId ?? sourceId,
            productId: sourceId,
            attributes: {},
            price: variantPrice ?? price,
            stock: variantStock ?? stock,
          )
        : ProductVariant(
            id: sourceId,
            productId: sourceId,
            attributes: {},
            price: price,
            stock: stock,
          );
    final imageUrl = get(FeedFields.imageUrl);
    return Product(
      id: sourceId,
      sourceId: sourceId,
      sourcePlatformId: sourcePlatformId,
      title: title,
      description: get(FeedFields.description),
      imageUrls: imageUrl != null ? [imageUrl] : [],
      variants: [variant],
      basePrice: price,
      currency: get(FeedFields.currency) ?? 'PLN',
      supplierId: get(FeedFields.supplierId),
    );
  }
}
