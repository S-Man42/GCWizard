import 'dart:math';
import 'package:collection/collection.dart';
import 'package:quiver/pattern.dart';
import 'package:gc_wizard/logic/tools/crypto/rotator.dart';
import 'package:diacritic/diacritic.dart';
import 'constants.dart';
import 'alphabets.dart';

List<int> textToIntList(String text, {bool allowNegativeValues: false}) {
  var regex = allowNegativeValues ? RegExp(r'[^\-0-9]') : RegExp(r'[^0-9]');

  var list = text.split(regex);
  list.removeWhere((value) => value == null || value == '');

  return list.map((value) => value == '-' ? 0 : int.tryParse(value)).toList();
}

int extractIntegerFromText(String text) {
  var digits = text.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.length == 0)
    return null;

  return int.tryParse(digits);
}

String intListToString(List<int> list, {String delimiter: ''}) {
  return list.map((elem) => elem == null ? unknownElement : elem).join(delimiter).trim();
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