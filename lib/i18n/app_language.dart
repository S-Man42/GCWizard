import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This is for settings
// appLanguage.changeLanguage(Locale("en"));

// from: https://medium.com/flutter-community/flutter-internationalization-the-easy-way-using-provider-and-json-c47caa4212b2
class AppLanguage extends ChangeNotifier {
 // static const Locale _defaultAppLocale = Locale('en');
  static const Locale _defaultAppLocale = Locale('fr');
  Locale _appLocale = _defaultAppLocale;

  Locale get appLocal => _appLocale ?? _defaultAppLocale;
  Future<Locale> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = _defaultAppLocale;
      //_appLocale = Locale('en', 'US');
      return null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    //_appLocale = Locale(prefs.getString('language_code'), prefs.getString('countryCode'));
    return _appLocale;
  }
  // Future<Locale> fetchLocaleAndReturn() async {
  //   fetchLocale();
  //   return appLocal;
  // }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    //if (_appLocale == type) {
    // if (_appLocale.languageCode == type.languageCode) {
    //   return;
    // }

    //_appLocale = type;
    _appLocale = Locale(type.languageCode);
    await prefs.setString('language_code', _appLocale.languageCode);
    await prefs.setString('countryCode', _appLocale.countryCode);

    notifyListeners();
  }


}