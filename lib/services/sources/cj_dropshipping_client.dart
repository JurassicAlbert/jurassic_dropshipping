import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/app_error.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';

const _baseUrl = 'https://developers.cjdropshipping.com/api2.0/v1';
const _authUrl = 'https://developers.cjdropshipping.com/api2.0/v1/authentication/getAccessToken';

/// CJ Dropshipping API client. Uses CJ-Access-Token from secure storage or getAccessToken.
class CjDropshippingClient {
  CjDropshippingClient({
    required this.secureStorage,
    Dio? dio,
  }) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: const Duration(seconds: 15))) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.read(SecureKeys.cjAccessToken);
        if (token != null && token.isNotEmpty) {
          options.headers['CJ-Access-Token'] = token;
        }
        options.headers['Content-Type'] = 'application/json';
        handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          final newToken = await _refreshToken();
          if (newToken != null) {
            e.requestOptions.headers['CJ-Access-Token'] = newToken;
            final req = await _dio.fetch(e.requestOptions);
            return handler.resolve(req);
          }
        }
        handler.next(e);
      },
    ));
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => appLogger.d(obj),
    ));
  }

  final SecureStorageService secureStorage;
  final Dio _dio;

  Future<String?> _refreshToken() async {
    final email = await secureStorage.read(SecureKeys.cjEmail);
    final apiKey = await secureStorage.read(SecureKeys.cjApiKey);
    if (email == null || apiKey == null) return null;
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        _authUrl,
        data: {'email': email, 'apiKey': apiKey},
      );
      final data = res.data is Map ? res.data as Map<String, dynamic> : jsonDecode(res.data as String) as Map<String, dynamic>;
      final token = data['data']?['accessToken'] as String?;
      if (token != null) {
        await secureStorage.write(SecureKeys.cjAccessToken, token);
        final refresh = data['data']?['refreshToken'] as String?;
        if (refresh != null) await secureStorage.write(SecureKeys.cjRefreshToken, refresh);
        return token;
      }
    } catch (e, st) {
      appLogger.e('CJ refresh token failed', error: e, stackTrace: st);
    }
    return null;
  }

  /// Ensure we have a valid token (e.g. after app start). Call with email + apiKey if token missing.
  Future<bool> ensureToken({String? email, String? apiKey}) async {
    var token = await secureStorage.read(SecureKeys.cjAccessToken);
    if (token != null && token.isNotEmpty) return true;
    if (email != null && apiKey != null) {
      await secureStorage.write(SecureKeys.cjEmail, email);
      await secureStorage.write(SecureKeys.cjApiKey, apiKey);
      token = await _refreshToken();
    }
    return token != null && token.isNotEmpty;
  }

  /// GET /product/listV2. keyWord, page, size, countryCode, startSellPrice, endSellPrice.
  Future<CjProductListResponse> productListV2({
    String? keyWord,
    int page = 1,
    int size = 20,
    String? countryCode,
    double? startSellPrice,
    double? endSellPrice,
  }) async {
    final query = <String, dynamic>{
      'page': page,
      'size': size,
      if (keyWord?.isNotEmpty == true) 'keyWord': keyWord!,
      if (countryCode != null) 'countryCode': countryCode,
      if (startSellPrice != null) 'startSellPrice': startSellPrice,
      if (endSellPrice != null) 'endSellPrice': endSellPrice,
    };
    final res = await _dio.get<Map<String, dynamic>>(
      '/product/listV2',
      queryParameters: query,
    );
    final data = res.data;
    if (data == null || data['result'] != true) {
      throw ApiError(
        (data?['code'] is int) ? (data!['code'] as int) : 0,
        data?['message'] as String?,
      );
    }
    return CjProductListResponse.fromJson(data);
  }

  /// GET product by id (variant list). Use product detail endpoint if available; otherwise derive from list.
  Future<CjProductDetail?> getProductDetail(String productId) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/product/queryProductDetail',
        queryParameters: {'productId': productId},
      );
      final data = res.data;
      if (data == null || data['result'] != true) return null;
      final d = data['data'];
      if (d is! Map<String, dynamic>) return null;
      return CjProductDetail.fromJson(d);
    } catch (_) {
      return null;
    }
  }

  /// POST createOrderV2. Returns CJ orderId.
  Future<CjCreateOrderResponse> createOrderV2(CjCreateOrderRequest body) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/shopping/order/createOrderV2',
      data: body.toJson(),
    );
    final data = res.data;
    if (data == null || data['result'] != true) {
      throw ApiError(
        (data?['code'] is int) ? (data!['code'] as int) : 0,
        data?['message'] as String?,
      );
    }
    return CjCreateOrderResponse.fromJson(data);
  }
}

class CjProductListResponse {
  CjProductListResponse({
    required this.totalRecords,
    required this.content,
  });
  factory CjProductListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is! Map<String, dynamic>) return CjProductListResponse(totalRecords: 0, content: []);
    final content = data['content'] as List<dynamic>? ?? [];
    final total = data['totalRecords'] as int? ?? 0;
    final list = <CjProductItem>[];
    for (final c in content) {
      if (c is! Map<String, dynamic>) continue;
      final productList = c['productList'] as List<dynamic>?;
      if (productList == null) continue;
      for (final p in productList) {
        if (p is Map<String, dynamic>) list.add(CjProductItem.fromJson(p));
      }
    }
    return CjProductListResponse(totalRecords: total, content: list);
  }
  final int totalRecords;
  final List<CjProductItem> content;
}

class CjProductItem {
  CjProductItem({
    required this.id,
    required this.nameEn,
    required this.sellPrice,
    this.nowPrice,
    this.bigImage,
    this.description,
    this.deliveryCycle,
    this.sku,
    this.warehouseInventoryNum,
  });
  factory CjProductItem.fromJson(Map<String, dynamic> json) {
    final sell = json['sellPrice']?.toString();
    final now = json['nowPrice']?.toString();
    return CjProductItem(
      id: json['id'] as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
      sellPrice: double.tryParse(sell ?? '0') ?? 0,
      nowPrice: double.tryParse(now ?? '') ?? double.tryParse(sell ?? '0') ?? 0,
      bigImage: json['bigImage'] as String?,
      description: json['description'] as String?,
      deliveryCycle: json['deliveryCycle'] as String?,
      sku: json['sku'] as String?,
      warehouseInventoryNum: json['warehouseInventoryNum'] as int?,
    );
  }
  final String id;
  final String nameEn;
  final double sellPrice;
  final double? nowPrice;
  final String? bigImage;
  final String? description;
  final String? deliveryCycle;
  final String? sku;
  final int? warehouseInventoryNum;
}

class CjProductDetail {
  CjProductDetail({
    required this.id,
    this.variants = const [],
    this.imageList = const [],
  });
  factory CjProductDetail.fromJson(Map<String, dynamic> json) {
    final vList = json['variantList'] as List<dynamic>? ?? [];
    final variants = vList.map((e) => CjVariant.fromJson(e as Map<String, dynamic>)).toList();
    final imgList = json['imageList'] as List<dynamic>? ?? [];
    final imageList = imgList.map((e) => e.toString()).toList();
    return CjProductDetail(
      id: json['id'] as String? ?? '',
      variants: variants,
      imageList: imageList,
    );
  }
  final String id;
  final List<CjVariant> variants;
  final List<String> imageList;
}

class CjVariant {
  CjVariant({
    required this.vid,
    required this.sellPrice,
    this.sku,
    this.inventoryNum,
  });
  factory CjVariant.fromJson(Map<String, dynamic> json) {
    final sell = json['sellPrice']?.toString();
    return CjVariant(
      vid: json['vid'] as String? ?? json['id'] as String? ?? '',
      sellPrice: double.tryParse(sell ?? '0') ?? 0,
      sku: json['sku'] as String?,
      inventoryNum: json['inventoryNum'] as int? ?? json['warehouseInventoryNum'] as int?,
    );
  }
  final String vid;
  final double sellPrice;
  final String? sku;
  final int? inventoryNum;
}

class CjCreateOrderRequest {
  CjCreateOrderRequest({
    required this.orderNumber,
    required this.shippingCountryCode,
    required this.shippingCountry,
    required this.shippingProvince,
    required this.shippingCity,
    required this.shippingCustomerName,
    required this.shippingAddress,
    required this.shippingPhone,
    required this.shippingZip,
    required this.products,
    this.shippingAddress2,
    this.email,
    this.logisticName = 'Standard',
    this.fromCountryCode = 'CN',
    this.payType = 2,
    this.shopLogisticsType = 2,
  });
  final String orderNumber;
  final String shippingCountryCode;
  final String shippingCountry;
  final String shippingProvince;
  final String shippingCity;
  final String shippingCustomerName;
  final String shippingAddress;
  final String? shippingAddress2;
  final String shippingPhone;
  final String shippingZip;
  final String? email;
  final String logisticName;
  final String fromCountryCode;
  final int payType;
  final int shopLogisticsType;
  final List<CjOrderProduct> products;

  Map<String, dynamic> toJson() => {
        'orderNumber': orderNumber,
        'shippingCountryCode': shippingCountryCode,
        'shippingCountry': shippingCountry,
        'shippingProvince': shippingProvince,
        'shippingCity': shippingCity,
        'shippingCustomerName': shippingCustomerName,
        'shippingAddress': shippingAddress,
        if (shippingAddress2 != null) 'shippingAddress2': shippingAddress2,
        'shippingPhone': shippingPhone,
        'shippingZip': shippingZip,
        if (email != null) 'email': email,
        'logisticName': logisticName,
        'fromCountryCode': fromCountryCode,
        'payType': payType,
        'shopLogisticsType': shopLogisticsType,
        'products': products.map((e) => e.toJson()).toList(),
      };
}

class CjOrderProduct {
  CjOrderProduct({required this.vid, required this.quantity, this.storeLineItemId});
  final String vid;
  final int quantity;
  final String? storeLineItemId;
  Map<String, dynamic> toJson() => {
        'vid': vid,
        'quantity': quantity,
        if (storeLineItemId != null) 'storeLineItemId': storeLineItemId,
      };
}

class CjCreateOrderResponse {
  CjCreateOrderResponse({this.orderId, this.orderNumber});
  factory CjCreateOrderResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is! Map<String, dynamic>) return CjCreateOrderResponse();
    return CjCreateOrderResponse(
      orderId: data['orderId'] as String?,
      orderNumber: data['orderNumber'] as String?,
    );
  }
  final String? orderId;
  final String? orderNumber;
}
