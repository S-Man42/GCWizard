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

final NumbersToCCITT1 = {
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
final CCITT1ToNumbers = switchMapKeyValue(NumbersToCCITT1);

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

final NumbersToCCITT_ITA2_MTK2 = {
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
final CCITT_ITA2_MTK2ToNumbers = switchMapKeyValue(NumbersToCCITT_ITA2_MTK2);

final AZToCCITT_ITA2_USTTY = {
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
final CCITT_ITA2_USTTYToAZ = switchMapKeyValue(AZToCCITT_ITA2_USTTY);

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
final CCITT2_USTTYToNumbers = switchMapKeyValue(NumbersToCCITT_ITA2_USTTY);

final _NUMBERS_FOLLOW = 27;
final _LETTERS_FOLLOW = 31;

String encodeCCITT(String input, CCITTCodebook language) {
  if (input == null || input.length == 0) return '';

  var isLetterMode = true;

  List<int> out = [];
  removeAccents(input.toUpperCase()).split('').forEach((character) {
    var code;
    if (isLetterMode) {
      switch (language) {
        case CCITTCodebook.CCITT_ITA2: code = AZToCCITT_ITA2[character]; break;
        case CCITTCodebook.CCITT_MTK2: code = AZToCCITT_ITA2_MTK2[character]; break;
        case CCITTCodebook.CCITT_USTTY: code = AZToCCITT_ITA2_USTTY[character]; break;
      }

      if (code != null) return out.add(code);

      switch (language) {
        case CCITTCodebook.CCITT_ITA2: code = NumbersToCCITT_ITA2[character]; break;
        case CCITTCodebook.CCITT_MTK2: code = NumbersToCCITT_ITA2_MTK2[character]; break;
        case CCITTCodebook.CCITT_USTTY: code = NumbersToCCITT_ITA2_USTTY[character]; break;
      }
      if (code != null) {
        out.add(_NUMBERS_FOLLOW);
        out.add(code);
        isLetterMode = false;
      }
    } else {
      switch (language) {
        case CCITTCodebook.CCITT_ITA2: code = NumbersToCCITT_ITA2[character]; break;
        case CCITTCodebook.CCITT_MTK2: code = NumbersToCCITT_ITA2_MTK2[character]; break;
        case CCITTCodebook.CCITT_USTTY: code = NumbersToCCITT_ITA2_USTTY[character]; break;
      }
      if (code != null) return out.add(code);

      switch (language) {
        case CCITTCodebook.CCITT_ITA2: code = AZToCCITT_ITA2[character]; break;
        case CCITTCodebook.CCITT_MTK2: code = AZToCCITT_ITA2_MTK2[character]; break;
        case CCITTCodebook.CCITT_USTTY: code = AZToCCITT_ITA2_USTTY[character]; break;
      }
      if (code != null) {
        out.add(_LETTERS_FOLLOW);
        out.add(code);
        isLetterMode = true;
      }
    }
  });

  return out.join(' ');
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

  values.forEach((value) {
    if (value == _NUMBERS_FOLLOW) {
      isLetterMode = false;
      return;
    }

    if (value == _LETTERS_FOLLOW) {
      isLetterMode = true;
      return;
    }

    if (isLetterMode) {
      switch (language) {
        case CCITTCodebook.CCITT_ITA2: out += CCITT_ITA2ToAZ[value] ?? ''; break;
        case CCITTCodebook.CCITT_MTK2: out += CCITT_ITA2ToAZ[value] ?? ''; break;
        case CCITTCodebook.CCITT_USTTY: out += CCITT_ITA2ToAZ[value] ?? ''; break;
      }
    } else {
      switch (language) {
        case CCITTCodebook.CCITT_ITA2: out += CCITT_ITA2ToNumbers[value] ?? ''; break;
        case CCITTCodebook.CCITT_MTK2: out += CCITT_ITA2ToNumbers[value] ?? ''; break;
        case CCITTCodebook.CCITT_USTTY: out += CCITT_ITA2ToNumbers[value] ?? ''; break;
      }

    }
  });

  return out;
}


String decodeCCITT_ITA5(List<int> values) {
  if (values == null || values.length == 0) return '';

  String out = '';

  values.forEach((value) {
    out = out + String.fromCharCode(value);
  });

  return out;
}
