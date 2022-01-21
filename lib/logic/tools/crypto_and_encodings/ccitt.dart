// Ressources
// 1. US Patent No 388244, 21. August 1888, https://pdfpiw.uspto.gov/.piw?PageNum=0&docid=00388244&IDKey=72154382AC1E%0D%0A&HomeUrl=%2F%2Fpatft.uspto.gov%2Fnetahtml%2FPTO%2Fpatimg.htm
// 2. https://en.wikipedia.org/wiki/Baudot_code
// 3. https://de.wikipedia.org/wiki/Baudot-Code
// 4. https://cryptii.com/pipes/baudot
// 5. https://cryptomuseum.com/ref/ita2/index.htm
// 6. CCITT - ITU
//    6.1 Recommendation S.1 (11/88) International Telegraph Alphabet No. 2 https://www.itu.int/rec/dologin_pub.asp?lang=e&id=T-REC-S.1-195811-S!!PDF-E&type=items
//
// Code Tables
// - CCITT_BAUDOT       according to 1. with Bit-Order 54321
// - CCITT_BAUDOT_MISS  according to 3. ITA1
// - CCITT_ITA1_EU      according to 2.
// - CCITT_ITA1_UK      according to 2.
// - CCITT_ITA2         according to 2., 4., 5.
// - CCITT_MTK2         according to 2.
// - CCITT_USTTY        according to 2., 4.
//


import 'package:gc_wizard/utils/common_utils.dart';

enum CCITTCodebook { BAUDOT, BAUDOT_54123, CCITT_ITA1_1926, CCITT_ITA1_1929, CCITT_ITA1_EU, CCITT_ITA1_UK, CCITT_ITA2_1929, CCITT_ITA2_1931, CCITT_MTK2, CCITT_ITA5, CCITT_USTTY, SIEMENS, MURRAY, WESTERNUNION }

Map<CCITTCodebook, Map<String, String>> CCITT_CODEBOOK = {
  CCITTCodebook.BAUDOT: {'title': 'punchtape_baudot_title', 'subtitle': 'punchtape_baudot_description'},
  CCITTCodebook.BAUDOT_54123: {'title': 'punchtape_baudot_54123_title', 'subtitle': 'punchtape_baudot_54123_description'},
  CCITTCodebook.MURRAY: {'title': 'punchtape_murray_title', 'subtitle': 'punchtape_murray_description'},
  CCITTCodebook.SIEMENS: {'title': 'punchtape_siemens_title', 'subtitle': 'punchtape_siemens_description'},
  CCITTCodebook.WESTERNUNION: {'title': 'punchtape_westernunion_title', 'subtitle': 'punchtape_westernunion_description'},
  CCITTCodebook.CCITT_ITA1_1926: {'title': 'punchtape_ccitt_ita1_1926_title', 'subtitle': 'punchtape_ccitt_ita1_1926_description'},
  CCITTCodebook.CCITT_ITA1_1929: {'title': 'punchtape_ccitt_ita1_1929_title', 'subtitle': 'punchtape_ccitt_ita1_1929_description'},
  CCITTCodebook.CCITT_ITA1_EU: {'title': 'punchtape_ccitt_ita1_eu_title', 'subtitle': 'punchtape_ccitt_ita1_eu_description'},
  CCITTCodebook.CCITT_ITA1_UK: {'title': 'punchtape_ccitt_ita1_uk_title', 'subtitle': 'punchtape_ccitt_ita1_uk_description'},
  CCITTCodebook.CCITT_ITA2_1929: {'title': 'punchtape_ccitt_ita2_1929_title', 'subtitle': 'punchtape_ccitt_ita2_1929_description'},
  CCITTCodebook.CCITT_ITA2_1931: {'title': 'punchtape_ccitt_ita2_1931_title', 'subtitle': 'punchtape_ccitt_ita2_1931_description'},
  CCITTCodebook.CCITT_MTK2: {'title': 'punchtape_ccitt_mtk2_title', 'subtitle': 'punchtape_ccitt_mtk2_description'},
  CCITTCodebook.CCITT_USTTY: {'title': 'punchtape_ccitt_ustty_title', 'subtitle': 'punchtape_ccitt_ustty_description'},
//  CCITTCodebook.CCITT2_ITA5: {'title': 'punchtape_ccitt_ITA5_title', 'subtitle': 'punchtape_ccitt_ITA5_description'},
};

Map<CCITTCodebook, Map<String, int>> punchTapeDefinition = {
  CCITTCodebook.BAUDOT : {'punchHoles' : 5, 'sprocketHole': 0},
  CCITTCodebook.BAUDOT_54123 : {'punchHoles' : 5, 'sprocketHole': 3},
  CCITTCodebook.MURRAY : {'punchHoles' : 5, 'sprocketHole': 0},
  CCITTCodebook.SIEMENS : {'punchHoles' : 5, 'sprocketHole': 0},
  CCITTCodebook.WESTERNUNION : {'punchHoles' : 5, 'sprocketHole': 0},
  CCITTCodebook.CCITT_ITA1_EU : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_ITA1_UK : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_ITA2_1929 : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_ITA2_1931 : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_MTK2 : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_USTTY : {'punchHoles' : 5, 'sprocketHole': 4},
  CCITTCodebook.CCITT_ITA5 : {'punchHoles' : 8, 'sprocketHole': 4},
};

final AZToCCITT_BAUDOT = {
// Original code from US Patent in Bit-Order 54321
  'A': 1,
  'B': 12,
  'C': 13,
  'D': 15,
  'E': 2,
  String.fromCharCode(201) /* É */ : 3,
  'F': 14,
  'G': 10,
  'H': 11,
  'I': 6,
  'J': 9,
  'K': 25,
  'L': 27,
  'M': 26,
  'N': 30,
  'O': 7,
  'P': 31,
  'Q': 29,
  'R': 28,
  'S': 20,
  'T': 21,
  'U': 5,
  'V': 23,
  'W': 22,
  'X': 18,
  'Y': 4,
  'Z': 19,
  '@': 24,
};
final CCITT_BAUDOTToAZ = switchMapKeyValue(AZToCCITT_BAUDOT);

// original Baudot according to US Patent has no numbers
final NumbersToCCITT_BAUDOT = {};
final CCITT_BAUDOTToNumbers = switchMapKeyValue(NumbersToCCITT_BAUDOT);

final AZToBaudot_54123 = {
  // Baudot-Code from DEU Wikipedia in Bit-Orde 54321
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
final Baudot_54123ToAZ = switchMapKeyValue(AZToBaudot_54123);

final NumbersToBaudot_54123 = {
  '1': 4,
  '2': 2,
  '3': 1,
  '4': 5,
  '5': 7,
  '6': 12,
  '7': 10,
  '8': 9,
  '9': 13,
  '0': 15,
  '1/': 6,
  '2/': 21,
  '3/': 3,
  '4/': 14,
  '5/': 11,
  '7/': 17,
  '9/': 18,
  '.': 20,
  '\'': 23,
  ':': 22,
  '?': 19,
  '(': 28,
  ')': 26,
  '-': 25,
  '/': 29,
  '+': 31,
  '=': 30,
  String.fromCharCode(163) /* £ */ : 27,
};
final Baudot_54123ToNumbers = switchMapKeyValue(NumbersToBaudot_54123);

final AZToMurray = {
  'A': 3,
  'B': 25,
  'C': 14,
  'D': 9,
  'E': 1,
  'F': 13,
  'G': 26,
  'H': 20,
  'I': 6,
  'J': 11,
  'K': 15,
  'L': 18,
  'M': 28,
  'N': 12,
  'O': 24,
  'P': 22,
  'Q': 23,
  'R': 10,
  'S': 5,
  'T': 16,
  'U': 7,
  'V': 30,
  'W': 19,
  'X': 29,
  'Y': 21,
  'Z': 17,
  '+': 8,
  ' ': 4
};
final MurrayToAZ = switchMapKeyValue(AZToMurray);

final NumbersToMurray = {
//  'A': 3,
  '/': 25,
  '\'': 14,
  '&': 9,
  '3': 1,
  '!': 13,
  '"': 26,
  ';': 20,
  '8': 6,
  '=': 11,
  '§': 15,
//  'L': 18,
  '?': 28,
  '-': 12,
  '9': 24,
  '0': 22,
  '1': 23,
  '4': 10,
  ':': 5,
  '5': 16,
  '7': 7,
  '(': 30,
  ')': 30,
  '2': 19,
  '%': 29,
  '6': 21,
  ',': 17,
  '.': 8,
  ' ': 4
};
final MurrayToNumbers = switchMapKeyValue(NumbersToMurray);

final AZToWesternunion = {
  'A': 3,
  'B': 25,
  'C': 14,
  'D': 9,
  'E': 1,
  'F': 13,
  'G': 26,
  'H': 20,
  'I': 6,
  'J': 11,
  'K': 15,
  'L': 18,
  'M': 28,
  'N': 12,
  'O': 24,
  'P': 22,
  'Q': 23,
  'R': 10,
  'S': 5,
  'T': 16,
  'U': 7,
  'V': 30,
  'W': 19,
  'X': 29,
  'Y': 21,
  'Z': 17,
  ' ': 4,
  '\r': 8,
  '\n': 2,
};
final WesternunionToAZ = switchMapKeyValue(AZToWesternunion);

final NumbersToWesternunion = {
  '-': 3,
  '?': 25,
  ':': 14,
  '\$': 9,
  '3': 1,
  'city': 13,
  '&': 26,
  '£': 20,
  '8': 6,
  '*': 11,
  '(': 15,
  ')': 18,
  '.': 28,
  ',': 12,
  '9': 24,
  '0': 22,
  '1': 23,
  '4': 10,
  'thru': 5,
  '5': 16,
  '7': 7,
  ';': 30,
  '2': 19,
  '/': 29,
  '6': 21,
  '"': 17,
  ' ': 4,
  '\r': 8,
  '\n': 2,
};
final WesternunionToNumbers = switchMapKeyValue(NumbersToWesternunion);

final AZToSiemens = {
  'A': 6,
  'B': 26,
  'C': 23,
  'D': 17,
  'E': 7,
  'F': 13,
  'G': 27,
  'H': 19,
  'I': 1,
  'J': 18,
  'K': 8,
  'L': 15,
  'M': 2,
  'N': 3,
  'O': 25,
  'P': 22,
  'Q': 20,
  'R': 24,
  'S': 12,
  'T': 16,
  'U': 14,
  'V': 29,
  'W': 9,
  'X': 10,
  'Y': 5,
  'Z': 21,
};
final SiemensToAZ = switchMapKeyValue(AZToSiemens);

final NumbersToSiemens = {
  '.': 6,
  '/': 26,
  '\'': 23,
  '&': 17,
  '3': 7,
  '!': 13,
  '"': 27,
  ';': 19,
  '8': 1,
  '=': 18,
  '§': 8,
  '+': 15,
  '?': 2,
  '-': 3,
  '9': 25,
  '0': 22,
  '1': 20,
  '4': 24,
  ':': 12,
  '5': 16,
  '7': 14,
  ')': 29,
  '2': 9,
  '(': 10,
  '6': 5,
  ',': 21,
};
final SiemensToNumbers = switchMapKeyValue(NumbersToSiemens);


final AZToCCITT_ITA1_EU = {
  // Code according to ENG Wikipedia, Bit-Order 54321
  'A': 1,
  String.fromCharCode(201) /* É */ : 3,
  'E': 2,
  'I': 6,
  'O': 7,
  'U': 5,
  'Y': 6,
  'B': 12,
  'C': 13,
  'D': 15,
  'F': 14,
  'G': 10,
  'H': 11,
  'J': 12,
  'K': 25,
  'L': 27,
  'M': 26,
  'N': 30,
  'P': 31,
  'Q': 29,
  'R': 28,
  'S': 20,
  'T': 21,
  'V': 23,
  'W': 22,
  'X': 18,
  'Z': 19,
  '-': 17,
};
final CCITT_ITA1_EUToAZ = switchMapKeyValue(AZToCCITT_ITA1_EU);

final NumbersToCCITT_ITA1_EU = {
  // Code according to ENG Wikipedia, Bit-Order 54321
  '1': 1,
  '&': 3,
  '2': 2,
  //'': 6, o with double underscore
  '5': 7,
  '4': 5,
  '3': 6,
  '8': 12,
  '9': 13,
  '0': 15,
  //'': 14, f with double underscore
  '7': 10,
  //'': 11, h with double underscore
  '6': 12,
  '(': 25,
  '=': 27,
  ')': 26,
  'N°': 30,
  '%': 31,
  '/': 29,
  '-': 28,
  ';': 20,
  '!': 21,
  '\'': 23,
  '?': 22,
  ',': 18,
  ':': 19,
  '.': 17,
};
final CCITT_ITA1_EUToNumbers = switchMapKeyValue(NumbersToCCITT_ITA1_EU);

final AZToCCITT_ITA1_UK = {
  // Code according to ENG Wikipedia, Bit-Order 54321
  'A': 1,
  '/': 3,
  'E': 2,
  'I': 6,
  'O': 7,
  'U': 5,
  'Y': 6,
  'B': 12,
  'C': 13,
  'D': 15,
  'F': 14,
  'G': 10,
  'H': 11,
  'J': 12,
  'K': 25,
  'L': 27,
  'M': 26,
  'N': 30,
  'P': 31,
  'Q': 29,
  'R': 28,
  'S': 20,
  'T': 21,
  'V': 23,
  'W': 22,
  'X': 18,
  'Z': 19,
  '-': 17,
};
final CCITT_ITA1_UKToAZ = switchMapKeyValue(AZToCCITT_ITA1_UK);

final NumbersToCCITT_ITA1_UK = {
  '1': 1,
  '1/': 3,
  '2': 2,
  '3/': 6,
  '5': 7,
  '4': 5,
  '3': 6,
  '8': 12,
  '9': 13,
  '0': 15,
  '5/': 14,
  '7': 10,
  '¹': 11,
  '6': 12,
  '(': 25,
  '=': 27,
  ')': 26,
  '£': 30,
  '+': 31,
  '/': 29,
  '-': 28,
  '7/': 20,
  '²': 21,
  '¹': 23,
  '?': 22,
  '9/': 18,
  ':': 19,
  '.': 17,
};
final CCITT_ITA1_UKToNumbers = switchMapKeyValue(NumbersToCCITT_ITA1_UK);

final AZToCCITT_ITA2_MTK2 = {
  //according to ENG Wikipedia, Bit-Order 54321
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
  //according to ENG Wikipedia, Bit-Order 54321
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
  //according to ENG Wikipedia, Bit-Order 54321
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
  //according to ENG Wikipedia, Bit-Order 54321
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

final AZToCCITT_ITA1_1926 = {
  'A': 1,
  'B': 12,
  'C': 13,
  'D': 15,
  'E': 2,
  'É': 3,
  'F': 14,
  'G': 10,
  'H': 11,
  'I': 6,
  'J': 9,
  'K': 25,
  'L': 27,
  'M': 26,
  'N': 30,
  'O': 7,
  'P': 31,
  'Q': 29,
  'R': 28,
  'S': 20,
  'T': 21,
  'U': 5,
  'V': 23,
  'W': 22,
  'X': 18,
  'Y': 4,
  'Z': 19,
  'Ṯ': 17,
  '✲': 24,
};
final CCITT_ITA1_1926ToAZ = switchMapKeyValue(AZToCCITT_ITA1_1926);

final AZToCCITT_ITA1_1929 = {
  'A': 1,
  'B': 12,
  'C': 13,
  'D': 15,
  'E': 2,
  'F': 14,
  'G': 10,
  'H': 11,
  'I': 6,
  'J': 9,
  'K': 25,
  'L': 27,
  'M': 26,
  'N': 30,
  'O': 7,
  'P': 31,
  'Q': 29,
  'R': 28,
  'S': 20,
  'T': 21,
  'U': 5,
  'V': 23,
  'W': 22,
  'X': 18,
  'Y': 4,
  'Z': 19,
  '✲': 24,
  '\n': 3,
  '\r': 17,
};
final CCITT_ITA1_1929ToAZ = switchMapKeyValue(AZToCCITT_ITA1_1929);

final AZToCCITT_ITA2_1929 = {
  'A': 1,
  'B': 12,
  'C': 13,
  'D': 15,
  'E': 2,
  'F': 14,
  'G': 10,
  'H': 11,
  'I': 6,
  'J': 9,
  'K': 25,
  'L': 27,
  'M': 26,
  'N': 30,
  'O': 7,
  'P': 24,
  'Q': 29,
  'R': 28,
  'S': 20,
  'T': 21,
  'U': 5,
  'V': 23,
  'W': 22,
  'X': 18,
  'Y': 4,
  'Z': 19,
  '\n': 3,
  '\r': 17,
};
final CCITT_ITA2_1929ToAZ = switchMapKeyValue(AZToCCITT_ITA2_1929);

final AZToCCITT_ITA2_1931 = {
  'A': 3,
  'B': 25,
  'C': 14,
  'D': 9,
  'E': 1,
  'F': 13,
  'G': 26,
  'H': 20,
  'I': 6,
  'J': 11,
  'K': 15,
  'L': 18,
  'M': 28,
  'N': 12,
  'O': 24,
  'P': 22,
  'Q': 23,
  'R': 10,
  'S': 5,
  'T': 16,
  'U': 7,
  'V': 30,
  'W': 19,
  'X': 29,
  'Y': 21,
  'Z': 17,
  ' ': 4,
  '\r': 2,
  '\n': 8,
};
final CCITT_ITA2_1931ToAZ = switchMapKeyValue(AZToCCITT_ITA2_1931);

final NumbersToCCITT_ITA1_1926 = {
  '1': 1,
  '8': 12,
  '9': 13,
  '0': 15,
  '2': 2,
  //'national': 3,
  //'national': 14,
  '7': 10,
  //'national': 11,
  //'national': 6,
  '6': 9,
  '(': 25,
  '=': 27,
  ')': 26,
  '№': 30,
  '5': 7,
  '%': 31,
  '/': 29,
  '-': 28,
  ';': 20,
  '!': 21,
  '4': 5,
  '\'': 23,
  '?': 22,
  ',': 18,
  '3': 4,
  ':': 19,
  '.': 17,
  '✲': 24,
};
final CCITT_ITA1_1926ToNumbers = switchMapKeyValue(NumbersToCCITT_ITA1_1926);

final NumbersToCCITT_ITA1_1929 = {
  '1': 1,
  '8': 12,
  '9': 13,
  '0': 15,
  '2': 2,
  //'national': 14,
  '7': 10,
  //'national': 11,
  //'national': 6,
  '6': 9,
  '(': 25,
  '=': 27,
  ')': 26,
  '+': 30,
  '5': 7,
  '%': 31,
  '/': 29,
  '-': 28,
  '.': 20,
  //'national': 21,
  '4': 5,
  '\'': 23,
  '?': 22,
  ',': 18,
  '3': 4,
  ':': 19,
  '✲': 24,
  '\n': 3,
  '\r': 17,
};
final CCITT_ITA1_1929ToNumbers = switchMapKeyValue(NumbersToCCITT_ITA1_1929);

final NumbersToCCITT_ITA2_1929 = {
  ':': 1,
  '?': 12,
  '(': 13,
  ',': 15,
  '3': 2,
  '/': 14,
  // 'national': 10,
  '+': 11,
  '8': 6,
  '🔔': 9,
  // 'national': 25,
  '=': 27,
  '\'': 26,
  '-': 30,
  '9': 7,
  '0': 24,
  '1': 29,
  '4': 28,
  //'national': 20,
  '5': 21,
  '7': 5,
  ')': 23,
  '2': 22,
  // 'national': 18,
  '6': 4,
  '.': 19,
  '\n': 3,
  '\r': 17,
};
final CCITT_ITA2_1929ToNumbers = switchMapKeyValue(NumbersToCCITT_ITA2_1929);

final NumbersToCCITT_ITA2_1931 = {
  '-': 3,
  '?': 25,
  ':': 14,
  // national : 9
  '3': 1,
  // national : 13
  // national : 26
  // national : 20
  '8': 6,
  '🔔' : 11, // Bell
  '(': 15,
  ')': 18,
  '.': 28,
  ',': 12,
  '9': 24,
  '0': 22,
  '1': 23,
  '4': 10,
  '\'': 5,
  '5': 16,
  '7': 7,
  '=': 30,
  '2': 19,
  '/': 29,
  '6': 21,
  '+': 17,
  ' ': 4,
  '\r': 2,
  '\n': 8,
};
final CCITT_ITA2_1931ToNumbers = switchMapKeyValue(NumbersToCCITT_ITA2_1931);


final _NUMBERS_FOLLOW = {
  CCITTCodebook.BAUDOT_54123 : 8,
  CCITTCodebook.CCITT_ITA1_1926 : 8,
  CCITTCodebook.CCITT_ITA1_1929 : 8,
  CCITTCodebook.CCITT_ITA1_EU : 8,
  CCITTCodebook.CCITT_ITA1_UK : 8,
  CCITTCodebook.CCITT_ITA2_1929 : 8,
  CCITTCodebook.CCITT_ITA2_1931 : 27,
  CCITTCodebook.CCITT_MTK2 : 27,
  CCITTCodebook.CCITT_USTTY : 27,
  CCITTCodebook.SIEMENS : 30,
  CCITTCodebook.MURRAY : 27,
  CCITTCodebook.WESTERNUNION : 27,
};
final _LETTERS_FOLLOW = {
  CCITTCodebook.BAUDOT_54123 : 16,
  CCITTCodebook.CCITT_ITA1_1926 : 16,
  CCITTCodebook.CCITT_ITA1_1929 : 16,
  CCITTCodebook.CCITT_ITA1_EU : 16,
  CCITTCodebook.CCITT_ITA1_UK : 16,
  CCITTCodebook.CCITT_ITA2_1929 : 16,
  CCITTCodebook.CCITT_ITA2_1931 : 31,
  CCITTCodebook.CCITT_MTK2 : 31,
  CCITTCodebook.CCITT_USTTY : 31,
  CCITTCodebook.SIEMENS : 28,
  CCITTCodebook.MURRAY : 31,
  CCITTCodebook.WESTERNUNION : 31,
};


int _EncodeAZ(CCITTCodebook language, String text){
    switch (language) {
      case CCITTCodebook.BAUDOT: return AZToCCITT_BAUDOT[text]; break;
      case CCITTCodebook.BAUDOT_54123: return AZToBaudot_54123[text]; break;
      case CCITTCodebook.CCITT_ITA1_1926: return AZToCCITT_ITA1_1926[text]; break;
      case CCITTCodebook.CCITT_ITA1_1929: return AZToCCITT_ITA1_1929[text]; break;
      case CCITTCodebook.CCITT_ITA1_EU: return AZToCCITT_ITA1_EU[text]; break;
      case CCITTCodebook.CCITT_ITA1_UK: return AZToCCITT_ITA1_UK[text]; break;
      case CCITTCodebook.CCITT_ITA2_1929: return AZToCCITT_ITA2_1929[text]; break;
      case CCITTCodebook.CCITT_ITA2_1931: return AZToCCITT_ITA2_1931[text]; break;
      case CCITTCodebook.CCITT_MTK2: return AZToCCITT_ITA2_MTK2[text]; break;
      case CCITTCodebook.CCITT_USTTY: return AZToCCITT_USTTY[text]; break;
      case CCITTCodebook.MURRAY: return AZToMurray[text]; break;
      case CCITTCodebook.SIEMENS: return AZToSiemens[text]; break;
      case CCITTCodebook.WESTERNUNION: return AZToWesternunion[text]; break;
    }
}

int _EncodeNumber(CCITTCodebook language, String text){
    switch (language) {
      case CCITTCodebook.BAUDOT: return NumbersToCCITT_BAUDOT[text]; break;
      case CCITTCodebook.BAUDOT_54123: return NumbersToBaudot_54123[text]; break;
      case CCITTCodebook.CCITT_ITA1_1926: return NumbersToCCITT_ITA1_1926[text]; break;
      case CCITTCodebook.CCITT_ITA1_1929: return NumbersToCCITT_ITA1_1929[text]; break;
      case CCITTCodebook.CCITT_ITA1_EU: return NumbersToCCITT_ITA1_EU[text]; break;
      case CCITTCodebook.CCITT_ITA1_UK: return NumbersToCCITT_ITA1_UK[text]; break;
      case CCITTCodebook.CCITT_ITA2_1929: return NumbersToCCITT_ITA2_1929[text]; break;
      case CCITTCodebook.CCITT_ITA2_1931: return NumbersToCCITT_ITA2_1931[text]; break;
      case CCITTCodebook.CCITT_MTK2: return NumbersToCCITT_MTK2[text]; break;
      case CCITTCodebook.CCITT_USTTY: return NumbersToCCITT_ITA2_USTTY[text]; break;
      case CCITTCodebook.MURRAY: return NumbersToMurray[text]; break;
      case CCITTCodebook.SIEMENS: return NumbersToSiemens[text]; break;
      case CCITTCodebook.WESTERNUNION: return NumbersToWesternunion[text]; break;
    }
}

String _DecodeAZ(CCITTCodebook language, int code){
    switch (language) {
      case CCITTCodebook.BAUDOT: return CCITT_BAUDOTToAZ[code]; break;
      case CCITTCodebook.BAUDOT_54123: return Baudot_54123ToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA1_1926: return CCITT_ITA1_1926ToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA1_1929: return CCITT_ITA1_1929ToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA1_EU: return CCITT_ITA1_EUToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA1_UK: return CCITT_ITA1_UKToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA2_1929: return CCITT_ITA2_1929ToAZ[code]; break;
      case CCITTCodebook.CCITT_ITA2_1931: return CCITT_ITA2_1931ToAZ[code]; break;
      case CCITTCodebook.CCITT_MTK2: return CCITT_ITA2_MTK2ToAZ[code]; break;
      case CCITTCodebook.CCITT_USTTY: return CCITT_USTTYToAZ[code]; break;
      case CCITTCodebook.MURRAY: return MurrayToAZ[code]; break;
      case CCITTCodebook.SIEMENS: return SiemensToAZ[code]; break;
      case CCITTCodebook.WESTERNUNION: return WesternunionToAZ[code]; break;
    }
}

String _DecodeNumber(CCITTCodebook language, int code){
    switch (language) {
      case CCITTCodebook.BAUDOT: return CCITT_BAUDOTToNumbers[code]; break;
      case CCITTCodebook.BAUDOT_54123: return Baudot_54123ToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA1_1926: return CCITT_ITA1_1926ToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA1_1929: return CCITT_ITA1_1929ToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA1_EU: return CCITT_ITA1_EUToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA1_UK: return CCITT_ITA1_UKToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA2_1929: return CCITT_ITA2_1929ToNumbers[code]; break;
      case CCITTCodebook.CCITT_ITA2_1931: return CCITT_ITA2_1931ToNumbers[code]; break;
      case CCITTCodebook.CCITT_MTK2: return CCITT_MTK2ToNumbers[code]; break;
      case CCITTCodebook.CCITT_USTTY: return CCITT_USTTYToNumbers[code]; break;
      case CCITTCodebook.MURRAY: return MurrayToNumbers[code]; break;
      case CCITTCodebook.SIEMENS: return SiemensToNumbers[code]; break;
      case CCITTCodebook.WESTERNUNION: return WesternunionToNumbers[code]; break;
    }
}


String encodeCCITT(String input, CCITTCodebook language) {
  if (input == null || input.length == 0) return '';

  var isLetterMode = true;

  List<int> out = [];

  switch (language) {
    // CCITT1
    case CCITTCodebook.BAUDOT:
    case CCITTCodebook.BAUDOT_54123:
    case CCITTCodebook.MURRAY:
    case CCITTCodebook.SIEMENS:
    case CCITTCodebook.WESTERNUNION:
    case CCITTCodebook.CCITT_ITA1_1926:
    case CCITTCodebook.CCITT_ITA1_1929:
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
                out.add(_LETTERS_FOLLOW[language]);
                cachedSpace = false;
              }
              return out.add(code);
            }

            code = _EncodeNumber(language, character);
            if (code != null) {
              out.add(_NUMBERS_FOLLOW[language]);
              isLetterMode = false;
              cachedSpace = false;
            }
          } else {
            var code = _EncodeNumber(language, character);
            if (code != null) {
              if (cachedSpace) {
                out.add(_NUMBERS_FOLLOW[language]);
                cachedSpace = false;
              }
              return out.add(code);
            }

            code = _EncodeAZ(language, character);
            if (code != null) {
              out.add(_LETTERS_FOLLOW[language]);
              out.add(code);
              isLetterMode = true;
              cachedSpace = false;
            }
          }
        });
        return out.join(' ');
      break;

    // CCITT 2
    case CCITTCodebook.CCITT_ITA2_1929:
    case CCITTCodebook.CCITT_ITA2_1931:
    case CCITTCodebook.CCITT_MTK2:
    case CCITTCodebook.CCITT_USTTY:
        removeAccents(input.toUpperCase()).split('').forEach((character) {
          if (isLetterMode) {
            var code = _EncodeAZ(language, character);
            if (code != null) return out.add(code);

            code = _EncodeNumber(language, character);
            if (code != null) {
              out.add(_NUMBERS_FOLLOW[language]);
              out.add(code);
              isLetterMode = false;
            }
          } else {
            var code = _EncodeNumber(language, character);
            if (code != null) return out.add(code);

            code = _EncodeAZ(language, character);
            if (code != null) {
              out.add(_LETTERS_FOLLOW[language]);
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
    case CCITTCodebook.BAUDOT:
    case CCITTCodebook.BAUDOT_54123:
    case CCITTCodebook.CCITT_ITA1_EU:
    case CCITTCodebook.CCITT_ITA1_UK:
        values.forEach((value) {
          if (value == _NUMBERS_FOLLOW[language]) {
            if (out.length > 0) out += ' ';
            isLetterMode = false;
            return;
          }

          if (value == _LETTERS_FOLLOW[language]) {
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
    case CCITTCodebook.CCITT_ITA2_1929:
    case CCITTCodebook.CCITT_ITA2_1931:
    case CCITTCodebook.CCITT_MTK2:
    case CCITTCodebook.CCITT_USTTY:
    values.forEach((value) {
      if (value == _NUMBERS_FOLLOW[language]) {
        isLetterMode = false;
        return;
      }

      if (value == _LETTERS_FOLLOW[language]) {
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
