import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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

@DriftDatabase(tables: [
  Products,
  Listings,
  Orders,
  DecisionLogs,
  UserRulesTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'jurassic_dropshipping.db'));
    return NativeDatabase.createInBackground(file);
  });
}
