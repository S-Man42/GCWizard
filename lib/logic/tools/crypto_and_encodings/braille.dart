import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
// https://www.pharmabraille.com/wp-content/uploads/2014/11/World-Braille-Usage-Third-Edition-1.pdf
// - English   p. 175 ff
// - French    p. 180 ff
// - German    p. 182 ff

// https://de.wikipedia.org/wiki/Brailleschrift
// https://www.pharmabraille.com/wp-content/uploads/2015/01/system_d_blindenschrift_7620.pdf

// https://en.wikipedia.org/wiki/Braille
// https://en.wikipedia.org/wiki/English_Braille
// http://www.acb.org/tennessee/braille.html
// https://www.pharmabraille.com/wp-content/uploads/2015/11/Rules-of-Unified-English-Braille-2013.pdf

// https://fr.wikipedia.org/wiki/Braille
// https://www.pharmabraille.com/wp-content/uploads/2015/01/CBFU_edition_internationale.pdf

// http://www.braille.ch/index.html#computer

// Examples
// DEU GC1WPAE Braille https://www.geocaching.com/geocache/GC1WPAE_braille
// DEU GC1N24V Code Braille https://www.geocaching.com/geocache/GC1N24V_code-braille
// NLD GC5PZ8Z Braille https://www.geocaching.com/geocache/GC5PZ8Z_braille
// USA GC5X6C8 Braille Numbers https://www.geocaching.com/geocache/GC5X6C8_braille-numbers
// USA GC7QK85 (Braille Cube)³ https://www.geocaching.com/geocache/GC7QK85_braille-cube

final SWITCH_NUMBERFOLLOWS = ['3', '4', '5', '6'];
final SWITCH_ANTOINE = ['6'];
final COMPOSED_4 = ['4'];
final COMPOSED_456 = ['4', '5', '6'];
final COMPOSED_6 = ['6'];

enum BrailleLanguage { BASIC, SIMPLE, DEU, ENG, FRA, EUR }

final Map<String, List<String>> _charsToSegmentsLetters = {
  ' ': [],
  'a': ['1'],
  'b': ['1', '2'],
  'c': ['1', '4'],
  'd': ['1', '4', '5'],
  'e': ['1', '5'],
  'f': ['1', '2', '4'],
  'g': ['1', '2', '4', '5'],
  'h': ['1', '2', '5'],
  'i': ['2', '4'],
  'j': ['2', '4', '5'],
  'k': ['1', '3'],
  'l': ['1', '2', '3'],
  'm': ['1', '3', '4'],
  'n': ['1', '3', '4', '5'],
  'o': ['1', '3', '5'],
  'p': ['1', '2', '3', '4'],
  'q': ['1', '2', '3', '4', '5'],
  'r': ['1', '2', '3', '5'],
  's': ['2', '3', '4'],
  't': ['2', '3', '4', '5'],
  'u': ['1', '3', '6'],
  'v': ['1', '2', '3', '6'],
  'w': ['2', '4', '5', '6'],
  'x': ['1', '3', '4', '6'],
  'y': ['1', '3', '4', '5', '6'],
  'z': ['1', '3', '5', '6'],
};

final Map<String, List<String>> _charsToSegmentsDigits = {
  '1': ['1'],
  '2': ['1', '2'],
  '3': ['1', '4'],
  '4': ['1', '4', '5'],
  '5': ['1', '5'],
  '6': ['1', '2', '4'],
  '7': ['1', '2', '4', '5'],
  '8': ['1', '2', '5'],
  '9': ['2', '4'],
  '0': ['2', '4', '5'],
};

final Map<String, List<String>> _charsToSegmentsAntoine = {
  '1': ['1', '6'],
  '2': ['1', '2', '6'],
  '3': ['1', '4', '6'],
  '4': ['1', '4', '5', '6'],
  '5': ['1', '5', '6'],
  '6': ['1', '2', '4', '6'],
  '7': ['1', '2', '4', '5', '6'],
  '8': ['1', '2', '5', '6'],
  '9': ['2', '4', '6'],
  '0': ['3', '4', '5', '6'],
};

final Map<String, List<String>> _charsToSegmentsDEULetters = {
  'ä': ['3', '4', '5'],
  'ö': ['2', '4', '6'],
  'ü': ['1', '2', '5', '6'],
  'ß': ['2', '3', '4', '6'],
  // Vollschrift
  'au': ['1', '6'],
  'eu': ['1', '2', '6'],
  'ei': ['1', '4', '6'],
  'ch': ['1', '4', '5', '6'],
  'sch': ['1', '5', '6'],
  'st': ['2', '3', '4', '5', '6'],
  'äu': ['3', '4'],
  'ie': ['3', '4', '6'],
};
final Map<String, List<String>> _charsToSegmentsDEUSymbols = {
  // Basis Interpunktions- und Sonderzeichen
  ',': ['2'],
  ';': ['2', '3'],
  ':': ['2', '5'],
  '?': ['2', '6'],
  '!': ['2', '3', '5'],
  '(': ['2', '3', '5', '6'],
  ')': ['2', '3', '5', '6'],
  '„': ['2', '3', '6'],
  '“': ['3', '5', '6'],
  '.': ['3'],
  '-': ['3', '6'],
  "'": ['6'], // small letters follows
  '§': ['3', '4', '6'],
};

final _DEUmulti = {
  '—',
  '*',
  '[',
  ']',
  '‘',
  '‚',
  '|',
  '…',
  '→',
  '←',
  '&',
  '%',
  '‰',
  '°',
  '’',
  '"',
  '\\',
  '@',
  '€',
  '£',
  '\$',
  '¢',
  '/',
};
final Map<String, List<List<String>>> _charsetDEUmulti = {
  // composed 3
  '…': [
    ['3'],
    ['3'],
    ['3']
  ],
  // composed 4
  '→': [
    ['4'],
    ['2', '5'],
    ['2'],
  ],
  '←': [
    ['4'],
    ['5'],
    ['2', '5']
  ],
  '°': [
    ['4'],
    ['3', '5', '6']
  ],
  '^': [
    ['4'],
    ['3', '4', '6']
  ],
  '’': [
    ['4'],
    ['3', '5']
  ],
  '"': [
    ['4'],
    ['3', '5'],
    ['3', '5']
  ],
  '\\': [
    ['4'],
    ['3', '4']
  ],
  '@': [
    ['4'],
    ['3', '4', '5']
  ],
  '€': [
    ['4'],
    ['1', '5']
  ],
  '£': [
    ['4'],
    ['4', '5', '6']
  ],
  '\$': [
    ['4'],
    ['2', '3', '4']
  ],
  '¢': [
    ['4'],
    ['1', '4']
  ],
  '*': [
    ['4'],
    ['3', '5']
  ],
  '√': [
    ['4'],
    ['1', '4', '6']
  ],
  '×'
      '•'
  // composed 5
  '&': [
    ['5'],
    ['1', '3', '6']
  ],
  '/' : [
    ['5'],
    ['2']
  ],
  // composed 6
  '—': [
    ['6'],
    ['3', '6']
  ],
  '[': [
    ['6'],
    ['2', '3', '5', '6']
  ],
  ']': [
    ['6'],
    ['2', '3', '5', '6']
  ],
  '‘': [
    ['6'],
    ['3', '5', '6']
  ],
  '‚': [
    ['6'],
    ['2', '3', '6']
  ],
  // composed 56

  // composed 456
  '|': [
    ['4', '5', '6'],
    ['1', '2', '3']
  ],
  // composed 3456
  '%': [
    ['3', '4', '5', '6'],
    ['2', '4', '5'],
    ['3', '5', '6']
  ],
  '‰': [
    ['3', '4', '5', '6'],
    ['2', '4', '5'],
    ['3', '5', '6'],
    ['3', '5', '6']
  ],
};

final _DEUswitches = {
  'ONECAPITALFOLLOWS',
  'CAPITALFOLLOWS',
  'SMALLLETTERFOLLOWS',
  'NUMBERFOLLOWS',
  'COMPOSED_4',
  'COMPOSED_5',
  'COMPOSED_6',
  'COMPOSED_56',
  'COMPOSED_456',
  'COMPOSED_3456',
};
final Map<String, List<String>> _charsetDEUswitches = {
  'ONECAPITALFOLLOWS': ['4', '6'],
  'CAPITALFOLLOWS': ['4', '5'],
  'SMALLLETTERFOLLOWS': ['6'],
  'NUMBERFOLLOWS': ['3', '4', '5', '6'],
  'COMPOSED_4': ['4'],
  'COMPOSED_5': ['5'],
  'COMPOSED_6': ['6'],
  'COMPOSED_56': ['5', '6'],
  'COMPOSED_456': ['4', '5', '6'],
  'COMPOSED_3456': ['3', '4', '5', '6'],
};
var _segmentsToDEUswitches = switchMapKeyValue(_charsetDEUswitches);




final Map<String, List<String>> _charsToSegmentsENGLetters = {
  'and': ['1', '2', '3', '4', '6'],
  'for': ['1', '2', '3', '4', '5', '6'],
  'of': ['1', '2', '3', '5', '6'],
  'the': ['2', '3', '4', '6'],
  'with': ['2', '3', '4', '5', '6'],
  'ch': ['1', '6'],
  'gh': ['1', '2', '6'],
  'sh': ['1', '4', '6'],
  'th': ['1', '4', '5', '6'],
  'wh': ['1', '5', '6'],
  'ed': ['1', '2', '4', '6'],
  'er': ['1', '2', '4', '5', '6'],
  'ou': ['1', '2', '5', '6'],
  'ow': ['2', '4', '6'],
  'st': ['3', '4'], //    or /
  'ar': ['3', '4', '5'],
  'ing': ['3', '4', '6'],
  'ble': ['3', '4', '5', '6'],
  'bb': ['2', '3'],
  'cc': ['2', '5'],
  'en': ['2', '6'],
  'ff': ['2', '3', '5'],
  'in': ['3', '5'],
  'by': ['3', '5', '6'],
};
final Map<String, List<String>> _charsToSegmentsENGSymbols = {
  ',': ['2'],
  ';': ['2', '3'],
  ':': ['2', '5'],
  '.': ['2', '5', '6'],
  '?': ['2', '3', '6'],
  '!': ['2', '3', '5'],
  '+': ['2', '3', '5'],
  '#': ['3', '4', '5', '6'], // number follows
  '=': ['2', '3', '5', '6'],
  '-': ['3', '6'],
  '§': ['3', '4', '6'],
  '"': ['2', '3', '6'],
  "'": ['4'],
  '~': ['5'],
  '>': ['4', '5'],
  '<': ['5', '6'],
  '/': ['3', '4'],
  '_': ['3', '6'],
};
final Map<String, List<String>> _charsetENGswitches = {
  'ONECAPITALFOLLOWS': ['4', '6'],
  'CAPITALFOLLOWS': ['4', '5'],
  'SMALLLETTERFOLLOWS': ['6'],
  'NUMBERFOLLOWS': ['3', '4', '5', '6'],
  'COMPOSED_4': ['4'],
  'COMPOSED_5': ['5'],
  'COMPOSED_6': ['6'],
  'COMPOSED_456': ['4', '5', '6'],
};
var _segmentsToENGswitches = switchMapKeyValue(_charsetENGswitches);



final Map<String, List<String>> _charsToSegmentsFRALetters = {
  'à': ['1', '2', '3', '5', '6'],
  'â': ['1', '6'],
  'ç': ['1', '2', '3', '4', '6'],
  'è': ['2', '3', '4', '6'],
  'é': ['1', '2', '3', '4', '5', '6'],
  'ê': ['1', '2', '6'],
  'ë': ['1', '2', '4', '6'],
  'î': ['1', '4', '6'],
  'ï': ['1', '2', '4', '5', '6'],
  'ô': ['1', '4', '5', '6'],
  'œ': ['2', '4', '6'],
  'ù': ['2', '3', '4', '5', '6'],
  'û': ['1', '5', '6'],
  'ü': ['1', '2', '5', '6'],
};
final Map<String, List<String>> _charsToSegmentsAntoineLetters = {
  'â': ['1', '6'], // 1
  'ê': ['1', '2', '6'], // 2
  'î': ['1', '4', '6'], // 3
  'ô': ['1', '4', '5', '6'], // 4
  'û': ['1', '5', '6'], // 5
  'ë': ['1', '2', '4', '6'], // 6
  'ï': ['1', '2', '4', '5', '6'], // 7
  'ü': ['1', '2', '5', '6'], // 8
  'œ': ['2', '4', '6'], // 9
  'NUMBERFOLLOWS': ['3', '4', '5', '6'], // 0
};
final Map<String, List<String>> _charsToSegmentsFRASymbols = {
  // Punctuation
  ',': ['2'],
  ';': ['2', '3'],
  ':': ['2', '5'],
  '.': ['2', '5', '6'],
  '?': ['2', '6'],
  '!': ['2', '3', '5'],
  '"': ['2', '3', '5', '6'],
  '«': ['2', '3', '5', '6'],
  '»': ['2', '3', '5', '6'],
  '“': ['2', '3', '5', '6'],
  '”': ['2', '3', '5', '6'],
  '‘': ['2', '3', '5', '6'],
  '’': ['2', '3', '5', '6'],
  '(': ['2', '3', '6'],
  ')': ['3', '5', '6'],
  "'": ['3'],
  '/': ['3', '4'],
  '@': ['3', '4', '5'],
  '-': ['3', '6'],
};

final _FRAmath = {
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0',
  '+',
  '-',
  '=',
  '×',
  '÷'
};
final Map<String, List<List<String>>> _charsetFRAmath = {
  //  mathmatics symbols or number follows  ['6'],
  '1': [
    ['6'],
    ['1', '6']
  ],
  '2': [
    ['6'],
    ['1', '2', '6']
  ],
  '3': [
    ['6'],
    ['1', '4', '6']
  ],
  '4': [
    ['6'],
    ['1', '4', '5', '6']
  ],
  '5': [
    ['6'],
    ['1', '5', '6']
  ],
  '6': [
    ['6'],
    ['1', '2', '4', '6']
  ],
  '7': [
    ['6'],
    ['1', '2', '4', '5', '6']
  ],
  '8': [
    ['6'],
    ['1', '2', '5', '6']
  ],
  '9': [
    ['6'],
    ['2', '4', '6']
  ],
  '0': [
    ['6'],
    ['3', '4', '5', '6']
  ],
  '+': [
    ['6'],
    ['2', '3', '5']
  ],
  '-': [
    ['6'],
    ['3', '6']
  ],
  '=': [
    ['6'],
    ['2', '3', '5', '6']
  ],
  '×': [
    ['6'],
    ['2', '3']
  ],
  '÷': [
    ['6'],
    ['2', '5']
  ],
};
final _FRAmulti = {
  '☐',
  '↔',
  '…',
  '→',
  '←',
  '–',
  '¢',
  '€',
  '£',
  'µ',
  'π',
  '\$',
  '¥',
  '≤',
  '≥',
  '[',
  ']',
  '©',
  '°',
  '§',
  '®',
  '™',
  '&',
  '<',
  '>',
  '~',
  '*',
  '\\',
  '#',
  '%',
  '‰',
  '_',
  '{',
  '}'
};
final Map<String, List<List<String>>> _charsetFRAmulti = {
  //  typographic symbols follows
  '☐': [
    ['1', '2', '3', '4', '6'],
    ['1', '3', '4', '5', '6']
  ],
  '↔': [
    ['2', '4', '6'],
    ['2', '5'],
    ['1', '3', '5']
  ],
  '←': [
    ['2', '4', '6'],
    ['2', '5'],
    ['2', '5']
  ],
  '→': [
    ['2', '5'],
    ['2', '5'],
    ['1', '3', '5']
  ],
  '…': [
    ['2', '5', '6'],
    ['2', '5', '6'],
    ['2', '5', '6']
  ],
  '–': [
    ['3', '6'],
    ['3', '6']
  ],
  //  typographic symbols follows  ['4', '5'],
  '¢': [
    ['4', '5'],
    ['1', '4']
  ],
  '€': [
    ['4', '5'],
    ['1', '5']
  ],
  '£': [
    ['4', '5'],
    ['1', '2', '3']
  ],
  'µ': [
    ['4', '5'],
    ['1', '3', '4']
  ],
  'π': [
    ['4', '5'],
    ['1', '2', '3', '4']
  ],
  '\$': [
    ['4', '5'],
    ['2', '3', '4']
  ],
  '¥': [
    ['4', '5'],
    ['1', '3', '4', '5', '6']
  ],
  '≤': [
    ['4', '5'],
    ['1', '2', '6']
  ],
  '≥': [
    ['4', '5'],
    ['3', '4', '5']
  ],
  '[': [
    ['4', '5'],
    ['2', '3', '6']
  ],
  ']': [
    ['3', '5', '6'],
    ['1', '2']
  ],
//  typographic symbols follows  ['5'],
  '©': [
    ['5'],
    ['1', '4']
  ],
  '°': [
    ['5'],
    ['1', '3', '5']
  ],
  '§': [
    ['5'],
    ['1', '2', '3', '4']
  ],
  '®': [
    ['5'],
    ['1', '2', '3', '5']
  ],
  '™': [
    ['5'],
    ['2', '3', '4', '5']
  ],
  '&': [
    ['5'],
    ['1', '2', '3', '4', '5', '6']
  ],
  '<': [
    ['5'],
    ['1', '2', '6']
  ],
  '>': [
    ['5'],
    ['3', '4', '5']
  ],
  '~': [
    ['5'],
    ['2', '6']
  ],
  '*': [
    ['5'],
    ['3', '5']
  ],
  '\\': [
    ['5'],
    ['3', '4']
  ],
  '#': [
    ['5'],
    ['3', '4', '5', '6']
  ],
  '%': [
    ['5'],
    ['3', '4', '6']
  ],
  '‰': [
    ['5'],
    ['3', '4', '6'],
    ['3', '4', '6']
  ],
  '_': [
    ['5'],
    ['3', '6']
  ],
  '{': [
    ['6'],
    ['6'],
    ['2', '3', '6']
  ],
  '}': [
    ['3', '5', '6'],
    ['3'],
    ['3']
  ],
};

final _FRAswitches = {'CAPITALFOLLOWS', 'NUMBERFOLLOWS', 'MATHFOLLOWS'};
final Map<String, List<String>> _charsetFRAswitches = {
  'CAPITALFOLLOWS': ['4', '5'],
  'NUMBERFOLLOWS': ['3', '4', '5', '6'],
  'MATHFOLLOWS': ['6']
};
var _segmentsToFRAswitches = switchMapKeyValue(_charsetFRAswitches);

final Map<String, List<String>> _charsToSegmentsEUR = {
  // http://fakoo.de/braille/computerbraille-text.html
  'NUL': ['3', '4', '5', '7', '8'],
  'SOH': ['1', '7', '8'],
  'STX': ['1', '2', '7', '8'],
  'ETX': ['1', '4', '7', '8'],
  'EOT': ['1', '4', '5', '7', '8'],
  'ENQ': ['1', '5', '7', '8'],
  'ACK': ['1', '2', '4', '7', '8'],
  'BEL': ['1', '2', '4', '5', '7', '8'],
  'BS': ['1', '2', '5', '7', '8'],
  'HT': ['2', '4', '7', '8'],
  'LF': ['2', '4', '5', '7', '8'],
  'VT': ['1', '3', '7', '8'],
  'FF': ['1', '2', '3', '7', '8'],
  'CR': ['1', '3', '4', '7', '8'],
  'SO': ['1', '3', '4', '5', '7', '8'],
  'SI': ['1', '3', '5', '7', '8'],
  'DLE': ['1', '2', '3', '4', '7', '8'],
  'DC1': ['1', '2', '3', '4', '5', '7', '8'],
  'DC2': ['1', '2', '3', '5', '7', '8'],
  'DC3': ['2', '3', '4', '7', '8'],
  'DC4': ['2', '3', '4', '5', '7', '8'],
  'NAK': ['1', '3', '6', '7', '8'],
  'SYN': ['1', '2', '3', '6', '7', '8'],
  'ETB': ['2', '4', '5', '6', '7', '8'],
  'CAN': ['1', '3', '4', '6', '7', '8'],
  'EM': ['1', '3', '4', '5', '6', '7', '8'],
  'SUB': ['1', '3', '5', '6', '7', '8'],
  'ESC': ['1', '2', '3', '5', '6', '7', '8'],
  'FS': ['3', '4', '7', '8'],
  'GS': ['2', '3', '4', '5', '6', '7', '8'],
  'RS': ['2', '3', '4', '6', '7', '8'],
  'US': ['4', '5', '6', '7', '8'],
  ' ': [],
  '!': ['5'],
  '"': ['4'],
  '#': ['3', '4', '5', '6'],
  '\$': ['4', '6'],
  '%': ['1', '2', '3', '4', '5', '6'],
  '&': ['1', '2', '3', '4', '6'],
  "'": ['6'],
  '(': ['2', '3', '6'],
  ')': ['3', '5', '6'],
  '*': ['3', '5'],
  '+': ['2', '3', '5'],
  ',': ['2'],
  '-': ['3', '6'],
  '.': ['3'],
  '/': ['2', '5', '6'],
  '0': ['3', '4', '6'],
  '1': ['1', '6'],
  '2': ['1', '2', '6'],
  '3': ['1', '4', '6'],
  '4': ['1', '4', '5', '6'],
  '5': ['1', '5', '6'],
  '6': ['1', '2', '4', '6'],
  '7': ['1', '2', '4', '5', '6'],
  '8': ['1', '2', '5', '6'],
  '9': ['2', '4', '6'],
  ':': ['2', '5'],
  ';': ['2', '3'],
  '<': ['5', '6'],
  '=': ['2', '3', '5', '6'],
  '>': ['4', '5'],
  '?': ['2', '6'],
  '@': ['3', '4', '5', '7'],
  'A': ['1', '7'],
  'B': ['1', '2', '7'],
  'C': ['1', '4', '7'],
  'D': ['1', '4', '5', '7'],
  'E': ['1', '5', '7'],
  'F': ['1', '4', '2', '7'],
  'G': ['1', '4', '2', '5', '7'],
  'H': ['1', '2', '5', '7'],
  'I': ['4', '2', '7'],
  'J': ['4', '2', '5', '7'],
  'K': ['1', '3', '7'],
  'L': ['1', '2', '3', '7'],
  'M': ['1', '4', '3', '7'],
  'N': ['1', '4', '5', '3', '7'],
  'O': ['1', '5', '3', '7'],
  'P': ['1', '4', '2', '3', '7'],
  'Q': ['1', '4', '2', '5', '3', '7'],
  'R': ['1', '2', '5', '3', '7'],
  'S': ['4', '2', '3', '7'],
  'T': ['4', '2', '5', '3', '7'],
  'U': ['1', '3', '6', '7'],
  'V': ['1', '2', '3', '3', '7'],
  'W': ['4', '2', '5', '6', '7'],
  'X': ['1', '4', '3', '6', '7'],
  'Y': ['1', '4', '5', '3', '6', '7'],
  'Z': ['1', '5', '3', '6', '7'],
  '[': ['1', '2', '3', '5', '6', '7'],
  '\\': ['3', '4', '7'],
  ']': ['2', '3', '4', '5', '6', '7'],
  '^': ['2', '3', '4', '6', '7'],
  '_': ['4', '5', '6', '7'],
  '`': ['3', '4', '5'],
  'a': ['1'],
  'b': ['1', '2'],
  'c': ['1', '4'],
  'd': ['1', '4', '5'],
  'e': ['1', '5'],
  'f': ['1', '2', '4'],
  'g': ['1', '2', '4', '5'],
  'h': ['1', '2', '5'],
  'i': ['2', '4'],
  'j': ['2', '4', '5'],
  'k': ['1', '3'],
  'l': ['1', '2', '3'],
  'm': ['1', '3', '4'],
  'n': ['1', '3', '4', '5'],
  'o': ['1', '3', '5'],
  'p': ['1', '2', '3', '4'],
  'q': ['1', '2', '3', '4', '5'],
  'r': ['1', '2', '3', '5'],
  's': ['2', '3', '4'],
  't': ['2', '3', '4', '5'],
  'u': ['1', '3', '6'],
  'v': ['1', '2', '3', '3'],
  'w': ['2', '4', '5', '6'],
  'x': ['1', '3', '4', '6'],
  'y': ['1', '3', '4', '5', '6'],
  'z': ['1', '3', '5', '6'],
  '{': ['1', '2', '3', '5', '6'],
  '|': ['3', '4'],
  '}': ['2', '3', '4', '5', '6'],
  '~': ['2', '3', '4', '6'],
  'DEL': ['4', '5', '6'],
  '€': ['4', '5', '7'],
  'HOP': ['8'],
  '‚': ['3', '6', '7', '8'],
  'ƒ': ['7', '8'],
  '„': ['1', '2', '3', '4', '5', '6', '7'],
  '…': ['1', '2', '3', '4', '5', '6', '8'],
  '†': ['1', '2', '4', '8'],
  '‡': ['1', '2', '4', '5', '8'],
  'ˆ': ['3', '7', '8'],
  '‰': ['2', '4', '8'],
  'Š': ['6', '7', '8'],
  '‹': ['2', '7'],
  'Œ': ['2', '3', '7'],
  'RI': ['2', '5', '7'],
  'Ž': ['1', '2', '5', '6', '7'],
  'SS3': ['1', '2', '4', '6', '7'],
  'DCS': ['1', '2', '4', '6', '7', '8'],
  '‘': ['2', '3', '5', '6', '7'],
  '’': ['2', '3', '6', '7'],
  '“': ['1', '3', '8'],
  '”': ['1', '2', '3', '8'],
  '•': ['2', '7', '8'],
  '–': ['2', '3', '7', '8'],
  '—': ['1', '3', '5', '6', '8'],
  'SOS': ['2', '5', '7', '8'],
  '™': ['1', '2', '4', '5', '6', '7', '8'],
  'š': ['2', '6', '7', '8'],
  '›': ['1', '2', '3', '4', '5', '8'],
  'œ': ['6', '7'],
  'OSC': ['1', '2', '4', '5', '6', '7'],
  'ž': ['2', '3', '5', '6', '7', '8'],
  'Ÿ': ['1', '2', '3', '4', '5', '6', '7', '8'],
  ' ': ['7'],
  '¡': ['3', '6', '7'],
  '¢': ['5', '8'],
  '£': ['4', '6', '7'],
  '¤': ['4', '6', '7', '8'],
  '¥': ['4', '6', '8'],
  '¦': ['1', '5', '8'],
  '§': ['3', '5', '7'],
  '¨': ['4', '8'],
  '©': ['1', '2', '3', '4', '6', '8'],
  'ª': ['1', '2', '5', '8'],
  '«': ['5', '6', '7', '8'],
  '¬': ['2', '5', '6', '7', '8'],
  //'': [],
  '®': ['1', '2', '3', '5', '8'],
  '¯': ['4', '5', '8'],
  '°': ['4', '5', '6', '8'],
  '±': ['2', '3', '5', '7', '8'],
  '²': ['1', '2', '8'],
  '³': ['1', '4', '8'],
  '´': ['5', '6', '8'],
  'µ': ['1', '3', '4', '8'],
  '¶': ['1', '4', '5', '8'],
  '·': ['3', '7'],
  '¸': ['6', '8'],
  '¹': ['1', '8'],
  'º': ['2', '4', '5', '8'],
  '»': ['4', '5', '7', '8'],
  '¼': ['1', '3', '6', '8'],
  '½': ['1', '2', '3', '6', '8'],
  '¾': ['1', '3', '4', '6', '8'],
  '¿': ['3', '8'],
  'À': ['2', '3', '6', '7', '8'],
  'Á': ['2', '8'],
  'Â': ['1', '6', '7'],
  'Ã': ['3', '4', '6', '7'],
  'Ä': ['5', '6', '7'],
  'Å': ['3', '4', '5', '6', '7'],
  'Æ': ['4', '7'],
  'Ç': ['1', '2', '3', '4', '6', '7'],
  'È': ['3', '5', '7', '8'],
  'É': ['2', '3', '8'],
  'Ê': ['1', '2', '6', '7'],
  'Ë': ['2', '3', '5', '8'],
  'Ì': ['5', '7'],
  'Í': ['2', '5', '8'],
  'Î': ['1', '4', '6', '7'],
  'Ï': ['2', '3', '5', '6', '8'],
  'Ð': ['3', '5', '6', '7'],
  'Ñ': ['2', '5', '6', '7'],
  'Ò': ['5', '7', '8'],
  'Ó': ['2', '5', '6', '8'],
  'Ô': ['1', '4', '5', '6', '7'],
  'Õ': ['2', '6', '7'],
  'Ö': ['3', '5', '8'],
  '×': ['2', '3', '4', '8'],
  'Ø': ['2', '4', '6', '7'],
  'Ù': ['3', '5', '6', '7', '8'],
  'Ú': ['2', '6', '8'],
  'Û': ['1', '5', '6', '7'],
  'Ü': ['2', '3', '6', '8'],
  'Ý': ['3', '5', '6', '8'],
  'Þ': ['2', '3', '5', '7'],
  'ß': ['3', '4', '5', '6', '8'],
  'à': ['1', '2', '3', '5', '6', '8'],
  'á': ['1', '6', '8'],
  'â': ['1', '6', '7', '8'],
  'ã': ['3', '4', '6', '7', '8'],
  'ä': ['3', '4', '5', '8'],
  'å': ['3', '4', '5', '6', '7', '8'],
  'æ': ['4', '7', '8'],
  'ç': ['1', '2', '3', '4', '6', '7', '8'],
  'è': ['2', '3', '4', '6', '8'],
  'é': ['1', '2', '6', '8'],
  'ê': ['1', '2', '6', '7', '8'],
  'ë': ['1', '2', '4', '6', '8'],
  'ì': ['3', '4', '8'],
  'í': ['1', '4', '6', '8'],
  'î': ['1', '4', '6', '7', '8'],
  'ï': ['1', '2', '4', '5', '6', '8'],
  'ð': ['2', '3', '4', '5', '8'],
  'ñ': ['1', '3', '4', '5', '8'],
  'ò': ['3', '4', '6', '8'],
  'ó': ['1', '4', '5', '6', '8'],
  'ô': ['1', '4', '5', '6', '7', '8'],
  'õ': ['1', '3', '5', '8'],
  'ö': ['2', '4', '6', '8'],
  '÷': ['1', '2', '5', '6', '7', '8'],
  'ø': ['2', '4', '6', '7', '8'],
  'ù': ['2', '3', '4', '5', '6', '8'],
  'ú': ['1', '5', '6', '8'],
  'û': ['1', '5', '6', '7', '8'],
  'ü': ['1', '2', '5', '6', '8'],
  'ý': ['2', '4', '5', '6', '8'],
  'þ': ['1', '2', '3', '4', '8'],
  'ÿ': ['1', '3', '4', '5', '6', '8'],
};

var _segmentsToCharsLetters = switchMapKeyValue(_charsToSegmentsLetters);
var _segmentsToCharsDigit = switchMapKeyValue(_charsToSegmentsDigits);
var _segmentsToCharsAntoine = switchMapKeyValue(_charsToSegmentsAntoine);
var _segmentsToCharsAntoineLetters =
    switchMapKeyValue(_charsToSegmentsAntoineLetters);
var _segmentsToCharsDEULetters = switchMapKeyValue(_charsToSegmentsDEULetters);
var _segmentsToCharsDEUSymbols = switchMapKeyValue(_charsToSegmentsDEUSymbols);

var _segmentsToCharsENGLetters = switchMapKeyValue(_charsToSegmentsENGLetters);
var _segmentsToCharsENGSymbols = switchMapKeyValue(_charsToSegmentsENGSymbols);
var _segmentsToCharsFRALetters = switchMapKeyValue(_charsToSegmentsFRALetters);
var _segmentsToCharsFRASymbols = switchMapKeyValue(_charsToSegmentsFRASymbols);
var _segmentsToCharsEUR = switchMapKeyValue(_charsToSegmentsEUR);

final _Numbers = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
final _SmallLetters = {
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
};
final _CapitalLetters = {
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
};
final _Mathmatical = {'+', '-', '*', '/', '(', ')', '[', ']', ',', '.', ':'};
final _AntoineLetters = {
  'â',
  'ê',
  'î',
  'ô',
  'û',
  'ë',
  'ï',
  'ü',
  'œ',
  'NUMBERFOLLOWS'
};

final Map _LetterToDigit = {
  'a': '1',
  'b': '2',
  'c': '3',
  'd': '4',
  'e': '5',
  'f': '6',
  'g': '7',
  'h': '8',
  'i': '9',
  'j': '0',
};

final Map _AntoineToDigit = {
  'â': '1',
  'ê': '2',
  'î': '3',
  'ô': '4',
  'û': '5',
  'ë': '6',
  'ï': '7',
  'ü': '8',
  'œ': '9',
  'NUMBERFOLLOWS': '0',
};

final Map _charsToSegmentsForeignLettersFRA = {
  // allemandes
  'ä': ['3', '4', '5'],
  'ö': ['2', '4', '6'],
  'ü': ['1', '2', '5', '6'],
  'ß': ['2', '3', '4', '6'],
  // espagnoles
  'á': ['1', '2', '3', '5', '6'],
  'é': ['2', '3', '4', '6'],
  'í': ['3', '4'],
  'ó': ['3', '4', '6'],
  'ú': ['2', '3', '4', '5', '6'],
  'ñ': ['1', '2', '4', '5', '6'],
  '¿': ['2', '6'],
  '¡': ['2', '3', '5'],
  // italiennes
  'é': ['1', '2', '3', '4', '5', '6'],
  'à': ['1', '2', '3', '5', '6'],
  'è': ['3', '4', '5'],
  'ì': ['3', '4'],
  'ò': ['3', '4', '6'],
  'ù': ['2', '3', '4', '5', '6'],
};

bool _isSmallLetter(String s) {
  return _SmallLetters.contains(s);
}

bool _isCapital(String s) {
  return _CapitalLetters.contains(s);
}

bool _isNumber(String s) {
  return _Numbers.contains(s);
}

bool _isMathmatical(String s) {
  return _Mathmatical.contains(s);
}

List<List<String>> _encodeBrailleBASIC(String input) {
  List<String> inputs = input.split('');
  List<List<String>> result = [];

  Map<String, List<String>> _charsToSegments = new Map<String, List<String>>();
  _charsToSegments.addAll(_charsToSegmentsLetters);
  _charsToSegments.addAll(_charsToSegmentsDigits);

  for (int i = 0; i < inputs.length; i++) {
    result.add(_charsToSegments[inputs[i].toLowerCase()]);
  }
  return result;
}

List<List<String>> _encodeBrailleSIMPLE(String input) {
  List<String> inputs = input.split('');
  List<List<String>> result = [];

  bool numberFollows = false;

  Map<String, List<String>> _charsToSegments = new Map<String, List<String>>();
  _charsToSegments.addAll(_charsToSegmentsLetters);
  _charsToSegments.addAll(_charsToSegmentsDigits);

  for (int i = 0; i < inputs.length; i++) {
    if (_isNumber(inputs[i])) {
      if (!numberFollows) {
        result.add(SWITCH_NUMBERFOLLOWS);
        numberFollows = true;
      }
    } else {
      numberFollows = false;
    }
    result.add(_charsToSegments[inputs[i].toLowerCase()]);
  }
  return result;
}

List<List<String>> _encodeBrailleDEU(String input) {
  bool stateNumberFollows = false;
  bool stateCapitals = false;

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  Map<String, List<String>> _charsToSegments = new Map<String, List<String>>();
  _charsToSegments.addAll(_charsToSegmentsLetters);
  _charsToSegments.addAll(_charsToSegmentsDigits);
  _charsToSegments.addAll(_charsToSegmentsDEULetters);
  _charsToSegments.addAll(_charsToSegmentsDEUSymbols);

  for (int i = 0; i < inputs.length; i++) {
    if (_DEUmulti.contains(inputs[i]))
      result.addAll(_charsetDEUmulti[inputs[i]]);

    if (_isNumber(inputs[i])) {
      if (!stateNumberFollows) {
        result.add(_charsetDEUswitches['NUMBERFOLLOWS']);
        stateNumberFollows = true;
      }
      result.add(_charsToSegments[inputs[i]]);
    } else {
      if (!_isMathmatical(inputs[i])) stateNumberFollows = false;
      if (_isSmallLetter(inputs[i])) {
        if (stateCapitals) stateCapitals = false;
      }
      if (_isCapital(inputs[i])) {
        // check following letter
        if (i < inputs.length - 1 && _isSmallLetter(inputs[i + 1]))
          result.add(_charsetDEUswitches['ONECAPITALFOLLOWS']);
        else {
          result.add(_charsetDEUswitches['CAPITALFOLLOWS']);
          stateCapitals = true;
        }
        inputs[i] = inputs[i].toLowerCase();
      }
      if (inputs[i] == 's' && i < inputs.length - 1 && inputs[i + 1] == 't') {
        result.add(_charsToSegments['st']);
        i++;
      } else if (inputs[i] == 'a' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'u') {
        result.add(_charsToSegments['au']);
        i++;
      } else if (inputs[i] == 'e' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'u') {
        result.add(_charsToSegments['eu']);
        i++;
      } else if (inputs[i] == 'e' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'i') {
        result.add(_charsToSegments['ei']);
        i++;
      } else if (inputs[i] == 'ä' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'U') {
        result.add(_charsToSegments['äu']);
        i++;
      } else if (inputs[i] == 'i' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'e') {
        result.add(_charsToSegments['ie']);
        i++;
      } else if (inputs[i] == 'c' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'h') {
        result.add(_charsToSegments['ch']);
        i++;
      } else if (inputs[i] == 's' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'c' &&
          inputs[i + 2] == 'h') {
        result.add(_charsToSegments['sch']);
        i = i + 2;
      } else
        result.add(_charsToSegments[inputs[i]]);
    }
  }
  return result;
}

List<List<String>> _encodeBrailleENG(String input) {
  bool numberFollows = false;

  Map<String, List<String>> _charsToSegments = new Map<String, List<String>>();
  _charsToSegments.addAll(_charsToSegmentsLetters);
  _charsToSegments.addAll(_charsToSegmentsDigits);
  _charsToSegments.addAll(_charsToSegmentsENGLetters);
  _charsToSegments.addAll(_charsToSegmentsENGSymbols);

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (_isNumber(inputs[i])) {
      if (!numberFollows) {
        result.add(SWITCH_NUMBERFOLLOWS);
        numberFollows = true;
      }
      result.add(_charsToSegments[inputs[i]]);
    } else {
      if (!_isMathmatical(inputs[i])) numberFollows = false;
      if (inputs[i] == 'w' &&
          i < inputs.length - 3 &&
          inputs[i + 1] == 'i' &&
          inputs[i + 2] == 't' &&
          inputs[i + 3] == 'h') {
        result.add(_charsToSegments['with']);
        i = i + 3;
      } else if (inputs[i] == 't' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'h' &&
          inputs[i + 2] == 'e') {
        result.add(_charsToSegments['the']);
        i = i + 2;
      } else if (inputs[i] == 'i' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'n' &&
          inputs[i + 2] == 'g') {
        result.add(_charsToSegments['ing']);
        i = i + 2;
      } else if (inputs[i] == 's' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'c' &&
          inputs[i + 2] == 'h') {
        result.add(_charsToSegments['sch']);
        i = i + 2;
      } else if (inputs[i] == 'a' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'n' &&
          inputs[i + 2] == 'd') {
        result.add(_charsToSegments['and']);
        i = i + 2;
      } else if (inputs[i] == 'f' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'o' &&
          inputs[i + 2] == 'r') {
        result.add(_charsToSegments['for']);
        i = i + 2;
      } else if (inputs[i] == 'b' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'l' &&
          inputs[i + 2] == 'e') {
        result.add(_charsToSegments['ble']);
        i = i + 2;
      } else if (inputs[i] == 'c' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'h') {
        result.add(_charsToSegments['ch']);
        i++;
      } else if (inputs[i] == 'g' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'h') {
        result.add(_charsToSegments['gh']);
        i++;
      } else if (inputs[i] == 's' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'h') {
        result.add(_charsToSegments['sh']);
        i++;
      } else if (inputs[i] == 't' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'h') {
        result.add(_charsToSegments['th']);
        i++;
      } else if (inputs[i] == 'w' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'h') {
        result.add(_charsToSegments['wh']);
        i++;
      } else if (inputs[i] == 'e' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'd') {
        result.add(_charsToSegments['ed']);
        i++;
      } else if (inputs[i] == 'e' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'r') {
        result.add(_charsToSegments['er']);
        i++;
      } else if (inputs[i] == 'o' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'u') {
        result.add(_charsToSegments['ou']);
        i++;
      } else if (inputs[i] == 'o' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'w') {
        result.add(_charsToSegments['ow']);
        i++;
      } else if (inputs[i] == 'i' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'n') {
        result.add(_charsToSegments['in']);
        i++;
      } else if (inputs[i] == 'e' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'a') {
        result.add(_charsToSegments['ea']);
        i++;
      } else if (inputs[i] == 'b' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'b') {
        result.add(_charsToSegments['bb']);
        i++;
      } else if (inputs[i] == 'c' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'c') {
        result.add(_charsToSegments['cc']);
        i++;
      } else if (inputs[i] == 'd' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'd') {
        result.add(_charsToSegments['dd']);
        i++;
      } else if (inputs[i] == 'e' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'n') {
        result.add(_charsToSegments['en']);
        i++;
      } else if (inputs[i] == 'f' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'f') {
        result.add(_charsToSegments['ff']);
        i++;
      } else if (inputs[i] == 'g' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'g') {
        result.add(_charsToSegments['gg']);
        i++;
      } else if (inputs[i] == 's' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 't') {
        result.add(_charsToSegments['st']);
        i++;
      } else if (inputs[i] == 'a' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'r') {
        result.add(_charsToSegments['ar']);
        i++;
      } else if (inputs[i] == 'o' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'f') {
        result.add(_charsToSegments['of']);
        i++;
      } else
        result.add(_charsToSegments[inputs[i]]);
    }
  }
  return result;
}

List<List<String>> _encodeBrailleFRA(String input) {
  bool numberFollows = false;

  Map<String, List<String>> _charsToSegments = new Map<String, List<String>>();
  _charsToSegments.addAll(_charsToSegmentsLetters);
  _charsToSegments.addAll(_charsToSegmentsDigits);
  _charsToSegments.addAll(_charsToSegmentsFRALetters);
  _charsToSegments.addAll(_charsToSegmentsFRASymbols);

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (_isNumber(inputs[i])) {
      if (!numberFollows) {
        result.add(_charsToSegments['#']);
        numberFollows = true;
      }
      result.add(_charsToSegments[inputs[i]]);
    } else {
      if (!_isMathmatical(inputs[i])) numberFollows = false;
    }
  }

  return result;
}

List<List<String>> _encodeBrailleEUR(String input) {
  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    result.add(_charsToSegmentsEUR[inputs[i]]);
  }
  return result;
}

List<List<String>> encodeBraille(String input, BrailleLanguage language) {
  if (input == null) return [];

  switch (language) {
    case BrailleLanguage.BASIC:
      return _encodeBrailleBASIC(input);
      break;
    case BrailleLanguage.SIMPLE:
      return _encodeBrailleSIMPLE(input);
      break;
    case BrailleLanguage.DEU:
      return _encodeBrailleDEU(input);
      break;
    case BrailleLanguage.ENG:
      return _encodeBrailleENG(input);
      break;
    case BrailleLanguage.FRA:
      return _encodeBrailleFRA(input);
      break;
    case BrailleLanguage.EUR:
      return _encodeBrailleEUR(input);
      break;
  }
}

Map<String, dynamic> _decodeBrailleBASIC(
    List<String> inputs, bool letters, bool french) {
  var displays = <List<String>>[];

  var _segmentsToCharsSIMPLEBraille_1 = _segmentsToCharsLetters;
  if (french) _segmentsToCharsSIMPLEBraille_1.addAll(_segmentsToCharsAntoine);

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';
    var display = <String>[];
    input.split('').forEach((element) {
      display.add(element);
    });

    if (_segmentsToCharsSIMPLEBraille_1.map((key, value) =>
            MapEntry(key.join(), value.toString()))[input.split('').join()] ==
        null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      charH = _segmentsToCharsSIMPLEBraille_1.map((key, value) =>
          MapEntry(key.join(), value.toString()))[input.split('').join()];

      if (letters)
        char = char + charH;
      else // digits
      if (french) {
        if (_isNumber(charH))
          char = char + charH;
        else
          char = char + UNKNOWN_ELEMENT;
      } else {
        if (_LetterToDigit[charH] == null)
          char = char + UNKNOWN_ELEMENT;
        else
          char = char + _LetterToDigit[charH];
      }
    }

    displays.add(display);

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};
}

Map<String, dynamic> _decodeBrailleSIMPLE(List<String> inputs, bool french) {
  var displays = <List<String>>[];

  Map<List<String>, String> _segmentsToCharsSIMPLEBraille =
      new Map<List<String>, String>();
  _segmentsToCharsSIMPLEBraille.addAll(_segmentsToCharsLetters);
  _segmentsToCharsSIMPLEBraille.addAll({SWITCH_NUMBERFOLLOWS: 'NUMBERFOLLOWS'});

  Map<List<String>, String> _segmentsToCharsSIMPLEBrailleFrench =
      new Map<List<String>, String>();
  _segmentsToCharsSIMPLEBrailleFrench.addAll(_segmentsToCharsLetters);
  _segmentsToCharsSIMPLEBrailleFrench
      .addAll({SWITCH_NUMBERFOLLOWS: 'NUMBERFOLLOWS'});
  _segmentsToCharsSIMPLEBrailleFrench
      .addAll({SWITCH_ANTOINE: 'ANTOINENUMBERFOLLOWS'});
  _segmentsToCharsSIMPLEBrailleFrench.addAll(_segmentsToCharsAntoineLetters);

  bool _numberFollows = false;
  bool _antoinenumberFollows = false;

  List<String> text = [];

  if (french) {
    _numberFollows = false;
    _antoinenumberFollows = false;
    text = inputs.where((input) => input != null).map((input) {
      var char = '';
      var charH = '';
      var display = <String>[];
      input.split('').forEach((element) {
        display.add(element);
      });

      if (_segmentsToCharsSIMPLEBrailleFrench.map((key, value) =>
              MapEntry(key.join(), value.toString()))[input.split('').join()] ==
          null)
        char = char + UNKNOWN_ELEMENT;
      else {
        charH = _segmentsToCharsSIMPLEBrailleFrench.map((key, value) =>
            MapEntry(key.join(), value.toString()))[input.split('').join()];
        if (charH == 'NUMBERFOLLOWS') {
          _numberFollows = true;
        } else if (charH == 'ANTOINENUMBERFOLLOWS') {
          _antoinenumberFollows = true;
          _numberFollows = false;
        } else if (charH == ' ') {
          _numberFollows = false;
          _antoinenumberFollows = false;
          char = char + charH;
        } else {
          // no switch but char to analyze
          if (_numberFollows) {
            if (_LetterToDigit[charH] == null) {
              _numberFollows = false;
            } else {
              charH = _LetterToDigit[charH];
            }
          } else if (_antoinenumberFollows) {
            if (_AntoineToDigit[charH] == null)
              _numberFollows = false;
            else {
              charH = _AntoineToDigit[charH];
            }
          } else if (_AntoineLetters.contains(charH)) charH = UNKNOWN_ELEMENT;

          char = char + charH;
        }
      }
      displays.add(display);

      return char;
    }).toList();
  } else {
    _numberFollows = false;
    text = inputs.where((input) => input != null).map((input) {
      var char = '';
      var charH = '';
      var display = <String>[];
      input.split('').forEach((element) {
        display.add(element);
      });

      if (_segmentsToCharsSIMPLEBraille.map((key, value) =>
              MapEntry(key.join(), value.toString()))[input.split('').join()] ==
          null)
        char = char + UNKNOWN_ELEMENT;
      else {
        charH = _segmentsToCharsSIMPLEBraille.map((key, value) =>
            MapEntry(key.join(), value.toString()))[input.split('').join()];

        if (charH == 'NUMBERFOLLOWS') {
          _numberFollows = true;
        } else if (charH == ' ') {
          _numberFollows = false;
          char = char + charH;
        } else {
          // no switch
          if (_numberFollows) {
            if (_LetterToDigit[charH] == null)
              _numberFollows = false;
            else
              charH = _LetterToDigit[charH];
          }
          char = char + charH;
        }
      }
      displays.add(display);

      return char;
    }).toList();
  }

  return {'displays': displays, 'chars': text};
}

Map<String, dynamic> _decodeBrailleDEU(List<String> inputs) {
  var displays = <List<String>>[];

  bool numberFollows = false;
  bool capitalFollows = false;
  bool oneCapitalFollows = false;
  bool smallLettersFollows = false;
  bool composed_4 = false;
  bool composed_5 = false;
  bool composed_6 = false;
  bool composed_56 = false;
  bool composed_456 = false;
  bool composed_3456 = false;

  String input = '';
  String char = '';
  String charH = '';
  List<String> text = [];
  int maxLength = inputs.length;

  // Build Map for decoding
  Map <String, String> BrailleToChar = new Map <String, String>();
  _segmentsToCharsDEULetters.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToCharsDEUSymbols.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToDEUswitches.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToCharsLetters.forEach((key, value) {BrailleToChar[key.join()] = value;});

  for (int i = 0; i < maxLength; i++) {
    input = inputs[i];

    // Build displays
    var display = <String>[];
    input.split('').forEach((element) {
      display.add(element);
    });
    displays.add(display);

    // Build text
    if (BrailleToChar[input] == null) {
      text.add(UNKNOWN_ELEMENT);
   } else {
      charH = BrailleToChar[input];
      if (_DEUswitches.contains(charH)) {
        if (charH == 'ONECAPITALFOLLOWS')
          oneCapitalFollows = true;
        else if (charH == "CAPITALFOLLOWS")
          capitalFollows = true;
        else if (charH == "SMALLLETTERFOLLOWS")
          smallLettersFollows = false;
        else if ((charH == 'NUMBERFOLLOWS') && !numberFollows)
          numberFollows = true;
        else if ((charH == 'NUMBERFOLLOWS') && numberFollows)
          composed_3456 = true;
        else if (charH == 'COMPOSED_4')
          composed_4 = true;
        else if (charH == 'COMPOSED_5')
          composed_5 = true;
        else if (charH == 'COMPOSED_6')
          composed_6 = true;
        else if (charH == 'COMPOSED_56')
          composed_56 = true;
        else if (charH == 'COMPOSED_456')
          composed_456 = true;
      } else if (charH == ' ') {
        numberFollows = false;
        capitalFollows = false;
        oneCapitalFollows = false;
        smallLettersFollows = false;
      } else {
        // no switch
        if (numberFollows) {
          if (_LetterToDigit[charH] == null)
            numberFollows = false;
          else
            charH = _LetterToDigit[charH];
        } else if (oneCapitalFollows) {
          charH = charH.toUpperCase();
          oneCapitalFollows = false;
        } else if (capitalFollows) {
          charH = charH.toUpperCase();
        } else if (composed_4){
          switch (input){
            case '356': charH = '°'; break;
            case '346': charH = '^'; break;
            case '35': charH = '’'; break;
            case '34': charH = '\\'; break;
            case '345': charH = '@'; break;
            case '15': charH = '€'; break;
            //case '456': charH = '£'; break;
            case '234': charH = '\$'; break;
            case '14': charH = '¢'; break;
            case '235': charH = '+'; break;
            case '2356': charH = '='; break;
            case '35': charH = '*'; break; //asterisk
            case '1256': charH = '—'; break;
            case '146': charH = '√'; break;
            case '456': charH = '_'; break;
            case '26': charH = '~'; break;
            case '235': charH = '×'; break;
            case '3': charH = '•'; break;
            default: charH = UNKNOWN_ELEMENT;
          }
        } else if (composed_5){
          switch (input){
            case '136': charH = '&'; break;
            case '2': charH = '/'; break;
            default: charH = UNKNOWN_ELEMENT;
          }
        } else if (composed_6){
          switch (input){
            case '36': charH = '–'; break; //n-dash
            case '2356': charH = '[]'; break;
            case '236': charH = '‚'; break;
            case '356': charH = '‘'; break;
            default: charH = UNKNOWN_ELEMENT;
          }
        } else if (composed_56){
          switch (input){
            case '2356': charH = '[]'; break;
            default: charH = UNKNOWN_ELEMENT;
          }
        } else if (composed_456){
          switch (input){
            case '123': charH = '|'; break;
            default: charH = UNKNOWN_ELEMENT;
          }
        } else if (composed_3456){
          switch (input){
            case '245':
              if (((i + 2) < maxLength) && (inputs[i + 1] == '356') && (inputs[i + 1] == '356')) {
                charH = '‰';
                i = i + 2;
              } else if (((i + 1) < maxLength) && (inputs[i + 1] == '356')) {
                charH = '%';
                i++;
              } else
              charH = UNKNOWN_ELEMENT;
              break;
            default: charH = UNKNOWN_ELEMENT;
          }
        }
        char = char + charH;
      }
      text.add(charH);
    };
  }

  return {'displays': displays, 'chars': text};
}

Map<String, dynamic> _decodeBrailleENG(List<String> inputs) {
// TO DO
  var displays = <List<String>>[];

  bool numberFollows = false;
  bool capitalFollows = false;
  bool oneCapitalFollows = false;
  bool smallLettersFollows = false;
  bool composed_4 = false;
  bool composed_5 = false;
  bool composed_6 = false;
  bool composed_56 = false;
  bool composed_456 = false;

  String input = '';
  String char = '';
  String charH = '';
  List<String> text = [];
  int maxLength = inputs.length;

  // Build Map for decoding
  Map <String, String> BrailleToChar = new Map <String, String>();
  _segmentsToCharsENGLetters.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToCharsENGSymbols.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToENGswitches.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToCharsLetters.forEach((key, value) {BrailleToChar[key.join()] = value;});

  for (int i = 0; i < maxLength; i++) {
    input = inputs[i];

    // Build displays
    var display = <String>[];
    input.split('').forEach((element) {
      display.add(element);
    });
    displays.add(display);

    // Build text
    if (BrailleToChar[input] == null) {
      text.add(UNKNOWN_ELEMENT);
    } else {
      charH = BrailleToChar[input];


    }
  }
  return {'displays': displays, 'chars': text};
}

Map<String, dynamic> _decodeBrailleFRA(List<String> inputs) {
// TO DO
  var displays = <List<String>>[];

  bool numberFollows = false;
  bool capitalFollows = false;
  bool oneCapitalFollows = false;
  bool smallLettersFollows = false;
  bool composed_4 = false;
  bool composed_5 = false;
  bool composed_6 = false;
  bool composed_56 = false;
  bool composed_456 = false;

  String input = '';
  String char = '';
  String charH = '';
  List<String> text = [];
  int maxLength = inputs.length;

  // Build Map for decoding
  Map <String, String> BrailleToChar = new Map <String, String>();
  _segmentsToCharsFRALetters.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToCharsFRASymbols.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToFRAswitches.forEach((key, value) {BrailleToChar[key.join()] = value;});
  _segmentsToCharsLetters.forEach((key, value) {BrailleToChar[key.join()] = value;});

  for (int i = 0; i < maxLength; i++) {
    input = inputs[i];

    // Build displays
    var display = <String>[];
    input.split('').forEach((element) {
      display.add(element);
    });
    displays.add(display);

    // Build text
    if (BrailleToChar[input] == null) {
      text.add(UNKNOWN_ELEMENT);
    } else {
      charH = BrailleToChar[input];


    }
  }
  return {'displays': displays, 'chars': text};}

Map<String, dynamic> _decodeBrailleEUR(List<String> inputs) {
  var displays = <List<String>>[];

  List<String> text = inputs.where((input) => input != null).map((input) {
    var display = <String>[];
    var char = '';

    input.split('').forEach((element) {
      display.add(element);
    });

    if (_segmentsToCharsEUR.map((key, value) =>
            MapEntry(key.join(), value.toString()))[input.split('').join()] ==
        null)
      char = char + UNKNOWN_ELEMENT;
    else {
      char = char +
          _segmentsToCharsEUR.map((key, value) =>
              MapEntry(key.join(), value.toString()))[input.split('').join()];
    }
    displays.add(display);

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};
}

Map<String, dynamic> decodeBraille(
    List<String> input, BrailleLanguage language, bool letters, bool french) {
  if (input == null || input.length == 0)
    return {
      'displays': [[]],
      'chars': [0]
    };

  switch (language) {
    case BrailleLanguage.BASIC:
      return _decodeBrailleBASIC(input, letters, french);
      break;
    case BrailleLanguage.SIMPLE:
      return _decodeBrailleSIMPLE(input, french);
      break;
    case BrailleLanguage.DEU:
      return _decodeBrailleDEU(input);
      break;
    case BrailleLanguage.ENG:
      return _decodeBrailleENG(input);
      break;
    case BrailleLanguage.FRA:
      return _decodeBrailleFRA(input);
      break;
    case BrailleLanguage.EUR:
      return _decodeBrailleEUR(input);
      break;
  }
}
