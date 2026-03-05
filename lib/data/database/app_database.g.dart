// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourcePlatformIdMeta = const VerificationMeta(
    'sourcePlatformId',
  );
  @override
  late final GeneratedColumn<String> sourcePlatformId = GeneratedColumn<String>(
    'source_platform_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlsMeta = const VerificationMeta(
    'imageUrls',
  );
  @override
  late final GeneratedColumn<String> imageUrls = GeneratedColumn<String>(
    'image_urls',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantsJsonMeta = const VerificationMeta(
    'variantsJson',
  );
  @override
  late final GeneratedColumn<String> variantsJson = GeneratedColumn<String>(
    'variants_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _basePriceMeta = const VerificationMeta(
    'basePrice',
  );
  @override
  late final GeneratedColumn<double> basePrice = GeneratedColumn<double>(
    'base_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shippingCostMeta = const VerificationMeta(
    'shippingCost',
  );
  @override
  late final GeneratedColumn<double> shippingCost = GeneratedColumn<double>(
    'shipping_cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PLN'),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplierCountryMeta = const VerificationMeta(
    'supplierCountry',
  );
  @override
  late final GeneratedColumn<String> supplierCountry = GeneratedColumn<String>(
    'supplier_country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedDaysMeta = const VerificationMeta(
    'estimatedDays',
  );
  @override
  late final GeneratedColumn<int> estimatedDays = GeneratedColumn<int>(
    'estimated_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawJsonMeta = const VerificationMeta(
    'rawJson',
  );
  @override
  late final GeneratedColumn<String> rawJson = GeneratedColumn<String>(
    'raw_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localId,
    sourceId,
    sourcePlatformId,
    title,
    description,
    imageUrls,
    variantsJson,
    basePrice,
    shippingCost,
    currency,
    supplierId,
    supplierCountry,
    estimatedDays,
    rawJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('source_platform_id')) {
      context.handle(
        _sourcePlatformIdMeta,
        sourcePlatformId.isAcceptableOrUnknown(
          data['source_platform_id']!,
          _sourcePlatformIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourcePlatformIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('image_urls')) {
      context.handle(
        _imageUrlsMeta,
        imageUrls.isAcceptableOrUnknown(data['image_urls']!, _imageUrlsMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlsMeta);
    }
    if (data.containsKey('variants_json')) {
      context.handle(
        _variantsJsonMeta,
        variantsJson.isAcceptableOrUnknown(
          data['variants_json']!,
          _variantsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_variantsJsonMeta);
    }
    if (data.containsKey('base_price')) {
      context.handle(
        _basePriceMeta,
        basePrice.isAcceptableOrUnknown(data['base_price']!, _basePriceMeta),
      );
    } else if (isInserting) {
      context.missing(_basePriceMeta);
    }
    if (data.containsKey('shipping_cost')) {
      context.handle(
        _shippingCostMeta,
        shippingCost.isAcceptableOrUnknown(
          data['shipping_cost']!,
          _shippingCostMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    }
    if (data.containsKey('supplier_country')) {
      context.handle(
        _supplierCountryMeta,
        supplierCountry.isAcceptableOrUnknown(
          data['supplier_country']!,
          _supplierCountryMeta,
        ),
      );
    }
    if (data.containsKey('estimated_days')) {
      context.handle(
        _estimatedDaysMeta,
        estimatedDays.isAcceptableOrUnknown(
          data['estimated_days']!,
          _estimatedDaysMeta,
        ),
      );
    }
    if (data.containsKey('raw_json')) {
      context.handle(
        _rawJsonMeta,
        rawJson.isAcceptableOrUnknown(data['raw_json']!, _rawJsonMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      sourcePlatformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_platform_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      imageUrls: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_urls'],
      )!,
      variantsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variants_json'],
      )!,
      basePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}base_price'],
      )!,
      shippingCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shipping_cost'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      ),
      supplierCountry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_country'],
      ),
      estimatedDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_days'],
      ),
      rawJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_json'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  final int id;
  final String localId;
  final String sourceId;
  final String sourcePlatformId;
  final String title;
  final String? description;
  final String imageUrls;
  final String variantsJson;
  final double basePrice;
  final double? shippingCost;
  final String currency;
  final String? supplierId;
  final String? supplierCountry;
  final int? estimatedDays;
  final String? rawJson;
  final DateTime updatedAt;
  const ProductRow({
    required this.id,
    required this.localId,
    required this.sourceId,
    required this.sourcePlatformId,
    required this.title,
    this.description,
    required this.imageUrls,
    required this.variantsJson,
    required this.basePrice,
    this.shippingCost,
    required this.currency,
    this.supplierId,
    this.supplierCountry,
    this.estimatedDays,
    this.rawJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_id'] = Variable<String>(localId);
    map['source_id'] = Variable<String>(sourceId);
    map['source_platform_id'] = Variable<String>(sourcePlatformId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['image_urls'] = Variable<String>(imageUrls);
    map['variants_json'] = Variable<String>(variantsJson);
    map['base_price'] = Variable<double>(basePrice);
    if (!nullToAbsent || shippingCost != null) {
      map['shipping_cost'] = Variable<double>(shippingCost);
    }
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    if (!nullToAbsent || supplierCountry != null) {
      map['supplier_country'] = Variable<String>(supplierCountry);
    }
    if (!nullToAbsent || estimatedDays != null) {
      map['estimated_days'] = Variable<int>(estimatedDays);
    }
    if (!nullToAbsent || rawJson != null) {
      map['raw_json'] = Variable<String>(rawJson);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      localId: Value(localId),
      sourceId: Value(sourceId),
      sourcePlatformId: Value(sourcePlatformId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageUrls: Value(imageUrls),
      variantsJson: Value(variantsJson),
      basePrice: Value(basePrice),
      shippingCost: shippingCost == null && nullToAbsent
          ? const Value.absent()
          : Value(shippingCost),
      currency: Value(currency),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      supplierCountry: supplierCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierCountry),
      estimatedDays: estimatedDays == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedDays),
      rawJson: rawJson == null && nullToAbsent
          ? const Value.absent()
          : Value(rawJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      id: serializer.fromJson<int>(json['id']),
      localId: serializer.fromJson<String>(json['localId']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      sourcePlatformId: serializer.fromJson<String>(json['sourcePlatformId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      imageUrls: serializer.fromJson<String>(json['imageUrls']),
      variantsJson: serializer.fromJson<String>(json['variantsJson']),
      basePrice: serializer.fromJson<double>(json['basePrice']),
      shippingCost: serializer.fromJson<double?>(json['shippingCost']),
      currency: serializer.fromJson<String>(json['currency']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      supplierCountry: serializer.fromJson<String?>(json['supplierCountry']),
      estimatedDays: serializer.fromJson<int?>(json['estimatedDays']),
      rawJson: serializer.fromJson<String?>(json['rawJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localId': serializer.toJson<String>(localId),
      'sourceId': serializer.toJson<String>(sourceId),
      'sourcePlatformId': serializer.toJson<String>(sourcePlatformId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'imageUrls': serializer.toJson<String>(imageUrls),
      'variantsJson': serializer.toJson<String>(variantsJson),
      'basePrice': serializer.toJson<double>(basePrice),
      'shippingCost': serializer.toJson<double?>(shippingCost),
      'currency': serializer.toJson<String>(currency),
      'supplierId': serializer.toJson<String?>(supplierId),
      'supplierCountry': serializer.toJson<String?>(supplierCountry),
      'estimatedDays': serializer.toJson<int?>(estimatedDays),
      'rawJson': serializer.toJson<String?>(rawJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductRow copyWith({
    int? id,
    String? localId,
    String? sourceId,
    String? sourcePlatformId,
    String? title,
    Value<String?> description = const Value.absent(),
    String? imageUrls,
    String? variantsJson,
    double? basePrice,
    Value<double?> shippingCost = const Value.absent(),
    String? currency,
    Value<String?> supplierId = const Value.absent(),
    Value<String?> supplierCountry = const Value.absent(),
    Value<int?> estimatedDays = const Value.absent(),
    Value<String?> rawJson = const Value.absent(),
    DateTime? updatedAt,
  }) => ProductRow(
    id: id ?? this.id,
    localId: localId ?? this.localId,
    sourceId: sourceId ?? this.sourceId,
    sourcePlatformId: sourcePlatformId ?? this.sourcePlatformId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    imageUrls: imageUrls ?? this.imageUrls,
    variantsJson: variantsJson ?? this.variantsJson,
    basePrice: basePrice ?? this.basePrice,
    shippingCost: shippingCost.present ? shippingCost.value : this.shippingCost,
    currency: currency ?? this.currency,
    supplierId: supplierId.present ? supplierId.value : this.supplierId,
    supplierCountry: supplierCountry.present
        ? supplierCountry.value
        : this.supplierCountry,
    estimatedDays: estimatedDays.present
        ? estimatedDays.value
        : this.estimatedDays,
    rawJson: rawJson.present ? rawJson.value : this.rawJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProductRow copyWithCompanion(ProductsCompanion data) {
    return ProductRow(
      id: data.id.present ? data.id.value : this.id,
      localId: data.localId.present ? data.localId.value : this.localId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      sourcePlatformId: data.sourcePlatformId.present
          ? data.sourcePlatformId.value
          : this.sourcePlatformId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageUrls: data.imageUrls.present ? data.imageUrls.value : this.imageUrls,
      variantsJson: data.variantsJson.present
          ? data.variantsJson.value
          : this.variantsJson,
      basePrice: data.basePrice.present ? data.basePrice.value : this.basePrice,
      shippingCost: data.shippingCost.present
          ? data.shippingCost.value
          : this.shippingCost,
      currency: data.currency.present ? data.currency.value : this.currency,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      supplierCountry: data.supplierCountry.present
          ? data.supplierCountry.value
          : this.supplierCountry,
      estimatedDays: data.estimatedDays.present
          ? data.estimatedDays.value
          : this.estimatedDays,
      rawJson: data.rawJson.present ? data.rawJson.value : this.rawJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('sourceId: $sourceId, ')
          ..write('sourcePlatformId: $sourcePlatformId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('variantsJson: $variantsJson, ')
          ..write('basePrice: $basePrice, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('currency: $currency, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierCountry: $supplierCountry, ')
          ..write('estimatedDays: $estimatedDays, ')
          ..write('rawJson: $rawJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localId,
    sourceId,
    sourcePlatformId,
    title,
    description,
    imageUrls,
    variantsJson,
    basePrice,
    shippingCost,
    currency,
    supplierId,
    supplierCountry,
    estimatedDays,
    rawJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.sourceId == this.sourceId &&
          other.sourcePlatformId == this.sourcePlatformId &&
          other.title == this.title &&
          other.description == this.description &&
          other.imageUrls == this.imageUrls &&
          other.variantsJson == this.variantsJson &&
          other.basePrice == this.basePrice &&
          other.shippingCost == this.shippingCost &&
          other.currency == this.currency &&
          other.supplierId == this.supplierId &&
          other.supplierCountry == this.supplierCountry &&
          other.estimatedDays == this.estimatedDays &&
          other.rawJson == this.rawJson &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<ProductRow> {
  final Value<int> id;
  final Value<String> localId;
  final Value<String> sourceId;
  final Value<String> sourcePlatformId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> imageUrls;
  final Value<String> variantsJson;
  final Value<double> basePrice;
  final Value<double?> shippingCost;
  final Value<String> currency;
  final Value<String?> supplierId;
  final Value<String?> supplierCountry;
  final Value<int?> estimatedDays;
  final Value<String?> rawJson;
  final Value<DateTime> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.sourcePlatformId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrls = const Value.absent(),
    this.variantsJson = const Value.absent(),
    this.basePrice = const Value.absent(),
    this.shippingCost = const Value.absent(),
    this.currency = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.supplierCountry = const Value.absent(),
    this.estimatedDays = const Value.absent(),
    this.rawJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String localId,
    required String sourceId,
    required String sourcePlatformId,
    required String title,
    this.description = const Value.absent(),
    required String imageUrls,
    required String variantsJson,
    required double basePrice,
    this.shippingCost = const Value.absent(),
    this.currency = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.supplierCountry = const Value.absent(),
    this.estimatedDays = const Value.absent(),
    this.rawJson = const Value.absent(),
    required DateTime updatedAt,
  }) : localId = Value(localId),
       sourceId = Value(sourceId),
       sourcePlatformId = Value(sourcePlatformId),
       title = Value(title),
       imageUrls = Value(imageUrls),
       variantsJson = Value(variantsJson),
       basePrice = Value(basePrice),
       updatedAt = Value(updatedAt);
  static Insertable<ProductRow> custom({
    Expression<int>? id,
    Expression<String>? localId,
    Expression<String>? sourceId,
    Expression<String>? sourcePlatformId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? imageUrls,
    Expression<String>? variantsJson,
    Expression<double>? basePrice,
    Expression<double>? shippingCost,
    Expression<String>? currency,
    Expression<String>? supplierId,
    Expression<String>? supplierCountry,
    Expression<int>? estimatedDays,
    Expression<String>? rawJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (sourceId != null) 'source_id': sourceId,
      if (sourcePlatformId != null) 'source_platform_id': sourcePlatformId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (imageUrls != null) 'image_urls': imageUrls,
      if (variantsJson != null) 'variants_json': variantsJson,
      if (basePrice != null) 'base_price': basePrice,
      if (shippingCost != null) 'shipping_cost': shippingCost,
      if (currency != null) 'currency': currency,
      if (supplierId != null) 'supplier_id': supplierId,
      if (supplierCountry != null) 'supplier_country': supplierCountry,
      if (estimatedDays != null) 'estimated_days': estimatedDays,
      if (rawJson != null) 'raw_json': rawJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? localId,
    Value<String>? sourceId,
    Value<String>? sourcePlatformId,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? imageUrls,
    Value<String>? variantsJson,
    Value<double>? basePrice,
    Value<double?>? shippingCost,
    Value<String>? currency,
    Value<String?>? supplierId,
    Value<String?>? supplierCountry,
    Value<int?>? estimatedDays,
    Value<String?>? rawJson,
    Value<DateTime>? updatedAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      sourceId: sourceId ?? this.sourceId,
      sourcePlatformId: sourcePlatformId ?? this.sourcePlatformId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      variantsJson: variantsJson ?? this.variantsJson,
      basePrice: basePrice ?? this.basePrice,
      shippingCost: shippingCost ?? this.shippingCost,
      currency: currency ?? this.currency,
      supplierId: supplierId ?? this.supplierId,
      supplierCountry: supplierCountry ?? this.supplierCountry,
      estimatedDays: estimatedDays ?? this.estimatedDays,
      rawJson: rawJson ?? this.rawJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (sourcePlatformId.present) {
      map['source_platform_id'] = Variable<String>(sourcePlatformId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrls.present) {
      map['image_urls'] = Variable<String>(imageUrls.value);
    }
    if (variantsJson.present) {
      map['variants_json'] = Variable<String>(variantsJson.value);
    }
    if (basePrice.present) {
      map['base_price'] = Variable<double>(basePrice.value);
    }
    if (shippingCost.present) {
      map['shipping_cost'] = Variable<double>(shippingCost.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (supplierCountry.present) {
      map['supplier_country'] = Variable<String>(supplierCountry.value);
    }
    if (estimatedDays.present) {
      map['estimated_days'] = Variable<int>(estimatedDays.value);
    }
    if (rawJson.present) {
      map['raw_json'] = Variable<String>(rawJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('sourceId: $sourceId, ')
          ..write('sourcePlatformId: $sourcePlatformId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('variantsJson: $variantsJson, ')
          ..write('basePrice: $basePrice, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('currency: $currency, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierCountry: $supplierCountry, ')
          ..write('estimatedDays: $estimatedDays, ')
          ..write('rawJson: $rawJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ListingsTable extends Listings
    with TableInfo<$ListingsTable, ListingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetPlatformIdMeta = const VerificationMeta(
    'targetPlatformId',
  );
  @override
  late final GeneratedColumn<String> targetPlatformId = GeneratedColumn<String>(
    'target_platform_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetListingIdMeta = const VerificationMeta(
    'targetListingId',
  );
  @override
  late final GeneratedColumn<String> targetListingId = GeneratedColumn<String>(
    'target_listing_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceCostMeta = const VerificationMeta(
    'sourceCost',
  );
  @override
  late final GeneratedColumn<double> sourceCost = GeneratedColumn<double>(
    'source_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decisionLogIdMeta = const VerificationMeta(
    'decisionLogId',
  );
  @override
  late final GeneratedColumn<String> decisionLogId = GeneratedColumn<String>(
    'decision_log_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localId,
    productId,
    targetPlatformId,
    targetListingId,
    status,
    sellingPrice,
    sourceCost,
    decisionLogId,
    createdAt,
    publishedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'listings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ListingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('target_platform_id')) {
      context.handle(
        _targetPlatformIdMeta,
        targetPlatformId.isAcceptableOrUnknown(
          data['target_platform_id']!,
          _targetPlatformIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetPlatformIdMeta);
    }
    if (data.containsKey('target_listing_id')) {
      context.handle(
        _targetListingIdMeta,
        targetListingId.isAcceptableOrUnknown(
          data['target_listing_id']!,
          _targetListingIdMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('source_cost')) {
      context.handle(
        _sourceCostMeta,
        sourceCost.isAcceptableOrUnknown(data['source_cost']!, _sourceCostMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceCostMeta);
    }
    if (data.containsKey('decision_log_id')) {
      context.handle(
        _decisionLogIdMeta,
        decisionLogId.isAcceptableOrUnknown(
          data['decision_log_id']!,
          _decisionLogIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ListingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      targetPlatformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_platform_id'],
      )!,
      targetListingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_listing_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      sourceCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}source_cost'],
      )!,
      decisionLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision_log_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
    );
  }

  @override
  $ListingsTable createAlias(String alias) {
    return $ListingsTable(attachedDatabase, alias);
  }
}

class ListingRow extends DataClass implements Insertable<ListingRow> {
  final int id;
  final String localId;
  final String productId;
  final String targetPlatformId;
  final String? targetListingId;
  final String status;
  final double sellingPrice;
  final double sourceCost;
  final String? decisionLogId;
  final DateTime createdAt;
  final DateTime? publishedAt;
  const ListingRow({
    required this.id,
    required this.localId,
    required this.productId,
    required this.targetPlatformId,
    this.targetListingId,
    required this.status,
    required this.sellingPrice,
    required this.sourceCost,
    this.decisionLogId,
    required this.createdAt,
    this.publishedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_id'] = Variable<String>(localId);
    map['product_id'] = Variable<String>(productId);
    map['target_platform_id'] = Variable<String>(targetPlatformId);
    if (!nullToAbsent || targetListingId != null) {
      map['target_listing_id'] = Variable<String>(targetListingId);
    }
    map['status'] = Variable<String>(status);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['source_cost'] = Variable<double>(sourceCost);
    if (!nullToAbsent || decisionLogId != null) {
      map['decision_log_id'] = Variable<String>(decisionLogId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    return map;
  }

  ListingsCompanion toCompanion(bool nullToAbsent) {
    return ListingsCompanion(
      id: Value(id),
      localId: Value(localId),
      productId: Value(productId),
      targetPlatformId: Value(targetPlatformId),
      targetListingId: targetListingId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetListingId),
      status: Value(status),
      sellingPrice: Value(sellingPrice),
      sourceCost: Value(sourceCost),
      decisionLogId: decisionLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(decisionLogId),
      createdAt: Value(createdAt),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
    );
  }

  factory ListingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListingRow(
      id: serializer.fromJson<int>(json['id']),
      localId: serializer.fromJson<String>(json['localId']),
      productId: serializer.fromJson<String>(json['productId']),
      targetPlatformId: serializer.fromJson<String>(json['targetPlatformId']),
      targetListingId: serializer.fromJson<String?>(json['targetListingId']),
      status: serializer.fromJson<String>(json['status']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      sourceCost: serializer.fromJson<double>(json['sourceCost']),
      decisionLogId: serializer.fromJson<String?>(json['decisionLogId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localId': serializer.toJson<String>(localId),
      'productId': serializer.toJson<String>(productId),
      'targetPlatformId': serializer.toJson<String>(targetPlatformId),
      'targetListingId': serializer.toJson<String?>(targetListingId),
      'status': serializer.toJson<String>(status),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'sourceCost': serializer.toJson<double>(sourceCost),
      'decisionLogId': serializer.toJson<String?>(decisionLogId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
    };
  }

  ListingRow copyWith({
    int? id,
    String? localId,
    String? productId,
    String? targetPlatformId,
    Value<String?> targetListingId = const Value.absent(),
    String? status,
    double? sellingPrice,
    double? sourceCost,
    Value<String?> decisionLogId = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> publishedAt = const Value.absent(),
  }) => ListingRow(
    id: id ?? this.id,
    localId: localId ?? this.localId,
    productId: productId ?? this.productId,
    targetPlatformId: targetPlatformId ?? this.targetPlatformId,
    targetListingId: targetListingId.present
        ? targetListingId.value
        : this.targetListingId,
    status: status ?? this.status,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    sourceCost: sourceCost ?? this.sourceCost,
    decisionLogId: decisionLogId.present
        ? decisionLogId.value
        : this.decisionLogId,
    createdAt: createdAt ?? this.createdAt,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
  );
  ListingRow copyWithCompanion(ListingsCompanion data) {
    return ListingRow(
      id: data.id.present ? data.id.value : this.id,
      localId: data.localId.present ? data.localId.value : this.localId,
      productId: data.productId.present ? data.productId.value : this.productId,
      targetPlatformId: data.targetPlatformId.present
          ? data.targetPlatformId.value
          : this.targetPlatformId,
      targetListingId: data.targetListingId.present
          ? data.targetListingId.value
          : this.targetListingId,
      status: data.status.present ? data.status.value : this.status,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      sourceCost: data.sourceCost.present
          ? data.sourceCost.value
          : this.sourceCost,
      decisionLogId: data.decisionLogId.present
          ? data.decisionLogId.value
          : this.decisionLogId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ListingRow(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('productId: $productId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('targetListingId: $targetListingId, ')
          ..write('status: $status, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('sourceCost: $sourceCost, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('createdAt: $createdAt, ')
          ..write('publishedAt: $publishedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localId,
    productId,
    targetPlatformId,
    targetListingId,
    status,
    sellingPrice,
    sourceCost,
    decisionLogId,
    createdAt,
    publishedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListingRow &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.productId == this.productId &&
          other.targetPlatformId == this.targetPlatformId &&
          other.targetListingId == this.targetListingId &&
          other.status == this.status &&
          other.sellingPrice == this.sellingPrice &&
          other.sourceCost == this.sourceCost &&
          other.decisionLogId == this.decisionLogId &&
          other.createdAt == this.createdAt &&
          other.publishedAt == this.publishedAt);
}

class ListingsCompanion extends UpdateCompanion<ListingRow> {
  final Value<int> id;
  final Value<String> localId;
  final Value<String> productId;
  final Value<String> targetPlatformId;
  final Value<String?> targetListingId;
  final Value<String> status;
  final Value<double> sellingPrice;
  final Value<double> sourceCost;
  final Value<String?> decisionLogId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> publishedAt;
  const ListingsCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.productId = const Value.absent(),
    this.targetPlatformId = const Value.absent(),
    this.targetListingId = const Value.absent(),
    this.status = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.sourceCost = const Value.absent(),
    this.decisionLogId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.publishedAt = const Value.absent(),
  });
  ListingsCompanion.insert({
    this.id = const Value.absent(),
    required String localId,
    required String productId,
    required String targetPlatformId,
    this.targetListingId = const Value.absent(),
    required String status,
    required double sellingPrice,
    required double sourceCost,
    this.decisionLogId = const Value.absent(),
    required DateTime createdAt,
    this.publishedAt = const Value.absent(),
  }) : localId = Value(localId),
       productId = Value(productId),
       targetPlatformId = Value(targetPlatformId),
       status = Value(status),
       sellingPrice = Value(sellingPrice),
       sourceCost = Value(sourceCost),
       createdAt = Value(createdAt);
  static Insertable<ListingRow> custom({
    Expression<int>? id,
    Expression<String>? localId,
    Expression<String>? productId,
    Expression<String>? targetPlatformId,
    Expression<String>? targetListingId,
    Expression<String>? status,
    Expression<double>? sellingPrice,
    Expression<double>? sourceCost,
    Expression<String>? decisionLogId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? publishedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (productId != null) 'product_id': productId,
      if (targetPlatformId != null) 'target_platform_id': targetPlatformId,
      if (targetListingId != null) 'target_listing_id': targetListingId,
      if (status != null) 'status': status,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (sourceCost != null) 'source_cost': sourceCost,
      if (decisionLogId != null) 'decision_log_id': decisionLogId,
      if (createdAt != null) 'created_at': createdAt,
      if (publishedAt != null) 'published_at': publishedAt,
    });
  }

  ListingsCompanion copyWith({
    Value<int>? id,
    Value<String>? localId,
    Value<String>? productId,
    Value<String>? targetPlatformId,
    Value<String?>? targetListingId,
    Value<String>? status,
    Value<double>? sellingPrice,
    Value<double>? sourceCost,
    Value<String?>? decisionLogId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? publishedAt,
  }) {
    return ListingsCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      productId: productId ?? this.productId,
      targetPlatformId: targetPlatformId ?? this.targetPlatformId,
      targetListingId: targetListingId ?? this.targetListingId,
      status: status ?? this.status,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      sourceCost: sourceCost ?? this.sourceCost,
      decisionLogId: decisionLogId ?? this.decisionLogId,
      createdAt: createdAt ?? this.createdAt,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (targetPlatformId.present) {
      map['target_platform_id'] = Variable<String>(targetPlatformId.value);
    }
    if (targetListingId.present) {
      map['target_listing_id'] = Variable<String>(targetListingId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (sourceCost.present) {
      map['source_cost'] = Variable<double>(sourceCost.value);
    }
    if (decisionLogId.present) {
      map['decision_log_id'] = Variable<String>(decisionLogId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListingsCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('productId: $productId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('targetListingId: $targetListingId, ')
          ..write('status: $status, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('sourceCost: $sourceCost, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('createdAt: $createdAt, ')
          ..write('publishedAt: $publishedAt')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, OrderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _listingIdMeta = const VerificationMeta(
    'listingId',
  );
  @override
  late final GeneratedColumn<String> listingId = GeneratedColumn<String>(
    'listing_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetOrderIdMeta = const VerificationMeta(
    'targetOrderId',
  );
  @override
  late final GeneratedColumn<String> targetOrderId = GeneratedColumn<String>(
    'target_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetPlatformIdMeta = const VerificationMeta(
    'targetPlatformId',
  );
  @override
  late final GeneratedColumn<String> targetPlatformId = GeneratedColumn<String>(
    'target_platform_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerAddressJsonMeta =
      const VerificationMeta('customerAddressJson');
  @override
  late final GeneratedColumn<String> customerAddressJson =
      GeneratedColumn<String>(
        'customer_address_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceOrderIdMeta = const VerificationMeta(
    'sourceOrderId',
  );
  @override
  late final GeneratedColumn<String> sourceOrderId = GeneratedColumn<String>(
    'source_order_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceCostMeta = const VerificationMeta(
    'sourceCost',
  );
  @override
  late final GeneratedColumn<double> sourceCost = GeneratedColumn<double>(
    'source_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackingNumberMeta = const VerificationMeta(
    'trackingNumber',
  );
  @override
  late final GeneratedColumn<String> trackingNumber = GeneratedColumn<String>(
    'tracking_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _decisionLogIdMeta = const VerificationMeta(
    'decisionLogId',
  );
  @override
  late final GeneratedColumn<String> decisionLogId = GeneratedColumn<String>(
    'decision_log_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _approvedAtMeta = const VerificationMeta(
    'approvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> approvedAt = GeneratedColumn<DateTime>(
    'approved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localId,
    listingId,
    targetOrderId,
    targetPlatformId,
    customerAddressJson,
    status,
    sourceOrderId,
    sourceCost,
    sellingPrice,
    trackingNumber,
    decisionLogId,
    approvedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('listing_id')) {
      context.handle(
        _listingIdMeta,
        listingId.isAcceptableOrUnknown(data['listing_id']!, _listingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listingIdMeta);
    }
    if (data.containsKey('target_order_id')) {
      context.handle(
        _targetOrderIdMeta,
        targetOrderId.isAcceptableOrUnknown(
          data['target_order_id']!,
          _targetOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetOrderIdMeta);
    }
    if (data.containsKey('target_platform_id')) {
      context.handle(
        _targetPlatformIdMeta,
        targetPlatformId.isAcceptableOrUnknown(
          data['target_platform_id']!,
          _targetPlatformIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetPlatformIdMeta);
    }
    if (data.containsKey('customer_address_json')) {
      context.handle(
        _customerAddressJsonMeta,
        customerAddressJson.isAcceptableOrUnknown(
          data['customer_address_json']!,
          _customerAddressJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerAddressJsonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('source_order_id')) {
      context.handle(
        _sourceOrderIdMeta,
        sourceOrderId.isAcceptableOrUnknown(
          data['source_order_id']!,
          _sourceOrderIdMeta,
        ),
      );
    }
    if (data.containsKey('source_cost')) {
      context.handle(
        _sourceCostMeta,
        sourceCost.isAcceptableOrUnknown(data['source_cost']!, _sourceCostMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceCostMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('tracking_number')) {
      context.handle(
        _trackingNumberMeta,
        trackingNumber.isAcceptableOrUnknown(
          data['tracking_number']!,
          _trackingNumberMeta,
        ),
      );
    }
    if (data.containsKey('decision_log_id')) {
      context.handle(
        _decisionLogIdMeta,
        decisionLogId.isAcceptableOrUnknown(
          data['decision_log_id']!,
          _decisionLogIdMeta,
        ),
      );
    }
    if (data.containsKey('approved_at')) {
      context.handle(
        _approvedAtMeta,
        approvedAt.isAcceptableOrUnknown(data['approved_at']!, _approvedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      listingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listing_id'],
      )!,
      targetOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_order_id'],
      )!,
      targetPlatformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_platform_id'],
      )!,
      customerAddressJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_address_json'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      sourceOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_order_id'],
      ),
      sourceCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}source_cost'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      trackingNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tracking_number'],
      ),
      decisionLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision_log_id'],
      ),
      approvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}approved_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class OrderRow extends DataClass implements Insertable<OrderRow> {
  final int id;
  final String localId;
  final String listingId;
  final String targetOrderId;
  final String targetPlatformId;
  final String customerAddressJson;
  final String status;
  final String? sourceOrderId;
  final double sourceCost;
  final double sellingPrice;
  final String? trackingNumber;
  final String? decisionLogId;
  final DateTime? approvedAt;
  final DateTime createdAt;
  const OrderRow({
    required this.id,
    required this.localId,
    required this.listingId,
    required this.targetOrderId,
    required this.targetPlatformId,
    required this.customerAddressJson,
    required this.status,
    this.sourceOrderId,
    required this.sourceCost,
    required this.sellingPrice,
    this.trackingNumber,
    this.decisionLogId,
    this.approvedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_id'] = Variable<String>(localId);
    map['listing_id'] = Variable<String>(listingId);
    map['target_order_id'] = Variable<String>(targetOrderId);
    map['target_platform_id'] = Variable<String>(targetPlatformId);
    map['customer_address_json'] = Variable<String>(customerAddressJson);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || sourceOrderId != null) {
      map['source_order_id'] = Variable<String>(sourceOrderId);
    }
    map['source_cost'] = Variable<double>(sourceCost);
    map['selling_price'] = Variable<double>(sellingPrice);
    if (!nullToAbsent || trackingNumber != null) {
      map['tracking_number'] = Variable<String>(trackingNumber);
    }
    if (!nullToAbsent || decisionLogId != null) {
      map['decision_log_id'] = Variable<String>(decisionLogId);
    }
    if (!nullToAbsent || approvedAt != null) {
      map['approved_at'] = Variable<DateTime>(approvedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      localId: Value(localId),
      listingId: Value(listingId),
      targetOrderId: Value(targetOrderId),
      targetPlatformId: Value(targetPlatformId),
      customerAddressJson: Value(customerAddressJson),
      status: Value(status),
      sourceOrderId: sourceOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceOrderId),
      sourceCost: Value(sourceCost),
      sellingPrice: Value(sellingPrice),
      trackingNumber: trackingNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackingNumber),
      decisionLogId: decisionLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(decisionLogId),
      approvedAt: approvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedAt),
      createdAt: Value(createdAt),
    );
  }

  factory OrderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderRow(
      id: serializer.fromJson<int>(json['id']),
      localId: serializer.fromJson<String>(json['localId']),
      listingId: serializer.fromJson<String>(json['listingId']),
      targetOrderId: serializer.fromJson<String>(json['targetOrderId']),
      targetPlatformId: serializer.fromJson<String>(json['targetPlatformId']),
      customerAddressJson: serializer.fromJson<String>(
        json['customerAddressJson'],
      ),
      status: serializer.fromJson<String>(json['status']),
      sourceOrderId: serializer.fromJson<String?>(json['sourceOrderId']),
      sourceCost: serializer.fromJson<double>(json['sourceCost']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      trackingNumber: serializer.fromJson<String?>(json['trackingNumber']),
      decisionLogId: serializer.fromJson<String?>(json['decisionLogId']),
      approvedAt: serializer.fromJson<DateTime?>(json['approvedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localId': serializer.toJson<String>(localId),
      'listingId': serializer.toJson<String>(listingId),
      'targetOrderId': serializer.toJson<String>(targetOrderId),
      'targetPlatformId': serializer.toJson<String>(targetPlatformId),
      'customerAddressJson': serializer.toJson<String>(customerAddressJson),
      'status': serializer.toJson<String>(status),
      'sourceOrderId': serializer.toJson<String?>(sourceOrderId),
      'sourceCost': serializer.toJson<double>(sourceCost),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'trackingNumber': serializer.toJson<String?>(trackingNumber),
      'decisionLogId': serializer.toJson<String?>(decisionLogId),
      'approvedAt': serializer.toJson<DateTime?>(approvedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OrderRow copyWith({
    int? id,
    String? localId,
    String? listingId,
    String? targetOrderId,
    String? targetPlatformId,
    String? customerAddressJson,
    String? status,
    Value<String?> sourceOrderId = const Value.absent(),
    double? sourceCost,
    double? sellingPrice,
    Value<String?> trackingNumber = const Value.absent(),
    Value<String?> decisionLogId = const Value.absent(),
    Value<DateTime?> approvedAt = const Value.absent(),
    DateTime? createdAt,
  }) => OrderRow(
    id: id ?? this.id,
    localId: localId ?? this.localId,
    listingId: listingId ?? this.listingId,
    targetOrderId: targetOrderId ?? this.targetOrderId,
    targetPlatformId: targetPlatformId ?? this.targetPlatformId,
    customerAddressJson: customerAddressJson ?? this.customerAddressJson,
    status: status ?? this.status,
    sourceOrderId: sourceOrderId.present
        ? sourceOrderId.value
        : this.sourceOrderId,
    sourceCost: sourceCost ?? this.sourceCost,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    trackingNumber: trackingNumber.present
        ? trackingNumber.value
        : this.trackingNumber,
    decisionLogId: decisionLogId.present
        ? decisionLogId.value
        : this.decisionLogId,
    approvedAt: approvedAt.present ? approvedAt.value : this.approvedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  OrderRow copyWithCompanion(OrdersCompanion data) {
    return OrderRow(
      id: data.id.present ? data.id.value : this.id,
      localId: data.localId.present ? data.localId.value : this.localId,
      listingId: data.listingId.present ? data.listingId.value : this.listingId,
      targetOrderId: data.targetOrderId.present
          ? data.targetOrderId.value
          : this.targetOrderId,
      targetPlatformId: data.targetPlatformId.present
          ? data.targetPlatformId.value
          : this.targetPlatformId,
      customerAddressJson: data.customerAddressJson.present
          ? data.customerAddressJson.value
          : this.customerAddressJson,
      status: data.status.present ? data.status.value : this.status,
      sourceOrderId: data.sourceOrderId.present
          ? data.sourceOrderId.value
          : this.sourceOrderId,
      sourceCost: data.sourceCost.present
          ? data.sourceCost.value
          : this.sourceCost,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      trackingNumber: data.trackingNumber.present
          ? data.trackingNumber.value
          : this.trackingNumber,
      decisionLogId: data.decisionLogId.present
          ? data.decisionLogId.value
          : this.decisionLogId,
      approvedAt: data.approvedAt.present
          ? data.approvedAt.value
          : this.approvedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderRow(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('listingId: $listingId, ')
          ..write('targetOrderId: $targetOrderId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('customerAddressJson: $customerAddressJson, ')
          ..write('status: $status, ')
          ..write('sourceOrderId: $sourceOrderId, ')
          ..write('sourceCost: $sourceCost, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localId,
    listingId,
    targetOrderId,
    targetPlatformId,
    customerAddressJson,
    status,
    sourceOrderId,
    sourceCost,
    sellingPrice,
    trackingNumber,
    decisionLogId,
    approvedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderRow &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.listingId == this.listingId &&
          other.targetOrderId == this.targetOrderId &&
          other.targetPlatformId == this.targetPlatformId &&
          other.customerAddressJson == this.customerAddressJson &&
          other.status == this.status &&
          other.sourceOrderId == this.sourceOrderId &&
          other.sourceCost == this.sourceCost &&
          other.sellingPrice == this.sellingPrice &&
          other.trackingNumber == this.trackingNumber &&
          other.decisionLogId == this.decisionLogId &&
          other.approvedAt == this.approvedAt &&
          other.createdAt == this.createdAt);
}

class OrdersCompanion extends UpdateCompanion<OrderRow> {
  final Value<int> id;
  final Value<String> localId;
  final Value<String> listingId;
  final Value<String> targetOrderId;
  final Value<String> targetPlatformId;
  final Value<String> customerAddressJson;
  final Value<String> status;
  final Value<String?> sourceOrderId;
  final Value<double> sourceCost;
  final Value<double> sellingPrice;
  final Value<String?> trackingNumber;
  final Value<String?> decisionLogId;
  final Value<DateTime?> approvedAt;
  final Value<DateTime> createdAt;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.listingId = const Value.absent(),
    this.targetOrderId = const Value.absent(),
    this.targetPlatformId = const Value.absent(),
    this.customerAddressJson = const Value.absent(),
    this.status = const Value.absent(),
    this.sourceOrderId = const Value.absent(),
    this.sourceCost = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.decisionLogId = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required String localId,
    required String listingId,
    required String targetOrderId,
    required String targetPlatformId,
    required String customerAddressJson,
    required String status,
    this.sourceOrderId = const Value.absent(),
    required double sourceCost,
    required double sellingPrice,
    this.trackingNumber = const Value.absent(),
    this.decisionLogId = const Value.absent(),
    this.approvedAt = const Value.absent(),
    required DateTime createdAt,
  }) : localId = Value(localId),
       listingId = Value(listingId),
       targetOrderId = Value(targetOrderId),
       targetPlatformId = Value(targetPlatformId),
       customerAddressJson = Value(customerAddressJson),
       status = Value(status),
       sourceCost = Value(sourceCost),
       sellingPrice = Value(sellingPrice),
       createdAt = Value(createdAt);
  static Insertable<OrderRow> custom({
    Expression<int>? id,
    Expression<String>? localId,
    Expression<String>? listingId,
    Expression<String>? targetOrderId,
    Expression<String>? targetPlatformId,
    Expression<String>? customerAddressJson,
    Expression<String>? status,
    Expression<String>? sourceOrderId,
    Expression<double>? sourceCost,
    Expression<double>? sellingPrice,
    Expression<String>? trackingNumber,
    Expression<String>? decisionLogId,
    Expression<DateTime>? approvedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (listingId != null) 'listing_id': listingId,
      if (targetOrderId != null) 'target_order_id': targetOrderId,
      if (targetPlatformId != null) 'target_platform_id': targetPlatformId,
      if (customerAddressJson != null)
        'customer_address_json': customerAddressJson,
      if (status != null) 'status': status,
      if (sourceOrderId != null) 'source_order_id': sourceOrderId,
      if (sourceCost != null) 'source_cost': sourceCost,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (trackingNumber != null) 'tracking_number': trackingNumber,
      if (decisionLogId != null) 'decision_log_id': decisionLogId,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<String>? localId,
    Value<String>? listingId,
    Value<String>? targetOrderId,
    Value<String>? targetPlatformId,
    Value<String>? customerAddressJson,
    Value<String>? status,
    Value<String?>? sourceOrderId,
    Value<double>? sourceCost,
    Value<double>? sellingPrice,
    Value<String?>? trackingNumber,
    Value<String?>? decisionLogId,
    Value<DateTime?>? approvedAt,
    Value<DateTime>? createdAt,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      listingId: listingId ?? this.listingId,
      targetOrderId: targetOrderId ?? this.targetOrderId,
      targetPlatformId: targetPlatformId ?? this.targetPlatformId,
      customerAddressJson: customerAddressJson ?? this.customerAddressJson,
      status: status ?? this.status,
      sourceOrderId: sourceOrderId ?? this.sourceOrderId,
      sourceCost: sourceCost ?? this.sourceCost,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      decisionLogId: decisionLogId ?? this.decisionLogId,
      approvedAt: approvedAt ?? this.approvedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (listingId.present) {
      map['listing_id'] = Variable<String>(listingId.value);
    }
    if (targetOrderId.present) {
      map['target_order_id'] = Variable<String>(targetOrderId.value);
    }
    if (targetPlatformId.present) {
      map['target_platform_id'] = Variable<String>(targetPlatformId.value);
    }
    if (customerAddressJson.present) {
      map['customer_address_json'] = Variable<String>(
        customerAddressJson.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (sourceOrderId.present) {
      map['source_order_id'] = Variable<String>(sourceOrderId.value);
    }
    if (sourceCost.present) {
      map['source_cost'] = Variable<double>(sourceCost.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (trackingNumber.present) {
      map['tracking_number'] = Variable<String>(trackingNumber.value);
    }
    if (decisionLogId.present) {
      map['decision_log_id'] = Variable<String>(decisionLogId.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('listingId: $listingId, ')
          ..write('targetOrderId: $targetOrderId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('customerAddressJson: $customerAddressJson, ')
          ..write('status: $status, ')
          ..write('sourceOrderId: $sourceOrderId, ')
          ..write('sourceCost: $sourceCost, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DecisionLogsTable extends DecisionLogs
    with TableInfo<$DecisionLogsTable, DecisionLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecisionLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _criteriaSnapshotMeta = const VerificationMeta(
    'criteriaSnapshot',
  );
  @override
  late final GeneratedColumn<String> criteriaSnapshot = GeneratedColumn<String>(
    'criteria_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localId,
    type,
    entityId,
    reason,
    criteriaSnapshot,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decision_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DecisionLogRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('criteria_snapshot')) {
      context.handle(
        _criteriaSnapshotMeta,
        criteriaSnapshot.isAcceptableOrUnknown(
          data['criteria_snapshot']!,
          _criteriaSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DecisionLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DecisionLogRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      criteriaSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}criteria_snapshot'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DecisionLogsTable createAlias(String alias) {
    return $DecisionLogsTable(attachedDatabase, alias);
  }
}

class DecisionLogRow extends DataClass implements Insertable<DecisionLogRow> {
  final int id;
  final String localId;
  final String type;
  final String entityId;
  final String reason;
  final String? criteriaSnapshot;
  final DateTime createdAt;
  const DecisionLogRow({
    required this.id,
    required this.localId,
    required this.type,
    required this.entityId,
    required this.reason,
    this.criteriaSnapshot,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_id'] = Variable<String>(localId);
    map['type'] = Variable<String>(type);
    map['entity_id'] = Variable<String>(entityId);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || criteriaSnapshot != null) {
      map['criteria_snapshot'] = Variable<String>(criteriaSnapshot);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DecisionLogsCompanion toCompanion(bool nullToAbsent) {
    return DecisionLogsCompanion(
      id: Value(id),
      localId: Value(localId),
      type: Value(type),
      entityId: Value(entityId),
      reason: Value(reason),
      criteriaSnapshot: criteriaSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(criteriaSnapshot),
      createdAt: Value(createdAt),
    );
  }

  factory DecisionLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DecisionLogRow(
      id: serializer.fromJson<int>(json['id']),
      localId: serializer.fromJson<String>(json['localId']),
      type: serializer.fromJson<String>(json['type']),
      entityId: serializer.fromJson<String>(json['entityId']),
      reason: serializer.fromJson<String>(json['reason']),
      criteriaSnapshot: serializer.fromJson<String?>(json['criteriaSnapshot']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localId': serializer.toJson<String>(localId),
      'type': serializer.toJson<String>(type),
      'entityId': serializer.toJson<String>(entityId),
      'reason': serializer.toJson<String>(reason),
      'criteriaSnapshot': serializer.toJson<String?>(criteriaSnapshot),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DecisionLogRow copyWith({
    int? id,
    String? localId,
    String? type,
    String? entityId,
    String? reason,
    Value<String?> criteriaSnapshot = const Value.absent(),
    DateTime? createdAt,
  }) => DecisionLogRow(
    id: id ?? this.id,
    localId: localId ?? this.localId,
    type: type ?? this.type,
    entityId: entityId ?? this.entityId,
    reason: reason ?? this.reason,
    criteriaSnapshot: criteriaSnapshot.present
        ? criteriaSnapshot.value
        : this.criteriaSnapshot,
    createdAt: createdAt ?? this.createdAt,
  );
  DecisionLogRow copyWithCompanion(DecisionLogsCompanion data) {
    return DecisionLogRow(
      id: data.id.present ? data.id.value : this.id,
      localId: data.localId.present ? data.localId.value : this.localId,
      type: data.type.present ? data.type.value : this.type,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      reason: data.reason.present ? data.reason.value : this.reason,
      criteriaSnapshot: data.criteriaSnapshot.present
          ? data.criteriaSnapshot.value
          : this.criteriaSnapshot,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DecisionLogRow(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('type: $type, ')
          ..write('entityId: $entityId, ')
          ..write('reason: $reason, ')
          ..write('criteriaSnapshot: $criteriaSnapshot, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localId,
    type,
    entityId,
    reason,
    criteriaSnapshot,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DecisionLogRow &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.type == this.type &&
          other.entityId == this.entityId &&
          other.reason == this.reason &&
          other.criteriaSnapshot == this.criteriaSnapshot &&
          other.createdAt == this.createdAt);
}

class DecisionLogsCompanion extends UpdateCompanion<DecisionLogRow> {
  final Value<int> id;
  final Value<String> localId;
  final Value<String> type;
  final Value<String> entityId;
  final Value<String> reason;
  final Value<String?> criteriaSnapshot;
  final Value<DateTime> createdAt;
  const DecisionLogsCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.type = const Value.absent(),
    this.entityId = const Value.absent(),
    this.reason = const Value.absent(),
    this.criteriaSnapshot = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DecisionLogsCompanion.insert({
    this.id = const Value.absent(),
    required String localId,
    required String type,
    required String entityId,
    required String reason,
    this.criteriaSnapshot = const Value.absent(),
    required DateTime createdAt,
  }) : localId = Value(localId),
       type = Value(type),
       entityId = Value(entityId),
       reason = Value(reason),
       createdAt = Value(createdAt);
  static Insertable<DecisionLogRow> custom({
    Expression<int>? id,
    Expression<String>? localId,
    Expression<String>? type,
    Expression<String>? entityId,
    Expression<String>? reason,
    Expression<String>? criteriaSnapshot,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (type != null) 'type': type,
      if (entityId != null) 'entity_id': entityId,
      if (reason != null) 'reason': reason,
      if (criteriaSnapshot != null) 'criteria_snapshot': criteriaSnapshot,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DecisionLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? localId,
    Value<String>? type,
    Value<String>? entityId,
    Value<String>? reason,
    Value<String?>? criteriaSnapshot,
    Value<DateTime>? createdAt,
  }) {
    return DecisionLogsCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      type: type ?? this.type,
      entityId: entityId ?? this.entityId,
      reason: reason ?? this.reason,
      criteriaSnapshot: criteriaSnapshot ?? this.criteriaSnapshot,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (criteriaSnapshot.present) {
      map['criteria_snapshot'] = Variable<String>(criteriaSnapshot.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecisionLogsCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('type: $type, ')
          ..write('entityId: $entityId, ')
          ..write('reason: $reason, ')
          ..write('criteriaSnapshot: $criteriaSnapshot, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserRulesTableTable extends UserRulesTable
    with TableInfo<$UserRulesTableTable, UserRulesRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _minProfitPercentMeta = const VerificationMeta(
    'minProfitPercent',
  );
  @override
  late final GeneratedColumn<double> minProfitPercent = GeneratedColumn<double>(
    'min_profit_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxSourcePriceMeta = const VerificationMeta(
    'maxSourcePrice',
  );
  @override
  late final GeneratedColumn<double> maxSourcePrice = GeneratedColumn<double>(
    'max_source_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredSupplierCountriesMeta =
      const VerificationMeta('preferredSupplierCountries');
  @override
  late final GeneratedColumn<String> preferredSupplierCountries =
      GeneratedColumn<String>(
        'preferred_supplier_countries',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _manualApprovalListingsMeta =
      const VerificationMeta('manualApprovalListings');
  @override
  late final GeneratedColumn<bool> manualApprovalListings =
      GeneratedColumn<bool>(
        'manual_approval_listings',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("manual_approval_listings" IN (0, 1))',
        ),
      );
  static const VerificationMeta _manualApprovalOrdersMeta =
      const VerificationMeta('manualApprovalOrders');
  @override
  late final GeneratedColumn<bool> manualApprovalOrders = GeneratedColumn<bool>(
    'manual_approval_orders',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("manual_approval_orders" IN (0, 1))',
    ),
  );
  static const VerificationMeta _scanIntervalMinutesMeta =
      const VerificationMeta('scanIntervalMinutes');
  @override
  late final GeneratedColumn<int> scanIntervalMinutes = GeneratedColumn<int>(
    'scan_interval_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _blacklistedProductIdsMeta =
      const VerificationMeta('blacklistedProductIds');
  @override
  late final GeneratedColumn<String> blacklistedProductIds =
      GeneratedColumn<String>(
        'blacklisted_product_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _blacklistedSupplierIdsMeta =
      const VerificationMeta('blacklistedSupplierIds');
  @override
  late final GeneratedColumn<String> blacklistedSupplierIds =
      GeneratedColumn<String>(
        'blacklisted_supplier_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _defaultMarkupPercentMeta =
      const VerificationMeta('defaultMarkupPercent');
  @override
  late final GeneratedColumn<double> defaultMarkupPercent =
      GeneratedColumn<double>(
        'default_markup_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _searchKeywordsMeta = const VerificationMeta(
    'searchKeywords',
  );
  @override
  late final GeneratedColumn<String> searchKeywords = GeneratedColumn<String>(
    'search_keywords',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    minProfitPercent,
    maxSourcePrice,
    preferredSupplierCountries,
    manualApprovalListings,
    manualApprovalOrders,
    scanIntervalMinutes,
    blacklistedProductIds,
    blacklistedSupplierIds,
    defaultMarkupPercent,
    searchKeywords,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_rules_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRulesRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('min_profit_percent')) {
      context.handle(
        _minProfitPercentMeta,
        minProfitPercent.isAcceptableOrUnknown(
          data['min_profit_percent']!,
          _minProfitPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_minProfitPercentMeta);
    }
    if (data.containsKey('max_source_price')) {
      context.handle(
        _maxSourcePriceMeta,
        maxSourcePrice.isAcceptableOrUnknown(
          data['max_source_price']!,
          _maxSourcePriceMeta,
        ),
      );
    }
    if (data.containsKey('preferred_supplier_countries')) {
      context.handle(
        _preferredSupplierCountriesMeta,
        preferredSupplierCountries.isAcceptableOrUnknown(
          data['preferred_supplier_countries']!,
          _preferredSupplierCountriesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferredSupplierCountriesMeta);
    }
    if (data.containsKey('manual_approval_listings')) {
      context.handle(
        _manualApprovalListingsMeta,
        manualApprovalListings.isAcceptableOrUnknown(
          data['manual_approval_listings']!,
          _manualApprovalListingsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_manualApprovalListingsMeta);
    }
    if (data.containsKey('manual_approval_orders')) {
      context.handle(
        _manualApprovalOrdersMeta,
        manualApprovalOrders.isAcceptableOrUnknown(
          data['manual_approval_orders']!,
          _manualApprovalOrdersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_manualApprovalOrdersMeta);
    }
    if (data.containsKey('scan_interval_minutes')) {
      context.handle(
        _scanIntervalMinutesMeta,
        scanIntervalMinutes.isAcceptableOrUnknown(
          data['scan_interval_minutes']!,
          _scanIntervalMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scanIntervalMinutesMeta);
    }
    if (data.containsKey('blacklisted_product_ids')) {
      context.handle(
        _blacklistedProductIdsMeta,
        blacklistedProductIds.isAcceptableOrUnknown(
          data['blacklisted_product_ids']!,
          _blacklistedProductIdsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_blacklistedProductIdsMeta);
    }
    if (data.containsKey('blacklisted_supplier_ids')) {
      context.handle(
        _blacklistedSupplierIdsMeta,
        blacklistedSupplierIds.isAcceptableOrUnknown(
          data['blacklisted_supplier_ids']!,
          _blacklistedSupplierIdsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_blacklistedSupplierIdsMeta);
    }
    if (data.containsKey('default_markup_percent')) {
      context.handle(
        _defaultMarkupPercentMeta,
        defaultMarkupPercent.isAcceptableOrUnknown(
          data['default_markup_percent']!,
          _defaultMarkupPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultMarkupPercentMeta);
    }
    if (data.containsKey('search_keywords')) {
      context.handle(
        _searchKeywordsMeta,
        searchKeywords.isAcceptableOrUnknown(
          data['search_keywords']!,
          _searchKeywordsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_searchKeywordsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRulesRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRulesRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      minProfitPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}min_profit_percent'],
      )!,
      maxSourcePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_source_price'],
      ),
      preferredSupplierCountries: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_supplier_countries'],
      )!,
      manualApprovalListings: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}manual_approval_listings'],
      )!,
      manualApprovalOrders: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}manual_approval_orders'],
      )!,
      scanIntervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scan_interval_minutes'],
      )!,
      blacklistedProductIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blacklisted_product_ids'],
      )!,
      blacklistedSupplierIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blacklisted_supplier_ids'],
      )!,
      defaultMarkupPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_markup_percent'],
      )!,
      searchKeywords: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_keywords'],
      )!,
    );
  }

  @override
  $UserRulesTableTable createAlias(String alias) {
    return $UserRulesTableTable(attachedDatabase, alias);
  }
}

class UserRulesRow extends DataClass implements Insertable<UserRulesRow> {
  final int id;
  final double minProfitPercent;
  final double? maxSourcePrice;
  final String preferredSupplierCountries;
  final bool manualApprovalListings;
  final bool manualApprovalOrders;
  final int scanIntervalMinutes;
  final String blacklistedProductIds;
  final String blacklistedSupplierIds;
  final double defaultMarkupPercent;
  final String searchKeywords;
  const UserRulesRow({
    required this.id,
    required this.minProfitPercent,
    this.maxSourcePrice,
    required this.preferredSupplierCountries,
    required this.manualApprovalListings,
    required this.manualApprovalOrders,
    required this.scanIntervalMinutes,
    required this.blacklistedProductIds,
    required this.blacklistedSupplierIds,
    required this.defaultMarkupPercent,
    required this.searchKeywords,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['min_profit_percent'] = Variable<double>(minProfitPercent);
    if (!nullToAbsent || maxSourcePrice != null) {
      map['max_source_price'] = Variable<double>(maxSourcePrice);
    }
    map['preferred_supplier_countries'] = Variable<String>(
      preferredSupplierCountries,
    );
    map['manual_approval_listings'] = Variable<bool>(manualApprovalListings);
    map['manual_approval_orders'] = Variable<bool>(manualApprovalOrders);
    map['scan_interval_minutes'] = Variable<int>(scanIntervalMinutes);
    map['blacklisted_product_ids'] = Variable<String>(blacklistedProductIds);
    map['blacklisted_supplier_ids'] = Variable<String>(blacklistedSupplierIds);
    map['default_markup_percent'] = Variable<double>(defaultMarkupPercent);
    map['search_keywords'] = Variable<String>(searchKeywords);
    return map;
  }

  UserRulesTableCompanion toCompanion(bool nullToAbsent) {
    return UserRulesTableCompanion(
      id: Value(id),
      minProfitPercent: Value(minProfitPercent),
      maxSourcePrice: maxSourcePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSourcePrice),
      preferredSupplierCountries: Value(preferredSupplierCountries),
      manualApprovalListings: Value(manualApprovalListings),
      manualApprovalOrders: Value(manualApprovalOrders),
      scanIntervalMinutes: Value(scanIntervalMinutes),
      blacklistedProductIds: Value(blacklistedProductIds),
      blacklistedSupplierIds: Value(blacklistedSupplierIds),
      defaultMarkupPercent: Value(defaultMarkupPercent),
      searchKeywords: Value(searchKeywords),
    );
  }

  factory UserRulesRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRulesRow(
      id: serializer.fromJson<int>(json['id']),
      minProfitPercent: serializer.fromJson<double>(json['minProfitPercent']),
      maxSourcePrice: serializer.fromJson<double?>(json['maxSourcePrice']),
      preferredSupplierCountries: serializer.fromJson<String>(
        json['preferredSupplierCountries'],
      ),
      manualApprovalListings: serializer.fromJson<bool>(
        json['manualApprovalListings'],
      ),
      manualApprovalOrders: serializer.fromJson<bool>(
        json['manualApprovalOrders'],
      ),
      scanIntervalMinutes: serializer.fromJson<int>(
        json['scanIntervalMinutes'],
      ),
      blacklistedProductIds: serializer.fromJson<String>(
        json['blacklistedProductIds'],
      ),
      blacklistedSupplierIds: serializer.fromJson<String>(
        json['blacklistedSupplierIds'],
      ),
      defaultMarkupPercent: serializer.fromJson<double>(
        json['defaultMarkupPercent'],
      ),
      searchKeywords: serializer.fromJson<String>(json['searchKeywords']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'minProfitPercent': serializer.toJson<double>(minProfitPercent),
      'maxSourcePrice': serializer.toJson<double?>(maxSourcePrice),
      'preferredSupplierCountries': serializer.toJson<String>(
        preferredSupplierCountries,
      ),
      'manualApprovalListings': serializer.toJson<bool>(manualApprovalListings),
      'manualApprovalOrders': serializer.toJson<bool>(manualApprovalOrders),
      'scanIntervalMinutes': serializer.toJson<int>(scanIntervalMinutes),
      'blacklistedProductIds': serializer.toJson<String>(blacklistedProductIds),
      'blacklistedSupplierIds': serializer.toJson<String>(
        blacklistedSupplierIds,
      ),
      'defaultMarkupPercent': serializer.toJson<double>(defaultMarkupPercent),
      'searchKeywords': serializer.toJson<String>(searchKeywords),
    };
  }

  UserRulesRow copyWith({
    int? id,
    double? minProfitPercent,
    Value<double?> maxSourcePrice = const Value.absent(),
    String? preferredSupplierCountries,
    bool? manualApprovalListings,
    bool? manualApprovalOrders,
    int? scanIntervalMinutes,
    String? blacklistedProductIds,
    String? blacklistedSupplierIds,
    double? defaultMarkupPercent,
    String? searchKeywords,
  }) => UserRulesRow(
    id: id ?? this.id,
    minProfitPercent: minProfitPercent ?? this.minProfitPercent,
    maxSourcePrice: maxSourcePrice.present
        ? maxSourcePrice.value
        : this.maxSourcePrice,
    preferredSupplierCountries:
        preferredSupplierCountries ?? this.preferredSupplierCountries,
    manualApprovalListings:
        manualApprovalListings ?? this.manualApprovalListings,
    manualApprovalOrders: manualApprovalOrders ?? this.manualApprovalOrders,
    scanIntervalMinutes: scanIntervalMinutes ?? this.scanIntervalMinutes,
    blacklistedProductIds: blacklistedProductIds ?? this.blacklistedProductIds,
    blacklistedSupplierIds:
        blacklistedSupplierIds ?? this.blacklistedSupplierIds,
    defaultMarkupPercent: defaultMarkupPercent ?? this.defaultMarkupPercent,
    searchKeywords: searchKeywords ?? this.searchKeywords,
  );
  UserRulesRow copyWithCompanion(UserRulesTableCompanion data) {
    return UserRulesRow(
      id: data.id.present ? data.id.value : this.id,
      minProfitPercent: data.minProfitPercent.present
          ? data.minProfitPercent.value
          : this.minProfitPercent,
      maxSourcePrice: data.maxSourcePrice.present
          ? data.maxSourcePrice.value
          : this.maxSourcePrice,
      preferredSupplierCountries: data.preferredSupplierCountries.present
          ? data.preferredSupplierCountries.value
          : this.preferredSupplierCountries,
      manualApprovalListings: data.manualApprovalListings.present
          ? data.manualApprovalListings.value
          : this.manualApprovalListings,
      manualApprovalOrders: data.manualApprovalOrders.present
          ? data.manualApprovalOrders.value
          : this.manualApprovalOrders,
      scanIntervalMinutes: data.scanIntervalMinutes.present
          ? data.scanIntervalMinutes.value
          : this.scanIntervalMinutes,
      blacklistedProductIds: data.blacklistedProductIds.present
          ? data.blacklistedProductIds.value
          : this.blacklistedProductIds,
      blacklistedSupplierIds: data.blacklistedSupplierIds.present
          ? data.blacklistedSupplierIds.value
          : this.blacklistedSupplierIds,
      defaultMarkupPercent: data.defaultMarkupPercent.present
          ? data.defaultMarkupPercent.value
          : this.defaultMarkupPercent,
      searchKeywords: data.searchKeywords.present
          ? data.searchKeywords.value
          : this.searchKeywords,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRulesRow(')
          ..write('id: $id, ')
          ..write('minProfitPercent: $minProfitPercent, ')
          ..write('maxSourcePrice: $maxSourcePrice, ')
          ..write('preferredSupplierCountries: $preferredSupplierCountries, ')
          ..write('manualApprovalListings: $manualApprovalListings, ')
          ..write('manualApprovalOrders: $manualApprovalOrders, ')
          ..write('scanIntervalMinutes: $scanIntervalMinutes, ')
          ..write('blacklistedProductIds: $blacklistedProductIds, ')
          ..write('blacklistedSupplierIds: $blacklistedSupplierIds, ')
          ..write('defaultMarkupPercent: $defaultMarkupPercent, ')
          ..write('searchKeywords: $searchKeywords')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    minProfitPercent,
    maxSourcePrice,
    preferredSupplierCountries,
    manualApprovalListings,
    manualApprovalOrders,
    scanIntervalMinutes,
    blacklistedProductIds,
    blacklistedSupplierIds,
    defaultMarkupPercent,
    searchKeywords,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRulesRow &&
          other.id == this.id &&
          other.minProfitPercent == this.minProfitPercent &&
          other.maxSourcePrice == this.maxSourcePrice &&
          other.preferredSupplierCountries == this.preferredSupplierCountries &&
          other.manualApprovalListings == this.manualApprovalListings &&
          other.manualApprovalOrders == this.manualApprovalOrders &&
          other.scanIntervalMinutes == this.scanIntervalMinutes &&
          other.blacklistedProductIds == this.blacklistedProductIds &&
          other.blacklistedSupplierIds == this.blacklistedSupplierIds &&
          other.defaultMarkupPercent == this.defaultMarkupPercent &&
          other.searchKeywords == this.searchKeywords);
}

class UserRulesTableCompanion extends UpdateCompanion<UserRulesRow> {
  final Value<int> id;
  final Value<double> minProfitPercent;
  final Value<double?> maxSourcePrice;
  final Value<String> preferredSupplierCountries;
  final Value<bool> manualApprovalListings;
  final Value<bool> manualApprovalOrders;
  final Value<int> scanIntervalMinutes;
  final Value<String> blacklistedProductIds;
  final Value<String> blacklistedSupplierIds;
  final Value<double> defaultMarkupPercent;
  final Value<String> searchKeywords;
  const UserRulesTableCompanion({
    this.id = const Value.absent(),
    this.minProfitPercent = const Value.absent(),
    this.maxSourcePrice = const Value.absent(),
    this.preferredSupplierCountries = const Value.absent(),
    this.manualApprovalListings = const Value.absent(),
    this.manualApprovalOrders = const Value.absent(),
    this.scanIntervalMinutes = const Value.absent(),
    this.blacklistedProductIds = const Value.absent(),
    this.blacklistedSupplierIds = const Value.absent(),
    this.defaultMarkupPercent = const Value.absent(),
    this.searchKeywords = const Value.absent(),
  });
  UserRulesTableCompanion.insert({
    this.id = const Value.absent(),
    required double minProfitPercent,
    this.maxSourcePrice = const Value.absent(),
    required String preferredSupplierCountries,
    required bool manualApprovalListings,
    required bool manualApprovalOrders,
    required int scanIntervalMinutes,
    required String blacklistedProductIds,
    required String blacklistedSupplierIds,
    required double defaultMarkupPercent,
    required String searchKeywords,
  }) : minProfitPercent = Value(minProfitPercent),
       preferredSupplierCountries = Value(preferredSupplierCountries),
       manualApprovalListings = Value(manualApprovalListings),
       manualApprovalOrders = Value(manualApprovalOrders),
       scanIntervalMinutes = Value(scanIntervalMinutes),
       blacklistedProductIds = Value(blacklistedProductIds),
       blacklistedSupplierIds = Value(blacklistedSupplierIds),
       defaultMarkupPercent = Value(defaultMarkupPercent),
       searchKeywords = Value(searchKeywords);
  static Insertable<UserRulesRow> custom({
    Expression<int>? id,
    Expression<double>? minProfitPercent,
    Expression<double>? maxSourcePrice,
    Expression<String>? preferredSupplierCountries,
    Expression<bool>? manualApprovalListings,
    Expression<bool>? manualApprovalOrders,
    Expression<int>? scanIntervalMinutes,
    Expression<String>? blacklistedProductIds,
    Expression<String>? blacklistedSupplierIds,
    Expression<double>? defaultMarkupPercent,
    Expression<String>? searchKeywords,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (minProfitPercent != null) 'min_profit_percent': minProfitPercent,
      if (maxSourcePrice != null) 'max_source_price': maxSourcePrice,
      if (preferredSupplierCountries != null)
        'preferred_supplier_countries': preferredSupplierCountries,
      if (manualApprovalListings != null)
        'manual_approval_listings': manualApprovalListings,
      if (manualApprovalOrders != null)
        'manual_approval_orders': manualApprovalOrders,
      if (scanIntervalMinutes != null)
        'scan_interval_minutes': scanIntervalMinutes,
      if (blacklistedProductIds != null)
        'blacklisted_product_ids': blacklistedProductIds,
      if (blacklistedSupplierIds != null)
        'blacklisted_supplier_ids': blacklistedSupplierIds,
      if (defaultMarkupPercent != null)
        'default_markup_percent': defaultMarkupPercent,
      if (searchKeywords != null) 'search_keywords': searchKeywords,
    });
  }

  UserRulesTableCompanion copyWith({
    Value<int>? id,
    Value<double>? minProfitPercent,
    Value<double?>? maxSourcePrice,
    Value<String>? preferredSupplierCountries,
    Value<bool>? manualApprovalListings,
    Value<bool>? manualApprovalOrders,
    Value<int>? scanIntervalMinutes,
    Value<String>? blacklistedProductIds,
    Value<String>? blacklistedSupplierIds,
    Value<double>? defaultMarkupPercent,
    Value<String>? searchKeywords,
  }) {
    return UserRulesTableCompanion(
      id: id ?? this.id,
      minProfitPercent: minProfitPercent ?? this.minProfitPercent,
      maxSourcePrice: maxSourcePrice ?? this.maxSourcePrice,
      preferredSupplierCountries:
          preferredSupplierCountries ?? this.preferredSupplierCountries,
      manualApprovalListings:
          manualApprovalListings ?? this.manualApprovalListings,
      manualApprovalOrders: manualApprovalOrders ?? this.manualApprovalOrders,
      scanIntervalMinutes: scanIntervalMinutes ?? this.scanIntervalMinutes,
      blacklistedProductIds:
          blacklistedProductIds ?? this.blacklistedProductIds,
      blacklistedSupplierIds:
          blacklistedSupplierIds ?? this.blacklistedSupplierIds,
      defaultMarkupPercent: defaultMarkupPercent ?? this.defaultMarkupPercent,
      searchKeywords: searchKeywords ?? this.searchKeywords,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (minProfitPercent.present) {
      map['min_profit_percent'] = Variable<double>(minProfitPercent.value);
    }
    if (maxSourcePrice.present) {
      map['max_source_price'] = Variable<double>(maxSourcePrice.value);
    }
    if (preferredSupplierCountries.present) {
      map['preferred_supplier_countries'] = Variable<String>(
        preferredSupplierCountries.value,
      );
    }
    if (manualApprovalListings.present) {
      map['manual_approval_listings'] = Variable<bool>(
        manualApprovalListings.value,
      );
    }
    if (manualApprovalOrders.present) {
      map['manual_approval_orders'] = Variable<bool>(
        manualApprovalOrders.value,
      );
    }
    if (scanIntervalMinutes.present) {
      map['scan_interval_minutes'] = Variable<int>(scanIntervalMinutes.value);
    }
    if (blacklistedProductIds.present) {
      map['blacklisted_product_ids'] = Variable<String>(
        blacklistedProductIds.value,
      );
    }
    if (blacklistedSupplierIds.present) {
      map['blacklisted_supplier_ids'] = Variable<String>(
        blacklistedSupplierIds.value,
      );
    }
    if (defaultMarkupPercent.present) {
      map['default_markup_percent'] = Variable<double>(
        defaultMarkupPercent.value,
      );
    }
    if (searchKeywords.present) {
      map['search_keywords'] = Variable<String>(searchKeywords.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRulesTableCompanion(')
          ..write('id: $id, ')
          ..write('minProfitPercent: $minProfitPercent, ')
          ..write('maxSourcePrice: $maxSourcePrice, ')
          ..write('preferredSupplierCountries: $preferredSupplierCountries, ')
          ..write('manualApprovalListings: $manualApprovalListings, ')
          ..write('manualApprovalOrders: $manualApprovalOrders, ')
          ..write('scanIntervalMinutes: $scanIntervalMinutes, ')
          ..write('blacklistedProductIds: $blacklistedProductIds, ')
          ..write('blacklistedSupplierIds: $blacklistedSupplierIds, ')
          ..write('defaultMarkupPercent: $defaultMarkupPercent, ')
          ..write('searchKeywords: $searchKeywords')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, SupplierRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformTypeMeta = const VerificationMeta(
    'platformType',
  );
  @override
  late final GeneratedColumn<String> platformType = GeneratedColumn<String>(
    'platform_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryCodeMeta = const VerificationMeta(
    'countryCode',
  );
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
    'country_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnWindowDaysMeta = const VerificationMeta(
    'returnWindowDays',
  );
  @override
  late final GeneratedColumn<int> returnWindowDays = GeneratedColumn<int>(
    'return_window_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnShippingCostMeta =
      const VerificationMeta('returnShippingCost');
  @override
  late final GeneratedColumn<double> returnShippingCost =
      GeneratedColumn<double>(
        'return_shipping_cost',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _restockingFeePercentMeta =
      const VerificationMeta('restockingFeePercent');
  @override
  late final GeneratedColumn<double> restockingFeePercent =
      GeneratedColumn<double>(
        'restocking_fee_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _acceptsNoReasonReturnsMeta =
      const VerificationMeta('acceptsNoReasonReturns');
  @override
  late final GeneratedColumn<bool> acceptsNoReasonReturns =
      GeneratedColumn<bool>(
        'accepts_no_reason_returns',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("accepts_no_reason_returns" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierId,
    name,
    platformType,
    countryCode,
    rating,
    returnWindowDays,
    returnShippingCost,
    restockingFeePercent,
    acceptsNoReasonReturns,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('platform_type')) {
      context.handle(
        _platformTypeMeta,
        platformType.isAcceptableOrUnknown(
          data['platform_type']!,
          _platformTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_platformTypeMeta);
    }
    if (data.containsKey('country_code')) {
      context.handle(
        _countryCodeMeta,
        countryCode.isAcceptableOrUnknown(
          data['country_code']!,
          _countryCodeMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('return_window_days')) {
      context.handle(
        _returnWindowDaysMeta,
        returnWindowDays.isAcceptableOrUnknown(
          data['return_window_days']!,
          _returnWindowDaysMeta,
        ),
      );
    }
    if (data.containsKey('return_shipping_cost')) {
      context.handle(
        _returnShippingCostMeta,
        returnShippingCost.isAcceptableOrUnknown(
          data['return_shipping_cost']!,
          _returnShippingCostMeta,
        ),
      );
    }
    if (data.containsKey('restocking_fee_percent')) {
      context.handle(
        _restockingFeePercentMeta,
        restockingFeePercent.isAcceptableOrUnknown(
          data['restocking_fee_percent']!,
          _restockingFeePercentMeta,
        ),
      );
    }
    if (data.containsKey('accepts_no_reason_returns')) {
      context.handle(
        _acceptsNoReasonReturnsMeta,
        acceptsNoReasonReturns.isAcceptableOrUnknown(
          data['accepts_no_reason_returns']!,
          _acceptsNoReasonReturnsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      platformType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform_type'],
      )!,
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      ),
      returnWindowDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}return_window_days'],
      ),
      returnShippingCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}return_shipping_cost'],
      ),
      restockingFeePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}restocking_fee_percent'],
      ),
      acceptsNoReasonReturns: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}accepts_no_reason_returns'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class SupplierRow extends DataClass implements Insertable<SupplierRow> {
  final int id;
  final String supplierId;
  final String name;
  final String platformType;
  final String? countryCode;
  final double? rating;
  final int? returnWindowDays;
  final double? returnShippingCost;
  final double? restockingFeePercent;
  final bool acceptsNoReasonReturns;
  const SupplierRow({
    required this.id,
    required this.supplierId,
    required this.name,
    required this.platformType,
    this.countryCode,
    this.rating,
    this.returnWindowDays,
    this.returnShippingCost,
    this.restockingFeePercent,
    required this.acceptsNoReasonReturns,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<String>(supplierId);
    map['name'] = Variable<String>(name);
    map['platform_type'] = Variable<String>(platformType);
    if (!nullToAbsent || countryCode != null) {
      map['country_code'] = Variable<String>(countryCode);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    if (!nullToAbsent || returnWindowDays != null) {
      map['return_window_days'] = Variable<int>(returnWindowDays);
    }
    if (!nullToAbsent || returnShippingCost != null) {
      map['return_shipping_cost'] = Variable<double>(returnShippingCost);
    }
    if (!nullToAbsent || restockingFeePercent != null) {
      map['restocking_fee_percent'] = Variable<double>(restockingFeePercent);
    }
    map['accepts_no_reason_returns'] = Variable<bool>(acceptsNoReasonReturns);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      name: Value(name),
      platformType: Value(platformType),
      countryCode: countryCode == null && nullToAbsent
          ? const Value.absent()
          : Value(countryCode),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      returnWindowDays: returnWindowDays == null && nullToAbsent
          ? const Value.absent()
          : Value(returnWindowDays),
      returnShippingCost: returnShippingCost == null && nullToAbsent
          ? const Value.absent()
          : Value(returnShippingCost),
      restockingFeePercent: restockingFeePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(restockingFeePercent),
      acceptsNoReasonReturns: Value(acceptsNoReasonReturns),
    );
  }

  factory SupplierRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierRow(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      name: serializer.fromJson<String>(json['name']),
      platformType: serializer.fromJson<String>(json['platformType']),
      countryCode: serializer.fromJson<String?>(json['countryCode']),
      rating: serializer.fromJson<double?>(json['rating']),
      returnWindowDays: serializer.fromJson<int?>(json['returnWindowDays']),
      returnShippingCost: serializer.fromJson<double?>(
        json['returnShippingCost'],
      ),
      restockingFeePercent: serializer.fromJson<double?>(
        json['restockingFeePercent'],
      ),
      acceptsNoReasonReturns: serializer.fromJson<bool>(
        json['acceptsNoReasonReturns'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<String>(supplierId),
      'name': serializer.toJson<String>(name),
      'platformType': serializer.toJson<String>(platformType),
      'countryCode': serializer.toJson<String?>(countryCode),
      'rating': serializer.toJson<double?>(rating),
      'returnWindowDays': serializer.toJson<int?>(returnWindowDays),
      'returnShippingCost': serializer.toJson<double?>(returnShippingCost),
      'restockingFeePercent': serializer.toJson<double?>(restockingFeePercent),
      'acceptsNoReasonReturns': serializer.toJson<bool>(acceptsNoReasonReturns),
    };
  }

  SupplierRow copyWith({
    int? id,
    String? supplierId,
    String? name,
    String? platformType,
    Value<String?> countryCode = const Value.absent(),
    Value<double?> rating = const Value.absent(),
    Value<int?> returnWindowDays = const Value.absent(),
    Value<double?> returnShippingCost = const Value.absent(),
    Value<double?> restockingFeePercent = const Value.absent(),
    bool? acceptsNoReasonReturns,
  }) => SupplierRow(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    name: name ?? this.name,
    platformType: platformType ?? this.platformType,
    countryCode: countryCode.present ? countryCode.value : this.countryCode,
    rating: rating.present ? rating.value : this.rating,
    returnWindowDays: returnWindowDays.present
        ? returnWindowDays.value
        : this.returnWindowDays,
    returnShippingCost: returnShippingCost.present
        ? returnShippingCost.value
        : this.returnShippingCost,
    restockingFeePercent: restockingFeePercent.present
        ? restockingFeePercent.value
        : this.restockingFeePercent,
    acceptsNoReasonReturns:
        acceptsNoReasonReturns ?? this.acceptsNoReasonReturns,
  );
  SupplierRow copyWithCompanion(SuppliersCompanion data) {
    return SupplierRow(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      name: data.name.present ? data.name.value : this.name,
      platformType: data.platformType.present
          ? data.platformType.value
          : this.platformType,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
      rating: data.rating.present ? data.rating.value : this.rating,
      returnWindowDays: data.returnWindowDays.present
          ? data.returnWindowDays.value
          : this.returnWindowDays,
      returnShippingCost: data.returnShippingCost.present
          ? data.returnShippingCost.value
          : this.returnShippingCost,
      restockingFeePercent: data.restockingFeePercent.present
          ? data.restockingFeePercent.value
          : this.restockingFeePercent,
      acceptsNoReasonReturns: data.acceptsNoReasonReturns.present
          ? data.acceptsNoReasonReturns.value
          : this.acceptsNoReasonReturns,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierRow(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('name: $name, ')
          ..write('platformType: $platformType, ')
          ..write('countryCode: $countryCode, ')
          ..write('rating: $rating, ')
          ..write('returnWindowDays: $returnWindowDays, ')
          ..write('returnShippingCost: $returnShippingCost, ')
          ..write('restockingFeePercent: $restockingFeePercent, ')
          ..write('acceptsNoReasonReturns: $acceptsNoReasonReturns')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    supplierId,
    name,
    platformType,
    countryCode,
    rating,
    returnWindowDays,
    returnShippingCost,
    restockingFeePercent,
    acceptsNoReasonReturns,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierRow &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.name == this.name &&
          other.platformType == this.platformType &&
          other.countryCode == this.countryCode &&
          other.rating == this.rating &&
          other.returnWindowDays == this.returnWindowDays &&
          other.returnShippingCost == this.returnShippingCost &&
          other.restockingFeePercent == this.restockingFeePercent &&
          other.acceptsNoReasonReturns == this.acceptsNoReasonReturns);
}

class SuppliersCompanion extends UpdateCompanion<SupplierRow> {
  final Value<int> id;
  final Value<String> supplierId;
  final Value<String> name;
  final Value<String> platformType;
  final Value<String?> countryCode;
  final Value<double?> rating;
  final Value<int?> returnWindowDays;
  final Value<double?> returnShippingCost;
  final Value<double?> restockingFeePercent;
  final Value<bool> acceptsNoReasonReturns;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.name = const Value.absent(),
    this.platformType = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.rating = const Value.absent(),
    this.returnWindowDays = const Value.absent(),
    this.returnShippingCost = const Value.absent(),
    this.restockingFeePercent = const Value.absent(),
    this.acceptsNoReasonReturns = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String supplierId,
    required String name,
    required String platformType,
    this.countryCode = const Value.absent(),
    this.rating = const Value.absent(),
    this.returnWindowDays = const Value.absent(),
    this.returnShippingCost = const Value.absent(),
    this.restockingFeePercent = const Value.absent(),
    this.acceptsNoReasonReturns = const Value.absent(),
  }) : supplierId = Value(supplierId),
       name = Value(name),
       platformType = Value(platformType);
  static Insertable<SupplierRow> custom({
    Expression<int>? id,
    Expression<String>? supplierId,
    Expression<String>? name,
    Expression<String>? platformType,
    Expression<String>? countryCode,
    Expression<double>? rating,
    Expression<int>? returnWindowDays,
    Expression<double>? returnShippingCost,
    Expression<double>? restockingFeePercent,
    Expression<bool>? acceptsNoReasonReturns,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (name != null) 'name': name,
      if (platformType != null) 'platform_type': platformType,
      if (countryCode != null) 'country_code': countryCode,
      if (rating != null) 'rating': rating,
      if (returnWindowDays != null) 'return_window_days': returnWindowDays,
      if (returnShippingCost != null)
        'return_shipping_cost': returnShippingCost,
      if (restockingFeePercent != null)
        'restocking_fee_percent': restockingFeePercent,
      if (acceptsNoReasonReturns != null)
        'accepts_no_reason_returns': acceptsNoReasonReturns,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<String>? supplierId,
    Value<String>? name,
    Value<String>? platformType,
    Value<String?>? countryCode,
    Value<double?>? rating,
    Value<int?>? returnWindowDays,
    Value<double?>? returnShippingCost,
    Value<double?>? restockingFeePercent,
    Value<bool>? acceptsNoReasonReturns,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      name: name ?? this.name,
      platformType: platformType ?? this.platformType,
      countryCode: countryCode ?? this.countryCode,
      rating: rating ?? this.rating,
      returnWindowDays: returnWindowDays ?? this.returnWindowDays,
      returnShippingCost: returnShippingCost ?? this.returnShippingCost,
      restockingFeePercent: restockingFeePercent ?? this.restockingFeePercent,
      acceptsNoReasonReturns:
          acceptsNoReasonReturns ?? this.acceptsNoReasonReturns,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (platformType.present) {
      map['platform_type'] = Variable<String>(platformType.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (returnWindowDays.present) {
      map['return_window_days'] = Variable<int>(returnWindowDays.value);
    }
    if (returnShippingCost.present) {
      map['return_shipping_cost'] = Variable<double>(returnShippingCost.value);
    }
    if (restockingFeePercent.present) {
      map['restocking_fee_percent'] = Variable<double>(
        restockingFeePercent.value,
      );
    }
    if (acceptsNoReasonReturns.present) {
      map['accepts_no_reason_returns'] = Variable<bool>(
        acceptsNoReasonReturns.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('name: $name, ')
          ..write('platformType: $platformType, ')
          ..write('countryCode: $countryCode, ')
          ..write('rating: $rating, ')
          ..write('returnWindowDays: $returnWindowDays, ')
          ..write('returnShippingCost: $returnShippingCost, ')
          ..write('restockingFeePercent: $restockingFeePercent, ')
          ..write('acceptsNoReasonReturns: $acceptsNoReasonReturns')
          ..write(')'))
        .toString();
  }
}

class $SupplierOffersTable extends SupplierOffers
    with TableInfo<$SupplierOffersTable, SupplierOfferRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierOffersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _offerIdMeta = const VerificationMeta(
    'offerId',
  );
  @override
  late final GeneratedColumn<String> offerId = GeneratedColumn<String>(
    'offer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourcePlatformIdMeta = const VerificationMeta(
    'sourcePlatformId',
  );
  @override
  late final GeneratedColumn<String> sourcePlatformId = GeneratedColumn<String>(
    'source_platform_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shippingCostMeta = const VerificationMeta(
    'shippingCost',
  );
  @override
  late final GeneratedColumn<double> shippingCost = GeneratedColumn<double>(
    'shipping_cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minEstimatedDaysMeta = const VerificationMeta(
    'minEstimatedDays',
  );
  @override
  late final GeneratedColumn<int> minEstimatedDays = GeneratedColumn<int>(
    'min_estimated_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxEstimatedDaysMeta = const VerificationMeta(
    'maxEstimatedDays',
  );
  @override
  late final GeneratedColumn<int> maxEstimatedDays = GeneratedColumn<int>(
    'max_estimated_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carrierCodeMeta = const VerificationMeta(
    'carrierCode',
  );
  @override
  late final GeneratedColumn<String> carrierCode = GeneratedColumn<String>(
    'carrier_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shippingMethodNameMeta =
      const VerificationMeta('shippingMethodName');
  @override
  late final GeneratedColumn<String> shippingMethodName =
      GeneratedColumn<String>(
        'shipping_method_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastPriceRefreshAtMeta =
      const VerificationMeta('lastPriceRefreshAt');
  @override
  late final GeneratedColumn<DateTime> lastPriceRefreshAt =
      GeneratedColumn<DateTime>(
        'last_price_refresh_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastStockRefreshAtMeta =
      const VerificationMeta('lastStockRefreshAt');
  @override
  late final GeneratedColumn<DateTime> lastStockRefreshAt =
      GeneratedColumn<DateTime>(
        'last_stock_refresh_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    offerId,
    productId,
    supplierId,
    sourcePlatformId,
    cost,
    shippingCost,
    minEstimatedDays,
    maxEstimatedDays,
    carrierCode,
    shippingMethodName,
    lastPriceRefreshAt,
    lastStockRefreshAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_offers';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierOfferRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('offer_id')) {
      context.handle(
        _offerIdMeta,
        offerId.isAcceptableOrUnknown(data['offer_id']!, _offerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_offerIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('source_platform_id')) {
      context.handle(
        _sourcePlatformIdMeta,
        sourcePlatformId.isAcceptableOrUnknown(
          data['source_platform_id']!,
          _sourcePlatformIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourcePlatformIdMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('shipping_cost')) {
      context.handle(
        _shippingCostMeta,
        shippingCost.isAcceptableOrUnknown(
          data['shipping_cost']!,
          _shippingCostMeta,
        ),
      );
    }
    if (data.containsKey('min_estimated_days')) {
      context.handle(
        _minEstimatedDaysMeta,
        minEstimatedDays.isAcceptableOrUnknown(
          data['min_estimated_days']!,
          _minEstimatedDaysMeta,
        ),
      );
    }
    if (data.containsKey('max_estimated_days')) {
      context.handle(
        _maxEstimatedDaysMeta,
        maxEstimatedDays.isAcceptableOrUnknown(
          data['max_estimated_days']!,
          _maxEstimatedDaysMeta,
        ),
      );
    }
    if (data.containsKey('carrier_code')) {
      context.handle(
        _carrierCodeMeta,
        carrierCode.isAcceptableOrUnknown(
          data['carrier_code']!,
          _carrierCodeMeta,
        ),
      );
    }
    if (data.containsKey('shipping_method_name')) {
      context.handle(
        _shippingMethodNameMeta,
        shippingMethodName.isAcceptableOrUnknown(
          data['shipping_method_name']!,
          _shippingMethodNameMeta,
        ),
      );
    }
    if (data.containsKey('last_price_refresh_at')) {
      context.handle(
        _lastPriceRefreshAtMeta,
        lastPriceRefreshAt.isAcceptableOrUnknown(
          data['last_price_refresh_at']!,
          _lastPriceRefreshAtMeta,
        ),
      );
    }
    if (data.containsKey('last_stock_refresh_at')) {
      context.handle(
        _lastStockRefreshAtMeta,
        lastStockRefreshAt.isAcceptableOrUnknown(
          data['last_stock_refresh_at']!,
          _lastStockRefreshAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierOfferRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierOfferRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      offerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}offer_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      sourcePlatformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_platform_id'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
      shippingCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shipping_cost'],
      ),
      minEstimatedDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_estimated_days'],
      ),
      maxEstimatedDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_estimated_days'],
      ),
      carrierCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}carrier_code'],
      ),
      shippingMethodName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shipping_method_name'],
      ),
      lastPriceRefreshAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_price_refresh_at'],
      ),
      lastStockRefreshAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_stock_refresh_at'],
      ),
    );
  }

  @override
  $SupplierOffersTable createAlias(String alias) {
    return $SupplierOffersTable(attachedDatabase, alias);
  }
}

class SupplierOfferRow extends DataClass
    implements Insertable<SupplierOfferRow> {
  final int id;
  final String offerId;
  final String productId;
  final String supplierId;
  final String sourcePlatformId;
  final double cost;
  final double? shippingCost;
  final int? minEstimatedDays;
  final int? maxEstimatedDays;
  final String? carrierCode;
  final String? shippingMethodName;
  final DateTime? lastPriceRefreshAt;
  final DateTime? lastStockRefreshAt;
  const SupplierOfferRow({
    required this.id,
    required this.offerId,
    required this.productId,
    required this.supplierId,
    required this.sourcePlatformId,
    required this.cost,
    this.shippingCost,
    this.minEstimatedDays,
    this.maxEstimatedDays,
    this.carrierCode,
    this.shippingMethodName,
    this.lastPriceRefreshAt,
    this.lastStockRefreshAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['offer_id'] = Variable<String>(offerId);
    map['product_id'] = Variable<String>(productId);
    map['supplier_id'] = Variable<String>(supplierId);
    map['source_platform_id'] = Variable<String>(sourcePlatformId);
    map['cost'] = Variable<double>(cost);
    if (!nullToAbsent || shippingCost != null) {
      map['shipping_cost'] = Variable<double>(shippingCost);
    }
    if (!nullToAbsent || minEstimatedDays != null) {
      map['min_estimated_days'] = Variable<int>(minEstimatedDays);
    }
    if (!nullToAbsent || maxEstimatedDays != null) {
      map['max_estimated_days'] = Variable<int>(maxEstimatedDays);
    }
    if (!nullToAbsent || carrierCode != null) {
      map['carrier_code'] = Variable<String>(carrierCode);
    }
    if (!nullToAbsent || shippingMethodName != null) {
      map['shipping_method_name'] = Variable<String>(shippingMethodName);
    }
    if (!nullToAbsent || lastPriceRefreshAt != null) {
      map['last_price_refresh_at'] = Variable<DateTime>(lastPriceRefreshAt);
    }
    if (!nullToAbsent || lastStockRefreshAt != null) {
      map['last_stock_refresh_at'] = Variable<DateTime>(lastStockRefreshAt);
    }
    return map;
  }

  SupplierOffersCompanion toCompanion(bool nullToAbsent) {
    return SupplierOffersCompanion(
      id: Value(id),
      offerId: Value(offerId),
      productId: Value(productId),
      supplierId: Value(supplierId),
      sourcePlatformId: Value(sourcePlatformId),
      cost: Value(cost),
      shippingCost: shippingCost == null && nullToAbsent
          ? const Value.absent()
          : Value(shippingCost),
      minEstimatedDays: minEstimatedDays == null && nullToAbsent
          ? const Value.absent()
          : Value(minEstimatedDays),
      maxEstimatedDays: maxEstimatedDays == null && nullToAbsent
          ? const Value.absent()
          : Value(maxEstimatedDays),
      carrierCode: carrierCode == null && nullToAbsent
          ? const Value.absent()
          : Value(carrierCode),
      shippingMethodName: shippingMethodName == null && nullToAbsent
          ? const Value.absent()
          : Value(shippingMethodName),
      lastPriceRefreshAt: lastPriceRefreshAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPriceRefreshAt),
      lastStockRefreshAt: lastStockRefreshAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStockRefreshAt),
    );
  }

  factory SupplierOfferRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierOfferRow(
      id: serializer.fromJson<int>(json['id']),
      offerId: serializer.fromJson<String>(json['offerId']),
      productId: serializer.fromJson<String>(json['productId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      sourcePlatformId: serializer.fromJson<String>(json['sourcePlatformId']),
      cost: serializer.fromJson<double>(json['cost']),
      shippingCost: serializer.fromJson<double?>(json['shippingCost']),
      minEstimatedDays: serializer.fromJson<int?>(json['minEstimatedDays']),
      maxEstimatedDays: serializer.fromJson<int?>(json['maxEstimatedDays']),
      carrierCode: serializer.fromJson<String?>(json['carrierCode']),
      shippingMethodName: serializer.fromJson<String?>(
        json['shippingMethodName'],
      ),
      lastPriceRefreshAt: serializer.fromJson<DateTime?>(
        json['lastPriceRefreshAt'],
      ),
      lastStockRefreshAt: serializer.fromJson<DateTime?>(
        json['lastStockRefreshAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'offerId': serializer.toJson<String>(offerId),
      'productId': serializer.toJson<String>(productId),
      'supplierId': serializer.toJson<String>(supplierId),
      'sourcePlatformId': serializer.toJson<String>(sourcePlatformId),
      'cost': serializer.toJson<double>(cost),
      'shippingCost': serializer.toJson<double?>(shippingCost),
      'minEstimatedDays': serializer.toJson<int?>(minEstimatedDays),
      'maxEstimatedDays': serializer.toJson<int?>(maxEstimatedDays),
      'carrierCode': serializer.toJson<String?>(carrierCode),
      'shippingMethodName': serializer.toJson<String?>(shippingMethodName),
      'lastPriceRefreshAt': serializer.toJson<DateTime?>(lastPriceRefreshAt),
      'lastStockRefreshAt': serializer.toJson<DateTime?>(lastStockRefreshAt),
    };
  }

  SupplierOfferRow copyWith({
    int? id,
    String? offerId,
    String? productId,
    String? supplierId,
    String? sourcePlatformId,
    double? cost,
    Value<double?> shippingCost = const Value.absent(),
    Value<int?> minEstimatedDays = const Value.absent(),
    Value<int?> maxEstimatedDays = const Value.absent(),
    Value<String?> carrierCode = const Value.absent(),
    Value<String?> shippingMethodName = const Value.absent(),
    Value<DateTime?> lastPriceRefreshAt = const Value.absent(),
    Value<DateTime?> lastStockRefreshAt = const Value.absent(),
  }) => SupplierOfferRow(
    id: id ?? this.id,
    offerId: offerId ?? this.offerId,
    productId: productId ?? this.productId,
    supplierId: supplierId ?? this.supplierId,
    sourcePlatformId: sourcePlatformId ?? this.sourcePlatformId,
    cost: cost ?? this.cost,
    shippingCost: shippingCost.present ? shippingCost.value : this.shippingCost,
    minEstimatedDays: minEstimatedDays.present
        ? minEstimatedDays.value
        : this.minEstimatedDays,
    maxEstimatedDays: maxEstimatedDays.present
        ? maxEstimatedDays.value
        : this.maxEstimatedDays,
    carrierCode: carrierCode.present ? carrierCode.value : this.carrierCode,
    shippingMethodName: shippingMethodName.present
        ? shippingMethodName.value
        : this.shippingMethodName,
    lastPriceRefreshAt: lastPriceRefreshAt.present
        ? lastPriceRefreshAt.value
        : this.lastPriceRefreshAt,
    lastStockRefreshAt: lastStockRefreshAt.present
        ? lastStockRefreshAt.value
        : this.lastStockRefreshAt,
  );
  SupplierOfferRow copyWithCompanion(SupplierOffersCompanion data) {
    return SupplierOfferRow(
      id: data.id.present ? data.id.value : this.id,
      offerId: data.offerId.present ? data.offerId.value : this.offerId,
      productId: data.productId.present ? data.productId.value : this.productId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      sourcePlatformId: data.sourcePlatformId.present
          ? data.sourcePlatformId.value
          : this.sourcePlatformId,
      cost: data.cost.present ? data.cost.value : this.cost,
      shippingCost: data.shippingCost.present
          ? data.shippingCost.value
          : this.shippingCost,
      minEstimatedDays: data.minEstimatedDays.present
          ? data.minEstimatedDays.value
          : this.minEstimatedDays,
      maxEstimatedDays: data.maxEstimatedDays.present
          ? data.maxEstimatedDays.value
          : this.maxEstimatedDays,
      carrierCode: data.carrierCode.present
          ? data.carrierCode.value
          : this.carrierCode,
      shippingMethodName: data.shippingMethodName.present
          ? data.shippingMethodName.value
          : this.shippingMethodName,
      lastPriceRefreshAt: data.lastPriceRefreshAt.present
          ? data.lastPriceRefreshAt.value
          : this.lastPriceRefreshAt,
      lastStockRefreshAt: data.lastStockRefreshAt.present
          ? data.lastStockRefreshAt.value
          : this.lastStockRefreshAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierOfferRow(')
          ..write('id: $id, ')
          ..write('offerId: $offerId, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId, ')
          ..write('sourcePlatformId: $sourcePlatformId, ')
          ..write('cost: $cost, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('minEstimatedDays: $minEstimatedDays, ')
          ..write('maxEstimatedDays: $maxEstimatedDays, ')
          ..write('carrierCode: $carrierCode, ')
          ..write('shippingMethodName: $shippingMethodName, ')
          ..write('lastPriceRefreshAt: $lastPriceRefreshAt, ')
          ..write('lastStockRefreshAt: $lastStockRefreshAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    offerId,
    productId,
    supplierId,
    sourcePlatformId,
    cost,
    shippingCost,
    minEstimatedDays,
    maxEstimatedDays,
    carrierCode,
    shippingMethodName,
    lastPriceRefreshAt,
    lastStockRefreshAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierOfferRow &&
          other.id == this.id &&
          other.offerId == this.offerId &&
          other.productId == this.productId &&
          other.supplierId == this.supplierId &&
          other.sourcePlatformId == this.sourcePlatformId &&
          other.cost == this.cost &&
          other.shippingCost == this.shippingCost &&
          other.minEstimatedDays == this.minEstimatedDays &&
          other.maxEstimatedDays == this.maxEstimatedDays &&
          other.carrierCode == this.carrierCode &&
          other.shippingMethodName == this.shippingMethodName &&
          other.lastPriceRefreshAt == this.lastPriceRefreshAt &&
          other.lastStockRefreshAt == this.lastStockRefreshAt);
}

class SupplierOffersCompanion extends UpdateCompanion<SupplierOfferRow> {
  final Value<int> id;
  final Value<String> offerId;
  final Value<String> productId;
  final Value<String> supplierId;
  final Value<String> sourcePlatformId;
  final Value<double> cost;
  final Value<double?> shippingCost;
  final Value<int?> minEstimatedDays;
  final Value<int?> maxEstimatedDays;
  final Value<String?> carrierCode;
  final Value<String?> shippingMethodName;
  final Value<DateTime?> lastPriceRefreshAt;
  final Value<DateTime?> lastStockRefreshAt;
  const SupplierOffersCompanion({
    this.id = const Value.absent(),
    this.offerId = const Value.absent(),
    this.productId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.sourcePlatformId = const Value.absent(),
    this.cost = const Value.absent(),
    this.shippingCost = const Value.absent(),
    this.minEstimatedDays = const Value.absent(),
    this.maxEstimatedDays = const Value.absent(),
    this.carrierCode = const Value.absent(),
    this.shippingMethodName = const Value.absent(),
    this.lastPriceRefreshAt = const Value.absent(),
    this.lastStockRefreshAt = const Value.absent(),
  });
  SupplierOffersCompanion.insert({
    this.id = const Value.absent(),
    required String offerId,
    required String productId,
    required String supplierId,
    required String sourcePlatformId,
    required double cost,
    this.shippingCost = const Value.absent(),
    this.minEstimatedDays = const Value.absent(),
    this.maxEstimatedDays = const Value.absent(),
    this.carrierCode = const Value.absent(),
    this.shippingMethodName = const Value.absent(),
    this.lastPriceRefreshAt = const Value.absent(),
    this.lastStockRefreshAt = const Value.absent(),
  }) : offerId = Value(offerId),
       productId = Value(productId),
       supplierId = Value(supplierId),
       sourcePlatformId = Value(sourcePlatformId),
       cost = Value(cost);
  static Insertable<SupplierOfferRow> custom({
    Expression<int>? id,
    Expression<String>? offerId,
    Expression<String>? productId,
    Expression<String>? supplierId,
    Expression<String>? sourcePlatformId,
    Expression<double>? cost,
    Expression<double>? shippingCost,
    Expression<int>? minEstimatedDays,
    Expression<int>? maxEstimatedDays,
    Expression<String>? carrierCode,
    Expression<String>? shippingMethodName,
    Expression<DateTime>? lastPriceRefreshAt,
    Expression<DateTime>? lastStockRefreshAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (offerId != null) 'offer_id': offerId,
      if (productId != null) 'product_id': productId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (sourcePlatformId != null) 'source_platform_id': sourcePlatformId,
      if (cost != null) 'cost': cost,
      if (shippingCost != null) 'shipping_cost': shippingCost,
      if (minEstimatedDays != null) 'min_estimated_days': minEstimatedDays,
      if (maxEstimatedDays != null) 'max_estimated_days': maxEstimatedDays,
      if (carrierCode != null) 'carrier_code': carrierCode,
      if (shippingMethodName != null)
        'shipping_method_name': shippingMethodName,
      if (lastPriceRefreshAt != null)
        'last_price_refresh_at': lastPriceRefreshAt,
      if (lastStockRefreshAt != null)
        'last_stock_refresh_at': lastStockRefreshAt,
    });
  }

  SupplierOffersCompanion copyWith({
    Value<int>? id,
    Value<String>? offerId,
    Value<String>? productId,
    Value<String>? supplierId,
    Value<String>? sourcePlatformId,
    Value<double>? cost,
    Value<double?>? shippingCost,
    Value<int?>? minEstimatedDays,
    Value<int?>? maxEstimatedDays,
    Value<String?>? carrierCode,
    Value<String?>? shippingMethodName,
    Value<DateTime?>? lastPriceRefreshAt,
    Value<DateTime?>? lastStockRefreshAt,
  }) {
    return SupplierOffersCompanion(
      id: id ?? this.id,
      offerId: offerId ?? this.offerId,
      productId: productId ?? this.productId,
      supplierId: supplierId ?? this.supplierId,
      sourcePlatformId: sourcePlatformId ?? this.sourcePlatformId,
      cost: cost ?? this.cost,
      shippingCost: shippingCost ?? this.shippingCost,
      minEstimatedDays: minEstimatedDays ?? this.minEstimatedDays,
      maxEstimatedDays: maxEstimatedDays ?? this.maxEstimatedDays,
      carrierCode: carrierCode ?? this.carrierCode,
      shippingMethodName: shippingMethodName ?? this.shippingMethodName,
      lastPriceRefreshAt: lastPriceRefreshAt ?? this.lastPriceRefreshAt,
      lastStockRefreshAt: lastStockRefreshAt ?? this.lastStockRefreshAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (offerId.present) {
      map['offer_id'] = Variable<String>(offerId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (sourcePlatformId.present) {
      map['source_platform_id'] = Variable<String>(sourcePlatformId.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (shippingCost.present) {
      map['shipping_cost'] = Variable<double>(shippingCost.value);
    }
    if (minEstimatedDays.present) {
      map['min_estimated_days'] = Variable<int>(minEstimatedDays.value);
    }
    if (maxEstimatedDays.present) {
      map['max_estimated_days'] = Variable<int>(maxEstimatedDays.value);
    }
    if (carrierCode.present) {
      map['carrier_code'] = Variable<String>(carrierCode.value);
    }
    if (shippingMethodName.present) {
      map['shipping_method_name'] = Variable<String>(shippingMethodName.value);
    }
    if (lastPriceRefreshAt.present) {
      map['last_price_refresh_at'] = Variable<DateTime>(
        lastPriceRefreshAt.value,
      );
    }
    if (lastStockRefreshAt.present) {
      map['last_stock_refresh_at'] = Variable<DateTime>(
        lastStockRefreshAt.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierOffersCompanion(')
          ..write('id: $id, ')
          ..write('offerId: $offerId, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId, ')
          ..write('sourcePlatformId: $sourcePlatformId, ')
          ..write('cost: $cost, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('minEstimatedDays: $minEstimatedDays, ')
          ..write('maxEstimatedDays: $maxEstimatedDays, ')
          ..write('carrierCode: $carrierCode, ')
          ..write('shippingMethodName: $shippingMethodName, ')
          ..write('lastPriceRefreshAt: $lastPriceRefreshAt, ')
          ..write('lastStockRefreshAt: $lastStockRefreshAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ListingsTable listings = $ListingsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $DecisionLogsTable decisionLogs = $DecisionLogsTable(this);
  late final $UserRulesTableTable userRulesTable = $UserRulesTableTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $SupplierOffersTable supplierOffers = $SupplierOffersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    listings,
    orders,
    decisionLogs,
    userRulesTable,
    suppliers,
    supplierOffers,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String localId,
      required String sourceId,
      required String sourcePlatformId,
      required String title,
      Value<String?> description,
      required String imageUrls,
      required String variantsJson,
      required double basePrice,
      Value<double?> shippingCost,
      Value<String> currency,
      Value<String?> supplierId,
      Value<String?> supplierCountry,
      Value<int?> estimatedDays,
      Value<String?> rawJson,
      required DateTime updatedAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> localId,
      Value<String> sourceId,
      Value<String> sourcePlatformId,
      Value<String> title,
      Value<String?> description,
      Value<String> imageUrls,
      Value<String> variantsJson,
      Value<double> basePrice,
      Value<double?> shippingCost,
      Value<String> currency,
      Value<String?> supplierId,
      Value<String?> supplierCountry,
      Value<int?> estimatedDays,
      Value<String?> rawJson,
      Value<DateTime> updatedAt,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrls => $composableBuilder(
    column: $table.imageUrls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantsJson => $composableBuilder(
    column: $table.variantsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get basePrice => $composableBuilder(
    column: $table.basePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shippingCost => $composableBuilder(
    column: $table.shippingCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierCountry => $composableBuilder(
    column: $table.supplierCountry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedDays => $composableBuilder(
    column: $table.estimatedDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawJson => $composableBuilder(
    column: $table.rawJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrls => $composableBuilder(
    column: $table.imageUrls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantsJson => $composableBuilder(
    column: $table.variantsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get basePrice => $composableBuilder(
    column: $table.basePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shippingCost => $composableBuilder(
    column: $table.shippingCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierCountry => $composableBuilder(
    column: $table.supplierCountry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedDays => $composableBuilder(
    column: $table.estimatedDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawJson => $composableBuilder(
    column: $table.rawJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrls =>
      $composableBuilder(column: $table.imageUrls, builder: (column) => column);

  GeneratedColumn<String> get variantsJson => $composableBuilder(
    column: $table.variantsJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get basePrice =>
      $composableBuilder(column: $table.basePrice, builder: (column) => column);

  GeneratedColumn<double> get shippingCost => $composableBuilder(
    column: $table.shippingCost,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierCountry => $composableBuilder(
    column: $table.supplierCountry,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedDays => $composableBuilder(
    column: $table.estimatedDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawJson =>
      $composableBuilder(column: $table.rawJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductRow,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (
            ProductRow,
            BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>,
          ),
          ProductRow,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> sourcePlatformId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> imageUrls = const Value.absent(),
                Value<String> variantsJson = const Value.absent(),
                Value<double> basePrice = const Value.absent(),
                Value<double?> shippingCost = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                Value<String?> supplierCountry = const Value.absent(),
                Value<int?> estimatedDays = const Value.absent(),
                Value<String?> rawJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                localId: localId,
                sourceId: sourceId,
                sourcePlatformId: sourcePlatformId,
                title: title,
                description: description,
                imageUrls: imageUrls,
                variantsJson: variantsJson,
                basePrice: basePrice,
                shippingCost: shippingCost,
                currency: currency,
                supplierId: supplierId,
                supplierCountry: supplierCountry,
                estimatedDays: estimatedDays,
                rawJson: rawJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String localId,
                required String sourceId,
                required String sourcePlatformId,
                required String title,
                Value<String?> description = const Value.absent(),
                required String imageUrls,
                required String variantsJson,
                required double basePrice,
                Value<double?> shippingCost = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                Value<String?> supplierCountry = const Value.absent(),
                Value<int?> estimatedDays = const Value.absent(),
                Value<String?> rawJson = const Value.absent(),
                required DateTime updatedAt,
              }) => ProductsCompanion.insert(
                id: id,
                localId: localId,
                sourceId: sourceId,
                sourcePlatformId: sourcePlatformId,
                title: title,
                description: description,
                imageUrls: imageUrls,
                variantsJson: variantsJson,
                basePrice: basePrice,
                shippingCost: shippingCost,
                currency: currency,
                supplierId: supplierId,
                supplierCountry: supplierCountry,
                estimatedDays: estimatedDays,
                rawJson: rawJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductRow,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductRow, BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>),
      ProductRow,
      PrefetchHooks Function()
    >;
typedef $$ListingsTableCreateCompanionBuilder =
    ListingsCompanion Function({
      Value<int> id,
      required String localId,
      required String productId,
      required String targetPlatformId,
      Value<String?> targetListingId,
      required String status,
      required double sellingPrice,
      required double sourceCost,
      Value<String?> decisionLogId,
      required DateTime createdAt,
      Value<DateTime?> publishedAt,
    });
typedef $$ListingsTableUpdateCompanionBuilder =
    ListingsCompanion Function({
      Value<int> id,
      Value<String> localId,
      Value<String> productId,
      Value<String> targetPlatformId,
      Value<String?> targetListingId,
      Value<String> status,
      Value<double> sellingPrice,
      Value<double> sourceCost,
      Value<String?> decisionLogId,
      Value<DateTime> createdAt,
      Value<DateTime?> publishedAt,
    });

class $$ListingsTableFilterComposer
    extends Composer<_$AppDatabase, $ListingsTable> {
  $$ListingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetListingId => $composableBuilder(
    column: $table.targetListingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sourceCost => $composableBuilder(
    column: $table.sourceCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decisionLogId => $composableBuilder(
    column: $table.decisionLogId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ListingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ListingsTable> {
  $$ListingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetListingId => $composableBuilder(
    column: $table.targetListingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sourceCost => $composableBuilder(
    column: $table.sourceCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decisionLogId => $composableBuilder(
    column: $table.decisionLogId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ListingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListingsTable> {
  $$ListingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetListingId => $composableBuilder(
    column: $table.targetListingId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sourceCost => $composableBuilder(
    column: $table.sourceCost,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decisionLogId => $composableBuilder(
    column: $table.decisionLogId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );
}

class $$ListingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ListingsTable,
          ListingRow,
          $$ListingsTableFilterComposer,
          $$ListingsTableOrderingComposer,
          $$ListingsTableAnnotationComposer,
          $$ListingsTableCreateCompanionBuilder,
          $$ListingsTableUpdateCompanionBuilder,
          (
            ListingRow,
            BaseReferences<_$AppDatabase, $ListingsTable, ListingRow>,
          ),
          ListingRow,
          PrefetchHooks Function()
        > {
  $$ListingsTableTableManager(_$AppDatabase db, $ListingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> targetPlatformId = const Value.absent(),
                Value<String?> targetListingId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<double> sourceCost = const Value.absent(),
                Value<String?> decisionLogId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
              }) => ListingsCompanion(
                id: id,
                localId: localId,
                productId: productId,
                targetPlatformId: targetPlatformId,
                targetListingId: targetListingId,
                status: status,
                sellingPrice: sellingPrice,
                sourceCost: sourceCost,
                decisionLogId: decisionLogId,
                createdAt: createdAt,
                publishedAt: publishedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String localId,
                required String productId,
                required String targetPlatformId,
                Value<String?> targetListingId = const Value.absent(),
                required String status,
                required double sellingPrice,
                required double sourceCost,
                Value<String?> decisionLogId = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> publishedAt = const Value.absent(),
              }) => ListingsCompanion.insert(
                id: id,
                localId: localId,
                productId: productId,
                targetPlatformId: targetPlatformId,
                targetListingId: targetListingId,
                status: status,
                sellingPrice: sellingPrice,
                sourceCost: sourceCost,
                decisionLogId: decisionLogId,
                createdAt: createdAt,
                publishedAt: publishedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ListingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ListingsTable,
      ListingRow,
      $$ListingsTableFilterComposer,
      $$ListingsTableOrderingComposer,
      $$ListingsTableAnnotationComposer,
      $$ListingsTableCreateCompanionBuilder,
      $$ListingsTableUpdateCompanionBuilder,
      (ListingRow, BaseReferences<_$AppDatabase, $ListingsTable, ListingRow>),
      ListingRow,
      PrefetchHooks Function()
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      required String localId,
      required String listingId,
      required String targetOrderId,
      required String targetPlatformId,
      required String customerAddressJson,
      required String status,
      Value<String?> sourceOrderId,
      required double sourceCost,
      required double sellingPrice,
      Value<String?> trackingNumber,
      Value<String?> decisionLogId,
      Value<DateTime?> approvedAt,
      required DateTime createdAt,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<String> localId,
      Value<String> listingId,
      Value<String> targetOrderId,
      Value<String> targetPlatformId,
      Value<String> customerAddressJson,
      Value<String> status,
      Value<String?> sourceOrderId,
      Value<double> sourceCost,
      Value<double> sellingPrice,
      Value<String?> trackingNumber,
      Value<String?> decisionLogId,
      Value<DateTime?> approvedAt,
      Value<DateTime> createdAt,
    });

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetOrderId => $composableBuilder(
    column: $table.targetOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerAddressJson => $composableBuilder(
    column: $table.customerAddressJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceOrderId => $composableBuilder(
    column: $table.sourceOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sourceCost => $composableBuilder(
    column: $table.sourceCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackingNumber => $composableBuilder(
    column: $table.trackingNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decisionLogId => $composableBuilder(
    column: $table.decisionLogId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetOrderId => $composableBuilder(
    column: $table.targetOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerAddressJson => $composableBuilder(
    column: $table.customerAddressJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceOrderId => $composableBuilder(
    column: $table.sourceOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sourceCost => $composableBuilder(
    column: $table.sourceCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackingNumber => $composableBuilder(
    column: $table.trackingNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decisionLogId => $composableBuilder(
    column: $table.decisionLogId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get listingId =>
      $composableBuilder(column: $table.listingId, builder: (column) => column);

  GeneratedColumn<String> get targetOrderId => $composableBuilder(
    column: $table.targetOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerAddressJson => $composableBuilder(
    column: $table.customerAddressJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get sourceOrderId => $composableBuilder(
    column: $table.sourceOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sourceCost => $composableBuilder(
    column: $table.sourceCost,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackingNumber => $composableBuilder(
    column: $table.trackingNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decisionLogId => $composableBuilder(
    column: $table.decisionLogId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          OrderRow,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (OrderRow, BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>),
          OrderRow,
          PrefetchHooks Function()
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> listingId = const Value.absent(),
                Value<String> targetOrderId = const Value.absent(),
                Value<String> targetPlatformId = const Value.absent(),
                Value<String> customerAddressJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> sourceOrderId = const Value.absent(),
                Value<double> sourceCost = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<String?> trackingNumber = const Value.absent(),
                Value<String?> decisionLogId = const Value.absent(),
                Value<DateTime?> approvedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                localId: localId,
                listingId: listingId,
                targetOrderId: targetOrderId,
                targetPlatformId: targetPlatformId,
                customerAddressJson: customerAddressJson,
                status: status,
                sourceOrderId: sourceOrderId,
                sourceCost: sourceCost,
                sellingPrice: sellingPrice,
                trackingNumber: trackingNumber,
                decisionLogId: decisionLogId,
                approvedAt: approvedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String localId,
                required String listingId,
                required String targetOrderId,
                required String targetPlatformId,
                required String customerAddressJson,
                required String status,
                Value<String?> sourceOrderId = const Value.absent(),
                required double sourceCost,
                required double sellingPrice,
                Value<String?> trackingNumber = const Value.absent(),
                Value<String?> decisionLogId = const Value.absent(),
                Value<DateTime?> approvedAt = const Value.absent(),
                required DateTime createdAt,
              }) => OrdersCompanion.insert(
                id: id,
                localId: localId,
                listingId: listingId,
                targetOrderId: targetOrderId,
                targetPlatformId: targetPlatformId,
                customerAddressJson: customerAddressJson,
                status: status,
                sourceOrderId: sourceOrderId,
                sourceCost: sourceCost,
                sellingPrice: sellingPrice,
                trackingNumber: trackingNumber,
                decisionLogId: decisionLogId,
                approvedAt: approvedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      OrderRow,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (OrderRow, BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>),
      OrderRow,
      PrefetchHooks Function()
    >;
typedef $$DecisionLogsTableCreateCompanionBuilder =
    DecisionLogsCompanion Function({
      Value<int> id,
      required String localId,
      required String type,
      required String entityId,
      required String reason,
      Value<String?> criteriaSnapshot,
      required DateTime createdAt,
    });
typedef $$DecisionLogsTableUpdateCompanionBuilder =
    DecisionLogsCompanion Function({
      Value<int> id,
      Value<String> localId,
      Value<String> type,
      Value<String> entityId,
      Value<String> reason,
      Value<String?> criteriaSnapshot,
      Value<DateTime> createdAt,
    });

class $$DecisionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DecisionLogsTable> {
  $$DecisionLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get criteriaSnapshot => $composableBuilder(
    column: $table.criteriaSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DecisionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DecisionLogsTable> {
  $$DecisionLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get criteriaSnapshot => $composableBuilder(
    column: $table.criteriaSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DecisionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DecisionLogsTable> {
  $$DecisionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get criteriaSnapshot => $composableBuilder(
    column: $table.criteriaSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DecisionLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DecisionLogsTable,
          DecisionLogRow,
          $$DecisionLogsTableFilterComposer,
          $$DecisionLogsTableOrderingComposer,
          $$DecisionLogsTableAnnotationComposer,
          $$DecisionLogsTableCreateCompanionBuilder,
          $$DecisionLogsTableUpdateCompanionBuilder,
          (
            DecisionLogRow,
            BaseReferences<_$AppDatabase, $DecisionLogsTable, DecisionLogRow>,
          ),
          DecisionLogRow,
          PrefetchHooks Function()
        > {
  $$DecisionLogsTableTableManager(_$AppDatabase db, $DecisionLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DecisionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DecisionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DecisionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String?> criteriaSnapshot = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DecisionLogsCompanion(
                id: id,
                localId: localId,
                type: type,
                entityId: entityId,
                reason: reason,
                criteriaSnapshot: criteriaSnapshot,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String localId,
                required String type,
                required String entityId,
                required String reason,
                Value<String?> criteriaSnapshot = const Value.absent(),
                required DateTime createdAt,
              }) => DecisionLogsCompanion.insert(
                id: id,
                localId: localId,
                type: type,
                entityId: entityId,
                reason: reason,
                criteriaSnapshot: criteriaSnapshot,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DecisionLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DecisionLogsTable,
      DecisionLogRow,
      $$DecisionLogsTableFilterComposer,
      $$DecisionLogsTableOrderingComposer,
      $$DecisionLogsTableAnnotationComposer,
      $$DecisionLogsTableCreateCompanionBuilder,
      $$DecisionLogsTableUpdateCompanionBuilder,
      (
        DecisionLogRow,
        BaseReferences<_$AppDatabase, $DecisionLogsTable, DecisionLogRow>,
      ),
      DecisionLogRow,
      PrefetchHooks Function()
    >;
typedef $$UserRulesTableTableCreateCompanionBuilder =
    UserRulesTableCompanion Function({
      Value<int> id,
      required double minProfitPercent,
      Value<double?> maxSourcePrice,
      required String preferredSupplierCountries,
      required bool manualApprovalListings,
      required bool manualApprovalOrders,
      required int scanIntervalMinutes,
      required String blacklistedProductIds,
      required String blacklistedSupplierIds,
      required double defaultMarkupPercent,
      required String searchKeywords,
    });
typedef $$UserRulesTableTableUpdateCompanionBuilder =
    UserRulesTableCompanion Function({
      Value<int> id,
      Value<double> minProfitPercent,
      Value<double?> maxSourcePrice,
      Value<String> preferredSupplierCountries,
      Value<bool> manualApprovalListings,
      Value<bool> manualApprovalOrders,
      Value<int> scanIntervalMinutes,
      Value<String> blacklistedProductIds,
      Value<String> blacklistedSupplierIds,
      Value<double> defaultMarkupPercent,
      Value<String> searchKeywords,
    });

class $$UserRulesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserRulesTableTable> {
  $$UserRulesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minProfitPercent => $composableBuilder(
    column: $table.minProfitPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSourcePrice => $composableBuilder(
    column: $table.maxSourcePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredSupplierCountries => $composableBuilder(
    column: $table.preferredSupplierCountries,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get manualApprovalListings => $composableBuilder(
    column: $table.manualApprovalListings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get manualApprovalOrders => $composableBuilder(
    column: $table.manualApprovalOrders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scanIntervalMinutes => $composableBuilder(
    column: $table.scanIntervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blacklistedProductIds => $composableBuilder(
    column: $table.blacklistedProductIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blacklistedSupplierIds => $composableBuilder(
    column: $table.blacklistedSupplierIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultMarkupPercent => $composableBuilder(
    column: $table.defaultMarkupPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchKeywords => $composableBuilder(
    column: $table.searchKeywords,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserRulesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserRulesTableTable> {
  $$UserRulesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minProfitPercent => $composableBuilder(
    column: $table.minProfitPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSourcePrice => $composableBuilder(
    column: $table.maxSourcePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredSupplierCountries => $composableBuilder(
    column: $table.preferredSupplierCountries,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get manualApprovalListings => $composableBuilder(
    column: $table.manualApprovalListings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get manualApprovalOrders => $composableBuilder(
    column: $table.manualApprovalOrders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scanIntervalMinutes => $composableBuilder(
    column: $table.scanIntervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blacklistedProductIds => $composableBuilder(
    column: $table.blacklistedProductIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blacklistedSupplierIds => $composableBuilder(
    column: $table.blacklistedSupplierIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultMarkupPercent => $composableBuilder(
    column: $table.defaultMarkupPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchKeywords => $composableBuilder(
    column: $table.searchKeywords,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserRulesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserRulesTableTable> {
  $$UserRulesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get minProfitPercent => $composableBuilder(
    column: $table.minProfitPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxSourcePrice => $composableBuilder(
    column: $table.maxSourcePrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredSupplierCountries => $composableBuilder(
    column: $table.preferredSupplierCountries,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get manualApprovalListings => $composableBuilder(
    column: $table.manualApprovalListings,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get manualApprovalOrders => $composableBuilder(
    column: $table.manualApprovalOrders,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scanIntervalMinutes => $composableBuilder(
    column: $table.scanIntervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blacklistedProductIds => $composableBuilder(
    column: $table.blacklistedProductIds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get blacklistedSupplierIds => $composableBuilder(
    column: $table.blacklistedSupplierIds,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultMarkupPercent => $composableBuilder(
    column: $table.defaultMarkupPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchKeywords => $composableBuilder(
    column: $table.searchKeywords,
    builder: (column) => column,
  );
}

class $$UserRulesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserRulesTableTable,
          UserRulesRow,
          $$UserRulesTableTableFilterComposer,
          $$UserRulesTableTableOrderingComposer,
          $$UserRulesTableTableAnnotationComposer,
          $$UserRulesTableTableCreateCompanionBuilder,
          $$UserRulesTableTableUpdateCompanionBuilder,
          (
            UserRulesRow,
            BaseReferences<_$AppDatabase, $UserRulesTableTable, UserRulesRow>,
          ),
          UserRulesRow,
          PrefetchHooks Function()
        > {
  $$UserRulesTableTableTableManager(
    _$AppDatabase db,
    $UserRulesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserRulesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserRulesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserRulesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> minProfitPercent = const Value.absent(),
                Value<double?> maxSourcePrice = const Value.absent(),
                Value<String> preferredSupplierCountries = const Value.absent(),
                Value<bool> manualApprovalListings = const Value.absent(),
                Value<bool> manualApprovalOrders = const Value.absent(),
                Value<int> scanIntervalMinutes = const Value.absent(),
                Value<String> blacklistedProductIds = const Value.absent(),
                Value<String> blacklistedSupplierIds = const Value.absent(),
                Value<double> defaultMarkupPercent = const Value.absent(),
                Value<String> searchKeywords = const Value.absent(),
              }) => UserRulesTableCompanion(
                id: id,
                minProfitPercent: minProfitPercent,
                maxSourcePrice: maxSourcePrice,
                preferredSupplierCountries: preferredSupplierCountries,
                manualApprovalListings: manualApprovalListings,
                manualApprovalOrders: manualApprovalOrders,
                scanIntervalMinutes: scanIntervalMinutes,
                blacklistedProductIds: blacklistedProductIds,
                blacklistedSupplierIds: blacklistedSupplierIds,
                defaultMarkupPercent: defaultMarkupPercent,
                searchKeywords: searchKeywords,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double minProfitPercent,
                Value<double?> maxSourcePrice = const Value.absent(),
                required String preferredSupplierCountries,
                required bool manualApprovalListings,
                required bool manualApprovalOrders,
                required int scanIntervalMinutes,
                required String blacklistedProductIds,
                required String blacklistedSupplierIds,
                required double defaultMarkupPercent,
                required String searchKeywords,
              }) => UserRulesTableCompanion.insert(
                id: id,
                minProfitPercent: minProfitPercent,
                maxSourcePrice: maxSourcePrice,
                preferredSupplierCountries: preferredSupplierCountries,
                manualApprovalListings: manualApprovalListings,
                manualApprovalOrders: manualApprovalOrders,
                scanIntervalMinutes: scanIntervalMinutes,
                blacklistedProductIds: blacklistedProductIds,
                blacklistedSupplierIds: blacklistedSupplierIds,
                defaultMarkupPercent: defaultMarkupPercent,
                searchKeywords: searchKeywords,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserRulesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserRulesTableTable,
      UserRulesRow,
      $$UserRulesTableTableFilterComposer,
      $$UserRulesTableTableOrderingComposer,
      $$UserRulesTableTableAnnotationComposer,
      $$UserRulesTableTableCreateCompanionBuilder,
      $$UserRulesTableTableUpdateCompanionBuilder,
      (
        UserRulesRow,
        BaseReferences<_$AppDatabase, $UserRulesTableTable, UserRulesRow>,
      ),
      UserRulesRow,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      required String supplierId,
      required String name,
      required String platformType,
      Value<String?> countryCode,
      Value<double?> rating,
      Value<int?> returnWindowDays,
      Value<double?> returnShippingCost,
      Value<double?> restockingFeePercent,
      Value<bool> acceptsNoReasonReturns,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      Value<String> supplierId,
      Value<String> name,
      Value<String> platformType,
      Value<String?> countryCode,
      Value<double?> rating,
      Value<int?> returnWindowDays,
      Value<double?> returnShippingCost,
      Value<double?> restockingFeePercent,
      Value<bool> acceptsNoReasonReturns,
    });

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platformType => $composableBuilder(
    column: $table.platformType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get returnWindowDays => $composableBuilder(
    column: $table.returnWindowDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get returnShippingCost => $composableBuilder(
    column: $table.returnShippingCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get restockingFeePercent => $composableBuilder(
    column: $table.restockingFeePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get acceptsNoReasonReturns => $composableBuilder(
    column: $table.acceptsNoReasonReturns,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platformType => $composableBuilder(
    column: $table.platformType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get returnWindowDays => $composableBuilder(
    column: $table.returnWindowDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get returnShippingCost => $composableBuilder(
    column: $table.returnShippingCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get restockingFeePercent => $composableBuilder(
    column: $table.restockingFeePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get acceptsNoReasonReturns => $composableBuilder(
    column: $table.acceptsNoReasonReturns,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get platformType => $composableBuilder(
    column: $table.platformType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get returnWindowDays => $composableBuilder(
    column: $table.returnWindowDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get returnShippingCost => $composableBuilder(
    column: $table.returnShippingCost,
    builder: (column) => column,
  );

  GeneratedColumn<double> get restockingFeePercent => $composableBuilder(
    column: $table.restockingFeePercent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get acceptsNoReasonReturns => $composableBuilder(
    column: $table.acceptsNoReasonReturns,
    builder: (column) => column,
  );
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          SupplierRow,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (
            SupplierRow,
            BaseReferences<_$AppDatabase, $SuppliersTable, SupplierRow>,
          ),
          SupplierRow,
          PrefetchHooks Function()
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> platformType = const Value.absent(),
                Value<String?> countryCode = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<int?> returnWindowDays = const Value.absent(),
                Value<double?> returnShippingCost = const Value.absent(),
                Value<double?> restockingFeePercent = const Value.absent(),
                Value<bool> acceptsNoReasonReturns = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                supplierId: supplierId,
                name: name,
                platformType: platformType,
                countryCode: countryCode,
                rating: rating,
                returnWindowDays: returnWindowDays,
                returnShippingCost: returnShippingCost,
                restockingFeePercent: restockingFeePercent,
                acceptsNoReasonReturns: acceptsNoReasonReturns,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String supplierId,
                required String name,
                required String platformType,
                Value<String?> countryCode = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<int?> returnWindowDays = const Value.absent(),
                Value<double?> returnShippingCost = const Value.absent(),
                Value<double?> restockingFeePercent = const Value.absent(),
                Value<bool> acceptsNoReasonReturns = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                supplierId: supplierId,
                name: name,
                platformType: platformType,
                countryCode: countryCode,
                rating: rating,
                returnWindowDays: returnWindowDays,
                returnShippingCost: returnShippingCost,
                restockingFeePercent: restockingFeePercent,
                acceptsNoReasonReturns: acceptsNoReasonReturns,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      SupplierRow,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (
        SupplierRow,
        BaseReferences<_$AppDatabase, $SuppliersTable, SupplierRow>,
      ),
      SupplierRow,
      PrefetchHooks Function()
    >;
typedef $$SupplierOffersTableCreateCompanionBuilder =
    SupplierOffersCompanion Function({
      Value<int> id,
      required String offerId,
      required String productId,
      required String supplierId,
      required String sourcePlatformId,
      required double cost,
      Value<double?> shippingCost,
      Value<int?> minEstimatedDays,
      Value<int?> maxEstimatedDays,
      Value<String?> carrierCode,
      Value<String?> shippingMethodName,
      Value<DateTime?> lastPriceRefreshAt,
      Value<DateTime?> lastStockRefreshAt,
    });
typedef $$SupplierOffersTableUpdateCompanionBuilder =
    SupplierOffersCompanion Function({
      Value<int> id,
      Value<String> offerId,
      Value<String> productId,
      Value<String> supplierId,
      Value<String> sourcePlatformId,
      Value<double> cost,
      Value<double?> shippingCost,
      Value<int?> minEstimatedDays,
      Value<int?> maxEstimatedDays,
      Value<String?> carrierCode,
      Value<String?> shippingMethodName,
      Value<DateTime?> lastPriceRefreshAt,
      Value<DateTime?> lastStockRefreshAt,
    });

class $$SupplierOffersTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierOffersTable> {
  $$SupplierOffersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get offerId => $composableBuilder(
    column: $table.offerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shippingCost => $composableBuilder(
    column: $table.shippingCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minEstimatedDays => $composableBuilder(
    column: $table.minEstimatedDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxEstimatedDays => $composableBuilder(
    column: $table.maxEstimatedDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get carrierCode => $composableBuilder(
    column: $table.carrierCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shippingMethodName => $composableBuilder(
    column: $table.shippingMethodName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPriceRefreshAt => $composableBuilder(
    column: $table.lastPriceRefreshAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastStockRefreshAt => $composableBuilder(
    column: $table.lastStockRefreshAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupplierOffersTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierOffersTable> {
  $$SupplierOffersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get offerId => $composableBuilder(
    column: $table.offerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shippingCost => $composableBuilder(
    column: $table.shippingCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minEstimatedDays => $composableBuilder(
    column: $table.minEstimatedDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxEstimatedDays => $composableBuilder(
    column: $table.maxEstimatedDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carrierCode => $composableBuilder(
    column: $table.carrierCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shippingMethodName => $composableBuilder(
    column: $table.shippingMethodName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPriceRefreshAt => $composableBuilder(
    column: $table.lastPriceRefreshAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastStockRefreshAt => $composableBuilder(
    column: $table.lastStockRefreshAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupplierOffersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierOffersTable> {
  $$SupplierOffersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get offerId =>
      $composableBuilder(column: $table.offerId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<double> get shippingCost => $composableBuilder(
    column: $table.shippingCost,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minEstimatedDays => $composableBuilder(
    column: $table.minEstimatedDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxEstimatedDays => $composableBuilder(
    column: $table.maxEstimatedDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get carrierCode => $composableBuilder(
    column: $table.carrierCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shippingMethodName => $composableBuilder(
    column: $table.shippingMethodName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPriceRefreshAt => $composableBuilder(
    column: $table.lastPriceRefreshAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastStockRefreshAt => $composableBuilder(
    column: $table.lastStockRefreshAt,
    builder: (column) => column,
  );
}

class $$SupplierOffersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierOffersTable,
          SupplierOfferRow,
          $$SupplierOffersTableFilterComposer,
          $$SupplierOffersTableOrderingComposer,
          $$SupplierOffersTableAnnotationComposer,
          $$SupplierOffersTableCreateCompanionBuilder,
          $$SupplierOffersTableUpdateCompanionBuilder,
          (
            SupplierOfferRow,
            BaseReferences<
              _$AppDatabase,
              $SupplierOffersTable,
              SupplierOfferRow
            >,
          ),
          SupplierOfferRow,
          PrefetchHooks Function()
        > {
  $$SupplierOffersTableTableManager(
    _$AppDatabase db,
    $SupplierOffersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierOffersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplierOffersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SupplierOffersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> offerId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> sourcePlatformId = const Value.absent(),
                Value<double> cost = const Value.absent(),
                Value<double?> shippingCost = const Value.absent(),
                Value<int?> minEstimatedDays = const Value.absent(),
                Value<int?> maxEstimatedDays = const Value.absent(),
                Value<String?> carrierCode = const Value.absent(),
                Value<String?> shippingMethodName = const Value.absent(),
                Value<DateTime?> lastPriceRefreshAt = const Value.absent(),
                Value<DateTime?> lastStockRefreshAt = const Value.absent(),
              }) => SupplierOffersCompanion(
                id: id,
                offerId: offerId,
                productId: productId,
                supplierId: supplierId,
                sourcePlatformId: sourcePlatformId,
                cost: cost,
                shippingCost: shippingCost,
                minEstimatedDays: minEstimatedDays,
                maxEstimatedDays: maxEstimatedDays,
                carrierCode: carrierCode,
                shippingMethodName: shippingMethodName,
                lastPriceRefreshAt: lastPriceRefreshAt,
                lastStockRefreshAt: lastStockRefreshAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String offerId,
                required String productId,
                required String supplierId,
                required String sourcePlatformId,
                required double cost,
                Value<double?> shippingCost = const Value.absent(),
                Value<int?> minEstimatedDays = const Value.absent(),
                Value<int?> maxEstimatedDays = const Value.absent(),
                Value<String?> carrierCode = const Value.absent(),
                Value<String?> shippingMethodName = const Value.absent(),
                Value<DateTime?> lastPriceRefreshAt = const Value.absent(),
                Value<DateTime?> lastStockRefreshAt = const Value.absent(),
              }) => SupplierOffersCompanion.insert(
                id: id,
                offerId: offerId,
                productId: productId,
                supplierId: supplierId,
                sourcePlatformId: sourcePlatformId,
                cost: cost,
                shippingCost: shippingCost,
                minEstimatedDays: minEstimatedDays,
                maxEstimatedDays: maxEstimatedDays,
                carrierCode: carrierCode,
                shippingMethodName: shippingMethodName,
                lastPriceRefreshAt: lastPriceRefreshAt,
                lastStockRefreshAt: lastStockRefreshAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupplierOffersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierOffersTable,
      SupplierOfferRow,
      $$SupplierOffersTableFilterComposer,
      $$SupplierOffersTableOrderingComposer,
      $$SupplierOffersTableAnnotationComposer,
      $$SupplierOffersTableCreateCompanionBuilder,
      $$SupplierOffersTableUpdateCompanionBuilder,
      (
        SupplierOfferRow,
        BaseReferences<_$AppDatabase, $SupplierOffersTable, SupplierOfferRow>,
      ),
      SupplierOfferRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ListingsTableTableManager get listings =>
      $$ListingsTableTableManager(_db, _db.listings);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$DecisionLogsTableTableManager get decisionLogs =>
      $$DecisionLogsTableTableManager(_db, _db.decisionLogs);
  $$UserRulesTableTableTableManager get userRulesTable =>
      $$UserRulesTableTableTableManager(_db, _db.userRulesTable);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$SupplierOffersTableTableManager get supplierOffers =>
      $$SupplierOffersTableTableManager(_db, _db.supplierOffers);
}
