import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';

part 'package:gc_wizard/tools/crypto_and_encodings/morse/logic/morse_data.dart';

enum MorseType {MORSE_ITU, MORSE1838, MORSE1844, STEINHEIL, GERKE}

const String _MORSE_CHARACTER_DOTS = '.\u2022\u00B7\u16EB\u2981\u25CF\u2218\u25E6';

// normalizes dot, dash and space chars
String normalizeMorseCharacters(String morse) {
  //normalizeCharacters normalizes already ' ' and '-',
  // but cannot normalize '.' because normally it is a common sentence char or digits delimiter

  return normalizeCharacters(morse).split('').map((e) {
    if (_MORSE_CHARACTER_DOTS.contains(e)) {
      return '.';
    }
    return e;
  }).join();
}

final Map<MorseType, String> MORSE_CODES = {
  MorseType.MORSE_ITU: 'symboltables_morse',
  MorseType.MORSE1838: 'symboltables_morse_1838_patent',
  MorseType.MORSE1844: 'symboltables_morse_1844_vail',
  MorseType.GERKE: 'symboltables_morse_gerke',
  MorseType.STEINHEIL: 'symboltables_morse_steinheil',
};

final Map<MorseType, Map<String, String>> _AZTO_MORSE_CODE = {
  MorseType.MORSE_ITU: _AZToMorse,
  MorseType.MORSE1838: _AZToMorse1838,
  MorseType.MORSE1844: _AZToMorse1844,
  MorseType.GERKE: _AZToGerke,
  MorseType.STEINHEIL: _AZToSteinheil,
};

final Map<MorseType, Map<String, String>> _MORSE_CODETOAZ = {
  MorseType.MORSE_ITU: _MorseToAZ,
  MorseType.MORSE1838: _Morse1838ToAZ,
  MorseType.MORSE1844: _Morse1844ToAZ,
  MorseType.GERKE: _GerkeToAZ,
  MorseType.STEINHEIL: _SteinheilToAZ,
};

String encodeMorse(String input, {MorseType type = MorseType.MORSE_ITU, String? spaceCharacter}) {
  if (input.isEmpty) return '';

  return input.toUpperCase().split('').map((character) {
    if (character == ' ') return '|';

    var morse = _AZTO_MORSE_CODE[type]?[character];
    return morse ?? '';
  }).join(spaceCharacter ?? ' '); // using wide space
}

String decodeMorse(String input, {MorseType type = MorseType.MORSE_ITU}) {
  if (input.isEmpty) return '';

  return normalizeMorseCharacters(input).split(RegExp(r'[^.\-/|]')).map((morse) {
    if (morse == '|' || morse == '/') return ' ';
    var character = _MORSE_CODETOAZ[type]?[morse];
    return character ?? '';
  }).join();
}
