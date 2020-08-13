import 'package:gc_wizard/utils/common_utils.dart';

final AZToCCITT1 = {
  'Y': 1, 'E': 2, 'I': 3, 'A': 4, 'U': 5, String.fromCharCode(201) /* É */: 6, 'O': 7, 'B': 9, 'G': 10, 'F': 11, 'J': 12, 'C': 13, 'H': 14, 'D': 15,
  'S': 17, 'X': 18, 'W': 19, '-': 20, 'T': 21, 'Z': 22, 'V': 23, 'R': 25, 'M': 26, 'N': 27, 'K': 28, 'Q': 29, 'L': 30, 'P': 31,
};
final CCITT1ToAZ = switchMapKeyValue(AZToCCITT1);

final NumbersToCCITT1 = {
  '3': 1, '2': 2, '3/': 3, '1': 4, '4': 5, '1/': 6, '5': 7, '8': 9, '7': 10, '5/': 11, '6': 12, '9': 13, '4/': 14, '0': 15,
  '7/': 17, '9/': 18, '?': 19, '.': 20, '2/': 21, ':': 22, '\'': 23, '-': 25, ')': 26, String.fromCharCode(163) /* £ */: 27, '(': 28, '/': 29, '=': 30, '+': 31
};
final CCITT1ToNumbers = switchMapKeyValue(NumbersToCCITT1);

final _NUMBERS_FOLLOW = 8;
final _LETTERS_FOLLOW = 16;

String encodeCCITT1(String input) {
  if (input == null || input.length == 0)
    return '';

  var isLetterMode = true;

  List<int> out = [];

  input = input.toUpperCase().replaceAll(String.fromCharCode(201), String.fromCharCode(0));
  input = removeAccents(input).replaceAll(String.fromCharCode(0), String.fromCharCode(201)); // keep É as only accent

  var cachedSpace = false;
  input.split('').forEach((character) {
    if (character == ' ') {
      cachedSpace = true;
      return;
    }

    if (isLetterMode) {
      var code = AZToCCITT1[character];
      if (code != null) {
        if (cachedSpace)
          out.add(_LETTERS_FOLLOW);
        return out.add(code);
      }

      code = NumbersToCCITT1[character];
      if (code != null) {
        out.add(_NUMBERS_FOLLOW);
        out.add(code);
        isLetterMode = false;
        cachedSpace = false;
      }
    } else {
      var code = NumbersToCCITT1[character];
      if (code != null) {
        if (cachedSpace)
          out.add(_NUMBERS_FOLLOW);
        return out.add(code);
      }

      code = AZToCCITT1[character];
      if (code != null) {
        out.add(_LETTERS_FOLLOW);
        out.add(code);
        isLetterMode = true;
        cachedSpace = false;
      }
    }
  });

  return out.join(' ');
}

String decodeCCITT1(List<int> values) {
  if (values == null || values.length == 0)
    return '';

  String out = '';
  var isLetterMode = true;

  values.forEach((value) {
    if (value == _NUMBERS_FOLLOW) {
      if (out.length > 0)
        out += ' ';
      isLetterMode = false;
      return;
    }

    if (value == _LETTERS_FOLLOW) {
      out += ' ';
      isLetterMode = true;
      return;
    }

    if (isLetterMode) {
      out += CCITT1ToAZ[value] ?? '';
    } else {
      out += CCITT1ToNumbers[value] ?? '';
    }
  });

  return out;
}