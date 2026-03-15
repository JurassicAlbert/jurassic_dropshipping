import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/services/dio_rate_limit_interceptor.dart';
import 'package:jurassic_dropshipping/services/dio_retry_interceptor.dart';
import 'package:jurassic_dropshipping/services/rate_limiter.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';

/// API2Cart unified ecommerce API client.
/// Connects to multiple store platforms (Shopify, WooCommerce, Magento, etc.)
/// through a single API.
class Api2CartClient {
  Api2CartClient({required this.secureStorage, Dio? dio, RateLimiter? rateLimiter})
      : _dio = dio ?? Dio(BaseOptions(
          baseUrl: 'https://api.api2cart.com/v1.1',
          connectTimeout: const Duration(seconds: 15),
        )) {
    _dio.interceptors.insert(0, RetryInterceptor());
    _dio.interceptors.add(RateLimitInterceptor(limiter: rateLimiter));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final apiKey = await secureStorage.read(SecureKeys.api2cartApiKey);
        final storeKey = await secureStorage.read(SecureKeys.api2cartStoreKey);
        if (apiKey != null) options.queryParameters['api_key'] = apiKey;
        if (storeKey != null) options.queryParameters['store_key'] = storeKey;
        handler.next(options);
      },
    ));
  }

  final SecureStorageService secureStorage;
  final Dio _dio;

  /// True if api_key and store_key are set. When false, callers should skip API calls.
  Future<bool> isConfigured() async {
    final apiKey = await secureStorage.read(SecureKeys.api2cartApiKey);
    final storeKey = await secureStorage.read(SecureKeys.api2cartStoreKey);
    return apiKey != null &&
        apiKey.isNotEmpty &&
        storeKey != null &&
        storeKey.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> searchProducts(String keyword, {int count = 50}) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('/product.list.json', queryParameters: {
        'params': 'id,name,price,images,quantity,weight',
        'count': count,
        'keyword': keyword,
      });
      final result = res.data?['result'] as Map<String, dynamic>?;
      final products = result?['product'] as List<dynamic>? ?? [];
      return products.map((e) => e as Map<String, dynamic>).toList();
    } catch (e, st) {
      appLogger.e('Api2Cart searchProducts failed', error: e, stackTrace: st);
      return [];
    }
  }

  Future<Map<String, dynamic>?> getProduct(String productId) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('/product.info.json', queryParameters: {
        'id': productId,
        'params': 'id,name,price,images,quantity,weight,description',
      });
      return res.data?['result'] as Map<String, dynamic>?;
    } catch (e, st) {
      appLogger.e('Api2Cart getProduct failed', error: e, stackTrace: st);
      return null;
    }
  }
}
