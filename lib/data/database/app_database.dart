import 'package:drift/drift.dart';

import 'app_database_storage_io.dart' if (dart.library.html) 'app_database_storage_web.dart' as storage;

part 'app_database.g.dart';

@DataClassName('ProductRow')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get localId => text()();
  TextColumn get sourceId => text()();
  TextColumn get sourcePlatformId => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get imageUrls => text()(); // JSON array as string
  TextColumn get variantsJson => text()(); // JSON array
  RealColumn get basePrice => real()();
  RealColumn get shippingCost => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('PLN'))();
  TextColumn get supplierId => text().nullable()();
  TextColumn get supplierCountry => text().nullable()();
  IntColumn get estimatedDays => integer().nullable()();
  TextColumn get rawJson => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('ListingRow')
class Listings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get localId => text()();
  TextColumn get productId => text()();
  TextColumn get targetPlatformId => text()();
  TextColumn get targetListingId => text().nullable()();
  TextColumn get status => text()();
  RealColumn get sellingPrice => real()();
  RealColumn get sourceCost => real()();
  TextColumn get decisionLogId => text().nullable()();
  TextColumn get marketplaceAccountId => text().nullable()();
  IntColumn get promisedMinDays => integer().nullable()();
  IntColumn get promisedMaxDays => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
}

@DataClassName('OrderRow')
class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get localId => text()();
  TextColumn get listingId => text()();
  TextColumn get targetOrderId => text()();
  TextColumn get targetPlatformId => text()();
  TextColumn get customerAddressJson => text()();
  TextColumn get status => text()();
  TextColumn get sourceOrderId => text().nullable()();
  RealColumn get sourceCost => real()();
  RealColumn get sellingPrice => real()();
  TextColumn get trackingNumber => text().nullable()();
  TextColumn get decisionLogId => text().nullable()();
  TextColumn get marketplaceAccountId => text().nullable()();
  DateTimeColumn get promisedDeliveryMin => dateTime().nullable()();
  DateTimeColumn get promisedDeliveryMax => dateTime().nullable()();
  DateTimeColumn get approvedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('DecisionLogRow')
class DecisionLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get localId => text()();
  TextColumn get type => text()();
  TextColumn get entityId => text()();
  TextColumn get reason => text()();
  TextColumn get criteriaSnapshot => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('UserRulesRow')
class UserRulesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get minProfitPercent => real()();
  RealColumn get maxSourcePrice => real().nullable()();
  TextColumn get preferredSupplierCountries => text()();
  BoolColumn get manualApprovalListings => boolean()();
  BoolColumn get manualApprovalOrders => boolean()();
  IntColumn get scanIntervalMinutes => integer()();
  TextColumn get blacklistedProductIds => text()();
  TextColumn get blacklistedSupplierIds => text()();
  RealColumn get defaultMarkupPercent => real()();
  TextColumn get searchKeywords => text()();
}

@DataClassName('SupplierRow')
class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get supplierId => text()();
  TextColumn get name => text()();
  TextColumn get platformType => text()();
  TextColumn get countryCode => text().nullable()();
  RealColumn get rating => real().nullable()();
  IntColumn get returnWindowDays => integer().nullable()();
  RealColumn get returnShippingCost => real().nullable()();
  RealColumn get restockingFeePercent => real().nullable()();
  BoolColumn get acceptsNoReasonReturns => boolean().withDefault(const Constant(false))();
}

@DataClassName('SupplierOfferRow')
class SupplierOffers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get offerId => text()();
  TextColumn get productId => text()();
  TextColumn get supplierId => text()();
  TextColumn get sourcePlatformId => text()();
  RealColumn get cost => real()();
  RealColumn get shippingCost => real().nullable()();
  IntColumn get minEstimatedDays => integer().nullable()();
  IntColumn get maxEstimatedDays => integer().nullable()();
  TextColumn get carrierCode => text().nullable()();
  TextColumn get shippingMethodName => text().nullable()();
  DateTimeColumn get lastPriceRefreshAt => dateTime().nullable()();
  DateTimeColumn get lastStockRefreshAt => dateTime().nullable()();
}

@DataClassName('ReturnRow')
class Returns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get returnId => text()();
  TextColumn get orderId => text()();
  TextColumn get reason => text()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  RealColumn get refundAmount => real().nullable()();
  RealColumn get returnShippingCost => real().nullable()();
  RealColumn get restockingFee => real().nullable()();
  DateTimeColumn get requestedAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
}

@DataClassName('MarketplaceAccountRow')
class MarketplaceAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get accountId => text()();
  TextColumn get platformId => text()();
  TextColumn get displayName => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get connectedAt => dateTime().nullable()();
}

@DriftDatabase(tables: [
  Products,
  Listings,
  Orders,
  DecisionLogs,
  UserRulesTable,
  Suppliers,
  SupplierOffers,
  MarketplaceAccounts,
  Returns,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(storage.openAppDatabaseConnection());

  @override
  int get schemaVersion => 3;
}
