import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jurassic_dropshipping/core/logger.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

const _authUrl = 'https://allegro.pl/auth/oauth/authorize';
const _tokenUrl = 'https://allegro.pl/auth/oauth/token';
const _redirectPort = 8642;
const _redirectPath = '/allegro/callback';

/// Handles the Allegro OAuth2 authorization code flow.
///
/// 1. Opens the user's browser to the Allegro consent page.
/// 2. Starts a temporary local HTTP server on [_redirectPort] to receive the callback.
/// 3. Exchanges the authorization code for access + refresh tokens.
/// 4. Stores tokens in [SecureStorageService].
class AllegroOAuthService {
  AllegroOAuthService({required this.secureStorage, Dio? dio})
      : _dio = dio ?? Dio();

  final SecureStorageService secureStorage;
  final Dio _dio;

  String get redirectUri => 'http://localhost:$_redirectPort$_redirectPath';

  /// Run the full OAuth flow. Returns `true` on success.
  Future<bool> authorize() async {
    final clientId = await secureStorage.read(SecureKeys.allegroClientId);
    final clientSecret = await secureStorage.read(SecureKeys.allegroClientSecret);
    if (clientId == null || clientSecret == null || clientId.isEmpty || clientSecret.isEmpty) {
      appLogger.w('AllegroOAuth: client ID or secret not set');
      return false;
    }

    final authUri = Uri.parse(_authUrl).replace(queryParameters: {
      'response_type': 'code',
      'client_id': clientId,
      'redirect_uri': redirectUri,
    });

    HttpServer? server;
    try {
      server = await HttpServer.bind(InternetAddress.loopbackIPv4, _redirectPort);
      appLogger.i('AllegroOAuth: listening on $redirectUri');

      final launched = await launchUrl(authUri, mode: LaunchMode.externalApplication);
      if (!launched) {
        appLogger.w('AllegroOAuth: could not launch browser');
        await server.close();
        return false;
      }

      final request = await server.first.timeout(
        const Duration(minutes: 5),
        onTimeout: () => throw TimeoutException('User did not complete OAuth in time'),
      );

      final code = request.uri.queryParameters['code'];
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.html
        ..write('<html><body><h2>Allegro connected!</h2>'
            '<p>You can close this tab and return to the app.</p></body></html>');
      await request.response.close();
      await server.close();
      server = null;

      if (code == null || code.isEmpty) {
        appLogger.w('AllegroOAuth: no code in redirect');
        return false;
      }

      return _exchangeCode(code, clientId, clientSecret);
    } catch (e, st) {
      appLogger.e('AllegroOAuth failed', error: e, stackTrace: st);
      await server?.close();
      return false;
    }
  }

  Future<bool> _exchangeCode(String code, String clientId, String clientSecret) async {
    try {
      final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));
      final res = await _dio.post<Map<String, dynamic>>(
        _tokenUrl,
        data: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': redirectUri,
        },
        options: Options(
          headers: {
            'Authorization': 'Basic $credentials',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      final data = res.data;
      if (data == null) return false;

      final accessToken = data['access_token'] as String?;
      final refreshToken = data['refresh_token'] as String?;
      if (accessToken == null) return false;

      await secureStorage.write(SecureKeys.allegroAccessToken, accessToken);
      if (refreshToken != null) {
        await secureStorage.write(SecureKeys.allegroRefreshToken, refreshToken);
      }
      appLogger.i('AllegroOAuth: tokens stored');
      return true;
    } catch (e, st) {
      appLogger.e('AllegroOAuth: token exchange failed', error: e, stackTrace: st);
      return false;
    }
  }
}

class TimeoutException implements Exception {
  TimeoutException(this.message);
  final String message;
  @override
  String toString() => 'TimeoutException: $message';
}
