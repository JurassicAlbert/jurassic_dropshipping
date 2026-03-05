import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';

/// Temu Seller API client. 
/// Temu does not yet have a public seller API, so this is a forward-looking 
/// implementation that will be connected when the API becomes available.
/// For now it uses placeholder endpoints.
class TemuSellerClient {
  TemuSellerClient({required this.secureStorage, Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(
          baseUrl: 'https://seller.temu.com/api',
          connectTimeout: const Duration(seconds: 15),
        ));

  final SecureStorageService secureStorage;
  final Dio _dio;

  Future<String?> createListing(Map<String, dynamic> body) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>('/listings', data: body);
      return res.data?['id'] as String?;
    } catch (e, st) {
      appLogger.e('TemuSeller createListing failed', error: e, stackTrace: st);
      return null;
    }
  }

  Future<void> updateListing(String id, {double? price, int? stock}) async {
    final updates = <String, dynamic>{};
    if (price != null) updates['price'] = price;
    if (stock != null) updates['stock'] = stock;
    if (updates.isEmpty) return;
    await _dio.patch('/listings/$id', data: updates);
  }

  Future<List<Map<String, dynamic>>> getOrders({DateTime? since}) async {
    try {
      final query = <String, dynamic>{};
      if (since != null) query['since'] = since.toUtc().toIso8601String();
      final res = await _dio.get<Map<String, dynamic>>('/orders', queryParameters: query);
      return (res.data?['orders'] as List<dynamic>? ?? [])
          .map((e) => e as Map<String, dynamic>)
          .toList();
    } catch (e, st) {
      appLogger.e('TemuSeller getOrders failed', error: e, stackTrace: st);
      return [];
    }
  }

  Future<void> updateTracking(String orderId, String trackingNumber) async {
    await _dio.post('/orders/$orderId/tracking', data: {'trackingNumber': trackingNumber});
  }
}
