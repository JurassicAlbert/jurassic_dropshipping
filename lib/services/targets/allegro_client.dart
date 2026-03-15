import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/dio_rate_limit_interceptor.dart';
import 'package:jurassic_dropshipping/services/dio_retry_interceptor.dart';
import 'package:jurassic_dropshipping/services/rate_limiter.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';

const _baseUrl = 'https://api.allegro.pl';
const _tokenUrl = 'https://allegro.pl/auth/oauth/token';

/// Headers for Allegro BETA endpoints (e.g. customer returns).
const _betaHeaders = {
  'Accept': 'application/vnd.allegro.beta.v1+json',
  'Content-Type': 'application/vnd.allegro.beta.v1+json',
};

/// Allegro REST API client. Uses OAuth2 access token from secure storage.
/// See: https://developer.allegro.pl/documentation/
class AllegroClient {
  AllegroClient({
    required this.secureStorage,
    Dio? dio,
    RateLimiter? rateLimiter,
  }) : _dio = dio ?? Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 15),
    headers: {
      'Accept': 'application/vnd.allegro.public.v1+json',
      'Content-Type': 'application/vnd.allegro.public.v1+json',
    },
  )) {
    _dio.interceptors.insert(0, RetryInterceptor());
    _dio.interceptors.add(RateLimitInterceptor(limiter: rateLimiter));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.read(SecureKeys.allegroAccessToken);
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            final token = await secureStorage.read(SecureKeys.allegroAccessToken);
            if (token != null) {
              e.requestOptions.headers['Authorization'] = 'Bearer $token';
              final req = await _dio.fetch(e.requestOptions);
              return handler.resolve(req);
            }
          }
        }
        handler.next(e);
      },
    ));
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: false,
      logPrint: (obj) => appLogger.d(obj),
    ));
  }

  final SecureStorageService secureStorage;
  final Dio _dio;

  Future<bool> _refreshToken() async {
    final refresh = await secureStorage.read(SecureKeys.allegroRefreshToken);
    final clientId = await secureStorage.read(SecureKeys.allegroClientId);
    final clientSecret = await secureStorage.read(SecureKeys.allegroClientSecret);
    if (refresh == null || clientId == null || clientSecret == null) return false;
    try {
      final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));
      final res = await _dio.post<Map<String, dynamic>>(
        _tokenUrl,
        data: 'grant_type=refresh_token&refresh_token=${Uri.encodeComponent(refresh)}',
        options: Options(
          headers: {'Authorization': 'Basic $credentials', 'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      final data = res.data;
      if (data == null) return false;
      final access = data['access_token'] as String?;
      final newRefresh = data['refresh_token'] as String?;
      if (access != null) {
        await secureStorage.write(SecureKeys.allegroAccessToken, access);
        if (newRefresh != null) await secureStorage.write(SecureKeys.allegroRefreshToken, newRefresh);
        return true;
      }
    } catch (e, st) {
      appLogger.e('Allegro refresh token failed', error: e, stackTrace: st);
    }
    return false;
  }

  /// True if credentials are set (access token or client id+secret for OAuth). When false, callers should skip API calls.
  Future<bool> isConfigured() async {
    final token = await secureStorage.read(SecureKeys.allegroAccessToken);
    if (token != null && token.isNotEmpty) return true;
    final clientId = await secureStorage.read(SecureKeys.allegroClientId);
    final clientSecret = await secureStorage.read(SecureKeys.allegroClientSecret);
    return clientId != null &&
        clientId.isNotEmpty &&
        clientSecret != null &&
        clientSecret.isNotEmpty;
  }

  /// Store tokens after OAuth flow (e.g. user pastes or we get from redirect).
  Future<void> setTokens({required String accessToken, String? refreshToken}) async {
    await secureStorage.write(SecureKeys.allegroAccessToken, accessToken);
    if (refreshToken != null) await secureStorage.write(SecureKeys.allegroRefreshToken, refreshToken);
  }

  /// GET /order/checkout-forms. Returns list of order IDs or full payload.
  Future<AllegroCheckoutFormsResponse> getCheckoutForms({DateTime? since}) async {
    final query = <String, dynamic>{};
    if (since != null) query['from'] = since.toUtc().toIso8601String();
    final res = await _dio.get<Map<String, dynamic>>(
      '/order/checkout-forms',
      queryParameters: query.isEmpty ? null : query,
    );
    final data = res.data ?? {};
    return AllegroCheckoutFormsResponse.fromJson(data);
  }

  /// GET /order/checkout-forms/{id}
  Future<Map<String, dynamic>?> getCheckoutForm(String orderId) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('/order/checkout-forms/$orderId');
      return res.data;
    } catch (_) {
      return null;
    }
  }

  /// POST /sale/offers - create offer. Returns offer id.
  Future<String?> createOffer(Map<String, dynamic> body) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>('/sale/offers', data: body);
      final id = res.data?['id'] as String?;
      return id;
    } catch (e, st) {
      appLogger.e('Allegro createOffer failed', error: e, stackTrace: st);
      return null;
    }
  }

  /// PATCH /sale/product-offers/{offerId} - update price/stock/name/description.
  Future<void> updateOffer(String offerId, {double? price, int? stock, String? title, String? description}) async {
    final updates = <String, dynamic>{};
    if (price != null) updates['sellingMode'] = {'price': {'amount': price.toString()}};
    if (stock != null) updates['stock'] = {'available': stock};
    if (title != null) updates['name'] = title;
    if (description != null) updates['description'] = {'sections': [{'items': [{'type': 'TEXT', 'content': description}]}]};
    if (updates.isEmpty) return;
    await _dio.patch<Map<String, dynamic>>('/sale/product-offers/$offerId', data: updates);
  }

  /// POST /order/checkout-forms/{orderId}/fulfillment or shipments - set tracking.
  Future<void> setShipmentTracking(String orderId, String trackingNumber, String carrierCode) async {
    try {
      await _dio.post(
        '/order/checkout-forms/$orderId/shipments',
        data: {
          'carrierId': carrierCode,
          'waybill': trackingNumber,
        },
      );
    } catch (e, st) {
      appLogger.e('Allegro setShipmentTracking failed', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// PUT /order/checkout-forms/{id}/fulfillment - set fulfillment status (e.g. CANCELLED).
  Future<void> putFulfillmentStatus(String orderId, String status) async {
    try {
      await _dio.put<Map<String, dynamic>>(
        '/order/checkout-forms/$orderId/fulfillment',
        data: {'status': status},
      );
    } catch (e, st) {
      appLogger.e('Allegro putFulfillmentStatus failed', error: e, stackTrace: st);
      rethrow;
    }
  }

  // --- Phase 12: Customer returns (BETA) ---

  /// GET /order/customer-returns. Returns list of customer returns.
  Future<List<CustomerReturnSummary>> getCustomerReturns({String? orderId, DateTime? createdAtGte, int limit = 50, int offset = 0}) async {
    try {
      final query = <String, dynamic>{'limit': limit, 'offset': offset};
      if (orderId != null) query['orderId'] = orderId;
      if (createdAtGte != null) query['createdAt.gte'] = createdAtGte.toUtc().toIso8601String();
      final res = await _dio.get<Map<String, dynamic>>(
        '/order/customer-returns',
        queryParameters: query,
        options: Options(headers: _betaHeaders),
      );
      final data = res.data ?? {};
      final list = data['customerReturns'] as List<dynamic>? ?? [];
      return list.map((e) => _parseCustomerReturnSummary(e as Map<String, dynamic>)).toList();
    } catch (e, st) {
      appLogger.e('Allegro getCustomerReturns failed', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// GET /order/customer-returns/{id}.
  Future<CustomerReturnDetails?> getCustomerReturn(String customerReturnId) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/order/customer-returns/$customerReturnId',
        options: Options(headers: _betaHeaders),
      );
      final data = res.data;
      return data != null ? _parseCustomerReturnDetails(data) : null;
    } catch (e, st) {
      appLogger.e('Allegro getCustomerReturn failed', error: e, stackTrace: st);
      return null;
    }
  }

  /// POST /order/customer-returns/{id}/rejection.
  Future<void> rejectCustomerReturn(String customerReturnId, String reason) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        '/order/customer-returns/$customerReturnId/rejection',
        data: {'rejection': {'code': 'REFUND_REJECTED', 'reason': reason}},
        options: Options(headers: _betaHeaders),
      );
    } catch (e, st) {
      appLogger.e('Allegro rejectCustomerReturn failed', error: e, stackTrace: st);
      rethrow;
    }
  }

  static CustomerReturnSummary _parseCustomerReturnSummary(Map<String, dynamic> m) {
    return CustomerReturnSummary(
      id: m['id'] as String? ?? '',
      orderId: m['orderId'] as String? ?? '',
      status: m['status'] as String? ?? 'UNKNOWN',
      createdAt: _parseDateTime(m['createdAt']),
      referenceNumber: m['referenceNumber'] as String?,
    );
  }

  static CustomerReturnDetails _parseCustomerReturnDetails(Map<String, dynamic> m) {
    final items = (m['items'] as List<dynamic>?)?.map((e) {
      final i = e as Map<String, dynamic>;
      final reason = i['reason'] as Map<String, dynamic>?;
      return CustomerReturnItem(
        offerId: i['offerId']?.toString() ?? '',
        quantity: (i['quantity'] as num?)?.toInt() ?? 1,
        name: i['name'] as String?,
        reasonType: reason?['type'] as String?,
        userComment: reason?['userComment'] as String?,
      );
    }).toList() ?? [];
    final rejection = m['rejection'] as Map<String, dynamic>?;
    return CustomerReturnDetails(
      id: m['id'] as String? ?? '',
      orderId: m['orderId'] as String? ?? '',
      status: m['status'] as String? ?? 'UNKNOWN',
      createdAt: _parseDateTime(m['createdAt']),
      referenceNumber: m['referenceNumber'] as String?,
      items: items,
      rejectionReason: rejection?['reason'] as String?,
    );
  }

  static DateTime? _parseDateTime(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    return DateTime.tryParse(v.toString());
  }

  // --- Phase 12: Refunds ---

  /// GET /payments/refunds. Filter by order.id to get refunds for an order.
  Future<List<Map<String, dynamic>>> getRefunds({String? orderId, int limit = 50, int offset = 0}) async {
    try {
      final query = <String, dynamic>{'limit': limit, 'offset': offset};
      if (orderId != null) query['order.id'] = orderId;
      final res = await _dio.get<Map<String, dynamic>>('/payments/refunds', queryParameters: query);
      final data = res.data ?? {};
      final list = data['refunds'] as List<dynamic>? ?? [];
      return list.map((e) => e as Map<String, dynamic>).toList();
    } catch (e, st) {
      appLogger.e('Allegro getRefunds failed', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// POST /payments/refunds. Initiates a refund. Needs payment.id and order.id from checkout form; lineItems from form lineItems.
  /// Returns refund id or null on failure.
  Future<String?> createRefund({
    required String paymentId,
    required String orderId,
    required String reason,
    List<Map<String, dynamic>>? lineItems,
    String? sellerComment,
  }) async {
    try {
      final body = <String, dynamic>{
        'payment': {'id': paymentId},
        'order': {'id': orderId},
        'commandId': 'refund_${DateTime.now().millisecondsSinceEpoch}',
        'reason': reason,
      };
      if (lineItems != null && lineItems.isNotEmpty) body['lineItems'] = lineItems;
      if (sellerComment != null) body['sellerComment'] = sellerComment;
      final res = await _dio.post<Map<String, dynamic>>('/payments/refunds', data: body);
      final id = res.data?['id'] as String?;
      return id;
    } catch (e, st) {
      appLogger.e('Allegro createRefund failed', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// GET listing offers by phrase (and optional category) for competitor pricing.
  /// Returns the lowest price found in the first page, or null if unavailable/error.
  Future<double?> getListingOffersLowestPrice(String phrase, {String? categoryId}) async {
    try {
      final query = <String, dynamic>{'phrase': phrase};
      if (categoryId != null && categoryId.isNotEmpty) query['category.id'] = categoryId;
      final res = await _dio.get<Map<String, dynamic>>(
        '/offers/listing',
        queryParameters: query,
      );
      final data = res.data;
      if (data == null) return null;
      final items = data['items'] as List<dynamic>? ?? data['offers'] as List<dynamic>? ?? [];
      double? lowest;
      for (final item in items) {
        if (item is! Map<String, dynamic>) continue;
        final selling = item['sellingMode'] as Map<String, dynamic>?;
        if (selling == null) continue;
        final price = selling['price'] as Map<String, dynamic>?;
        final amount = price?['amount'] ?? price?['value'];
        if (amount == null) continue;
        final value = double.tryParse(amount.toString());
        if (value != null && (lowest == null || value < lowest)) lowest = value;
      }
      return lowest;
    } catch (e, st) {
      appLogger.d('Allegro getListingOffersLowestPrice failed', error: e, stackTrace: st);
      return null;
    }
  }
}

class AllegroCheckoutFormsResponse {
  AllegroCheckoutFormsResponse({this.checkoutForms = const []});
  factory AllegroCheckoutFormsResponse.fromJson(Map<String, dynamic> json) {
    final list = json['checkoutForms'] as List<dynamic>? ?? [];
    return AllegroCheckoutFormsResponse(
      checkoutForms: list.map((e) => e as Map<String, dynamic>).toList(),
    );
  }
  final List<Map<String, dynamic>> checkoutForms;
}
