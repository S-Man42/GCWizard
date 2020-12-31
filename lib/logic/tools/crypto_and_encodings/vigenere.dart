import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/utils/alphabets.dart';

String encryptVigenere(String input, String key, bool autoKey, {int aValue = 0, ignoreNonLetters: true}) {
  if (input == null || input.length == 0)
    return '';

  if (key == null)
    return input;

  key = key.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');

  if (key.length == 0)
    return input;

  String output = '';

  if (autoKey) {
    key += input.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
  } else {
    while (key.length < input.length) {
      key += key;
    }
  }

  int keyOffset = 0;

  var aOffset = alphabet_AZ['A'] - aValue;

  for (int i = 0; i < input.length; ++i) {
    if(ignoreNonLetters && !alphabet_AZ.containsKey(input[i].toUpperCase()))  {
      keyOffset++;
      output += input[i];

      continue;
    }

    if (i - keyOffset >= key.length)
      break;

    output += Rotator().rotate(input[i], alphabet_AZ[key[i - keyOffset]] - aOffset);
  }

  return output;
}

String decryptVigenere(String input, String key, bool autoKey, {int aValue: 0, bool ignoreNonLetters: true}) {
  if (input == null || input.length == 0)
    return '';

  if (key == null)
    return input;

  key = key.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');

  if (key.length == 0)
    return input;

  String originalKey = key;
  String output = '';

  if (!autoKey) {
    while (key.length < input.length) {
      key += key;
    }
  }

  int keyOffset = 0;

  var aOffset = alphabet_AZ['A'] - aValue;

  for (int i = 0; i < input.length; ++i) {
    if(ignoreNonLetters && !alphabet_AZ.containsKey(input[i].toUpperCase()))  {
      keyOffset++;
      output += input[i];

      continue;
    }

    int position;
    if (autoKey) {
      String s = originalKey + output.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');

      if (i - keyOffset >= s.length)
        break;

      position = alphabet_AZ[s[i - keyOffset]];
    } else {
      if (i - keyOffset >= key.length)
        break;

      position = alphabet_AZ[key[i - keyOffset]];
    }

    output += Rotator().rotate(input[i], -position + aOffset);
  }

  return output;
}