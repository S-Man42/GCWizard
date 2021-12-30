import 'package:flutter/material.dart';

final SUPPORTED_LOCALES = [
  Locale('cz'),
  Locale('da'),
  Locale('de'),
  Locale('el'),
  Locale('en'),
  Locale('es'),
  Locale('fi'),
  Locale('fr'),
  Locale('it'),
  Locale('ko'),
  Locale('nl'),
  Locale('pl'),
  Locale('pt'),
  Locale('ru'),
  Locale('sk'),
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
