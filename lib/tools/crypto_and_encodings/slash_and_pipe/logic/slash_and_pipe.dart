import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';

const Map<String, String> _AZToSlashAndPipe = {
  'A': '|',
  'B': '|\\',
  'C': '||',
  'D': '|/',
  'E': '\\',
  'F': '||\\',
  'G': '|||',
  'H': '||/',
  'I': '/',
  'J': '|\\',
  'K': '|\\|',
  'L': '|\\/',
  'M': '|/\\',
  'N': '|/|',
  'O': '|//',
  'P': '\\',
  'Q': '\\|',
  'R': '\\/',
  'S': '/\\',
  'T': '/|',
  'U': '//',
  'V': '||\\\\',
  'W': '||//',
  'X': '|||\\',
  'Y': '|||/',
  'Z': '||||',
};

String encryptSlashAndPipe(String input, Map<String, String>? replaceCharacters) {
  if (input.isEmpty) return '';

  var slashandpipe = normalizeUmlauts(input)
      .toUpperCase()
      .split('')
      .where((character) => _AZToSlashAndPipe[character] != null)
      .map((character) => substitution(character, _AZToSlashAndPipe))
      .join(' ');

  if (replaceCharacters != null) slashandpipe = substitution(slashandpipe, replaceCharacters);

  return slashandpipe;
}

String decryptSlashAndPipe(String input, Map<String, String>? replaceCharacters) {
  if (input.isEmpty) return '';

  if (replaceCharacters != null) input = substitution(input, switchMapKeyValue(replaceCharacters));

  final SlashAndPipeToAZ = switchMapKeyValue(_AZToSlashAndPipe);

  return input
      .split(RegExp(r'[^|/\\]'))
      .where((character) => SlashAndPipeToAZ[character] != null)
      .map((pattern) => SlashAndPipeToAZ[pattern])
      .join();
}
