import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
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

  var replaceToCharacters = [String.fromCharCode(0), String.fromCharCode(1), String.fromCharCode(2)];

  Map<String, String> substitutions = {};
  Map<String, String> integerSubstitutions = {};
  for (int i = 0; i <= 2; i++) {
    substitutions.putIfAbsent(replaceCharacters[i], () => replaceToCharacters[i]);
    integerSubstitutions.putIfAbsent(replaceToCharacters[i], () => i.toString());
  }

  input = substitution(input, substitutions);

  var output = '';
  while (input.length > 0) {
    var chunk = '';
    while (chunk.length < 3 && input.length > 0) {
      var character = input[0];
      if (replaceToCharacters.contains(character)) {
        chunk += character;
      } else {
        output += chunk + character;
        chunk = '';
      }

      input = input.substring(1);
    }

    if (chunk.length == 3) {
      var index = int.tryParse(convertBase(substitution(chunk, integerSubstitutions), 3, 10));
      if (index < 26) {
        output += alphabet_AZIndexes[index + 1];
        continue;
      }
    }

    output += chunk;
  }

  return substitution(output + input, switchMapKeyValue(substitutions)).toUpperCase();
}