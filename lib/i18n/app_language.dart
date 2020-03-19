import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This is for settings
// appLanguage.changeLanguage(Locale("en"));

// from: https://medium.com/flutter-community/flutter-internationalization-the-easy-way-using-provider-and-json-c47caa4212b2
class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return null;
  }


  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }

    _appLocale = type;
    await prefs.setString('language_code', _appLocale.languageCode);
    await prefs.setString('countryCode', _appLocale.countryCode);

    notifyListeners();
  }
}