import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';

encryptKenny(String input, List<String> replaceCharacters, bool caseSensitive) {
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
    if (caseSensitive) {
      if (isUpperCase(letter))
        value = value[0].toUpperCase() + value.substring(1).toLowerCase();
      else
        value = value.toLowerCase();
    }
    output += value;
  });
  return output;
}

decryptKenny(String input, List<String> replaceCharacters, bool caseSensitive) {
  if (input == null || input.length == 0)
    return '';

  if (replaceCharacters == null || replaceCharacters.length < 3)
    return '';

  var replaceToCharacters = [String.fromCharCode(0), String.fromCharCode(1), String.fromCharCode(2)];

  Map<String, String> substitutions = {};
  Map<String, String> substitutionsSwitched = {};
  Map<String, String> integerSubstitutions = {};
  for (int i = 0; i <= 2; i++) {
    substitutions.putIfAbsent(replaceCharacters[i], () => replaceToCharacters[i]);
    integerSubstitutions.putIfAbsent(replaceToCharacters[i], () => i.toString());
  }

  var _input = substitution(input, substitutions, caseSensitive: false);
  int chunkStart = 0;
  int chunkOffset = 0;
  substitutionsSwitched = switchMapKeyValue(substitutions);

  var output = '';
  while (_input.length > 0) {
    var chunk = '';
    chunkStart += chunkOffset;
    chunkOffset = 0;
    while (chunk.length < 3 && _input.length > 0) {
      var character = _input[0];
      if (replaceToCharacters.contains(character)) {
        chunk += character;
        chunkOffset += substitutionsSwitched[character].length;
      } else {
        var outputTmp = _restoreChunks(chunk + input[chunkStart + chunkOffset], input, chunkStart, substitutionsSwitched);
        output += outputTmp;
        chunk = '';
        chunkOffset = 0;
        chunkStart += outputTmp.length;
      }

      _input = _input.substring(1);
    }

    if (chunk.length == 3) {
      var index = int.tryParse(convertBase(substitution(chunk, integerSubstitutions), 3, 10));
      if (index < 26) {
        var outputChar = alphabet_AZIndexes[index + 1];
        if (caseSensitive) {
          if (!isUpperCase(input[chunkStart]))
            outputChar = outputChar.toLowerCase();
        }
        output += outputChar;
        continue;
      }
    }

    var outputTmp = substitution(chunk, substitutionsSwitched);
    for (int i = 0; i < outputTmp.length; i++)
      output += input[chunkStart + i];
  }

  output = _restoreChunks(output + _input, input, 0 , substitutionsSwitched);

  if (!caseSensitive)
    output = output.toUpperCase();

  return output;
}

String _restoreChunks(String chunk , String input, int position, Map<String, String> substitutionsSwitched){
  var output = '';
  for (int i = 0; i < chunk.length; i++) {
    if (substitutionsSwitched.containsKey(chunk[i])){
      output +=  input.substring(position, position + substitutionsSwitched[chunk[i]].length) ;
      position += substitutionsSwitched[chunk[i]].length;
    } else
      output += chunk[i];
    position += chunk[i].length;
  }
  return output;
}