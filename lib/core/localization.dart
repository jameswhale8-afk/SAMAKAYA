import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  static const String _langKey = 'selected_language';
  static Map<String, dynamic> _strings = {};
  static String _currentLang = 'en';

  static Future<void> load(String langCode) async {
    _currentLang = langCode;
    final jsonString = await rootBundle.loadString('assets/i18n/$langCode.json');
    _strings = json.decode(jsonString);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, langCode);
  }

  static Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString(_langKey) ?? 'en';
    await load(lang);
  }

  static String get(String key, {Map<String, String>? params}) {
    var value = _strings[key] as String? ?? key;
    if (params != null) {
      for (final entry in params.entries) {
        value = value.replaceAll('{${entry.key}}', entry.value);
      }
    }
    return value;
  }

  static String get currentLang => _currentLang;
}