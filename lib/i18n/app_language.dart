import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/supported_locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This is for settings
// appLanguage.changeLanguage(Locale("en"));

// from: https://medium.com/flutter-community/flutter-internationalization-the-easy-way-using-provider-and-json-c47caa4212b2
class AppLanguage extends ChangeNotifier {

  static const Locale _defaultAppLocale = Locale(defaultLanguage); // Locale('en', 'US');
  Locale _appLocale = _defaultAppLocale;

  Locale get appLocal => _appLocale ?? _defaultAppLocale;
  Future<Locale> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = _defaultAppLocale;
      return _appLocale;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    //_appLocale = Locale(prefs.getString('language_code'), prefs.getString('countryCode'));
    return _appLocale;
  }

  void changeLocale(Locale locale) async {
    var prefs = await SharedPreferences.getInstance();
    //if (_appLocale == locale) {
    if (_appLocale.languageCode == locale.languageCode) {
      // no change
      return;
    }

    //_appLocale = locale;
    _appLocale = Locale(locale.languageCode);
    await prefs.setString('language_code', _appLocale.languageCode);
    //await prefs.setString('countryCode', _appLocale.countryCode);

    notifyListeners();
  }


  void changeLanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    changeLocale(locale);
  }


}