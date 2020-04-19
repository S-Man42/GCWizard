import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:gc_wizard/logic/tools/crypto/rotator.dart';
import 'package:intl/intl.dart';

import 'alphabets.dart';
import 'constants.dart';

List<int> textToIntList(String text, {bool allowNegativeValues: false}) {
  var regex = allowNegativeValues ? RegExp(r'[^\-0-9]') : RegExp(r'[^0-9]');

  var list = text.split(regex);
  list.removeWhere((value) => value == null || value == '');

  return list.map((value) => value == '-' ? 0 : int.tryParse(value)).toList();
}

List<String> textToBinaryList(String text) {
  if (text == null || text.length == 0)
    return [];

  final regex = RegExp(r'[01]+');

  return regex.allMatches(text).map((value) => text.substring(value.start, value.end)).toList();
}

int extractIntegerFromText(String text) {
  var digits = text.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.length == 0)
    return null;

  return int.tryParse(digits);
}

String intListToString(List<int> list, {String delimiter: ''}) {
  return list.map((elem) => elem == null ? UNKNOWN_ELEMENT : elem).join(delimiter).trim();
}

String digitsToAlpha(String input, {int aValue: 0, bool removeNonDigits: true}) {
  if (input == null)
    return input;
  
  if (aValue == null)
    aValue = 0;

  if (removeNonDigits == null)
    removeNonDigits = false;
  
  final letters = Rotator().rotate(Rotator.defaultAlphabetAlpha, aValue);
  
  return input.split('').map((character) {
    var value = alphabet_09[character];
    
    if (value == null)
      if (removeNonDigits)
        return '';
      else
        return character;

    return letters[value];
  }).join();
}

String normalizeUmlauts(String input) {
  return input.split('').map((letter) {
    if (letter == String.fromCharCode(223)) //ß
      return 'ss';
    if (letter == String.fromCharCode(7838)) //Capital ß = ẞ
      return 'SS';

    var isLowerCase = letter == letter.toLowerCase();

    String out;
    switch (letter.toLowerCase().codeUnitAt(0)) {
      case 228: //ä
      case 230: //æ
        out = 'ae'; break;
      case 246: //ö
        out = 'oe'; break;
      case 252: //ü
        out = 'ue'; break;
      default:
        out = letter;
    }

    return isLowerCase ? out : out.toUpperCase();
  }).join();
}

String removeAccents(String text) {
  String out = normalizeUmlauts(text);
  return removeDiacritics(out);
}

String removeNonLetters(String text) {
  return text.replaceAll(RegExp(r'[^A-Za-z]'), '');
}

String insertCharacter(String text, int index, String character) {
  if (text == null || character == null)
    return text;

  if (index < 0)
    index = 0;

  if (index > text.length)
    index = text.length;

  return text.substring(0, index) + character + text.substring(index);
}

String insertSpaceEveryNthCharacter(String input, int n) {
  if (n == null || n <= 0)
    return input; //TODO Exception

  String out = '';
  int i = 0;
  while (i < input.length) {
    out += input.substring(i, min(i + n, input.length)) + ' ';
    i += n;
  }

  return out.trim();
}

String formatDaysToNearestUnit(double days) {
  var format = NumberFormat('0.00');

  if (days >= 365 * 1000000)
    return format.format(days / (365 * 1000000)) + ' Mio. a';
  if (days >= 365)
    return format.format(days / 365) + ' a';
  if (days >= 1)
    return format.format(days) + ' d';
  if (days >= 1 / 24)
    return format.format(days / (1 / 24)) + ' h';
  if (days >= 1 / 24 / 60)
    return format.format(days / (1 / 24 / 60)) + ' min';
  if (days >= 1 / 24 / 60 / 60)
    return format.format(days / (1 / 24 / 60 / 60)) + ' s';

  return format.format(days / (1 / 24 / 60 / 60 / 1000)) + ' ms';
}

double celsiusToKelvin(double celsius) {
  return celsius + 273.15;
}

double kelvinToFahrenheit(double kelvin) {
  return kelvin * 9 / 5 - 459.67;
}

double celsiusToFahrenheit(double celsius) {
  return kelvinToFahrenheit(celsiusToKelvin(celsius));
}

Map<U, T> switchMapKeyValue<T,U>(Map<T, U> map) {
  if (map == null)
    return null;

  return map.map((k, v) => MapEntry(v, k));
}

String stringToSuperscript(String text) {
  return text.split('').map((character) {
    var superscript = superscriptCharacters[character];
    return superscript ?? text;
  }).join();
}