// https://de.wikipedia.org/wiki/Leetspeak

import 'package:gc_wizard/utils/collection_utils.dart';


final Map<String, String> UPSIDE_DOWN_ENCODE = {
  'A' : 'ɐ',
  'B' : 'q',
  'C' : 'ɔ',
  'D' : 'p',
  'E' : 'ǝ',
  'F' : 'ɟ',
  'G' : 'ƃ',
  'H' : 'ɥ',
  'I' : 'ᴉ',
  'J' : 'ɾ',
  'K' : 'ʞ',
  'L' : 'l',
  'M' : 'ɯ',
  'N' : 'u',
  'O' : 'o',
  'P' : 'd',
  'Q' : 'b',
  'R' : 'ɹ',
  'S' : 's',
  'T' : 'ʇ',
  'U' : 'n',
  'V' : 'ʌ',
  'W' : 'ʍ',
  'X' : 'x',
  'Y' : 'ʎ',
  'Z' : 'z',
  '.' : "'",
  '?' : '¿',
  '!' : '¡',
  '(' : '(',
  ')' : ')',
  '+' : '+',
  '-' : '-',
  '*' : '*',
  '[' : '[',
  ']' : ']',
  '/' : '\\',
  '\\' : '/',
  ' ' : ' ',
};



String decodeUpsideDownText(String chiffre){

  Map<String, String> UPSIDE_DOWN_DECODE = switchMapKeyValue(UPSIDE_DOWN_ENCODE);
  return chiffre.split('').reversed.map((letter) {
    if (UPSIDE_DOWN_DECODE[letter] == null) {
          return '';
        } else {
          return UPSIDE_DOWN_DECODE[letter];
        }
      }).toList().join('');

}

String encodeUpsideDownText(String plain){

  return plain.toUpperCase().split('').reversed.map((letter) {
    if (UPSIDE_DOWN_ENCODE[letter] == null) {
          return '';
        } else {
          return UPSIDE_DOWN_ENCODE[letter];
        }
      }).toList().join('');

}