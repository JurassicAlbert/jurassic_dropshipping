import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keys for stored credentials. Values are stored in flutter_secure_storage.
abstract class SecureKeys {
  static const String cjAccessToken = 'cj_access_token';
  static const String cjRefreshToken = 'cj_refresh_token';
  static const String cjEmail = 'cj_email';
  static const String cjApiKey = 'cj_api_key';
  static const String allegroAccessToken = 'allegro_access_token';
  static const String allegroRefreshToken = 'allegro_refresh_token';
  static const String allegroClientId = 'allegro_client_id';
  static const String allegroClientSecret = 'allegro_client_secret';
}

/// Secure storage for API keys and tokens. Never log or expose these.
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  final FlutterSecureStorage _storage;

  Future<String?> read(String key) => _storage.read(key: key);
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);
  Future<void> delete(String key) => _storage.delete(key: key);
  Future<void> deleteAll() => _storage.deleteAll();
}
