import 'package:gc_wizard/logic/tools/crypto/substitution.dart';
import 'package:gc_wizard/utils/common_utils.dart';

const AZToTomTom = {'A': '/', 'B': '//', 'C': '///', 'D': '////', 'E': '/\\', 'F': '//\\', 'G': '///\\', 'H': '/\\\\', 'I': '/\\\\\\', 'J': '\\/', 'K': '\\\\/', 'L': '\\\\\\/', 'M': '\\//', 'N': '\\///', 'O': '/\\/', 'P': '//\\/', 'Q': '/\\\\/', 'R': '/\\//', 'S': '\\/\\', 'T': '\\\\/\\', 'U': '\\//\\', 'V': '\\/\\\\', 'W': '//\\\\', 'X': '\\\\//', 'Y': '\\/\\/', 'Z': '/\\/\\'};

encryptTomTom(String input, Map<String, String> replaceCharacters) {
  if (input == null || input.length == 0)
    return '';

  var tomtom = normalizeUmlauts(input)
    .toUpperCase()
    .split('')
    .where((character) => AZToTomTom[character] != null)
    .map((character) => substitution(character, AZToTomTom))
    .join(' ');

  //TODO: Expert Mode
  if (replaceCharacters != null)
    tomtom = substitution(tomtom, replaceCharacters);

  return tomtom;
}

decryptTomTom(String input, Map<String, String> replaceCharacters) {
  if (input == null || input.length == 0)
    return '';

  if (replaceCharacters != null)
    input = substitution(input, replaceCharacters.map((k, v) => MapEntry(v, k)));

  final tomTomToAZ = AZToTomTom.map((k, v) => MapEntry(v, k));

  return input
      .split(RegExp(r'[^/\\]'))
      .where((character) => tomTomToAZ[character] != null)
      .map((pattern) => tomTomToAZ[pattern]).join();
}