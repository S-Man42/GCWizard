import 'package:quiver/pattern.dart';
import 'package:gc_wizard/utils/common_utils.dart';

const AZToTomTom = {'A': '/', 'B': '//', 'C': '///', 'D': '////', 'E': '/\\', 'F': '//\\', 'G': '///\\', 'H': '/\\\\', 'I': '/\\\\\\', 'J': '\\/', 'K': '\\\\/', 'L': '\\\\\\/', 'M': '\\//', 'N': '\\///', 'O': '/\\/', 'P': '//\\/', 'Q': '/\\\\/', 'R': '/\\//', 'S': '\\/\\', 'T': '\\\\/\\', 'U': '\\//\\', 'V': '\\/\\\\', 'W': '//\\\\', 'X': '\\\\//', 'Y': '\\/\\/', 'Z': '/\\/\\'};
const TomTomCharacters = ["/", "\\"];

encryptTomTomCode(String input, List<String> replaceCharacters) {
  if (input == null || input.length == 0)
    return '';

  if (replaceCharacters == null || replaceCharacters.length != TomTomCharacters.length)
    return '';

  final Map<String, String> substitutions = createSubstitutedLookupMap(AZToTomTom, TomTomCharacters, replaceCharacters);
  
  return normalizeUmlauts(input)
    .toUpperCase()
    .split('')
    .map((character) {
      var pattern = substitutions[character];
      return pattern != null ? pattern + ' ' : '';
  }).join().trim();
}

decryptTomTomCode(String input, List<String> replaceCharacters) {
  if (input == null || input.length == 0)
    return '';
  
  if (replaceCharacters == null || replaceCharacters.length != TomTomCharacters.length)
    return '';

  final Map<String, String> substitutions = createSubstitutedLookupMap(AZToTomTom, TomTomCharacters, replaceCharacters);
  final TomTomToAZ = substitutions.map((k, v) => MapEntry(v, k));
  final String pattern = replaceCharacters.map((character) => escapeRegex(character)).join();
  final String searchString = '[' + pattern + ']+';

  return RegExp(searchString).allMatches(input).map((pattern) {
    var character = TomTomToAZ[input.substring(pattern.start, pattern.end)];
    return character != null ? character : '';
  }).join();
}