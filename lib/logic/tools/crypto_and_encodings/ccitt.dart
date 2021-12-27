import 'package:gc_wizard/logic/tools/crypto_and_encodings/telegraphs/punchtape.dart';
import 'package:gc_wizard/utils/common_utils.dart';
// https://en.wikipedia.org/wiki/Baudot_code

enum CCITTCodebook { CCITT_BAUDOT, CCITT_BAUDOT_MISS, CCITT_ITA1_EU, CCITT_ITA1_UK, CCITT_ITA2, CCITT_MTK2, CCITT_ITA5, CCITT_USTTY }

Map<CCITTCodebook, Map<String, String>> CCITT_CODEBOOK = {
  CCITTCodebook.CCITT_BAUDOT: {'title': 'punchtape_baudot_title', 'subtitle': 'punchtape_baudot_description'},
  CCITTCodebook.CCITT_BAUDOT_MISS: {'title': 'punchtape_ccitt_baudot_miss_title', 'subtitle': 'punchtape_ccitt_baudot_miss_description'},
  CCITTCodebook.CCITT_ITA1_EU: {'title': 'punchtape_ccitt_ita1_eu_title', 'subtitle': 'punchtape_ccitt_ita1_eu_description'},
  CCITTCodebook.CCITT_ITA1_UK: {'title': 'punchtape_ccitt_ita1_uk_title', 'subtitle': 'punchtape_ccitt_ita1_uk_description'},
  CCITTCodebook.CCITT_ITA2: {'title': 'punchtape_ccitt_ita2_title', 'subtitle': 'punchtape_ccitt_ita2_description'},
  CCITTCodebook.CCITT_MTK2: {'title': 'punchtape_ccitt_mtk2_title', 'subtitle': 'punchtape_ccitt_mtk2_description'},
  CCITTCodebook.CCITT_USTTY: {'title': 'punchtape_ccitt_ustty_title', 'subtitle': 'punchtape_ccitt_ustty_description'},
//  CCITTCodebook.CCITT2_ITA5: {'title': 'punchtape_ccitt_ITA5_title', 'subtitle': 'punchtape_ccitt_ITA5_description'},
};

Map<CCITTCodebook, Map<String, int>> punchTapeDefinition = {
  CCITTCodebook.CCITT_BAUDOT : {'punchHoles' : 5, 'sprocketHole': 0},
  CCITTCodebook.CCITT_BAUDOT_MISS : {'punchHoles' : 5, 'sprocketHole': 0},
  CCITTCodebook.CCITT_ITA1_EU : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_ITA1_UK : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_ITA2 : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_MTK2 : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_USTTY : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_ITA5 : {'punchHoles' : 8, 'sprocketHole': 4},
};

final AZToCCITT_BAUDOT = {
  'A': 1,
  'E': 2,
  String.fromCharCode(201) /* É */ : 3,
  'Y': 4,
  'U': 5,
  'I': 6, //String.fromCharCode(201) /* É */ : 6,
  'O': 7,
  'J': 9,
  'G': 10,
  'H': 11,
  'B': 12,
  'C': 13,
  'F': 14,
  'D': 15,
  'X': 18,
  'Z': 19,
  'S': 20,
  'T': 21,
  'W': 22,
  'V': 23,
  '@': 24,
  'K': 25,
  'M': 26,
  'L': 27,
  'R': 28,
  'Q': 29,
  'N': 30,
  'P': 31,
};
final CCITT_BAUDOTToAZ = switchMapKeyValue(AZToCCITT_BAUDOT);

final NumbersToCCITT_BAUDOT = {};
final CCITT_BAUDOTToNumbers = switchMapKeyValue(NumbersToCCITT_BAUDOT);

final AZToCCITT_ITA1_MISS = {
  'Y': 1,
  'E': 2,
  'I': 3,
  'A': 4,
  'U': 5,
  String.fromCharCode(201) /* É */ : 6,
  'O': 7,
  'B': 9,
  'G': 10,
  'F': 11,
  'J': 12,
  'C': 13,
  'H': 14,
  'D': 15,
  'S': 17,
  'X': 18,
  'W': 19,
  '-': 20,
  'T': 21,
  'Z': 22,
  'V': 23,
  'R': 25,
  'M': 26,
  'N': 27,
  'K': 28,
  'Q': 29,
  'L': 30,
  'P': 31,
};
final CCITT_ITA1_MISSToAZ = switchMapKeyValue(AZToCCITT_ITA1_MISS);

final NumbersToCCITT_ITA1_MISS = {
  '3': 1,
  '2': 2,
  '3/': 3,
  '1': 4,
  '4': 5,
  '1/': 6,
  '5': 7,
  '8': 9,
  '7': 10,
  '5/': 11,
  '6': 12,
  '9': 13,
  '4/': 14,
  '0': 15,
  '7/': 17,
  '9/': 18,
  '?': 19,
  '.': 20,
  '2/': 21,
  ':': 22,
  '\'': 23,
  '-': 25,
  ')': 26,
  String.fromCharCode(163) /* £ */ : 27,
  '(': 28,
  '/': 29,
  '=': 30,
  '+': 31
};
final CCITT_ITA1_MISSToNumbers = switchMapKeyValue(NumbersToCCITT_ITA1_MISS);

final AZToCCITT_ITA1_EU = {
  'Y': 1,
  'E': 2,
  'I': 3,
  'A': 4,
  'U': 5,
  String.fromCharCode(201) /* É */ : 6,
  'O': 7,
  'B': 9,
  'G': 10,
  'F': 11,
  'J': 12,
  'C': 13,
  'H': 14,
  'D': 15,
  'S': 17,
  'X': 18,
  'W': 19,
  '-': 20,
  'T': 21,
  'Z': 22,
  'V': 23,
  'R': 25,
  'M': 26,
  'N': 27,
  'K': 28,
  'Q': 29,
  'L': 30,
  'P': 31,
};
final CCITT_ITA1_EUToAZ = switchMapKeyValue(AZToCCITT_ITA1_EU);

final NumbersToCCITT_ITA1_EU = {
  '3': 1,
  '2': 2,
  '3/': 3,
  '1': 4,
  '4': 5,
  '1/': 6,
  '5': 7,
  '8': 9,
  '7': 10,
  '5/': 11,
  '6': 12,
  '9': 13,
  '4/': 14,
  '0': 15,
  '7/': 17,
  '9/': 18,
  '?': 19,
  '.': 20,
  '2/': 21,
  ':': 22,
  '\'': 23,
  '-': 25,
  ')': 26,
  String.fromCharCode(163) /* £ */ : 27,
  '(': 28,
  '/': 29,
  '=': 30,
  '+': 31
};
final CCITT_ITA1_EUToNumbers = switchMapKeyValue(NumbersToCCITT_ITA1_EU);

final AZToCCITT_ITA1_UK = {
  'Y': 1,
  'E': 2,
  'I': 3,
  'A': 4,
  'U': 5,
  String.fromCharCode(201) /* É */ : 6,
  'O': 7,
  'B': 9,
  'G': 10,
  'F': 11,
  'J': 12,
  'C': 13,
  'H': 14,
  'D': 15,
  'S': 17,
  'X': 18,
  'W': 19,
  '-': 20,
  'T': 21,
  'Z': 22,
  'V': 23,
  'R': 25,
  'M': 26,
  'N': 27,
  'K': 28,
  'Q': 29,
  'L': 30,
  'P': 31,
};
final CCITT_ITA1_UKToAZ = switchMapKeyValue(AZToCCITT_ITA1_UK);

final NumbersToCCITT_ITA1_UK = {
  '3': 1,
  '2': 2,
  '3/': 3,
  '1': 4,
  '4': 5,
  '1/': 6,
  '5': 7,
  '8': 9,
  '7': 10,
  '5/': 11,
  '6': 12,
  '9': 13,
  '4/': 14,
  '0': 15,
  '7/': 17,
  '9/': 18,
  '?': 19,
  '.': 20,
  '2/': 21,
  ':': 22,
  '\'': 23,
  '-': 25,
  ')': 26,
  String.fromCharCode(163) /* £ */ : 27,
  '(': 28,
  '/': 29,
  '=': 30,
  '+': 31
};
final CCITT_ITA1_UKToNumbers = switchMapKeyValue(NumbersToCCITT_ITA1_UK);

final AZToCCITT_ITA2 = {
  ' ': 4,
  '\r': 2,
  '\n': 8,
  'E': 1,
  'A': 3,
  'S': 5,
  'I': 6,
  'U': 7,
  'D': 9,
  'R': 10,
  'J': 11,
  'N': 12,
  'F': 13,
  'C': 14,
  'K': 15,
  'T': 16,
  'Z': 17,
  'L': 18,
  'W': 19,
  'H': 20,
  'Y': 21,
  'P': 22,
  'Q': 23,
  'O': 24,
  'B': 25,
  'G': 26,
  'M': 28,
  'X': 29,
  'V': 30
};
final CCITT_ITA2ToAZ = switchMapKeyValue(AZToCCITT_ITA2);

final NumbersToCCITT_ITA2 = {
  ' ': 4,
  '\r': 2,
  '\n': 8,
  '3': 1,
  '-': 3,
  '\'': 5,
  '8': 6,
  '7': 7,
  '4': 10,
  '@': 11,
  ',': 12,
  ':': 14,
  '(': 15,
  '5': 16,
  '+': 17,
  ')': 18,
  '2': 19,
  '6': 21,
  '0': 22,
  '1': 23,
  '9': 24,
  '?': 25,
  '.': 28,
  '/': 29,
  '=': 30
};
final CCITT_ITA2ToNumbers = switchMapKeyValue(NumbersToCCITT_ITA2);

final AZToCCITT_ITA2_MTK2 = {
  ' ': 4,
  '\r': 2,
  '\n': 8,
  'E': 1,
  'A': 3,
  'С': 5,
  'И': 6,
  'У': 7,
  'Д': 9,
  'Р': 10,
  'Й': 11,
  'Ч': 12,
  'Ф': 13,
  'Ц': 14,
  'К': 15,
  'Т': 16,
  'З': 17,
  'Л': 18,
  'В': 19,
  'Х': 20,
  'Ы': 21,
  'П': 22,
  'Я': 23,
  'О': 24,
  'Б': 25,
  'Г': 26,
  'М': 28,
  'Ь': 29,
  'Ж': 30
};
final CCITT_ITA2_MTK2ToAZ = switchMapKeyValue(AZToCCITT_ITA2_MTK2);

final NumbersToCCITT_MTK2 = {
  ' ': 4,
  '\r': 2,
  '\n': 8,
  '3': 1,
  '-': 3,
  '\'': 5,
  '8': 6,
  '7': 7,
  'Ч' : 9,
  '4': 10,
  'Ю': 11,
  ',': 12,
  'Э': 13,
  ':': 14,
  '(': 15,
  '5': 16,
  '+': 17,
  ')': 18,
  '2': 19,
  'Щ': 20,
  '6': 21,
  '0': 22,
  '1': 23,
  '9': 24,
  '?': 25,
  'Ш': 26,
  '.': 28,
  '/': 29,
  '=': 30
};
final CCITT_MTK2ToNumbers = switchMapKeyValue(NumbersToCCITT_MTK2);

final AZToCCITT_USTTY = {
  ' ': 4,
  '\r': 2,
  '\n': 8,
  'E': 1,
  'A': 3,
  'S': 5,
  'I': 6,
  'U': 7,
  'D': 9,
  'R': 10,
  'J': 11,
  'N': 12,
  'F': 13,
  'C': 14,
  'K': 15,
  'T': 16,
  'Z': 17,
  'L': 18,
  'W': 19,
  'H': 20,
  'Y': 21,
  'P': 22,
  'Q': 23,
  'O': 24,
  'B': 25,
  'G': 26,
  'M': 28,
  'X': 29,
  'V': 30
};
final CCITT_USTTYToAZ = switchMapKeyValue(AZToCCITT_USTTY);

final NumbersToCCITT_ITA2_USTTY = {
  ' ': 4,
  '\r': 2,
  '\n': 8,
  '3': 1,
  '-': 3,
  '@': 5,
  '8': 6,
  '7': 7,
  '4': 10,
  '\'': 11,
  ',': 12,
  ':': 14,
  '(': 15,
  '5': 16,
  '"': 17,
  ')': 18,
  '2': 19,
  '6': 21,
  '0': 22,
  '1': 23,
  '9': 24,
  '?': 25,
  '.': 28,
  '/': 29,
  ';': 30
};
final CCITT_USTTYToNumbers = switchMapKeyValue(NumbersToCCITT_ITA2_USTTY);

final _NUMBERS_FOLLOW_CCITT_1 = 8;
final _LETTERS_FOLLOW_CCITT_1 = 16;

final _NUMBERS_FOLLOW_CCITT_2 = 27;
final _LETTERS_FOLLOW_CCITT_2 = 31;

int _EncodeAZ(CCITTCodebook language, String text){
    switch (language) {
      case CCITTCodebook.CCITT_BAUDOT: return AZToCCITT_BAUDOT[text]; break;
      case CCITTCodebook.CCITT_BAUDOT_MISS: return AZToCCITT_ITA1_MISS[text]; break;
      case CCITTCodebook.CCITT_ITA1_EU: return AZToCCITT_ITA1_EU[text]; break;
      case CCITTCodebook.CCITT_ITA1_UK: return AZToCCITT_ITA1_UK[text]; break;
      case CCITTCodebook.CCITT_ITA2: return AZToCCITT_ITA2[text]; break;
      case CCITTCodebook.CCITT_MTK2: return AZToCCITT_ITA2_MTK2[text]; break;
      case CCITTCodebook.CCITT_USTTY: return AZToCCITT_USTTY[text]; break;
    }
}

int _EncodeNumber(CCITTCodebook language, String text){
    switch (language) {
      case CCITTCodebook.CCITT_BAUDOT: return NumbersToCCITT_BAUDOT[text]; break;
      case CCITTCodebook.CCITT_BAUDOT_MISS: return NumbersToCCITT_ITA1_MISS[text]; break;
      case CCITTCodebook.CCITT_ITA1_EU: return NumbersToCCITT_ITA1_EU[text]; break;
      case CCITTCodebook.CCITT_ITA1_UK: return NumbersToCCITT_ITA1_UK[text]; break;
      case CCITTCodebook.CCITT_ITA2: return NumbersToCCITT_ITA2[text]; break;
      case CCITTCodebook.CCITT_MTK2: return NumbersToCCITT_MTK2[text]; break;
      case CCITTCodebook.CCITT_USTTY: return NumbersToCCITT_ITA2_USTTY[text]; break;
    }
}

String _DecodeAZ(CCITTCodebook language, int code){
    switch (language) {
      case CCITTCodebook.CCITT_BAUDOT: return CCITT_BAUDOTToAZ[code]; break;
      case CCITTCodebook.CCITT_BAUDOT_MISS: return CCITT_ITA1_MISSToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA1_EU: return CCITT_ITA1_EUToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA1_UK: return CCITT_ITA1_UKToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA2: return CCITT_ITA2ToAZ[code]; break;
      case CCITTCodebook.CCITT_MTK2: return CCITT_ITA2_MTK2ToAZ[code]; break;
      case CCITTCodebook.CCITT_USTTY: return CCITT_USTTYToAZ[code]; break;
    }
}

String _DecodeNumber(CCITTCodebook language, int code){
    switch (language) {
      case CCITTCodebook.CCITT_BAUDOT: return CCITT_BAUDOTToNumbers[code]; break;
      case CCITTCodebook.CCITT_BAUDOT_MISS: return CCITT_ITA1_MISSToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA1_EU: return CCITT_ITA1_EUToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA1_UK: return CCITT_ITA1_UKToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA2: return CCITT_ITA2ToNumbers[code]; break;
      case CCITTCodebook.CCITT_MTK2: return CCITT_MTK2ToNumbers[code]; break;
      case CCITTCodebook.CCITT_USTTY: return CCITT_USTTYToNumbers[code]; break;
    }
}


String encodeCCITT(String input, CCITTCodebook language) {
  if (input == null || input.length == 0) return '';

  var isLetterMode = true;

  List<int> out = [];

  switch (language) {
    // CCITT1
    case CCITTCodebook.CCITT_BAUDOT:
    case CCITTCodebook.CCITT_BAUDOT_MISS:
    case CCITTCodebook.CCITT_ITA1_EU:
    case CCITTCodebook.CCITT_ITA1_UK:
        input = input.toUpperCase().replaceAll(String.fromCharCode(201), String.fromCharCode(0));
        input = removeAccents(input).replaceAll(String.fromCharCode(0), String.fromCharCode(201)); // keep É as only accent

        var cachedSpace = false;
        input.split('').forEach((character) {
          if (character == ' ') {
            cachedSpace = true;
            return;
          }

          if (isLetterMode) {
            var code = _EncodeAZ(language, character);
            if (code != null) {
              if (cachedSpace) {
                out.add(_LETTERS_FOLLOW_CCITT_1);
                cachedSpace = false;
              }
              return out.add(code);
            }

            code = _EncodeNumber(language, character);
            if (code != null) {
              out.add(_NUMBERS_FOLLOW_CCITT_1);
              out.add(code);
              isLetterMode = false;
              cachedSpace = false;
            }
          } else {
            var code = _EncodeNumber(language, character);
            if (code != null) {
              if (cachedSpace) {
                out.add(_NUMBERS_FOLLOW_CCITT_1);
                cachedSpace = false;
              }
              return out.add(code);
            }

            code = _EncodeAZ(language, character);
            if (code != null) {
              out.add(_LETTERS_FOLLOW_CCITT_1);
              out.add(code);
              isLetterMode = true;
              cachedSpace = false;
            }
          }
        });
        return out.join(' ');
      break;

    // CCITT 2
    case CCITTCodebook.CCITT_ITA2:
    case CCITTCodebook.CCITT_MTK2:
    case CCITTCodebook.CCITT_USTTY:
        removeAccents(input.toUpperCase()).split('').forEach((character) {
          if (isLetterMode) {
            var code = _EncodeAZ(language, character);
            if (code != null) return out.add(code);

            code = _EncodeNumber(language, character);
            if (code != null) {
              out.add(_NUMBERS_FOLLOW_CCITT_2);
              out.add(code);
              isLetterMode = false;
            }
          } else {
            var code = _EncodeNumber(language, character);
            if (code != null) return out.add(code);

            code = _EncodeAZ(language, character);
            if (code != null) {
              out.add(_LETTERS_FOLLOW_CCITT_2);
              out.add(code);
              isLetterMode = true;
            }
          }
        });

        return out.join(' ');
      break;
  }
}


String encodeCCITT_ITA5(String input) {
  if (input == null || input.length == 0) return '';

  List<int> out = [];
  input.toUpperCase().split('').forEach((character) {
    return out.add(character.codeUnitAt(0));
  });

  return out.join(' ');
}


String decodeCCITT(List<int> values, CCITTCodebook language) {
  if (values == null || values.length == 0) return '';

  String out = '';
  var isLetterMode = true;

  switch (language) {
  // CCITT1
    case CCITTCodebook.CCITT_BAUDOT:
    case CCITTCodebook.CCITT_BAUDOT_MISS:
    case CCITTCodebook.CCITT_ITA1_EU:
    case CCITTCodebook.CCITT_ITA1_UK:
        values.forEach((value) {
          if (value == _NUMBERS_FOLLOW_CCITT_1) {
            if (out.length > 0) out += ' ';
            isLetterMode = false;
            return;
          }

          if (value == _LETTERS_FOLLOW_CCITT_1) {
            out += ' ';
            isLetterMode = true;
            return;
          }

          if (isLetterMode) {
            out += _DecodeAZ(language, value) ?? '';
          } else {
            out += _DecodeNumber(language, value) ?? '';
          }
        });

        return out;
      break;

  // CCITT 2
    case CCITTCodebook.CCITT_ITA2:
    case CCITTCodebook.CCITT_MTK2:
    case CCITTCodebook.CCITT_USTTY:
    values.forEach((value) {
      if (value == _NUMBERS_FOLLOW_CCITT_2) {
        isLetterMode = false;
        return;
      }

      if (value == _LETTERS_FOLLOW_CCITT_2) {
        isLetterMode = true;
        return;
      }

      if (isLetterMode) {
        out += _DecodeAZ(language, value) ?? '';
      } else {
        out += _DecodeNumber(language, value) ?? '';
      }
    });

    return out;      break;
  }
}


String decodeCCITT_ITA5(List<int> values) {
  if (values == null || values.length == 0) return '';

  String out = '';

  values.forEach((value) {
    out = out + String.fromCharCode(value);
  });

  return out;
}
