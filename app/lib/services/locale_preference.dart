import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Which language the app should use.
enum LanguagePreference {
  /// Follow the device language (English when it is not supported).
  system,

  /// Always English.
  english,

  /// Always Spanish.
  spanish,
}

extension LanguagePreferenceX on LanguagePreference {
  /// The forced locale, or null to follow the device.
  Locale? get locale {
    switch (this) {
      case LanguagePreference.system:
        return null;
      case LanguagePreference.english:
        return const Locale('en');
      case LanguagePreference.spanish:
        return const Locale('es');
    }
  }

  static LanguagePreference parse(String? raw) {
    switch (raw) {
      case 'english':
        return LanguagePreference.english;
      case 'spanish':
        return LanguagePreference.spanish;
      case 'system':
      default:
        return LanguagePreference.system;
    }
  }
}

/// Persists the language choice and notifies [MaterialApp] so it switches live.
class LocalePreferenceService {
  LocalePreferenceService._();

  static const String _key = 'language_preference';

  /// Live value. Missing keys mean [LanguagePreference.system].
  static final ValueNotifier<LanguagePreference> preference =
      ValueNotifier<LanguagePreference>(LanguagePreference.system);

  static Future<LanguagePreference> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final LanguagePreference value =
        LanguagePreferenceX.parse(prefs.getString(_key));
    preference.value = value;
    return value;
  }

  static Future<void> setPreference(LanguagePreference value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, value.name);
    preference.value = value;
  }
}
