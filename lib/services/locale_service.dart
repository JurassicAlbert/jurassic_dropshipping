import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const String _prefsBoxName = 'prefs';
const String _localeKey = 'locale';
const String _defaultLanguageCode = 'pl';

/// Persists and loads app locale (e.g. pl, en). Default is Polish.
class LocaleService {
  Future<Locale> getLocale() async {
    try {
      final box = await Hive.openBox(_prefsBoxName);
      final code = box.get(_localeKey, defaultValue: _defaultLanguageCode) as String;
      if (code == 'en' || code == 'pl') return Locale(code);
      return const Locale(_defaultLanguageCode);
    } catch (_) {
      return const Locale(_defaultLanguageCode);
    }
  }

  Future<void> setLocale(Locale locale) async {
    final code = locale.languageCode == 'en' ? 'en' : 'pl';
    try {
      final box = await Hive.openBox(_prefsBoxName);
      await box.put(_localeKey, code);
    } catch (_) {}
  }
}
