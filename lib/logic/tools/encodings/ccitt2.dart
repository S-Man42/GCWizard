import 'package:gc_wizard/utils/common_utils.dart';

final AZToCCIT2 = {
  ' ': 4, '\r': 2, '\n': 8, 'E': 1, 'A': 3, 'S': 5, 'I': 6, 'U': 7, 'D': 9, 'R': 10, 'J': 11, 'N': 12, 'F': 13, 'C': 14, 'K': 15, 'T': 16, 'Z': 17, 'L': 18,
  'W': 19, 'H': 20, 'Y': 21, 'P': 22, 'Q': 23, 'O': 24, 'B': 25, 'G': 26, 'M': 28, 'X': 29, 'V': 30
};
final CCIT2ToAZ = switchMapKeyValue(AZToCCIT2);

final NumbersToCCIT2 = {
  ' ': 4, '\r': 2, '\n': 8, '3': 1, '-': 3, '\'': 5, '8': 6, '7': 7, '4': 10, '@': 11, ',': 12, ':': 14, '(': 15, '5': 16, '+': 17, ')': 18, '2': 19, '6': 21,
  '0': 22, '1': 23, '9': 24, '?': 25, '.': 28, '/': 29, '=': 30
};
final CCIT2ToNumbers = switchMapKeyValue(NumbersToCCIT2);

final _NUMBERS_FOLLOW = 27;
final _LETTERS_FOLLOW = 31;

String encodeCCITT2(String input) {
  if (input == null || input.length == 0)
    return '';

  var isLetterMode = true;

  List<int> out = [];
  input.toUpperCase().split('').forEach((character) {
    if (isLetterMode) {
      var code = AZToCCIT2[character];
      if (code != null)
        return out.add(code);

      code = NumbersToCCIT2[character];
      if (code != null) {
        out.add(_NUMBERS_FOLLOW);
        out.add(code);
        isLetterMode = false;
      }
    } else {
      var code = NumbersToCCIT2[character];
      if (code != null)
        return out.add(code);

      code = AZToCCIT2[character];
      if (code != null) {
        out.add(_LETTERS_FOLLOW);
        out.add(code);
        isLetterMode = true;
      }
    }
  });

  return out.join(' ');
}

String decodeCCITT2(List<int> values) {
  if (values == null || values.length == 0)
    return '';

  String out = '';
  var isLetterMode = true;

  values.forEach((value) {
    if (value == _NUMBERS_FOLLOW) {
      isLetterMode = false;
      return;
    }

    if (value == _LETTERS_FOLLOW) {
      isLetterMode = true;
      return;
    }

    if (isLetterMode) {
      out += CCIT2ToAZ[value] ?? '';
    } else {
      out += CCIT2ToNumbers[value] ?? '';
    }
  });

  return out;
}