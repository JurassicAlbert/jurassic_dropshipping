import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/services/allegro_oauth_service.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';

class MockSecureStorage extends SecureStorageService {
  final Map<String, String> _store = {};

  MockSecureStorage() : super(storage: null);

  @override
  Future<String?> read(String key) async => _store[key];

  @override
  Future<void> write(String key, String value) async => _store[key] = value;

  @override
  Future<void> delete(String key) async => _store.remove(key);

  @override
  Future<void> deleteAll() async => _store.clear();
}

void main() {
  group('AllegroOAuthService', () {
    test('redirectUri returns expected value', () {
      final storage = MockSecureStorage();
      final service = AllegroOAuthService(secureStorage: storage);

      expect(service.redirectUri, 'http://localhost:8642/allegro/callback');
    });

    test('authorize returns false when client ID is missing', () async {
      final storage = MockSecureStorage();
      await storage.write(SecureKeys.allegroClientSecret, 'test_secret');

      final service = AllegroOAuthService(secureStorage: storage);
      final result = await service.authorize();

      expect(result, isFalse);
    });

    test('authorize returns false when client secret is missing', () async {
      final storage = MockSecureStorage();
      await storage.write(SecureKeys.allegroClientId, 'test_client_id');

      final service = AllegroOAuthService(secureStorage: storage);
      final result = await service.authorize();

      expect(result, isFalse);
    });
  });
}
