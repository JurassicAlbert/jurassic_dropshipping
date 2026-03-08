import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';

class AuthService {
  static const _boxName = 'auth';
  static const _hashKey = 'password_hash';
  static const _isLockedKey = 'is_locked';

  Future<bool> get isPasswordSet async {
    final box = await Hive.openBox(_boxName);
    return box.get(_hashKey) != null;
  }

  Future<bool> get isLocked async {
    final box = await Hive.openBox(_boxName);
    return box.get(_isLockedKey, defaultValue: true) as bool;
  }

  Future<void> setPassword(String password) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_hashKey, _hash(password));
    await box.put(_isLockedKey, false);
  }

  Future<bool> unlock(String password) async {
    final box = await Hive.openBox(_boxName);
    final stored = box.get(_hashKey) as String?;
    if (stored == null) return false;
    final match = stored == _hash(password);
    if (match) await box.put(_isLockedKey, false);
    return match;
  }

  Future<void> lock() async {
    final box = await Hive.openBox(_boxName);
    await box.put(_isLockedKey, true);
  }

  String _hash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
