// https://de.wikipedia.org/wiki/Upside_Down_Text
// https://fonts.webtoolhub.com/font-n34162-quirkus-upside-down.aspx?lic=1
// Dieses Werk ist unter einem Creative Commons Namensnennung 3.0 Deutschland Lizenzvertrag lizenziert.
// Copyright (c) 2009 by Peter Wiegel Licensed under Creative Commons Attribution 3.0 Germany, This Font is "E-Mail-Ware" Please mail your comment or donate via PayPal to wiegel@peter-wiegel.de

import 'package:gc_wizard/utils/collection_utils.dart';


final Map<String, String> UPSIDE_DOWN_ENCODE = {
  'A' : 'ɐ', // U+0250 ollɐɥ
  'B' : 'q', // ok
  'C' : 'ɔ',
  'D' : 'p', // ok
  'E' : 'ǝ',
  'F' : 'ɟ',
  'G' : 'ƃ',
  'H' : 'ɥ', // U+0265
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
  return chiffre.split('').reversed.toList().join('');
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
  return plain.split('').reversed.toList().join('');
  return plain.toUpperCase().split('').reversed.map((letter) {
     if (UPSIDE_DOWN_ENCODE[letter] == null) {
           return '';
     } else {
           return UPSIDE_DOWN_ENCODE[letter];
     }
    }).toList().join('');

}