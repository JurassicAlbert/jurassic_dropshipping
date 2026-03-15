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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    tenantId,
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
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
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
  final int tenantId;
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
    required this.tenantId,
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
    map['tenant_id'] = Variable<int>(tenantId);
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
      tenantId: Value(tenantId),
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
      tenantId: serializer.fromJson<int>(json['tenantId']),
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
      'tenantId': serializer.toJson<int>(tenantId),
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
    int? tenantId,
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
    tenantId: tenantId ?? this.tenantId,
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
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
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
          ..write('tenantId: $tenantId, ')
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
    tenantId,
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
          other.tenantId == this.tenantId &&
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
  final Value<int> tenantId;
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
    this.tenantId = const Value.absent(),
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
    this.tenantId = const Value.absent(),
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
    Expression<int>? tenantId,
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
      if (tenantId != null) 'tenant_id': tenantId,
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
    Value<int>? tenantId,
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
      tenantId: tenantId ?? this.tenantId,
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
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
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
          ..write('tenantId: $tenantId, ')
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _marketplaceAccountIdMeta =
      const VerificationMeta('marketplaceAccountId');
  @override
  late final GeneratedColumn<String> marketplaceAccountId =
      GeneratedColumn<String>(
        'marketplace_account_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _promisedMinDaysMeta = const VerificationMeta(
    'promisedMinDays',
  );
  @override
  late final GeneratedColumn<int> promisedMinDays = GeneratedColumn<int>(
    'promised_min_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promisedMaxDaysMeta = const VerificationMeta(
    'promisedMaxDays',
  );
  @override
  late final GeneratedColumn<int> promisedMaxDays = GeneratedColumn<int>(
    'promised_max_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    localId,
    productId,
    targetPlatformId,
    targetListingId,
    status,
    sellingPrice,
    sourceCost,
    decisionLogId,
    marketplaceAccountId,
    promisedMinDays,
    promisedMaxDays,
    createdAt,
    publishedAt,
    variantId,
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
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
    if (data.containsKey('marketplace_account_id')) {
      context.handle(
        _marketplaceAccountIdMeta,
        marketplaceAccountId.isAcceptableOrUnknown(
          data['marketplace_account_id']!,
          _marketplaceAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('promised_min_days')) {
      context.handle(
        _promisedMinDaysMeta,
        promisedMinDays.isAcceptableOrUnknown(
          data['promised_min_days']!,
          _promisedMinDaysMeta,
        ),
      );
    }
    if (data.containsKey('promised_max_days')) {
      context.handle(
        _promisedMaxDaysMeta,
        promisedMaxDays.isAcceptableOrUnknown(
          data['promised_max_days']!,
          _promisedMaxDaysMeta,
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
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
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
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
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
      marketplaceAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marketplace_account_id'],
      ),
      promisedMinDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}promised_min_days'],
      ),
      promisedMaxDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}promised_max_days'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published_at'],
      ),
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
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
  final int tenantId;
  final String localId;
  final String productId;
  final String targetPlatformId;
  final String? targetListingId;
  final String status;
  final double sellingPrice;
  final double sourceCost;
  final String? decisionLogId;
  final String? marketplaceAccountId;
  final int? promisedMinDays;
  final int? promisedMaxDays;
  final DateTime createdAt;
  final DateTime? publishedAt;
  final String? variantId;
  const ListingRow({
    required this.id,
    required this.tenantId,
    required this.localId,
    required this.productId,
    required this.targetPlatformId,
    this.targetListingId,
    required this.status,
    required this.sellingPrice,
    required this.sourceCost,
    this.decisionLogId,
    this.marketplaceAccountId,
    this.promisedMinDays,
    this.promisedMaxDays,
    required this.createdAt,
    this.publishedAt,
    this.variantId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
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
    if (!nullToAbsent || marketplaceAccountId != null) {
      map['marketplace_account_id'] = Variable<String>(marketplaceAccountId);
    }
    if (!nullToAbsent || promisedMinDays != null) {
      map['promised_min_days'] = Variable<int>(promisedMinDays);
    }
    if (!nullToAbsent || promisedMaxDays != null) {
      map['promised_max_days'] = Variable<int>(promisedMaxDays);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    if (!nullToAbsent || variantId != null) {
      map['variant_id'] = Variable<String>(variantId);
    }
    return map;
  }

  ListingsCompanion toCompanion(bool nullToAbsent) {
    return ListingsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
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
      marketplaceAccountId: marketplaceAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(marketplaceAccountId),
      promisedMinDays: promisedMinDays == null && nullToAbsent
          ? const Value.absent()
          : Value(promisedMinDays),
      promisedMaxDays: promisedMaxDays == null && nullToAbsent
          ? const Value.absent()
          : Value(promisedMaxDays),
      createdAt: Value(createdAt),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      variantId: variantId == null && nullToAbsent
          ? const Value.absent()
          : Value(variantId),
    );
  }

  factory ListingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListingRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      localId: serializer.fromJson<String>(json['localId']),
      productId: serializer.fromJson<String>(json['productId']),
      targetPlatformId: serializer.fromJson<String>(json['targetPlatformId']),
      targetListingId: serializer.fromJson<String?>(json['targetListingId']),
      status: serializer.fromJson<String>(json['status']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      sourceCost: serializer.fromJson<double>(json['sourceCost']),
      decisionLogId: serializer.fromJson<String?>(json['decisionLogId']),
      marketplaceAccountId: serializer.fromJson<String?>(
        json['marketplaceAccountId'],
      ),
      promisedMinDays: serializer.fromJson<int?>(json['promisedMinDays']),
      promisedMaxDays: serializer.fromJson<int?>(json['promisedMaxDays']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      variantId: serializer.fromJson<String?>(json['variantId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'localId': serializer.toJson<String>(localId),
      'productId': serializer.toJson<String>(productId),
      'targetPlatformId': serializer.toJson<String>(targetPlatformId),
      'targetListingId': serializer.toJson<String?>(targetListingId),
      'status': serializer.toJson<String>(status),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'sourceCost': serializer.toJson<double>(sourceCost),
      'decisionLogId': serializer.toJson<String?>(decisionLogId),
      'marketplaceAccountId': serializer.toJson<String?>(marketplaceAccountId),
      'promisedMinDays': serializer.toJson<int?>(promisedMinDays),
      'promisedMaxDays': serializer.toJson<int?>(promisedMaxDays),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'variantId': serializer.toJson<String?>(variantId),
    };
  }

  ListingRow copyWith({
    int? id,
    int? tenantId,
    String? localId,
    String? productId,
    String? targetPlatformId,
    Value<String?> targetListingId = const Value.absent(),
    String? status,
    double? sellingPrice,
    double? sourceCost,
    Value<String?> decisionLogId = const Value.absent(),
    Value<String?> marketplaceAccountId = const Value.absent(),
    Value<int?> promisedMinDays = const Value.absent(),
    Value<int?> promisedMaxDays = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> publishedAt = const Value.absent(),
    Value<String?> variantId = const Value.absent(),
  }) => ListingRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
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
    marketplaceAccountId: marketplaceAccountId.present
        ? marketplaceAccountId.value
        : this.marketplaceAccountId,
    promisedMinDays: promisedMinDays.present
        ? promisedMinDays.value
        : this.promisedMinDays,
    promisedMaxDays: promisedMaxDays.present
        ? promisedMaxDays.value
        : this.promisedMaxDays,
    createdAt: createdAt ?? this.createdAt,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    variantId: variantId.present ? variantId.value : this.variantId,
  );
  ListingRow copyWithCompanion(ListingsCompanion data) {
    return ListingRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
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
      marketplaceAccountId: data.marketplaceAccountId.present
          ? data.marketplaceAccountId.value
          : this.marketplaceAccountId,
      promisedMinDays: data.promisedMinDays.present
          ? data.promisedMinDays.value
          : this.promisedMinDays,
      promisedMaxDays: data.promisedMaxDays.present
          ? data.promisedMaxDays.value
          : this.promisedMaxDays,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ListingRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('localId: $localId, ')
          ..write('productId: $productId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('targetListingId: $targetListingId, ')
          ..write('status: $status, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('sourceCost: $sourceCost, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('marketplaceAccountId: $marketplaceAccountId, ')
          ..write('promisedMinDays: $promisedMinDays, ')
          ..write('promisedMaxDays: $promisedMaxDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('variantId: $variantId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    localId,
    productId,
    targetPlatformId,
    targetListingId,
    status,
    sellingPrice,
    sourceCost,
    decisionLogId,
    marketplaceAccountId,
    promisedMinDays,
    promisedMaxDays,
    createdAt,
    publishedAt,
    variantId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListingRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.localId == this.localId &&
          other.productId == this.productId &&
          other.targetPlatformId == this.targetPlatformId &&
          other.targetListingId == this.targetListingId &&
          other.status == this.status &&
          other.sellingPrice == this.sellingPrice &&
          other.sourceCost == this.sourceCost &&
          other.decisionLogId == this.decisionLogId &&
          other.marketplaceAccountId == this.marketplaceAccountId &&
          other.promisedMinDays == this.promisedMinDays &&
          other.promisedMaxDays == this.promisedMaxDays &&
          other.createdAt == this.createdAt &&
          other.publishedAt == this.publishedAt &&
          other.variantId == this.variantId);
}

class ListingsCompanion extends UpdateCompanion<ListingRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> localId;
  final Value<String> productId;
  final Value<String> targetPlatformId;
  final Value<String?> targetListingId;
  final Value<String> status;
  final Value<double> sellingPrice;
  final Value<double> sourceCost;
  final Value<String?> decisionLogId;
  final Value<String?> marketplaceAccountId;
  final Value<int?> promisedMinDays;
  final Value<int?> promisedMaxDays;
  final Value<DateTime> createdAt;
  final Value<DateTime?> publishedAt;
  final Value<String?> variantId;
  const ListingsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.localId = const Value.absent(),
    this.productId = const Value.absent(),
    this.targetPlatformId = const Value.absent(),
    this.targetListingId = const Value.absent(),
    this.status = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.sourceCost = const Value.absent(),
    this.decisionLogId = const Value.absent(),
    this.marketplaceAccountId = const Value.absent(),
    this.promisedMinDays = const Value.absent(),
    this.promisedMaxDays = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.variantId = const Value.absent(),
  });
  ListingsCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String localId,
    required String productId,
    required String targetPlatformId,
    this.targetListingId = const Value.absent(),
    required String status,
    required double sellingPrice,
    required double sourceCost,
    this.decisionLogId = const Value.absent(),
    this.marketplaceAccountId = const Value.absent(),
    this.promisedMinDays = const Value.absent(),
    this.promisedMaxDays = const Value.absent(),
    required DateTime createdAt,
    this.publishedAt = const Value.absent(),
    this.variantId = const Value.absent(),
  }) : localId = Value(localId),
       productId = Value(productId),
       targetPlatformId = Value(targetPlatformId),
       status = Value(status),
       sellingPrice = Value(sellingPrice),
       sourceCost = Value(sourceCost),
       createdAt = Value(createdAt);
  static Insertable<ListingRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? localId,
    Expression<String>? productId,
    Expression<String>? targetPlatformId,
    Expression<String>? targetListingId,
    Expression<String>? status,
    Expression<double>? sellingPrice,
    Expression<double>? sourceCost,
    Expression<String>? decisionLogId,
    Expression<String>? marketplaceAccountId,
    Expression<int>? promisedMinDays,
    Expression<int>? promisedMaxDays,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? publishedAt,
    Expression<String>? variantId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (localId != null) 'local_id': localId,
      if (productId != null) 'product_id': productId,
      if (targetPlatformId != null) 'target_platform_id': targetPlatformId,
      if (targetListingId != null) 'target_listing_id': targetListingId,
      if (status != null) 'status': status,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (sourceCost != null) 'source_cost': sourceCost,
      if (decisionLogId != null) 'decision_log_id': decisionLogId,
      if (marketplaceAccountId != null)
        'marketplace_account_id': marketplaceAccountId,
      if (promisedMinDays != null) 'promised_min_days': promisedMinDays,
      if (promisedMaxDays != null) 'promised_max_days': promisedMaxDays,
      if (createdAt != null) 'created_at': createdAt,
      if (publishedAt != null) 'published_at': publishedAt,
      if (variantId != null) 'variant_id': variantId,
    });
  }

  ListingsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? localId,
    Value<String>? productId,
    Value<String>? targetPlatformId,
    Value<String?>? targetListingId,
    Value<String>? status,
    Value<double>? sellingPrice,
    Value<double>? sourceCost,
    Value<String?>? decisionLogId,
    Value<String?>? marketplaceAccountId,
    Value<int?>? promisedMinDays,
    Value<int?>? promisedMaxDays,
    Value<DateTime>? createdAt,
    Value<DateTime?>? publishedAt,
    Value<String?>? variantId,
  }) {
    return ListingsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      localId: localId ?? this.localId,
      productId: productId ?? this.productId,
      targetPlatformId: targetPlatformId ?? this.targetPlatformId,
      targetListingId: targetListingId ?? this.targetListingId,
      status: status ?? this.status,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      sourceCost: sourceCost ?? this.sourceCost,
      decisionLogId: decisionLogId ?? this.decisionLogId,
      marketplaceAccountId: marketplaceAccountId ?? this.marketplaceAccountId,
      promisedMinDays: promisedMinDays ?? this.promisedMinDays,
      promisedMaxDays: promisedMaxDays ?? this.promisedMaxDays,
      createdAt: createdAt ?? this.createdAt,
      publishedAt: publishedAt ?? this.publishedAt,
      variantId: variantId ?? this.variantId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
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
    if (marketplaceAccountId.present) {
      map['marketplace_account_id'] = Variable<String>(
        marketplaceAccountId.value,
      );
    }
    if (promisedMinDays.present) {
      map['promised_min_days'] = Variable<int>(promisedMinDays.value);
    }
    if (promisedMaxDays.present) {
      map['promised_max_days'] = Variable<int>(promisedMaxDays.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListingsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('localId: $localId, ')
          ..write('productId: $productId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('targetListingId: $targetListingId, ')
          ..write('status: $status, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('sourceCost: $sourceCost, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('marketplaceAccountId: $marketplaceAccountId, ')
          ..write('promisedMinDays: $promisedMinDays, ')
          ..write('promisedMaxDays: $promisedMaxDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('variantId: $variantId')
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _marketplaceAccountIdMeta =
      const VerificationMeta('marketplaceAccountId');
  @override
  late final GeneratedColumn<String> marketplaceAccountId =
      GeneratedColumn<String>(
        'marketplace_account_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _promisedDeliveryMinMeta =
      const VerificationMeta('promisedDeliveryMin');
  @override
  late final GeneratedColumn<DateTime> promisedDeliveryMin =
      GeneratedColumn<DateTime>(
        'promised_delivery_min',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _promisedDeliveryMaxMeta =
      const VerificationMeta('promisedDeliveryMax');
  @override
  late final GeneratedColumn<DateTime> promisedDeliveryMax =
      GeneratedColumn<DateTime>(
        'promised_delivery_max',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deliveredAtMeta = const VerificationMeta(
    'deliveredAt',
  );
  @override
  late final GeneratedColumn<DateTime> deliveredAt = GeneratedColumn<DateTime>(
    'delivered_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
  static const VerificationMeta _lifecycleStateMeta = const VerificationMeta(
    'lifecycleState',
  );
  @override
  late final GeneratedColumn<String> lifecycleState = GeneratedColumn<String>(
    'lifecycle_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _financialStateMeta = const VerificationMeta(
    'financialState',
  );
  @override
  late final GeneratedColumn<String> financialState = GeneratedColumn<String>(
    'financial_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _queuedForCapitalMeta = const VerificationMeta(
    'queuedForCapital',
  );
  @override
  late final GeneratedColumn<bool> queuedForCapital = GeneratedColumn<bool>(
    'queued_for_capital',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("queued_for_capital" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _riskScoreMeta = const VerificationMeta(
    'riskScore',
  );
  @override
  late final GeneratedColumn<double> riskScore = GeneratedColumn<double>(
    'risk_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _riskFactorsJsonMeta = const VerificationMeta(
    'riskFactorsJson',
  );
  @override
  late final GeneratedColumn<String> riskFactorsJson = GeneratedColumn<String>(
    'risk_factors_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    localId,
    listingId,
    targetOrderId,
    targetPlatformId,
    customerAddressJson,
    status,
    sourceOrderId,
    sourceCost,
    sellingPrice,
    quantity,
    trackingNumber,
    decisionLogId,
    marketplaceAccountId,
    promisedDeliveryMin,
    promisedDeliveryMax,
    deliveredAt,
    approvedAt,
    createdAt,
    lifecycleState,
    financialState,
    queuedForCapital,
    riskScore,
    riskFactorsJson,
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
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
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
    if (data.containsKey('marketplace_account_id')) {
      context.handle(
        _marketplaceAccountIdMeta,
        marketplaceAccountId.isAcceptableOrUnknown(
          data['marketplace_account_id']!,
          _marketplaceAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('promised_delivery_min')) {
      context.handle(
        _promisedDeliveryMinMeta,
        promisedDeliveryMin.isAcceptableOrUnknown(
          data['promised_delivery_min']!,
          _promisedDeliveryMinMeta,
        ),
      );
    }
    if (data.containsKey('promised_delivery_max')) {
      context.handle(
        _promisedDeliveryMaxMeta,
        promisedDeliveryMax.isAcceptableOrUnknown(
          data['promised_delivery_max']!,
          _promisedDeliveryMaxMeta,
        ),
      );
    }
    if (data.containsKey('delivered_at')) {
      context.handle(
        _deliveredAtMeta,
        deliveredAt.isAcceptableOrUnknown(
          data['delivered_at']!,
          _deliveredAtMeta,
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
    if (data.containsKey('lifecycle_state')) {
      context.handle(
        _lifecycleStateMeta,
        lifecycleState.isAcceptableOrUnknown(
          data['lifecycle_state']!,
          _lifecycleStateMeta,
        ),
      );
    }
    if (data.containsKey('financial_state')) {
      context.handle(
        _financialStateMeta,
        financialState.isAcceptableOrUnknown(
          data['financial_state']!,
          _financialStateMeta,
        ),
      );
    }
    if (data.containsKey('queued_for_capital')) {
      context.handle(
        _queuedForCapitalMeta,
        queuedForCapital.isAcceptableOrUnknown(
          data['queued_for_capital']!,
          _queuedForCapitalMeta,
        ),
      );
    }
    if (data.containsKey('risk_score')) {
      context.handle(
        _riskScoreMeta,
        riskScore.isAcceptableOrUnknown(data['risk_score']!, _riskScoreMeta),
      );
    }
    if (data.containsKey('risk_factors_json')) {
      context.handle(
        _riskFactorsJsonMeta,
        riskFactorsJson.isAcceptableOrUnknown(
          data['risk_factors_json']!,
          _riskFactorsJsonMeta,
        ),
      );
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
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
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
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      trackingNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tracking_number'],
      ),
      decisionLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision_log_id'],
      ),
      marketplaceAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marketplace_account_id'],
      ),
      promisedDeliveryMin: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}promised_delivery_min'],
      ),
      promisedDeliveryMax: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}promised_delivery_max'],
      ),
      deliveredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}delivered_at'],
      ),
      approvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}approved_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lifecycleState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lifecycle_state'],
      ),
      financialState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}financial_state'],
      ),
      queuedForCapital: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}queued_for_capital'],
      )!,
      riskScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}risk_score'],
      ),
      riskFactorsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_factors_json'],
      ),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class OrderRow extends DataClass implements Insertable<OrderRow> {
  final int id;
  final int tenantId;
  final String localId;
  final String listingId;
  final String targetOrderId;
  final String targetPlatformId;
  final String customerAddressJson;
  final String status;
  final String? sourceOrderId;
  final double sourceCost;
  final double sellingPrice;
  final int quantity;
  final String? trackingNumber;
  final String? decisionLogId;
  final String? marketplaceAccountId;
  final DateTime? promisedDeliveryMin;
  final DateTime? promisedDeliveryMax;
  final DateTime? deliveredAt;
  final DateTime? approvedAt;
  final DateTime createdAt;

  /// Post-order lifecycle state (created, approved, shipped, returnRequested, refunded, etc.). Nullable for backfill.
  final String? lifecycleState;

  /// Phase 14: financial state (unpaid, supplier_paid, marketplace_held, marketplace_released, refunded, loss). Nullable.
  final String? financialState;

  /// Phase 14: when true, order is waiting for capital before fulfillment.
  final bool queuedForCapital;

  /// Phase 16: risk score 0–100; null until evaluated.
  final double? riskScore;

  /// Phase 16: JSON array of factor names (e.g. highValue, newCustomer).
  final String? riskFactorsJson;
  const OrderRow({
    required this.id,
    required this.tenantId,
    required this.localId,
    required this.listingId,
    required this.targetOrderId,
    required this.targetPlatformId,
    required this.customerAddressJson,
    required this.status,
    this.sourceOrderId,
    required this.sourceCost,
    required this.sellingPrice,
    required this.quantity,
    this.trackingNumber,
    this.decisionLogId,
    this.marketplaceAccountId,
    this.promisedDeliveryMin,
    this.promisedDeliveryMax,
    this.deliveredAt,
    this.approvedAt,
    required this.createdAt,
    this.lifecycleState,
    this.financialState,
    required this.queuedForCapital,
    this.riskScore,
    this.riskFactorsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
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
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || trackingNumber != null) {
      map['tracking_number'] = Variable<String>(trackingNumber);
    }
    if (!nullToAbsent || decisionLogId != null) {
      map['decision_log_id'] = Variable<String>(decisionLogId);
    }
    if (!nullToAbsent || marketplaceAccountId != null) {
      map['marketplace_account_id'] = Variable<String>(marketplaceAccountId);
    }
    if (!nullToAbsent || promisedDeliveryMin != null) {
      map['promised_delivery_min'] = Variable<DateTime>(promisedDeliveryMin);
    }
    if (!nullToAbsent || promisedDeliveryMax != null) {
      map['promised_delivery_max'] = Variable<DateTime>(promisedDeliveryMax);
    }
    if (!nullToAbsent || deliveredAt != null) {
      map['delivered_at'] = Variable<DateTime>(deliveredAt);
    }
    if (!nullToAbsent || approvedAt != null) {
      map['approved_at'] = Variable<DateTime>(approvedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lifecycleState != null) {
      map['lifecycle_state'] = Variable<String>(lifecycleState);
    }
    if (!nullToAbsent || financialState != null) {
      map['financial_state'] = Variable<String>(financialState);
    }
    map['queued_for_capital'] = Variable<bool>(queuedForCapital);
    if (!nullToAbsent || riskScore != null) {
      map['risk_score'] = Variable<double>(riskScore);
    }
    if (!nullToAbsent || riskFactorsJson != null) {
      map['risk_factors_json'] = Variable<String>(riskFactorsJson);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
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
      quantity: Value(quantity),
      trackingNumber: trackingNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackingNumber),
      decisionLogId: decisionLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(decisionLogId),
      marketplaceAccountId: marketplaceAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(marketplaceAccountId),
      promisedDeliveryMin: promisedDeliveryMin == null && nullToAbsent
          ? const Value.absent()
          : Value(promisedDeliveryMin),
      promisedDeliveryMax: promisedDeliveryMax == null && nullToAbsent
          ? const Value.absent()
          : Value(promisedDeliveryMax),
      deliveredAt: deliveredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveredAt),
      approvedAt: approvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedAt),
      createdAt: Value(createdAt),
      lifecycleState: lifecycleState == null && nullToAbsent
          ? const Value.absent()
          : Value(lifecycleState),
      financialState: financialState == null && nullToAbsent
          ? const Value.absent()
          : Value(financialState),
      queuedForCapital: Value(queuedForCapital),
      riskScore: riskScore == null && nullToAbsent
          ? const Value.absent()
          : Value(riskScore),
      riskFactorsJson: riskFactorsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(riskFactorsJson),
    );
  }

  factory OrderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
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
      quantity: serializer.fromJson<int>(json['quantity']),
      trackingNumber: serializer.fromJson<String?>(json['trackingNumber']),
      decisionLogId: serializer.fromJson<String?>(json['decisionLogId']),
      marketplaceAccountId: serializer.fromJson<String?>(
        json['marketplaceAccountId'],
      ),
      promisedDeliveryMin: serializer.fromJson<DateTime?>(
        json['promisedDeliveryMin'],
      ),
      promisedDeliveryMax: serializer.fromJson<DateTime?>(
        json['promisedDeliveryMax'],
      ),
      deliveredAt: serializer.fromJson<DateTime?>(json['deliveredAt']),
      approvedAt: serializer.fromJson<DateTime?>(json['approvedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lifecycleState: serializer.fromJson<String?>(json['lifecycleState']),
      financialState: serializer.fromJson<String?>(json['financialState']),
      queuedForCapital: serializer.fromJson<bool>(json['queuedForCapital']),
      riskScore: serializer.fromJson<double?>(json['riskScore']),
      riskFactorsJson: serializer.fromJson<String?>(json['riskFactorsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'localId': serializer.toJson<String>(localId),
      'listingId': serializer.toJson<String>(listingId),
      'targetOrderId': serializer.toJson<String>(targetOrderId),
      'targetPlatformId': serializer.toJson<String>(targetPlatformId),
      'customerAddressJson': serializer.toJson<String>(customerAddressJson),
      'status': serializer.toJson<String>(status),
      'sourceOrderId': serializer.toJson<String?>(sourceOrderId),
      'sourceCost': serializer.toJson<double>(sourceCost),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'quantity': serializer.toJson<int>(quantity),
      'trackingNumber': serializer.toJson<String?>(trackingNumber),
      'decisionLogId': serializer.toJson<String?>(decisionLogId),
      'marketplaceAccountId': serializer.toJson<String?>(marketplaceAccountId),
      'promisedDeliveryMin': serializer.toJson<DateTime?>(promisedDeliveryMin),
      'promisedDeliveryMax': serializer.toJson<DateTime?>(promisedDeliveryMax),
      'deliveredAt': serializer.toJson<DateTime?>(deliveredAt),
      'approvedAt': serializer.toJson<DateTime?>(approvedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lifecycleState': serializer.toJson<String?>(lifecycleState),
      'financialState': serializer.toJson<String?>(financialState),
      'queuedForCapital': serializer.toJson<bool>(queuedForCapital),
      'riskScore': serializer.toJson<double?>(riskScore),
      'riskFactorsJson': serializer.toJson<String?>(riskFactorsJson),
    };
  }

  OrderRow copyWith({
    int? id,
    int? tenantId,
    String? localId,
    String? listingId,
    String? targetOrderId,
    String? targetPlatformId,
    String? customerAddressJson,
    String? status,
    Value<String?> sourceOrderId = const Value.absent(),
    double? sourceCost,
    double? sellingPrice,
    int? quantity,
    Value<String?> trackingNumber = const Value.absent(),
    Value<String?> decisionLogId = const Value.absent(),
    Value<String?> marketplaceAccountId = const Value.absent(),
    Value<DateTime?> promisedDeliveryMin = const Value.absent(),
    Value<DateTime?> promisedDeliveryMax = const Value.absent(),
    Value<DateTime?> deliveredAt = const Value.absent(),
    Value<DateTime?> approvedAt = const Value.absent(),
    DateTime? createdAt,
    Value<String?> lifecycleState = const Value.absent(),
    Value<String?> financialState = const Value.absent(),
    bool? queuedForCapital,
    Value<double?> riskScore = const Value.absent(),
    Value<String?> riskFactorsJson = const Value.absent(),
  }) => OrderRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
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
    quantity: quantity ?? this.quantity,
    trackingNumber: trackingNumber.present
        ? trackingNumber.value
        : this.trackingNumber,
    decisionLogId: decisionLogId.present
        ? decisionLogId.value
        : this.decisionLogId,
    marketplaceAccountId: marketplaceAccountId.present
        ? marketplaceAccountId.value
        : this.marketplaceAccountId,
    promisedDeliveryMin: promisedDeliveryMin.present
        ? promisedDeliveryMin.value
        : this.promisedDeliveryMin,
    promisedDeliveryMax: promisedDeliveryMax.present
        ? promisedDeliveryMax.value
        : this.promisedDeliveryMax,
    deliveredAt: deliveredAt.present ? deliveredAt.value : this.deliveredAt,
    approvedAt: approvedAt.present ? approvedAt.value : this.approvedAt,
    createdAt: createdAt ?? this.createdAt,
    lifecycleState: lifecycleState.present
        ? lifecycleState.value
        : this.lifecycleState,
    financialState: financialState.present
        ? financialState.value
        : this.financialState,
    queuedForCapital: queuedForCapital ?? this.queuedForCapital,
    riskScore: riskScore.present ? riskScore.value : this.riskScore,
    riskFactorsJson: riskFactorsJson.present
        ? riskFactorsJson.value
        : this.riskFactorsJson,
  );
  OrderRow copyWithCompanion(OrdersCompanion data) {
    return OrderRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
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
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      trackingNumber: data.trackingNumber.present
          ? data.trackingNumber.value
          : this.trackingNumber,
      decisionLogId: data.decisionLogId.present
          ? data.decisionLogId.value
          : this.decisionLogId,
      marketplaceAccountId: data.marketplaceAccountId.present
          ? data.marketplaceAccountId.value
          : this.marketplaceAccountId,
      promisedDeliveryMin: data.promisedDeliveryMin.present
          ? data.promisedDeliveryMin.value
          : this.promisedDeliveryMin,
      promisedDeliveryMax: data.promisedDeliveryMax.present
          ? data.promisedDeliveryMax.value
          : this.promisedDeliveryMax,
      deliveredAt: data.deliveredAt.present
          ? data.deliveredAt.value
          : this.deliveredAt,
      approvedAt: data.approvedAt.present
          ? data.approvedAt.value
          : this.approvedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lifecycleState: data.lifecycleState.present
          ? data.lifecycleState.value
          : this.lifecycleState,
      financialState: data.financialState.present
          ? data.financialState.value
          : this.financialState,
      queuedForCapital: data.queuedForCapital.present
          ? data.queuedForCapital.value
          : this.queuedForCapital,
      riskScore: data.riskScore.present ? data.riskScore.value : this.riskScore,
      riskFactorsJson: data.riskFactorsJson.present
          ? data.riskFactorsJson.value
          : this.riskFactorsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('localId: $localId, ')
          ..write('listingId: $listingId, ')
          ..write('targetOrderId: $targetOrderId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('customerAddressJson: $customerAddressJson, ')
          ..write('status: $status, ')
          ..write('sourceOrderId: $sourceOrderId, ')
          ..write('sourceCost: $sourceCost, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('marketplaceAccountId: $marketplaceAccountId, ')
          ..write('promisedDeliveryMin: $promisedDeliveryMin, ')
          ..write('promisedDeliveryMax: $promisedDeliveryMax, ')
          ..write('deliveredAt: $deliveredAt, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('lifecycleState: $lifecycleState, ')
          ..write('financialState: $financialState, ')
          ..write('queuedForCapital: $queuedForCapital, ')
          ..write('riskScore: $riskScore, ')
          ..write('riskFactorsJson: $riskFactorsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    tenantId,
    localId,
    listingId,
    targetOrderId,
    targetPlatformId,
    customerAddressJson,
    status,
    sourceOrderId,
    sourceCost,
    sellingPrice,
    quantity,
    trackingNumber,
    decisionLogId,
    marketplaceAccountId,
    promisedDeliveryMin,
    promisedDeliveryMax,
    deliveredAt,
    approvedAt,
    createdAt,
    lifecycleState,
    financialState,
    queuedForCapital,
    riskScore,
    riskFactorsJson,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.localId == this.localId &&
          other.listingId == this.listingId &&
          other.targetOrderId == this.targetOrderId &&
          other.targetPlatformId == this.targetPlatformId &&
          other.customerAddressJson == this.customerAddressJson &&
          other.status == this.status &&
          other.sourceOrderId == this.sourceOrderId &&
          other.sourceCost == this.sourceCost &&
          other.sellingPrice == this.sellingPrice &&
          other.quantity == this.quantity &&
          other.trackingNumber == this.trackingNumber &&
          other.decisionLogId == this.decisionLogId &&
          other.marketplaceAccountId == this.marketplaceAccountId &&
          other.promisedDeliveryMin == this.promisedDeliveryMin &&
          other.promisedDeliveryMax == this.promisedDeliveryMax &&
          other.deliveredAt == this.deliveredAt &&
          other.approvedAt == this.approvedAt &&
          other.createdAt == this.createdAt &&
          other.lifecycleState == this.lifecycleState &&
          other.financialState == this.financialState &&
          other.queuedForCapital == this.queuedForCapital &&
          other.riskScore == this.riskScore &&
          other.riskFactorsJson == this.riskFactorsJson);
}

class OrdersCompanion extends UpdateCompanion<OrderRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> localId;
  final Value<String> listingId;
  final Value<String> targetOrderId;
  final Value<String> targetPlatformId;
  final Value<String> customerAddressJson;
  final Value<String> status;
  final Value<String?> sourceOrderId;
  final Value<double> sourceCost;
  final Value<double> sellingPrice;
  final Value<int> quantity;
  final Value<String?> trackingNumber;
  final Value<String?> decisionLogId;
  final Value<String?> marketplaceAccountId;
  final Value<DateTime?> promisedDeliveryMin;
  final Value<DateTime?> promisedDeliveryMax;
  final Value<DateTime?> deliveredAt;
  final Value<DateTime?> approvedAt;
  final Value<DateTime> createdAt;
  final Value<String?> lifecycleState;
  final Value<String?> financialState;
  final Value<bool> queuedForCapital;
  final Value<double?> riskScore;
  final Value<String?> riskFactorsJson;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.localId = const Value.absent(),
    this.listingId = const Value.absent(),
    this.targetOrderId = const Value.absent(),
    this.targetPlatformId = const Value.absent(),
    this.customerAddressJson = const Value.absent(),
    this.status = const Value.absent(),
    this.sourceOrderId = const Value.absent(),
    this.sourceCost = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.decisionLogId = const Value.absent(),
    this.marketplaceAccountId = const Value.absent(),
    this.promisedDeliveryMin = const Value.absent(),
    this.promisedDeliveryMax = const Value.absent(),
    this.deliveredAt = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lifecycleState = const Value.absent(),
    this.financialState = const Value.absent(),
    this.queuedForCapital = const Value.absent(),
    this.riskScore = const Value.absent(),
    this.riskFactorsJson = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String localId,
    required String listingId,
    required String targetOrderId,
    required String targetPlatformId,
    required String customerAddressJson,
    required String status,
    this.sourceOrderId = const Value.absent(),
    required double sourceCost,
    required double sellingPrice,
    this.quantity = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.decisionLogId = const Value.absent(),
    this.marketplaceAccountId = const Value.absent(),
    this.promisedDeliveryMin = const Value.absent(),
    this.promisedDeliveryMax = const Value.absent(),
    this.deliveredAt = const Value.absent(),
    this.approvedAt = const Value.absent(),
    required DateTime createdAt,
    this.lifecycleState = const Value.absent(),
    this.financialState = const Value.absent(),
    this.queuedForCapital = const Value.absent(),
    this.riskScore = const Value.absent(),
    this.riskFactorsJson = const Value.absent(),
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
    Expression<int>? tenantId,
    Expression<String>? localId,
    Expression<String>? listingId,
    Expression<String>? targetOrderId,
    Expression<String>? targetPlatformId,
    Expression<String>? customerAddressJson,
    Expression<String>? status,
    Expression<String>? sourceOrderId,
    Expression<double>? sourceCost,
    Expression<double>? sellingPrice,
    Expression<int>? quantity,
    Expression<String>? trackingNumber,
    Expression<String>? decisionLogId,
    Expression<String>? marketplaceAccountId,
    Expression<DateTime>? promisedDeliveryMin,
    Expression<DateTime>? promisedDeliveryMax,
    Expression<DateTime>? deliveredAt,
    Expression<DateTime>? approvedAt,
    Expression<DateTime>? createdAt,
    Expression<String>? lifecycleState,
    Expression<String>? financialState,
    Expression<bool>? queuedForCapital,
    Expression<double>? riskScore,
    Expression<String>? riskFactorsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
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
      if (quantity != null) 'quantity': quantity,
      if (trackingNumber != null) 'tracking_number': trackingNumber,
      if (decisionLogId != null) 'decision_log_id': decisionLogId,
      if (marketplaceAccountId != null)
        'marketplace_account_id': marketplaceAccountId,
      if (promisedDeliveryMin != null)
        'promised_delivery_min': promisedDeliveryMin,
      if (promisedDeliveryMax != null)
        'promised_delivery_max': promisedDeliveryMax,
      if (deliveredAt != null) 'delivered_at': deliveredAt,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (lifecycleState != null) 'lifecycle_state': lifecycleState,
      if (financialState != null) 'financial_state': financialState,
      if (queuedForCapital != null) 'queued_for_capital': queuedForCapital,
      if (riskScore != null) 'risk_score': riskScore,
      if (riskFactorsJson != null) 'risk_factors_json': riskFactorsJson,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? localId,
    Value<String>? listingId,
    Value<String>? targetOrderId,
    Value<String>? targetPlatformId,
    Value<String>? customerAddressJson,
    Value<String>? status,
    Value<String?>? sourceOrderId,
    Value<double>? sourceCost,
    Value<double>? sellingPrice,
    Value<int>? quantity,
    Value<String?>? trackingNumber,
    Value<String?>? decisionLogId,
    Value<String?>? marketplaceAccountId,
    Value<DateTime?>? promisedDeliveryMin,
    Value<DateTime?>? promisedDeliveryMax,
    Value<DateTime?>? deliveredAt,
    Value<DateTime?>? approvedAt,
    Value<DateTime>? createdAt,
    Value<String?>? lifecycleState,
    Value<String?>? financialState,
    Value<bool>? queuedForCapital,
    Value<double?>? riskScore,
    Value<String?>? riskFactorsJson,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      localId: localId ?? this.localId,
      listingId: listingId ?? this.listingId,
      targetOrderId: targetOrderId ?? this.targetOrderId,
      targetPlatformId: targetPlatformId ?? this.targetPlatformId,
      customerAddressJson: customerAddressJson ?? this.customerAddressJson,
      status: status ?? this.status,
      sourceOrderId: sourceOrderId ?? this.sourceOrderId,
      sourceCost: sourceCost ?? this.sourceCost,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      decisionLogId: decisionLogId ?? this.decisionLogId,
      marketplaceAccountId: marketplaceAccountId ?? this.marketplaceAccountId,
      promisedDeliveryMin: promisedDeliveryMin ?? this.promisedDeliveryMin,
      promisedDeliveryMax: promisedDeliveryMax ?? this.promisedDeliveryMax,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      approvedAt: approvedAt ?? this.approvedAt,
      createdAt: createdAt ?? this.createdAt,
      lifecycleState: lifecycleState ?? this.lifecycleState,
      financialState: financialState ?? this.financialState,
      queuedForCapital: queuedForCapital ?? this.queuedForCapital,
      riskScore: riskScore ?? this.riskScore,
      riskFactorsJson: riskFactorsJson ?? this.riskFactorsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
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
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (trackingNumber.present) {
      map['tracking_number'] = Variable<String>(trackingNumber.value);
    }
    if (decisionLogId.present) {
      map['decision_log_id'] = Variable<String>(decisionLogId.value);
    }
    if (marketplaceAccountId.present) {
      map['marketplace_account_id'] = Variable<String>(
        marketplaceAccountId.value,
      );
    }
    if (promisedDeliveryMin.present) {
      map['promised_delivery_min'] = Variable<DateTime>(
        promisedDeliveryMin.value,
      );
    }
    if (promisedDeliveryMax.present) {
      map['promised_delivery_max'] = Variable<DateTime>(
        promisedDeliveryMax.value,
      );
    }
    if (deliveredAt.present) {
      map['delivered_at'] = Variable<DateTime>(deliveredAt.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lifecycleState.present) {
      map['lifecycle_state'] = Variable<String>(lifecycleState.value);
    }
    if (financialState.present) {
      map['financial_state'] = Variable<String>(financialState.value);
    }
    if (queuedForCapital.present) {
      map['queued_for_capital'] = Variable<bool>(queuedForCapital.value);
    }
    if (riskScore.present) {
      map['risk_score'] = Variable<double>(riskScore.value);
    }
    if (riskFactorsJson.present) {
      map['risk_factors_json'] = Variable<String>(riskFactorsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('localId: $localId, ')
          ..write('listingId: $listingId, ')
          ..write('targetOrderId: $targetOrderId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('customerAddressJson: $customerAddressJson, ')
          ..write('status: $status, ')
          ..write('sourceOrderId: $sourceOrderId, ')
          ..write('sourceCost: $sourceCost, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('marketplaceAccountId: $marketplaceAccountId, ')
          ..write('promisedDeliveryMin: $promisedDeliveryMin, ')
          ..write('promisedDeliveryMax: $promisedDeliveryMax, ')
          ..write('deliveredAt: $deliveredAt, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('lifecycleState: $lifecycleState, ')
          ..write('financialState: $financialState, ')
          ..write('queuedForCapital: $queuedForCapital, ')
          ..write('riskScore: $riskScore, ')
          ..write('riskFactorsJson: $riskFactorsJson')
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _incidentTypeMeta = const VerificationMeta(
    'incidentType',
  );
  @override
  late final GeneratedColumn<String> incidentType = GeneratedColumn<String>(
    'incident_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _financialImpactMeta = const VerificationMeta(
    'financialImpact',
  );
  @override
  late final GeneratedColumn<double> financialImpact = GeneratedColumn<double>(
    'financial_impact',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    localId,
    type,
    entityId,
    reason,
    criteriaSnapshot,
    createdAt,
    incidentType,
    financialImpact,
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
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
    if (data.containsKey('incident_type')) {
      context.handle(
        _incidentTypeMeta,
        incidentType.isAcceptableOrUnknown(
          data['incident_type']!,
          _incidentTypeMeta,
        ),
      );
    }
    if (data.containsKey('financial_impact')) {
      context.handle(
        _financialImpactMeta,
        financialImpact.isAcceptableOrUnknown(
          data['financial_impact']!,
          _financialImpactMeta,
        ),
      );
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
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
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
      incidentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}incident_type'],
      ),
      financialImpact: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}financial_impact'],
      ),
    );
  }

  @override
  $DecisionLogsTable createAlias(String alias) {
    return $DecisionLogsTable(attachedDatabase, alias);
  }
}

class DecisionLogRow extends DataClass implements Insertable<DecisionLogRow> {
  final int id;
  final int tenantId;
  final String localId;
  final String type;
  final String entityId;
  final String reason;
  final String? criteriaSnapshot;
  final DateTime createdAt;

  /// For incident decisions: type (e.g. damage_claim, non_collected).
  final String? incidentType;

  /// For incident decisions: total cost impact (refund + shipping + fees).
  final double? financialImpact;
  const DecisionLogRow({
    required this.id,
    required this.tenantId,
    required this.localId,
    required this.type,
    required this.entityId,
    required this.reason,
    this.criteriaSnapshot,
    required this.createdAt,
    this.incidentType,
    this.financialImpact,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['local_id'] = Variable<String>(localId);
    map['type'] = Variable<String>(type);
    map['entity_id'] = Variable<String>(entityId);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || criteriaSnapshot != null) {
      map['criteria_snapshot'] = Variable<String>(criteriaSnapshot);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || incidentType != null) {
      map['incident_type'] = Variable<String>(incidentType);
    }
    if (!nullToAbsent || financialImpact != null) {
      map['financial_impact'] = Variable<double>(financialImpact);
    }
    return map;
  }

  DecisionLogsCompanion toCompanion(bool nullToAbsent) {
    return DecisionLogsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      localId: Value(localId),
      type: Value(type),
      entityId: Value(entityId),
      reason: Value(reason),
      criteriaSnapshot: criteriaSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(criteriaSnapshot),
      createdAt: Value(createdAt),
      incidentType: incidentType == null && nullToAbsent
          ? const Value.absent()
          : Value(incidentType),
      financialImpact: financialImpact == null && nullToAbsent
          ? const Value.absent()
          : Value(financialImpact),
    );
  }

  factory DecisionLogRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DecisionLogRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      localId: serializer.fromJson<String>(json['localId']),
      type: serializer.fromJson<String>(json['type']),
      entityId: serializer.fromJson<String>(json['entityId']),
      reason: serializer.fromJson<String>(json['reason']),
      criteriaSnapshot: serializer.fromJson<String?>(json['criteriaSnapshot']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      incidentType: serializer.fromJson<String?>(json['incidentType']),
      financialImpact: serializer.fromJson<double?>(json['financialImpact']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'localId': serializer.toJson<String>(localId),
      'type': serializer.toJson<String>(type),
      'entityId': serializer.toJson<String>(entityId),
      'reason': serializer.toJson<String>(reason),
      'criteriaSnapshot': serializer.toJson<String?>(criteriaSnapshot),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'incidentType': serializer.toJson<String?>(incidentType),
      'financialImpact': serializer.toJson<double?>(financialImpact),
    };
  }

  DecisionLogRow copyWith({
    int? id,
    int? tenantId,
    String? localId,
    String? type,
    String? entityId,
    String? reason,
    Value<String?> criteriaSnapshot = const Value.absent(),
    DateTime? createdAt,
    Value<String?> incidentType = const Value.absent(),
    Value<double?> financialImpact = const Value.absent(),
  }) => DecisionLogRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    localId: localId ?? this.localId,
    type: type ?? this.type,
    entityId: entityId ?? this.entityId,
    reason: reason ?? this.reason,
    criteriaSnapshot: criteriaSnapshot.present
        ? criteriaSnapshot.value
        : this.criteriaSnapshot,
    createdAt: createdAt ?? this.createdAt,
    incidentType: incidentType.present ? incidentType.value : this.incidentType,
    financialImpact: financialImpact.present
        ? financialImpact.value
        : this.financialImpact,
  );
  DecisionLogRow copyWithCompanion(DecisionLogsCompanion data) {
    return DecisionLogRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      localId: data.localId.present ? data.localId.value : this.localId,
      type: data.type.present ? data.type.value : this.type,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      reason: data.reason.present ? data.reason.value : this.reason,
      criteriaSnapshot: data.criteriaSnapshot.present
          ? data.criteriaSnapshot.value
          : this.criteriaSnapshot,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      incidentType: data.incidentType.present
          ? data.incidentType.value
          : this.incidentType,
      financialImpact: data.financialImpact.present
          ? data.financialImpact.value
          : this.financialImpact,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DecisionLogRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('localId: $localId, ')
          ..write('type: $type, ')
          ..write('entityId: $entityId, ')
          ..write('reason: $reason, ')
          ..write('criteriaSnapshot: $criteriaSnapshot, ')
          ..write('createdAt: $createdAt, ')
          ..write('incidentType: $incidentType, ')
          ..write('financialImpact: $financialImpact')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    localId,
    type,
    entityId,
    reason,
    criteriaSnapshot,
    createdAt,
    incidentType,
    financialImpact,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DecisionLogRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.localId == this.localId &&
          other.type == this.type &&
          other.entityId == this.entityId &&
          other.reason == this.reason &&
          other.criteriaSnapshot == this.criteriaSnapshot &&
          other.createdAt == this.createdAt &&
          other.incidentType == this.incidentType &&
          other.financialImpact == this.financialImpact);
}

class DecisionLogsCompanion extends UpdateCompanion<DecisionLogRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> localId;
  final Value<String> type;
  final Value<String> entityId;
  final Value<String> reason;
  final Value<String?> criteriaSnapshot;
  final Value<DateTime> createdAt;
  final Value<String?> incidentType;
  final Value<double?> financialImpact;
  const DecisionLogsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.localId = const Value.absent(),
    this.type = const Value.absent(),
    this.entityId = const Value.absent(),
    this.reason = const Value.absent(),
    this.criteriaSnapshot = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.incidentType = const Value.absent(),
    this.financialImpact = const Value.absent(),
  });
  DecisionLogsCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String localId,
    required String type,
    required String entityId,
    required String reason,
    this.criteriaSnapshot = const Value.absent(),
    required DateTime createdAt,
    this.incidentType = const Value.absent(),
    this.financialImpact = const Value.absent(),
  }) : localId = Value(localId),
       type = Value(type),
       entityId = Value(entityId),
       reason = Value(reason),
       createdAt = Value(createdAt);
  static Insertable<DecisionLogRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? localId,
    Expression<String>? type,
    Expression<String>? entityId,
    Expression<String>? reason,
    Expression<String>? criteriaSnapshot,
    Expression<DateTime>? createdAt,
    Expression<String>? incidentType,
    Expression<double>? financialImpact,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (localId != null) 'local_id': localId,
      if (type != null) 'type': type,
      if (entityId != null) 'entity_id': entityId,
      if (reason != null) 'reason': reason,
      if (criteriaSnapshot != null) 'criteria_snapshot': criteriaSnapshot,
      if (createdAt != null) 'created_at': createdAt,
      if (incidentType != null) 'incident_type': incidentType,
      if (financialImpact != null) 'financial_impact': financialImpact,
    });
  }

  DecisionLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? localId,
    Value<String>? type,
    Value<String>? entityId,
    Value<String>? reason,
    Value<String?>? criteriaSnapshot,
    Value<DateTime>? createdAt,
    Value<String?>? incidentType,
    Value<double?>? financialImpact,
  }) {
    return DecisionLogsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      localId: localId ?? this.localId,
      type: type ?? this.type,
      entityId: entityId ?? this.entityId,
      reason: reason ?? this.reason,
      criteriaSnapshot: criteriaSnapshot ?? this.criteriaSnapshot,
      createdAt: createdAt ?? this.createdAt,
      incidentType: incidentType ?? this.incidentType,
      financialImpact: financialImpact ?? this.financialImpact,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
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
    if (incidentType.present) {
      map['incident_type'] = Variable<String>(incidentType.value);
    }
    if (financialImpact.present) {
      map['financial_impact'] = Variable<double>(financialImpact.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecisionLogsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('localId: $localId, ')
          ..write('type: $type, ')
          ..write('entityId: $entityId, ')
          ..write('reason: $reason, ')
          ..write('criteriaSnapshot: $criteriaSnapshot, ')
          ..write('createdAt: $createdAt, ')
          ..write('incidentType: $incidentType, ')
          ..write('financialImpact: $financialImpact')
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _marketplaceFeesJsonMeta =
      const VerificationMeta('marketplaceFeesJson');
  @override
  late final GeneratedColumn<String> marketplaceFeesJson =
      GeneratedColumn<String>(
        'marketplace_fees_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _paymentFeesJsonMeta = const VerificationMeta(
    'paymentFeesJson',
  );
  @override
  late final GeneratedColumn<String> paymentFeesJson = GeneratedColumn<String>(
    'payment_fees_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _sellerReturnAddressJsonMeta =
      const VerificationMeta('sellerReturnAddressJson');
  @override
  late final GeneratedColumn<String> sellerReturnAddressJson =
      GeneratedColumn<String>(
        'seller_return_address_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _marketplaceReturnPolicyJsonMeta =
      const VerificationMeta('marketplaceReturnPolicyJson');
  @override
  late final GeneratedColumn<String> marketplaceReturnPolicyJson =
      GeneratedColumn<String>(
        'marketplace_return_policy_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _targetsReadOnlyMeta = const VerificationMeta(
    'targetsReadOnly',
  );
  @override
  late final GeneratedColumn<bool> targetsReadOnly = GeneratedColumn<bool>(
    'targets_read_only',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("targets_read_only" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _pricingStrategyMeta = const VerificationMeta(
    'pricingStrategy',
  );
  @override
  late final GeneratedColumn<String> pricingStrategy = GeneratedColumn<String>(
    'pricing_strategy',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('always_below_lowest'),
  );
  static const VerificationMeta _categoryMinProfitPercentJsonMeta =
      const VerificationMeta('categoryMinProfitPercentJson');
  @override
  late final GeneratedColumn<String> categoryMinProfitPercentJson =
      GeneratedColumn<String>(
        'category_min_profit_percent_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _premiumWhenBetterReviewsPercentMeta =
      const VerificationMeta('premiumWhenBetterReviewsPercent');
  @override
  late final GeneratedColumn<double> premiumWhenBetterReviewsPercent =
      GeneratedColumn<double>(
        'premium_when_better_reviews_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(2.0),
      );
  static const VerificationMeta _minSalesCountForPremiumMeta =
      const VerificationMeta('minSalesCountForPremium');
  @override
  late final GeneratedColumn<int> minSalesCountForPremium =
      GeneratedColumn<int>(
        'min_sales_count_for_premium',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(10),
      );
  static const VerificationMeta _kpiDrivenStrategyEnabledMeta =
      const VerificationMeta('kpiDrivenStrategyEnabled');
  @override
  late final GeneratedColumn<bool> kpiDrivenStrategyEnabled =
      GeneratedColumn<bool>(
        'kpi_driven_strategy_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("kpi_driven_strategy_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _rateLimitMaxRequestsPerSecondJsonMeta =
      const VerificationMeta('rateLimitMaxRequestsPerSecondJson');
  @override
  late final GeneratedColumn<String> rateLimitMaxRequestsPerSecondJson =
      GeneratedColumn<String>(
        'rate_limit_max_requests_per_second_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _incidentRulesJsonMeta = const VerificationMeta(
    'incidentRulesJson',
  );
  @override
  late final GeneratedColumn<String> incidentRulesJson =
      GeneratedColumn<String>(
        'incident_rules_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _riskScoreThresholdMeta =
      const VerificationMeta('riskScoreThreshold');
  @override
  late final GeneratedColumn<double> riskScoreThreshold =
      GeneratedColumn<double>(
        'risk_score_threshold',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _defaultReturnRatePercentMeta =
      const VerificationMeta('defaultReturnRatePercent');
  @override
  late final GeneratedColumn<double> defaultReturnRatePercent =
      GeneratedColumn<double>(
        'default_return_rate_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _defaultReturnCostPerUnitMeta =
      const VerificationMeta('defaultReturnCostPerUnit');
  @override
  late final GeneratedColumn<double> defaultReturnCostPerUnit =
      GeneratedColumn<double>(
        'default_return_cost_per_unit',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _blockFulfillWhenInsufficientStockMeta =
      const VerificationMeta('blockFulfillWhenInsufficientStock');
  @override
  late final GeneratedColumn<bool> blockFulfillWhenInsufficientStock =
      GeneratedColumn<bool>(
        'block_fulfill_when_insufficient_stock',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("block_fulfill_when_insufficient_stock" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _autoPauseListingWhenMarginBelowThresholdMeta =
      const VerificationMeta('autoPauseListingWhenMarginBelowThreshold');
  @override
  late final GeneratedColumn<bool> autoPauseListingWhenMarginBelowThreshold =
      GeneratedColumn<bool>(
        'auto_pause_listing_when_margin_below_threshold',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("auto_pause_listing_when_margin_below_threshold" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _defaultSupplierProcessingDaysMeta =
      const VerificationMeta('defaultSupplierProcessingDays');
  @override
  late final GeneratedColumn<int> defaultSupplierProcessingDays =
      GeneratedColumn<int>(
        'default_supplier_processing_days',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(2),
      );
  static const VerificationMeta _defaultSupplierShippingDaysMeta =
      const VerificationMeta('defaultSupplierShippingDays');
  @override
  late final GeneratedColumn<int> defaultSupplierShippingDays =
      GeneratedColumn<int>(
        'default_supplier_shipping_days',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(7),
      );
  static const VerificationMeta _marketplaceMaxDeliveryDaysMeta =
      const VerificationMeta('marketplaceMaxDeliveryDays');
  @override
  late final GeneratedColumn<int> marketplaceMaxDeliveryDays =
      GeneratedColumn<int>(
        'marketplace_max_delivery_days',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _listingHealthMaxReturnRatePercentMeta =
      const VerificationMeta('listingHealthMaxReturnRatePercent');
  @override
  late final GeneratedColumn<double> listingHealthMaxReturnRatePercent =
      GeneratedColumn<double>(
        'listing_health_max_return_rate_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _listingHealthMaxLateRatePercentMeta =
      const VerificationMeta('listingHealthMaxLateRatePercent');
  @override
  late final GeneratedColumn<double> listingHealthMaxLateRatePercent =
      GeneratedColumn<double>(
        'listing_health_max_late_rate_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _autoPauseListingWhenHealthPoorMeta =
      const VerificationMeta('autoPauseListingWhenHealthPoor');
  @override
  late final GeneratedColumn<bool> autoPauseListingWhenHealthPoor =
      GeneratedColumn<bool>(
        'auto_pause_listing_when_health_poor',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("auto_pause_listing_when_health_poor" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _safetyStockBufferMeta = const VerificationMeta(
    'safetyStockBuffer',
  );
  @override
  late final GeneratedColumn<int> safetyStockBuffer = GeneratedColumn<int>(
    'safety_stock_buffer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _customerAbuseMaxReturnRatePercentMeta =
      const VerificationMeta('customerAbuseMaxReturnRatePercent');
  @override
  late final GeneratedColumn<double> customerAbuseMaxReturnRatePercent =
      GeneratedColumn<double>(
        'customer_abuse_max_return_rate_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _customerAbuseMaxComplaintRatePercentMeta =
      const VerificationMeta('customerAbuseMaxComplaintRatePercent');
  @override
  late final GeneratedColumn<double> customerAbuseMaxComplaintRatePercent =
      GeneratedColumn<double>(
        'customer_abuse_max_complaint_rate_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _priceRefreshIntervalMinutesBySourceJsonMeta =
      const VerificationMeta('priceRefreshIntervalMinutesBySourceJson');
  @override
  late final GeneratedColumn<String> priceRefreshIntervalMinutesBySourceJson =
      GeneratedColumn<String>(
        'price_refresh_interval_minutes_by_source_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
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
    marketplaceFeesJson,
    paymentFeesJson,
    sellerReturnAddressJson,
    marketplaceReturnPolicyJson,
    targetsReadOnly,
    pricingStrategy,
    categoryMinProfitPercentJson,
    premiumWhenBetterReviewsPercent,
    minSalesCountForPremium,
    kpiDrivenStrategyEnabled,
    rateLimitMaxRequestsPerSecondJson,
    incidentRulesJson,
    riskScoreThreshold,
    defaultReturnRatePercent,
    defaultReturnCostPerUnit,
    blockFulfillWhenInsufficientStock,
    autoPauseListingWhenMarginBelowThreshold,
    defaultSupplierProcessingDays,
    defaultSupplierShippingDays,
    marketplaceMaxDeliveryDays,
    listingHealthMaxReturnRatePercent,
    listingHealthMaxLateRatePercent,
    autoPauseListingWhenHealthPoor,
    safetyStockBuffer,
    customerAbuseMaxReturnRatePercent,
    customerAbuseMaxComplaintRatePercent,
    priceRefreshIntervalMinutesBySourceJson,
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
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
    if (data.containsKey('marketplace_fees_json')) {
      context.handle(
        _marketplaceFeesJsonMeta,
        marketplaceFeesJson.isAcceptableOrUnknown(
          data['marketplace_fees_json']!,
          _marketplaceFeesJsonMeta,
        ),
      );
    }
    if (data.containsKey('payment_fees_json')) {
      context.handle(
        _paymentFeesJsonMeta,
        paymentFeesJson.isAcceptableOrUnknown(
          data['payment_fees_json']!,
          _paymentFeesJsonMeta,
        ),
      );
    }
    if (data.containsKey('seller_return_address_json')) {
      context.handle(
        _sellerReturnAddressJsonMeta,
        sellerReturnAddressJson.isAcceptableOrUnknown(
          data['seller_return_address_json']!,
          _sellerReturnAddressJsonMeta,
        ),
      );
    }
    if (data.containsKey('marketplace_return_policy_json')) {
      context.handle(
        _marketplaceReturnPolicyJsonMeta,
        marketplaceReturnPolicyJson.isAcceptableOrUnknown(
          data['marketplace_return_policy_json']!,
          _marketplaceReturnPolicyJsonMeta,
        ),
      );
    }
    if (data.containsKey('targets_read_only')) {
      context.handle(
        _targetsReadOnlyMeta,
        targetsReadOnly.isAcceptableOrUnknown(
          data['targets_read_only']!,
          _targetsReadOnlyMeta,
        ),
      );
    }
    if (data.containsKey('pricing_strategy')) {
      context.handle(
        _pricingStrategyMeta,
        pricingStrategy.isAcceptableOrUnknown(
          data['pricing_strategy']!,
          _pricingStrategyMeta,
        ),
      );
    }
    if (data.containsKey('category_min_profit_percent_json')) {
      context.handle(
        _categoryMinProfitPercentJsonMeta,
        categoryMinProfitPercentJson.isAcceptableOrUnknown(
          data['category_min_profit_percent_json']!,
          _categoryMinProfitPercentJsonMeta,
        ),
      );
    }
    if (data.containsKey('premium_when_better_reviews_percent')) {
      context.handle(
        _premiumWhenBetterReviewsPercentMeta,
        premiumWhenBetterReviewsPercent.isAcceptableOrUnknown(
          data['premium_when_better_reviews_percent']!,
          _premiumWhenBetterReviewsPercentMeta,
        ),
      );
    }
    if (data.containsKey('min_sales_count_for_premium')) {
      context.handle(
        _minSalesCountForPremiumMeta,
        minSalesCountForPremium.isAcceptableOrUnknown(
          data['min_sales_count_for_premium']!,
          _minSalesCountForPremiumMeta,
        ),
      );
    }
    if (data.containsKey('kpi_driven_strategy_enabled')) {
      context.handle(
        _kpiDrivenStrategyEnabledMeta,
        kpiDrivenStrategyEnabled.isAcceptableOrUnknown(
          data['kpi_driven_strategy_enabled']!,
          _kpiDrivenStrategyEnabledMeta,
        ),
      );
    }
    if (data.containsKey('rate_limit_max_requests_per_second_json')) {
      context.handle(
        _rateLimitMaxRequestsPerSecondJsonMeta,
        rateLimitMaxRequestsPerSecondJson.isAcceptableOrUnknown(
          data['rate_limit_max_requests_per_second_json']!,
          _rateLimitMaxRequestsPerSecondJsonMeta,
        ),
      );
    }
    if (data.containsKey('incident_rules_json')) {
      context.handle(
        _incidentRulesJsonMeta,
        incidentRulesJson.isAcceptableOrUnknown(
          data['incident_rules_json']!,
          _incidentRulesJsonMeta,
        ),
      );
    }
    if (data.containsKey('risk_score_threshold')) {
      context.handle(
        _riskScoreThresholdMeta,
        riskScoreThreshold.isAcceptableOrUnknown(
          data['risk_score_threshold']!,
          _riskScoreThresholdMeta,
        ),
      );
    }
    if (data.containsKey('default_return_rate_percent')) {
      context.handle(
        _defaultReturnRatePercentMeta,
        defaultReturnRatePercent.isAcceptableOrUnknown(
          data['default_return_rate_percent']!,
          _defaultReturnRatePercentMeta,
        ),
      );
    }
    if (data.containsKey('default_return_cost_per_unit')) {
      context.handle(
        _defaultReturnCostPerUnitMeta,
        defaultReturnCostPerUnit.isAcceptableOrUnknown(
          data['default_return_cost_per_unit']!,
          _defaultReturnCostPerUnitMeta,
        ),
      );
    }
    if (data.containsKey('block_fulfill_when_insufficient_stock')) {
      context.handle(
        _blockFulfillWhenInsufficientStockMeta,
        blockFulfillWhenInsufficientStock.isAcceptableOrUnknown(
          data['block_fulfill_when_insufficient_stock']!,
          _blockFulfillWhenInsufficientStockMeta,
        ),
      );
    }
    if (data.containsKey('auto_pause_listing_when_margin_below_threshold')) {
      context.handle(
        _autoPauseListingWhenMarginBelowThresholdMeta,
        autoPauseListingWhenMarginBelowThreshold.isAcceptableOrUnknown(
          data['auto_pause_listing_when_margin_below_threshold']!,
          _autoPauseListingWhenMarginBelowThresholdMeta,
        ),
      );
    }
    if (data.containsKey('default_supplier_processing_days')) {
      context.handle(
        _defaultSupplierProcessingDaysMeta,
        defaultSupplierProcessingDays.isAcceptableOrUnknown(
          data['default_supplier_processing_days']!,
          _defaultSupplierProcessingDaysMeta,
        ),
      );
    }
    if (data.containsKey('default_supplier_shipping_days')) {
      context.handle(
        _defaultSupplierShippingDaysMeta,
        defaultSupplierShippingDays.isAcceptableOrUnknown(
          data['default_supplier_shipping_days']!,
          _defaultSupplierShippingDaysMeta,
        ),
      );
    }
    if (data.containsKey('marketplace_max_delivery_days')) {
      context.handle(
        _marketplaceMaxDeliveryDaysMeta,
        marketplaceMaxDeliveryDays.isAcceptableOrUnknown(
          data['marketplace_max_delivery_days']!,
          _marketplaceMaxDeliveryDaysMeta,
        ),
      );
    }
    if (data.containsKey('listing_health_max_return_rate_percent')) {
      context.handle(
        _listingHealthMaxReturnRatePercentMeta,
        listingHealthMaxReturnRatePercent.isAcceptableOrUnknown(
          data['listing_health_max_return_rate_percent']!,
          _listingHealthMaxReturnRatePercentMeta,
        ),
      );
    }
    if (data.containsKey('listing_health_max_late_rate_percent')) {
      context.handle(
        _listingHealthMaxLateRatePercentMeta,
        listingHealthMaxLateRatePercent.isAcceptableOrUnknown(
          data['listing_health_max_late_rate_percent']!,
          _listingHealthMaxLateRatePercentMeta,
        ),
      );
    }
    if (data.containsKey('auto_pause_listing_when_health_poor')) {
      context.handle(
        _autoPauseListingWhenHealthPoorMeta,
        autoPauseListingWhenHealthPoor.isAcceptableOrUnknown(
          data['auto_pause_listing_when_health_poor']!,
          _autoPauseListingWhenHealthPoorMeta,
        ),
      );
    }
    if (data.containsKey('safety_stock_buffer')) {
      context.handle(
        _safetyStockBufferMeta,
        safetyStockBuffer.isAcceptableOrUnknown(
          data['safety_stock_buffer']!,
          _safetyStockBufferMeta,
        ),
      );
    }
    if (data.containsKey('customer_abuse_max_return_rate_percent')) {
      context.handle(
        _customerAbuseMaxReturnRatePercentMeta,
        customerAbuseMaxReturnRatePercent.isAcceptableOrUnknown(
          data['customer_abuse_max_return_rate_percent']!,
          _customerAbuseMaxReturnRatePercentMeta,
        ),
      );
    }
    if (data.containsKey('customer_abuse_max_complaint_rate_percent')) {
      context.handle(
        _customerAbuseMaxComplaintRatePercentMeta,
        customerAbuseMaxComplaintRatePercent.isAcceptableOrUnknown(
          data['customer_abuse_max_complaint_rate_percent']!,
          _customerAbuseMaxComplaintRatePercentMeta,
        ),
      );
    }
    if (data.containsKey('price_refresh_interval_minutes_by_source_json')) {
      context.handle(
        _priceRefreshIntervalMinutesBySourceJsonMeta,
        priceRefreshIntervalMinutesBySourceJson.isAcceptableOrUnknown(
          data['price_refresh_interval_minutes_by_source_json']!,
          _priceRefreshIntervalMinutesBySourceJsonMeta,
        ),
      );
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
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
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
      marketplaceFeesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marketplace_fees_json'],
      )!,
      paymentFeesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_fees_json'],
      )!,
      sellerReturnAddressJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seller_return_address_json'],
      ),
      marketplaceReturnPolicyJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marketplace_return_policy_json'],
      )!,
      targetsReadOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}targets_read_only'],
      )!,
      pricingStrategy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pricing_strategy'],
      )!,
      categoryMinProfitPercentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_min_profit_percent_json'],
      )!,
      premiumWhenBetterReviewsPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}premium_when_better_reviews_percent'],
      )!,
      minSalesCountForPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_sales_count_for_premium'],
      )!,
      kpiDrivenStrategyEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}kpi_driven_strategy_enabled'],
      )!,
      rateLimitMaxRequestsPerSecondJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rate_limit_max_requests_per_second_json'],
      )!,
      incidentRulesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}incident_rules_json'],
      ),
      riskScoreThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}risk_score_threshold'],
      ),
      defaultReturnRatePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_return_rate_percent'],
      ),
      defaultReturnCostPerUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_return_cost_per_unit'],
      ),
      blockFulfillWhenInsufficientStock: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}block_fulfill_when_insufficient_stock'],
      )!,
      autoPauseListingWhenMarginBelowThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_pause_listing_when_margin_below_threshold'],
      )!,
      defaultSupplierProcessingDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_supplier_processing_days'],
      )!,
      defaultSupplierShippingDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_supplier_shipping_days'],
      )!,
      marketplaceMaxDeliveryDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}marketplace_max_delivery_days'],
      ),
      listingHealthMaxReturnRatePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}listing_health_max_return_rate_percent'],
      ),
      listingHealthMaxLateRatePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}listing_health_max_late_rate_percent'],
      ),
      autoPauseListingWhenHealthPoor: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_pause_listing_when_health_poor'],
      )!,
      safetyStockBuffer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}safety_stock_buffer'],
      )!,
      customerAbuseMaxReturnRatePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}customer_abuse_max_return_rate_percent'],
      ),
      customerAbuseMaxComplaintRatePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}customer_abuse_max_complaint_rate_percent'],
      ),
      priceRefreshIntervalMinutesBySourceJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_refresh_interval_minutes_by_source_json'],
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
  final int tenantId;
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
  final String marketplaceFeesJson;
  final String paymentFeesJson;
  final String? sellerReturnAddressJson;
  final String marketplaceReturnPolicyJson;
  final bool targetsReadOnly;
  final String pricingStrategy;
  final String categoryMinProfitPercentJson;
  final double premiumWhenBetterReviewsPercent;
  final int minSalesCountForPremium;
  final bool kpiDrivenStrategyEnabled;

  /// Per-platform rate limit: platformId -> max requests per second (JSON object).
  final String rateLimitMaxRequestsPerSecondJson;

  /// Phase 8: incident decision rules – JSON array of { condition, action }. Nullable.
  final String? incidentRulesJson;

  /// Phase 16: if order risk score > this value, set to pendingApproval. Nullable (disabled when null).
  final double? riskScoreThreshold;

  /// Phase 17: default expected return rate % for return-rate-aware P_min (e.g. 15 = 15%). Nullable.
  final double? defaultReturnRatePercent;

  /// Phase 17: default return cost per unit (PLN) for return-rate-aware P_min. Nullable.
  final double? defaultReturnCostPerUnit;

  /// When true, fulfillment is skipped when inventory availableToSell < order quantity (Phase 18).
  final bool blockFulfillWhenInsufficientStock;

  /// Phase 20: when true, ProfitGuard auto-pauses listing when margin < minProfitPercent.
  final bool autoPauseListingWhenMarginBelowThreshold;

  /// Phase 21: default supplier processing days; used for shipping validation.
  final int defaultSupplierProcessingDays;

  /// Phase 21: default supplier shipping days when product has no estimatedDays.
  final int defaultSupplierShippingDays;

  /// Phase 21: marketplace max delivery days; reject listing if expected delivery > this. Nullable = skip check.
  final int? marketplaceMaxDeliveryDays;

  /// Phase 26: max return+incident rate %; when exceeded and auto-pause on, listing is paused. Null = no limit.
  final double? listingHealthMaxReturnRatePercent;

  /// Phase 26: max late delivery rate %; when exceeded and auto-pause on, listing is paused. Null = no limit.
  final double? listingHealthMaxLateRatePercent;

  /// Phase 26: when true, auto-pause listings when health thresholds exceeded.
  final bool autoPauseListingWhenHealthPoor;

  /// Phase 19: reduce effective available-to-sell by this many units (stock drift buffer).
  final int safetyStockBuffer;

  /// Phase 25: max return rate % for customer abuse check; null = disabled.
  final double? customerAbuseMaxReturnRatePercent;

  /// Phase 25: max complaint rate % for customer abuse check; null = disabled.
  final double? customerAbuseMaxComplaintRatePercent;

  /// Per-warehouse price refresh interval (minutes). sourcePlatformId -> minutes. Warehouses publish 1-2x/day; we pull from XML/CSV/API when stale. Default 720.
  final String priceRefreshIntervalMinutesBySourceJson;
  const UserRulesRow({
    required this.id,
    required this.tenantId,
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
    required this.marketplaceFeesJson,
    required this.paymentFeesJson,
    this.sellerReturnAddressJson,
    required this.marketplaceReturnPolicyJson,
    required this.targetsReadOnly,
    required this.pricingStrategy,
    required this.categoryMinProfitPercentJson,
    required this.premiumWhenBetterReviewsPercent,
    required this.minSalesCountForPremium,
    required this.kpiDrivenStrategyEnabled,
    required this.rateLimitMaxRequestsPerSecondJson,
    this.incidentRulesJson,
    this.riskScoreThreshold,
    this.defaultReturnRatePercent,
    this.defaultReturnCostPerUnit,
    required this.blockFulfillWhenInsufficientStock,
    required this.autoPauseListingWhenMarginBelowThreshold,
    required this.defaultSupplierProcessingDays,
    required this.defaultSupplierShippingDays,
    this.marketplaceMaxDeliveryDays,
    this.listingHealthMaxReturnRatePercent,
    this.listingHealthMaxLateRatePercent,
    required this.autoPauseListingWhenHealthPoor,
    required this.safetyStockBuffer,
    this.customerAbuseMaxReturnRatePercent,
    this.customerAbuseMaxComplaintRatePercent,
    required this.priceRefreshIntervalMinutesBySourceJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
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
    map['marketplace_fees_json'] = Variable<String>(marketplaceFeesJson);
    map['payment_fees_json'] = Variable<String>(paymentFeesJson);
    if (!nullToAbsent || sellerReturnAddressJson != null) {
      map['seller_return_address_json'] = Variable<String>(
        sellerReturnAddressJson,
      );
    }
    map['marketplace_return_policy_json'] = Variable<String>(
      marketplaceReturnPolicyJson,
    );
    map['targets_read_only'] = Variable<bool>(targetsReadOnly);
    map['pricing_strategy'] = Variable<String>(pricingStrategy);
    map['category_min_profit_percent_json'] = Variable<String>(
      categoryMinProfitPercentJson,
    );
    map['premium_when_better_reviews_percent'] = Variable<double>(
      premiumWhenBetterReviewsPercent,
    );
    map['min_sales_count_for_premium'] = Variable<int>(minSalesCountForPremium);
    map['kpi_driven_strategy_enabled'] = Variable<bool>(
      kpiDrivenStrategyEnabled,
    );
    map['rate_limit_max_requests_per_second_json'] = Variable<String>(
      rateLimitMaxRequestsPerSecondJson,
    );
    if (!nullToAbsent || incidentRulesJson != null) {
      map['incident_rules_json'] = Variable<String>(incidentRulesJson);
    }
    if (!nullToAbsent || riskScoreThreshold != null) {
      map['risk_score_threshold'] = Variable<double>(riskScoreThreshold);
    }
    if (!nullToAbsent || defaultReturnRatePercent != null) {
      map['default_return_rate_percent'] = Variable<double>(
        defaultReturnRatePercent,
      );
    }
    if (!nullToAbsent || defaultReturnCostPerUnit != null) {
      map['default_return_cost_per_unit'] = Variable<double>(
        defaultReturnCostPerUnit,
      );
    }
    map['block_fulfill_when_insufficient_stock'] = Variable<bool>(
      blockFulfillWhenInsufficientStock,
    );
    map['auto_pause_listing_when_margin_below_threshold'] = Variable<bool>(
      autoPauseListingWhenMarginBelowThreshold,
    );
    map['default_supplier_processing_days'] = Variable<int>(
      defaultSupplierProcessingDays,
    );
    map['default_supplier_shipping_days'] = Variable<int>(
      defaultSupplierShippingDays,
    );
    if (!nullToAbsent || marketplaceMaxDeliveryDays != null) {
      map['marketplace_max_delivery_days'] = Variable<int>(
        marketplaceMaxDeliveryDays,
      );
    }
    if (!nullToAbsent || listingHealthMaxReturnRatePercent != null) {
      map['listing_health_max_return_rate_percent'] = Variable<double>(
        listingHealthMaxReturnRatePercent,
      );
    }
    if (!nullToAbsent || listingHealthMaxLateRatePercent != null) {
      map['listing_health_max_late_rate_percent'] = Variable<double>(
        listingHealthMaxLateRatePercent,
      );
    }
    map['auto_pause_listing_when_health_poor'] = Variable<bool>(
      autoPauseListingWhenHealthPoor,
    );
    map['safety_stock_buffer'] = Variable<int>(safetyStockBuffer);
    if (!nullToAbsent || customerAbuseMaxReturnRatePercent != null) {
      map['customer_abuse_max_return_rate_percent'] = Variable<double>(
        customerAbuseMaxReturnRatePercent,
      );
    }
    if (!nullToAbsent || customerAbuseMaxComplaintRatePercent != null) {
      map['customer_abuse_max_complaint_rate_percent'] = Variable<double>(
        customerAbuseMaxComplaintRatePercent,
      );
    }
    map['price_refresh_interval_minutes_by_source_json'] = Variable<String>(
      priceRefreshIntervalMinutesBySourceJson,
    );
    return map;
  }

  UserRulesTableCompanion toCompanion(bool nullToAbsent) {
    return UserRulesTableCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
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
      marketplaceFeesJson: Value(marketplaceFeesJson),
      paymentFeesJson: Value(paymentFeesJson),
      sellerReturnAddressJson: sellerReturnAddressJson == null && nullToAbsent
          ? const Value.absent()
          : Value(sellerReturnAddressJson),
      marketplaceReturnPolicyJson: Value(marketplaceReturnPolicyJson),
      targetsReadOnly: Value(targetsReadOnly),
      pricingStrategy: Value(pricingStrategy),
      categoryMinProfitPercentJson: Value(categoryMinProfitPercentJson),
      premiumWhenBetterReviewsPercent: Value(premiumWhenBetterReviewsPercent),
      minSalesCountForPremium: Value(minSalesCountForPremium),
      kpiDrivenStrategyEnabled: Value(kpiDrivenStrategyEnabled),
      rateLimitMaxRequestsPerSecondJson: Value(
        rateLimitMaxRequestsPerSecondJson,
      ),
      incidentRulesJson: incidentRulesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(incidentRulesJson),
      riskScoreThreshold: riskScoreThreshold == null && nullToAbsent
          ? const Value.absent()
          : Value(riskScoreThreshold),
      defaultReturnRatePercent: defaultReturnRatePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultReturnRatePercent),
      defaultReturnCostPerUnit: defaultReturnCostPerUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultReturnCostPerUnit),
      blockFulfillWhenInsufficientStock: Value(
        blockFulfillWhenInsufficientStock,
      ),
      autoPauseListingWhenMarginBelowThreshold: Value(
        autoPauseListingWhenMarginBelowThreshold,
      ),
      defaultSupplierProcessingDays: Value(defaultSupplierProcessingDays),
      defaultSupplierShippingDays: Value(defaultSupplierShippingDays),
      marketplaceMaxDeliveryDays:
          marketplaceMaxDeliveryDays == null && nullToAbsent
          ? const Value.absent()
          : Value(marketplaceMaxDeliveryDays),
      listingHealthMaxReturnRatePercent:
          listingHealthMaxReturnRatePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(listingHealthMaxReturnRatePercent),
      listingHealthMaxLateRatePercent:
          listingHealthMaxLateRatePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(listingHealthMaxLateRatePercent),
      autoPauseListingWhenHealthPoor: Value(autoPauseListingWhenHealthPoor),
      safetyStockBuffer: Value(safetyStockBuffer),
      customerAbuseMaxReturnRatePercent:
          customerAbuseMaxReturnRatePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(customerAbuseMaxReturnRatePercent),
      customerAbuseMaxComplaintRatePercent:
          customerAbuseMaxComplaintRatePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(customerAbuseMaxComplaintRatePercent),
      priceRefreshIntervalMinutesBySourceJson: Value(
        priceRefreshIntervalMinutesBySourceJson,
      ),
    );
  }

  factory UserRulesRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRulesRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
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
      marketplaceFeesJson: serializer.fromJson<String>(
        json['marketplaceFeesJson'],
      ),
      paymentFeesJson: serializer.fromJson<String>(json['paymentFeesJson']),
      sellerReturnAddressJson: serializer.fromJson<String?>(
        json['sellerReturnAddressJson'],
      ),
      marketplaceReturnPolicyJson: serializer.fromJson<String>(
        json['marketplaceReturnPolicyJson'],
      ),
      targetsReadOnly: serializer.fromJson<bool>(json['targetsReadOnly']),
      pricingStrategy: serializer.fromJson<String>(json['pricingStrategy']),
      categoryMinProfitPercentJson: serializer.fromJson<String>(
        json['categoryMinProfitPercentJson'],
      ),
      premiumWhenBetterReviewsPercent: serializer.fromJson<double>(
        json['premiumWhenBetterReviewsPercent'],
      ),
      minSalesCountForPremium: serializer.fromJson<int>(
        json['minSalesCountForPremium'],
      ),
      kpiDrivenStrategyEnabled: serializer.fromJson<bool>(
        json['kpiDrivenStrategyEnabled'],
      ),
      rateLimitMaxRequestsPerSecondJson: serializer.fromJson<String>(
        json['rateLimitMaxRequestsPerSecondJson'],
      ),
      incidentRulesJson: serializer.fromJson<String?>(
        json['incidentRulesJson'],
      ),
      riskScoreThreshold: serializer.fromJson<double?>(
        json['riskScoreThreshold'],
      ),
      defaultReturnRatePercent: serializer.fromJson<double?>(
        json['defaultReturnRatePercent'],
      ),
      defaultReturnCostPerUnit: serializer.fromJson<double?>(
        json['defaultReturnCostPerUnit'],
      ),
      blockFulfillWhenInsufficientStock: serializer.fromJson<bool>(
        json['blockFulfillWhenInsufficientStock'],
      ),
      autoPauseListingWhenMarginBelowThreshold: serializer.fromJson<bool>(
        json['autoPauseListingWhenMarginBelowThreshold'],
      ),
      defaultSupplierProcessingDays: serializer.fromJson<int>(
        json['defaultSupplierProcessingDays'],
      ),
      defaultSupplierShippingDays: serializer.fromJson<int>(
        json['defaultSupplierShippingDays'],
      ),
      marketplaceMaxDeliveryDays: serializer.fromJson<int?>(
        json['marketplaceMaxDeliveryDays'],
      ),
      listingHealthMaxReturnRatePercent: serializer.fromJson<double?>(
        json['listingHealthMaxReturnRatePercent'],
      ),
      listingHealthMaxLateRatePercent: serializer.fromJson<double?>(
        json['listingHealthMaxLateRatePercent'],
      ),
      autoPauseListingWhenHealthPoor: serializer.fromJson<bool>(
        json['autoPauseListingWhenHealthPoor'],
      ),
      safetyStockBuffer: serializer.fromJson<int>(json['safetyStockBuffer']),
      customerAbuseMaxReturnRatePercent: serializer.fromJson<double?>(
        json['customerAbuseMaxReturnRatePercent'],
      ),
      customerAbuseMaxComplaintRatePercent: serializer.fromJson<double?>(
        json['customerAbuseMaxComplaintRatePercent'],
      ),
      priceRefreshIntervalMinutesBySourceJson: serializer.fromJson<String>(
        json['priceRefreshIntervalMinutesBySourceJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
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
      'marketplaceFeesJson': serializer.toJson<String>(marketplaceFeesJson),
      'paymentFeesJson': serializer.toJson<String>(paymentFeesJson),
      'sellerReturnAddressJson': serializer.toJson<String?>(
        sellerReturnAddressJson,
      ),
      'marketplaceReturnPolicyJson': serializer.toJson<String>(
        marketplaceReturnPolicyJson,
      ),
      'targetsReadOnly': serializer.toJson<bool>(targetsReadOnly),
      'pricingStrategy': serializer.toJson<String>(pricingStrategy),
      'categoryMinProfitPercentJson': serializer.toJson<String>(
        categoryMinProfitPercentJson,
      ),
      'premiumWhenBetterReviewsPercent': serializer.toJson<double>(
        premiumWhenBetterReviewsPercent,
      ),
      'minSalesCountForPremium': serializer.toJson<int>(
        minSalesCountForPremium,
      ),
      'kpiDrivenStrategyEnabled': serializer.toJson<bool>(
        kpiDrivenStrategyEnabled,
      ),
      'rateLimitMaxRequestsPerSecondJson': serializer.toJson<String>(
        rateLimitMaxRequestsPerSecondJson,
      ),
      'incidentRulesJson': serializer.toJson<String?>(incidentRulesJson),
      'riskScoreThreshold': serializer.toJson<double?>(riskScoreThreshold),
      'defaultReturnRatePercent': serializer.toJson<double?>(
        defaultReturnRatePercent,
      ),
      'defaultReturnCostPerUnit': serializer.toJson<double?>(
        defaultReturnCostPerUnit,
      ),
      'blockFulfillWhenInsufficientStock': serializer.toJson<bool>(
        blockFulfillWhenInsufficientStock,
      ),
      'autoPauseListingWhenMarginBelowThreshold': serializer.toJson<bool>(
        autoPauseListingWhenMarginBelowThreshold,
      ),
      'defaultSupplierProcessingDays': serializer.toJson<int>(
        defaultSupplierProcessingDays,
      ),
      'defaultSupplierShippingDays': serializer.toJson<int>(
        defaultSupplierShippingDays,
      ),
      'marketplaceMaxDeliveryDays': serializer.toJson<int?>(
        marketplaceMaxDeliveryDays,
      ),
      'listingHealthMaxReturnRatePercent': serializer.toJson<double?>(
        listingHealthMaxReturnRatePercent,
      ),
      'listingHealthMaxLateRatePercent': serializer.toJson<double?>(
        listingHealthMaxLateRatePercent,
      ),
      'autoPauseListingWhenHealthPoor': serializer.toJson<bool>(
        autoPauseListingWhenHealthPoor,
      ),
      'safetyStockBuffer': serializer.toJson<int>(safetyStockBuffer),
      'customerAbuseMaxReturnRatePercent': serializer.toJson<double?>(
        customerAbuseMaxReturnRatePercent,
      ),
      'customerAbuseMaxComplaintRatePercent': serializer.toJson<double?>(
        customerAbuseMaxComplaintRatePercent,
      ),
      'priceRefreshIntervalMinutesBySourceJson': serializer.toJson<String>(
        priceRefreshIntervalMinutesBySourceJson,
      ),
    };
  }

  UserRulesRow copyWith({
    int? id,
    int? tenantId,
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
    String? marketplaceFeesJson,
    String? paymentFeesJson,
    Value<String?> sellerReturnAddressJson = const Value.absent(),
    String? marketplaceReturnPolicyJson,
    bool? targetsReadOnly,
    String? pricingStrategy,
    String? categoryMinProfitPercentJson,
    double? premiumWhenBetterReviewsPercent,
    int? minSalesCountForPremium,
    bool? kpiDrivenStrategyEnabled,
    String? rateLimitMaxRequestsPerSecondJson,
    Value<String?> incidentRulesJson = const Value.absent(),
    Value<double?> riskScoreThreshold = const Value.absent(),
    Value<double?> defaultReturnRatePercent = const Value.absent(),
    Value<double?> defaultReturnCostPerUnit = const Value.absent(),
    bool? blockFulfillWhenInsufficientStock,
    bool? autoPauseListingWhenMarginBelowThreshold,
    int? defaultSupplierProcessingDays,
    int? defaultSupplierShippingDays,
    Value<int?> marketplaceMaxDeliveryDays = const Value.absent(),
    Value<double?> listingHealthMaxReturnRatePercent = const Value.absent(),
    Value<double?> listingHealthMaxLateRatePercent = const Value.absent(),
    bool? autoPauseListingWhenHealthPoor,
    int? safetyStockBuffer,
    Value<double?> customerAbuseMaxReturnRatePercent = const Value.absent(),
    Value<double?> customerAbuseMaxComplaintRatePercent = const Value.absent(),
    String? priceRefreshIntervalMinutesBySourceJson,
  }) => UserRulesRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
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
    marketplaceFeesJson: marketplaceFeesJson ?? this.marketplaceFeesJson,
    paymentFeesJson: paymentFeesJson ?? this.paymentFeesJson,
    sellerReturnAddressJson: sellerReturnAddressJson.present
        ? sellerReturnAddressJson.value
        : this.sellerReturnAddressJson,
    marketplaceReturnPolicyJson:
        marketplaceReturnPolicyJson ?? this.marketplaceReturnPolicyJson,
    targetsReadOnly: targetsReadOnly ?? this.targetsReadOnly,
    pricingStrategy: pricingStrategy ?? this.pricingStrategy,
    categoryMinProfitPercentJson:
        categoryMinProfitPercentJson ?? this.categoryMinProfitPercentJson,
    premiumWhenBetterReviewsPercent:
        premiumWhenBetterReviewsPercent ?? this.premiumWhenBetterReviewsPercent,
    minSalesCountForPremium:
        minSalesCountForPremium ?? this.minSalesCountForPremium,
    kpiDrivenStrategyEnabled:
        kpiDrivenStrategyEnabled ?? this.kpiDrivenStrategyEnabled,
    rateLimitMaxRequestsPerSecondJson:
        rateLimitMaxRequestsPerSecondJson ??
        this.rateLimitMaxRequestsPerSecondJson,
    incidentRulesJson: incidentRulesJson.present
        ? incidentRulesJson.value
        : this.incidentRulesJson,
    riskScoreThreshold: riskScoreThreshold.present
        ? riskScoreThreshold.value
        : this.riskScoreThreshold,
    defaultReturnRatePercent: defaultReturnRatePercent.present
        ? defaultReturnRatePercent.value
        : this.defaultReturnRatePercent,
    defaultReturnCostPerUnit: defaultReturnCostPerUnit.present
        ? defaultReturnCostPerUnit.value
        : this.defaultReturnCostPerUnit,
    blockFulfillWhenInsufficientStock:
        blockFulfillWhenInsufficientStock ??
        this.blockFulfillWhenInsufficientStock,
    autoPauseListingWhenMarginBelowThreshold:
        autoPauseListingWhenMarginBelowThreshold ??
        this.autoPauseListingWhenMarginBelowThreshold,
    defaultSupplierProcessingDays:
        defaultSupplierProcessingDays ?? this.defaultSupplierProcessingDays,
    defaultSupplierShippingDays:
        defaultSupplierShippingDays ?? this.defaultSupplierShippingDays,
    marketplaceMaxDeliveryDays: marketplaceMaxDeliveryDays.present
        ? marketplaceMaxDeliveryDays.value
        : this.marketplaceMaxDeliveryDays,
    listingHealthMaxReturnRatePercent: listingHealthMaxReturnRatePercent.present
        ? listingHealthMaxReturnRatePercent.value
        : this.listingHealthMaxReturnRatePercent,
    listingHealthMaxLateRatePercent: listingHealthMaxLateRatePercent.present
        ? listingHealthMaxLateRatePercent.value
        : this.listingHealthMaxLateRatePercent,
    autoPauseListingWhenHealthPoor:
        autoPauseListingWhenHealthPoor ?? this.autoPauseListingWhenHealthPoor,
    safetyStockBuffer: safetyStockBuffer ?? this.safetyStockBuffer,
    customerAbuseMaxReturnRatePercent: customerAbuseMaxReturnRatePercent.present
        ? customerAbuseMaxReturnRatePercent.value
        : this.customerAbuseMaxReturnRatePercent,
    customerAbuseMaxComplaintRatePercent:
        customerAbuseMaxComplaintRatePercent.present
        ? customerAbuseMaxComplaintRatePercent.value
        : this.customerAbuseMaxComplaintRatePercent,
    priceRefreshIntervalMinutesBySourceJson:
        priceRefreshIntervalMinutesBySourceJson ??
        this.priceRefreshIntervalMinutesBySourceJson,
  );
  UserRulesRow copyWithCompanion(UserRulesTableCompanion data) {
    return UserRulesRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
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
      marketplaceFeesJson: data.marketplaceFeesJson.present
          ? data.marketplaceFeesJson.value
          : this.marketplaceFeesJson,
      paymentFeesJson: data.paymentFeesJson.present
          ? data.paymentFeesJson.value
          : this.paymentFeesJson,
      sellerReturnAddressJson: data.sellerReturnAddressJson.present
          ? data.sellerReturnAddressJson.value
          : this.sellerReturnAddressJson,
      marketplaceReturnPolicyJson: data.marketplaceReturnPolicyJson.present
          ? data.marketplaceReturnPolicyJson.value
          : this.marketplaceReturnPolicyJson,
      targetsReadOnly: data.targetsReadOnly.present
          ? data.targetsReadOnly.value
          : this.targetsReadOnly,
      pricingStrategy: data.pricingStrategy.present
          ? data.pricingStrategy.value
          : this.pricingStrategy,
      categoryMinProfitPercentJson: data.categoryMinProfitPercentJson.present
          ? data.categoryMinProfitPercentJson.value
          : this.categoryMinProfitPercentJson,
      premiumWhenBetterReviewsPercent:
          data.premiumWhenBetterReviewsPercent.present
          ? data.premiumWhenBetterReviewsPercent.value
          : this.premiumWhenBetterReviewsPercent,
      minSalesCountForPremium: data.minSalesCountForPremium.present
          ? data.minSalesCountForPremium.value
          : this.minSalesCountForPremium,
      kpiDrivenStrategyEnabled: data.kpiDrivenStrategyEnabled.present
          ? data.kpiDrivenStrategyEnabled.value
          : this.kpiDrivenStrategyEnabled,
      rateLimitMaxRequestsPerSecondJson:
          data.rateLimitMaxRequestsPerSecondJson.present
          ? data.rateLimitMaxRequestsPerSecondJson.value
          : this.rateLimitMaxRequestsPerSecondJson,
      incidentRulesJson: data.incidentRulesJson.present
          ? data.incidentRulesJson.value
          : this.incidentRulesJson,
      riskScoreThreshold: data.riskScoreThreshold.present
          ? data.riskScoreThreshold.value
          : this.riskScoreThreshold,
      defaultReturnRatePercent: data.defaultReturnRatePercent.present
          ? data.defaultReturnRatePercent.value
          : this.defaultReturnRatePercent,
      defaultReturnCostPerUnit: data.defaultReturnCostPerUnit.present
          ? data.defaultReturnCostPerUnit.value
          : this.defaultReturnCostPerUnit,
      blockFulfillWhenInsufficientStock:
          data.blockFulfillWhenInsufficientStock.present
          ? data.blockFulfillWhenInsufficientStock.value
          : this.blockFulfillWhenInsufficientStock,
      autoPauseListingWhenMarginBelowThreshold:
          data.autoPauseListingWhenMarginBelowThreshold.present
          ? data.autoPauseListingWhenMarginBelowThreshold.value
          : this.autoPauseListingWhenMarginBelowThreshold,
      defaultSupplierProcessingDays: data.defaultSupplierProcessingDays.present
          ? data.defaultSupplierProcessingDays.value
          : this.defaultSupplierProcessingDays,
      defaultSupplierShippingDays: data.defaultSupplierShippingDays.present
          ? data.defaultSupplierShippingDays.value
          : this.defaultSupplierShippingDays,
      marketplaceMaxDeliveryDays: data.marketplaceMaxDeliveryDays.present
          ? data.marketplaceMaxDeliveryDays.value
          : this.marketplaceMaxDeliveryDays,
      listingHealthMaxReturnRatePercent:
          data.listingHealthMaxReturnRatePercent.present
          ? data.listingHealthMaxReturnRatePercent.value
          : this.listingHealthMaxReturnRatePercent,
      listingHealthMaxLateRatePercent:
          data.listingHealthMaxLateRatePercent.present
          ? data.listingHealthMaxLateRatePercent.value
          : this.listingHealthMaxLateRatePercent,
      autoPauseListingWhenHealthPoor:
          data.autoPauseListingWhenHealthPoor.present
          ? data.autoPauseListingWhenHealthPoor.value
          : this.autoPauseListingWhenHealthPoor,
      safetyStockBuffer: data.safetyStockBuffer.present
          ? data.safetyStockBuffer.value
          : this.safetyStockBuffer,
      customerAbuseMaxReturnRatePercent:
          data.customerAbuseMaxReturnRatePercent.present
          ? data.customerAbuseMaxReturnRatePercent.value
          : this.customerAbuseMaxReturnRatePercent,
      customerAbuseMaxComplaintRatePercent:
          data.customerAbuseMaxComplaintRatePercent.present
          ? data.customerAbuseMaxComplaintRatePercent.value
          : this.customerAbuseMaxComplaintRatePercent,
      priceRefreshIntervalMinutesBySourceJson:
          data.priceRefreshIntervalMinutesBySourceJson.present
          ? data.priceRefreshIntervalMinutesBySourceJson.value
          : this.priceRefreshIntervalMinutesBySourceJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRulesRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('minProfitPercent: $minProfitPercent, ')
          ..write('maxSourcePrice: $maxSourcePrice, ')
          ..write('preferredSupplierCountries: $preferredSupplierCountries, ')
          ..write('manualApprovalListings: $manualApprovalListings, ')
          ..write('manualApprovalOrders: $manualApprovalOrders, ')
          ..write('scanIntervalMinutes: $scanIntervalMinutes, ')
          ..write('blacklistedProductIds: $blacklistedProductIds, ')
          ..write('blacklistedSupplierIds: $blacklistedSupplierIds, ')
          ..write('defaultMarkupPercent: $defaultMarkupPercent, ')
          ..write('searchKeywords: $searchKeywords, ')
          ..write('marketplaceFeesJson: $marketplaceFeesJson, ')
          ..write('paymentFeesJson: $paymentFeesJson, ')
          ..write('sellerReturnAddressJson: $sellerReturnAddressJson, ')
          ..write('marketplaceReturnPolicyJson: $marketplaceReturnPolicyJson, ')
          ..write('targetsReadOnly: $targetsReadOnly, ')
          ..write('pricingStrategy: $pricingStrategy, ')
          ..write(
            'categoryMinProfitPercentJson: $categoryMinProfitPercentJson, ',
          )
          ..write(
            'premiumWhenBetterReviewsPercent: $premiumWhenBetterReviewsPercent, ',
          )
          ..write('minSalesCountForPremium: $minSalesCountForPremium, ')
          ..write('kpiDrivenStrategyEnabled: $kpiDrivenStrategyEnabled, ')
          ..write(
            'rateLimitMaxRequestsPerSecondJson: $rateLimitMaxRequestsPerSecondJson, ',
          )
          ..write('incidentRulesJson: $incidentRulesJson, ')
          ..write('riskScoreThreshold: $riskScoreThreshold, ')
          ..write('defaultReturnRatePercent: $defaultReturnRatePercent, ')
          ..write('defaultReturnCostPerUnit: $defaultReturnCostPerUnit, ')
          ..write(
            'blockFulfillWhenInsufficientStock: $blockFulfillWhenInsufficientStock, ',
          )
          ..write(
            'autoPauseListingWhenMarginBelowThreshold: $autoPauseListingWhenMarginBelowThreshold, ',
          )
          ..write(
            'defaultSupplierProcessingDays: $defaultSupplierProcessingDays, ',
          )
          ..write('defaultSupplierShippingDays: $defaultSupplierShippingDays, ')
          ..write('marketplaceMaxDeliveryDays: $marketplaceMaxDeliveryDays, ')
          ..write(
            'listingHealthMaxReturnRatePercent: $listingHealthMaxReturnRatePercent, ',
          )
          ..write(
            'listingHealthMaxLateRatePercent: $listingHealthMaxLateRatePercent, ',
          )
          ..write(
            'autoPauseListingWhenHealthPoor: $autoPauseListingWhenHealthPoor, ',
          )
          ..write('safetyStockBuffer: $safetyStockBuffer, ')
          ..write(
            'customerAbuseMaxReturnRatePercent: $customerAbuseMaxReturnRatePercent, ',
          )
          ..write(
            'customerAbuseMaxComplaintRatePercent: $customerAbuseMaxComplaintRatePercent, ',
          )
          ..write(
            'priceRefreshIntervalMinutesBySourceJson: $priceRefreshIntervalMinutesBySourceJson',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    tenantId,
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
    marketplaceFeesJson,
    paymentFeesJson,
    sellerReturnAddressJson,
    marketplaceReturnPolicyJson,
    targetsReadOnly,
    pricingStrategy,
    categoryMinProfitPercentJson,
    premiumWhenBetterReviewsPercent,
    minSalesCountForPremium,
    kpiDrivenStrategyEnabled,
    rateLimitMaxRequestsPerSecondJson,
    incidentRulesJson,
    riskScoreThreshold,
    defaultReturnRatePercent,
    defaultReturnCostPerUnit,
    blockFulfillWhenInsufficientStock,
    autoPauseListingWhenMarginBelowThreshold,
    defaultSupplierProcessingDays,
    defaultSupplierShippingDays,
    marketplaceMaxDeliveryDays,
    listingHealthMaxReturnRatePercent,
    listingHealthMaxLateRatePercent,
    autoPauseListingWhenHealthPoor,
    safetyStockBuffer,
    customerAbuseMaxReturnRatePercent,
    customerAbuseMaxComplaintRatePercent,
    priceRefreshIntervalMinutesBySourceJson,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRulesRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.minProfitPercent == this.minProfitPercent &&
          other.maxSourcePrice == this.maxSourcePrice &&
          other.preferredSupplierCountries == this.preferredSupplierCountries &&
          other.manualApprovalListings == this.manualApprovalListings &&
          other.manualApprovalOrders == this.manualApprovalOrders &&
          other.scanIntervalMinutes == this.scanIntervalMinutes &&
          other.blacklistedProductIds == this.blacklistedProductIds &&
          other.blacklistedSupplierIds == this.blacklistedSupplierIds &&
          other.defaultMarkupPercent == this.defaultMarkupPercent &&
          other.searchKeywords == this.searchKeywords &&
          other.marketplaceFeesJson == this.marketplaceFeesJson &&
          other.paymentFeesJson == this.paymentFeesJson &&
          other.sellerReturnAddressJson == this.sellerReturnAddressJson &&
          other.marketplaceReturnPolicyJson ==
              this.marketplaceReturnPolicyJson &&
          other.targetsReadOnly == this.targetsReadOnly &&
          other.pricingStrategy == this.pricingStrategy &&
          other.categoryMinProfitPercentJson ==
              this.categoryMinProfitPercentJson &&
          other.premiumWhenBetterReviewsPercent ==
              this.premiumWhenBetterReviewsPercent &&
          other.minSalesCountForPremium == this.minSalesCountForPremium &&
          other.kpiDrivenStrategyEnabled == this.kpiDrivenStrategyEnabled &&
          other.rateLimitMaxRequestsPerSecondJson ==
              this.rateLimitMaxRequestsPerSecondJson &&
          other.incidentRulesJson == this.incidentRulesJson &&
          other.riskScoreThreshold == this.riskScoreThreshold &&
          other.defaultReturnRatePercent == this.defaultReturnRatePercent &&
          other.defaultReturnCostPerUnit == this.defaultReturnCostPerUnit &&
          other.blockFulfillWhenInsufficientStock ==
              this.blockFulfillWhenInsufficientStock &&
          other.autoPauseListingWhenMarginBelowThreshold ==
              this.autoPauseListingWhenMarginBelowThreshold &&
          other.defaultSupplierProcessingDays ==
              this.defaultSupplierProcessingDays &&
          other.defaultSupplierShippingDays ==
              this.defaultSupplierShippingDays &&
          other.marketplaceMaxDeliveryDays == this.marketplaceMaxDeliveryDays &&
          other.listingHealthMaxReturnRatePercent ==
              this.listingHealthMaxReturnRatePercent &&
          other.listingHealthMaxLateRatePercent ==
              this.listingHealthMaxLateRatePercent &&
          other.autoPauseListingWhenHealthPoor ==
              this.autoPauseListingWhenHealthPoor &&
          other.safetyStockBuffer == this.safetyStockBuffer &&
          other.customerAbuseMaxReturnRatePercent ==
              this.customerAbuseMaxReturnRatePercent &&
          other.customerAbuseMaxComplaintRatePercent ==
              this.customerAbuseMaxComplaintRatePercent &&
          other.priceRefreshIntervalMinutesBySourceJson ==
              this.priceRefreshIntervalMinutesBySourceJson);
}

class UserRulesTableCompanion extends UpdateCompanion<UserRulesRow> {
  final Value<int> id;
  final Value<int> tenantId;
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
  final Value<String> marketplaceFeesJson;
  final Value<String> paymentFeesJson;
  final Value<String?> sellerReturnAddressJson;
  final Value<String> marketplaceReturnPolicyJson;
  final Value<bool> targetsReadOnly;
  final Value<String> pricingStrategy;
  final Value<String> categoryMinProfitPercentJson;
  final Value<double> premiumWhenBetterReviewsPercent;
  final Value<int> minSalesCountForPremium;
  final Value<bool> kpiDrivenStrategyEnabled;
  final Value<String> rateLimitMaxRequestsPerSecondJson;
  final Value<String?> incidentRulesJson;
  final Value<double?> riskScoreThreshold;
  final Value<double?> defaultReturnRatePercent;
  final Value<double?> defaultReturnCostPerUnit;
  final Value<bool> blockFulfillWhenInsufficientStock;
  final Value<bool> autoPauseListingWhenMarginBelowThreshold;
  final Value<int> defaultSupplierProcessingDays;
  final Value<int> defaultSupplierShippingDays;
  final Value<int?> marketplaceMaxDeliveryDays;
  final Value<double?> listingHealthMaxReturnRatePercent;
  final Value<double?> listingHealthMaxLateRatePercent;
  final Value<bool> autoPauseListingWhenHealthPoor;
  final Value<int> safetyStockBuffer;
  final Value<double?> customerAbuseMaxReturnRatePercent;
  final Value<double?> customerAbuseMaxComplaintRatePercent;
  final Value<String> priceRefreshIntervalMinutesBySourceJson;
  const UserRulesTableCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
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
    this.marketplaceFeesJson = const Value.absent(),
    this.paymentFeesJson = const Value.absent(),
    this.sellerReturnAddressJson = const Value.absent(),
    this.marketplaceReturnPolicyJson = const Value.absent(),
    this.targetsReadOnly = const Value.absent(),
    this.pricingStrategy = const Value.absent(),
    this.categoryMinProfitPercentJson = const Value.absent(),
    this.premiumWhenBetterReviewsPercent = const Value.absent(),
    this.minSalesCountForPremium = const Value.absent(),
    this.kpiDrivenStrategyEnabled = const Value.absent(),
    this.rateLimitMaxRequestsPerSecondJson = const Value.absent(),
    this.incidentRulesJson = const Value.absent(),
    this.riskScoreThreshold = const Value.absent(),
    this.defaultReturnRatePercent = const Value.absent(),
    this.defaultReturnCostPerUnit = const Value.absent(),
    this.blockFulfillWhenInsufficientStock = const Value.absent(),
    this.autoPauseListingWhenMarginBelowThreshold = const Value.absent(),
    this.defaultSupplierProcessingDays = const Value.absent(),
    this.defaultSupplierShippingDays = const Value.absent(),
    this.marketplaceMaxDeliveryDays = const Value.absent(),
    this.listingHealthMaxReturnRatePercent = const Value.absent(),
    this.listingHealthMaxLateRatePercent = const Value.absent(),
    this.autoPauseListingWhenHealthPoor = const Value.absent(),
    this.safetyStockBuffer = const Value.absent(),
    this.customerAbuseMaxReturnRatePercent = const Value.absent(),
    this.customerAbuseMaxComplaintRatePercent = const Value.absent(),
    this.priceRefreshIntervalMinutesBySourceJson = const Value.absent(),
  });
  UserRulesTableCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
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
    this.marketplaceFeesJson = const Value.absent(),
    this.paymentFeesJson = const Value.absent(),
    this.sellerReturnAddressJson = const Value.absent(),
    this.marketplaceReturnPolicyJson = const Value.absent(),
    this.targetsReadOnly = const Value.absent(),
    this.pricingStrategy = const Value.absent(),
    this.categoryMinProfitPercentJson = const Value.absent(),
    this.premiumWhenBetterReviewsPercent = const Value.absent(),
    this.minSalesCountForPremium = const Value.absent(),
    this.kpiDrivenStrategyEnabled = const Value.absent(),
    this.rateLimitMaxRequestsPerSecondJson = const Value.absent(),
    this.incidentRulesJson = const Value.absent(),
    this.riskScoreThreshold = const Value.absent(),
    this.defaultReturnRatePercent = const Value.absent(),
    this.defaultReturnCostPerUnit = const Value.absent(),
    this.blockFulfillWhenInsufficientStock = const Value.absent(),
    this.autoPauseListingWhenMarginBelowThreshold = const Value.absent(),
    this.defaultSupplierProcessingDays = const Value.absent(),
    this.defaultSupplierShippingDays = const Value.absent(),
    this.marketplaceMaxDeliveryDays = const Value.absent(),
    this.listingHealthMaxReturnRatePercent = const Value.absent(),
    this.listingHealthMaxLateRatePercent = const Value.absent(),
    this.autoPauseListingWhenHealthPoor = const Value.absent(),
    this.safetyStockBuffer = const Value.absent(),
    this.customerAbuseMaxReturnRatePercent = const Value.absent(),
    this.customerAbuseMaxComplaintRatePercent = const Value.absent(),
    this.priceRefreshIntervalMinutesBySourceJson = const Value.absent(),
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
    Expression<int>? tenantId,
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
    Expression<String>? marketplaceFeesJson,
    Expression<String>? paymentFeesJson,
    Expression<String>? sellerReturnAddressJson,
    Expression<String>? marketplaceReturnPolicyJson,
    Expression<bool>? targetsReadOnly,
    Expression<String>? pricingStrategy,
    Expression<String>? categoryMinProfitPercentJson,
    Expression<double>? premiumWhenBetterReviewsPercent,
    Expression<int>? minSalesCountForPremium,
    Expression<bool>? kpiDrivenStrategyEnabled,
    Expression<String>? rateLimitMaxRequestsPerSecondJson,
    Expression<String>? incidentRulesJson,
    Expression<double>? riskScoreThreshold,
    Expression<double>? defaultReturnRatePercent,
    Expression<double>? defaultReturnCostPerUnit,
    Expression<bool>? blockFulfillWhenInsufficientStock,
    Expression<bool>? autoPauseListingWhenMarginBelowThreshold,
    Expression<int>? defaultSupplierProcessingDays,
    Expression<int>? defaultSupplierShippingDays,
    Expression<int>? marketplaceMaxDeliveryDays,
    Expression<double>? listingHealthMaxReturnRatePercent,
    Expression<double>? listingHealthMaxLateRatePercent,
    Expression<bool>? autoPauseListingWhenHealthPoor,
    Expression<int>? safetyStockBuffer,
    Expression<double>? customerAbuseMaxReturnRatePercent,
    Expression<double>? customerAbuseMaxComplaintRatePercent,
    Expression<String>? priceRefreshIntervalMinutesBySourceJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
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
      if (marketplaceFeesJson != null)
        'marketplace_fees_json': marketplaceFeesJson,
      if (paymentFeesJson != null) 'payment_fees_json': paymentFeesJson,
      if (sellerReturnAddressJson != null)
        'seller_return_address_json': sellerReturnAddressJson,
      if (marketplaceReturnPolicyJson != null)
        'marketplace_return_policy_json': marketplaceReturnPolicyJson,
      if (targetsReadOnly != null) 'targets_read_only': targetsReadOnly,
      if (pricingStrategy != null) 'pricing_strategy': pricingStrategy,
      if (categoryMinProfitPercentJson != null)
        'category_min_profit_percent_json': categoryMinProfitPercentJson,
      if (premiumWhenBetterReviewsPercent != null)
        'premium_when_better_reviews_percent': premiumWhenBetterReviewsPercent,
      if (minSalesCountForPremium != null)
        'min_sales_count_for_premium': minSalesCountForPremium,
      if (kpiDrivenStrategyEnabled != null)
        'kpi_driven_strategy_enabled': kpiDrivenStrategyEnabled,
      if (rateLimitMaxRequestsPerSecondJson != null)
        'rate_limit_max_requests_per_second_json':
            rateLimitMaxRequestsPerSecondJson,
      if (incidentRulesJson != null) 'incident_rules_json': incidentRulesJson,
      if (riskScoreThreshold != null)
        'risk_score_threshold': riskScoreThreshold,
      if (defaultReturnRatePercent != null)
        'default_return_rate_percent': defaultReturnRatePercent,
      if (defaultReturnCostPerUnit != null)
        'default_return_cost_per_unit': defaultReturnCostPerUnit,
      if (blockFulfillWhenInsufficientStock != null)
        'block_fulfill_when_insufficient_stock':
            blockFulfillWhenInsufficientStock,
      if (autoPauseListingWhenMarginBelowThreshold != null)
        'auto_pause_listing_when_margin_below_threshold':
            autoPauseListingWhenMarginBelowThreshold,
      if (defaultSupplierProcessingDays != null)
        'default_supplier_processing_days': defaultSupplierProcessingDays,
      if (defaultSupplierShippingDays != null)
        'default_supplier_shipping_days': defaultSupplierShippingDays,
      if (marketplaceMaxDeliveryDays != null)
        'marketplace_max_delivery_days': marketplaceMaxDeliveryDays,
      if (listingHealthMaxReturnRatePercent != null)
        'listing_health_max_return_rate_percent':
            listingHealthMaxReturnRatePercent,
      if (listingHealthMaxLateRatePercent != null)
        'listing_health_max_late_rate_percent': listingHealthMaxLateRatePercent,
      if (autoPauseListingWhenHealthPoor != null)
        'auto_pause_listing_when_health_poor': autoPauseListingWhenHealthPoor,
      if (safetyStockBuffer != null) 'safety_stock_buffer': safetyStockBuffer,
      if (customerAbuseMaxReturnRatePercent != null)
        'customer_abuse_max_return_rate_percent':
            customerAbuseMaxReturnRatePercent,
      if (customerAbuseMaxComplaintRatePercent != null)
        'customer_abuse_max_complaint_rate_percent':
            customerAbuseMaxComplaintRatePercent,
      if (priceRefreshIntervalMinutesBySourceJson != null)
        'price_refresh_interval_minutes_by_source_json':
            priceRefreshIntervalMinutesBySourceJson,
    });
  }

  UserRulesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
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
    Value<String>? marketplaceFeesJson,
    Value<String>? paymentFeesJson,
    Value<String?>? sellerReturnAddressJson,
    Value<String>? marketplaceReturnPolicyJson,
    Value<bool>? targetsReadOnly,
    Value<String>? pricingStrategy,
    Value<String>? categoryMinProfitPercentJson,
    Value<double>? premiumWhenBetterReviewsPercent,
    Value<int>? minSalesCountForPremium,
    Value<bool>? kpiDrivenStrategyEnabled,
    Value<String>? rateLimitMaxRequestsPerSecondJson,
    Value<String?>? incidentRulesJson,
    Value<double?>? riskScoreThreshold,
    Value<double?>? defaultReturnRatePercent,
    Value<double?>? defaultReturnCostPerUnit,
    Value<bool>? blockFulfillWhenInsufficientStock,
    Value<bool>? autoPauseListingWhenMarginBelowThreshold,
    Value<int>? defaultSupplierProcessingDays,
    Value<int>? defaultSupplierShippingDays,
    Value<int?>? marketplaceMaxDeliveryDays,
    Value<double?>? listingHealthMaxReturnRatePercent,
    Value<double?>? listingHealthMaxLateRatePercent,
    Value<bool>? autoPauseListingWhenHealthPoor,
    Value<int>? safetyStockBuffer,
    Value<double?>? customerAbuseMaxReturnRatePercent,
    Value<double?>? customerAbuseMaxComplaintRatePercent,
    Value<String>? priceRefreshIntervalMinutesBySourceJson,
  }) {
    return UserRulesTableCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
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
      marketplaceFeesJson: marketplaceFeesJson ?? this.marketplaceFeesJson,
      paymentFeesJson: paymentFeesJson ?? this.paymentFeesJson,
      sellerReturnAddressJson:
          sellerReturnAddressJson ?? this.sellerReturnAddressJson,
      marketplaceReturnPolicyJson:
          marketplaceReturnPolicyJson ?? this.marketplaceReturnPolicyJson,
      targetsReadOnly: targetsReadOnly ?? this.targetsReadOnly,
      pricingStrategy: pricingStrategy ?? this.pricingStrategy,
      categoryMinProfitPercentJson:
          categoryMinProfitPercentJson ?? this.categoryMinProfitPercentJson,
      premiumWhenBetterReviewsPercent:
          premiumWhenBetterReviewsPercent ??
          this.premiumWhenBetterReviewsPercent,
      minSalesCountForPremium:
          minSalesCountForPremium ?? this.minSalesCountForPremium,
      kpiDrivenStrategyEnabled:
          kpiDrivenStrategyEnabled ?? this.kpiDrivenStrategyEnabled,
      rateLimitMaxRequestsPerSecondJson:
          rateLimitMaxRequestsPerSecondJson ??
          this.rateLimitMaxRequestsPerSecondJson,
      incidentRulesJson: incidentRulesJson ?? this.incidentRulesJson,
      riskScoreThreshold: riskScoreThreshold ?? this.riskScoreThreshold,
      defaultReturnRatePercent:
          defaultReturnRatePercent ?? this.defaultReturnRatePercent,
      defaultReturnCostPerUnit:
          defaultReturnCostPerUnit ?? this.defaultReturnCostPerUnit,
      blockFulfillWhenInsufficientStock:
          blockFulfillWhenInsufficientStock ??
          this.blockFulfillWhenInsufficientStock,
      autoPauseListingWhenMarginBelowThreshold:
          autoPauseListingWhenMarginBelowThreshold ??
          this.autoPauseListingWhenMarginBelowThreshold,
      defaultSupplierProcessingDays:
          defaultSupplierProcessingDays ?? this.defaultSupplierProcessingDays,
      defaultSupplierShippingDays:
          defaultSupplierShippingDays ?? this.defaultSupplierShippingDays,
      marketplaceMaxDeliveryDays:
          marketplaceMaxDeliveryDays ?? this.marketplaceMaxDeliveryDays,
      listingHealthMaxReturnRatePercent:
          listingHealthMaxReturnRatePercent ??
          this.listingHealthMaxReturnRatePercent,
      listingHealthMaxLateRatePercent:
          listingHealthMaxLateRatePercent ??
          this.listingHealthMaxLateRatePercent,
      autoPauseListingWhenHealthPoor:
          autoPauseListingWhenHealthPoor ?? this.autoPauseListingWhenHealthPoor,
      safetyStockBuffer: safetyStockBuffer ?? this.safetyStockBuffer,
      customerAbuseMaxReturnRatePercent:
          customerAbuseMaxReturnRatePercent ??
          this.customerAbuseMaxReturnRatePercent,
      customerAbuseMaxComplaintRatePercent:
          customerAbuseMaxComplaintRatePercent ??
          this.customerAbuseMaxComplaintRatePercent,
      priceRefreshIntervalMinutesBySourceJson:
          priceRefreshIntervalMinutesBySourceJson ??
          this.priceRefreshIntervalMinutesBySourceJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
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
    if (marketplaceFeesJson.present) {
      map['marketplace_fees_json'] = Variable<String>(
        marketplaceFeesJson.value,
      );
    }
    if (paymentFeesJson.present) {
      map['payment_fees_json'] = Variable<String>(paymentFeesJson.value);
    }
    if (sellerReturnAddressJson.present) {
      map['seller_return_address_json'] = Variable<String>(
        sellerReturnAddressJson.value,
      );
    }
    if (marketplaceReturnPolicyJson.present) {
      map['marketplace_return_policy_json'] = Variable<String>(
        marketplaceReturnPolicyJson.value,
      );
    }
    if (targetsReadOnly.present) {
      map['targets_read_only'] = Variable<bool>(targetsReadOnly.value);
    }
    if (pricingStrategy.present) {
      map['pricing_strategy'] = Variable<String>(pricingStrategy.value);
    }
    if (categoryMinProfitPercentJson.present) {
      map['category_min_profit_percent_json'] = Variable<String>(
        categoryMinProfitPercentJson.value,
      );
    }
    if (premiumWhenBetterReviewsPercent.present) {
      map['premium_when_better_reviews_percent'] = Variable<double>(
        premiumWhenBetterReviewsPercent.value,
      );
    }
    if (minSalesCountForPremium.present) {
      map['min_sales_count_for_premium'] = Variable<int>(
        minSalesCountForPremium.value,
      );
    }
    if (kpiDrivenStrategyEnabled.present) {
      map['kpi_driven_strategy_enabled'] = Variable<bool>(
        kpiDrivenStrategyEnabled.value,
      );
    }
    if (rateLimitMaxRequestsPerSecondJson.present) {
      map['rate_limit_max_requests_per_second_json'] = Variable<String>(
        rateLimitMaxRequestsPerSecondJson.value,
      );
    }
    if (incidentRulesJson.present) {
      map['incident_rules_json'] = Variable<String>(incidentRulesJson.value);
    }
    if (riskScoreThreshold.present) {
      map['risk_score_threshold'] = Variable<double>(riskScoreThreshold.value);
    }
    if (defaultReturnRatePercent.present) {
      map['default_return_rate_percent'] = Variable<double>(
        defaultReturnRatePercent.value,
      );
    }
    if (defaultReturnCostPerUnit.present) {
      map['default_return_cost_per_unit'] = Variable<double>(
        defaultReturnCostPerUnit.value,
      );
    }
    if (blockFulfillWhenInsufficientStock.present) {
      map['block_fulfill_when_insufficient_stock'] = Variable<bool>(
        blockFulfillWhenInsufficientStock.value,
      );
    }
    if (autoPauseListingWhenMarginBelowThreshold.present) {
      map['auto_pause_listing_when_margin_below_threshold'] = Variable<bool>(
        autoPauseListingWhenMarginBelowThreshold.value,
      );
    }
    if (defaultSupplierProcessingDays.present) {
      map['default_supplier_processing_days'] = Variable<int>(
        defaultSupplierProcessingDays.value,
      );
    }
    if (defaultSupplierShippingDays.present) {
      map['default_supplier_shipping_days'] = Variable<int>(
        defaultSupplierShippingDays.value,
      );
    }
    if (marketplaceMaxDeliveryDays.present) {
      map['marketplace_max_delivery_days'] = Variable<int>(
        marketplaceMaxDeliveryDays.value,
      );
    }
    if (listingHealthMaxReturnRatePercent.present) {
      map['listing_health_max_return_rate_percent'] = Variable<double>(
        listingHealthMaxReturnRatePercent.value,
      );
    }
    if (listingHealthMaxLateRatePercent.present) {
      map['listing_health_max_late_rate_percent'] = Variable<double>(
        listingHealthMaxLateRatePercent.value,
      );
    }
    if (autoPauseListingWhenHealthPoor.present) {
      map['auto_pause_listing_when_health_poor'] = Variable<bool>(
        autoPauseListingWhenHealthPoor.value,
      );
    }
    if (safetyStockBuffer.present) {
      map['safety_stock_buffer'] = Variable<int>(safetyStockBuffer.value);
    }
    if (customerAbuseMaxReturnRatePercent.present) {
      map['customer_abuse_max_return_rate_percent'] = Variable<double>(
        customerAbuseMaxReturnRatePercent.value,
      );
    }
    if (customerAbuseMaxComplaintRatePercent.present) {
      map['customer_abuse_max_complaint_rate_percent'] = Variable<double>(
        customerAbuseMaxComplaintRatePercent.value,
      );
    }
    if (priceRefreshIntervalMinutesBySourceJson.present) {
      map['price_refresh_interval_minutes_by_source_json'] = Variable<String>(
        priceRefreshIntervalMinutesBySourceJson.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRulesTableCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('minProfitPercent: $minProfitPercent, ')
          ..write('maxSourcePrice: $maxSourcePrice, ')
          ..write('preferredSupplierCountries: $preferredSupplierCountries, ')
          ..write('manualApprovalListings: $manualApprovalListings, ')
          ..write('manualApprovalOrders: $manualApprovalOrders, ')
          ..write('scanIntervalMinutes: $scanIntervalMinutes, ')
          ..write('blacklistedProductIds: $blacklistedProductIds, ')
          ..write('blacklistedSupplierIds: $blacklistedSupplierIds, ')
          ..write('defaultMarkupPercent: $defaultMarkupPercent, ')
          ..write('searchKeywords: $searchKeywords, ')
          ..write('marketplaceFeesJson: $marketplaceFeesJson, ')
          ..write('paymentFeesJson: $paymentFeesJson, ')
          ..write('sellerReturnAddressJson: $sellerReturnAddressJson, ')
          ..write('marketplaceReturnPolicyJson: $marketplaceReturnPolicyJson, ')
          ..write('targetsReadOnly: $targetsReadOnly, ')
          ..write('pricingStrategy: $pricingStrategy, ')
          ..write(
            'categoryMinProfitPercentJson: $categoryMinProfitPercentJson, ',
          )
          ..write(
            'premiumWhenBetterReviewsPercent: $premiumWhenBetterReviewsPercent, ',
          )
          ..write('minSalesCountForPremium: $minSalesCountForPremium, ')
          ..write('kpiDrivenStrategyEnabled: $kpiDrivenStrategyEnabled, ')
          ..write(
            'rateLimitMaxRequestsPerSecondJson: $rateLimitMaxRequestsPerSecondJson, ',
          )
          ..write('incidentRulesJson: $incidentRulesJson, ')
          ..write('riskScoreThreshold: $riskScoreThreshold, ')
          ..write('defaultReturnRatePercent: $defaultReturnRatePercent, ')
          ..write('defaultReturnCostPerUnit: $defaultReturnCostPerUnit, ')
          ..write(
            'blockFulfillWhenInsufficientStock: $blockFulfillWhenInsufficientStock, ',
          )
          ..write(
            'autoPauseListingWhenMarginBelowThreshold: $autoPauseListingWhenMarginBelowThreshold, ',
          )
          ..write(
            'defaultSupplierProcessingDays: $defaultSupplierProcessingDays, ',
          )
          ..write('defaultSupplierShippingDays: $defaultSupplierShippingDays, ')
          ..write('marketplaceMaxDeliveryDays: $marketplaceMaxDeliveryDays, ')
          ..write(
            'listingHealthMaxReturnRatePercent: $listingHealthMaxReturnRatePercent, ',
          )
          ..write(
            'listingHealthMaxLateRatePercent: $listingHealthMaxLateRatePercent, ',
          )
          ..write(
            'autoPauseListingWhenHealthPoor: $autoPauseListingWhenHealthPoor, ',
          )
          ..write('safetyStockBuffer: $safetyStockBuffer, ')
          ..write(
            'customerAbuseMaxReturnRatePercent: $customerAbuseMaxReturnRatePercent, ',
          )
          ..write(
            'customerAbuseMaxComplaintRatePercent: $customerAbuseMaxComplaintRatePercent, ',
          )
          ..write(
            'priceRefreshIntervalMinutesBySourceJson: $priceRefreshIntervalMinutesBySourceJson',
          )
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _warehouseAddressMeta = const VerificationMeta(
    'warehouseAddress',
  );
  @override
  late final GeneratedColumn<String> warehouseAddress = GeneratedColumn<String>(
    'warehouse_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warehouseCityMeta = const VerificationMeta(
    'warehouseCity',
  );
  @override
  late final GeneratedColumn<String> warehouseCity = GeneratedColumn<String>(
    'warehouse_city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warehouseZipMeta = const VerificationMeta(
    'warehouseZip',
  );
  @override
  late final GeneratedColumn<String> warehouseZip = GeneratedColumn<String>(
    'warehouse_zip',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warehouseCountryMeta = const VerificationMeta(
    'warehouseCountry',
  );
  @override
  late final GeneratedColumn<String> warehouseCountry = GeneratedColumn<String>(
    'warehouse_country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warehousePhoneMeta = const VerificationMeta(
    'warehousePhone',
  );
  @override
  late final GeneratedColumn<String> warehousePhone = GeneratedColumn<String>(
    'warehouse_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warehouseEmailMeta = const VerificationMeta(
    'warehouseEmail',
  );
  @override
  late final GeneratedColumn<String> warehouseEmail = GeneratedColumn<String>(
    'warehouse_email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feedSourceMeta = const VerificationMeta(
    'feedSource',
  );
  @override
  late final GeneratedColumn<String> feedSource = GeneratedColumn<String>(
    'feed_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shopUrlMeta = const VerificationMeta(
    'shopUrl',
  );
  @override
  late final GeneratedColumn<String> shopUrl = GeneratedColumn<String>(
    'shop_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    supplierId,
    name,
    platformType,
    countryCode,
    rating,
    returnWindowDays,
    returnShippingCost,
    restockingFeePercent,
    acceptsNoReasonReturns,
    warehouseAddress,
    warehouseCity,
    warehouseZip,
    warehouseCountry,
    warehousePhone,
    warehouseEmail,
    feedSource,
    shopUrl,
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
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
    if (data.containsKey('warehouse_address')) {
      context.handle(
        _warehouseAddressMeta,
        warehouseAddress.isAcceptableOrUnknown(
          data['warehouse_address']!,
          _warehouseAddressMeta,
        ),
      );
    }
    if (data.containsKey('warehouse_city')) {
      context.handle(
        _warehouseCityMeta,
        warehouseCity.isAcceptableOrUnknown(
          data['warehouse_city']!,
          _warehouseCityMeta,
        ),
      );
    }
    if (data.containsKey('warehouse_zip')) {
      context.handle(
        _warehouseZipMeta,
        warehouseZip.isAcceptableOrUnknown(
          data['warehouse_zip']!,
          _warehouseZipMeta,
        ),
      );
    }
    if (data.containsKey('warehouse_country')) {
      context.handle(
        _warehouseCountryMeta,
        warehouseCountry.isAcceptableOrUnknown(
          data['warehouse_country']!,
          _warehouseCountryMeta,
        ),
      );
    }
    if (data.containsKey('warehouse_phone')) {
      context.handle(
        _warehousePhoneMeta,
        warehousePhone.isAcceptableOrUnknown(
          data['warehouse_phone']!,
          _warehousePhoneMeta,
        ),
      );
    }
    if (data.containsKey('warehouse_email')) {
      context.handle(
        _warehouseEmailMeta,
        warehouseEmail.isAcceptableOrUnknown(
          data['warehouse_email']!,
          _warehouseEmailMeta,
        ),
      );
    }
    if (data.containsKey('feed_source')) {
      context.handle(
        _feedSourceMeta,
        feedSource.isAcceptableOrUnknown(data['feed_source']!, _feedSourceMeta),
      );
    }
    if (data.containsKey('shop_url')) {
      context.handle(
        _shopUrlMeta,
        shopUrl.isAcceptableOrUnknown(data['shop_url']!, _shopUrlMeta),
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
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
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
      warehouseAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_address'],
      ),
      warehouseCity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_city'],
      ),
      warehouseZip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_zip'],
      ),
      warehouseCountry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_country'],
      ),
      warehousePhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_phone'],
      ),
      warehouseEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_email'],
      ),
      feedSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feed_source'],
      ),
      shopUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_url'],
      ),
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class SupplierRow extends DataClass implements Insertable<SupplierRow> {
  final int id;
  final int tenantId;
  final String supplierId;
  final String name;
  final String platformType;
  final String? countryCode;
  final double? rating;
  final int? returnWindowDays;
  final double? returnShippingCost;
  final double? restockingFeePercent;
  final bool acceptsNoReasonReturns;
  final String? warehouseAddress;
  final String? warehouseCity;
  final String? warehouseZip;
  final String? warehouseCountry;
  final String? warehousePhone;
  final String? warehouseEmail;
  final String? feedSource;
  final String? shopUrl;
  const SupplierRow({
    required this.id,
    required this.tenantId,
    required this.supplierId,
    required this.name,
    required this.platformType,
    this.countryCode,
    this.rating,
    this.returnWindowDays,
    this.returnShippingCost,
    this.restockingFeePercent,
    required this.acceptsNoReasonReturns,
    this.warehouseAddress,
    this.warehouseCity,
    this.warehouseZip,
    this.warehouseCountry,
    this.warehousePhone,
    this.warehouseEmail,
    this.feedSource,
    this.shopUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
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
    if (!nullToAbsent || warehouseAddress != null) {
      map['warehouse_address'] = Variable<String>(warehouseAddress);
    }
    if (!nullToAbsent || warehouseCity != null) {
      map['warehouse_city'] = Variable<String>(warehouseCity);
    }
    if (!nullToAbsent || warehouseZip != null) {
      map['warehouse_zip'] = Variable<String>(warehouseZip);
    }
    if (!nullToAbsent || warehouseCountry != null) {
      map['warehouse_country'] = Variable<String>(warehouseCountry);
    }
    if (!nullToAbsent || warehousePhone != null) {
      map['warehouse_phone'] = Variable<String>(warehousePhone);
    }
    if (!nullToAbsent || warehouseEmail != null) {
      map['warehouse_email'] = Variable<String>(warehouseEmail);
    }
    if (!nullToAbsent || feedSource != null) {
      map['feed_source'] = Variable<String>(feedSource);
    }
    if (!nullToAbsent || shopUrl != null) {
      map['shop_url'] = Variable<String>(shopUrl);
    }
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
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
      warehouseAddress: warehouseAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseAddress),
      warehouseCity: warehouseCity == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseCity),
      warehouseZip: warehouseZip == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseZip),
      warehouseCountry: warehouseCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseCountry),
      warehousePhone: warehousePhone == null && nullToAbsent
          ? const Value.absent()
          : Value(warehousePhone),
      warehouseEmail: warehouseEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseEmail),
      feedSource: feedSource == null && nullToAbsent
          ? const Value.absent()
          : Value(feedSource),
      shopUrl: shopUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(shopUrl),
    );
  }

  factory SupplierRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
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
      warehouseAddress: serializer.fromJson<String?>(json['warehouseAddress']),
      warehouseCity: serializer.fromJson<String?>(json['warehouseCity']),
      warehouseZip: serializer.fromJson<String?>(json['warehouseZip']),
      warehouseCountry: serializer.fromJson<String?>(json['warehouseCountry']),
      warehousePhone: serializer.fromJson<String?>(json['warehousePhone']),
      warehouseEmail: serializer.fromJson<String?>(json['warehouseEmail']),
      feedSource: serializer.fromJson<String?>(json['feedSource']),
      shopUrl: serializer.fromJson<String?>(json['shopUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'supplierId': serializer.toJson<String>(supplierId),
      'name': serializer.toJson<String>(name),
      'platformType': serializer.toJson<String>(platformType),
      'countryCode': serializer.toJson<String?>(countryCode),
      'rating': serializer.toJson<double?>(rating),
      'returnWindowDays': serializer.toJson<int?>(returnWindowDays),
      'returnShippingCost': serializer.toJson<double?>(returnShippingCost),
      'restockingFeePercent': serializer.toJson<double?>(restockingFeePercent),
      'acceptsNoReasonReturns': serializer.toJson<bool>(acceptsNoReasonReturns),
      'warehouseAddress': serializer.toJson<String?>(warehouseAddress),
      'warehouseCity': serializer.toJson<String?>(warehouseCity),
      'warehouseZip': serializer.toJson<String?>(warehouseZip),
      'warehouseCountry': serializer.toJson<String?>(warehouseCountry),
      'warehousePhone': serializer.toJson<String?>(warehousePhone),
      'warehouseEmail': serializer.toJson<String?>(warehouseEmail),
      'feedSource': serializer.toJson<String?>(feedSource),
      'shopUrl': serializer.toJson<String?>(shopUrl),
    };
  }

  SupplierRow copyWith({
    int? id,
    int? tenantId,
    String? supplierId,
    String? name,
    String? platformType,
    Value<String?> countryCode = const Value.absent(),
    Value<double?> rating = const Value.absent(),
    Value<int?> returnWindowDays = const Value.absent(),
    Value<double?> returnShippingCost = const Value.absent(),
    Value<double?> restockingFeePercent = const Value.absent(),
    bool? acceptsNoReasonReturns,
    Value<String?> warehouseAddress = const Value.absent(),
    Value<String?> warehouseCity = const Value.absent(),
    Value<String?> warehouseZip = const Value.absent(),
    Value<String?> warehouseCountry = const Value.absent(),
    Value<String?> warehousePhone = const Value.absent(),
    Value<String?> warehouseEmail = const Value.absent(),
    Value<String?> feedSource = const Value.absent(),
    Value<String?> shopUrl = const Value.absent(),
  }) => SupplierRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
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
    warehouseAddress: warehouseAddress.present
        ? warehouseAddress.value
        : this.warehouseAddress,
    warehouseCity: warehouseCity.present
        ? warehouseCity.value
        : this.warehouseCity,
    warehouseZip: warehouseZip.present ? warehouseZip.value : this.warehouseZip,
    warehouseCountry: warehouseCountry.present
        ? warehouseCountry.value
        : this.warehouseCountry,
    warehousePhone: warehousePhone.present
        ? warehousePhone.value
        : this.warehousePhone,
    warehouseEmail: warehouseEmail.present
        ? warehouseEmail.value
        : this.warehouseEmail,
    feedSource: feedSource.present ? feedSource.value : this.feedSource,
    shopUrl: shopUrl.present ? shopUrl.value : this.shopUrl,
  );
  SupplierRow copyWithCompanion(SuppliersCompanion data) {
    return SupplierRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
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
      warehouseAddress: data.warehouseAddress.present
          ? data.warehouseAddress.value
          : this.warehouseAddress,
      warehouseCity: data.warehouseCity.present
          ? data.warehouseCity.value
          : this.warehouseCity,
      warehouseZip: data.warehouseZip.present
          ? data.warehouseZip.value
          : this.warehouseZip,
      warehouseCountry: data.warehouseCountry.present
          ? data.warehouseCountry.value
          : this.warehouseCountry,
      warehousePhone: data.warehousePhone.present
          ? data.warehousePhone.value
          : this.warehousePhone,
      warehouseEmail: data.warehouseEmail.present
          ? data.warehouseEmail.value
          : this.warehouseEmail,
      feedSource: data.feedSource.present
          ? data.feedSource.value
          : this.feedSource,
      shopUrl: data.shopUrl.present ? data.shopUrl.value : this.shopUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('supplierId: $supplierId, ')
          ..write('name: $name, ')
          ..write('platformType: $platformType, ')
          ..write('countryCode: $countryCode, ')
          ..write('rating: $rating, ')
          ..write('returnWindowDays: $returnWindowDays, ')
          ..write('returnShippingCost: $returnShippingCost, ')
          ..write('restockingFeePercent: $restockingFeePercent, ')
          ..write('acceptsNoReasonReturns: $acceptsNoReasonReturns, ')
          ..write('warehouseAddress: $warehouseAddress, ')
          ..write('warehouseCity: $warehouseCity, ')
          ..write('warehouseZip: $warehouseZip, ')
          ..write('warehouseCountry: $warehouseCountry, ')
          ..write('warehousePhone: $warehousePhone, ')
          ..write('warehouseEmail: $warehouseEmail, ')
          ..write('feedSource: $feedSource, ')
          ..write('shopUrl: $shopUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    supplierId,
    name,
    platformType,
    countryCode,
    rating,
    returnWindowDays,
    returnShippingCost,
    restockingFeePercent,
    acceptsNoReasonReturns,
    warehouseAddress,
    warehouseCity,
    warehouseZip,
    warehouseCountry,
    warehousePhone,
    warehouseEmail,
    feedSource,
    shopUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.supplierId == this.supplierId &&
          other.name == this.name &&
          other.platformType == this.platformType &&
          other.countryCode == this.countryCode &&
          other.rating == this.rating &&
          other.returnWindowDays == this.returnWindowDays &&
          other.returnShippingCost == this.returnShippingCost &&
          other.restockingFeePercent == this.restockingFeePercent &&
          other.acceptsNoReasonReturns == this.acceptsNoReasonReturns &&
          other.warehouseAddress == this.warehouseAddress &&
          other.warehouseCity == this.warehouseCity &&
          other.warehouseZip == this.warehouseZip &&
          other.warehouseCountry == this.warehouseCountry &&
          other.warehousePhone == this.warehousePhone &&
          other.warehouseEmail == this.warehouseEmail &&
          other.feedSource == this.feedSource &&
          other.shopUrl == this.shopUrl);
}

class SuppliersCompanion extends UpdateCompanion<SupplierRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> supplierId;
  final Value<String> name;
  final Value<String> platformType;
  final Value<String?> countryCode;
  final Value<double?> rating;
  final Value<int?> returnWindowDays;
  final Value<double?> returnShippingCost;
  final Value<double?> restockingFeePercent;
  final Value<bool> acceptsNoReasonReturns;
  final Value<String?> warehouseAddress;
  final Value<String?> warehouseCity;
  final Value<String?> warehouseZip;
  final Value<String?> warehouseCountry;
  final Value<String?> warehousePhone;
  final Value<String?> warehouseEmail;
  final Value<String?> feedSource;
  final Value<String?> shopUrl;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.name = const Value.absent(),
    this.platformType = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.rating = const Value.absent(),
    this.returnWindowDays = const Value.absent(),
    this.returnShippingCost = const Value.absent(),
    this.restockingFeePercent = const Value.absent(),
    this.acceptsNoReasonReturns = const Value.absent(),
    this.warehouseAddress = const Value.absent(),
    this.warehouseCity = const Value.absent(),
    this.warehouseZip = const Value.absent(),
    this.warehouseCountry = const Value.absent(),
    this.warehousePhone = const Value.absent(),
    this.warehouseEmail = const Value.absent(),
    this.feedSource = const Value.absent(),
    this.shopUrl = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String supplierId,
    required String name,
    required String platformType,
    this.countryCode = const Value.absent(),
    this.rating = const Value.absent(),
    this.returnWindowDays = const Value.absent(),
    this.returnShippingCost = const Value.absent(),
    this.restockingFeePercent = const Value.absent(),
    this.acceptsNoReasonReturns = const Value.absent(),
    this.warehouseAddress = const Value.absent(),
    this.warehouseCity = const Value.absent(),
    this.warehouseZip = const Value.absent(),
    this.warehouseCountry = const Value.absent(),
    this.warehousePhone = const Value.absent(),
    this.warehouseEmail = const Value.absent(),
    this.feedSource = const Value.absent(),
    this.shopUrl = const Value.absent(),
  }) : supplierId = Value(supplierId),
       name = Value(name),
       platformType = Value(platformType);
  static Insertable<SupplierRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? supplierId,
    Expression<String>? name,
    Expression<String>? platformType,
    Expression<String>? countryCode,
    Expression<double>? rating,
    Expression<int>? returnWindowDays,
    Expression<double>? returnShippingCost,
    Expression<double>? restockingFeePercent,
    Expression<bool>? acceptsNoReasonReturns,
    Expression<String>? warehouseAddress,
    Expression<String>? warehouseCity,
    Expression<String>? warehouseZip,
    Expression<String>? warehouseCountry,
    Expression<String>? warehousePhone,
    Expression<String>? warehouseEmail,
    Expression<String>? feedSource,
    Expression<String>? shopUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
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
      if (warehouseAddress != null) 'warehouse_address': warehouseAddress,
      if (warehouseCity != null) 'warehouse_city': warehouseCity,
      if (warehouseZip != null) 'warehouse_zip': warehouseZip,
      if (warehouseCountry != null) 'warehouse_country': warehouseCountry,
      if (warehousePhone != null) 'warehouse_phone': warehousePhone,
      if (warehouseEmail != null) 'warehouse_email': warehouseEmail,
      if (feedSource != null) 'feed_source': feedSource,
      if (shopUrl != null) 'shop_url': shopUrl,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? supplierId,
    Value<String>? name,
    Value<String>? platformType,
    Value<String?>? countryCode,
    Value<double?>? rating,
    Value<int?>? returnWindowDays,
    Value<double?>? returnShippingCost,
    Value<double?>? restockingFeePercent,
    Value<bool>? acceptsNoReasonReturns,
    Value<String?>? warehouseAddress,
    Value<String?>? warehouseCity,
    Value<String?>? warehouseZip,
    Value<String?>? warehouseCountry,
    Value<String?>? warehousePhone,
    Value<String?>? warehouseEmail,
    Value<String?>? feedSource,
    Value<String?>? shopUrl,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
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
      warehouseAddress: warehouseAddress ?? this.warehouseAddress,
      warehouseCity: warehouseCity ?? this.warehouseCity,
      warehouseZip: warehouseZip ?? this.warehouseZip,
      warehouseCountry: warehouseCountry ?? this.warehouseCountry,
      warehousePhone: warehousePhone ?? this.warehousePhone,
      warehouseEmail: warehouseEmail ?? this.warehouseEmail,
      feedSource: feedSource ?? this.feedSource,
      shopUrl: shopUrl ?? this.shopUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
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
    if (warehouseAddress.present) {
      map['warehouse_address'] = Variable<String>(warehouseAddress.value);
    }
    if (warehouseCity.present) {
      map['warehouse_city'] = Variable<String>(warehouseCity.value);
    }
    if (warehouseZip.present) {
      map['warehouse_zip'] = Variable<String>(warehouseZip.value);
    }
    if (warehouseCountry.present) {
      map['warehouse_country'] = Variable<String>(warehouseCountry.value);
    }
    if (warehousePhone.present) {
      map['warehouse_phone'] = Variable<String>(warehousePhone.value);
    }
    if (warehouseEmail.present) {
      map['warehouse_email'] = Variable<String>(warehouseEmail.value);
    }
    if (feedSource.present) {
      map['feed_source'] = Variable<String>(feedSource.value);
    }
    if (shopUrl.present) {
      map['shop_url'] = Variable<String>(shopUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('supplierId: $supplierId, ')
          ..write('name: $name, ')
          ..write('platformType: $platformType, ')
          ..write('countryCode: $countryCode, ')
          ..write('rating: $rating, ')
          ..write('returnWindowDays: $returnWindowDays, ')
          ..write('returnShippingCost: $returnShippingCost, ')
          ..write('restockingFeePercent: $restockingFeePercent, ')
          ..write('acceptsNoReasonReturns: $acceptsNoReasonReturns, ')
          ..write('warehouseAddress: $warehouseAddress, ')
          ..write('warehouseCity: $warehouseCity, ')
          ..write('warehouseZip: $warehouseZip, ')
          ..write('warehouseCountry: $warehouseCountry, ')
          ..write('warehousePhone: $warehousePhone, ')
          ..write('warehouseEmail: $warehouseEmail, ')
          ..write('feedSource: $feedSource, ')
          ..write('shopUrl: $shopUrl')
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    tenantId,
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
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
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
  final int tenantId;
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
    required this.tenantId,
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
    map['tenant_id'] = Variable<int>(tenantId);
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
      tenantId: Value(tenantId),
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
      tenantId: serializer.fromJson<int>(json['tenantId']),
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
      'tenantId': serializer.toJson<int>(tenantId),
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
    int? tenantId,
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
    tenantId: tenantId ?? this.tenantId,
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
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
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
          ..write('tenantId: $tenantId, ')
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
    tenantId,
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
          other.tenantId == this.tenantId &&
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
  final Value<int> tenantId;
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
    this.tenantId = const Value.absent(),
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
    this.tenantId = const Value.absent(),
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
    Expression<int>? tenantId,
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
      if (tenantId != null) 'tenant_id': tenantId,
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
    Value<int>? tenantId,
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
      tenantId: tenantId ?? this.tenantId,
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
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
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
          ..write('tenantId: $tenantId, ')
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

class $MarketplaceAccountsTable extends MarketplaceAccounts
    with TableInfo<$MarketplaceAccountsTable, MarketplaceAccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MarketplaceAccountsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformIdMeta = const VerificationMeta(
    'platformId',
  );
  @override
  late final GeneratedColumn<String> platformId = GeneratedColumn<String>(
    'platform_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _connectedAtMeta = const VerificationMeta(
    'connectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> connectedAt = GeneratedColumn<DateTime>(
    'connected_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    accountId,
    platformId,
    displayName,
    isActive,
    connectedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'marketplace_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<MarketplaceAccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('platform_id')) {
      context.handle(
        _platformIdMeta,
        platformId.isAcceptableOrUnknown(data['platform_id']!, _platformIdMeta),
      );
    } else if (isInserting) {
      context.missing(_platformIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('connected_at')) {
      context.handle(
        _connectedAtMeta,
        connectedAt.isAcceptableOrUnknown(
          data['connected_at']!,
          _connectedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MarketplaceAccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MarketplaceAccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      platformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      connectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}connected_at'],
      ),
    );
  }

  @override
  $MarketplaceAccountsTable createAlias(String alias) {
    return $MarketplaceAccountsTable(attachedDatabase, alias);
  }
}

class MarketplaceAccountRow extends DataClass
    implements Insertable<MarketplaceAccountRow> {
  final int id;
  final int tenantId;
  final String accountId;
  final String platformId;
  final String displayName;
  final bool isActive;
  final DateTime? connectedAt;
  const MarketplaceAccountRow({
    required this.id,
    required this.tenantId,
    required this.accountId,
    required this.platformId,
    required this.displayName,
    required this.isActive,
    this.connectedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['account_id'] = Variable<String>(accountId);
    map['platform_id'] = Variable<String>(platformId);
    map['display_name'] = Variable<String>(displayName);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || connectedAt != null) {
      map['connected_at'] = Variable<DateTime>(connectedAt);
    }
    return map;
  }

  MarketplaceAccountsCompanion toCompanion(bool nullToAbsent) {
    return MarketplaceAccountsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      accountId: Value(accountId),
      platformId: Value(platformId),
      displayName: Value(displayName),
      isActive: Value(isActive),
      connectedAt: connectedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(connectedAt),
    );
  }

  factory MarketplaceAccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MarketplaceAccountRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      accountId: serializer.fromJson<String>(json['accountId']),
      platformId: serializer.fromJson<String>(json['platformId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      connectedAt: serializer.fromJson<DateTime?>(json['connectedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'accountId': serializer.toJson<String>(accountId),
      'platformId': serializer.toJson<String>(platformId),
      'displayName': serializer.toJson<String>(displayName),
      'isActive': serializer.toJson<bool>(isActive),
      'connectedAt': serializer.toJson<DateTime?>(connectedAt),
    };
  }

  MarketplaceAccountRow copyWith({
    int? id,
    int? tenantId,
    String? accountId,
    String? platformId,
    String? displayName,
    bool? isActive,
    Value<DateTime?> connectedAt = const Value.absent(),
  }) => MarketplaceAccountRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    accountId: accountId ?? this.accountId,
    platformId: platformId ?? this.platformId,
    displayName: displayName ?? this.displayName,
    isActive: isActive ?? this.isActive,
    connectedAt: connectedAt.present ? connectedAt.value : this.connectedAt,
  );
  MarketplaceAccountRow copyWithCompanion(MarketplaceAccountsCompanion data) {
    return MarketplaceAccountRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      platformId: data.platformId.present
          ? data.platformId.value
          : this.platformId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      connectedAt: data.connectedAt.present
          ? data.connectedAt.value
          : this.connectedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MarketplaceAccountRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('accountId: $accountId, ')
          ..write('platformId: $platformId, ')
          ..write('displayName: $displayName, ')
          ..write('isActive: $isActive, ')
          ..write('connectedAt: $connectedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    accountId,
    platformId,
    displayName,
    isActive,
    connectedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MarketplaceAccountRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.accountId == this.accountId &&
          other.platformId == this.platformId &&
          other.displayName == this.displayName &&
          other.isActive == this.isActive &&
          other.connectedAt == this.connectedAt);
}

class MarketplaceAccountsCompanion
    extends UpdateCompanion<MarketplaceAccountRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> accountId;
  final Value<String> platformId;
  final Value<String> displayName;
  final Value<bool> isActive;
  final Value<DateTime?> connectedAt;
  const MarketplaceAccountsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.platformId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.isActive = const Value.absent(),
    this.connectedAt = const Value.absent(),
  });
  MarketplaceAccountsCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String accountId,
    required String platformId,
    required String displayName,
    this.isActive = const Value.absent(),
    this.connectedAt = const Value.absent(),
  }) : accountId = Value(accountId),
       platformId = Value(platformId),
       displayName = Value(displayName);
  static Insertable<MarketplaceAccountRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? accountId,
    Expression<String>? platformId,
    Expression<String>? displayName,
    Expression<bool>? isActive,
    Expression<DateTime>? connectedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (accountId != null) 'account_id': accountId,
      if (platformId != null) 'platform_id': platformId,
      if (displayName != null) 'display_name': displayName,
      if (isActive != null) 'is_active': isActive,
      if (connectedAt != null) 'connected_at': connectedAt,
    });
  }

  MarketplaceAccountsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? accountId,
    Value<String>? platformId,
    Value<String>? displayName,
    Value<bool>? isActive,
    Value<DateTime?>? connectedAt,
  }) {
    return MarketplaceAccountsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      accountId: accountId ?? this.accountId,
      platformId: platformId ?? this.platformId,
      displayName: displayName ?? this.displayName,
      isActive: isActive ?? this.isActive,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (platformId.present) {
      map['platform_id'] = Variable<String>(platformId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (connectedAt.present) {
      map['connected_at'] = Variable<DateTime>(connectedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MarketplaceAccountsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('accountId: $accountId, ')
          ..write('platformId: $platformId, ')
          ..write('displayName: $displayName, ')
          ..write('isActive: $isActive, ')
          ..write('connectedAt: $connectedAt')
          ..write(')'))
        .toString();
  }
}

class $MessageThreadsTable extends MessageThreads
    with TableInfo<$MessageThreadsTable, MessageThreadRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageThreadsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
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
  static const VerificationMeta _marketplaceAccountIdMeta =
      const VerificationMeta('marketplaceAccountId');
  @override
  late final GeneratedColumn<String> marketplaceAccountId =
      GeneratedColumn<String>(
        'marketplace_account_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _externalThreadIdMeta = const VerificationMeta(
    'externalThreadId',
  );
  @override
  late final GeneratedColumn<String> externalThreadId = GeneratedColumn<String>(
    'external_thread_id',
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
  static const VerificationMeta _lastMessageAtMeta = const VerificationMeta(
    'lastMessageAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMessageAt =
      GeneratedColumn<DateTime>(
        'last_message_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    orderId,
    targetPlatformId,
    marketplaceAccountId,
    externalThreadId,
    status,
    lastMessageAt,
    unreadCount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_threads';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageThreadRow> instance, {
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
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
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
    if (data.containsKey('marketplace_account_id')) {
      context.handle(
        _marketplaceAccountIdMeta,
        marketplaceAccountId.isAcceptableOrUnknown(
          data['marketplace_account_id']!,
          _marketplaceAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('external_thread_id')) {
      context.handle(
        _externalThreadIdMeta,
        externalThreadId.isAcceptableOrUnknown(
          data['external_thread_id']!,
          _externalThreadIdMeta,
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
    if (data.containsKey('last_message_at')) {
      context.handle(
        _lastMessageAtMeta,
        lastMessageAt.isAcceptableOrUnknown(
          data['last_message_at']!,
          _lastMessageAtMeta,
        ),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
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
  MessageThreadRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageThreadRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      targetPlatformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_platform_id'],
      )!,
      marketplaceAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marketplace_account_id'],
      ),
      externalThreadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_thread_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MessageThreadsTable createAlias(String alias) {
    return $MessageThreadsTable(attachedDatabase, alias);
  }
}

class MessageThreadRow extends DataClass
    implements Insertable<MessageThreadRow> {
  final int id;
  final String localId;
  final String orderId;
  final String targetPlatformId;
  final String? marketplaceAccountId;
  final String? externalThreadId;
  final String status;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final DateTime createdAt;
  const MessageThreadRow({
    required this.id,
    required this.localId,
    required this.orderId,
    required this.targetPlatformId,
    this.marketplaceAccountId,
    this.externalThreadId,
    required this.status,
    this.lastMessageAt,
    required this.unreadCount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['local_id'] = Variable<String>(localId);
    map['order_id'] = Variable<String>(orderId);
    map['target_platform_id'] = Variable<String>(targetPlatformId);
    if (!nullToAbsent || marketplaceAccountId != null) {
      map['marketplace_account_id'] = Variable<String>(marketplaceAccountId);
    }
    if (!nullToAbsent || externalThreadId != null) {
      map['external_thread_id'] = Variable<String>(externalThreadId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MessageThreadsCompanion toCompanion(bool nullToAbsent) {
    return MessageThreadsCompanion(
      id: Value(id),
      localId: Value(localId),
      orderId: Value(orderId),
      targetPlatformId: Value(targetPlatformId),
      marketplaceAccountId: marketplaceAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(marketplaceAccountId),
      externalThreadId: externalThreadId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalThreadId),
      status: Value(status),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
      unreadCount: Value(unreadCount),
      createdAt: Value(createdAt),
    );
  }

  factory MessageThreadRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageThreadRow(
      id: serializer.fromJson<int>(json['id']),
      localId: serializer.fromJson<String>(json['localId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      targetPlatformId: serializer.fromJson<String>(json['targetPlatformId']),
      marketplaceAccountId: serializer.fromJson<String?>(
        json['marketplaceAccountId'],
      ),
      externalThreadId: serializer.fromJson<String?>(json['externalThreadId']),
      status: serializer.fromJson<String>(json['status']),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'localId': serializer.toJson<String>(localId),
      'orderId': serializer.toJson<String>(orderId),
      'targetPlatformId': serializer.toJson<String>(targetPlatformId),
      'marketplaceAccountId': serializer.toJson<String?>(marketplaceAccountId),
      'externalThreadId': serializer.toJson<String?>(externalThreadId),
      'status': serializer.toJson<String>(status),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MessageThreadRow copyWith({
    int? id,
    String? localId,
    String? orderId,
    String? targetPlatformId,
    Value<String?> marketplaceAccountId = const Value.absent(),
    Value<String?> externalThreadId = const Value.absent(),
    String? status,
    Value<DateTime?> lastMessageAt = const Value.absent(),
    int? unreadCount,
    DateTime? createdAt,
  }) => MessageThreadRow(
    id: id ?? this.id,
    localId: localId ?? this.localId,
    orderId: orderId ?? this.orderId,
    targetPlatformId: targetPlatformId ?? this.targetPlatformId,
    marketplaceAccountId: marketplaceAccountId.present
        ? marketplaceAccountId.value
        : this.marketplaceAccountId,
    externalThreadId: externalThreadId.present
        ? externalThreadId.value
        : this.externalThreadId,
    status: status ?? this.status,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
    unreadCount: unreadCount ?? this.unreadCount,
    createdAt: createdAt ?? this.createdAt,
  );
  MessageThreadRow copyWithCompanion(MessageThreadsCompanion data) {
    return MessageThreadRow(
      id: data.id.present ? data.id.value : this.id,
      localId: data.localId.present ? data.localId.value : this.localId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      targetPlatformId: data.targetPlatformId.present
          ? data.targetPlatformId.value
          : this.targetPlatformId,
      marketplaceAccountId: data.marketplaceAccountId.present
          ? data.marketplaceAccountId.value
          : this.marketplaceAccountId,
      externalThreadId: data.externalThreadId.present
          ? data.externalThreadId.value
          : this.externalThreadId,
      status: data.status.present ? data.status.value : this.status,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageThreadRow(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('orderId: $orderId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('marketplaceAccountId: $marketplaceAccountId, ')
          ..write('externalThreadId: $externalThreadId, ')
          ..write('status: $status, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localId,
    orderId,
    targetPlatformId,
    marketplaceAccountId,
    externalThreadId,
    status,
    lastMessageAt,
    unreadCount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageThreadRow &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.orderId == this.orderId &&
          other.targetPlatformId == this.targetPlatformId &&
          other.marketplaceAccountId == this.marketplaceAccountId &&
          other.externalThreadId == this.externalThreadId &&
          other.status == this.status &&
          other.lastMessageAt == this.lastMessageAt &&
          other.unreadCount == this.unreadCount &&
          other.createdAt == this.createdAt);
}

class MessageThreadsCompanion extends UpdateCompanion<MessageThreadRow> {
  final Value<int> id;
  final Value<String> localId;
  final Value<String> orderId;
  final Value<String> targetPlatformId;
  final Value<String?> marketplaceAccountId;
  final Value<String?> externalThreadId;
  final Value<String> status;
  final Value<DateTime?> lastMessageAt;
  final Value<int> unreadCount;
  final Value<DateTime> createdAt;
  const MessageThreadsCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.targetPlatformId = const Value.absent(),
    this.marketplaceAccountId = const Value.absent(),
    this.externalThreadId = const Value.absent(),
    this.status = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MessageThreadsCompanion.insert({
    this.id = const Value.absent(),
    required String localId,
    required String orderId,
    required String targetPlatformId,
    this.marketplaceAccountId = const Value.absent(),
    this.externalThreadId = const Value.absent(),
    required String status,
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    required DateTime createdAt,
  }) : localId = Value(localId),
       orderId = Value(orderId),
       targetPlatformId = Value(targetPlatformId),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<MessageThreadRow> custom({
    Expression<int>? id,
    Expression<String>? localId,
    Expression<String>? orderId,
    Expression<String>? targetPlatformId,
    Expression<String>? marketplaceAccountId,
    Expression<String>? externalThreadId,
    Expression<String>? status,
    Expression<DateTime>? lastMessageAt,
    Expression<int>? unreadCount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (orderId != null) 'order_id': orderId,
      if (targetPlatformId != null) 'target_platform_id': targetPlatformId,
      if (marketplaceAccountId != null)
        'marketplace_account_id': marketplaceAccountId,
      if (externalThreadId != null) 'external_thread_id': externalThreadId,
      if (status != null) 'status': status,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MessageThreadsCompanion copyWith({
    Value<int>? id,
    Value<String>? localId,
    Value<String>? orderId,
    Value<String>? targetPlatformId,
    Value<String?>? marketplaceAccountId,
    Value<String?>? externalThreadId,
    Value<String>? status,
    Value<DateTime?>? lastMessageAt,
    Value<int>? unreadCount,
    Value<DateTime>? createdAt,
  }) {
    return MessageThreadsCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      orderId: orderId ?? this.orderId,
      targetPlatformId: targetPlatformId ?? this.targetPlatformId,
      marketplaceAccountId: marketplaceAccountId ?? this.marketplaceAccountId,
      externalThreadId: externalThreadId ?? this.externalThreadId,
      status: status ?? this.status,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
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
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (targetPlatformId.present) {
      map['target_platform_id'] = Variable<String>(targetPlatformId.value);
    }
    if (marketplaceAccountId.present) {
      map['marketplace_account_id'] = Variable<String>(
        marketplaceAccountId.value,
      );
    }
    if (externalThreadId.present) {
      map['external_thread_id'] = Variable<String>(externalThreadId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageThreadsCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('orderId: $orderId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('marketplaceAccountId: $marketplaceAccountId, ')
          ..write('externalThreadId: $externalThreadId, ')
          ..write('status: $status, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages
    with TableInfo<$MessagesTable, MessageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _threadLocalIdMeta = const VerificationMeta(
    'threadLocalId',
  );
  @override
  late final GeneratedColumn<String> threadLocalId = GeneratedColumn<String>(
    'thread_local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorLabelMeta = const VerificationMeta(
    'authorLabel',
  );
  @override
  late final GeneratedColumn<String> authorLabel = GeneratedColumn<String>(
    'author_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    threadLocalId,
    direction,
    authorLabel,
    body,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('thread_local_id')) {
      context.handle(
        _threadLocalIdMeta,
        threadLocalId.isAcceptableOrUnknown(
          data['thread_local_id']!,
          _threadLocalIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_threadLocalIdMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('author_label')) {
      context.handle(
        _authorLabelMeta,
        authorLabel.isAcceptableOrUnknown(
          data['author_label']!,
          _authorLabelMeta,
        ),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
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
  MessageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      threadLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thread_local_id'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      authorLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_label'],
      ),
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class MessageRow extends DataClass implements Insertable<MessageRow> {
  final int id;
  final String threadLocalId;
  final String direction;
  final String? authorLabel;
  final String body;
  final DateTime createdAt;
  const MessageRow({
    required this.id,
    required this.threadLocalId,
    required this.direction,
    this.authorLabel,
    required this.body,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['thread_local_id'] = Variable<String>(threadLocalId);
    map['direction'] = Variable<String>(direction);
    if (!nullToAbsent || authorLabel != null) {
      map['author_label'] = Variable<String>(authorLabel);
    }
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      threadLocalId: Value(threadLocalId),
      direction: Value(direction),
      authorLabel: authorLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(authorLabel),
      body: Value(body),
      createdAt: Value(createdAt),
    );
  }

  factory MessageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageRow(
      id: serializer.fromJson<int>(json['id']),
      threadLocalId: serializer.fromJson<String>(json['threadLocalId']),
      direction: serializer.fromJson<String>(json['direction']),
      authorLabel: serializer.fromJson<String?>(json['authorLabel']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'threadLocalId': serializer.toJson<String>(threadLocalId),
      'direction': serializer.toJson<String>(direction),
      'authorLabel': serializer.toJson<String?>(authorLabel),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MessageRow copyWith({
    int? id,
    String? threadLocalId,
    String? direction,
    Value<String?> authorLabel = const Value.absent(),
    String? body,
    DateTime? createdAt,
  }) => MessageRow(
    id: id ?? this.id,
    threadLocalId: threadLocalId ?? this.threadLocalId,
    direction: direction ?? this.direction,
    authorLabel: authorLabel.present ? authorLabel.value : this.authorLabel,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
  );
  MessageRow copyWithCompanion(MessagesCompanion data) {
    return MessageRow(
      id: data.id.present ? data.id.value : this.id,
      threadLocalId: data.threadLocalId.present
          ? data.threadLocalId.value
          : this.threadLocalId,
      direction: data.direction.present ? data.direction.value : this.direction,
      authorLabel: data.authorLabel.present
          ? data.authorLabel.value
          : this.authorLabel,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageRow(')
          ..write('id: $id, ')
          ..write('threadLocalId: $threadLocalId, ')
          ..write('direction: $direction, ')
          ..write('authorLabel: $authorLabel, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, threadLocalId, direction, authorLabel, body, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageRow &&
          other.id == this.id &&
          other.threadLocalId == this.threadLocalId &&
          other.direction == this.direction &&
          other.authorLabel == this.authorLabel &&
          other.body == this.body &&
          other.createdAt == this.createdAt);
}

class MessagesCompanion extends UpdateCompanion<MessageRow> {
  final Value<int> id;
  final Value<String> threadLocalId;
  final Value<String> direction;
  final Value<String?> authorLabel;
  final Value<String> body;
  final Value<DateTime> createdAt;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.threadLocalId = const Value.absent(),
    this.direction = const Value.absent(),
    this.authorLabel = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required String threadLocalId,
    required String direction,
    this.authorLabel = const Value.absent(),
    required String body,
    required DateTime createdAt,
  }) : threadLocalId = Value(threadLocalId),
       direction = Value(direction),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<MessageRow> custom({
    Expression<int>? id,
    Expression<String>? threadLocalId,
    Expression<String>? direction,
    Expression<String>? authorLabel,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (threadLocalId != null) 'thread_local_id': threadLocalId,
      if (direction != null) 'direction': direction,
      if (authorLabel != null) 'author_label': authorLabel,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? id,
    Value<String>? threadLocalId,
    Value<String>? direction,
    Value<String?>? authorLabel,
    Value<String>? body,
    Value<DateTime>? createdAt,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      threadLocalId: threadLocalId ?? this.threadLocalId,
      direction: direction ?? this.direction,
      authorLabel: authorLabel ?? this.authorLabel,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (threadLocalId.present) {
      map['thread_local_id'] = Variable<String>(threadLocalId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (authorLabel.present) {
      map['author_label'] = Variable<String>(authorLabel.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('threadLocalId: $threadLocalId, ')
          ..write('direction: $direction, ')
          ..write('authorLabel: $authorLabel, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReturnsTable extends Returns with TableInfo<$ReturnsTable, ReturnRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _returnIdMeta = const VerificationMeta(
    'returnId',
  );
  @override
  late final GeneratedColumn<String> returnId = GeneratedColumn<String>(
    'return_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refundAmountMeta = const VerificationMeta(
    'refundAmount',
  );
  @override
  late final GeneratedColumn<double> refundAmount = GeneratedColumn<double>(
    'refund_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
  static const VerificationMeta _restockingFeeMeta = const VerificationMeta(
    'restockingFee',
  );
  @override
  late final GeneratedColumn<double> restockingFee = GeneratedColumn<double>(
    'restocking_fee',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requestedAtMeta = const VerificationMeta(
    'requestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> requestedAt = GeneratedColumn<DateTime>(
    'requested_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnToAddressMeta = const VerificationMeta(
    'returnToAddress',
  );
  @override
  late final GeneratedColumn<String> returnToAddress = GeneratedColumn<String>(
    'return_to_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnToCityMeta = const VerificationMeta(
    'returnToCity',
  );
  @override
  late final GeneratedColumn<String> returnToCity = GeneratedColumn<String>(
    'return_to_city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnToCountryMeta = const VerificationMeta(
    'returnToCountry',
  );
  @override
  late final GeneratedColumn<String> returnToCountry = GeneratedColumn<String>(
    'return_to_country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnTrackingNumberMeta =
      const VerificationMeta('returnTrackingNumber');
  @override
  late final GeneratedColumn<String> returnTrackingNumber =
      GeneratedColumn<String>(
        'return_tracking_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _returnCarrierMeta = const VerificationMeta(
    'returnCarrier',
  );
  @override
  late final GeneratedColumn<String> returnCarrier = GeneratedColumn<String>(
    'return_carrier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourcePlatformIdMeta = const VerificationMeta(
    'sourcePlatformId',
  );
  @override
  late final GeneratedColumn<String> sourcePlatformId = GeneratedColumn<String>(
    'source_platform_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetPlatformIdMeta = const VerificationMeta(
    'targetPlatformId',
  );
  @override
  late final GeneratedColumn<String> targetPlatformId = GeneratedColumn<String>(
    'target_platform_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnDestinationMeta = const VerificationMeta(
    'returnDestination',
  );
  @override
  late final GeneratedColumn<String> returnDestination =
      GeneratedColumn<String>(
        'return_destination',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _returnRoutingDestinationMeta =
      const VerificationMeta('returnRoutingDestination');
  @override
  late final GeneratedColumn<String> returnRoutingDestination =
      GeneratedColumn<String>(
        'return_routing_destination',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    returnId,
    orderId,
    reason,
    status,
    notes,
    refundAmount,
    returnShippingCost,
    restockingFee,
    requestedAt,
    resolvedAt,
    returnToAddress,
    returnToCity,
    returnToCountry,
    returnTrackingNumber,
    returnCarrier,
    supplierId,
    productId,
    sourcePlatformId,
    targetPlatformId,
    returnDestination,
    returnRoutingDestination,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'returns';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('return_id')) {
      context.handle(
        _returnIdMeta,
        returnId.isAcceptableOrUnknown(data['return_id']!, _returnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_returnIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('refund_amount')) {
      context.handle(
        _refundAmountMeta,
        refundAmount.isAcceptableOrUnknown(
          data['refund_amount']!,
          _refundAmountMeta,
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
    if (data.containsKey('restocking_fee')) {
      context.handle(
        _restockingFeeMeta,
        restockingFee.isAcceptableOrUnknown(
          data['restocking_fee']!,
          _restockingFeeMeta,
        ),
      );
    }
    if (data.containsKey('requested_at')) {
      context.handle(
        _requestedAtMeta,
        requestedAt.isAcceptableOrUnknown(
          data['requested_at']!,
          _requestedAtMeta,
        ),
      );
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    if (data.containsKey('return_to_address')) {
      context.handle(
        _returnToAddressMeta,
        returnToAddress.isAcceptableOrUnknown(
          data['return_to_address']!,
          _returnToAddressMeta,
        ),
      );
    }
    if (data.containsKey('return_to_city')) {
      context.handle(
        _returnToCityMeta,
        returnToCity.isAcceptableOrUnknown(
          data['return_to_city']!,
          _returnToCityMeta,
        ),
      );
    }
    if (data.containsKey('return_to_country')) {
      context.handle(
        _returnToCountryMeta,
        returnToCountry.isAcceptableOrUnknown(
          data['return_to_country']!,
          _returnToCountryMeta,
        ),
      );
    }
    if (data.containsKey('return_tracking_number')) {
      context.handle(
        _returnTrackingNumberMeta,
        returnTrackingNumber.isAcceptableOrUnknown(
          data['return_tracking_number']!,
          _returnTrackingNumberMeta,
        ),
      );
    }
    if (data.containsKey('return_carrier')) {
      context.handle(
        _returnCarrierMeta,
        returnCarrier.isAcceptableOrUnknown(
          data['return_carrier']!,
          _returnCarrierMeta,
        ),
      );
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('source_platform_id')) {
      context.handle(
        _sourcePlatformIdMeta,
        sourcePlatformId.isAcceptableOrUnknown(
          data['source_platform_id']!,
          _sourcePlatformIdMeta,
        ),
      );
    }
    if (data.containsKey('target_platform_id')) {
      context.handle(
        _targetPlatformIdMeta,
        targetPlatformId.isAcceptableOrUnknown(
          data['target_platform_id']!,
          _targetPlatformIdMeta,
        ),
      );
    }
    if (data.containsKey('return_destination')) {
      context.handle(
        _returnDestinationMeta,
        returnDestination.isAcceptableOrUnknown(
          data['return_destination']!,
          _returnDestinationMeta,
        ),
      );
    }
    if (data.containsKey('return_routing_destination')) {
      context.handle(
        _returnRoutingDestinationMeta,
        returnRoutingDestination.isAcceptableOrUnknown(
          data['return_routing_destination']!,
          _returnRoutingDestinationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      returnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      refundAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_amount'],
      ),
      returnShippingCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}return_shipping_cost'],
      ),
      restockingFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}restocking_fee'],
      ),
      requestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}requested_at'],
      ),
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
      returnToAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_to_address'],
      ),
      returnToCity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_to_city'],
      ),
      returnToCountry: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_to_country'],
      ),
      returnTrackingNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_tracking_number'],
      ),
      returnCarrier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_carrier'],
      ),
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      ),
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      sourcePlatformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_platform_id'],
      ),
      targetPlatformId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_platform_id'],
      ),
      returnDestination: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_destination'],
      ),
      returnRoutingDestination: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_routing_destination'],
      ),
    );
  }

  @override
  $ReturnsTable createAlias(String alias) {
    return $ReturnsTable(attachedDatabase, alias);
  }
}

class ReturnRow extends DataClass implements Insertable<ReturnRow> {
  final int id;
  final int tenantId;
  final String returnId;
  final String orderId;
  final String reason;
  final String status;
  final String? notes;
  final double? refundAmount;
  final double? returnShippingCost;
  final double? restockingFee;
  final DateTime? requestedAt;
  final DateTime? resolvedAt;
  final String? returnToAddress;
  final String? returnToCity;
  final String? returnToCountry;
  final String? returnTrackingNumber;
  final String? returnCarrier;
  final String? supplierId;
  final String? productId;
  final String? sourcePlatformId;
  final String? targetPlatformId;
  final String? returnDestination;

  /// Routing target: SELLER_ADDRESS, SUPPLIER_WAREHOUSE, RETURN_CENTER, DISPOSAL.
  final String? returnRoutingDestination;
  const ReturnRow({
    required this.id,
    required this.tenantId,
    required this.returnId,
    required this.orderId,
    required this.reason,
    required this.status,
    this.notes,
    this.refundAmount,
    this.returnShippingCost,
    this.restockingFee,
    this.requestedAt,
    this.resolvedAt,
    this.returnToAddress,
    this.returnToCity,
    this.returnToCountry,
    this.returnTrackingNumber,
    this.returnCarrier,
    this.supplierId,
    this.productId,
    this.sourcePlatformId,
    this.targetPlatformId,
    this.returnDestination,
    this.returnRoutingDestination,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['return_id'] = Variable<String>(returnId);
    map['order_id'] = Variable<String>(orderId);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || refundAmount != null) {
      map['refund_amount'] = Variable<double>(refundAmount);
    }
    if (!nullToAbsent || returnShippingCost != null) {
      map['return_shipping_cost'] = Variable<double>(returnShippingCost);
    }
    if (!nullToAbsent || restockingFee != null) {
      map['restocking_fee'] = Variable<double>(restockingFee);
    }
    if (!nullToAbsent || requestedAt != null) {
      map['requested_at'] = Variable<DateTime>(requestedAt);
    }
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || returnToAddress != null) {
      map['return_to_address'] = Variable<String>(returnToAddress);
    }
    if (!nullToAbsent || returnToCity != null) {
      map['return_to_city'] = Variable<String>(returnToCity);
    }
    if (!nullToAbsent || returnToCountry != null) {
      map['return_to_country'] = Variable<String>(returnToCountry);
    }
    if (!nullToAbsent || returnTrackingNumber != null) {
      map['return_tracking_number'] = Variable<String>(returnTrackingNumber);
    }
    if (!nullToAbsent || returnCarrier != null) {
      map['return_carrier'] = Variable<String>(returnCarrier);
    }
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    if (!nullToAbsent || sourcePlatformId != null) {
      map['source_platform_id'] = Variable<String>(sourcePlatformId);
    }
    if (!nullToAbsent || targetPlatformId != null) {
      map['target_platform_id'] = Variable<String>(targetPlatformId);
    }
    if (!nullToAbsent || returnDestination != null) {
      map['return_destination'] = Variable<String>(returnDestination);
    }
    if (!nullToAbsent || returnRoutingDestination != null) {
      map['return_routing_destination'] = Variable<String>(
        returnRoutingDestination,
      );
    }
    return map;
  }

  ReturnsCompanion toCompanion(bool nullToAbsent) {
    return ReturnsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      returnId: Value(returnId),
      orderId: Value(orderId),
      reason: Value(reason),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      refundAmount: refundAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(refundAmount),
      returnShippingCost: returnShippingCost == null && nullToAbsent
          ? const Value.absent()
          : Value(returnShippingCost),
      restockingFee: restockingFee == null && nullToAbsent
          ? const Value.absent()
          : Value(restockingFee),
      requestedAt: requestedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(requestedAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      returnToAddress: returnToAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(returnToAddress),
      returnToCity: returnToCity == null && nullToAbsent
          ? const Value.absent()
          : Value(returnToCity),
      returnToCountry: returnToCountry == null && nullToAbsent
          ? const Value.absent()
          : Value(returnToCountry),
      returnTrackingNumber: returnTrackingNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(returnTrackingNumber),
      returnCarrier: returnCarrier == null && nullToAbsent
          ? const Value.absent()
          : Value(returnCarrier),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      sourcePlatformId: sourcePlatformId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourcePlatformId),
      targetPlatformId: targetPlatformId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetPlatformId),
      returnDestination: returnDestination == null && nullToAbsent
          ? const Value.absent()
          : Value(returnDestination),
      returnRoutingDestination: returnRoutingDestination == null && nullToAbsent
          ? const Value.absent()
          : Value(returnRoutingDestination),
    );
  }

  factory ReturnRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      returnId: serializer.fromJson<String>(json['returnId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      refundAmount: serializer.fromJson<double?>(json['refundAmount']),
      returnShippingCost: serializer.fromJson<double?>(
        json['returnShippingCost'],
      ),
      restockingFee: serializer.fromJson<double?>(json['restockingFee']),
      requestedAt: serializer.fromJson<DateTime?>(json['requestedAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      returnToAddress: serializer.fromJson<String?>(json['returnToAddress']),
      returnToCity: serializer.fromJson<String?>(json['returnToCity']),
      returnToCountry: serializer.fromJson<String?>(json['returnToCountry']),
      returnTrackingNumber: serializer.fromJson<String?>(
        json['returnTrackingNumber'],
      ),
      returnCarrier: serializer.fromJson<String?>(json['returnCarrier']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      productId: serializer.fromJson<String?>(json['productId']),
      sourcePlatformId: serializer.fromJson<String?>(json['sourcePlatformId']),
      targetPlatformId: serializer.fromJson<String?>(json['targetPlatformId']),
      returnDestination: serializer.fromJson<String?>(
        json['returnDestination'],
      ),
      returnRoutingDestination: serializer.fromJson<String?>(
        json['returnRoutingDestination'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'returnId': serializer.toJson<String>(returnId),
      'orderId': serializer.toJson<String>(orderId),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'refundAmount': serializer.toJson<double?>(refundAmount),
      'returnShippingCost': serializer.toJson<double?>(returnShippingCost),
      'restockingFee': serializer.toJson<double?>(restockingFee),
      'requestedAt': serializer.toJson<DateTime?>(requestedAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'returnToAddress': serializer.toJson<String?>(returnToAddress),
      'returnToCity': serializer.toJson<String?>(returnToCity),
      'returnToCountry': serializer.toJson<String?>(returnToCountry),
      'returnTrackingNumber': serializer.toJson<String?>(returnTrackingNumber),
      'returnCarrier': serializer.toJson<String?>(returnCarrier),
      'supplierId': serializer.toJson<String?>(supplierId),
      'productId': serializer.toJson<String?>(productId),
      'sourcePlatformId': serializer.toJson<String?>(sourcePlatformId),
      'targetPlatformId': serializer.toJson<String?>(targetPlatformId),
      'returnDestination': serializer.toJson<String?>(returnDestination),
      'returnRoutingDestination': serializer.toJson<String?>(
        returnRoutingDestination,
      ),
    };
  }

  ReturnRow copyWith({
    int? id,
    int? tenantId,
    String? returnId,
    String? orderId,
    String? reason,
    String? status,
    Value<String?> notes = const Value.absent(),
    Value<double?> refundAmount = const Value.absent(),
    Value<double?> returnShippingCost = const Value.absent(),
    Value<double?> restockingFee = const Value.absent(),
    Value<DateTime?> requestedAt = const Value.absent(),
    Value<DateTime?> resolvedAt = const Value.absent(),
    Value<String?> returnToAddress = const Value.absent(),
    Value<String?> returnToCity = const Value.absent(),
    Value<String?> returnToCountry = const Value.absent(),
    Value<String?> returnTrackingNumber = const Value.absent(),
    Value<String?> returnCarrier = const Value.absent(),
    Value<String?> supplierId = const Value.absent(),
    Value<String?> productId = const Value.absent(),
    Value<String?> sourcePlatformId = const Value.absent(),
    Value<String?> targetPlatformId = const Value.absent(),
    Value<String?> returnDestination = const Value.absent(),
    Value<String?> returnRoutingDestination = const Value.absent(),
  }) => ReturnRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    returnId: returnId ?? this.returnId,
    orderId: orderId ?? this.orderId,
    reason: reason ?? this.reason,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    refundAmount: refundAmount.present ? refundAmount.value : this.refundAmount,
    returnShippingCost: returnShippingCost.present
        ? returnShippingCost.value
        : this.returnShippingCost,
    restockingFee: restockingFee.present
        ? restockingFee.value
        : this.restockingFee,
    requestedAt: requestedAt.present ? requestedAt.value : this.requestedAt,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
    returnToAddress: returnToAddress.present
        ? returnToAddress.value
        : this.returnToAddress,
    returnToCity: returnToCity.present ? returnToCity.value : this.returnToCity,
    returnToCountry: returnToCountry.present
        ? returnToCountry.value
        : this.returnToCountry,
    returnTrackingNumber: returnTrackingNumber.present
        ? returnTrackingNumber.value
        : this.returnTrackingNumber,
    returnCarrier: returnCarrier.present
        ? returnCarrier.value
        : this.returnCarrier,
    supplierId: supplierId.present ? supplierId.value : this.supplierId,
    productId: productId.present ? productId.value : this.productId,
    sourcePlatformId: sourcePlatformId.present
        ? sourcePlatformId.value
        : this.sourcePlatformId,
    targetPlatformId: targetPlatformId.present
        ? targetPlatformId.value
        : this.targetPlatformId,
    returnDestination: returnDestination.present
        ? returnDestination.value
        : this.returnDestination,
    returnRoutingDestination: returnRoutingDestination.present
        ? returnRoutingDestination.value
        : this.returnRoutingDestination,
  );
  ReturnRow copyWithCompanion(ReturnsCompanion data) {
    return ReturnRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      returnId: data.returnId.present ? data.returnId.value : this.returnId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      refundAmount: data.refundAmount.present
          ? data.refundAmount.value
          : this.refundAmount,
      returnShippingCost: data.returnShippingCost.present
          ? data.returnShippingCost.value
          : this.returnShippingCost,
      restockingFee: data.restockingFee.present
          ? data.restockingFee.value
          : this.restockingFee,
      requestedAt: data.requestedAt.present
          ? data.requestedAt.value
          : this.requestedAt,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
      returnToAddress: data.returnToAddress.present
          ? data.returnToAddress.value
          : this.returnToAddress,
      returnToCity: data.returnToCity.present
          ? data.returnToCity.value
          : this.returnToCity,
      returnToCountry: data.returnToCountry.present
          ? data.returnToCountry.value
          : this.returnToCountry,
      returnTrackingNumber: data.returnTrackingNumber.present
          ? data.returnTrackingNumber.value
          : this.returnTrackingNumber,
      returnCarrier: data.returnCarrier.present
          ? data.returnCarrier.value
          : this.returnCarrier,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      productId: data.productId.present ? data.productId.value : this.productId,
      sourcePlatformId: data.sourcePlatformId.present
          ? data.sourcePlatformId.value
          : this.sourcePlatformId,
      targetPlatformId: data.targetPlatformId.present
          ? data.targetPlatformId.value
          : this.targetPlatformId,
      returnDestination: data.returnDestination.present
          ? data.returnDestination.value
          : this.returnDestination,
      returnRoutingDestination: data.returnRoutingDestination.present
          ? data.returnRoutingDestination.value
          : this.returnRoutingDestination,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('returnId: $returnId, ')
          ..write('orderId: $orderId, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('returnShippingCost: $returnShippingCost, ')
          ..write('restockingFee: $restockingFee, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('returnToAddress: $returnToAddress, ')
          ..write('returnToCity: $returnToCity, ')
          ..write('returnToCountry: $returnToCountry, ')
          ..write('returnTrackingNumber: $returnTrackingNumber, ')
          ..write('returnCarrier: $returnCarrier, ')
          ..write('supplierId: $supplierId, ')
          ..write('productId: $productId, ')
          ..write('sourcePlatformId: $sourcePlatformId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('returnDestination: $returnDestination, ')
          ..write('returnRoutingDestination: $returnRoutingDestination')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    tenantId,
    returnId,
    orderId,
    reason,
    status,
    notes,
    refundAmount,
    returnShippingCost,
    restockingFee,
    requestedAt,
    resolvedAt,
    returnToAddress,
    returnToCity,
    returnToCountry,
    returnTrackingNumber,
    returnCarrier,
    supplierId,
    productId,
    sourcePlatformId,
    targetPlatformId,
    returnDestination,
    returnRoutingDestination,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.returnId == this.returnId &&
          other.orderId == this.orderId &&
          other.reason == this.reason &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.refundAmount == this.refundAmount &&
          other.returnShippingCost == this.returnShippingCost &&
          other.restockingFee == this.restockingFee &&
          other.requestedAt == this.requestedAt &&
          other.resolvedAt == this.resolvedAt &&
          other.returnToAddress == this.returnToAddress &&
          other.returnToCity == this.returnToCity &&
          other.returnToCountry == this.returnToCountry &&
          other.returnTrackingNumber == this.returnTrackingNumber &&
          other.returnCarrier == this.returnCarrier &&
          other.supplierId == this.supplierId &&
          other.productId == this.productId &&
          other.sourcePlatformId == this.sourcePlatformId &&
          other.targetPlatformId == this.targetPlatformId &&
          other.returnDestination == this.returnDestination &&
          other.returnRoutingDestination == this.returnRoutingDestination);
}

class ReturnsCompanion extends UpdateCompanion<ReturnRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> returnId;
  final Value<String> orderId;
  final Value<String> reason;
  final Value<String> status;
  final Value<String?> notes;
  final Value<double?> refundAmount;
  final Value<double?> returnShippingCost;
  final Value<double?> restockingFee;
  final Value<DateTime?> requestedAt;
  final Value<DateTime?> resolvedAt;
  final Value<String?> returnToAddress;
  final Value<String?> returnToCity;
  final Value<String?> returnToCountry;
  final Value<String?> returnTrackingNumber;
  final Value<String?> returnCarrier;
  final Value<String?> supplierId;
  final Value<String?> productId;
  final Value<String?> sourcePlatformId;
  final Value<String?> targetPlatformId;
  final Value<String?> returnDestination;
  final Value<String?> returnRoutingDestination;
  const ReturnsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.returnId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.returnShippingCost = const Value.absent(),
    this.restockingFee = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.returnToAddress = const Value.absent(),
    this.returnToCity = const Value.absent(),
    this.returnToCountry = const Value.absent(),
    this.returnTrackingNumber = const Value.absent(),
    this.returnCarrier = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.productId = const Value.absent(),
    this.sourcePlatformId = const Value.absent(),
    this.targetPlatformId = const Value.absent(),
    this.returnDestination = const Value.absent(),
    this.returnRoutingDestination = const Value.absent(),
  });
  ReturnsCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String returnId,
    required String orderId,
    required String reason,
    required String status,
    this.notes = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.returnShippingCost = const Value.absent(),
    this.restockingFee = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.returnToAddress = const Value.absent(),
    this.returnToCity = const Value.absent(),
    this.returnToCountry = const Value.absent(),
    this.returnTrackingNumber = const Value.absent(),
    this.returnCarrier = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.productId = const Value.absent(),
    this.sourcePlatformId = const Value.absent(),
    this.targetPlatformId = const Value.absent(),
    this.returnDestination = const Value.absent(),
    this.returnRoutingDestination = const Value.absent(),
  }) : returnId = Value(returnId),
       orderId = Value(orderId),
       reason = Value(reason),
       status = Value(status);
  static Insertable<ReturnRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? returnId,
    Expression<String>? orderId,
    Expression<String>? reason,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<double>? refundAmount,
    Expression<double>? returnShippingCost,
    Expression<double>? restockingFee,
    Expression<DateTime>? requestedAt,
    Expression<DateTime>? resolvedAt,
    Expression<String>? returnToAddress,
    Expression<String>? returnToCity,
    Expression<String>? returnToCountry,
    Expression<String>? returnTrackingNumber,
    Expression<String>? returnCarrier,
    Expression<String>? supplierId,
    Expression<String>? productId,
    Expression<String>? sourcePlatformId,
    Expression<String>? targetPlatformId,
    Expression<String>? returnDestination,
    Expression<String>? returnRoutingDestination,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (returnId != null) 'return_id': returnId,
      if (orderId != null) 'order_id': orderId,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (refundAmount != null) 'refund_amount': refundAmount,
      if (returnShippingCost != null)
        'return_shipping_cost': returnShippingCost,
      if (restockingFee != null) 'restocking_fee': restockingFee,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (returnToAddress != null) 'return_to_address': returnToAddress,
      if (returnToCity != null) 'return_to_city': returnToCity,
      if (returnToCountry != null) 'return_to_country': returnToCountry,
      if (returnTrackingNumber != null)
        'return_tracking_number': returnTrackingNumber,
      if (returnCarrier != null) 'return_carrier': returnCarrier,
      if (supplierId != null) 'supplier_id': supplierId,
      if (productId != null) 'product_id': productId,
      if (sourcePlatformId != null) 'source_platform_id': sourcePlatformId,
      if (targetPlatformId != null) 'target_platform_id': targetPlatformId,
      if (returnDestination != null) 'return_destination': returnDestination,
      if (returnRoutingDestination != null)
        'return_routing_destination': returnRoutingDestination,
    });
  }

  ReturnsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? returnId,
    Value<String>? orderId,
    Value<String>? reason,
    Value<String>? status,
    Value<String?>? notes,
    Value<double?>? refundAmount,
    Value<double?>? returnShippingCost,
    Value<double?>? restockingFee,
    Value<DateTime?>? requestedAt,
    Value<DateTime?>? resolvedAt,
    Value<String?>? returnToAddress,
    Value<String?>? returnToCity,
    Value<String?>? returnToCountry,
    Value<String?>? returnTrackingNumber,
    Value<String?>? returnCarrier,
    Value<String?>? supplierId,
    Value<String?>? productId,
    Value<String?>? sourcePlatformId,
    Value<String?>? targetPlatformId,
    Value<String?>? returnDestination,
    Value<String?>? returnRoutingDestination,
  }) {
    return ReturnsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      returnId: returnId ?? this.returnId,
      orderId: orderId ?? this.orderId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      refundAmount: refundAmount ?? this.refundAmount,
      returnShippingCost: returnShippingCost ?? this.returnShippingCost,
      restockingFee: restockingFee ?? this.restockingFee,
      requestedAt: requestedAt ?? this.requestedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      returnToAddress: returnToAddress ?? this.returnToAddress,
      returnToCity: returnToCity ?? this.returnToCity,
      returnToCountry: returnToCountry ?? this.returnToCountry,
      returnTrackingNumber: returnTrackingNumber ?? this.returnTrackingNumber,
      returnCarrier: returnCarrier ?? this.returnCarrier,
      supplierId: supplierId ?? this.supplierId,
      productId: productId ?? this.productId,
      sourcePlatformId: sourcePlatformId ?? this.sourcePlatformId,
      targetPlatformId: targetPlatformId ?? this.targetPlatformId,
      returnDestination: returnDestination ?? this.returnDestination,
      returnRoutingDestination:
          returnRoutingDestination ?? this.returnRoutingDestination,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (returnId.present) {
      map['return_id'] = Variable<String>(returnId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (refundAmount.present) {
      map['refund_amount'] = Variable<double>(refundAmount.value);
    }
    if (returnShippingCost.present) {
      map['return_shipping_cost'] = Variable<double>(returnShippingCost.value);
    }
    if (restockingFee.present) {
      map['restocking_fee'] = Variable<double>(restockingFee.value);
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<DateTime>(requestedAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (returnToAddress.present) {
      map['return_to_address'] = Variable<String>(returnToAddress.value);
    }
    if (returnToCity.present) {
      map['return_to_city'] = Variable<String>(returnToCity.value);
    }
    if (returnToCountry.present) {
      map['return_to_country'] = Variable<String>(returnToCountry.value);
    }
    if (returnTrackingNumber.present) {
      map['return_tracking_number'] = Variable<String>(
        returnTrackingNumber.value,
      );
    }
    if (returnCarrier.present) {
      map['return_carrier'] = Variable<String>(returnCarrier.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (sourcePlatformId.present) {
      map['source_platform_id'] = Variable<String>(sourcePlatformId.value);
    }
    if (targetPlatformId.present) {
      map['target_platform_id'] = Variable<String>(targetPlatformId.value);
    }
    if (returnDestination.present) {
      map['return_destination'] = Variable<String>(returnDestination.value);
    }
    if (returnRoutingDestination.present) {
      map['return_routing_destination'] = Variable<String>(
        returnRoutingDestination.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('returnId: $returnId, ')
          ..write('orderId: $orderId, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('returnShippingCost: $returnShippingCost, ')
          ..write('restockingFee: $restockingFee, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('returnToAddress: $returnToAddress, ')
          ..write('returnToCity: $returnToCity, ')
          ..write('returnToCountry: $returnToCountry, ')
          ..write('returnTrackingNumber: $returnTrackingNumber, ')
          ..write('returnCarrier: $returnCarrier, ')
          ..write('supplierId: $supplierId, ')
          ..write('productId: $productId, ')
          ..write('sourcePlatformId: $sourcePlatformId, ')
          ..write('targetPlatformId: $targetPlatformId, ')
          ..write('returnDestination: $returnDestination, ')
          ..write('returnRoutingDestination: $returnRoutingDestination')
          ..write(')'))
        .toString();
  }
}

class $SupplierReturnPoliciesTable extends SupplierReturnPolicies
    with TableInfo<$SupplierReturnPoliciesTable, SupplierReturnPolicyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierReturnPoliciesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _policyTypeMeta = const VerificationMeta(
    'policyType',
  );
  @override
  late final GeneratedColumn<String> policyType = GeneratedColumn<String>(
    'policy_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _returnShippingPaidByMeta =
      const VerificationMeta('returnShippingPaidBy');
  @override
  late final GeneratedColumn<String> returnShippingPaidBy =
      GeneratedColumn<String>(
        'return_shipping_paid_by',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _requiresRmaMeta = const VerificationMeta(
    'requiresRma',
  );
  @override
  late final GeneratedColumn<bool> requiresRma = GeneratedColumn<bool>(
    'requires_rma',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_rma" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _warehouseReturnSupportedMeta =
      const VerificationMeta('warehouseReturnSupported');
  @override
  late final GeneratedColumn<bool> warehouseReturnSupported =
      GeneratedColumn<bool>(
        'warehouse_return_supported',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("warehouse_return_supported" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _virtualRestockSupportedMeta =
      const VerificationMeta('virtualRestockSupported');
  @override
  late final GeneratedColumn<bool> virtualRestockSupported =
      GeneratedColumn<bool>(
        'virtual_restock_supported',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("virtual_restock_supported" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    supplierId,
    policyType,
    returnWindowDays,
    restockingFeePercent,
    returnShippingPaidBy,
    requiresRma,
    warehouseReturnSupported,
    virtualRestockSupported,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_return_policies';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierReturnPolicyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('policy_type')) {
      context.handle(
        _policyTypeMeta,
        policyType.isAcceptableOrUnknown(data['policy_type']!, _policyTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_policyTypeMeta);
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
    if (data.containsKey('restocking_fee_percent')) {
      context.handle(
        _restockingFeePercentMeta,
        restockingFeePercent.isAcceptableOrUnknown(
          data['restocking_fee_percent']!,
          _restockingFeePercentMeta,
        ),
      );
    }
    if (data.containsKey('return_shipping_paid_by')) {
      context.handle(
        _returnShippingPaidByMeta,
        returnShippingPaidBy.isAcceptableOrUnknown(
          data['return_shipping_paid_by']!,
          _returnShippingPaidByMeta,
        ),
      );
    }
    if (data.containsKey('requires_rma')) {
      context.handle(
        _requiresRmaMeta,
        requiresRma.isAcceptableOrUnknown(
          data['requires_rma']!,
          _requiresRmaMeta,
        ),
      );
    }
    if (data.containsKey('warehouse_return_supported')) {
      context.handle(
        _warehouseReturnSupportedMeta,
        warehouseReturnSupported.isAcceptableOrUnknown(
          data['warehouse_return_supported']!,
          _warehouseReturnSupportedMeta,
        ),
      );
    }
    if (data.containsKey('virtual_restock_supported')) {
      context.handle(
        _virtualRestockSupportedMeta,
        virtualRestockSupported.isAcceptableOrUnknown(
          data['virtual_restock_supported']!,
          _virtualRestockSupportedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierReturnPolicyRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierReturnPolicyRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      policyType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}policy_type'],
      )!,
      returnWindowDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}return_window_days'],
      ),
      restockingFeePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}restocking_fee_percent'],
      ),
      returnShippingPaidBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_shipping_paid_by'],
      ),
      requiresRma: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_rma'],
      )!,
      warehouseReturnSupported: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}warehouse_return_supported'],
      )!,
      virtualRestockSupported: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}virtual_restock_supported'],
      )!,
    );
  }

  @override
  $SupplierReturnPoliciesTable createAlias(String alias) {
    return $SupplierReturnPoliciesTable(attachedDatabase, alias);
  }
}

class SupplierReturnPolicyRow extends DataClass
    implements Insertable<SupplierReturnPolicyRow> {
  final int id;
  final int tenantId;
  final String supplierId;
  final String policyType;
  final int? returnWindowDays;
  final double? restockingFeePercent;
  final String? returnShippingPaidBy;
  final bool requiresRma;
  final bool warehouseReturnSupported;
  final bool virtualRestockSupported;
  const SupplierReturnPolicyRow({
    required this.id,
    required this.tenantId,
    required this.supplierId,
    required this.policyType,
    this.returnWindowDays,
    this.restockingFeePercent,
    this.returnShippingPaidBy,
    required this.requiresRma,
    required this.warehouseReturnSupported,
    required this.virtualRestockSupported,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['supplier_id'] = Variable<String>(supplierId);
    map['policy_type'] = Variable<String>(policyType);
    if (!nullToAbsent || returnWindowDays != null) {
      map['return_window_days'] = Variable<int>(returnWindowDays);
    }
    if (!nullToAbsent || restockingFeePercent != null) {
      map['restocking_fee_percent'] = Variable<double>(restockingFeePercent);
    }
    if (!nullToAbsent || returnShippingPaidBy != null) {
      map['return_shipping_paid_by'] = Variable<String>(returnShippingPaidBy);
    }
    map['requires_rma'] = Variable<bool>(requiresRma);
    map['warehouse_return_supported'] = Variable<bool>(
      warehouseReturnSupported,
    );
    map['virtual_restock_supported'] = Variable<bool>(virtualRestockSupported);
    return map;
  }

  SupplierReturnPoliciesCompanion toCompanion(bool nullToAbsent) {
    return SupplierReturnPoliciesCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      supplierId: Value(supplierId),
      policyType: Value(policyType),
      returnWindowDays: returnWindowDays == null && nullToAbsent
          ? const Value.absent()
          : Value(returnWindowDays),
      restockingFeePercent: restockingFeePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(restockingFeePercent),
      returnShippingPaidBy: returnShippingPaidBy == null && nullToAbsent
          ? const Value.absent()
          : Value(returnShippingPaidBy),
      requiresRma: Value(requiresRma),
      warehouseReturnSupported: Value(warehouseReturnSupported),
      virtualRestockSupported: Value(virtualRestockSupported),
    );
  }

  factory SupplierReturnPolicyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierReturnPolicyRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      policyType: serializer.fromJson<String>(json['policyType']),
      returnWindowDays: serializer.fromJson<int?>(json['returnWindowDays']),
      restockingFeePercent: serializer.fromJson<double?>(
        json['restockingFeePercent'],
      ),
      returnShippingPaidBy: serializer.fromJson<String?>(
        json['returnShippingPaidBy'],
      ),
      requiresRma: serializer.fromJson<bool>(json['requiresRma']),
      warehouseReturnSupported: serializer.fromJson<bool>(
        json['warehouseReturnSupported'],
      ),
      virtualRestockSupported: serializer.fromJson<bool>(
        json['virtualRestockSupported'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'supplierId': serializer.toJson<String>(supplierId),
      'policyType': serializer.toJson<String>(policyType),
      'returnWindowDays': serializer.toJson<int?>(returnWindowDays),
      'restockingFeePercent': serializer.toJson<double?>(restockingFeePercent),
      'returnShippingPaidBy': serializer.toJson<String?>(returnShippingPaidBy),
      'requiresRma': serializer.toJson<bool>(requiresRma),
      'warehouseReturnSupported': serializer.toJson<bool>(
        warehouseReturnSupported,
      ),
      'virtualRestockSupported': serializer.toJson<bool>(
        virtualRestockSupported,
      ),
    };
  }

  SupplierReturnPolicyRow copyWith({
    int? id,
    int? tenantId,
    String? supplierId,
    String? policyType,
    Value<int?> returnWindowDays = const Value.absent(),
    Value<double?> restockingFeePercent = const Value.absent(),
    Value<String?> returnShippingPaidBy = const Value.absent(),
    bool? requiresRma,
    bool? warehouseReturnSupported,
    bool? virtualRestockSupported,
  }) => SupplierReturnPolicyRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    supplierId: supplierId ?? this.supplierId,
    policyType: policyType ?? this.policyType,
    returnWindowDays: returnWindowDays.present
        ? returnWindowDays.value
        : this.returnWindowDays,
    restockingFeePercent: restockingFeePercent.present
        ? restockingFeePercent.value
        : this.restockingFeePercent,
    returnShippingPaidBy: returnShippingPaidBy.present
        ? returnShippingPaidBy.value
        : this.returnShippingPaidBy,
    requiresRma: requiresRma ?? this.requiresRma,
    warehouseReturnSupported:
        warehouseReturnSupported ?? this.warehouseReturnSupported,
    virtualRestockSupported:
        virtualRestockSupported ?? this.virtualRestockSupported,
  );
  SupplierReturnPolicyRow copyWithCompanion(
    SupplierReturnPoliciesCompanion data,
  ) {
    return SupplierReturnPolicyRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      policyType: data.policyType.present
          ? data.policyType.value
          : this.policyType,
      returnWindowDays: data.returnWindowDays.present
          ? data.returnWindowDays.value
          : this.returnWindowDays,
      restockingFeePercent: data.restockingFeePercent.present
          ? data.restockingFeePercent.value
          : this.restockingFeePercent,
      returnShippingPaidBy: data.returnShippingPaidBy.present
          ? data.returnShippingPaidBy.value
          : this.returnShippingPaidBy,
      requiresRma: data.requiresRma.present
          ? data.requiresRma.value
          : this.requiresRma,
      warehouseReturnSupported: data.warehouseReturnSupported.present
          ? data.warehouseReturnSupported.value
          : this.warehouseReturnSupported,
      virtualRestockSupported: data.virtualRestockSupported.present
          ? data.virtualRestockSupported.value
          : this.virtualRestockSupported,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierReturnPolicyRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('supplierId: $supplierId, ')
          ..write('policyType: $policyType, ')
          ..write('returnWindowDays: $returnWindowDays, ')
          ..write('restockingFeePercent: $restockingFeePercent, ')
          ..write('returnShippingPaidBy: $returnShippingPaidBy, ')
          ..write('requiresRma: $requiresRma, ')
          ..write('warehouseReturnSupported: $warehouseReturnSupported, ')
          ..write('virtualRestockSupported: $virtualRestockSupported')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    supplierId,
    policyType,
    returnWindowDays,
    restockingFeePercent,
    returnShippingPaidBy,
    requiresRma,
    warehouseReturnSupported,
    virtualRestockSupported,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierReturnPolicyRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.supplierId == this.supplierId &&
          other.policyType == this.policyType &&
          other.returnWindowDays == this.returnWindowDays &&
          other.restockingFeePercent == this.restockingFeePercent &&
          other.returnShippingPaidBy == this.returnShippingPaidBy &&
          other.requiresRma == this.requiresRma &&
          other.warehouseReturnSupported == this.warehouseReturnSupported &&
          other.virtualRestockSupported == this.virtualRestockSupported);
}

class SupplierReturnPoliciesCompanion
    extends UpdateCompanion<SupplierReturnPolicyRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> supplierId;
  final Value<String> policyType;
  final Value<int?> returnWindowDays;
  final Value<double?> restockingFeePercent;
  final Value<String?> returnShippingPaidBy;
  final Value<bool> requiresRma;
  final Value<bool> warehouseReturnSupported;
  final Value<bool> virtualRestockSupported;
  const SupplierReturnPoliciesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.policyType = const Value.absent(),
    this.returnWindowDays = const Value.absent(),
    this.restockingFeePercent = const Value.absent(),
    this.returnShippingPaidBy = const Value.absent(),
    this.requiresRma = const Value.absent(),
    this.warehouseReturnSupported = const Value.absent(),
    this.virtualRestockSupported = const Value.absent(),
  });
  SupplierReturnPoliciesCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String supplierId,
    required String policyType,
    this.returnWindowDays = const Value.absent(),
    this.restockingFeePercent = const Value.absent(),
    this.returnShippingPaidBy = const Value.absent(),
    this.requiresRma = const Value.absent(),
    this.warehouseReturnSupported = const Value.absent(),
    this.virtualRestockSupported = const Value.absent(),
  }) : supplierId = Value(supplierId),
       policyType = Value(policyType);
  static Insertable<SupplierReturnPolicyRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? supplierId,
    Expression<String>? policyType,
    Expression<int>? returnWindowDays,
    Expression<double>? restockingFeePercent,
    Expression<String>? returnShippingPaidBy,
    Expression<bool>? requiresRma,
    Expression<bool>? warehouseReturnSupported,
    Expression<bool>? virtualRestockSupported,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (policyType != null) 'policy_type': policyType,
      if (returnWindowDays != null) 'return_window_days': returnWindowDays,
      if (restockingFeePercent != null)
        'restocking_fee_percent': restockingFeePercent,
      if (returnShippingPaidBy != null)
        'return_shipping_paid_by': returnShippingPaidBy,
      if (requiresRma != null) 'requires_rma': requiresRma,
      if (warehouseReturnSupported != null)
        'warehouse_return_supported': warehouseReturnSupported,
      if (virtualRestockSupported != null)
        'virtual_restock_supported': virtualRestockSupported,
    });
  }

  SupplierReturnPoliciesCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? supplierId,
    Value<String>? policyType,
    Value<int?>? returnWindowDays,
    Value<double?>? restockingFeePercent,
    Value<String?>? returnShippingPaidBy,
    Value<bool>? requiresRma,
    Value<bool>? warehouseReturnSupported,
    Value<bool>? virtualRestockSupported,
  }) {
    return SupplierReturnPoliciesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      supplierId: supplierId ?? this.supplierId,
      policyType: policyType ?? this.policyType,
      returnWindowDays: returnWindowDays ?? this.returnWindowDays,
      restockingFeePercent: restockingFeePercent ?? this.restockingFeePercent,
      returnShippingPaidBy: returnShippingPaidBy ?? this.returnShippingPaidBy,
      requiresRma: requiresRma ?? this.requiresRma,
      warehouseReturnSupported:
          warehouseReturnSupported ?? this.warehouseReturnSupported,
      virtualRestockSupported:
          virtualRestockSupported ?? this.virtualRestockSupported,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (policyType.present) {
      map['policy_type'] = Variable<String>(policyType.value);
    }
    if (returnWindowDays.present) {
      map['return_window_days'] = Variable<int>(returnWindowDays.value);
    }
    if (restockingFeePercent.present) {
      map['restocking_fee_percent'] = Variable<double>(
        restockingFeePercent.value,
      );
    }
    if (returnShippingPaidBy.present) {
      map['return_shipping_paid_by'] = Variable<String>(
        returnShippingPaidBy.value,
      );
    }
    if (requiresRma.present) {
      map['requires_rma'] = Variable<bool>(requiresRma.value);
    }
    if (warehouseReturnSupported.present) {
      map['warehouse_return_supported'] = Variable<bool>(
        warehouseReturnSupported.value,
      );
    }
    if (virtualRestockSupported.present) {
      map['virtual_restock_supported'] = Variable<bool>(
        virtualRestockSupported.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierReturnPoliciesCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('supplierId: $supplierId, ')
          ..write('policyType: $policyType, ')
          ..write('returnWindowDays: $returnWindowDays, ')
          ..write('restockingFeePercent: $restockingFeePercent, ')
          ..write('returnShippingPaidBy: $returnShippingPaidBy, ')
          ..write('requiresRma: $requiresRma, ')
          ..write('warehouseReturnSupported: $warehouseReturnSupported, ')
          ..write('virtualRestockSupported: $virtualRestockSupported')
          ..write(')'))
        .toString();
  }
}

class $IncidentRecordsTable extends IncidentRecords
    with TableInfo<$IncidentRecordsTable, IncidentRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncidentRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _incidentTypeMeta = const VerificationMeta(
    'incidentType',
  );
  @override
  late final GeneratedColumn<String> incidentType = GeneratedColumn<String>(
    'incident_type',
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
  static const VerificationMeta _triggerMeta = const VerificationMeta(
    'trigger',
  );
  @override
  late final GeneratedColumn<String> trigger = GeneratedColumn<String>(
    'trigger',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _automaticDecisionMeta = const VerificationMeta(
    'automaticDecision',
  );
  @override
  late final GeneratedColumn<String> automaticDecision =
      GeneratedColumn<String>(
        'automatic_decision',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _supplierInteractionMeta =
      const VerificationMeta('supplierInteraction');
  @override
  late final GeneratedColumn<String> supplierInteraction =
      GeneratedColumn<String>(
        'supplier_interaction',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _marketplaceInteractionMeta =
      const VerificationMeta('marketplaceInteraction');
  @override
  late final GeneratedColumn<String> marketplaceInteraction =
      GeneratedColumn<String>(
        'marketplace_interaction',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _refundAmountMeta = const VerificationMeta(
    'refundAmount',
  );
  @override
  late final GeneratedColumn<double> refundAmount = GeneratedColumn<double>(
    'refund_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _financialImpactMeta = const VerificationMeta(
    'financialImpact',
  );
  @override
  late final GeneratedColumn<double> financialImpact = GeneratedColumn<double>(
    'financial_impact',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attachmentIdsMeta = const VerificationMeta(
    'attachmentIds',
  );
  @override
  late final GeneratedColumn<String> attachmentIds = GeneratedColumn<String>(
    'attachment_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    orderId,
    incidentType,
    status,
    trigger,
    automaticDecision,
    supplierInteraction,
    marketplaceInteraction,
    refundAmount,
    financialImpact,
    decisionLogId,
    createdAt,
    resolvedAt,
    attachmentIds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incident_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<IncidentRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('incident_type')) {
      context.handle(
        _incidentTypeMeta,
        incidentType.isAcceptableOrUnknown(
          data['incident_type']!,
          _incidentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_incidentTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('trigger')) {
      context.handle(
        _triggerMeta,
        trigger.isAcceptableOrUnknown(data['trigger']!, _triggerMeta),
      );
    }
    if (data.containsKey('automatic_decision')) {
      context.handle(
        _automaticDecisionMeta,
        automaticDecision.isAcceptableOrUnknown(
          data['automatic_decision']!,
          _automaticDecisionMeta,
        ),
      );
    }
    if (data.containsKey('supplier_interaction')) {
      context.handle(
        _supplierInteractionMeta,
        supplierInteraction.isAcceptableOrUnknown(
          data['supplier_interaction']!,
          _supplierInteractionMeta,
        ),
      );
    }
    if (data.containsKey('marketplace_interaction')) {
      context.handle(
        _marketplaceInteractionMeta,
        marketplaceInteraction.isAcceptableOrUnknown(
          data['marketplace_interaction']!,
          _marketplaceInteractionMeta,
        ),
      );
    }
    if (data.containsKey('refund_amount')) {
      context.handle(
        _refundAmountMeta,
        refundAmount.isAcceptableOrUnknown(
          data['refund_amount']!,
          _refundAmountMeta,
        ),
      );
    }
    if (data.containsKey('financial_impact')) {
      context.handle(
        _financialImpactMeta,
        financialImpact.isAcceptableOrUnknown(
          data['financial_impact']!,
          _financialImpactMeta,
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
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    if (data.containsKey('attachment_ids')) {
      context.handle(
        _attachmentIdsMeta,
        attachmentIds.isAcceptableOrUnknown(
          data['attachment_ids']!,
          _attachmentIdsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncidentRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncidentRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      incidentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}incident_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      trigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger'],
      )!,
      automaticDecision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}automatic_decision'],
      ),
      supplierInteraction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_interaction'],
      ),
      marketplaceInteraction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marketplace_interaction'],
      ),
      refundAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_amount'],
      ),
      financialImpact: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}financial_impact'],
      ),
      decisionLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision_log_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
      attachmentIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_ids'],
      ),
    );
  }

  @override
  $IncidentRecordsTable createAlias(String alias) {
    return $IncidentRecordsTable(attachedDatabase, alias);
  }
}

class IncidentRecordRow extends DataClass
    implements Insertable<IncidentRecordRow> {
  final int id;
  final int tenantId;
  final String orderId;
  final String incidentType;
  final String status;
  final String trigger;
  final String? automaticDecision;
  final String? supplierInteraction;
  final String? marketplaceInteraction;
  final double? refundAmount;
  final double? financialImpact;
  final String? decisionLogId;
  final DateTime createdAt;
  final DateTime? resolvedAt;

  /// JSON array of attachment IDs (e.g. for damage claim photos). Nullable for Phase 7.
  final String? attachmentIds;
  const IncidentRecordRow({
    required this.id,
    required this.tenantId,
    required this.orderId,
    required this.incidentType,
    required this.status,
    required this.trigger,
    this.automaticDecision,
    this.supplierInteraction,
    this.marketplaceInteraction,
    this.refundAmount,
    this.financialImpact,
    this.decisionLogId,
    required this.createdAt,
    this.resolvedAt,
    this.attachmentIds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['order_id'] = Variable<String>(orderId);
    map['incident_type'] = Variable<String>(incidentType);
    map['status'] = Variable<String>(status);
    map['trigger'] = Variable<String>(trigger);
    if (!nullToAbsent || automaticDecision != null) {
      map['automatic_decision'] = Variable<String>(automaticDecision);
    }
    if (!nullToAbsent || supplierInteraction != null) {
      map['supplier_interaction'] = Variable<String>(supplierInteraction);
    }
    if (!nullToAbsent || marketplaceInteraction != null) {
      map['marketplace_interaction'] = Variable<String>(marketplaceInteraction);
    }
    if (!nullToAbsent || refundAmount != null) {
      map['refund_amount'] = Variable<double>(refundAmount);
    }
    if (!nullToAbsent || financialImpact != null) {
      map['financial_impact'] = Variable<double>(financialImpact);
    }
    if (!nullToAbsent || decisionLogId != null) {
      map['decision_log_id'] = Variable<String>(decisionLogId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || attachmentIds != null) {
      map['attachment_ids'] = Variable<String>(attachmentIds);
    }
    return map;
  }

  IncidentRecordsCompanion toCompanion(bool nullToAbsent) {
    return IncidentRecordsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      orderId: Value(orderId),
      incidentType: Value(incidentType),
      status: Value(status),
      trigger: Value(trigger),
      automaticDecision: automaticDecision == null && nullToAbsent
          ? const Value.absent()
          : Value(automaticDecision),
      supplierInteraction: supplierInteraction == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierInteraction),
      marketplaceInteraction: marketplaceInteraction == null && nullToAbsent
          ? const Value.absent()
          : Value(marketplaceInteraction),
      refundAmount: refundAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(refundAmount),
      financialImpact: financialImpact == null && nullToAbsent
          ? const Value.absent()
          : Value(financialImpact),
      decisionLogId: decisionLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(decisionLogId),
      createdAt: Value(createdAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      attachmentIds: attachmentIds == null && nullToAbsent
          ? const Value.absent()
          : Value(attachmentIds),
    );
  }

  factory IncidentRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncidentRecordRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      incidentType: serializer.fromJson<String>(json['incidentType']),
      status: serializer.fromJson<String>(json['status']),
      trigger: serializer.fromJson<String>(json['trigger']),
      automaticDecision: serializer.fromJson<String?>(
        json['automaticDecision'],
      ),
      supplierInteraction: serializer.fromJson<String?>(
        json['supplierInteraction'],
      ),
      marketplaceInteraction: serializer.fromJson<String?>(
        json['marketplaceInteraction'],
      ),
      refundAmount: serializer.fromJson<double?>(json['refundAmount']),
      financialImpact: serializer.fromJson<double?>(json['financialImpact']),
      decisionLogId: serializer.fromJson<String?>(json['decisionLogId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      attachmentIds: serializer.fromJson<String?>(json['attachmentIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'orderId': serializer.toJson<String>(orderId),
      'incidentType': serializer.toJson<String>(incidentType),
      'status': serializer.toJson<String>(status),
      'trigger': serializer.toJson<String>(trigger),
      'automaticDecision': serializer.toJson<String?>(automaticDecision),
      'supplierInteraction': serializer.toJson<String?>(supplierInteraction),
      'marketplaceInteraction': serializer.toJson<String?>(
        marketplaceInteraction,
      ),
      'refundAmount': serializer.toJson<double?>(refundAmount),
      'financialImpact': serializer.toJson<double?>(financialImpact),
      'decisionLogId': serializer.toJson<String?>(decisionLogId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'attachmentIds': serializer.toJson<String?>(attachmentIds),
    };
  }

  IncidentRecordRow copyWith({
    int? id,
    int? tenantId,
    String? orderId,
    String? incidentType,
    String? status,
    String? trigger,
    Value<String?> automaticDecision = const Value.absent(),
    Value<String?> supplierInteraction = const Value.absent(),
    Value<String?> marketplaceInteraction = const Value.absent(),
    Value<double?> refundAmount = const Value.absent(),
    Value<double?> financialImpact = const Value.absent(),
    Value<String?> decisionLogId = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> resolvedAt = const Value.absent(),
    Value<String?> attachmentIds = const Value.absent(),
  }) => IncidentRecordRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    orderId: orderId ?? this.orderId,
    incidentType: incidentType ?? this.incidentType,
    status: status ?? this.status,
    trigger: trigger ?? this.trigger,
    automaticDecision: automaticDecision.present
        ? automaticDecision.value
        : this.automaticDecision,
    supplierInteraction: supplierInteraction.present
        ? supplierInteraction.value
        : this.supplierInteraction,
    marketplaceInteraction: marketplaceInteraction.present
        ? marketplaceInteraction.value
        : this.marketplaceInteraction,
    refundAmount: refundAmount.present ? refundAmount.value : this.refundAmount,
    financialImpact: financialImpact.present
        ? financialImpact.value
        : this.financialImpact,
    decisionLogId: decisionLogId.present
        ? decisionLogId.value
        : this.decisionLogId,
    createdAt: createdAt ?? this.createdAt,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
    attachmentIds: attachmentIds.present
        ? attachmentIds.value
        : this.attachmentIds,
  );
  IncidentRecordRow copyWithCompanion(IncidentRecordsCompanion data) {
    return IncidentRecordRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      incidentType: data.incidentType.present
          ? data.incidentType.value
          : this.incidentType,
      status: data.status.present ? data.status.value : this.status,
      trigger: data.trigger.present ? data.trigger.value : this.trigger,
      automaticDecision: data.automaticDecision.present
          ? data.automaticDecision.value
          : this.automaticDecision,
      supplierInteraction: data.supplierInteraction.present
          ? data.supplierInteraction.value
          : this.supplierInteraction,
      marketplaceInteraction: data.marketplaceInteraction.present
          ? data.marketplaceInteraction.value
          : this.marketplaceInteraction,
      refundAmount: data.refundAmount.present
          ? data.refundAmount.value
          : this.refundAmount,
      financialImpact: data.financialImpact.present
          ? data.financialImpact.value
          : this.financialImpact,
      decisionLogId: data.decisionLogId.present
          ? data.decisionLogId.value
          : this.decisionLogId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
      attachmentIds: data.attachmentIds.present
          ? data.attachmentIds.value
          : this.attachmentIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncidentRecordRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('orderId: $orderId, ')
          ..write('incidentType: $incidentType, ')
          ..write('status: $status, ')
          ..write('trigger: $trigger, ')
          ..write('automaticDecision: $automaticDecision, ')
          ..write('supplierInteraction: $supplierInteraction, ')
          ..write('marketplaceInteraction: $marketplaceInteraction, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('financialImpact: $financialImpact, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('createdAt: $createdAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('attachmentIds: $attachmentIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    orderId,
    incidentType,
    status,
    trigger,
    automaticDecision,
    supplierInteraction,
    marketplaceInteraction,
    refundAmount,
    financialImpact,
    decisionLogId,
    createdAt,
    resolvedAt,
    attachmentIds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncidentRecordRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.orderId == this.orderId &&
          other.incidentType == this.incidentType &&
          other.status == this.status &&
          other.trigger == this.trigger &&
          other.automaticDecision == this.automaticDecision &&
          other.supplierInteraction == this.supplierInteraction &&
          other.marketplaceInteraction == this.marketplaceInteraction &&
          other.refundAmount == this.refundAmount &&
          other.financialImpact == this.financialImpact &&
          other.decisionLogId == this.decisionLogId &&
          other.createdAt == this.createdAt &&
          other.resolvedAt == this.resolvedAt &&
          other.attachmentIds == this.attachmentIds);
}

class IncidentRecordsCompanion extends UpdateCompanion<IncidentRecordRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> orderId;
  final Value<String> incidentType;
  final Value<String> status;
  final Value<String> trigger;
  final Value<String?> automaticDecision;
  final Value<String?> supplierInteraction;
  final Value<String?> marketplaceInteraction;
  final Value<double?> refundAmount;
  final Value<double?> financialImpact;
  final Value<String?> decisionLogId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> resolvedAt;
  final Value<String?> attachmentIds;
  const IncidentRecordsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.incidentType = const Value.absent(),
    this.status = const Value.absent(),
    this.trigger = const Value.absent(),
    this.automaticDecision = const Value.absent(),
    this.supplierInteraction = const Value.absent(),
    this.marketplaceInteraction = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.financialImpact = const Value.absent(),
    this.decisionLogId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.attachmentIds = const Value.absent(),
  });
  IncidentRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String orderId,
    required String incidentType,
    required String status,
    this.trigger = const Value.absent(),
    this.automaticDecision = const Value.absent(),
    this.supplierInteraction = const Value.absent(),
    this.marketplaceInteraction = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.financialImpact = const Value.absent(),
    this.decisionLogId = const Value.absent(),
    required DateTime createdAt,
    this.resolvedAt = const Value.absent(),
    this.attachmentIds = const Value.absent(),
  }) : orderId = Value(orderId),
       incidentType = Value(incidentType),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<IncidentRecordRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? orderId,
    Expression<String>? incidentType,
    Expression<String>? status,
    Expression<String>? trigger,
    Expression<String>? automaticDecision,
    Expression<String>? supplierInteraction,
    Expression<String>? marketplaceInteraction,
    Expression<double>? refundAmount,
    Expression<double>? financialImpact,
    Expression<String>? decisionLogId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? resolvedAt,
    Expression<String>? attachmentIds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (orderId != null) 'order_id': orderId,
      if (incidentType != null) 'incident_type': incidentType,
      if (status != null) 'status': status,
      if (trigger != null) 'trigger': trigger,
      if (automaticDecision != null) 'automatic_decision': automaticDecision,
      if (supplierInteraction != null)
        'supplier_interaction': supplierInteraction,
      if (marketplaceInteraction != null)
        'marketplace_interaction': marketplaceInteraction,
      if (refundAmount != null) 'refund_amount': refundAmount,
      if (financialImpact != null) 'financial_impact': financialImpact,
      if (decisionLogId != null) 'decision_log_id': decisionLogId,
      if (createdAt != null) 'created_at': createdAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (attachmentIds != null) 'attachment_ids': attachmentIds,
    });
  }

  IncidentRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? orderId,
    Value<String>? incidentType,
    Value<String>? status,
    Value<String>? trigger,
    Value<String?>? automaticDecision,
    Value<String?>? supplierInteraction,
    Value<String?>? marketplaceInteraction,
    Value<double?>? refundAmount,
    Value<double?>? financialImpact,
    Value<String?>? decisionLogId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? resolvedAt,
    Value<String?>? attachmentIds,
  }) {
    return IncidentRecordsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      orderId: orderId ?? this.orderId,
      incidentType: incidentType ?? this.incidentType,
      status: status ?? this.status,
      trigger: trigger ?? this.trigger,
      automaticDecision: automaticDecision ?? this.automaticDecision,
      supplierInteraction: supplierInteraction ?? this.supplierInteraction,
      marketplaceInteraction:
          marketplaceInteraction ?? this.marketplaceInteraction,
      refundAmount: refundAmount ?? this.refundAmount,
      financialImpact: financialImpact ?? this.financialImpact,
      decisionLogId: decisionLogId ?? this.decisionLogId,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      attachmentIds: attachmentIds ?? this.attachmentIds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (incidentType.present) {
      map['incident_type'] = Variable<String>(incidentType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (trigger.present) {
      map['trigger'] = Variable<String>(trigger.value);
    }
    if (automaticDecision.present) {
      map['automatic_decision'] = Variable<String>(automaticDecision.value);
    }
    if (supplierInteraction.present) {
      map['supplier_interaction'] = Variable<String>(supplierInteraction.value);
    }
    if (marketplaceInteraction.present) {
      map['marketplace_interaction'] = Variable<String>(
        marketplaceInteraction.value,
      );
    }
    if (refundAmount.present) {
      map['refund_amount'] = Variable<double>(refundAmount.value);
    }
    if (financialImpact.present) {
      map['financial_impact'] = Variable<double>(financialImpact.value);
    }
    if (decisionLogId.present) {
      map['decision_log_id'] = Variable<String>(decisionLogId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (attachmentIds.present) {
      map['attachment_ids'] = Variable<String>(attachmentIds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncidentRecordsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('orderId: $orderId, ')
          ..write('incidentType: $incidentType, ')
          ..write('status: $status, ')
          ..write('trigger: $trigger, ')
          ..write('automaticDecision: $automaticDecision, ')
          ..write('supplierInteraction: $supplierInteraction, ')
          ..write('marketplaceInteraction: $marketplaceInteraction, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('financialImpact: $financialImpact, ')
          ..write('decisionLogId: $decisionLogId, ')
          ..write('createdAt: $createdAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('attachmentIds: $attachmentIds')
          ..write(')'))
        .toString();
  }
}

class $ReturnedStocksTable extends ReturnedStocks
    with TableInfo<$ReturnedStocksTable, ReturnedStockRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnedStocksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('as_new'),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restockableMeta = const VerificationMeta(
    'restockable',
  );
  @override
  late final GeneratedColumn<bool> restockable = GeneratedColumn<bool>(
    'restockable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("restockable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _sourceReturnIdMeta = const VerificationMeta(
    'sourceReturnId',
  );
  @override
  late final GeneratedColumn<String> sourceReturnId = GeneratedColumn<String>(
    'source_return_id',
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
    tenantId,
    productId,
    supplierId,
    condition,
    quantity,
    restockable,
    sourceOrderId,
    sourceReturnId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'returned_stocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnedStockRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('restockable')) {
      context.handle(
        _restockableMeta,
        restockable.isAcceptableOrUnknown(
          data['restockable']!,
          _restockableMeta,
        ),
      );
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
    if (data.containsKey('source_return_id')) {
      context.handle(
        _sourceReturnIdMeta,
        sourceReturnId.isAcceptableOrUnknown(
          data['source_return_id']!,
          _sourceReturnIdMeta,
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
  ReturnedStockRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnedStockRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      restockable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}restockable'],
      )!,
      sourceOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_order_id'],
      ),
      sourceReturnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_return_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReturnedStocksTable createAlias(String alias) {
    return $ReturnedStocksTable(attachedDatabase, alias);
  }
}

class ReturnedStockRow extends DataClass
    implements Insertable<ReturnedStockRow> {
  final int id;
  final int tenantId;
  final String productId;
  final String supplierId;
  final String condition;
  final int quantity;
  final bool restockable;
  final String? sourceOrderId;
  final String? sourceReturnId;
  final DateTime createdAt;
  const ReturnedStockRow({
    required this.id,
    required this.tenantId,
    required this.productId,
    required this.supplierId,
    required this.condition,
    required this.quantity,
    required this.restockable,
    this.sourceOrderId,
    this.sourceReturnId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['product_id'] = Variable<String>(productId);
    map['supplier_id'] = Variable<String>(supplierId);
    map['condition'] = Variable<String>(condition);
    map['quantity'] = Variable<int>(quantity);
    map['restockable'] = Variable<bool>(restockable);
    if (!nullToAbsent || sourceOrderId != null) {
      map['source_order_id'] = Variable<String>(sourceOrderId);
    }
    if (!nullToAbsent || sourceReturnId != null) {
      map['source_return_id'] = Variable<String>(sourceReturnId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReturnedStocksCompanion toCompanion(bool nullToAbsent) {
    return ReturnedStocksCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      productId: Value(productId),
      supplierId: Value(supplierId),
      condition: Value(condition),
      quantity: Value(quantity),
      restockable: Value(restockable),
      sourceOrderId: sourceOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceOrderId),
      sourceReturnId: sourceReturnId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceReturnId),
      createdAt: Value(createdAt),
    );
  }

  factory ReturnedStockRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnedStockRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      productId: serializer.fromJson<String>(json['productId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      condition: serializer.fromJson<String>(json['condition']),
      quantity: serializer.fromJson<int>(json['quantity']),
      restockable: serializer.fromJson<bool>(json['restockable']),
      sourceOrderId: serializer.fromJson<String?>(json['sourceOrderId']),
      sourceReturnId: serializer.fromJson<String?>(json['sourceReturnId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'productId': serializer.toJson<String>(productId),
      'supplierId': serializer.toJson<String>(supplierId),
      'condition': serializer.toJson<String>(condition),
      'quantity': serializer.toJson<int>(quantity),
      'restockable': serializer.toJson<bool>(restockable),
      'sourceOrderId': serializer.toJson<String?>(sourceOrderId),
      'sourceReturnId': serializer.toJson<String?>(sourceReturnId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ReturnedStockRow copyWith({
    int? id,
    int? tenantId,
    String? productId,
    String? supplierId,
    String? condition,
    int? quantity,
    bool? restockable,
    Value<String?> sourceOrderId = const Value.absent(),
    Value<String?> sourceReturnId = const Value.absent(),
    DateTime? createdAt,
  }) => ReturnedStockRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    productId: productId ?? this.productId,
    supplierId: supplierId ?? this.supplierId,
    condition: condition ?? this.condition,
    quantity: quantity ?? this.quantity,
    restockable: restockable ?? this.restockable,
    sourceOrderId: sourceOrderId.present
        ? sourceOrderId.value
        : this.sourceOrderId,
    sourceReturnId: sourceReturnId.present
        ? sourceReturnId.value
        : this.sourceReturnId,
    createdAt: createdAt ?? this.createdAt,
  );
  ReturnedStockRow copyWithCompanion(ReturnedStocksCompanion data) {
    return ReturnedStockRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      productId: data.productId.present ? data.productId.value : this.productId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      condition: data.condition.present ? data.condition.value : this.condition,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      restockable: data.restockable.present
          ? data.restockable.value
          : this.restockable,
      sourceOrderId: data.sourceOrderId.present
          ? data.sourceOrderId.value
          : this.sourceOrderId,
      sourceReturnId: data.sourceReturnId.present
          ? data.sourceReturnId.value
          : this.sourceReturnId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnedStockRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId, ')
          ..write('condition: $condition, ')
          ..write('quantity: $quantity, ')
          ..write('restockable: $restockable, ')
          ..write('sourceOrderId: $sourceOrderId, ')
          ..write('sourceReturnId: $sourceReturnId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    productId,
    supplierId,
    condition,
    quantity,
    restockable,
    sourceOrderId,
    sourceReturnId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnedStockRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.productId == this.productId &&
          other.supplierId == this.supplierId &&
          other.condition == this.condition &&
          other.quantity == this.quantity &&
          other.restockable == this.restockable &&
          other.sourceOrderId == this.sourceOrderId &&
          other.sourceReturnId == this.sourceReturnId &&
          other.createdAt == this.createdAt);
}

class ReturnedStocksCompanion extends UpdateCompanion<ReturnedStockRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> productId;
  final Value<String> supplierId;
  final Value<String> condition;
  final Value<int> quantity;
  final Value<bool> restockable;
  final Value<String?> sourceOrderId;
  final Value<String?> sourceReturnId;
  final Value<DateTime> createdAt;
  const ReturnedStocksCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.productId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.condition = const Value.absent(),
    this.quantity = const Value.absent(),
    this.restockable = const Value.absent(),
    this.sourceOrderId = const Value.absent(),
    this.sourceReturnId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReturnedStocksCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String productId,
    required String supplierId,
    this.condition = const Value.absent(),
    required int quantity,
    this.restockable = const Value.absent(),
    this.sourceOrderId = const Value.absent(),
    this.sourceReturnId = const Value.absent(),
    required DateTime createdAt,
  }) : productId = Value(productId),
       supplierId = Value(supplierId),
       quantity = Value(quantity),
       createdAt = Value(createdAt);
  static Insertable<ReturnedStockRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? productId,
    Expression<String>? supplierId,
    Expression<String>? condition,
    Expression<int>? quantity,
    Expression<bool>? restockable,
    Expression<String>? sourceOrderId,
    Expression<String>? sourceReturnId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (productId != null) 'product_id': productId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (condition != null) 'condition': condition,
      if (quantity != null) 'quantity': quantity,
      if (restockable != null) 'restockable': restockable,
      if (sourceOrderId != null) 'source_order_id': sourceOrderId,
      if (sourceReturnId != null) 'source_return_id': sourceReturnId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReturnedStocksCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? productId,
    Value<String>? supplierId,
    Value<String>? condition,
    Value<int>? quantity,
    Value<bool>? restockable,
    Value<String?>? sourceOrderId,
    Value<String?>? sourceReturnId,
    Value<DateTime>? createdAt,
  }) {
    return ReturnedStocksCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      productId: productId ?? this.productId,
      supplierId: supplierId ?? this.supplierId,
      condition: condition ?? this.condition,
      quantity: quantity ?? this.quantity,
      restockable: restockable ?? this.restockable,
      sourceOrderId: sourceOrderId ?? this.sourceOrderId,
      sourceReturnId: sourceReturnId ?? this.sourceReturnId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (restockable.present) {
      map['restockable'] = Variable<bool>(restockable.value);
    }
    if (sourceOrderId.present) {
      map['source_order_id'] = Variable<String>(sourceOrderId.value);
    }
    if (sourceReturnId.present) {
      map['source_return_id'] = Variable<String>(sourceReturnId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnedStocksCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId, ')
          ..write('condition: $condition, ')
          ..write('quantity: $quantity, ')
          ..write('restockable: $restockable, ')
          ..write('sourceOrderId: $sourceOrderId, ')
          ..write('sourceReturnId: $sourceReturnId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FinancialLedgerTable extends FinancialLedger
    with TableInfo<$FinancialLedgerTable, FinancialLedgerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialLedgerTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
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
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
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
    tenantId,
    type,
    orderId,
    amount,
    currency,
    referenceId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_ledger';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialLedgerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
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
  FinancialLedgerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialLedgerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FinancialLedgerTable createAlias(String alias) {
    return $FinancialLedgerTable(attachedDatabase, alias);
  }
}

class FinancialLedgerRow extends DataClass
    implements Insertable<FinancialLedgerRow> {
  final int id;
  final int tenantId;
  final String type;
  final String? orderId;
  final double amount;
  final String currency;
  final String? referenceId;
  final DateTime createdAt;
  const FinancialLedgerRow({
    required this.id,
    required this.tenantId,
    required this.type,
    this.orderId,
    required this.amount,
    required this.currency,
    this.referenceId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || orderId != null) {
      map['order_id'] = Variable<String>(orderId);
    }
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FinancialLedgerCompanion toCompanion(bool nullToAbsent) {
    return FinancialLedgerCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      type: Value(type),
      orderId: orderId == null && nullToAbsent
          ? const Value.absent()
          : Value(orderId),
      amount: Value(amount),
      currency: Value(currency),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      createdAt: Value(createdAt),
    );
  }

  factory FinancialLedgerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialLedgerRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      type: serializer.fromJson<String>(json['type']),
      orderId: serializer.fromJson<String?>(json['orderId']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'type': serializer.toJson<String>(type),
      'orderId': serializer.toJson<String?>(orderId),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'referenceId': serializer.toJson<String?>(referenceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FinancialLedgerRow copyWith({
    int? id,
    int? tenantId,
    String? type,
    Value<String?> orderId = const Value.absent(),
    double? amount,
    String? currency,
    Value<String?> referenceId = const Value.absent(),
    DateTime? createdAt,
  }) => FinancialLedgerRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    type: type ?? this.type,
    orderId: orderId.present ? orderId.value : this.orderId,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    createdAt: createdAt ?? this.createdAt,
  );
  FinancialLedgerRow copyWithCompanion(FinancialLedgerCompanion data) {
    return FinancialLedgerRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      type: data.type.present ? data.type.value : this.type,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialLedgerRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('type: $type, ')
          ..write('orderId: $orderId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('referenceId: $referenceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    type,
    orderId,
    amount,
    currency,
    referenceId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialLedgerRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.type == this.type &&
          other.orderId == this.orderId &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.referenceId == this.referenceId &&
          other.createdAt == this.createdAt);
}

class FinancialLedgerCompanion extends UpdateCompanion<FinancialLedgerRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> type;
  final Value<String?> orderId;
  final Value<double> amount;
  final Value<String> currency;
  final Value<String?> referenceId;
  final Value<DateTime> createdAt;
  const FinancialLedgerCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.type = const Value.absent(),
    this.orderId = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FinancialLedgerCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String type,
    this.orderId = const Value.absent(),
    required double amount,
    this.currency = const Value.absent(),
    this.referenceId = const Value.absent(),
    required DateTime createdAt,
  }) : type = Value(type),
       amount = Value(amount),
       createdAt = Value(createdAt);
  static Insertable<FinancialLedgerRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? type,
    Expression<String>? orderId,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<String>? referenceId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (type != null) 'type': type,
      if (orderId != null) 'order_id': orderId,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (referenceId != null) 'reference_id': referenceId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FinancialLedgerCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? type,
    Value<String?>? orderId,
    Value<double>? amount,
    Value<String>? currency,
    Value<String?>? referenceId,
    Value<DateTime>? createdAt,
  }) {
    return FinancialLedgerCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      type: type ?? this.type,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      referenceId: referenceId ?? this.referenceId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialLedgerCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('type: $type, ')
          ..write('orderId: $orderId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('referenceId: $referenceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FeatureFlagsTable extends FeatureFlags
    with TableInfo<$FeatureFlagsTable, FeatureFlagRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeatureFlagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [name, tenantId, enabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feature_flags';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeatureFlagRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  FeatureFlagRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeatureFlagRow(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $FeatureFlagsTable createAlias(String alias) {
    return $FeatureFlagsTable(attachedDatabase, alias);
  }
}

class FeatureFlagRow extends DataClass implements Insertable<FeatureFlagRow> {
  final String name;
  final int tenantId;
  final bool enabled;
  const FeatureFlagRow({
    required this.name,
    required this.tenantId,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['tenant_id'] = Variable<int>(tenantId);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  FeatureFlagsCompanion toCompanion(bool nullToAbsent) {
    return FeatureFlagsCompanion(
      name: Value(name),
      tenantId: Value(tenantId),
      enabled: Value(enabled),
    );
  }

  factory FeatureFlagRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeatureFlagRow(
      name: serializer.fromJson<String>(json['name']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'tenantId': serializer.toJson<int>(tenantId),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  FeatureFlagRow copyWith({String? name, int? tenantId, bool? enabled}) =>
      FeatureFlagRow(
        name: name ?? this.name,
        tenantId: tenantId ?? this.tenantId,
        enabled: enabled ?? this.enabled,
      );
  FeatureFlagRow copyWithCompanion(FeatureFlagsCompanion data) {
    return FeatureFlagRow(
      name: data.name.present ? data.name.value : this.name,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeatureFlagRow(')
          ..write('name: $name, ')
          ..write('tenantId: $tenantId, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, tenantId, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeatureFlagRow &&
          other.name == this.name &&
          other.tenantId == this.tenantId &&
          other.enabled == this.enabled);
}

class FeatureFlagsCompanion extends UpdateCompanion<FeatureFlagRow> {
  final Value<String> name;
  final Value<int> tenantId;
  final Value<bool> enabled;
  final Value<int> rowid;
  const FeatureFlagsCompanion({
    this.name = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeatureFlagsCompanion.insert({
    required String name,
    this.tenantId = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<FeatureFlagRow> custom({
    Expression<String>? name,
    Expression<int>? tenantId,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (tenantId != null) 'tenant_id': tenantId,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeatureFlagsCompanion copyWith({
    Value<String>? name,
    Value<int>? tenantId,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return FeatureFlagsCompanion(
      name: name ?? this.name,
      tenantId: tenantId ?? this.tenantId,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeatureFlagsCompanion(')
          ..write('name: $name, ')
          ..write('tenantId: $tenantId, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackgroundJobsTable extends BackgroundJobs
    with TableInfo<$BackgroundJobsTable, BackgroundJobRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackgroundJobsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _jobTypeMeta = const VerificationMeta(
    'jobType',
  );
  @override
  late final GeneratedColumn<String> jobType = GeneratedColumn<String>(
    'job_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
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
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _maxAttemptsMeta = const VerificationMeta(
    'maxAttempts',
  );
  @override
  late final GeneratedColumn<int> maxAttempts = GeneratedColumn<int>(
    'max_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
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
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    jobType,
    payloadJson,
    status,
    attempts,
    maxAttempts,
    createdAt,
    startedAt,
    completedAt,
    errorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'background_jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackgroundJobRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('job_type')) {
      context.handle(
        _jobTypeMeta,
        jobType.isAcceptableOrUnknown(data['job_type']!, _jobTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_jobTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
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
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('max_attempts')) {
      context.handle(
        _maxAttemptsMeta,
        maxAttempts.isAcceptableOrUnknown(
          data['max_attempts']!,
          _maxAttemptsMeta,
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
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackgroundJobRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackgroundJobRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      jobType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_type'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      maxAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_attempts'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
    );
  }

  @override
  $BackgroundJobsTable createAlias(String alias) {
    return $BackgroundJobsTable(attachedDatabase, alias);
  }
}

class BackgroundJobRow extends DataClass
    implements Insertable<BackgroundJobRow> {
  final int id;
  final int tenantId;
  final String jobType;
  final String payloadJson;
  final String status;
  final int attempts;
  final int maxAttempts;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? errorMessage;
  const BackgroundJobRow({
    required this.id,
    required this.tenantId,
    required this.jobType,
    required this.payloadJson,
    required this.status,
    required this.attempts,
    required this.maxAttempts,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.errorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['job_type'] = Variable<String>(jobType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['status'] = Variable<String>(status);
    map['attempts'] = Variable<int>(attempts);
    map['max_attempts'] = Variable<int>(maxAttempts);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  BackgroundJobsCompanion toCompanion(bool nullToAbsent) {
    return BackgroundJobsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      jobType: Value(jobType),
      payloadJson: Value(payloadJson),
      status: Value(status),
      attempts: Value(attempts),
      maxAttempts: Value(maxAttempts),
      createdAt: Value(createdAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory BackgroundJobRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackgroundJobRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      jobType: serializer.fromJson<String>(json['jobType']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      status: serializer.fromJson<String>(json['status']),
      attempts: serializer.fromJson<int>(json['attempts']),
      maxAttempts: serializer.fromJson<int>(json['maxAttempts']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'jobType': serializer.toJson<String>(jobType),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'status': serializer.toJson<String>(status),
      'attempts': serializer.toJson<int>(attempts),
      'maxAttempts': serializer.toJson<int>(maxAttempts),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  BackgroundJobRow copyWith({
    int? id,
    int? tenantId,
    String? jobType,
    String? payloadJson,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? createdAt,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
  }) => BackgroundJobRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    jobType: jobType ?? this.jobType,
    payloadJson: payloadJson ?? this.payloadJson,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    maxAttempts: maxAttempts ?? this.maxAttempts,
    createdAt: createdAt ?? this.createdAt,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
  );
  BackgroundJobRow copyWithCompanion(BackgroundJobsCompanion data) {
    return BackgroundJobRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      jobType: data.jobType.present ? data.jobType.value : this.jobType,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      maxAttempts: data.maxAttempts.present
          ? data.maxAttempts.value
          : this.maxAttempts,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundJobRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('jobType: $jobType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('maxAttempts: $maxAttempts, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    jobType,
    payloadJson,
    status,
    attempts,
    maxAttempts,
    createdAt,
    startedAt,
    completedAt,
    errorMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackgroundJobRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.jobType == this.jobType &&
          other.payloadJson == this.payloadJson &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.maxAttempts == this.maxAttempts &&
          other.createdAt == this.createdAt &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.errorMessage == this.errorMessage);
}

class BackgroundJobsCompanion extends UpdateCompanion<BackgroundJobRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> jobType;
  final Value<String> payloadJson;
  final Value<String> status;
  final Value<int> attempts;
  final Value<int> maxAttempts;
  final Value<DateTime> createdAt;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String?> errorMessage;
  const BackgroundJobsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.jobType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.maxAttempts = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
  });
  BackgroundJobsCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String jobType,
    this.payloadJson = const Value.absent(),
    required String status,
    this.attempts = const Value.absent(),
    this.maxAttempts = const Value.absent(),
    required DateTime createdAt,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
  }) : jobType = Value(jobType),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<BackgroundJobRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? jobType,
    Expression<String>? payloadJson,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<int>? maxAttempts,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? errorMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (jobType != null) 'job_type': jobType,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (maxAttempts != null) 'max_attempts': maxAttempts,
      if (createdAt != null) 'created_at': createdAt,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }

  BackgroundJobsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? jobType,
    Value<String>? payloadJson,
    Value<String>? status,
    Value<int>? attempts,
    Value<int>? maxAttempts,
    Value<DateTime>? createdAt,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String?>? errorMessage,
  }) {
    return BackgroundJobsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      jobType: jobType ?? this.jobType,
      payloadJson: payloadJson ?? this.payloadJson,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (jobType.present) {
      map['job_type'] = Variable<String>(jobType.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (maxAttempts.present) {
      map['max_attempts'] = Variable<int>(maxAttempts.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundJobsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('jobType: $jobType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('maxAttempts: $maxAttempts, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }
}

class $DistributedLocksTable extends DistributedLocks
    with TableInfo<$DistributedLocksTable, DistributedLockRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DistributedLocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lockKeyMeta = const VerificationMeta(
    'lockKey',
  );
  @override
  late final GeneratedColumn<String> lockKey = GeneratedColumn<String>(
    'lock_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [lockKey, tenantId, expiresAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'distributed_locks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DistributedLockRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('lock_key')) {
      context.handle(
        _lockKeyMeta,
        lockKey.isAcceptableOrUnknown(data['lock_key']!, _lockKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_lockKeyMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {lockKey};
  @override
  DistributedLockRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DistributedLockRow(
      lockKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lock_key'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
    );
  }

  @override
  $DistributedLocksTable createAlias(String alias) {
    return $DistributedLocksTable(attachedDatabase, alias);
  }
}

class DistributedLockRow extends DataClass
    implements Insertable<DistributedLockRow> {
  final String lockKey;
  final int tenantId;
  final DateTime expiresAt;
  const DistributedLockRow({
    required this.lockKey,
    required this.tenantId,
    required this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['lock_key'] = Variable<String>(lockKey);
    map['tenant_id'] = Variable<int>(tenantId);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  DistributedLocksCompanion toCompanion(bool nullToAbsent) {
    return DistributedLocksCompanion(
      lockKey: Value(lockKey),
      tenantId: Value(tenantId),
      expiresAt: Value(expiresAt),
    );
  }

  factory DistributedLockRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DistributedLockRow(
      lockKey: serializer.fromJson<String>(json['lockKey']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lockKey': serializer.toJson<String>(lockKey),
      'tenantId': serializer.toJson<int>(tenantId),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  DistributedLockRow copyWith({
    String? lockKey,
    int? tenantId,
    DateTime? expiresAt,
  }) => DistributedLockRow(
    lockKey: lockKey ?? this.lockKey,
    tenantId: tenantId ?? this.tenantId,
    expiresAt: expiresAt ?? this.expiresAt,
  );
  DistributedLockRow copyWithCompanion(DistributedLocksCompanion data) {
    return DistributedLockRow(
      lockKey: data.lockKey.present ? data.lockKey.value : this.lockKey,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DistributedLockRow(')
          ..write('lockKey: $lockKey, ')
          ..write('tenantId: $tenantId, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(lockKey, tenantId, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DistributedLockRow &&
          other.lockKey == this.lockKey &&
          other.tenantId == this.tenantId &&
          other.expiresAt == this.expiresAt);
}

class DistributedLocksCompanion extends UpdateCompanion<DistributedLockRow> {
  final Value<String> lockKey;
  final Value<int> tenantId;
  final Value<DateTime> expiresAt;
  final Value<int> rowid;
  const DistributedLocksCompanion({
    this.lockKey = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DistributedLocksCompanion.insert({
    required String lockKey,
    this.tenantId = const Value.absent(),
    required DateTime expiresAt,
    this.rowid = const Value.absent(),
  }) : lockKey = Value(lockKey),
       expiresAt = Value(expiresAt);
  static Insertable<DistributedLockRow> custom({
    Expression<String>? lockKey,
    Expression<int>? tenantId,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lockKey != null) 'lock_key': lockKey,
      if (tenantId != null) 'tenant_id': tenantId,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DistributedLocksCompanion copyWith({
    Value<String>? lockKey,
    Value<int>? tenantId,
    Value<DateTime>? expiresAt,
    Value<int>? rowid,
  }) {
    return DistributedLocksCompanion(
      lockKey: lockKey ?? this.lockKey,
      tenantId: tenantId ?? this.tenantId,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lockKey.present) {
      map['lock_key'] = Variable<String>(lockKey.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DistributedLocksCompanion(')
          ..write('lockKey: $lockKey, ')
          ..write('tenantId: $tenantId, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillingPlansTable extends BillingPlans
    with TableInfo<$BillingPlansTable, BillingPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillingPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxListingsMeta = const VerificationMeta(
    'maxListings',
  );
  @override
  late final GeneratedColumn<int> maxListings = GeneratedColumn<int>(
    'max_listings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxOrdersPerMonthMeta = const VerificationMeta(
    'maxOrdersPerMonth',
  );
  @override
  late final GeneratedColumn<int> maxOrdersPerMonth = GeneratedColumn<int>(
    'max_orders_per_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stripePriceIdMeta = const VerificationMeta(
    'stripePriceId',
  );
  @override
  late final GeneratedColumn<String> stripePriceId = GeneratedColumn<String>(
    'stripe_price_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    maxListings,
    maxOrdersPerMonth,
    stripePriceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'billing_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillingPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('max_listings')) {
      context.handle(
        _maxListingsMeta,
        maxListings.isAcceptableOrUnknown(
          data['max_listings']!,
          _maxListingsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxListingsMeta);
    }
    if (data.containsKey('max_orders_per_month')) {
      context.handle(
        _maxOrdersPerMonthMeta,
        maxOrdersPerMonth.isAcceptableOrUnknown(
          data['max_orders_per_month']!,
          _maxOrdersPerMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxOrdersPerMonthMeta);
    }
    if (data.containsKey('stripe_price_id')) {
      context.handle(
        _stripePriceIdMeta,
        stripePriceId.isAcceptableOrUnknown(
          data['stripe_price_id']!,
          _stripePriceIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillingPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillingPlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      maxListings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_listings'],
      )!,
      maxOrdersPerMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_orders_per_month'],
      )!,
      stripePriceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stripe_price_id'],
      ),
    );
  }

  @override
  $BillingPlansTable createAlias(String alias) {
    return $BillingPlansTable(attachedDatabase, alias);
  }
}

class BillingPlanRow extends DataClass implements Insertable<BillingPlanRow> {
  final int id;
  final String name;
  final int maxListings;
  final int maxOrdersPerMonth;
  final String? stripePriceId;
  const BillingPlanRow({
    required this.id,
    required this.name,
    required this.maxListings,
    required this.maxOrdersPerMonth,
    this.stripePriceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['max_listings'] = Variable<int>(maxListings);
    map['max_orders_per_month'] = Variable<int>(maxOrdersPerMonth);
    if (!nullToAbsent || stripePriceId != null) {
      map['stripe_price_id'] = Variable<String>(stripePriceId);
    }
    return map;
  }

  BillingPlansCompanion toCompanion(bool nullToAbsent) {
    return BillingPlansCompanion(
      id: Value(id),
      name: Value(name),
      maxListings: Value(maxListings),
      maxOrdersPerMonth: Value(maxOrdersPerMonth),
      stripePriceId: stripePriceId == null && nullToAbsent
          ? const Value.absent()
          : Value(stripePriceId),
    );
  }

  factory BillingPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillingPlanRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      maxListings: serializer.fromJson<int>(json['maxListings']),
      maxOrdersPerMonth: serializer.fromJson<int>(json['maxOrdersPerMonth']),
      stripePriceId: serializer.fromJson<String?>(json['stripePriceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'maxListings': serializer.toJson<int>(maxListings),
      'maxOrdersPerMonth': serializer.toJson<int>(maxOrdersPerMonth),
      'stripePriceId': serializer.toJson<String?>(stripePriceId),
    };
  }

  BillingPlanRow copyWith({
    int? id,
    String? name,
    int? maxListings,
    int? maxOrdersPerMonth,
    Value<String?> stripePriceId = const Value.absent(),
  }) => BillingPlanRow(
    id: id ?? this.id,
    name: name ?? this.name,
    maxListings: maxListings ?? this.maxListings,
    maxOrdersPerMonth: maxOrdersPerMonth ?? this.maxOrdersPerMonth,
    stripePriceId: stripePriceId.present
        ? stripePriceId.value
        : this.stripePriceId,
  );
  BillingPlanRow copyWithCompanion(BillingPlansCompanion data) {
    return BillingPlanRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      maxListings: data.maxListings.present
          ? data.maxListings.value
          : this.maxListings,
      maxOrdersPerMonth: data.maxOrdersPerMonth.present
          ? data.maxOrdersPerMonth.value
          : this.maxOrdersPerMonth,
      stripePriceId: data.stripePriceId.present
          ? data.stripePriceId.value
          : this.stripePriceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillingPlanRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('maxListings: $maxListings, ')
          ..write('maxOrdersPerMonth: $maxOrdersPerMonth, ')
          ..write('stripePriceId: $stripePriceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, maxListings, maxOrdersPerMonth, stripePriceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillingPlanRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.maxListings == this.maxListings &&
          other.maxOrdersPerMonth == this.maxOrdersPerMonth &&
          other.stripePriceId == this.stripePriceId);
}

class BillingPlansCompanion extends UpdateCompanion<BillingPlanRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> maxListings;
  final Value<int> maxOrdersPerMonth;
  final Value<String?> stripePriceId;
  const BillingPlansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.maxListings = const Value.absent(),
    this.maxOrdersPerMonth = const Value.absent(),
    this.stripePriceId = const Value.absent(),
  });
  BillingPlansCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int maxListings,
    required int maxOrdersPerMonth,
    this.stripePriceId = const Value.absent(),
  }) : name = Value(name),
       maxListings = Value(maxListings),
       maxOrdersPerMonth = Value(maxOrdersPerMonth);
  static Insertable<BillingPlanRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? maxListings,
    Expression<int>? maxOrdersPerMonth,
    Expression<String>? stripePriceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (maxListings != null) 'max_listings': maxListings,
      if (maxOrdersPerMonth != null) 'max_orders_per_month': maxOrdersPerMonth,
      if (stripePriceId != null) 'stripe_price_id': stripePriceId,
    });
  }

  BillingPlansCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? maxListings,
    Value<int>? maxOrdersPerMonth,
    Value<String?>? stripePriceId,
  }) {
    return BillingPlansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      maxListings: maxListings ?? this.maxListings,
      maxOrdersPerMonth: maxOrdersPerMonth ?? this.maxOrdersPerMonth,
      stripePriceId: stripePriceId ?? this.stripePriceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (maxListings.present) {
      map['max_listings'] = Variable<int>(maxListings.value);
    }
    if (maxOrdersPerMonth.present) {
      map['max_orders_per_month'] = Variable<int>(maxOrdersPerMonth.value);
    }
    if (stripePriceId.present) {
      map['stripe_price_id'] = Variable<String>(stripePriceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillingPlansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('maxListings: $maxListings, ')
          ..write('maxOrdersPerMonth: $maxOrdersPerMonth, ')
          ..write('stripePriceId: $stripePriceId')
          ..write(')'))
        .toString();
  }
}

class $TenantPlansTable extends TenantPlans
    with TableInfo<$TenantPlansTable, TenantPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenantPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stripeCustomerIdMeta = const VerificationMeta(
    'stripeCustomerId',
  );
  @override
  late final GeneratedColumn<String> stripeCustomerId = GeneratedColumn<String>(
    'stripe_customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stripeSubscriptionIdMeta =
      const VerificationMeta('stripeSubscriptionId');
  @override
  late final GeneratedColumn<String> stripeSubscriptionId =
      GeneratedColumn<String>(
        'stripe_subscription_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _currentPeriodStartMeta =
      const VerificationMeta('currentPeriodStart');
  @override
  late final GeneratedColumn<DateTime> currentPeriodStart =
      GeneratedColumn<DateTime>(
        'current_period_start',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _currentPeriodEndMeta = const VerificationMeta(
    'currentPeriodEnd',
  );
  @override
  late final GeneratedColumn<DateTime> currentPeriodEnd =
      GeneratedColumn<DateTime>(
        'current_period_end',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    tenantId,
    planId,
    stripeCustomerId,
    stripeSubscriptionId,
    currentPeriodStart,
    currentPeriodEnd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenant_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<TenantPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('stripe_customer_id')) {
      context.handle(
        _stripeCustomerIdMeta,
        stripeCustomerId.isAcceptableOrUnknown(
          data['stripe_customer_id']!,
          _stripeCustomerIdMeta,
        ),
      );
    }
    if (data.containsKey('stripe_subscription_id')) {
      context.handle(
        _stripeSubscriptionIdMeta,
        stripeSubscriptionId.isAcceptableOrUnknown(
          data['stripe_subscription_id']!,
          _stripeSubscriptionIdMeta,
        ),
      );
    }
    if (data.containsKey('current_period_start')) {
      context.handle(
        _currentPeriodStartMeta,
        currentPeriodStart.isAcceptableOrUnknown(
          data['current_period_start']!,
          _currentPeriodStartMeta,
        ),
      );
    }
    if (data.containsKey('current_period_end')) {
      context.handle(
        _currentPeriodEndMeta,
        currentPeriodEnd.isAcceptableOrUnknown(
          data['current_period_end']!,
          _currentPeriodEndMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tenantId};
  @override
  TenantPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TenantPlanRow(
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      stripeCustomerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stripe_customer_id'],
      ),
      stripeSubscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stripe_subscription_id'],
      ),
      currentPeriodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}current_period_start'],
      ),
      currentPeriodEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}current_period_end'],
      ),
    );
  }

  @override
  $TenantPlansTable createAlias(String alias) {
    return $TenantPlansTable(attachedDatabase, alias);
  }
}

class TenantPlanRow extends DataClass implements Insertable<TenantPlanRow> {
  final int tenantId;
  final int planId;
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final DateTime? currentPeriodStart;
  final DateTime? currentPeriodEnd;
  const TenantPlanRow({
    required this.tenantId,
    required this.planId,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.currentPeriodStart,
    this.currentPeriodEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tenant_id'] = Variable<int>(tenantId);
    map['plan_id'] = Variable<int>(planId);
    if (!nullToAbsent || stripeCustomerId != null) {
      map['stripe_customer_id'] = Variable<String>(stripeCustomerId);
    }
    if (!nullToAbsent || stripeSubscriptionId != null) {
      map['stripe_subscription_id'] = Variable<String>(stripeSubscriptionId);
    }
    if (!nullToAbsent || currentPeriodStart != null) {
      map['current_period_start'] = Variable<DateTime>(currentPeriodStart);
    }
    if (!nullToAbsent || currentPeriodEnd != null) {
      map['current_period_end'] = Variable<DateTime>(currentPeriodEnd);
    }
    return map;
  }

  TenantPlansCompanion toCompanion(bool nullToAbsent) {
    return TenantPlansCompanion(
      tenantId: Value(tenantId),
      planId: Value(planId),
      stripeCustomerId: stripeCustomerId == null && nullToAbsent
          ? const Value.absent()
          : Value(stripeCustomerId),
      stripeSubscriptionId: stripeSubscriptionId == null && nullToAbsent
          ? const Value.absent()
          : Value(stripeSubscriptionId),
      currentPeriodStart: currentPeriodStart == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPeriodStart),
      currentPeriodEnd: currentPeriodEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPeriodEnd),
    );
  }

  factory TenantPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TenantPlanRow(
      tenantId: serializer.fromJson<int>(json['tenantId']),
      planId: serializer.fromJson<int>(json['planId']),
      stripeCustomerId: serializer.fromJson<String?>(json['stripeCustomerId']),
      stripeSubscriptionId: serializer.fromJson<String?>(
        json['stripeSubscriptionId'],
      ),
      currentPeriodStart: serializer.fromJson<DateTime?>(
        json['currentPeriodStart'],
      ),
      currentPeriodEnd: serializer.fromJson<DateTime?>(
        json['currentPeriodEnd'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tenantId': serializer.toJson<int>(tenantId),
      'planId': serializer.toJson<int>(planId),
      'stripeCustomerId': serializer.toJson<String?>(stripeCustomerId),
      'stripeSubscriptionId': serializer.toJson<String?>(stripeSubscriptionId),
      'currentPeriodStart': serializer.toJson<DateTime?>(currentPeriodStart),
      'currentPeriodEnd': serializer.toJson<DateTime?>(currentPeriodEnd),
    };
  }

  TenantPlanRow copyWith({
    int? tenantId,
    int? planId,
    Value<String?> stripeCustomerId = const Value.absent(),
    Value<String?> stripeSubscriptionId = const Value.absent(),
    Value<DateTime?> currentPeriodStart = const Value.absent(),
    Value<DateTime?> currentPeriodEnd = const Value.absent(),
  }) => TenantPlanRow(
    tenantId: tenantId ?? this.tenantId,
    planId: planId ?? this.planId,
    stripeCustomerId: stripeCustomerId.present
        ? stripeCustomerId.value
        : this.stripeCustomerId,
    stripeSubscriptionId: stripeSubscriptionId.present
        ? stripeSubscriptionId.value
        : this.stripeSubscriptionId,
    currentPeriodStart: currentPeriodStart.present
        ? currentPeriodStart.value
        : this.currentPeriodStart,
    currentPeriodEnd: currentPeriodEnd.present
        ? currentPeriodEnd.value
        : this.currentPeriodEnd,
  );
  TenantPlanRow copyWithCompanion(TenantPlansCompanion data) {
    return TenantPlanRow(
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      planId: data.planId.present ? data.planId.value : this.planId,
      stripeCustomerId: data.stripeCustomerId.present
          ? data.stripeCustomerId.value
          : this.stripeCustomerId,
      stripeSubscriptionId: data.stripeSubscriptionId.present
          ? data.stripeSubscriptionId.value
          : this.stripeSubscriptionId,
      currentPeriodStart: data.currentPeriodStart.present
          ? data.currentPeriodStart.value
          : this.currentPeriodStart,
      currentPeriodEnd: data.currentPeriodEnd.present
          ? data.currentPeriodEnd.value
          : this.currentPeriodEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TenantPlanRow(')
          ..write('tenantId: $tenantId, ')
          ..write('planId: $planId, ')
          ..write('stripeCustomerId: $stripeCustomerId, ')
          ..write('stripeSubscriptionId: $stripeSubscriptionId, ')
          ..write('currentPeriodStart: $currentPeriodStart, ')
          ..write('currentPeriodEnd: $currentPeriodEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    tenantId,
    planId,
    stripeCustomerId,
    stripeSubscriptionId,
    currentPeriodStart,
    currentPeriodEnd,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TenantPlanRow &&
          other.tenantId == this.tenantId &&
          other.planId == this.planId &&
          other.stripeCustomerId == this.stripeCustomerId &&
          other.stripeSubscriptionId == this.stripeSubscriptionId &&
          other.currentPeriodStart == this.currentPeriodStart &&
          other.currentPeriodEnd == this.currentPeriodEnd);
}

class TenantPlansCompanion extends UpdateCompanion<TenantPlanRow> {
  final Value<int> tenantId;
  final Value<int> planId;
  final Value<String?> stripeCustomerId;
  final Value<String?> stripeSubscriptionId;
  final Value<DateTime?> currentPeriodStart;
  final Value<DateTime?> currentPeriodEnd;
  const TenantPlansCompanion({
    this.tenantId = const Value.absent(),
    this.planId = const Value.absent(),
    this.stripeCustomerId = const Value.absent(),
    this.stripeSubscriptionId = const Value.absent(),
    this.currentPeriodStart = const Value.absent(),
    this.currentPeriodEnd = const Value.absent(),
  });
  TenantPlansCompanion.insert({
    this.tenantId = const Value.absent(),
    required int planId,
    this.stripeCustomerId = const Value.absent(),
    this.stripeSubscriptionId = const Value.absent(),
    this.currentPeriodStart = const Value.absent(),
    this.currentPeriodEnd = const Value.absent(),
  }) : planId = Value(planId);
  static Insertable<TenantPlanRow> custom({
    Expression<int>? tenantId,
    Expression<int>? planId,
    Expression<String>? stripeCustomerId,
    Expression<String>? stripeSubscriptionId,
    Expression<DateTime>? currentPeriodStart,
    Expression<DateTime>? currentPeriodEnd,
  }) {
    return RawValuesInsertable({
      if (tenantId != null) 'tenant_id': tenantId,
      if (planId != null) 'plan_id': planId,
      if (stripeCustomerId != null) 'stripe_customer_id': stripeCustomerId,
      if (stripeSubscriptionId != null)
        'stripe_subscription_id': stripeSubscriptionId,
      if (currentPeriodStart != null)
        'current_period_start': currentPeriodStart,
      if (currentPeriodEnd != null) 'current_period_end': currentPeriodEnd,
    });
  }

  TenantPlansCompanion copyWith({
    Value<int>? tenantId,
    Value<int>? planId,
    Value<String?>? stripeCustomerId,
    Value<String?>? stripeSubscriptionId,
    Value<DateTime?>? currentPeriodStart,
    Value<DateTime?>? currentPeriodEnd,
  }) {
    return TenantPlansCompanion(
      tenantId: tenantId ?? this.tenantId,
      planId: planId ?? this.planId,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
      stripeSubscriptionId: stripeSubscriptionId ?? this.stripeSubscriptionId,
      currentPeriodStart: currentPeriodStart ?? this.currentPeriodStart,
      currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (stripeCustomerId.present) {
      map['stripe_customer_id'] = Variable<String>(stripeCustomerId.value);
    }
    if (stripeSubscriptionId.present) {
      map['stripe_subscription_id'] = Variable<String>(
        stripeSubscriptionId.value,
      );
    }
    if (currentPeriodStart.present) {
      map['current_period_start'] = Variable<DateTime>(
        currentPeriodStart.value,
      );
    }
    if (currentPeriodEnd.present) {
      map['current_period_end'] = Variable<DateTime>(currentPeriodEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenantPlansCompanion(')
          ..write('tenantId: $tenantId, ')
          ..write('planId: $planId, ')
          ..write('stripeCustomerId: $stripeCustomerId, ')
          ..write('stripeSubscriptionId: $stripeSubscriptionId, ')
          ..write('currentPeriodStart: $currentPeriodStart, ')
          ..write('currentPeriodEnd: $currentPeriodEnd')
          ..write(')'))
        .toString();
  }
}

class $SupplierReliabilityScoresTable extends SupplierReliabilityScores
    with
        TableInfo<
          $SupplierReliabilityScoresTable,
          SupplierReliabilityScoreRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierReliabilityScoresTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricsJsonMeta = const VerificationMeta(
    'metricsJson',
  );
  @override
  late final GeneratedColumn<String> metricsJson = GeneratedColumn<String>(
    'metrics_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _lastEvaluatedAtMeta = const VerificationMeta(
    'lastEvaluatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastEvaluatedAt =
      GeneratedColumn<DateTime>(
        'last_evaluated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    supplierId,
    score,
    metricsJson,
    lastEvaluatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_reliability_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierReliabilityScoreRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('metrics_json')) {
      context.handle(
        _metricsJsonMeta,
        metricsJson.isAcceptableOrUnknown(
          data['metrics_json']!,
          _metricsJsonMeta,
        ),
      );
    }
    if (data.containsKey('last_evaluated_at')) {
      context.handle(
        _lastEvaluatedAtMeta,
        lastEvaluatedAt.isAcceptableOrUnknown(
          data['last_evaluated_at']!,
          _lastEvaluatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastEvaluatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierReliabilityScoreRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierReliabilityScoreRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      )!,
      metricsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metrics_json'],
      )!,
      lastEvaluatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_evaluated_at'],
      )!,
    );
  }

  @override
  $SupplierReliabilityScoresTable createAlias(String alias) {
    return $SupplierReliabilityScoresTable(attachedDatabase, alias);
  }
}

class SupplierReliabilityScoreRow extends DataClass
    implements Insertable<SupplierReliabilityScoreRow> {
  final int id;
  final int tenantId;
  final String supplierId;
  final double score;
  final String metricsJson;
  final DateTime lastEvaluatedAt;
  const SupplierReliabilityScoreRow({
    required this.id,
    required this.tenantId,
    required this.supplierId,
    required this.score,
    required this.metricsJson,
    required this.lastEvaluatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['supplier_id'] = Variable<String>(supplierId);
    map['score'] = Variable<double>(score);
    map['metrics_json'] = Variable<String>(metricsJson);
    map['last_evaluated_at'] = Variable<DateTime>(lastEvaluatedAt);
    return map;
  }

  SupplierReliabilityScoresCompanion toCompanion(bool nullToAbsent) {
    return SupplierReliabilityScoresCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      supplierId: Value(supplierId),
      score: Value(score),
      metricsJson: Value(metricsJson),
      lastEvaluatedAt: Value(lastEvaluatedAt),
    );
  }

  factory SupplierReliabilityScoreRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierReliabilityScoreRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      score: serializer.fromJson<double>(json['score']),
      metricsJson: serializer.fromJson<String>(json['metricsJson']),
      lastEvaluatedAt: serializer.fromJson<DateTime>(json['lastEvaluatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'supplierId': serializer.toJson<String>(supplierId),
      'score': serializer.toJson<double>(score),
      'metricsJson': serializer.toJson<String>(metricsJson),
      'lastEvaluatedAt': serializer.toJson<DateTime>(lastEvaluatedAt),
    };
  }

  SupplierReliabilityScoreRow copyWith({
    int? id,
    int? tenantId,
    String? supplierId,
    double? score,
    String? metricsJson,
    DateTime? lastEvaluatedAt,
  }) => SupplierReliabilityScoreRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    supplierId: supplierId ?? this.supplierId,
    score: score ?? this.score,
    metricsJson: metricsJson ?? this.metricsJson,
    lastEvaluatedAt: lastEvaluatedAt ?? this.lastEvaluatedAt,
  );
  SupplierReliabilityScoreRow copyWithCompanion(
    SupplierReliabilityScoresCompanion data,
  ) {
    return SupplierReliabilityScoreRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      score: data.score.present ? data.score.value : this.score,
      metricsJson: data.metricsJson.present
          ? data.metricsJson.value
          : this.metricsJson,
      lastEvaluatedAt: data.lastEvaluatedAt.present
          ? data.lastEvaluatedAt.value
          : this.lastEvaluatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierReliabilityScoreRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('supplierId: $supplierId, ')
          ..write('score: $score, ')
          ..write('metricsJson: $metricsJson, ')
          ..write('lastEvaluatedAt: $lastEvaluatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    supplierId,
    score,
    metricsJson,
    lastEvaluatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierReliabilityScoreRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.supplierId == this.supplierId &&
          other.score == this.score &&
          other.metricsJson == this.metricsJson &&
          other.lastEvaluatedAt == this.lastEvaluatedAt);
}

class SupplierReliabilityScoresCompanion
    extends UpdateCompanion<SupplierReliabilityScoreRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> supplierId;
  final Value<double> score;
  final Value<String> metricsJson;
  final Value<DateTime> lastEvaluatedAt;
  const SupplierReliabilityScoresCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.score = const Value.absent(),
    this.metricsJson = const Value.absent(),
    this.lastEvaluatedAt = const Value.absent(),
  });
  SupplierReliabilityScoresCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String supplierId,
    required double score,
    this.metricsJson = const Value.absent(),
    required DateTime lastEvaluatedAt,
  }) : supplierId = Value(supplierId),
       score = Value(score),
       lastEvaluatedAt = Value(lastEvaluatedAt);
  static Insertable<SupplierReliabilityScoreRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? supplierId,
    Expression<double>? score,
    Expression<String>? metricsJson,
    Expression<DateTime>? lastEvaluatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (score != null) 'score': score,
      if (metricsJson != null) 'metrics_json': metricsJson,
      if (lastEvaluatedAt != null) 'last_evaluated_at': lastEvaluatedAt,
    });
  }

  SupplierReliabilityScoresCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? supplierId,
    Value<double>? score,
    Value<String>? metricsJson,
    Value<DateTime>? lastEvaluatedAt,
  }) {
    return SupplierReliabilityScoresCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      supplierId: supplierId ?? this.supplierId,
      score: score ?? this.score,
      metricsJson: metricsJson ?? this.metricsJson,
      lastEvaluatedAt: lastEvaluatedAt ?? this.lastEvaluatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (metricsJson.present) {
      map['metrics_json'] = Variable<String>(metricsJson.value);
    }
    if (lastEvaluatedAt.present) {
      map['last_evaluated_at'] = Variable<DateTime>(lastEvaluatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierReliabilityScoresCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('supplierId: $supplierId, ')
          ..write('score: $score, ')
          ..write('metricsJson: $metricsJson, ')
          ..write('lastEvaluatedAt: $lastEvaluatedAt')
          ..write(')'))
        .toString();
  }
}

class $ListingHealthMetricsTable extends ListingHealthMetrics
    with TableInfo<$ListingHealthMetricsTable, ListingHealthMetricsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListingHealthMetricsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
  static const VerificationMeta _totalOrdersMeta = const VerificationMeta(
    'totalOrders',
  );
  @override
  late final GeneratedColumn<int> totalOrders = GeneratedColumn<int>(
    'total_orders',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cancelledCountMeta = const VerificationMeta(
    'cancelledCount',
  );
  @override
  late final GeneratedColumn<int> cancelledCount = GeneratedColumn<int>(
    'cancelled_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lateCountMeta = const VerificationMeta(
    'lateCount',
  );
  @override
  late final GeneratedColumn<int> lateCount = GeneratedColumn<int>(
    'late_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnOrIncidentCountMeta =
      const VerificationMeta('returnOrIncidentCount');
  @override
  late final GeneratedColumn<int> returnOrIncidentCount = GeneratedColumn<int>(
    'return_or_incident_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastEvaluatedAtMeta = const VerificationMeta(
    'lastEvaluatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastEvaluatedAt =
      GeneratedColumn<DateTime>(
        'last_evaluated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    listingId,
    totalOrders,
    cancelledCount,
    lateCount,
    returnOrIncidentCount,
    lastEvaluatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'listing_health_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<ListingHealthMetricsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('listing_id')) {
      context.handle(
        _listingIdMeta,
        listingId.isAcceptableOrUnknown(data['listing_id']!, _listingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listingIdMeta);
    }
    if (data.containsKey('total_orders')) {
      context.handle(
        _totalOrdersMeta,
        totalOrders.isAcceptableOrUnknown(
          data['total_orders']!,
          _totalOrdersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalOrdersMeta);
    }
    if (data.containsKey('cancelled_count')) {
      context.handle(
        _cancelledCountMeta,
        cancelledCount.isAcceptableOrUnknown(
          data['cancelled_count']!,
          _cancelledCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cancelledCountMeta);
    }
    if (data.containsKey('late_count')) {
      context.handle(
        _lateCountMeta,
        lateCount.isAcceptableOrUnknown(data['late_count']!, _lateCountMeta),
      );
    } else if (isInserting) {
      context.missing(_lateCountMeta);
    }
    if (data.containsKey('return_or_incident_count')) {
      context.handle(
        _returnOrIncidentCountMeta,
        returnOrIncidentCount.isAcceptableOrUnknown(
          data['return_or_incident_count']!,
          _returnOrIncidentCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_returnOrIncidentCountMeta);
    }
    if (data.containsKey('last_evaluated_at')) {
      context.handle(
        _lastEvaluatedAtMeta,
        lastEvaluatedAt.isAcceptableOrUnknown(
          data['last_evaluated_at']!,
          _lastEvaluatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastEvaluatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ListingHealthMetricsRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListingHealthMetricsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      listingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listing_id'],
      )!,
      totalOrders: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_orders'],
      )!,
      cancelledCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cancelled_count'],
      )!,
      lateCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}late_count'],
      )!,
      returnOrIncidentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}return_or_incident_count'],
      )!,
      lastEvaluatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_evaluated_at'],
      )!,
    );
  }

  @override
  $ListingHealthMetricsTable createAlias(String alias) {
    return $ListingHealthMetricsTable(attachedDatabase, alias);
  }
}

class ListingHealthMetricsRow extends DataClass
    implements Insertable<ListingHealthMetricsRow> {
  final int id;
  final int tenantId;
  final String listingId;
  final int totalOrders;
  final int cancelledCount;
  final int lateCount;
  final int returnOrIncidentCount;
  final DateTime lastEvaluatedAt;
  const ListingHealthMetricsRow({
    required this.id,
    required this.tenantId,
    required this.listingId,
    required this.totalOrders,
    required this.cancelledCount,
    required this.lateCount,
    required this.returnOrIncidentCount,
    required this.lastEvaluatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['listing_id'] = Variable<String>(listingId);
    map['total_orders'] = Variable<int>(totalOrders);
    map['cancelled_count'] = Variable<int>(cancelledCount);
    map['late_count'] = Variable<int>(lateCount);
    map['return_or_incident_count'] = Variable<int>(returnOrIncidentCount);
    map['last_evaluated_at'] = Variable<DateTime>(lastEvaluatedAt);
    return map;
  }

  ListingHealthMetricsCompanion toCompanion(bool nullToAbsent) {
    return ListingHealthMetricsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      listingId: Value(listingId),
      totalOrders: Value(totalOrders),
      cancelledCount: Value(cancelledCount),
      lateCount: Value(lateCount),
      returnOrIncidentCount: Value(returnOrIncidentCount),
      lastEvaluatedAt: Value(lastEvaluatedAt),
    );
  }

  factory ListingHealthMetricsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListingHealthMetricsRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      listingId: serializer.fromJson<String>(json['listingId']),
      totalOrders: serializer.fromJson<int>(json['totalOrders']),
      cancelledCount: serializer.fromJson<int>(json['cancelledCount']),
      lateCount: serializer.fromJson<int>(json['lateCount']),
      returnOrIncidentCount: serializer.fromJson<int>(
        json['returnOrIncidentCount'],
      ),
      lastEvaluatedAt: serializer.fromJson<DateTime>(json['lastEvaluatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'listingId': serializer.toJson<String>(listingId),
      'totalOrders': serializer.toJson<int>(totalOrders),
      'cancelledCount': serializer.toJson<int>(cancelledCount),
      'lateCount': serializer.toJson<int>(lateCount),
      'returnOrIncidentCount': serializer.toJson<int>(returnOrIncidentCount),
      'lastEvaluatedAt': serializer.toJson<DateTime>(lastEvaluatedAt),
    };
  }

  ListingHealthMetricsRow copyWith({
    int? id,
    int? tenantId,
    String? listingId,
    int? totalOrders,
    int? cancelledCount,
    int? lateCount,
    int? returnOrIncidentCount,
    DateTime? lastEvaluatedAt,
  }) => ListingHealthMetricsRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    listingId: listingId ?? this.listingId,
    totalOrders: totalOrders ?? this.totalOrders,
    cancelledCount: cancelledCount ?? this.cancelledCount,
    lateCount: lateCount ?? this.lateCount,
    returnOrIncidentCount: returnOrIncidentCount ?? this.returnOrIncidentCount,
    lastEvaluatedAt: lastEvaluatedAt ?? this.lastEvaluatedAt,
  );
  ListingHealthMetricsRow copyWithCompanion(
    ListingHealthMetricsCompanion data,
  ) {
    return ListingHealthMetricsRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      listingId: data.listingId.present ? data.listingId.value : this.listingId,
      totalOrders: data.totalOrders.present
          ? data.totalOrders.value
          : this.totalOrders,
      cancelledCount: data.cancelledCount.present
          ? data.cancelledCount.value
          : this.cancelledCount,
      lateCount: data.lateCount.present ? data.lateCount.value : this.lateCount,
      returnOrIncidentCount: data.returnOrIncidentCount.present
          ? data.returnOrIncidentCount.value
          : this.returnOrIncidentCount,
      lastEvaluatedAt: data.lastEvaluatedAt.present
          ? data.lastEvaluatedAt.value
          : this.lastEvaluatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ListingHealthMetricsRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('listingId: $listingId, ')
          ..write('totalOrders: $totalOrders, ')
          ..write('cancelledCount: $cancelledCount, ')
          ..write('lateCount: $lateCount, ')
          ..write('returnOrIncidentCount: $returnOrIncidentCount, ')
          ..write('lastEvaluatedAt: $lastEvaluatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    listingId,
    totalOrders,
    cancelledCount,
    lateCount,
    returnOrIncidentCount,
    lastEvaluatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListingHealthMetricsRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.listingId == this.listingId &&
          other.totalOrders == this.totalOrders &&
          other.cancelledCount == this.cancelledCount &&
          other.lateCount == this.lateCount &&
          other.returnOrIncidentCount == this.returnOrIncidentCount &&
          other.lastEvaluatedAt == this.lastEvaluatedAt);
}

class ListingHealthMetricsCompanion
    extends UpdateCompanion<ListingHealthMetricsRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> listingId;
  final Value<int> totalOrders;
  final Value<int> cancelledCount;
  final Value<int> lateCount;
  final Value<int> returnOrIncidentCount;
  final Value<DateTime> lastEvaluatedAt;
  const ListingHealthMetricsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.listingId = const Value.absent(),
    this.totalOrders = const Value.absent(),
    this.cancelledCount = const Value.absent(),
    this.lateCount = const Value.absent(),
    this.returnOrIncidentCount = const Value.absent(),
    this.lastEvaluatedAt = const Value.absent(),
  });
  ListingHealthMetricsCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String listingId,
    required int totalOrders,
    required int cancelledCount,
    required int lateCount,
    required int returnOrIncidentCount,
    required DateTime lastEvaluatedAt,
  }) : listingId = Value(listingId),
       totalOrders = Value(totalOrders),
       cancelledCount = Value(cancelledCount),
       lateCount = Value(lateCount),
       returnOrIncidentCount = Value(returnOrIncidentCount),
       lastEvaluatedAt = Value(lastEvaluatedAt);
  static Insertable<ListingHealthMetricsRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? listingId,
    Expression<int>? totalOrders,
    Expression<int>? cancelledCount,
    Expression<int>? lateCount,
    Expression<int>? returnOrIncidentCount,
    Expression<DateTime>? lastEvaluatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (listingId != null) 'listing_id': listingId,
      if (totalOrders != null) 'total_orders': totalOrders,
      if (cancelledCount != null) 'cancelled_count': cancelledCount,
      if (lateCount != null) 'late_count': lateCount,
      if (returnOrIncidentCount != null)
        'return_or_incident_count': returnOrIncidentCount,
      if (lastEvaluatedAt != null) 'last_evaluated_at': lastEvaluatedAt,
    });
  }

  ListingHealthMetricsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? listingId,
    Value<int>? totalOrders,
    Value<int>? cancelledCount,
    Value<int>? lateCount,
    Value<int>? returnOrIncidentCount,
    Value<DateTime>? lastEvaluatedAt,
  }) {
    return ListingHealthMetricsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      listingId: listingId ?? this.listingId,
      totalOrders: totalOrders ?? this.totalOrders,
      cancelledCount: cancelledCount ?? this.cancelledCount,
      lateCount: lateCount ?? this.lateCount,
      returnOrIncidentCount:
          returnOrIncidentCount ?? this.returnOrIncidentCount,
      lastEvaluatedAt: lastEvaluatedAt ?? this.lastEvaluatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (listingId.present) {
      map['listing_id'] = Variable<String>(listingId.value);
    }
    if (totalOrders.present) {
      map['total_orders'] = Variable<int>(totalOrders.value);
    }
    if (cancelledCount.present) {
      map['cancelled_count'] = Variable<int>(cancelledCount.value);
    }
    if (lateCount.present) {
      map['late_count'] = Variable<int>(lateCount.value);
    }
    if (returnOrIncidentCount.present) {
      map['return_or_incident_count'] = Variable<int>(
        returnOrIncidentCount.value,
      );
    }
    if (lastEvaluatedAt.present) {
      map['last_evaluated_at'] = Variable<DateTime>(lastEvaluatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListingHealthMetricsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('listingId: $listingId, ')
          ..write('totalOrders: $totalOrders, ')
          ..write('cancelledCount: $cancelledCount, ')
          ..write('lateCount: $lateCount, ')
          ..write('returnOrIncidentCount: $returnOrIncidentCount, ')
          ..write('lastEvaluatedAt: $lastEvaluatedAt')
          ..write(')'))
        .toString();
  }
}

class $CustomerMetricsTable extends CustomerMetrics
    with TableInfo<$CustomerMetricsTable, CustomerMetricsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerMetricsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnRateMeta = const VerificationMeta(
    'returnRate',
  );
  @override
  late final GeneratedColumn<double> returnRate = GeneratedColumn<double>(
    'return_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _complaintRateMeta = const VerificationMeta(
    'complaintRate',
  );
  @override
  late final GeneratedColumn<double> complaintRate = GeneratedColumn<double>(
    'complaint_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refundRateMeta = const VerificationMeta(
    'refundRate',
  );
  @override
  late final GeneratedColumn<double> refundRate = GeneratedColumn<double>(
    'refund_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderCountMeta = const VerificationMeta(
    'orderCount',
  );
  @override
  late final GeneratedColumn<int> orderCount = GeneratedColumn<int>(
    'order_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _windowEndMeta = const VerificationMeta(
    'windowEnd',
  );
  @override
  late final GeneratedColumn<DateTime> windowEnd = GeneratedColumn<DateTime>(
    'window_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    customerId,
    returnRate,
    complaintRate,
    refundRate,
    orderCount,
    windowEnd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerMetricsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('return_rate')) {
      context.handle(
        _returnRateMeta,
        returnRate.isAcceptableOrUnknown(data['return_rate']!, _returnRateMeta),
      );
    } else if (isInserting) {
      context.missing(_returnRateMeta);
    }
    if (data.containsKey('complaint_rate')) {
      context.handle(
        _complaintRateMeta,
        complaintRate.isAcceptableOrUnknown(
          data['complaint_rate']!,
          _complaintRateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_complaintRateMeta);
    }
    if (data.containsKey('refund_rate')) {
      context.handle(
        _refundRateMeta,
        refundRate.isAcceptableOrUnknown(data['refund_rate']!, _refundRateMeta),
      );
    } else if (isInserting) {
      context.missing(_refundRateMeta);
    }
    if (data.containsKey('order_count')) {
      context.handle(
        _orderCountMeta,
        orderCount.isAcceptableOrUnknown(data['order_count']!, _orderCountMeta),
      );
    } else if (isInserting) {
      context.missing(_orderCountMeta);
    }
    if (data.containsKey('window_end')) {
      context.handle(
        _windowEndMeta,
        windowEnd.isAcceptableOrUnknown(data['window_end']!, _windowEndMeta),
      );
    } else if (isInserting) {
      context.missing(_windowEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerMetricsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerMetricsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      returnRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}return_rate'],
      )!,
      complaintRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}complaint_rate'],
      )!,
      refundRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_rate'],
      )!,
      orderCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_count'],
      )!,
      windowEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}window_end'],
      )!,
    );
  }

  @override
  $CustomerMetricsTable createAlias(String alias) {
    return $CustomerMetricsTable(attachedDatabase, alias);
  }
}

class CustomerMetricsRow extends DataClass
    implements Insertable<CustomerMetricsRow> {
  final int id;
  final int tenantId;
  final String customerId;
  final double returnRate;
  final double complaintRate;
  final double refundRate;
  final int orderCount;
  final DateTime windowEnd;
  const CustomerMetricsRow({
    required this.id,
    required this.tenantId,
    required this.customerId,
    required this.returnRate,
    required this.complaintRate,
    required this.refundRate,
    required this.orderCount,
    required this.windowEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['customer_id'] = Variable<String>(customerId);
    map['return_rate'] = Variable<double>(returnRate);
    map['complaint_rate'] = Variable<double>(complaintRate);
    map['refund_rate'] = Variable<double>(refundRate);
    map['order_count'] = Variable<int>(orderCount);
    map['window_end'] = Variable<DateTime>(windowEnd);
    return map;
  }

  CustomerMetricsCompanion toCompanion(bool nullToAbsent) {
    return CustomerMetricsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      customerId: Value(customerId),
      returnRate: Value(returnRate),
      complaintRate: Value(complaintRate),
      refundRate: Value(refundRate),
      orderCount: Value(orderCount),
      windowEnd: Value(windowEnd),
    );
  }

  factory CustomerMetricsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerMetricsRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      customerId: serializer.fromJson<String>(json['customerId']),
      returnRate: serializer.fromJson<double>(json['returnRate']),
      complaintRate: serializer.fromJson<double>(json['complaintRate']),
      refundRate: serializer.fromJson<double>(json['refundRate']),
      orderCount: serializer.fromJson<int>(json['orderCount']),
      windowEnd: serializer.fromJson<DateTime>(json['windowEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'customerId': serializer.toJson<String>(customerId),
      'returnRate': serializer.toJson<double>(returnRate),
      'complaintRate': serializer.toJson<double>(complaintRate),
      'refundRate': serializer.toJson<double>(refundRate),
      'orderCount': serializer.toJson<int>(orderCount),
      'windowEnd': serializer.toJson<DateTime>(windowEnd),
    };
  }

  CustomerMetricsRow copyWith({
    int? id,
    int? tenantId,
    String? customerId,
    double? returnRate,
    double? complaintRate,
    double? refundRate,
    int? orderCount,
    DateTime? windowEnd,
  }) => CustomerMetricsRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    customerId: customerId ?? this.customerId,
    returnRate: returnRate ?? this.returnRate,
    complaintRate: complaintRate ?? this.complaintRate,
    refundRate: refundRate ?? this.refundRate,
    orderCount: orderCount ?? this.orderCount,
    windowEnd: windowEnd ?? this.windowEnd,
  );
  CustomerMetricsRow copyWithCompanion(CustomerMetricsCompanion data) {
    return CustomerMetricsRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      returnRate: data.returnRate.present
          ? data.returnRate.value
          : this.returnRate,
      complaintRate: data.complaintRate.present
          ? data.complaintRate.value
          : this.complaintRate,
      refundRate: data.refundRate.present
          ? data.refundRate.value
          : this.refundRate,
      orderCount: data.orderCount.present
          ? data.orderCount.value
          : this.orderCount,
      windowEnd: data.windowEnd.present ? data.windowEnd.value : this.windowEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerMetricsRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('customerId: $customerId, ')
          ..write('returnRate: $returnRate, ')
          ..write('complaintRate: $complaintRate, ')
          ..write('refundRate: $refundRate, ')
          ..write('orderCount: $orderCount, ')
          ..write('windowEnd: $windowEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    customerId,
    returnRate,
    complaintRate,
    refundRate,
    orderCount,
    windowEnd,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerMetricsRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.customerId == this.customerId &&
          other.returnRate == this.returnRate &&
          other.complaintRate == this.complaintRate &&
          other.refundRate == this.refundRate &&
          other.orderCount == this.orderCount &&
          other.windowEnd == this.windowEnd);
}

class CustomerMetricsCompanion extends UpdateCompanion<CustomerMetricsRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> customerId;
  final Value<double> returnRate;
  final Value<double> complaintRate;
  final Value<double> refundRate;
  final Value<int> orderCount;
  final Value<DateTime> windowEnd;
  const CustomerMetricsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.returnRate = const Value.absent(),
    this.complaintRate = const Value.absent(),
    this.refundRate = const Value.absent(),
    this.orderCount = const Value.absent(),
    this.windowEnd = const Value.absent(),
  });
  CustomerMetricsCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String customerId,
    required double returnRate,
    required double complaintRate,
    required double refundRate,
    required int orderCount,
    required DateTime windowEnd,
  }) : customerId = Value(customerId),
       returnRate = Value(returnRate),
       complaintRate = Value(complaintRate),
       refundRate = Value(refundRate),
       orderCount = Value(orderCount),
       windowEnd = Value(windowEnd);
  static Insertable<CustomerMetricsRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? customerId,
    Expression<double>? returnRate,
    Expression<double>? complaintRate,
    Expression<double>? refundRate,
    Expression<int>? orderCount,
    Expression<DateTime>? windowEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (customerId != null) 'customer_id': customerId,
      if (returnRate != null) 'return_rate': returnRate,
      if (complaintRate != null) 'complaint_rate': complaintRate,
      if (refundRate != null) 'refund_rate': refundRate,
      if (orderCount != null) 'order_count': orderCount,
      if (windowEnd != null) 'window_end': windowEnd,
    });
  }

  CustomerMetricsCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? customerId,
    Value<double>? returnRate,
    Value<double>? complaintRate,
    Value<double>? refundRate,
    Value<int>? orderCount,
    Value<DateTime>? windowEnd,
  }) {
    return CustomerMetricsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      customerId: customerId ?? this.customerId,
      returnRate: returnRate ?? this.returnRate,
      complaintRate: complaintRate ?? this.complaintRate,
      refundRate: refundRate ?? this.refundRate,
      orderCount: orderCount ?? this.orderCount,
      windowEnd: windowEnd ?? this.windowEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (returnRate.present) {
      map['return_rate'] = Variable<double>(returnRate.value);
    }
    if (complaintRate.present) {
      map['complaint_rate'] = Variable<double>(complaintRate.value);
    }
    if (refundRate.present) {
      map['refund_rate'] = Variable<double>(refundRate.value);
    }
    if (orderCount.present) {
      map['order_count'] = Variable<int>(orderCount.value);
    }
    if (windowEnd.present) {
      map['window_end'] = Variable<DateTime>(windowEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerMetricsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('customerId: $customerId, ')
          ..write('returnRate: $returnRate, ')
          ..write('complaintRate: $complaintRate, ')
          ..write('refundRate: $refundRate, ')
          ..write('orderCount: $orderCount, ')
          ..write('windowEnd: $windowEnd')
          ..write(')'))
        .toString();
  }
}

class $StockStateTable extends StockState
    with TableInfo<$StockStateTable, StockStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockStateTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<int> tenantId = GeneratedColumn<int>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplierStockMeta = const VerificationMeta(
    'supplierStock',
  );
  @override
  late final GeneratedColumn<int> supplierStock = GeneratedColumn<int>(
    'supplier_stock',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnedStockMeta = const VerificationMeta(
    'returnedStock',
  );
  @override
  late final GeneratedColumn<int> returnedStock = GeneratedColumn<int>(
    'returned_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reservedStockMeta = const VerificationMeta(
    'reservedStock',
  );
  @override
  late final GeneratedColumn<int> reservedStock = GeneratedColumn<int>(
    'reserved_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _availableStockMeta = const VerificationMeta(
    'availableStock',
  );
  @override
  late final GeneratedColumn<int> availableStock = GeneratedColumn<int>(
    'available_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUpdatedAtMeta = const VerificationMeta(
    'lastUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    productId,
    supplierId,
    supplierStock,
    returnedStock,
    reservedStock,
    availableStock,
    lastUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_state';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
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
    }
    if (data.containsKey('supplier_stock')) {
      context.handle(
        _supplierStockMeta,
        supplierStock.isAcceptableOrUnknown(
          data['supplier_stock']!,
          _supplierStockMeta,
        ),
      );
    }
    if (data.containsKey('returned_stock')) {
      context.handle(
        _returnedStockMeta,
        returnedStock.isAcceptableOrUnknown(
          data['returned_stock']!,
          _returnedStockMeta,
        ),
      );
    }
    if (data.containsKey('reserved_stock')) {
      context.handle(
        _reservedStockMeta,
        reservedStock.isAcceptableOrUnknown(
          data['reserved_stock']!,
          _reservedStockMeta,
        ),
      );
    }
    if (data.containsKey('available_stock')) {
      context.handle(
        _availableStockMeta,
        availableStock.isAcceptableOrUnknown(
          data['available_stock']!,
          _availableStockMeta,
        ),
      );
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
        _lastUpdatedAtMeta,
        lastUpdatedAt.isAcceptableOrUnknown(
          data['last_updated_at']!,
          _lastUpdatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockStateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tenant_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      ),
      supplierStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_stock'],
      ),
      returnedStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}returned_stock'],
      )!,
      reservedStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reserved_stock'],
      )!,
      availableStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}available_stock'],
      )!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_at'],
      )!,
    );
  }

  @override
  $StockStateTable createAlias(String alias) {
    return $StockStateTable(attachedDatabase, alias);
  }
}

class StockStateRow extends DataClass implements Insertable<StockStateRow> {
  final int id;
  final int tenantId;
  final String productId;
  final String? supplierId;
  final int? supplierStock;
  final int returnedStock;
  final int reservedStock;
  final int availableStock;
  final DateTime lastUpdatedAt;
  const StockStateRow({
    required this.id,
    required this.tenantId,
    required this.productId,
    this.supplierId,
    this.supplierStock,
    required this.returnedStock,
    required this.reservedStock,
    required this.availableStock,
    required this.lastUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenant_id'] = Variable<int>(tenantId);
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    if (!nullToAbsent || supplierStock != null) {
      map['supplier_stock'] = Variable<int>(supplierStock);
    }
    map['returned_stock'] = Variable<int>(returnedStock);
    map['reserved_stock'] = Variable<int>(reservedStock);
    map['available_stock'] = Variable<int>(availableStock);
    map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    return map;
  }

  StockStateCompanion toCompanion(bool nullToAbsent) {
    return StockStateCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      productId: Value(productId),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      supplierStock: supplierStock == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierStock),
      returnedStock: Value(returnedStock),
      reservedStock: Value(reservedStock),
      availableStock: Value(availableStock),
      lastUpdatedAt: Value(lastUpdatedAt),
    );
  }

  factory StockStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockStateRow(
      id: serializer.fromJson<int>(json['id']),
      tenantId: serializer.fromJson<int>(json['tenantId']),
      productId: serializer.fromJson<String>(json['productId']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      supplierStock: serializer.fromJson<int?>(json['supplierStock']),
      returnedStock: serializer.fromJson<int>(json['returnedStock']),
      reservedStock: serializer.fromJson<int>(json['reservedStock']),
      availableStock: serializer.fromJson<int>(json['availableStock']),
      lastUpdatedAt: serializer.fromJson<DateTime>(json['lastUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantId': serializer.toJson<int>(tenantId),
      'productId': serializer.toJson<String>(productId),
      'supplierId': serializer.toJson<String?>(supplierId),
      'supplierStock': serializer.toJson<int?>(supplierStock),
      'returnedStock': serializer.toJson<int>(returnedStock),
      'reservedStock': serializer.toJson<int>(reservedStock),
      'availableStock': serializer.toJson<int>(availableStock),
      'lastUpdatedAt': serializer.toJson<DateTime>(lastUpdatedAt),
    };
  }

  StockStateRow copyWith({
    int? id,
    int? tenantId,
    String? productId,
    Value<String?> supplierId = const Value.absent(),
    Value<int?> supplierStock = const Value.absent(),
    int? returnedStock,
    int? reservedStock,
    int? availableStock,
    DateTime? lastUpdatedAt,
  }) => StockStateRow(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    productId: productId ?? this.productId,
    supplierId: supplierId.present ? supplierId.value : this.supplierId,
    supplierStock: supplierStock.present
        ? supplierStock.value
        : this.supplierStock,
    returnedStock: returnedStock ?? this.returnedStock,
    reservedStock: reservedStock ?? this.reservedStock,
    availableStock: availableStock ?? this.availableStock,
    lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
  );
  StockStateRow copyWithCompanion(StockStateCompanion data) {
    return StockStateRow(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      productId: data.productId.present ? data.productId.value : this.productId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      supplierStock: data.supplierStock.present
          ? data.supplierStock.value
          : this.supplierStock,
      returnedStock: data.returnedStock.present
          ? data.returnedStock.value
          : this.returnedStock,
      reservedStock: data.reservedStock.present
          ? data.reservedStock.value
          : this.reservedStock,
      availableStock: data.availableStock.present
          ? data.availableStock.value
          : this.availableStock,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockStateRow(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierStock: $supplierStock, ')
          ..write('returnedStock: $returnedStock, ')
          ..write('reservedStock: $reservedStock, ')
          ..write('availableStock: $availableStock, ')
          ..write('lastUpdatedAt: $lastUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    productId,
    supplierId,
    supplierStock,
    returnedStock,
    reservedStock,
    availableStock,
    lastUpdatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockStateRow &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.productId == this.productId &&
          other.supplierId == this.supplierId &&
          other.supplierStock == this.supplierStock &&
          other.returnedStock == this.returnedStock &&
          other.reservedStock == this.reservedStock &&
          other.availableStock == this.availableStock &&
          other.lastUpdatedAt == this.lastUpdatedAt);
}

class StockStateCompanion extends UpdateCompanion<StockStateRow> {
  final Value<int> id;
  final Value<int> tenantId;
  final Value<String> productId;
  final Value<String?> supplierId;
  final Value<int?> supplierStock;
  final Value<int> returnedStock;
  final Value<int> reservedStock;
  final Value<int> availableStock;
  final Value<DateTime> lastUpdatedAt;
  const StockStateCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.productId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.supplierStock = const Value.absent(),
    this.returnedStock = const Value.absent(),
    this.reservedStock = const Value.absent(),
    this.availableStock = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
  });
  StockStateCompanion.insert({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    required String productId,
    this.supplierId = const Value.absent(),
    this.supplierStock = const Value.absent(),
    this.returnedStock = const Value.absent(),
    this.reservedStock = const Value.absent(),
    this.availableStock = const Value.absent(),
    required DateTime lastUpdatedAt,
  }) : productId = Value(productId),
       lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<StockStateRow> custom({
    Expression<int>? id,
    Expression<int>? tenantId,
    Expression<String>? productId,
    Expression<String>? supplierId,
    Expression<int>? supplierStock,
    Expression<int>? returnedStock,
    Expression<int>? reservedStock,
    Expression<int>? availableStock,
    Expression<DateTime>? lastUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (productId != null) 'product_id': productId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (supplierStock != null) 'supplier_stock': supplierStock,
      if (returnedStock != null) 'returned_stock': returnedStock,
      if (reservedStock != null) 'reserved_stock': reservedStock,
      if (availableStock != null) 'available_stock': availableStock,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
    });
  }

  StockStateCompanion copyWith({
    Value<int>? id,
    Value<int>? tenantId,
    Value<String>? productId,
    Value<String?>? supplierId,
    Value<int?>? supplierStock,
    Value<int>? returnedStock,
    Value<int>? reservedStock,
    Value<int>? availableStock,
    Value<DateTime>? lastUpdatedAt,
  }) {
    return StockStateCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      productId: productId ?? this.productId,
      supplierId: supplierId ?? this.supplierId,
      supplierStock: supplierStock ?? this.supplierStock,
      returnedStock: returnedStock ?? this.returnedStock,
      reservedStock: reservedStock ?? this.reservedStock,
      availableStock: availableStock ?? this.availableStock,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<int>(tenantId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (supplierStock.present) {
      map['supplier_stock'] = Variable<int>(supplierStock.value);
    }
    if (returnedStock.present) {
      map['returned_stock'] = Variable<int>(returnedStock.value);
    }
    if (reservedStock.present) {
      map['reserved_stock'] = Variable<int>(reservedStock.value);
    }
    if (availableStock.present) {
      map['available_stock'] = Variable<int>(availableStock.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockStateCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('productId: $productId, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierStock: $supplierStock, ')
          ..write('returnedStock: $returnedStock, ')
          ..write('reservedStock: $reservedStock, ')
          ..write('availableStock: $availableStock, ')
          ..write('lastUpdatedAt: $lastUpdatedAt')
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
  late final $MarketplaceAccountsTable marketplaceAccounts =
      $MarketplaceAccountsTable(this);
  late final $MessageThreadsTable messageThreads = $MessageThreadsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $ReturnsTable returns = $ReturnsTable(this);
  late final $SupplierReturnPoliciesTable supplierReturnPolicies =
      $SupplierReturnPoliciesTable(this);
  late final $IncidentRecordsTable incidentRecords = $IncidentRecordsTable(
    this,
  );
  late final $ReturnedStocksTable returnedStocks = $ReturnedStocksTable(this);
  late final $FinancialLedgerTable financialLedger = $FinancialLedgerTable(
    this,
  );
  late final $FeatureFlagsTable featureFlags = $FeatureFlagsTable(this);
  late final $BackgroundJobsTable backgroundJobs = $BackgroundJobsTable(this);
  late final $DistributedLocksTable distributedLocks = $DistributedLocksTable(
    this,
  );
  late final $BillingPlansTable billingPlans = $BillingPlansTable(this);
  late final $TenantPlansTable tenantPlans = $TenantPlansTable(this);
  late final $SupplierReliabilityScoresTable supplierReliabilityScores =
      $SupplierReliabilityScoresTable(this);
  late final $ListingHealthMetricsTable listingHealthMetrics =
      $ListingHealthMetricsTable(this);
  late final $CustomerMetricsTable customerMetrics = $CustomerMetricsTable(
    this,
  );
  late final $StockStateTable stockState = $StockStateTable(this);
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
    marketplaceAccounts,
    messageThreads,
    messages,
    returns,
    supplierReturnPolicies,
    incidentRecords,
    returnedStocks,
    financialLedger,
    featureFlags,
    backgroundJobs,
    distributedLocks,
    billingPlans,
    tenantPlans,
    supplierReliabilityScores,
    listingHealthMetrics,
    customerMetrics,
    stockState,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
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
      Value<int> tenantId,
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

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
                Value<int> tenantId = const Value.absent(),
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
                tenantId: tenantId,
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
                Value<int> tenantId = const Value.absent(),
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
                tenantId: tenantId,
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
      Value<int> tenantId,
      required String localId,
      required String productId,
      required String targetPlatformId,
      Value<String?> targetListingId,
      required String status,
      required double sellingPrice,
      required double sourceCost,
      Value<String?> decisionLogId,
      Value<String?> marketplaceAccountId,
      Value<int?> promisedMinDays,
      Value<int?> promisedMaxDays,
      required DateTime createdAt,
      Value<DateTime?> publishedAt,
      Value<String?> variantId,
    });
typedef $$ListingsTableUpdateCompanionBuilder =
    ListingsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> localId,
      Value<String> productId,
      Value<String> targetPlatformId,
      Value<String?> targetListingId,
      Value<String> status,
      Value<double> sellingPrice,
      Value<double> sourceCost,
      Value<String?> decisionLogId,
      Value<String?> marketplaceAccountId,
      Value<int?> promisedMinDays,
      Value<int?> promisedMaxDays,
      Value<DateTime> createdAt,
      Value<DateTime?> publishedAt,
      Value<String?> variantId,
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnFilters<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get promisedMinDays => $composableBuilder(
    column: $table.promisedMinDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get promisedMaxDays => $composableBuilder(
    column: $table.promisedMaxDays,
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

  ColumnFilters<String> get variantId => $composableBuilder(
    column: $table.variantId,
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get promisedMinDays => $composableBuilder(
    column: $table.promisedMinDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get promisedMaxDays => $composableBuilder(
    column: $table.promisedMaxDays,
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

  ColumnOrderings<String> get variantId => $composableBuilder(
    column: $table.variantId,
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

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

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

  GeneratedColumn<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get promisedMinDays => $composableBuilder(
    column: $table.promisedMinDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get promisedMaxDays => $composableBuilder(
    column: $table.promisedMaxDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);
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
                Value<int> tenantId = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> targetPlatformId = const Value.absent(),
                Value<String?> targetListingId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<double> sourceCost = const Value.absent(),
                Value<String?> decisionLogId = const Value.absent(),
                Value<String?> marketplaceAccountId = const Value.absent(),
                Value<int?> promisedMinDays = const Value.absent(),
                Value<int?> promisedMaxDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<String?> variantId = const Value.absent(),
              }) => ListingsCompanion(
                id: id,
                tenantId: tenantId,
                localId: localId,
                productId: productId,
                targetPlatformId: targetPlatformId,
                targetListingId: targetListingId,
                status: status,
                sellingPrice: sellingPrice,
                sourceCost: sourceCost,
                decisionLogId: decisionLogId,
                marketplaceAccountId: marketplaceAccountId,
                promisedMinDays: promisedMinDays,
                promisedMaxDays: promisedMaxDays,
                createdAt: createdAt,
                publishedAt: publishedAt,
                variantId: variantId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String localId,
                required String productId,
                required String targetPlatformId,
                Value<String?> targetListingId = const Value.absent(),
                required String status,
                required double sellingPrice,
                required double sourceCost,
                Value<String?> decisionLogId = const Value.absent(),
                Value<String?> marketplaceAccountId = const Value.absent(),
                Value<int?> promisedMinDays = const Value.absent(),
                Value<int?> promisedMaxDays = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> publishedAt = const Value.absent(),
                Value<String?> variantId = const Value.absent(),
              }) => ListingsCompanion.insert(
                id: id,
                tenantId: tenantId,
                localId: localId,
                productId: productId,
                targetPlatformId: targetPlatformId,
                targetListingId: targetListingId,
                status: status,
                sellingPrice: sellingPrice,
                sourceCost: sourceCost,
                decisionLogId: decisionLogId,
                marketplaceAccountId: marketplaceAccountId,
                promisedMinDays: promisedMinDays,
                promisedMaxDays: promisedMaxDays,
                createdAt: createdAt,
                publishedAt: publishedAt,
                variantId: variantId,
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
      Value<int> tenantId,
      required String localId,
      required String listingId,
      required String targetOrderId,
      required String targetPlatformId,
      required String customerAddressJson,
      required String status,
      Value<String?> sourceOrderId,
      required double sourceCost,
      required double sellingPrice,
      Value<int> quantity,
      Value<String?> trackingNumber,
      Value<String?> decisionLogId,
      Value<String?> marketplaceAccountId,
      Value<DateTime?> promisedDeliveryMin,
      Value<DateTime?> promisedDeliveryMax,
      Value<DateTime?> deliveredAt,
      Value<DateTime?> approvedAt,
      required DateTime createdAt,
      Value<String?> lifecycleState,
      Value<String?> financialState,
      Value<bool> queuedForCapital,
      Value<double?> riskScore,
      Value<String?> riskFactorsJson,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> localId,
      Value<String> listingId,
      Value<String> targetOrderId,
      Value<String> targetPlatformId,
      Value<String> customerAddressJson,
      Value<String> status,
      Value<String?> sourceOrderId,
      Value<double> sourceCost,
      Value<double> sellingPrice,
      Value<int> quantity,
      Value<String?> trackingNumber,
      Value<String?> decisionLogId,
      Value<String?> marketplaceAccountId,
      Value<DateTime?> promisedDeliveryMin,
      Value<DateTime?> promisedDeliveryMax,
      Value<DateTime?> deliveredAt,
      Value<DateTime?> approvedAt,
      Value<DateTime> createdAt,
      Value<String?> lifecycleState,
      Value<String?> financialState,
      Value<bool> queuedForCapital,
      Value<double?> riskScore,
      Value<String?> riskFactorsJson,
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
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

  ColumnFilters<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get promisedDeliveryMin => $composableBuilder(
    column: $table.promisedDeliveryMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get promisedDeliveryMax => $composableBuilder(
    column: $table.promisedDeliveryMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
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

  ColumnFilters<String> get lifecycleState => $composableBuilder(
    column: $table.lifecycleState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get financialState => $composableBuilder(
    column: $table.financialState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get queuedForCapital => $composableBuilder(
    column: $table.queuedForCapital,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskFactorsJson => $composableBuilder(
    column: $table.riskFactorsJson,
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
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

  ColumnOrderings<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get promisedDeliveryMin => $composableBuilder(
    column: $table.promisedDeliveryMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get promisedDeliveryMax => $composableBuilder(
    column: $table.promisedDeliveryMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
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

  ColumnOrderings<String> get lifecycleState => $composableBuilder(
    column: $table.lifecycleState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get financialState => $composableBuilder(
    column: $table.financialState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get queuedForCapital => $composableBuilder(
    column: $table.queuedForCapital,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskFactorsJson => $composableBuilder(
    column: $table.riskFactorsJson,
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

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

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

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get trackingNumber => $composableBuilder(
    column: $table.trackingNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decisionLogId => $composableBuilder(
    column: $table.decisionLogId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get promisedDeliveryMin => $composableBuilder(
    column: $table.promisedDeliveryMin,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get promisedDeliveryMax => $composableBuilder(
    column: $table.promisedDeliveryMax,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deliveredAt => $composableBuilder(
    column: $table.deliveredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
    column: $table.approvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get lifecycleState => $composableBuilder(
    column: $table.lifecycleState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get financialState => $composableBuilder(
    column: $table.financialState,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get queuedForCapital => $composableBuilder(
    column: $table.queuedForCapital,
    builder: (column) => column,
  );

  GeneratedColumn<double> get riskScore =>
      $composableBuilder(column: $table.riskScore, builder: (column) => column);

  GeneratedColumn<String> get riskFactorsJson => $composableBuilder(
    column: $table.riskFactorsJson,
    builder: (column) => column,
  );
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
                Value<int> tenantId = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> listingId = const Value.absent(),
                Value<String> targetOrderId = const Value.absent(),
                Value<String> targetPlatformId = const Value.absent(),
                Value<String> customerAddressJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> sourceOrderId = const Value.absent(),
                Value<double> sourceCost = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> trackingNumber = const Value.absent(),
                Value<String?> decisionLogId = const Value.absent(),
                Value<String?> marketplaceAccountId = const Value.absent(),
                Value<DateTime?> promisedDeliveryMin = const Value.absent(),
                Value<DateTime?> promisedDeliveryMax = const Value.absent(),
                Value<DateTime?> deliveredAt = const Value.absent(),
                Value<DateTime?> approvedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> lifecycleState = const Value.absent(),
                Value<String?> financialState = const Value.absent(),
                Value<bool> queuedForCapital = const Value.absent(),
                Value<double?> riskScore = const Value.absent(),
                Value<String?> riskFactorsJson = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                tenantId: tenantId,
                localId: localId,
                listingId: listingId,
                targetOrderId: targetOrderId,
                targetPlatformId: targetPlatformId,
                customerAddressJson: customerAddressJson,
                status: status,
                sourceOrderId: sourceOrderId,
                sourceCost: sourceCost,
                sellingPrice: sellingPrice,
                quantity: quantity,
                trackingNumber: trackingNumber,
                decisionLogId: decisionLogId,
                marketplaceAccountId: marketplaceAccountId,
                promisedDeliveryMin: promisedDeliveryMin,
                promisedDeliveryMax: promisedDeliveryMax,
                deliveredAt: deliveredAt,
                approvedAt: approvedAt,
                createdAt: createdAt,
                lifecycleState: lifecycleState,
                financialState: financialState,
                queuedForCapital: queuedForCapital,
                riskScore: riskScore,
                riskFactorsJson: riskFactorsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String localId,
                required String listingId,
                required String targetOrderId,
                required String targetPlatformId,
                required String customerAddressJson,
                required String status,
                Value<String?> sourceOrderId = const Value.absent(),
                required double sourceCost,
                required double sellingPrice,
                Value<int> quantity = const Value.absent(),
                Value<String?> trackingNumber = const Value.absent(),
                Value<String?> decisionLogId = const Value.absent(),
                Value<String?> marketplaceAccountId = const Value.absent(),
                Value<DateTime?> promisedDeliveryMin = const Value.absent(),
                Value<DateTime?> promisedDeliveryMax = const Value.absent(),
                Value<DateTime?> deliveredAt = const Value.absent(),
                Value<DateTime?> approvedAt = const Value.absent(),
                required DateTime createdAt,
                Value<String?> lifecycleState = const Value.absent(),
                Value<String?> financialState = const Value.absent(),
                Value<bool> queuedForCapital = const Value.absent(),
                Value<double?> riskScore = const Value.absent(),
                Value<String?> riskFactorsJson = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                tenantId: tenantId,
                localId: localId,
                listingId: listingId,
                targetOrderId: targetOrderId,
                targetPlatformId: targetPlatformId,
                customerAddressJson: customerAddressJson,
                status: status,
                sourceOrderId: sourceOrderId,
                sourceCost: sourceCost,
                sellingPrice: sellingPrice,
                quantity: quantity,
                trackingNumber: trackingNumber,
                decisionLogId: decisionLogId,
                marketplaceAccountId: marketplaceAccountId,
                promisedDeliveryMin: promisedDeliveryMin,
                promisedDeliveryMax: promisedDeliveryMax,
                deliveredAt: deliveredAt,
                approvedAt: approvedAt,
                createdAt: createdAt,
                lifecycleState: lifecycleState,
                financialState: financialState,
                queuedForCapital: queuedForCapital,
                riskScore: riskScore,
                riskFactorsJson: riskFactorsJson,
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
      Value<int> tenantId,
      required String localId,
      required String type,
      required String entityId,
      required String reason,
      Value<String?> criteriaSnapshot,
      required DateTime createdAt,
      Value<String?> incidentType,
      Value<double?> financialImpact,
    });
typedef $$DecisionLogsTableUpdateCompanionBuilder =
    DecisionLogsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> localId,
      Value<String> type,
      Value<String> entityId,
      Value<String> reason,
      Value<String?> criteriaSnapshot,
      Value<DateTime> createdAt,
      Value<String?> incidentType,
      Value<double?> financialImpact,
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnFilters<String> get incidentType => $composableBuilder(
    column: $table.incidentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get financialImpact => $composableBuilder(
    column: $table.financialImpact,
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<String> get incidentType => $composableBuilder(
    column: $table.incidentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get financialImpact => $composableBuilder(
    column: $table.financialImpact,
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

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

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

  GeneratedColumn<String> get incidentType => $composableBuilder(
    column: $table.incidentType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get financialImpact => $composableBuilder(
    column: $table.financialImpact,
    builder: (column) => column,
  );
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
                Value<int> tenantId = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String?> criteriaSnapshot = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> incidentType = const Value.absent(),
                Value<double?> financialImpact = const Value.absent(),
              }) => DecisionLogsCompanion(
                id: id,
                tenantId: tenantId,
                localId: localId,
                type: type,
                entityId: entityId,
                reason: reason,
                criteriaSnapshot: criteriaSnapshot,
                createdAt: createdAt,
                incidentType: incidentType,
                financialImpact: financialImpact,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String localId,
                required String type,
                required String entityId,
                required String reason,
                Value<String?> criteriaSnapshot = const Value.absent(),
                required DateTime createdAt,
                Value<String?> incidentType = const Value.absent(),
                Value<double?> financialImpact = const Value.absent(),
              }) => DecisionLogsCompanion.insert(
                id: id,
                tenantId: tenantId,
                localId: localId,
                type: type,
                entityId: entityId,
                reason: reason,
                criteriaSnapshot: criteriaSnapshot,
                createdAt: createdAt,
                incidentType: incidentType,
                financialImpact: financialImpact,
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
      Value<int> tenantId,
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
      Value<String> marketplaceFeesJson,
      Value<String> paymentFeesJson,
      Value<String?> sellerReturnAddressJson,
      Value<String> marketplaceReturnPolicyJson,
      Value<bool> targetsReadOnly,
      Value<String> pricingStrategy,
      Value<String> categoryMinProfitPercentJson,
      Value<double> premiumWhenBetterReviewsPercent,
      Value<int> minSalesCountForPremium,
      Value<bool> kpiDrivenStrategyEnabled,
      Value<String> rateLimitMaxRequestsPerSecondJson,
      Value<String?> incidentRulesJson,
      Value<double?> riskScoreThreshold,
      Value<double?> defaultReturnRatePercent,
      Value<double?> defaultReturnCostPerUnit,
      Value<bool> blockFulfillWhenInsufficientStock,
      Value<bool> autoPauseListingWhenMarginBelowThreshold,
      Value<int> defaultSupplierProcessingDays,
      Value<int> defaultSupplierShippingDays,
      Value<int?> marketplaceMaxDeliveryDays,
      Value<double?> listingHealthMaxReturnRatePercent,
      Value<double?> listingHealthMaxLateRatePercent,
      Value<bool> autoPauseListingWhenHealthPoor,
      Value<int> safetyStockBuffer,
      Value<double?> customerAbuseMaxReturnRatePercent,
      Value<double?> customerAbuseMaxComplaintRatePercent,
      Value<String> priceRefreshIntervalMinutesBySourceJson,
    });
typedef $$UserRulesTableTableUpdateCompanionBuilder =
    UserRulesTableCompanion Function({
      Value<int> id,
      Value<int> tenantId,
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
      Value<String> marketplaceFeesJson,
      Value<String> paymentFeesJson,
      Value<String?> sellerReturnAddressJson,
      Value<String> marketplaceReturnPolicyJson,
      Value<bool> targetsReadOnly,
      Value<String> pricingStrategy,
      Value<String> categoryMinProfitPercentJson,
      Value<double> premiumWhenBetterReviewsPercent,
      Value<int> minSalesCountForPremium,
      Value<bool> kpiDrivenStrategyEnabled,
      Value<String> rateLimitMaxRequestsPerSecondJson,
      Value<String?> incidentRulesJson,
      Value<double?> riskScoreThreshold,
      Value<double?> defaultReturnRatePercent,
      Value<double?> defaultReturnCostPerUnit,
      Value<bool> blockFulfillWhenInsufficientStock,
      Value<bool> autoPauseListingWhenMarginBelowThreshold,
      Value<int> defaultSupplierProcessingDays,
      Value<int> defaultSupplierShippingDays,
      Value<int?> marketplaceMaxDeliveryDays,
      Value<double?> listingHealthMaxReturnRatePercent,
      Value<double?> listingHealthMaxLateRatePercent,
      Value<bool> autoPauseListingWhenHealthPoor,
      Value<int> safetyStockBuffer,
      Value<double?> customerAbuseMaxReturnRatePercent,
      Value<double?> customerAbuseMaxComplaintRatePercent,
      Value<String> priceRefreshIntervalMinutesBySourceJson,
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnFilters<String> get marketplaceFeesJson => $composableBuilder(
    column: $table.marketplaceFeesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentFeesJson => $composableBuilder(
    column: $table.paymentFeesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sellerReturnAddressJson => $composableBuilder(
    column: $table.sellerReturnAddressJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marketplaceReturnPolicyJson => $composableBuilder(
    column: $table.marketplaceReturnPolicyJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get targetsReadOnly => $composableBuilder(
    column: $table.targetsReadOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pricingStrategy => $composableBuilder(
    column: $table.pricingStrategy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryMinProfitPercentJson => $composableBuilder(
    column: $table.categoryMinProfitPercentJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get premiumWhenBetterReviewsPercent =>
      $composableBuilder(
        column: $table.premiumWhenBetterReviewsPercent,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get minSalesCountForPremium => $composableBuilder(
    column: $table.minSalesCountForPremium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get kpiDrivenStrategyEnabled => $composableBuilder(
    column: $table.kpiDrivenStrategyEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rateLimitMaxRequestsPerSecondJson =>
      $composableBuilder(
        column: $table.rateLimitMaxRequestsPerSecondJson,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get incidentRulesJson => $composableBuilder(
    column: $table.incidentRulesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get riskScoreThreshold => $composableBuilder(
    column: $table.riskScoreThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultReturnRatePercent => $composableBuilder(
    column: $table.defaultReturnRatePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultReturnCostPerUnit => $composableBuilder(
    column: $table.defaultReturnCostPerUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get blockFulfillWhenInsufficientStock =>
      $composableBuilder(
        column: $table.blockFulfillWhenInsufficientStock,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get autoPauseListingWhenMarginBelowThreshold =>
      $composableBuilder(
        column: $table.autoPauseListingWhenMarginBelowThreshold,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<int> get defaultSupplierProcessingDays => $composableBuilder(
    column: $table.defaultSupplierProcessingDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultSupplierShippingDays => $composableBuilder(
    column: $table.defaultSupplierShippingDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get marketplaceMaxDeliveryDays => $composableBuilder(
    column: $table.marketplaceMaxDeliveryDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get listingHealthMaxReturnRatePercent =>
      $composableBuilder(
        column: $table.listingHealthMaxReturnRatePercent,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<double> get listingHealthMaxLateRatePercent =>
      $composableBuilder(
        column: $table.listingHealthMaxLateRatePercent,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get autoPauseListingWhenHealthPoor => $composableBuilder(
    column: $table.autoPauseListingWhenHealthPoor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get safetyStockBuffer => $composableBuilder(
    column: $table.safetyStockBuffer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get customerAbuseMaxReturnRatePercent =>
      $composableBuilder(
        column: $table.customerAbuseMaxReturnRatePercent,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<double> get customerAbuseMaxComplaintRatePercent =>
      $composableBuilder(
        column: $table.customerAbuseMaxComplaintRatePercent,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get priceRefreshIntervalMinutesBySourceJson =>
      $composableBuilder(
        column: $table.priceRefreshIntervalMinutesBySourceJson,
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<String> get marketplaceFeesJson => $composableBuilder(
    column: $table.marketplaceFeesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentFeesJson => $composableBuilder(
    column: $table.paymentFeesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sellerReturnAddressJson => $composableBuilder(
    column: $table.sellerReturnAddressJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marketplaceReturnPolicyJson => $composableBuilder(
    column: $table.marketplaceReturnPolicyJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get targetsReadOnly => $composableBuilder(
    column: $table.targetsReadOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pricingStrategy => $composableBuilder(
    column: $table.pricingStrategy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryMinProfitPercentJson =>
      $composableBuilder(
        column: $table.categoryMinProfitPercentJson,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<double> get premiumWhenBetterReviewsPercent =>
      $composableBuilder(
        column: $table.premiumWhenBetterReviewsPercent,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get minSalesCountForPremium => $composableBuilder(
    column: $table.minSalesCountForPremium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get kpiDrivenStrategyEnabled => $composableBuilder(
    column: $table.kpiDrivenStrategyEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rateLimitMaxRequestsPerSecondJson =>
      $composableBuilder(
        column: $table.rateLimitMaxRequestsPerSecondJson,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get incidentRulesJson => $composableBuilder(
    column: $table.incidentRulesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get riskScoreThreshold => $composableBuilder(
    column: $table.riskScoreThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultReturnRatePercent => $composableBuilder(
    column: $table.defaultReturnRatePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultReturnCostPerUnit => $composableBuilder(
    column: $table.defaultReturnCostPerUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get blockFulfillWhenInsufficientStock =>
      $composableBuilder(
        column: $table.blockFulfillWhenInsufficientStock,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get autoPauseListingWhenMarginBelowThreshold =>
      $composableBuilder(
        column: $table.autoPauseListingWhenMarginBelowThreshold,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get defaultSupplierProcessingDays => $composableBuilder(
    column: $table.defaultSupplierProcessingDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultSupplierShippingDays => $composableBuilder(
    column: $table.defaultSupplierShippingDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get marketplaceMaxDeliveryDays => $composableBuilder(
    column: $table.marketplaceMaxDeliveryDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get listingHealthMaxReturnRatePercent =>
      $composableBuilder(
        column: $table.listingHealthMaxReturnRatePercent,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<double> get listingHealthMaxLateRatePercent =>
      $composableBuilder(
        column: $table.listingHealthMaxLateRatePercent,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get autoPauseListingWhenHealthPoor =>
      $composableBuilder(
        column: $table.autoPauseListingWhenHealthPoor,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<int> get safetyStockBuffer => $composableBuilder(
    column: $table.safetyStockBuffer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get customerAbuseMaxReturnRatePercent =>
      $composableBuilder(
        column: $table.customerAbuseMaxReturnRatePercent,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<double> get customerAbuseMaxComplaintRatePercent =>
      $composableBuilder(
        column: $table.customerAbuseMaxComplaintRatePercent,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get priceRefreshIntervalMinutesBySourceJson =>
      $composableBuilder(
        column: $table.priceRefreshIntervalMinutesBySourceJson,
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

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

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

  GeneratedColumn<String> get marketplaceFeesJson => $composableBuilder(
    column: $table.marketplaceFeesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentFeesJson => $composableBuilder(
    column: $table.paymentFeesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sellerReturnAddressJson => $composableBuilder(
    column: $table.sellerReturnAddressJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marketplaceReturnPolicyJson => $composableBuilder(
    column: $table.marketplaceReturnPolicyJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get targetsReadOnly => $composableBuilder(
    column: $table.targetsReadOnly,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pricingStrategy => $composableBuilder(
    column: $table.pricingStrategy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryMinProfitPercentJson =>
      $composableBuilder(
        column: $table.categoryMinProfitPercentJson,
        builder: (column) => column,
      );

  GeneratedColumn<double> get premiumWhenBetterReviewsPercent =>
      $composableBuilder(
        column: $table.premiumWhenBetterReviewsPercent,
        builder: (column) => column,
      );

  GeneratedColumn<int> get minSalesCountForPremium => $composableBuilder(
    column: $table.minSalesCountForPremium,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get kpiDrivenStrategyEnabled => $composableBuilder(
    column: $table.kpiDrivenStrategyEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rateLimitMaxRequestsPerSecondJson =>
      $composableBuilder(
        column: $table.rateLimitMaxRequestsPerSecondJson,
        builder: (column) => column,
      );

  GeneratedColumn<String> get incidentRulesJson => $composableBuilder(
    column: $table.incidentRulesJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get riskScoreThreshold => $composableBuilder(
    column: $table.riskScoreThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultReturnRatePercent => $composableBuilder(
    column: $table.defaultReturnRatePercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultReturnCostPerUnit => $composableBuilder(
    column: $table.defaultReturnCostPerUnit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get blockFulfillWhenInsufficientStock =>
      $composableBuilder(
        column: $table.blockFulfillWhenInsufficientStock,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get autoPauseListingWhenMarginBelowThreshold =>
      $composableBuilder(
        column: $table.autoPauseListingWhenMarginBelowThreshold,
        builder: (column) => column,
      );

  GeneratedColumn<int> get defaultSupplierProcessingDays => $composableBuilder(
    column: $table.defaultSupplierProcessingDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultSupplierShippingDays => $composableBuilder(
    column: $table.defaultSupplierShippingDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get marketplaceMaxDeliveryDays => $composableBuilder(
    column: $table.marketplaceMaxDeliveryDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get listingHealthMaxReturnRatePercent =>
      $composableBuilder(
        column: $table.listingHealthMaxReturnRatePercent,
        builder: (column) => column,
      );

  GeneratedColumn<double> get listingHealthMaxLateRatePercent =>
      $composableBuilder(
        column: $table.listingHealthMaxLateRatePercent,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get autoPauseListingWhenHealthPoor =>
      $composableBuilder(
        column: $table.autoPauseListingWhenHealthPoor,
        builder: (column) => column,
      );

  GeneratedColumn<int> get safetyStockBuffer => $composableBuilder(
    column: $table.safetyStockBuffer,
    builder: (column) => column,
  );

  GeneratedColumn<double> get customerAbuseMaxReturnRatePercent =>
      $composableBuilder(
        column: $table.customerAbuseMaxReturnRatePercent,
        builder: (column) => column,
      );

  GeneratedColumn<double> get customerAbuseMaxComplaintRatePercent =>
      $composableBuilder(
        column: $table.customerAbuseMaxComplaintRatePercent,
        builder: (column) => column,
      );

  GeneratedColumn<String> get priceRefreshIntervalMinutesBySourceJson =>
      $composableBuilder(
        column: $table.priceRefreshIntervalMinutesBySourceJson,
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
                Value<int> tenantId = const Value.absent(),
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
                Value<String> marketplaceFeesJson = const Value.absent(),
                Value<String> paymentFeesJson = const Value.absent(),
                Value<String?> sellerReturnAddressJson = const Value.absent(),
                Value<String> marketplaceReturnPolicyJson =
                    const Value.absent(),
                Value<bool> targetsReadOnly = const Value.absent(),
                Value<String> pricingStrategy = const Value.absent(),
                Value<String> categoryMinProfitPercentJson =
                    const Value.absent(),
                Value<double> premiumWhenBetterReviewsPercent =
                    const Value.absent(),
                Value<int> minSalesCountForPremium = const Value.absent(),
                Value<bool> kpiDrivenStrategyEnabled = const Value.absent(),
                Value<String> rateLimitMaxRequestsPerSecondJson =
                    const Value.absent(),
                Value<String?> incidentRulesJson = const Value.absent(),
                Value<double?> riskScoreThreshold = const Value.absent(),
                Value<double?> defaultReturnRatePercent = const Value.absent(),
                Value<double?> defaultReturnCostPerUnit = const Value.absent(),
                Value<bool> blockFulfillWhenInsufficientStock =
                    const Value.absent(),
                Value<bool> autoPauseListingWhenMarginBelowThreshold =
                    const Value.absent(),
                Value<int> defaultSupplierProcessingDays = const Value.absent(),
                Value<int> defaultSupplierShippingDays = const Value.absent(),
                Value<int?> marketplaceMaxDeliveryDays = const Value.absent(),
                Value<double?> listingHealthMaxReturnRatePercent =
                    const Value.absent(),
                Value<double?> listingHealthMaxLateRatePercent =
                    const Value.absent(),
                Value<bool> autoPauseListingWhenHealthPoor =
                    const Value.absent(),
                Value<int> safetyStockBuffer = const Value.absent(),
                Value<double?> customerAbuseMaxReturnRatePercent =
                    const Value.absent(),
                Value<double?> customerAbuseMaxComplaintRatePercent =
                    const Value.absent(),
                Value<String> priceRefreshIntervalMinutesBySourceJson =
                    const Value.absent(),
              }) => UserRulesTableCompanion(
                id: id,
                tenantId: tenantId,
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
                marketplaceFeesJson: marketplaceFeesJson,
                paymentFeesJson: paymentFeesJson,
                sellerReturnAddressJson: sellerReturnAddressJson,
                marketplaceReturnPolicyJson: marketplaceReturnPolicyJson,
                targetsReadOnly: targetsReadOnly,
                pricingStrategy: pricingStrategy,
                categoryMinProfitPercentJson: categoryMinProfitPercentJson,
                premiumWhenBetterReviewsPercent:
                    premiumWhenBetterReviewsPercent,
                minSalesCountForPremium: minSalesCountForPremium,
                kpiDrivenStrategyEnabled: kpiDrivenStrategyEnabled,
                rateLimitMaxRequestsPerSecondJson:
                    rateLimitMaxRequestsPerSecondJson,
                incidentRulesJson: incidentRulesJson,
                riskScoreThreshold: riskScoreThreshold,
                defaultReturnRatePercent: defaultReturnRatePercent,
                defaultReturnCostPerUnit: defaultReturnCostPerUnit,
                blockFulfillWhenInsufficientStock:
                    blockFulfillWhenInsufficientStock,
                autoPauseListingWhenMarginBelowThreshold:
                    autoPauseListingWhenMarginBelowThreshold,
                defaultSupplierProcessingDays: defaultSupplierProcessingDays,
                defaultSupplierShippingDays: defaultSupplierShippingDays,
                marketplaceMaxDeliveryDays: marketplaceMaxDeliveryDays,
                listingHealthMaxReturnRatePercent:
                    listingHealthMaxReturnRatePercent,
                listingHealthMaxLateRatePercent:
                    listingHealthMaxLateRatePercent,
                autoPauseListingWhenHealthPoor: autoPauseListingWhenHealthPoor,
                safetyStockBuffer: safetyStockBuffer,
                customerAbuseMaxReturnRatePercent:
                    customerAbuseMaxReturnRatePercent,
                customerAbuseMaxComplaintRatePercent:
                    customerAbuseMaxComplaintRatePercent,
                priceRefreshIntervalMinutesBySourceJson:
                    priceRefreshIntervalMinutesBySourceJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
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
                Value<String> marketplaceFeesJson = const Value.absent(),
                Value<String> paymentFeesJson = const Value.absent(),
                Value<String?> sellerReturnAddressJson = const Value.absent(),
                Value<String> marketplaceReturnPolicyJson =
                    const Value.absent(),
                Value<bool> targetsReadOnly = const Value.absent(),
                Value<String> pricingStrategy = const Value.absent(),
                Value<String> categoryMinProfitPercentJson =
                    const Value.absent(),
                Value<double> premiumWhenBetterReviewsPercent =
                    const Value.absent(),
                Value<int> minSalesCountForPremium = const Value.absent(),
                Value<bool> kpiDrivenStrategyEnabled = const Value.absent(),
                Value<String> rateLimitMaxRequestsPerSecondJson =
                    const Value.absent(),
                Value<String?> incidentRulesJson = const Value.absent(),
                Value<double?> riskScoreThreshold = const Value.absent(),
                Value<double?> defaultReturnRatePercent = const Value.absent(),
                Value<double?> defaultReturnCostPerUnit = const Value.absent(),
                Value<bool> blockFulfillWhenInsufficientStock =
                    const Value.absent(),
                Value<bool> autoPauseListingWhenMarginBelowThreshold =
                    const Value.absent(),
                Value<int> defaultSupplierProcessingDays = const Value.absent(),
                Value<int> defaultSupplierShippingDays = const Value.absent(),
                Value<int?> marketplaceMaxDeliveryDays = const Value.absent(),
                Value<double?> listingHealthMaxReturnRatePercent =
                    const Value.absent(),
                Value<double?> listingHealthMaxLateRatePercent =
                    const Value.absent(),
                Value<bool> autoPauseListingWhenHealthPoor =
                    const Value.absent(),
                Value<int> safetyStockBuffer = const Value.absent(),
                Value<double?> customerAbuseMaxReturnRatePercent =
                    const Value.absent(),
                Value<double?> customerAbuseMaxComplaintRatePercent =
                    const Value.absent(),
                Value<String> priceRefreshIntervalMinutesBySourceJson =
                    const Value.absent(),
              }) => UserRulesTableCompanion.insert(
                id: id,
                tenantId: tenantId,
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
                marketplaceFeesJson: marketplaceFeesJson,
                paymentFeesJson: paymentFeesJson,
                sellerReturnAddressJson: sellerReturnAddressJson,
                marketplaceReturnPolicyJson: marketplaceReturnPolicyJson,
                targetsReadOnly: targetsReadOnly,
                pricingStrategy: pricingStrategy,
                categoryMinProfitPercentJson: categoryMinProfitPercentJson,
                premiumWhenBetterReviewsPercent:
                    premiumWhenBetterReviewsPercent,
                minSalesCountForPremium: minSalesCountForPremium,
                kpiDrivenStrategyEnabled: kpiDrivenStrategyEnabled,
                rateLimitMaxRequestsPerSecondJson:
                    rateLimitMaxRequestsPerSecondJson,
                incidentRulesJson: incidentRulesJson,
                riskScoreThreshold: riskScoreThreshold,
                defaultReturnRatePercent: defaultReturnRatePercent,
                defaultReturnCostPerUnit: defaultReturnCostPerUnit,
                blockFulfillWhenInsufficientStock:
                    blockFulfillWhenInsufficientStock,
                autoPauseListingWhenMarginBelowThreshold:
                    autoPauseListingWhenMarginBelowThreshold,
                defaultSupplierProcessingDays: defaultSupplierProcessingDays,
                defaultSupplierShippingDays: defaultSupplierShippingDays,
                marketplaceMaxDeliveryDays: marketplaceMaxDeliveryDays,
                listingHealthMaxReturnRatePercent:
                    listingHealthMaxReturnRatePercent,
                listingHealthMaxLateRatePercent:
                    listingHealthMaxLateRatePercent,
                autoPauseListingWhenHealthPoor: autoPauseListingWhenHealthPoor,
                safetyStockBuffer: safetyStockBuffer,
                customerAbuseMaxReturnRatePercent:
                    customerAbuseMaxReturnRatePercent,
                customerAbuseMaxComplaintRatePercent:
                    customerAbuseMaxComplaintRatePercent,
                priceRefreshIntervalMinutesBySourceJson:
                    priceRefreshIntervalMinutesBySourceJson,
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
      Value<int> tenantId,
      required String supplierId,
      required String name,
      required String platformType,
      Value<String?> countryCode,
      Value<double?> rating,
      Value<int?> returnWindowDays,
      Value<double?> returnShippingCost,
      Value<double?> restockingFeePercent,
      Value<bool> acceptsNoReasonReturns,
      Value<String?> warehouseAddress,
      Value<String?> warehouseCity,
      Value<String?> warehouseZip,
      Value<String?> warehouseCountry,
      Value<String?> warehousePhone,
      Value<String?> warehouseEmail,
      Value<String?> feedSource,
      Value<String?> shopUrl,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> supplierId,
      Value<String> name,
      Value<String> platformType,
      Value<String?> countryCode,
      Value<double?> rating,
      Value<int?> returnWindowDays,
      Value<double?> returnShippingCost,
      Value<double?> restockingFeePercent,
      Value<bool> acceptsNoReasonReturns,
      Value<String?> warehouseAddress,
      Value<String?> warehouseCity,
      Value<String?> warehouseZip,
      Value<String?> warehouseCountry,
      Value<String?> warehousePhone,
      Value<String?> warehouseEmail,
      Value<String?> feedSource,
      Value<String?> shopUrl,
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnFilters<String> get warehouseAddress => $composableBuilder(
    column: $table.warehouseAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseCity => $composableBuilder(
    column: $table.warehouseCity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseZip => $composableBuilder(
    column: $table.warehouseZip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseCountry => $composableBuilder(
    column: $table.warehouseCountry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehousePhone => $composableBuilder(
    column: $table.warehousePhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseEmail => $composableBuilder(
    column: $table.warehouseEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedSource => $composableBuilder(
    column: $table.feedSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopUrl => $composableBuilder(
    column: $table.shopUrl,
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<String> get warehouseAddress => $composableBuilder(
    column: $table.warehouseAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseCity => $composableBuilder(
    column: $table.warehouseCity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseZip => $composableBuilder(
    column: $table.warehouseZip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseCountry => $composableBuilder(
    column: $table.warehouseCountry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehousePhone => $composableBuilder(
    column: $table.warehousePhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseEmail => $composableBuilder(
    column: $table.warehouseEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedSource => $composableBuilder(
    column: $table.feedSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopUrl => $composableBuilder(
    column: $table.shopUrl,
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

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

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

  GeneratedColumn<String> get warehouseAddress => $composableBuilder(
    column: $table.warehouseAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warehouseCity => $composableBuilder(
    column: $table.warehouseCity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warehouseZip => $composableBuilder(
    column: $table.warehouseZip,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warehouseCountry => $composableBuilder(
    column: $table.warehouseCountry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warehousePhone => $composableBuilder(
    column: $table.warehousePhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warehouseEmail => $composableBuilder(
    column: $table.warehouseEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get feedSource => $composableBuilder(
    column: $table.feedSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shopUrl =>
      $composableBuilder(column: $table.shopUrl, builder: (column) => column);
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
                Value<int> tenantId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> platformType = const Value.absent(),
                Value<String?> countryCode = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<int?> returnWindowDays = const Value.absent(),
                Value<double?> returnShippingCost = const Value.absent(),
                Value<double?> restockingFeePercent = const Value.absent(),
                Value<bool> acceptsNoReasonReturns = const Value.absent(),
                Value<String?> warehouseAddress = const Value.absent(),
                Value<String?> warehouseCity = const Value.absent(),
                Value<String?> warehouseZip = const Value.absent(),
                Value<String?> warehouseCountry = const Value.absent(),
                Value<String?> warehousePhone = const Value.absent(),
                Value<String?> warehouseEmail = const Value.absent(),
                Value<String?> feedSource = const Value.absent(),
                Value<String?> shopUrl = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                tenantId: tenantId,
                supplierId: supplierId,
                name: name,
                platformType: platformType,
                countryCode: countryCode,
                rating: rating,
                returnWindowDays: returnWindowDays,
                returnShippingCost: returnShippingCost,
                restockingFeePercent: restockingFeePercent,
                acceptsNoReasonReturns: acceptsNoReasonReturns,
                warehouseAddress: warehouseAddress,
                warehouseCity: warehouseCity,
                warehouseZip: warehouseZip,
                warehouseCountry: warehouseCountry,
                warehousePhone: warehousePhone,
                warehouseEmail: warehouseEmail,
                feedSource: feedSource,
                shopUrl: shopUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String supplierId,
                required String name,
                required String platformType,
                Value<String?> countryCode = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<int?> returnWindowDays = const Value.absent(),
                Value<double?> returnShippingCost = const Value.absent(),
                Value<double?> restockingFeePercent = const Value.absent(),
                Value<bool> acceptsNoReasonReturns = const Value.absent(),
                Value<String?> warehouseAddress = const Value.absent(),
                Value<String?> warehouseCity = const Value.absent(),
                Value<String?> warehouseZip = const Value.absent(),
                Value<String?> warehouseCountry = const Value.absent(),
                Value<String?> warehousePhone = const Value.absent(),
                Value<String?> warehouseEmail = const Value.absent(),
                Value<String?> feedSource = const Value.absent(),
                Value<String?> shopUrl = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                tenantId: tenantId,
                supplierId: supplierId,
                name: name,
                platformType: platformType,
                countryCode: countryCode,
                rating: rating,
                returnWindowDays: returnWindowDays,
                returnShippingCost: returnShippingCost,
                restockingFeePercent: restockingFeePercent,
                acceptsNoReasonReturns: acceptsNoReasonReturns,
                warehouseAddress: warehouseAddress,
                warehouseCity: warehouseCity,
                warehouseZip: warehouseZip,
                warehouseCountry: warehouseCountry,
                warehousePhone: warehousePhone,
                warehouseEmail: warehouseEmail,
                feedSource: feedSource,
                shopUrl: shopUrl,
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
      Value<int> tenantId,
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
      Value<int> tenantId,
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

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
                Value<int> tenantId = const Value.absent(),
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
                tenantId: tenantId,
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
                Value<int> tenantId = const Value.absent(),
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
                tenantId: tenantId,
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
typedef $$MarketplaceAccountsTableCreateCompanionBuilder =
    MarketplaceAccountsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String accountId,
      required String platformId,
      required String displayName,
      Value<bool> isActive,
      Value<DateTime?> connectedAt,
    });
typedef $$MarketplaceAccountsTableUpdateCompanionBuilder =
    MarketplaceAccountsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> accountId,
      Value<String> platformId,
      Value<String> displayName,
      Value<bool> isActive,
      Value<DateTime?> connectedAt,
    });

class $$MarketplaceAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $MarketplaceAccountsTable> {
  $$MarketplaceAccountsTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platformId => $composableBuilder(
    column: $table.platformId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MarketplaceAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $MarketplaceAccountsTable> {
  $$MarketplaceAccountsTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platformId => $composableBuilder(
    column: $table.platformId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MarketplaceAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MarketplaceAccountsTable> {
  $$MarketplaceAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get platformId => $composableBuilder(
    column: $table.platformId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => column,
  );
}

class $$MarketplaceAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MarketplaceAccountsTable,
          MarketplaceAccountRow,
          $$MarketplaceAccountsTableFilterComposer,
          $$MarketplaceAccountsTableOrderingComposer,
          $$MarketplaceAccountsTableAnnotationComposer,
          $$MarketplaceAccountsTableCreateCompanionBuilder,
          $$MarketplaceAccountsTableUpdateCompanionBuilder,
          (
            MarketplaceAccountRow,
            BaseReferences<
              _$AppDatabase,
              $MarketplaceAccountsTable,
              MarketplaceAccountRow
            >,
          ),
          MarketplaceAccountRow,
          PrefetchHooks Function()
        > {
  $$MarketplaceAccountsTableTableManager(
    _$AppDatabase db,
    $MarketplaceAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MarketplaceAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MarketplaceAccountsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MarketplaceAccountsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> platformId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> connectedAt = const Value.absent(),
              }) => MarketplaceAccountsCompanion(
                id: id,
                tenantId: tenantId,
                accountId: accountId,
                platformId: platformId,
                displayName: displayName,
                isActive: isActive,
                connectedAt: connectedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String accountId,
                required String platformId,
                required String displayName,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> connectedAt = const Value.absent(),
              }) => MarketplaceAccountsCompanion.insert(
                id: id,
                tenantId: tenantId,
                accountId: accountId,
                platformId: platformId,
                displayName: displayName,
                isActive: isActive,
                connectedAt: connectedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MarketplaceAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MarketplaceAccountsTable,
      MarketplaceAccountRow,
      $$MarketplaceAccountsTableFilterComposer,
      $$MarketplaceAccountsTableOrderingComposer,
      $$MarketplaceAccountsTableAnnotationComposer,
      $$MarketplaceAccountsTableCreateCompanionBuilder,
      $$MarketplaceAccountsTableUpdateCompanionBuilder,
      (
        MarketplaceAccountRow,
        BaseReferences<
          _$AppDatabase,
          $MarketplaceAccountsTable,
          MarketplaceAccountRow
        >,
      ),
      MarketplaceAccountRow,
      PrefetchHooks Function()
    >;
typedef $$MessageThreadsTableCreateCompanionBuilder =
    MessageThreadsCompanion Function({
      Value<int> id,
      required String localId,
      required String orderId,
      required String targetPlatformId,
      Value<String?> marketplaceAccountId,
      Value<String?> externalThreadId,
      required String status,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      required DateTime createdAt,
    });
typedef $$MessageThreadsTableUpdateCompanionBuilder =
    MessageThreadsCompanion Function({
      Value<int> id,
      Value<String> localId,
      Value<String> orderId,
      Value<String> targetPlatformId,
      Value<String?> marketplaceAccountId,
      Value<String?> externalThreadId,
      Value<String> status,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      Value<DateTime> createdAt,
    });

class $$MessageThreadsTableFilterComposer
    extends Composer<_$AppDatabase, $MessageThreadsTable> {
  $$MessageThreadsTableFilterComposer({
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

  ColumnFilters<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalThreadId => $composableBuilder(
    column: $table.externalThreadId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessageThreadsTableOrderingComposer
    extends Composer<_$AppDatabase, $MessageThreadsTable> {
  $$MessageThreadsTableOrderingComposer({
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

  ColumnOrderings<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalThreadId => $composableBuilder(
    column: $table.externalThreadId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessageThreadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessageThreadsTable> {
  $$MessageThreadsTableAnnotationComposer({
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

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marketplaceAccountId => $composableBuilder(
    column: $table.marketplaceAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalThreadId => $composableBuilder(
    column: $table.externalThreadId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MessageThreadsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessageThreadsTable,
          MessageThreadRow,
          $$MessageThreadsTableFilterComposer,
          $$MessageThreadsTableOrderingComposer,
          $$MessageThreadsTableAnnotationComposer,
          $$MessageThreadsTableCreateCompanionBuilder,
          $$MessageThreadsTableUpdateCompanionBuilder,
          (
            MessageThreadRow,
            BaseReferences<
              _$AppDatabase,
              $MessageThreadsTable,
              MessageThreadRow
            >,
          ),
          MessageThreadRow,
          PrefetchHooks Function()
        > {
  $$MessageThreadsTableTableManager(
    _$AppDatabase db,
    $MessageThreadsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageThreadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageThreadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageThreadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> targetPlatformId = const Value.absent(),
                Value<String?> marketplaceAccountId = const Value.absent(),
                Value<String?> externalThreadId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MessageThreadsCompanion(
                id: id,
                localId: localId,
                orderId: orderId,
                targetPlatformId: targetPlatformId,
                marketplaceAccountId: marketplaceAccountId,
                externalThreadId: externalThreadId,
                status: status,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String localId,
                required String orderId,
                required String targetPlatformId,
                Value<String?> marketplaceAccountId = const Value.absent(),
                Value<String?> externalThreadId = const Value.absent(),
                required String status,
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                required DateTime createdAt,
              }) => MessageThreadsCompanion.insert(
                id: id,
                localId: localId,
                orderId: orderId,
                targetPlatformId: targetPlatformId,
                marketplaceAccountId: marketplaceAccountId,
                externalThreadId: externalThreadId,
                status: status,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessageThreadsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessageThreadsTable,
      MessageThreadRow,
      $$MessageThreadsTableFilterComposer,
      $$MessageThreadsTableOrderingComposer,
      $$MessageThreadsTableAnnotationComposer,
      $$MessageThreadsTableCreateCompanionBuilder,
      $$MessageThreadsTableUpdateCompanionBuilder,
      (
        MessageThreadRow,
        BaseReferences<_$AppDatabase, $MessageThreadsTable, MessageThreadRow>,
      ),
      MessageThreadRow,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      required String threadLocalId,
      required String direction,
      Value<String?> authorLabel,
      required String body,
      required DateTime createdAt,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> id,
      Value<String> threadLocalId,
      Value<String> direction,
      Value<String?> authorLabel,
      Value<String> body,
      Value<DateTime> createdAt,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
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

  ColumnFilters<String> get threadLocalId => $composableBuilder(
    column: $table.threadLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorLabel => $composableBuilder(
    column: $table.authorLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
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

  ColumnOrderings<String> get threadLocalId => $composableBuilder(
    column: $table.threadLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorLabel => $composableBuilder(
    column: $table.authorLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get threadLocalId => $composableBuilder(
    column: $table.threadLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get authorLabel => $composableBuilder(
    column: $table.authorLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          MessageRow,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (
            MessageRow,
            BaseReferences<_$AppDatabase, $MessagesTable, MessageRow>,
          ),
          MessageRow,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> threadLocalId = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String?> authorLabel = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                threadLocalId: threadLocalId,
                direction: direction,
                authorLabel: authorLabel,
                body: body,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String threadLocalId,
                required String direction,
                Value<String?> authorLabel = const Value.absent(),
                required String body,
                required DateTime createdAt,
              }) => MessagesCompanion.insert(
                id: id,
                threadLocalId: threadLocalId,
                direction: direction,
                authorLabel: authorLabel,
                body: body,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      MessageRow,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (MessageRow, BaseReferences<_$AppDatabase, $MessagesTable, MessageRow>),
      MessageRow,
      PrefetchHooks Function()
    >;
typedef $$ReturnsTableCreateCompanionBuilder =
    ReturnsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String returnId,
      required String orderId,
      required String reason,
      required String status,
      Value<String?> notes,
      Value<double?> refundAmount,
      Value<double?> returnShippingCost,
      Value<double?> restockingFee,
      Value<DateTime?> requestedAt,
      Value<DateTime?> resolvedAt,
      Value<String?> returnToAddress,
      Value<String?> returnToCity,
      Value<String?> returnToCountry,
      Value<String?> returnTrackingNumber,
      Value<String?> returnCarrier,
      Value<String?> supplierId,
      Value<String?> productId,
      Value<String?> sourcePlatformId,
      Value<String?> targetPlatformId,
      Value<String?> returnDestination,
      Value<String?> returnRoutingDestination,
    });
typedef $$ReturnsTableUpdateCompanionBuilder =
    ReturnsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> returnId,
      Value<String> orderId,
      Value<String> reason,
      Value<String> status,
      Value<String?> notes,
      Value<double?> refundAmount,
      Value<double?> returnShippingCost,
      Value<double?> restockingFee,
      Value<DateTime?> requestedAt,
      Value<DateTime?> resolvedAt,
      Value<String?> returnToAddress,
      Value<String?> returnToCity,
      Value<String?> returnToCountry,
      Value<String?> returnTrackingNumber,
      Value<String?> returnCarrier,
      Value<String?> supplierId,
      Value<String?> productId,
      Value<String?> sourcePlatformId,
      Value<String?> targetPlatformId,
      Value<String?> returnDestination,
      Value<String?> returnRoutingDestination,
    });

class $$ReturnsTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnId => $composableBuilder(
    column: $table.returnId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get returnShippingCost => $composableBuilder(
    column: $table.returnShippingCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get restockingFee => $composableBuilder(
    column: $table.restockingFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnToAddress => $composableBuilder(
    column: $table.returnToAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnToCity => $composableBuilder(
    column: $table.returnToCity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnToCountry => $composableBuilder(
    column: $table.returnToCountry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnTrackingNumber => $composableBuilder(
    column: $table.returnTrackingNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnCarrier => $composableBuilder(
    column: $table.returnCarrier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnDestination => $composableBuilder(
    column: $table.returnDestination,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnRoutingDestination => $composableBuilder(
    column: $table.returnRoutingDestination,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnId => $composableBuilder(
    column: $table.returnId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get returnShippingCost => $composableBuilder(
    column: $table.returnShippingCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get restockingFee => $composableBuilder(
    column: $table.restockingFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnToAddress => $composableBuilder(
    column: $table.returnToAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnToCity => $composableBuilder(
    column: $table.returnToCity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnToCountry => $composableBuilder(
    column: $table.returnToCountry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnTrackingNumber => $composableBuilder(
    column: $table.returnTrackingNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnCarrier => $composableBuilder(
    column: $table.returnCarrier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnDestination => $composableBuilder(
    column: $table.returnDestination,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnRoutingDestination => $composableBuilder(
    column: $table.returnRoutingDestination,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnsTable> {
  $$ReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get returnId =>
      $composableBuilder(column: $table.returnId, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get returnShippingCost => $composableBuilder(
    column: $table.returnShippingCost,
    builder: (column) => column,
  );

  GeneratedColumn<double> get restockingFee => $composableBuilder(
    column: $table.restockingFee,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnToAddress => $composableBuilder(
    column: $table.returnToAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnToCity => $composableBuilder(
    column: $table.returnToCity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnToCountry => $composableBuilder(
    column: $table.returnToCountry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnTrackingNumber => $composableBuilder(
    column: $table.returnTrackingNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnCarrier => $composableBuilder(
    column: $table.returnCarrier,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get sourcePlatformId => $composableBuilder(
    column: $table.sourcePlatformId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetPlatformId => $composableBuilder(
    column: $table.targetPlatformId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnDestination => $composableBuilder(
    column: $table.returnDestination,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnRoutingDestination => $composableBuilder(
    column: $table.returnRoutingDestination,
    builder: (column) => column,
  );
}

class $$ReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnsTable,
          ReturnRow,
          $$ReturnsTableFilterComposer,
          $$ReturnsTableOrderingComposer,
          $$ReturnsTableAnnotationComposer,
          $$ReturnsTableCreateCompanionBuilder,
          $$ReturnsTableUpdateCompanionBuilder,
          (ReturnRow, BaseReferences<_$AppDatabase, $ReturnsTable, ReturnRow>),
          ReturnRow,
          PrefetchHooks Function()
        > {
  $$ReturnsTableTableManager(_$AppDatabase db, $ReturnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> returnId = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> refundAmount = const Value.absent(),
                Value<double?> returnShippingCost = const Value.absent(),
                Value<double?> restockingFee = const Value.absent(),
                Value<DateTime?> requestedAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<String?> returnToAddress = const Value.absent(),
                Value<String?> returnToCity = const Value.absent(),
                Value<String?> returnToCountry = const Value.absent(),
                Value<String?> returnTrackingNumber = const Value.absent(),
                Value<String?> returnCarrier = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String?> sourcePlatformId = const Value.absent(),
                Value<String?> targetPlatformId = const Value.absent(),
                Value<String?> returnDestination = const Value.absent(),
                Value<String?> returnRoutingDestination = const Value.absent(),
              }) => ReturnsCompanion(
                id: id,
                tenantId: tenantId,
                returnId: returnId,
                orderId: orderId,
                reason: reason,
                status: status,
                notes: notes,
                refundAmount: refundAmount,
                returnShippingCost: returnShippingCost,
                restockingFee: restockingFee,
                requestedAt: requestedAt,
                resolvedAt: resolvedAt,
                returnToAddress: returnToAddress,
                returnToCity: returnToCity,
                returnToCountry: returnToCountry,
                returnTrackingNumber: returnTrackingNumber,
                returnCarrier: returnCarrier,
                supplierId: supplierId,
                productId: productId,
                sourcePlatformId: sourcePlatformId,
                targetPlatformId: targetPlatformId,
                returnDestination: returnDestination,
                returnRoutingDestination: returnRoutingDestination,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String returnId,
                required String orderId,
                required String reason,
                required String status,
                Value<String?> notes = const Value.absent(),
                Value<double?> refundAmount = const Value.absent(),
                Value<double?> returnShippingCost = const Value.absent(),
                Value<double?> restockingFee = const Value.absent(),
                Value<DateTime?> requestedAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<String?> returnToAddress = const Value.absent(),
                Value<String?> returnToCity = const Value.absent(),
                Value<String?> returnToCountry = const Value.absent(),
                Value<String?> returnTrackingNumber = const Value.absent(),
                Value<String?> returnCarrier = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String?> sourcePlatformId = const Value.absent(),
                Value<String?> targetPlatformId = const Value.absent(),
                Value<String?> returnDestination = const Value.absent(),
                Value<String?> returnRoutingDestination = const Value.absent(),
              }) => ReturnsCompanion.insert(
                id: id,
                tenantId: tenantId,
                returnId: returnId,
                orderId: orderId,
                reason: reason,
                status: status,
                notes: notes,
                refundAmount: refundAmount,
                returnShippingCost: returnShippingCost,
                restockingFee: restockingFee,
                requestedAt: requestedAt,
                resolvedAt: resolvedAt,
                returnToAddress: returnToAddress,
                returnToCity: returnToCity,
                returnToCountry: returnToCountry,
                returnTrackingNumber: returnTrackingNumber,
                returnCarrier: returnCarrier,
                supplierId: supplierId,
                productId: productId,
                sourcePlatformId: sourcePlatformId,
                targetPlatformId: targetPlatformId,
                returnDestination: returnDestination,
                returnRoutingDestination: returnRoutingDestination,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnsTable,
      ReturnRow,
      $$ReturnsTableFilterComposer,
      $$ReturnsTableOrderingComposer,
      $$ReturnsTableAnnotationComposer,
      $$ReturnsTableCreateCompanionBuilder,
      $$ReturnsTableUpdateCompanionBuilder,
      (ReturnRow, BaseReferences<_$AppDatabase, $ReturnsTable, ReturnRow>),
      ReturnRow,
      PrefetchHooks Function()
    >;
typedef $$SupplierReturnPoliciesTableCreateCompanionBuilder =
    SupplierReturnPoliciesCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String supplierId,
      required String policyType,
      Value<int?> returnWindowDays,
      Value<double?> restockingFeePercent,
      Value<String?> returnShippingPaidBy,
      Value<bool> requiresRma,
      Value<bool> warehouseReturnSupported,
      Value<bool> virtualRestockSupported,
    });
typedef $$SupplierReturnPoliciesTableUpdateCompanionBuilder =
    SupplierReturnPoliciesCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> supplierId,
      Value<String> policyType,
      Value<int?> returnWindowDays,
      Value<double?> restockingFeePercent,
      Value<String?> returnShippingPaidBy,
      Value<bool> requiresRma,
      Value<bool> warehouseReturnSupported,
      Value<bool> virtualRestockSupported,
    });

class $$SupplierReturnPoliciesTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierReturnPoliciesTable> {
  $$SupplierReturnPoliciesTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get policyType => $composableBuilder(
    column: $table.policyType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get returnWindowDays => $composableBuilder(
    column: $table.returnWindowDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get restockingFeePercent => $composableBuilder(
    column: $table.restockingFeePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnShippingPaidBy => $composableBuilder(
    column: $table.returnShippingPaidBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresRma => $composableBuilder(
    column: $table.requiresRma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get warehouseReturnSupported => $composableBuilder(
    column: $table.warehouseReturnSupported,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get virtualRestockSupported => $composableBuilder(
    column: $table.virtualRestockSupported,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupplierReturnPoliciesTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierReturnPoliciesTable> {
  $$SupplierReturnPoliciesTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get policyType => $composableBuilder(
    column: $table.policyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get returnWindowDays => $composableBuilder(
    column: $table.returnWindowDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get restockingFeePercent => $composableBuilder(
    column: $table.restockingFeePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnShippingPaidBy => $composableBuilder(
    column: $table.returnShippingPaidBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresRma => $composableBuilder(
    column: $table.requiresRma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get warehouseReturnSupported => $composableBuilder(
    column: $table.warehouseReturnSupported,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get virtualRestockSupported => $composableBuilder(
    column: $table.virtualRestockSupported,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupplierReturnPoliciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierReturnPoliciesTable> {
  $$SupplierReturnPoliciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get policyType => $composableBuilder(
    column: $table.policyType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get returnWindowDays => $composableBuilder(
    column: $table.returnWindowDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get restockingFeePercent => $composableBuilder(
    column: $table.restockingFeePercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnShippingPaidBy => $composableBuilder(
    column: $table.returnShippingPaidBy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresRma => $composableBuilder(
    column: $table.requiresRma,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get warehouseReturnSupported => $composableBuilder(
    column: $table.warehouseReturnSupported,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get virtualRestockSupported => $composableBuilder(
    column: $table.virtualRestockSupported,
    builder: (column) => column,
  );
}

class $$SupplierReturnPoliciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierReturnPoliciesTable,
          SupplierReturnPolicyRow,
          $$SupplierReturnPoliciesTableFilterComposer,
          $$SupplierReturnPoliciesTableOrderingComposer,
          $$SupplierReturnPoliciesTableAnnotationComposer,
          $$SupplierReturnPoliciesTableCreateCompanionBuilder,
          $$SupplierReturnPoliciesTableUpdateCompanionBuilder,
          (
            SupplierReturnPolicyRow,
            BaseReferences<
              _$AppDatabase,
              $SupplierReturnPoliciesTable,
              SupplierReturnPolicyRow
            >,
          ),
          SupplierReturnPolicyRow,
          PrefetchHooks Function()
        > {
  $$SupplierReturnPoliciesTableTableManager(
    _$AppDatabase db,
    $SupplierReturnPoliciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierReturnPoliciesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SupplierReturnPoliciesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SupplierReturnPoliciesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> policyType = const Value.absent(),
                Value<int?> returnWindowDays = const Value.absent(),
                Value<double?> restockingFeePercent = const Value.absent(),
                Value<String?> returnShippingPaidBy = const Value.absent(),
                Value<bool> requiresRma = const Value.absent(),
                Value<bool> warehouseReturnSupported = const Value.absent(),
                Value<bool> virtualRestockSupported = const Value.absent(),
              }) => SupplierReturnPoliciesCompanion(
                id: id,
                tenantId: tenantId,
                supplierId: supplierId,
                policyType: policyType,
                returnWindowDays: returnWindowDays,
                restockingFeePercent: restockingFeePercent,
                returnShippingPaidBy: returnShippingPaidBy,
                requiresRma: requiresRma,
                warehouseReturnSupported: warehouseReturnSupported,
                virtualRestockSupported: virtualRestockSupported,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String supplierId,
                required String policyType,
                Value<int?> returnWindowDays = const Value.absent(),
                Value<double?> restockingFeePercent = const Value.absent(),
                Value<String?> returnShippingPaidBy = const Value.absent(),
                Value<bool> requiresRma = const Value.absent(),
                Value<bool> warehouseReturnSupported = const Value.absent(),
                Value<bool> virtualRestockSupported = const Value.absent(),
              }) => SupplierReturnPoliciesCompanion.insert(
                id: id,
                tenantId: tenantId,
                supplierId: supplierId,
                policyType: policyType,
                returnWindowDays: returnWindowDays,
                restockingFeePercent: restockingFeePercent,
                returnShippingPaidBy: returnShippingPaidBy,
                requiresRma: requiresRma,
                warehouseReturnSupported: warehouseReturnSupported,
                virtualRestockSupported: virtualRestockSupported,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupplierReturnPoliciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierReturnPoliciesTable,
      SupplierReturnPolicyRow,
      $$SupplierReturnPoliciesTableFilterComposer,
      $$SupplierReturnPoliciesTableOrderingComposer,
      $$SupplierReturnPoliciesTableAnnotationComposer,
      $$SupplierReturnPoliciesTableCreateCompanionBuilder,
      $$SupplierReturnPoliciesTableUpdateCompanionBuilder,
      (
        SupplierReturnPolicyRow,
        BaseReferences<
          _$AppDatabase,
          $SupplierReturnPoliciesTable,
          SupplierReturnPolicyRow
        >,
      ),
      SupplierReturnPolicyRow,
      PrefetchHooks Function()
    >;
typedef $$IncidentRecordsTableCreateCompanionBuilder =
    IncidentRecordsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String orderId,
      required String incidentType,
      required String status,
      Value<String> trigger,
      Value<String?> automaticDecision,
      Value<String?> supplierInteraction,
      Value<String?> marketplaceInteraction,
      Value<double?> refundAmount,
      Value<double?> financialImpact,
      Value<String?> decisionLogId,
      required DateTime createdAt,
      Value<DateTime?> resolvedAt,
      Value<String?> attachmentIds,
    });
typedef $$IncidentRecordsTableUpdateCompanionBuilder =
    IncidentRecordsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> orderId,
      Value<String> incidentType,
      Value<String> status,
      Value<String> trigger,
      Value<String?> automaticDecision,
      Value<String?> supplierInteraction,
      Value<String?> marketplaceInteraction,
      Value<double?> refundAmount,
      Value<double?> financialImpact,
      Value<String?> decisionLogId,
      Value<DateTime> createdAt,
      Value<DateTime?> resolvedAt,
      Value<String?> attachmentIds,
    });

class $$IncidentRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $IncidentRecordsTable> {
  $$IncidentRecordsTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incidentType => $composableBuilder(
    column: $table.incidentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get automaticDecision => $composableBuilder(
    column: $table.automaticDecision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierInteraction => $composableBuilder(
    column: $table.supplierInteraction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marketplaceInteraction => $composableBuilder(
    column: $table.marketplaceInteraction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get financialImpact => $composableBuilder(
    column: $table.financialImpact,
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

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentIds => $composableBuilder(
    column: $table.attachmentIds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IncidentRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $IncidentRecordsTable> {
  $$IncidentRecordsTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incidentType => $composableBuilder(
    column: $table.incidentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trigger => $composableBuilder(
    column: $table.trigger,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get automaticDecision => $composableBuilder(
    column: $table.automaticDecision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierInteraction => $composableBuilder(
    column: $table.supplierInteraction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marketplaceInteraction => $composableBuilder(
    column: $table.marketplaceInteraction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get financialImpact => $composableBuilder(
    column: $table.financialImpact,
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

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentIds => $composableBuilder(
    column: $table.attachmentIds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncidentRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncidentRecordsTable> {
  $$IncidentRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get incidentType => $composableBuilder(
    column: $table.incidentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get trigger =>
      $composableBuilder(column: $table.trigger, builder: (column) => column);

  GeneratedColumn<String> get automaticDecision => $composableBuilder(
    column: $table.automaticDecision,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierInteraction => $composableBuilder(
    column: $table.supplierInteraction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marketplaceInteraction => $composableBuilder(
    column: $table.marketplaceInteraction,
    builder: (column) => column,
  );

  GeneratedColumn<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get financialImpact => $composableBuilder(
    column: $table.financialImpact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decisionLogId => $composableBuilder(
    column: $table.decisionLogId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentIds => $composableBuilder(
    column: $table.attachmentIds,
    builder: (column) => column,
  );
}

class $$IncidentRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncidentRecordsTable,
          IncidentRecordRow,
          $$IncidentRecordsTableFilterComposer,
          $$IncidentRecordsTableOrderingComposer,
          $$IncidentRecordsTableAnnotationComposer,
          $$IncidentRecordsTableCreateCompanionBuilder,
          $$IncidentRecordsTableUpdateCompanionBuilder,
          (
            IncidentRecordRow,
            BaseReferences<
              _$AppDatabase,
              $IncidentRecordsTable,
              IncidentRecordRow
            >,
          ),
          IncidentRecordRow,
          PrefetchHooks Function()
        > {
  $$IncidentRecordsTableTableManager(
    _$AppDatabase db,
    $IncidentRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncidentRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncidentRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncidentRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> incidentType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> trigger = const Value.absent(),
                Value<String?> automaticDecision = const Value.absent(),
                Value<String?> supplierInteraction = const Value.absent(),
                Value<String?> marketplaceInteraction = const Value.absent(),
                Value<double?> refundAmount = const Value.absent(),
                Value<double?> financialImpact = const Value.absent(),
                Value<String?> decisionLogId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<String?> attachmentIds = const Value.absent(),
              }) => IncidentRecordsCompanion(
                id: id,
                tenantId: tenantId,
                orderId: orderId,
                incidentType: incidentType,
                status: status,
                trigger: trigger,
                automaticDecision: automaticDecision,
                supplierInteraction: supplierInteraction,
                marketplaceInteraction: marketplaceInteraction,
                refundAmount: refundAmount,
                financialImpact: financialImpact,
                decisionLogId: decisionLogId,
                createdAt: createdAt,
                resolvedAt: resolvedAt,
                attachmentIds: attachmentIds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String orderId,
                required String incidentType,
                required String status,
                Value<String> trigger = const Value.absent(),
                Value<String?> automaticDecision = const Value.absent(),
                Value<String?> supplierInteraction = const Value.absent(),
                Value<String?> marketplaceInteraction = const Value.absent(),
                Value<double?> refundAmount = const Value.absent(),
                Value<double?> financialImpact = const Value.absent(),
                Value<String?> decisionLogId = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<String?> attachmentIds = const Value.absent(),
              }) => IncidentRecordsCompanion.insert(
                id: id,
                tenantId: tenantId,
                orderId: orderId,
                incidentType: incidentType,
                status: status,
                trigger: trigger,
                automaticDecision: automaticDecision,
                supplierInteraction: supplierInteraction,
                marketplaceInteraction: marketplaceInteraction,
                refundAmount: refundAmount,
                financialImpact: financialImpact,
                decisionLogId: decisionLogId,
                createdAt: createdAt,
                resolvedAt: resolvedAt,
                attachmentIds: attachmentIds,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IncidentRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncidentRecordsTable,
      IncidentRecordRow,
      $$IncidentRecordsTableFilterComposer,
      $$IncidentRecordsTableOrderingComposer,
      $$IncidentRecordsTableAnnotationComposer,
      $$IncidentRecordsTableCreateCompanionBuilder,
      $$IncidentRecordsTableUpdateCompanionBuilder,
      (
        IncidentRecordRow,
        BaseReferences<_$AppDatabase, $IncidentRecordsTable, IncidentRecordRow>,
      ),
      IncidentRecordRow,
      PrefetchHooks Function()
    >;
typedef $$ReturnedStocksTableCreateCompanionBuilder =
    ReturnedStocksCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String productId,
      required String supplierId,
      Value<String> condition,
      required int quantity,
      Value<bool> restockable,
      Value<String?> sourceOrderId,
      Value<String?> sourceReturnId,
      required DateTime createdAt,
    });
typedef $$ReturnedStocksTableUpdateCompanionBuilder =
    ReturnedStocksCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> productId,
      Value<String> supplierId,
      Value<String> condition,
      Value<int> quantity,
      Value<bool> restockable,
      Value<String?> sourceOrderId,
      Value<String?> sourceReturnId,
      Value<DateTime> createdAt,
    });

class $$ReturnedStocksTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnedStocksTable> {
  $$ReturnedStocksTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get restockable => $composableBuilder(
    column: $table.restockable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceOrderId => $composableBuilder(
    column: $table.sourceOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceReturnId => $composableBuilder(
    column: $table.sourceReturnId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnedStocksTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnedStocksTable> {
  $$ReturnedStocksTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get restockable => $composableBuilder(
    column: $table.restockable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceOrderId => $composableBuilder(
    column: $table.sourceOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceReturnId => $composableBuilder(
    column: $table.sourceReturnId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnedStocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnedStocksTable> {
  $$ReturnedStocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<bool> get restockable => $composableBuilder(
    column: $table.restockable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceOrderId => $composableBuilder(
    column: $table.sourceOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceReturnId => $composableBuilder(
    column: $table.sourceReturnId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ReturnedStocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnedStocksTable,
          ReturnedStockRow,
          $$ReturnedStocksTableFilterComposer,
          $$ReturnedStocksTableOrderingComposer,
          $$ReturnedStocksTableAnnotationComposer,
          $$ReturnedStocksTableCreateCompanionBuilder,
          $$ReturnedStocksTableUpdateCompanionBuilder,
          (
            ReturnedStockRow,
            BaseReferences<
              _$AppDatabase,
              $ReturnedStocksTable,
              ReturnedStockRow
            >,
          ),
          ReturnedStockRow,
          PrefetchHooks Function()
        > {
  $$ReturnedStocksTableTableManager(
    _$AppDatabase db,
    $ReturnedStocksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReturnedStocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReturnedStocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReturnedStocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<bool> restockable = const Value.absent(),
                Value<String?> sourceOrderId = const Value.absent(),
                Value<String?> sourceReturnId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReturnedStocksCompanion(
                id: id,
                tenantId: tenantId,
                productId: productId,
                supplierId: supplierId,
                condition: condition,
                quantity: quantity,
                restockable: restockable,
                sourceOrderId: sourceOrderId,
                sourceReturnId: sourceReturnId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String productId,
                required String supplierId,
                Value<String> condition = const Value.absent(),
                required int quantity,
                Value<bool> restockable = const Value.absent(),
                Value<String?> sourceOrderId = const Value.absent(),
                Value<String?> sourceReturnId = const Value.absent(),
                required DateTime createdAt,
              }) => ReturnedStocksCompanion.insert(
                id: id,
                tenantId: tenantId,
                productId: productId,
                supplierId: supplierId,
                condition: condition,
                quantity: quantity,
                restockable: restockable,
                sourceOrderId: sourceOrderId,
                sourceReturnId: sourceReturnId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReturnedStocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnedStocksTable,
      ReturnedStockRow,
      $$ReturnedStocksTableFilterComposer,
      $$ReturnedStocksTableOrderingComposer,
      $$ReturnedStocksTableAnnotationComposer,
      $$ReturnedStocksTableCreateCompanionBuilder,
      $$ReturnedStocksTableUpdateCompanionBuilder,
      (
        ReturnedStockRow,
        BaseReferences<_$AppDatabase, $ReturnedStocksTable, ReturnedStockRow>,
      ),
      ReturnedStockRow,
      PrefetchHooks Function()
    >;
typedef $$FinancialLedgerTableCreateCompanionBuilder =
    FinancialLedgerCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String type,
      Value<String?> orderId,
      required double amount,
      Value<String> currency,
      Value<String?> referenceId,
      required DateTime createdAt,
    });
typedef $$FinancialLedgerTableUpdateCompanionBuilder =
    FinancialLedgerCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> type,
      Value<String?> orderId,
      Value<double> amount,
      Value<String> currency,
      Value<String?> referenceId,
      Value<DateTime> createdAt,
    });

class $$FinancialLedgerTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialLedgerTable> {
  $$FinancialLedgerTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FinancialLedgerTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialLedgerTable> {
  $$FinancialLedgerTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FinancialLedgerTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialLedgerTable> {
  $$FinancialLedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FinancialLedgerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialLedgerTable,
          FinancialLedgerRow,
          $$FinancialLedgerTableFilterComposer,
          $$FinancialLedgerTableOrderingComposer,
          $$FinancialLedgerTableAnnotationComposer,
          $$FinancialLedgerTableCreateCompanionBuilder,
          $$FinancialLedgerTableUpdateCompanionBuilder,
          (
            FinancialLedgerRow,
            BaseReferences<
              _$AppDatabase,
              $FinancialLedgerTable,
              FinancialLedgerRow
            >,
          ),
          FinancialLedgerRow,
          PrefetchHooks Function()
        > {
  $$FinancialLedgerTableTableManager(
    _$AppDatabase db,
    $FinancialLedgerTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialLedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialLedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancialLedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> orderId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FinancialLedgerCompanion(
                id: id,
                tenantId: tenantId,
                type: type,
                orderId: orderId,
                amount: amount,
                currency: currency,
                referenceId: referenceId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String type,
                Value<String?> orderId = const Value.absent(),
                required double amount,
                Value<String> currency = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                required DateTime createdAt,
              }) => FinancialLedgerCompanion.insert(
                id: id,
                tenantId: tenantId,
                type: type,
                orderId: orderId,
                amount: amount,
                currency: currency,
                referenceId: referenceId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FinancialLedgerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialLedgerTable,
      FinancialLedgerRow,
      $$FinancialLedgerTableFilterComposer,
      $$FinancialLedgerTableOrderingComposer,
      $$FinancialLedgerTableAnnotationComposer,
      $$FinancialLedgerTableCreateCompanionBuilder,
      $$FinancialLedgerTableUpdateCompanionBuilder,
      (
        FinancialLedgerRow,
        BaseReferences<
          _$AppDatabase,
          $FinancialLedgerTable,
          FinancialLedgerRow
        >,
      ),
      FinancialLedgerRow,
      PrefetchHooks Function()
    >;
typedef $$FeatureFlagsTableCreateCompanionBuilder =
    FeatureFlagsCompanion Function({
      required String name,
      Value<int> tenantId,
      Value<bool> enabled,
      Value<int> rowid,
    });
typedef $$FeatureFlagsTableUpdateCompanionBuilder =
    FeatureFlagsCompanion Function({
      Value<String> name,
      Value<int> tenantId,
      Value<bool> enabled,
      Value<int> rowid,
    });

class $$FeatureFlagsTableFilterComposer
    extends Composer<_$AppDatabase, $FeatureFlagsTable> {
  $$FeatureFlagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeatureFlagsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeatureFlagsTable> {
  $$FeatureFlagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeatureFlagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeatureFlagsTable> {
  $$FeatureFlagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$FeatureFlagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeatureFlagsTable,
          FeatureFlagRow,
          $$FeatureFlagsTableFilterComposer,
          $$FeatureFlagsTableOrderingComposer,
          $$FeatureFlagsTableAnnotationComposer,
          $$FeatureFlagsTableCreateCompanionBuilder,
          $$FeatureFlagsTableUpdateCompanionBuilder,
          (
            FeatureFlagRow,
            BaseReferences<_$AppDatabase, $FeatureFlagsTable, FeatureFlagRow>,
          ),
          FeatureFlagRow,
          PrefetchHooks Function()
        > {
  $$FeatureFlagsTableTableManager(_$AppDatabase db, $FeatureFlagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeatureFlagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeatureFlagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeatureFlagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> name = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeatureFlagsCompanion(
                name: name,
                tenantId: tenantId,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String name,
                Value<int> tenantId = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeatureFlagsCompanion.insert(
                name: name,
                tenantId: tenantId,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeatureFlagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeatureFlagsTable,
      FeatureFlagRow,
      $$FeatureFlagsTableFilterComposer,
      $$FeatureFlagsTableOrderingComposer,
      $$FeatureFlagsTableAnnotationComposer,
      $$FeatureFlagsTableCreateCompanionBuilder,
      $$FeatureFlagsTableUpdateCompanionBuilder,
      (
        FeatureFlagRow,
        BaseReferences<_$AppDatabase, $FeatureFlagsTable, FeatureFlagRow>,
      ),
      FeatureFlagRow,
      PrefetchHooks Function()
    >;
typedef $$BackgroundJobsTableCreateCompanionBuilder =
    BackgroundJobsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String jobType,
      Value<String> payloadJson,
      required String status,
      Value<int> attempts,
      Value<int> maxAttempts,
      required DateTime createdAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> errorMessage,
    });
typedef $$BackgroundJobsTableUpdateCompanionBuilder =
    BackgroundJobsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> jobType,
      Value<String> payloadJson,
      Value<String> status,
      Value<int> attempts,
      Value<int> maxAttempts,
      Value<DateTime> createdAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<String?> errorMessage,
    });

class $$BackgroundJobsTableFilterComposer
    extends Composer<_$AppDatabase, $BackgroundJobsTable> {
  $$BackgroundJobsTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobType => $composableBuilder(
    column: $table.jobType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxAttempts => $composableBuilder(
    column: $table.maxAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackgroundJobsTableOrderingComposer
    extends Composer<_$AppDatabase, $BackgroundJobsTable> {
  $$BackgroundJobsTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobType => $composableBuilder(
    column: $table.jobType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxAttempts => $composableBuilder(
    column: $table.maxAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackgroundJobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackgroundJobsTable> {
  $$BackgroundJobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get jobType =>
      $composableBuilder(column: $table.jobType, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<int> get maxAttempts => $composableBuilder(
    column: $table.maxAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );
}

class $$BackgroundJobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackgroundJobsTable,
          BackgroundJobRow,
          $$BackgroundJobsTableFilterComposer,
          $$BackgroundJobsTableOrderingComposer,
          $$BackgroundJobsTableAnnotationComposer,
          $$BackgroundJobsTableCreateCompanionBuilder,
          $$BackgroundJobsTableUpdateCompanionBuilder,
          (
            BackgroundJobRow,
            BaseReferences<
              _$AppDatabase,
              $BackgroundJobsTable,
              BackgroundJobRow
            >,
          ),
          BackgroundJobRow,
          PrefetchHooks Function()
        > {
  $$BackgroundJobsTableTableManager(
    _$AppDatabase db,
    $BackgroundJobsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackgroundJobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackgroundJobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackgroundJobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> jobType = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<int> maxAttempts = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
              }) => BackgroundJobsCompanion(
                id: id,
                tenantId: tenantId,
                jobType: jobType,
                payloadJson: payloadJson,
                status: status,
                attempts: attempts,
                maxAttempts: maxAttempts,
                createdAt: createdAt,
                startedAt: startedAt,
                completedAt: completedAt,
                errorMessage: errorMessage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String jobType,
                Value<String> payloadJson = const Value.absent(),
                required String status,
                Value<int> attempts = const Value.absent(),
                Value<int> maxAttempts = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
              }) => BackgroundJobsCompanion.insert(
                id: id,
                tenantId: tenantId,
                jobType: jobType,
                payloadJson: payloadJson,
                status: status,
                attempts: attempts,
                maxAttempts: maxAttempts,
                createdAt: createdAt,
                startedAt: startedAt,
                completedAt: completedAt,
                errorMessage: errorMessage,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackgroundJobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackgroundJobsTable,
      BackgroundJobRow,
      $$BackgroundJobsTableFilterComposer,
      $$BackgroundJobsTableOrderingComposer,
      $$BackgroundJobsTableAnnotationComposer,
      $$BackgroundJobsTableCreateCompanionBuilder,
      $$BackgroundJobsTableUpdateCompanionBuilder,
      (
        BackgroundJobRow,
        BaseReferences<_$AppDatabase, $BackgroundJobsTable, BackgroundJobRow>,
      ),
      BackgroundJobRow,
      PrefetchHooks Function()
    >;
typedef $$DistributedLocksTableCreateCompanionBuilder =
    DistributedLocksCompanion Function({
      required String lockKey,
      Value<int> tenantId,
      required DateTime expiresAt,
      Value<int> rowid,
    });
typedef $$DistributedLocksTableUpdateCompanionBuilder =
    DistributedLocksCompanion Function({
      Value<String> lockKey,
      Value<int> tenantId,
      Value<DateTime> expiresAt,
      Value<int> rowid,
    });

class $$DistributedLocksTableFilterComposer
    extends Composer<_$AppDatabase, $DistributedLocksTable> {
  $$DistributedLocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lockKey => $composableBuilder(
    column: $table.lockKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DistributedLocksTableOrderingComposer
    extends Composer<_$AppDatabase, $DistributedLocksTable> {
  $$DistributedLocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lockKey => $composableBuilder(
    column: $table.lockKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DistributedLocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DistributedLocksTable> {
  $$DistributedLocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lockKey =>
      $composableBuilder(column: $table.lockKey, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$DistributedLocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DistributedLocksTable,
          DistributedLockRow,
          $$DistributedLocksTableFilterComposer,
          $$DistributedLocksTableOrderingComposer,
          $$DistributedLocksTableAnnotationComposer,
          $$DistributedLocksTableCreateCompanionBuilder,
          $$DistributedLocksTableUpdateCompanionBuilder,
          (
            DistributedLockRow,
            BaseReferences<
              _$AppDatabase,
              $DistributedLocksTable,
              DistributedLockRow
            >,
          ),
          DistributedLockRow,
          PrefetchHooks Function()
        > {
  $$DistributedLocksTableTableManager(
    _$AppDatabase db,
    $DistributedLocksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DistributedLocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DistributedLocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DistributedLocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> lockKey = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DistributedLocksCompanion(
                lockKey: lockKey,
                tenantId: tenantId,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String lockKey,
                Value<int> tenantId = const Value.absent(),
                required DateTime expiresAt,
                Value<int> rowid = const Value.absent(),
              }) => DistributedLocksCompanion.insert(
                lockKey: lockKey,
                tenantId: tenantId,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DistributedLocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DistributedLocksTable,
      DistributedLockRow,
      $$DistributedLocksTableFilterComposer,
      $$DistributedLocksTableOrderingComposer,
      $$DistributedLocksTableAnnotationComposer,
      $$DistributedLocksTableCreateCompanionBuilder,
      $$DistributedLocksTableUpdateCompanionBuilder,
      (
        DistributedLockRow,
        BaseReferences<
          _$AppDatabase,
          $DistributedLocksTable,
          DistributedLockRow
        >,
      ),
      DistributedLockRow,
      PrefetchHooks Function()
    >;
typedef $$BillingPlansTableCreateCompanionBuilder =
    BillingPlansCompanion Function({
      Value<int> id,
      required String name,
      required int maxListings,
      required int maxOrdersPerMonth,
      Value<String?> stripePriceId,
    });
typedef $$BillingPlansTableUpdateCompanionBuilder =
    BillingPlansCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> maxListings,
      Value<int> maxOrdersPerMonth,
      Value<String?> stripePriceId,
    });

class $$BillingPlansTableFilterComposer
    extends Composer<_$AppDatabase, $BillingPlansTable> {
  $$BillingPlansTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxListings => $composableBuilder(
    column: $table.maxListings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxOrdersPerMonth => $composableBuilder(
    column: $table.maxOrdersPerMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stripePriceId => $composableBuilder(
    column: $table.stripePriceId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillingPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $BillingPlansTable> {
  $$BillingPlansTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxListings => $composableBuilder(
    column: $table.maxListings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxOrdersPerMonth => $composableBuilder(
    column: $table.maxOrdersPerMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stripePriceId => $composableBuilder(
    column: $table.stripePriceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillingPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillingPlansTable> {
  $$BillingPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get maxListings => $composableBuilder(
    column: $table.maxListings,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxOrdersPerMonth => $composableBuilder(
    column: $table.maxOrdersPerMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stripePriceId => $composableBuilder(
    column: $table.stripePriceId,
    builder: (column) => column,
  );
}

class $$BillingPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillingPlansTable,
          BillingPlanRow,
          $$BillingPlansTableFilterComposer,
          $$BillingPlansTableOrderingComposer,
          $$BillingPlansTableAnnotationComposer,
          $$BillingPlansTableCreateCompanionBuilder,
          $$BillingPlansTableUpdateCompanionBuilder,
          (
            BillingPlanRow,
            BaseReferences<_$AppDatabase, $BillingPlansTable, BillingPlanRow>,
          ),
          BillingPlanRow,
          PrefetchHooks Function()
        > {
  $$BillingPlansTableTableManager(_$AppDatabase db, $BillingPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillingPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillingPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillingPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> maxListings = const Value.absent(),
                Value<int> maxOrdersPerMonth = const Value.absent(),
                Value<String?> stripePriceId = const Value.absent(),
              }) => BillingPlansCompanion(
                id: id,
                name: name,
                maxListings: maxListings,
                maxOrdersPerMonth: maxOrdersPerMonth,
                stripePriceId: stripePriceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int maxListings,
                required int maxOrdersPerMonth,
                Value<String?> stripePriceId = const Value.absent(),
              }) => BillingPlansCompanion.insert(
                id: id,
                name: name,
                maxListings: maxListings,
                maxOrdersPerMonth: maxOrdersPerMonth,
                stripePriceId: stripePriceId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillingPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillingPlansTable,
      BillingPlanRow,
      $$BillingPlansTableFilterComposer,
      $$BillingPlansTableOrderingComposer,
      $$BillingPlansTableAnnotationComposer,
      $$BillingPlansTableCreateCompanionBuilder,
      $$BillingPlansTableUpdateCompanionBuilder,
      (
        BillingPlanRow,
        BaseReferences<_$AppDatabase, $BillingPlansTable, BillingPlanRow>,
      ),
      BillingPlanRow,
      PrefetchHooks Function()
    >;
typedef $$TenantPlansTableCreateCompanionBuilder =
    TenantPlansCompanion Function({
      Value<int> tenantId,
      required int planId,
      Value<String?> stripeCustomerId,
      Value<String?> stripeSubscriptionId,
      Value<DateTime?> currentPeriodStart,
      Value<DateTime?> currentPeriodEnd,
    });
typedef $$TenantPlansTableUpdateCompanionBuilder =
    TenantPlansCompanion Function({
      Value<int> tenantId,
      Value<int> planId,
      Value<String?> stripeCustomerId,
      Value<String?> stripeSubscriptionId,
      Value<DateTime?> currentPeriodStart,
      Value<DateTime?> currentPeriodEnd,
    });

class $$TenantPlansTableFilterComposer
    extends Composer<_$AppDatabase, $TenantPlansTable> {
  $$TenantPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stripeCustomerId => $composableBuilder(
    column: $table.stripeCustomerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stripeSubscriptionId => $composableBuilder(
    column: $table.stripeSubscriptionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TenantPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $TenantPlansTable> {
  $$TenantPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stripeCustomerId => $composableBuilder(
    column: $table.stripeCustomerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stripeSubscriptionId => $composableBuilder(
    column: $table.stripeSubscriptionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TenantPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenantPlansTable> {
  $$TenantPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<int> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get stripeCustomerId => $composableBuilder(
    column: $table.stripeCustomerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stripeSubscriptionId => $composableBuilder(
    column: $table.stripeSubscriptionId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get currentPeriodStart => $composableBuilder(
    column: $table.currentPeriodStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get currentPeriodEnd => $composableBuilder(
    column: $table.currentPeriodEnd,
    builder: (column) => column,
  );
}

class $$TenantPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TenantPlansTable,
          TenantPlanRow,
          $$TenantPlansTableFilterComposer,
          $$TenantPlansTableOrderingComposer,
          $$TenantPlansTableAnnotationComposer,
          $$TenantPlansTableCreateCompanionBuilder,
          $$TenantPlansTableUpdateCompanionBuilder,
          (
            TenantPlanRow,
            BaseReferences<_$AppDatabase, $TenantPlansTable, TenantPlanRow>,
          ),
          TenantPlanRow,
          PrefetchHooks Function()
        > {
  $$TenantPlansTableTableManager(_$AppDatabase db, $TenantPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenantPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenantPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenantPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> tenantId = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<String?> stripeCustomerId = const Value.absent(),
                Value<String?> stripeSubscriptionId = const Value.absent(),
                Value<DateTime?> currentPeriodStart = const Value.absent(),
                Value<DateTime?> currentPeriodEnd = const Value.absent(),
              }) => TenantPlansCompanion(
                tenantId: tenantId,
                planId: planId,
                stripeCustomerId: stripeCustomerId,
                stripeSubscriptionId: stripeSubscriptionId,
                currentPeriodStart: currentPeriodStart,
                currentPeriodEnd: currentPeriodEnd,
              ),
          createCompanionCallback:
              ({
                Value<int> tenantId = const Value.absent(),
                required int planId,
                Value<String?> stripeCustomerId = const Value.absent(),
                Value<String?> stripeSubscriptionId = const Value.absent(),
                Value<DateTime?> currentPeriodStart = const Value.absent(),
                Value<DateTime?> currentPeriodEnd = const Value.absent(),
              }) => TenantPlansCompanion.insert(
                tenantId: tenantId,
                planId: planId,
                stripeCustomerId: stripeCustomerId,
                stripeSubscriptionId: stripeSubscriptionId,
                currentPeriodStart: currentPeriodStart,
                currentPeriodEnd: currentPeriodEnd,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TenantPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TenantPlansTable,
      TenantPlanRow,
      $$TenantPlansTableFilterComposer,
      $$TenantPlansTableOrderingComposer,
      $$TenantPlansTableAnnotationComposer,
      $$TenantPlansTableCreateCompanionBuilder,
      $$TenantPlansTableUpdateCompanionBuilder,
      (
        TenantPlanRow,
        BaseReferences<_$AppDatabase, $TenantPlansTable, TenantPlanRow>,
      ),
      TenantPlanRow,
      PrefetchHooks Function()
    >;
typedef $$SupplierReliabilityScoresTableCreateCompanionBuilder =
    SupplierReliabilityScoresCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String supplierId,
      required double score,
      Value<String> metricsJson,
      required DateTime lastEvaluatedAt,
    });
typedef $$SupplierReliabilityScoresTableUpdateCompanionBuilder =
    SupplierReliabilityScoresCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> supplierId,
      Value<double> score,
      Value<String> metricsJson,
      Value<DateTime> lastEvaluatedAt,
    });

class $$SupplierReliabilityScoresTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierReliabilityScoresTable> {
  $$SupplierReliabilityScoresTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metricsJson => $composableBuilder(
    column: $table.metricsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastEvaluatedAt => $composableBuilder(
    column: $table.lastEvaluatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupplierReliabilityScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierReliabilityScoresTable> {
  $$SupplierReliabilityScoresTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metricsJson => $composableBuilder(
    column: $table.metricsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastEvaluatedAt => $composableBuilder(
    column: $table.lastEvaluatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupplierReliabilityScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierReliabilityScoresTable> {
  $$SupplierReliabilityScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get metricsJson => $composableBuilder(
    column: $table.metricsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastEvaluatedAt => $composableBuilder(
    column: $table.lastEvaluatedAt,
    builder: (column) => column,
  );
}

class $$SupplierReliabilityScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierReliabilityScoresTable,
          SupplierReliabilityScoreRow,
          $$SupplierReliabilityScoresTableFilterComposer,
          $$SupplierReliabilityScoresTableOrderingComposer,
          $$SupplierReliabilityScoresTableAnnotationComposer,
          $$SupplierReliabilityScoresTableCreateCompanionBuilder,
          $$SupplierReliabilityScoresTableUpdateCompanionBuilder,
          (
            SupplierReliabilityScoreRow,
            BaseReferences<
              _$AppDatabase,
              $SupplierReliabilityScoresTable,
              SupplierReliabilityScoreRow
            >,
          ),
          SupplierReliabilityScoreRow,
          PrefetchHooks Function()
        > {
  $$SupplierReliabilityScoresTableTableManager(
    _$AppDatabase db,
    $SupplierReliabilityScoresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierReliabilityScoresTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SupplierReliabilityScoresTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SupplierReliabilityScoresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<double> score = const Value.absent(),
                Value<String> metricsJson = const Value.absent(),
                Value<DateTime> lastEvaluatedAt = const Value.absent(),
              }) => SupplierReliabilityScoresCompanion(
                id: id,
                tenantId: tenantId,
                supplierId: supplierId,
                score: score,
                metricsJson: metricsJson,
                lastEvaluatedAt: lastEvaluatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String supplierId,
                required double score,
                Value<String> metricsJson = const Value.absent(),
                required DateTime lastEvaluatedAt,
              }) => SupplierReliabilityScoresCompanion.insert(
                id: id,
                tenantId: tenantId,
                supplierId: supplierId,
                score: score,
                metricsJson: metricsJson,
                lastEvaluatedAt: lastEvaluatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupplierReliabilityScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierReliabilityScoresTable,
      SupplierReliabilityScoreRow,
      $$SupplierReliabilityScoresTableFilterComposer,
      $$SupplierReliabilityScoresTableOrderingComposer,
      $$SupplierReliabilityScoresTableAnnotationComposer,
      $$SupplierReliabilityScoresTableCreateCompanionBuilder,
      $$SupplierReliabilityScoresTableUpdateCompanionBuilder,
      (
        SupplierReliabilityScoreRow,
        BaseReferences<
          _$AppDatabase,
          $SupplierReliabilityScoresTable,
          SupplierReliabilityScoreRow
        >,
      ),
      SupplierReliabilityScoreRow,
      PrefetchHooks Function()
    >;
typedef $$ListingHealthMetricsTableCreateCompanionBuilder =
    ListingHealthMetricsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String listingId,
      required int totalOrders,
      required int cancelledCount,
      required int lateCount,
      required int returnOrIncidentCount,
      required DateTime lastEvaluatedAt,
    });
typedef $$ListingHealthMetricsTableUpdateCompanionBuilder =
    ListingHealthMetricsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> listingId,
      Value<int> totalOrders,
      Value<int> cancelledCount,
      Value<int> lateCount,
      Value<int> returnOrIncidentCount,
      Value<DateTime> lastEvaluatedAt,
    });

class $$ListingHealthMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $ListingHealthMetricsTable> {
  $$ListingHealthMetricsTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalOrders => $composableBuilder(
    column: $table.totalOrders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cancelledCount => $composableBuilder(
    column: $table.cancelledCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lateCount => $composableBuilder(
    column: $table.lateCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get returnOrIncidentCount => $composableBuilder(
    column: $table.returnOrIncidentCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastEvaluatedAt => $composableBuilder(
    column: $table.lastEvaluatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ListingHealthMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $ListingHealthMetricsTable> {
  $$ListingHealthMetricsTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalOrders => $composableBuilder(
    column: $table.totalOrders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cancelledCount => $composableBuilder(
    column: $table.cancelledCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lateCount => $composableBuilder(
    column: $table.lateCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get returnOrIncidentCount => $composableBuilder(
    column: $table.returnOrIncidentCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastEvaluatedAt => $composableBuilder(
    column: $table.lastEvaluatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ListingHealthMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListingHealthMetricsTable> {
  $$ListingHealthMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get listingId =>
      $composableBuilder(column: $table.listingId, builder: (column) => column);

  GeneratedColumn<int> get totalOrders => $composableBuilder(
    column: $table.totalOrders,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cancelledCount => $composableBuilder(
    column: $table.cancelledCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lateCount =>
      $composableBuilder(column: $table.lateCount, builder: (column) => column);

  GeneratedColumn<int> get returnOrIncidentCount => $composableBuilder(
    column: $table.returnOrIncidentCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastEvaluatedAt => $composableBuilder(
    column: $table.lastEvaluatedAt,
    builder: (column) => column,
  );
}

class $$ListingHealthMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ListingHealthMetricsTable,
          ListingHealthMetricsRow,
          $$ListingHealthMetricsTableFilterComposer,
          $$ListingHealthMetricsTableOrderingComposer,
          $$ListingHealthMetricsTableAnnotationComposer,
          $$ListingHealthMetricsTableCreateCompanionBuilder,
          $$ListingHealthMetricsTableUpdateCompanionBuilder,
          (
            ListingHealthMetricsRow,
            BaseReferences<
              _$AppDatabase,
              $ListingHealthMetricsTable,
              ListingHealthMetricsRow
            >,
          ),
          ListingHealthMetricsRow,
          PrefetchHooks Function()
        > {
  $$ListingHealthMetricsTableTableManager(
    _$AppDatabase db,
    $ListingHealthMetricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListingHealthMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListingHealthMetricsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ListingHealthMetricsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> listingId = const Value.absent(),
                Value<int> totalOrders = const Value.absent(),
                Value<int> cancelledCount = const Value.absent(),
                Value<int> lateCount = const Value.absent(),
                Value<int> returnOrIncidentCount = const Value.absent(),
                Value<DateTime> lastEvaluatedAt = const Value.absent(),
              }) => ListingHealthMetricsCompanion(
                id: id,
                tenantId: tenantId,
                listingId: listingId,
                totalOrders: totalOrders,
                cancelledCount: cancelledCount,
                lateCount: lateCount,
                returnOrIncidentCount: returnOrIncidentCount,
                lastEvaluatedAt: lastEvaluatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String listingId,
                required int totalOrders,
                required int cancelledCount,
                required int lateCount,
                required int returnOrIncidentCount,
                required DateTime lastEvaluatedAt,
              }) => ListingHealthMetricsCompanion.insert(
                id: id,
                tenantId: tenantId,
                listingId: listingId,
                totalOrders: totalOrders,
                cancelledCount: cancelledCount,
                lateCount: lateCount,
                returnOrIncidentCount: returnOrIncidentCount,
                lastEvaluatedAt: lastEvaluatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ListingHealthMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ListingHealthMetricsTable,
      ListingHealthMetricsRow,
      $$ListingHealthMetricsTableFilterComposer,
      $$ListingHealthMetricsTableOrderingComposer,
      $$ListingHealthMetricsTableAnnotationComposer,
      $$ListingHealthMetricsTableCreateCompanionBuilder,
      $$ListingHealthMetricsTableUpdateCompanionBuilder,
      (
        ListingHealthMetricsRow,
        BaseReferences<
          _$AppDatabase,
          $ListingHealthMetricsTable,
          ListingHealthMetricsRow
        >,
      ),
      ListingHealthMetricsRow,
      PrefetchHooks Function()
    >;
typedef $$CustomerMetricsTableCreateCompanionBuilder =
    CustomerMetricsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String customerId,
      required double returnRate,
      required double complaintRate,
      required double refundRate,
      required int orderCount,
      required DateTime windowEnd,
    });
typedef $$CustomerMetricsTableUpdateCompanionBuilder =
    CustomerMetricsCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> customerId,
      Value<double> returnRate,
      Value<double> complaintRate,
      Value<double> refundRate,
      Value<int> orderCount,
      Value<DateTime> windowEnd,
    });

class $$CustomerMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerMetricsTable> {
  $$CustomerMetricsTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get returnRate => $composableBuilder(
    column: $table.returnRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get complaintRate => $composableBuilder(
    column: $table.complaintRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundRate => $composableBuilder(
    column: $table.refundRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderCount => $composableBuilder(
    column: $table.orderCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get windowEnd => $composableBuilder(
    column: $table.windowEnd,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomerMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerMetricsTable> {
  $$CustomerMetricsTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get returnRate => $composableBuilder(
    column: $table.returnRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get complaintRate => $composableBuilder(
    column: $table.complaintRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundRate => $composableBuilder(
    column: $table.refundRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderCount => $composableBuilder(
    column: $table.orderCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get windowEnd => $composableBuilder(
    column: $table.windowEnd,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomerMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerMetricsTable> {
  $$CustomerMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get returnRate => $composableBuilder(
    column: $table.returnRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get complaintRate => $composableBuilder(
    column: $table.complaintRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get refundRate => $composableBuilder(
    column: $table.refundRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get orderCount => $composableBuilder(
    column: $table.orderCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get windowEnd =>
      $composableBuilder(column: $table.windowEnd, builder: (column) => column);
}

class $$CustomerMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerMetricsTable,
          CustomerMetricsRow,
          $$CustomerMetricsTableFilterComposer,
          $$CustomerMetricsTableOrderingComposer,
          $$CustomerMetricsTableAnnotationComposer,
          $$CustomerMetricsTableCreateCompanionBuilder,
          $$CustomerMetricsTableUpdateCompanionBuilder,
          (
            CustomerMetricsRow,
            BaseReferences<
              _$AppDatabase,
              $CustomerMetricsTable,
              CustomerMetricsRow
            >,
          ),
          CustomerMetricsRow,
          PrefetchHooks Function()
        > {
  $$CustomerMetricsTableTableManager(
    _$AppDatabase db,
    $CustomerMetricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerMetricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerMetricsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<double> returnRate = const Value.absent(),
                Value<double> complaintRate = const Value.absent(),
                Value<double> refundRate = const Value.absent(),
                Value<int> orderCount = const Value.absent(),
                Value<DateTime> windowEnd = const Value.absent(),
              }) => CustomerMetricsCompanion(
                id: id,
                tenantId: tenantId,
                customerId: customerId,
                returnRate: returnRate,
                complaintRate: complaintRate,
                refundRate: refundRate,
                orderCount: orderCount,
                windowEnd: windowEnd,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String customerId,
                required double returnRate,
                required double complaintRate,
                required double refundRate,
                required int orderCount,
                required DateTime windowEnd,
              }) => CustomerMetricsCompanion.insert(
                id: id,
                tenantId: tenantId,
                customerId: customerId,
                returnRate: returnRate,
                complaintRate: complaintRate,
                refundRate: refundRate,
                orderCount: orderCount,
                windowEnd: windowEnd,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomerMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerMetricsTable,
      CustomerMetricsRow,
      $$CustomerMetricsTableFilterComposer,
      $$CustomerMetricsTableOrderingComposer,
      $$CustomerMetricsTableAnnotationComposer,
      $$CustomerMetricsTableCreateCompanionBuilder,
      $$CustomerMetricsTableUpdateCompanionBuilder,
      (
        CustomerMetricsRow,
        BaseReferences<
          _$AppDatabase,
          $CustomerMetricsTable,
          CustomerMetricsRow
        >,
      ),
      CustomerMetricsRow,
      PrefetchHooks Function()
    >;
typedef $$StockStateTableCreateCompanionBuilder =
    StockStateCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      required String productId,
      Value<String?> supplierId,
      Value<int?> supplierStock,
      Value<int> returnedStock,
      Value<int> reservedStock,
      Value<int> availableStock,
      required DateTime lastUpdatedAt,
    });
typedef $$StockStateTableUpdateCompanionBuilder =
    StockStateCompanion Function({
      Value<int> id,
      Value<int> tenantId,
      Value<String> productId,
      Value<String?> supplierId,
      Value<int?> supplierStock,
      Value<int> returnedStock,
      Value<int> reservedStock,
      Value<int> availableStock,
      Value<DateTime> lastUpdatedAt,
    });

class $$StockStateTableFilterComposer
    extends Composer<_$AppDatabase, $StockStateTable> {
  $$StockStateTableFilterComposer({
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

  ColumnFilters<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnFilters<int> get supplierStock => $composableBuilder(
    column: $table.supplierStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get returnedStock => $composableBuilder(
    column: $table.returnedStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reservedStock => $composableBuilder(
    column: $table.reservedStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get availableStock => $composableBuilder(
    column: $table.availableStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockStateTableOrderingComposer
    extends Composer<_$AppDatabase, $StockStateTable> {
  $$StockStateTableOrderingComposer({
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

  ColumnOrderings<int> get tenantId => $composableBuilder(
    column: $table.tenantId,
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

  ColumnOrderings<int> get supplierStock => $composableBuilder(
    column: $table.supplierStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get returnedStock => $composableBuilder(
    column: $table.returnedStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reservedStock => $composableBuilder(
    column: $table.reservedStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get availableStock => $composableBuilder(
    column: $table.availableStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockStateTable> {
  $$StockStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get supplierStock => $composableBuilder(
    column: $table.supplierStock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get returnedStock => $composableBuilder(
    column: $table.returnedStock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reservedStock => $composableBuilder(
    column: $table.reservedStock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get availableStock => $composableBuilder(
    column: $table.availableStock,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
    column: $table.lastUpdatedAt,
    builder: (column) => column,
  );
}

class $$StockStateTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockStateTable,
          StockStateRow,
          $$StockStateTableFilterComposer,
          $$StockStateTableOrderingComposer,
          $$StockStateTableAnnotationComposer,
          $$StockStateTableCreateCompanionBuilder,
          $$StockStateTableUpdateCompanionBuilder,
          (
            StockStateRow,
            BaseReferences<_$AppDatabase, $StockStateTable, StockStateRow>,
          ),
          StockStateRow,
          PrefetchHooks Function()
        > {
  $$StockStateTableTableManager(_$AppDatabase db, $StockStateTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                Value<int?> supplierStock = const Value.absent(),
                Value<int> returnedStock = const Value.absent(),
                Value<int> reservedStock = const Value.absent(),
                Value<int> availableStock = const Value.absent(),
                Value<DateTime> lastUpdatedAt = const Value.absent(),
              }) => StockStateCompanion(
                id: id,
                tenantId: tenantId,
                productId: productId,
                supplierId: supplierId,
                supplierStock: supplierStock,
                returnedStock: returnedStock,
                reservedStock: reservedStock,
                availableStock: availableStock,
                lastUpdatedAt: lastUpdatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tenantId = const Value.absent(),
                required String productId,
                Value<String?> supplierId = const Value.absent(),
                Value<int?> supplierStock = const Value.absent(),
                Value<int> returnedStock = const Value.absent(),
                Value<int> reservedStock = const Value.absent(),
                Value<int> availableStock = const Value.absent(),
                required DateTime lastUpdatedAt,
              }) => StockStateCompanion.insert(
                id: id,
                tenantId: tenantId,
                productId: productId,
                supplierId: supplierId,
                supplierStock: supplierStock,
                returnedStock: returnedStock,
                reservedStock: reservedStock,
                availableStock: availableStock,
                lastUpdatedAt: lastUpdatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockStateTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockStateTable,
      StockStateRow,
      $$StockStateTableFilterComposer,
      $$StockStateTableOrderingComposer,
      $$StockStateTableAnnotationComposer,
      $$StockStateTableCreateCompanionBuilder,
      $$StockStateTableUpdateCompanionBuilder,
      (
        StockStateRow,
        BaseReferences<_$AppDatabase, $StockStateTable, StockStateRow>,
      ),
      StockStateRow,
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
  $$MarketplaceAccountsTableTableManager get marketplaceAccounts =>
      $$MarketplaceAccountsTableTableManager(_db, _db.marketplaceAccounts);
  $$MessageThreadsTableTableManager get messageThreads =>
      $$MessageThreadsTableTableManager(_db, _db.messageThreads);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$ReturnsTableTableManager get returns =>
      $$ReturnsTableTableManager(_db, _db.returns);
  $$SupplierReturnPoliciesTableTableManager get supplierReturnPolicies =>
      $$SupplierReturnPoliciesTableTableManager(
        _db,
        _db.supplierReturnPolicies,
      );
  $$IncidentRecordsTableTableManager get incidentRecords =>
      $$IncidentRecordsTableTableManager(_db, _db.incidentRecords);
  $$ReturnedStocksTableTableManager get returnedStocks =>
      $$ReturnedStocksTableTableManager(_db, _db.returnedStocks);
  $$FinancialLedgerTableTableManager get financialLedger =>
      $$FinancialLedgerTableTableManager(_db, _db.financialLedger);
  $$FeatureFlagsTableTableManager get featureFlags =>
      $$FeatureFlagsTableTableManager(_db, _db.featureFlags);
  $$BackgroundJobsTableTableManager get backgroundJobs =>
      $$BackgroundJobsTableTableManager(_db, _db.backgroundJobs);
  $$DistributedLocksTableTableManager get distributedLocks =>
      $$DistributedLocksTableTableManager(_db, _db.distributedLocks);
  $$BillingPlansTableTableManager get billingPlans =>
      $$BillingPlansTableTableManager(_db, _db.billingPlans);
  $$TenantPlansTableTableManager get tenantPlans =>
      $$TenantPlansTableTableManager(_db, _db.tenantPlans);
  $$SupplierReliabilityScoresTableTableManager get supplierReliabilityScores =>
      $$SupplierReliabilityScoresTableTableManager(
        _db,
        _db.supplierReliabilityScores,
      );
  $$ListingHealthMetricsTableTableManager get listingHealthMetrics =>
      $$ListingHealthMetricsTableTableManager(_db, _db.listingHealthMetrics);
  $$CustomerMetricsTableTableManager get customerMetrics =>
      $$CustomerMetricsTableTableManager(_db, _db.customerMetrics);
  $$StockStateTableTableManager get stockState =>
      $$StockStateTableTableManager(_db, _db.stockState);
}
