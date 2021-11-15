import 'package:flutter/material.dart';

final SUPPORTED_LOCALES = [
  Locale('da'),
  Locale('de'),
  Locale('en'),
  Locale('es'),
  Locale('fr'),
  Locale('it'),
  Locale('ko'),
  Locale('nl'),
  Locale('pl'),
  Locale('ru'),
  Locale('tr'),
];
const String defaultLanguage = 'en';

final SUPPORTED_HELPLOCALES = ['en', 'de', 'fr'];

///
///  Control if locale is supported
///
bool isLocaleSupported(Locale locale) {
  // Include all of your supported language codes here
  return SUPPORTED_LOCALES.map((locale) => locale.languageCode).toList().contains(locale.languageCode);
}
