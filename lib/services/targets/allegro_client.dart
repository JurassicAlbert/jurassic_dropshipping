import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';

const _baseUrl = 'https://api.allegro.pl';
const _tokenUrl = 'https://allegro.pl/auth/oauth/token';

/// Allegro REST API client. Uses OAuth2 access token from secure storage.
/// See: https://developer.allegro.pl/documentation/
class AllegroClient {
  AllegroClient({
    required this.secureStorage,
    Dio? dio,
  }) : _dio = dio ?? Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 15),
    headers: {
      'Accept': 'application/vnd.allegro.public.v1+json',
      'Content-Type': 'application/vnd.allegro.public.v1+json',
    },
  )) {
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

  /// PATCH /sale/product-offers/{offerId} - update price/stock.
  Future<void> updateOffer(String offerId, {double? price, int? stock}) async {
    final updates = <String, dynamic>{};
    if (price != null) updates['sellingMode'] = {'price': {'amount': price.toString()}};
    if (stock != null) updates['stock'] = {'available': stock};
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
