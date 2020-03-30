import 'package:gc_wizard/logic/tools/crypto/substitution.dart';
import 'package:gc_wizard/logic/tools/science/numeral_bases.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';

encryptKenny(String input, List<String> replaceCharacters) {
  if (input == null || input.length == 0)
    return '';

  if (replaceCharacters == null || replaceCharacters.length < 3)
    return '';

  Map<String, String> substitutions = {};
  for (int i = 0; i <= 2; i++) {
    substitutions.putIfAbsent(i.toString(), () => replaceCharacters[i]);
  }

  input = normalizeUmlauts(input);

  var output = '';
  RegExp regExp = RegExp(r'[A-Za-z]');
  input.split('').forEach((letter) {
    if (!letter.startsWith(regExp)) {
      output += letter;
      return;
    }
    var value = convertBase((alphabet_AZ[letter.toUpperCase()] - 1).toString(), 10, 3).padLeft(3, '0');
    value = substitution(value, substitutions);
    output += value;
  });

  return output;
}

decryptKenny(String input, List<String> replaceCharacters) {
  if (input == null || input.length == 0)
    return '';

  if (replaceCharacters == null || replaceCharacters.length < 3)
    return '';

  Map<String, String> substitutions = {};
  for (int i = 0; i <= 2; i++) {
    substitutions.putIfAbsent(replaceCharacters[i], () => i.toString());
  }

  input = substitution(input, substitutions);

  var output = '';
  while (input.length >= 3) {
    var chunk = '';
    while (chunk.length < 3 && input.length > 0) {
      var character = input[0];
      if ('012'.contains(character)) {
        chunk += character;
      } else {
        output += character;
      }
      input = input.substring(1);
    }

    if (chunk.length == 3) {
      var index = int.tryParse(convertBase(chunk, 3, 10));
      if (index < 26)
        output += alphabet_AZIndexes[index + 1];
    }
  }

  return output + input;
}