# Warehouse / depot feeds (product origin)

You can source products **directly from wholesaler/warehouse/depot** (product origin) instead of or in addition to middlemen (CJ, API2Cart). Feeds may be **API, CSV, or XML** and **differ per warehouse**; the app supports configurable mapping so the same pipeline works for different schemas.

## Middleman vs product origin

| | Middleman (CJ, API2Cart) | Product origin (warehouse/depot) |
|---|--------------------------|----------------------------------|
| **Role** | Agent between you and supplier; they hold stock and fulfill. | Direct catalog/stock from wholesaler; you may fulfill via their API or another channel. |
| **Data** | API (fixed per platform). | API, CSV, or XML – **format and column/tag names differ per warehouse**. |
| **In the app** | [SourcePlatform](lib/domain/platforms.dart) implementations (CJ, API2Cart). | [ProductFeed](lib/domain/product_feed.dart) (CSV/XML) wrapped as [WarehouseFeedSourcePlatform](lib/services/feeds/warehouse_feed_source_platform.dart). |
| **Fulfillment** | placeOrder via middleman API. | Feed is **catalog-only** by default; add a warehouse order API integration when needed. |

The app keeps **middleman integrations** (CJ, API2Cart) and adds **methods to connect warehouse feeds** with flexible mapping.

## Feed types and mapping

- **CSV:** [CsvProductFeed](lib/services/feeds/csv_product_feed.dart) – delimiter (comma/semicolon/tab), optional header row, [FeedFieldMapping](lib/domain/product_feed.dart) from CSV column names to standard fields (`sourceId`, `title`, `basePrice`, `stock`, `imageUrl`, etc.).
- **XML:** [XmlProductFeed](lib/services/feeds/xml_product_feed.dart) – repeated element (e.g. `<product>`), child tags or attributes mapped via [FeedFieldMapping] to the same standard fields.
- **API:** A future warehouse API adapter would implement [ProductFeed] (or wrap an HTTP client) and map the API response to [Product]; same mapping idea for differing APIs.

Standard fields (see [FeedFields](lib/domain/product_feed.dart)): `sourceId`, `title`, `description`, `basePrice`, `stock`, `imageUrl`, `currency`, `supplierId`, and optionally `variantId`, `variantPrice`, `variantStock` for multi-variant rows.

## Example: CSV feed

Warehouse sends a CSV with columns e.g. `SKU`, `Product Name`, `Price`, `Qty`, `Image URL`. Map them and create a source:

```dart
final mapping = FeedFieldMapping(
  sourceId: 'SKU',
  title: 'Product Name',
  basePrice: 'Price',
  stock: 'Qty',
  imageUrl: 'Image URL',
);
final feed = CsvProductFeed(
  id: 'warehouse_alpha',
  displayName: 'Warehouse Alpha',
  sourcePlatformId: 'warehouse_alpha',
  mapping: mapping,
  csvContent: fileContent, // or await http.get(url).then((r) => r.body),
  delimiter: ',',
  hasHeaderRow: true,
);
final source = WarehouseFeedSourcePlatform(feed: feed);
// Add source to your sources list (e.g. in app_providers or a feed registry).
```

## Example: XML feed

Warehouse sends XML with e.g. `<catalog><product><Name>...</Name><Price>...</Price></product></catalog>`:

```dart
final mapping = FeedFieldMapping(
  sourceId: 'Id',
  title: 'Name',
  basePrice: 'Price',
  stock: 'Stock',
);
final feed = XmlProductFeed(
  id: 'depot_beta',
  displayName: 'Depot Beta',
  sourcePlatformId: 'depot_beta',
  mapping: mapping,
  xmlContent: xmlString,
  itemTag: 'product',
  rootTag: 'catalog',
);
final source = WarehouseFeedSourcePlatform(feed: feed);
```

## Registering feed sources

- **Scanner / sync:** They use the list of [SourcePlatform] (see [sourcesListProvider](lib/app_providers.dart)). To use warehouse feeds, add your [WarehouseFeedSourcePlatform] instances to that list (e.g. from a config file, DB table, or env that defines feed type + path/URL + mapping).
- **Catalog-only:** Feed-based sources do not implement `placeOrder`; they throw. Use them for **scan and listing creation**; fulfillment for those products can be handled by another source (e.g. same warehouse via a separate order API) or manually until you add the warehouse order integration.

## Adding a new warehouse API

When a warehouse exposes an HTTP API (REST, etc.) with a different schema:

1. Implement [ProductFeed]: `getProducts()` and `getProduct(sourceId)` returning [Product].
2. Map the API response (JSON/XML) to [Product] using your own field mapping (each API will differ).
3. Wrap in [WarehouseFeedSourcePlatform] and add to your sources list.
4. If the warehouse supports order placement, implement [SourcePlatform] directly (with `placeOrder`) or extend the feed with an order client used by a custom source.

## Files

- [lib/domain/product_feed.dart](lib/domain/product_feed.dart) – ProductFeed interface, FeedFieldMapping, FeedFields.
- [lib/services/feeds/csv_product_feed.dart](lib/services/feeds/csv_product_feed.dart) – CSV parsing and mapping.
- [lib/services/feeds/xml_product_feed.dart](lib/services/feeds/xml_product_feed.dart) – XML parsing and mapping.
- [lib/services/feeds/warehouse_feed_source_platform.dart](lib/services/feeds/warehouse_feed_source_platform.dart) – Feed as SourcePlatform (catalog-only).
