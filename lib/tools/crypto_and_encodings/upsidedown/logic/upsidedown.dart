// https://de.wikipedia.org/wiki/Upside_Down_Text

import 'package:gc_wizard/utils/collection_utils.dart';


final Map<String, String> UPSIDE_DOWN_ENCODE = {
  'A' : 'ɐ',
  'B' : 'q', // ok
  'C' : 'ɔ',
  'D' : 'p', // ok
  'E' : 'ǝ',
  'F' : 'ɟ',
  'G' : 'ƃ',
  'H' : 'ɥ',
  'I' : 'ᴉ',
  'J' : 'ɾ',
  'K' : 'ʞ',
  'L' : 'l',
  'M' : 'ɯ',
  'N' : 'u', // ok
  'O' : 'o', // ok
  'P' : 'd', // ok
  'Q' : 'b', // ok
  'R' : 'ɹ',
  'S' : 's', // ok
  'T' : 'ʇ',
  'U' : 'n', // ok
  'V' : 'ʌ',
  'W' : 'ʍ',
  'X' : 'x', // ok
  'Y' : 'ʎ',
  'Z' : 'z', // ok
  '.' : "'",
  '?' : '¿',
  '!' : '¡',
  '(' : '(',// ok
  ')' : ')',// ok
  '+' : '+',// ok
  '-' : '-',// ok
  '*' : '*',// ok
  '[' : '[',// ok
  ']' : ']',// ok
  '/' : '\\',// ok
  '\\' : '/',// ok
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