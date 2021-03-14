import 'package:diacritic/diacritic.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final AZToVanity = {
  'A': '2',
  'B': '22',
  'C': '222',
  'D': '3',
  'E': '33',
  'F': '333',
  'G': '4',
  'H': '44',
  'I': '444',
  'J': '5',
  'K': '55',
  'L': '555',
  'M': '6',
  'N': '66',
  'O': '666',
  'P': '7',
  'Q': '77',
  'R': '777',
  'S': '7777',
  'T': '8',
  'U': '88',
  'V': '888',
  'W': '9',
  'X': '99',
  'Y': '999',
  'Z': '9999',
  '1': '1',
  '2': '2222',
  '3': '3333',
  '4': '4444',
  '5': '5555',
  '6': '6666',
  '7': '77777',
  '8': '8888',
  '9': '99999',
  '0': '0'
};

final VanityToAZ = switchMapKeyValue(AZToVanity);

const DEFAULT_NUMBER_FOR_SPACE = '1';

String encryptVanitySingleNumbers(String input, {numberForSpace: DEFAULT_NUMBER_FOR_SPACE}) {
  return _encodeVanityMultipleNumbers(input, numberForSpace: numberForSpace).map((code) => code[0]).join();
}

_encodeVanityMultipleNumbers(String input, {numberForSpace: DEFAULT_NUMBER_FOR_SPACE}) {
  if (input == null || input == '') return [];

  input = removeDiacritics(input).toUpperCase();

  return input.split('').map((character) {
    if (character == ' ' && numberForSpace != null && numberForSpace.length > 0) return numberForSpace;

    var code = AZToVanity[character];
    if (code == null) return character;

    return code;
  }).toList();
}

String encodeVanityMultipleNumbers(String input, {numberForSpace: DEFAULT_NUMBER_FOR_SPACE}) {
  return _encodeVanityMultipleNumbers(input, numberForSpace: numberForSpace).join(' ');
}

String decodeVanityMultipleNumbers(List<int> input) {
  if (input == null) return '';

  return input.map((code) {
    var character = VanityToAZ[code.toString()];

    if (character == null) return UNKNOWN_ELEMENT;

    return character;
  }).join();
}
