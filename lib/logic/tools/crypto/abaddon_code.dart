import 'package:quiver/pattern.dart';
import 'package:gc_wizard/utils/common_utils.dart';

const AZToAbaddon = {'A': '¥¥µ', 'B': '¥þ¥', 'C': 'þµµ', 'D': 'µµþ', 'E': 'µ¥µ', 'F': 'µµ¥', 'G': 'µþþ', 'H': 'þµ¥', 'I': '¥¥¥', 'J': 'µþµ', 'K': '¥þµ', 'L': 'µ¥¥', 'M': 'þ¥¥', 'N': '¥¥þ', 'O': 'þþþ', 'P': 'þþ¥', 'Q': '¥þþ', 'R': 'þþµ', 'S': 'þµþ', 'T': 'þ¥µ', 'U': 'µµµ', 'V': '¥µ¥', 'W': 'µþ¥', 'X': 'µ¥þ', 'Y': '¥µþ', 'Z': 'þ¥þ', ' ': '¥µµ'};
const AbaddonCharacters = ['¥', 'µ', 'þ'];

encryptAbaddonCode(String input, List<String> replaceCharacters) {
  if (input == null || input.length == 0)
    return '';

  if (replaceCharacters == null || replaceCharacters.length != AbaddonCharacters.length)
    return '';

  final Map<String, String> substitutions = createSubstitutedLookupMap(AZToAbaddon, AbaddonCharacters, replaceCharacters);
  
  return normalizeUmlauts(input)
    .toUpperCase()
    .split('')
    .map((character) {
      var pattern = substitutions[character];
      return pattern != null ? pattern : '';
  }).join();
}

decryptAbaddonCode(String input, List<String> replaceCharacters) {
  if (input == null || input.length == 0)
    return '';
  
  if (replaceCharacters == null || replaceCharacters.length != AbaddonCharacters.length)
    return '';

  final Map<String, String> substitutions = createSubstitutedLookupMap(AZToAbaddon, AbaddonCharacters, replaceCharacters);
  final TomTomToAZ = substitutions.map((k, v) => MapEntry(v, k));
  final String pattern = replaceCharacters.map((character) => escapeRegex(character)).join();
  final String filterString = '[^' + pattern + ']';
  final String searchString = '[' + pattern + ']{3,3}';

  input = input.replaceAll(RegExp(filterString), '');

  return RegExp(searchString).allMatches(input).map((pattern) {
    var character = TomTomToAZ[input.substring(pattern.start, pattern.end)];
    return character != null ? character : '';
  }).join();
}