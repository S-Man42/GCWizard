import 'dart:convert';

import 'package:base32/base32.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ascii85.dart';

final Map<String, Function> BASE_FUNCTIONS = {
  'base_base16': decodeBase16,
  'base_base32': decodeBase32,
  'base_base64': decodeBase64,
  'base_base58': decodeBase58,
  'base_base85': decodeBase85,
  'base_base91': decodeBase91,
  'base_base122': decodeBase122,
};

String decodeBase16(String input) {
  if (input == null || input == '') return '';

  return List.generate(input.length, (i) => i % 2 == 0 ? input.substring(i, i + 2) : null)
      .where((b) => b != null && RegExp(r'[0-9A-Fa-f]{2}').hasMatch(b))
      .map((b) => String.fromCharCode(int.parse(b, radix: 16)))
      .toList()
      .join();
}

String encodeBase16(String input) {
  if (input == null || input == '') return '';

  return input.codeUnits.map((codeUnit) => codeUnit.toRadixString(16).padLeft(2, '0')).join();
}

String encodeBase32(String input) {
  if (input == null || input == '') return '';

  return base32.encodeString(input);
}

String decodeBase32(String input) {
  if (input == null || input == '') return '';

  var out = '';

  //if there's no result, try with appended =
  for (int i = 0; i <= 1; i++) {
    try {
      out = base32.decodeAsString(input + '=' * i);

      if (out.length > 0) break;
    } on FormatException {}
  }

  return out;
}

String encodeBase64(String input) {
  if (input == null || input == '') return '';

  return base64.encode(utf8.encode(input));
}

String decodeBase64(String input) {
  if (input == null || input == '') return '';

  var out = '';

  //if there's no result, try with appended = or ==
  for (int i = 0; i <= 2; i++) {
    try {
      out = utf8.decode(base64.decode(input + '=' * i));

      if (out.length > 0) break;
    } on FormatException {}
  }

  return out;
}

String encodeBase85(String input) {
  if (input == null || input == '') return '';

  var encoded = encodeASCII85(utf8.encode(input));

  if (encoded == null) return '';

  return '<~' + encoded + '~>';
}

String decodeBase85(String input) {
  if (input == null || input == '') return '';

  if (input.startsWith('<~')) input = input.substring(2);

  if (input.endsWith('~>')) input = input.substring(0, input.length - 2);

  var decoded = decodeASCII85(input);
  return utf8.decode(decoded == null ? [] : decoded);
}

String decode(String input, Function function) {
  var output = '';
  if (input.length == 0) return output;

  while (input.length > 0) {
    try {
      output = function(input);

      if (output.length == 0 && input.length > 0) throw FormatException();

      break;
    } on FormatException {
      return decode(input.substring(0, input.length - 1), function);
    } on RangeError {
      return decode(input.substring(0, input.length - 1), function);
    }
  }

  return output;
}

String encodeBase58(String input){
  // https://www.darklaunch.com/base58-encode-and-decode-using-php-with-example-base58-encode-base58-decode.html
  if (input == null || input == '' || int.tryParse(input) == null) return '';

  int num = int.parse(input);
  String alphabet = '123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';
  int base_count = alphabet.length;
  int div = 0;
  int mod = 0;
  String encoded = '';

  while(num >= base_count) {
    div = num ~/ base_count;
    mod = num % base_count;
    encoded = encoded + alphabet[mod];
    num = div;
  }
  if (num > 0)
    encoded = encoded + alphabet[num];

  return encoded.split('').reversed.join('');
}

String decodeBase58(String num){
  // https://www.darklaunch.com/base58-encode-and-decode-using-php-with-example-base58-encode-base58-decode.html
  if (num == null || num == '') return '';

  String alphabet = '123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';
  int len = num.toString().length;
  int multi = 1;
  int decoded = 0;

  for (int i = len - 1; i >= 0; i--) {
    decoded = decoded + multi * _strPos(alphabet, num.toString()[i]);
    multi = multi * alphabet.length;
  }
  return decoded.toString();
}

List<String> b91_enctab = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '!', '#', '\$', '%', '&', '(', ')', '*', '+', ',', '.', '/', ':', ';', '<', '=',
  '>', '?', '@', '[', ']', '^', '_', '`', '{', '|', '}', '~', '"'
];

String encodeBase91(String d){
// Copyright (c) 2005-2006 Joachim Henke
// http://base91.sourceforge.net/
// This is an encoded string => nX,<:WRT%yV%!5:maref3+1RrUb64^M
  if (d == null || d == '') return '';

  int l = d.length;
  String o = '';
  int b = 0;
  int n = 0;
  int v = 0;

  for (int i = 0; i < l; ++i) {
    b = b | d.codeUnitAt(i) << n;
    n = n + 8;
    if (n > 13) {
      v = b & 8191;
      if (v > 88) {
        b = b >> 13;
        n = n - 13;
      } else {
        v = b & 16383;
        b = b >> 14;
        n = n - 14;
      }
      o = o + b91_enctab[v % 91] + b91_enctab[v ~/ 91];
    }
  }
  if (n > 0) {
    o = o + b91_enctab[b % 91];
    if (n > 7 || b > 90)
      o = o + b91_enctab[b ~/ 91];
  }
  return o;
}

String decodeBase91(String d){
// Copyright (c) 2005-2006 Joachim Henke
// http://base91.sourceforge.net/
// nX,<:WRT%yV%!5:maref3+1RrUb64^M  => This is an encoded string

  if (d == null || d == '') return '';

  Map<int, int> b91_dectab = {};

  for (int i = 0; i < 256; i++)
    b91_dectab[i] = -1;

  for (int i = 0; i < 91; ++i)
    b91_dectab[b91_enctab[i].codeUnitAt(0)] = i;

  int dbq = 0;
  int dn = 0;
  int dv = -1;
  List<int> output = [];

  for (int i = 0; i < d.length; ++i) {
    if (b91_dectab[d[i].codeUnitAt(0)] != -1) {
      if (dv == -1)
        dv = b91_dectab[d[i].codeUnitAt(0)];
      else {
        dv = dv + b91_dectab[d[i].codeUnitAt(0)] * 91;
        dbq |= dv << dn;
        dn += (dv & 8191) > 88 ? 13 : 14;
        do {
          output.add(dbq % 256);
          dbq >>= 8;
          dn -= 8;
        } while (dn > 7);
        dv = -1;
      }
    }
  }

  if (dv != -1) {
    output.add(dbq | dv << dn);
  }

  return String.fromCharCodes(output);
}

String encodeBase122(String input){
  if (input == null || input == '') return '';

}

String decodeBase122(String input){
  if (input == null || input == '') return '';

}

int _strPos(String text, String char){
  for (int i = 0; i < text.length; i++)
    if (text[i] == char)
      return i;
}
