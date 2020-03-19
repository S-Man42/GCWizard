import 'dart:convert';

import 'package:base32/base32.dart';
import 'package:gc_wizard/logic/tools/encodings/ascii85.dart';

String base16Decode(String input) {
  if (input == null || input == '')
    return '';

  return List.generate(input.length,
          (i) => i % 2 == 0 ? input.substring(i, i + 2) : null)
      .where((b) => b != null && RegExp(r'[0-9A-Fa-f]{2}').hasMatch(b))
      .map((b) => String.fromCharCode(int.parse(b, radix: 16)))
      .toList()
      .join();
}

String base16Encode(String input) {
  if (input == null || input == '')
    return '';

  return input.codeUnits
      .map((codeUnit) => codeUnit.toRadixString(16).padLeft(2, '0'))
      .join();
}

String base32Encode(String input) {
  if (input == null || input == '')
    return '';

  return base32.encodeString(input);
}

String base32Decode(String input) {
  if (input == null || input == '')
    return '';

  var out = '';

  //if there's no result, try with appended =
  for (int i = 0; i <= 1; i++) {
    try {
      out = base32.decodeAsString(input + '=' * i);

      if (out.length > 0)
        break;
    } on FormatException {}
  }

  return out;
}

String base64Encode(String input) {
  if (input == null || input == '')
    return '';

  return base64.encode(utf8.encode(input));
}

String base64Decode(String input) {
  if (input == null || input == '')
    return '';

  var out = '';

  //if there's no result, try with appended = or ==
  for (int i = 0; i <= 2; i++) {
    try {
      out = utf8.decode(base64.decode(input + '=' * i));

      if (out.length > 0)
        break;
    } on FormatException {}
  }

  return out;
}

String base85Encode(String input) {
  if (input == null || input == '')
    return '';

  var encoded = encodeASCII85(utf8.encode(input));

  if (encoded == null)
    return '';

  return '<~' + encoded + '~>';
}

String base85Decode(String input) {
  if (input == null || input == '')
    return '';

  if (input.startsWith('<~'))
    input = input.substring(2);

  if (input.endsWith('~>'))
    input = input.substring(0, input.length - 2);

  var decoded = decodeASCII85(input);
  return utf8.decode(decoded == null ? [] : decoded);
}

String decode(String input, Function function) {
  var output = '';
  if (input.length == 0)
    return output;

  while (input.length > 0) {
    try {
      output = function(input);

      if (output.length == 0 && input.length > 0)
        throw FormatException();

      break;
    } on FormatException {
      return decode(input.substring(0, input.length - 1), function);
    } on RangeError {
      return decode(input.substring(0, input.length - 1), function);
    }
  }

  return output;
}