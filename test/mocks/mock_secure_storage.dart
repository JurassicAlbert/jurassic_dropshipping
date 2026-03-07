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
