import 'package:flutter/material.dart';

final Map<Locale, Map<String, dynamic>> SUPPORTED_LOCALES = {
  Locale('cz'): {'name_native': '🇨🇿 Čeština', 'percent_translated': 11},
  Locale('da'): {'name_native': '🇩🇰 Dansk', 'percent_translated': 2},
  Locale('de'): {'name_native': '🇩🇪 Deutsch', 'percent_translated': 100},
  Locale('el'): {'name_native': '🇬🇷 Ελληνικά', 'percent_translated': 5},
  Locale('en'): {'name_native': '🇬🇧🇺🇸 English', 'percent_translated': 100},
  Locale('es'): {'name_native': '🇪🇸 Español', 'percent_translated': 6},
  Locale('fi'): {'name_native': '🇫🇮 Suomi', 'percent_translated': 54},
  Locale('fr'): {'name_native': '🇫🇷 Français', 'percent_translated': 87},
  Locale('it'): {'name_native': '🇮🇹 Italiano', 'percent_translated': 9},
  Locale('ko'): {'name_native': '🇰🇷 한국어', 'percent_translated': 83},
  Locale('nl'): {'name_native': '🇳🇱 Nederlands', 'percent_translated': 100},
  Locale('pl'): {'name_native': '🇵🇱 Polski', 'percent_translated': 53},
  Locale('pt'): {'name_native': '🇵🇹 Português', 'percent_translated': 19},
  Locale('ru'): {'name_native': '🇷🇺 Ру́сский', 'percent_translated': 6},
  Locale('sk'): {'name_native': '🇸🇰 Slovenský', 'percent_translated': 92},
  Locale('sv'): {'name_native': '🇸🇪 Svenska', 'percent_translated': 93},
  Locale('tr'): {'name_native': '🇹🇷 Türkçe', 'percent_translated': 11},
};

const Locale DEFAULT_LOCALE = Locale('en');

final SUPPORTED_HELPLOCALES = ['en', 'de'];

///
///  Control if locale is supported
///
bool isLocaleSupported(Locale locale) {
  // Include all of your supported language codes here
  return SUPPORTED_LOCALES.containsKey(locale);
}
