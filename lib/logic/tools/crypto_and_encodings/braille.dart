import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
// https://www.pharmabraille.com/wp-content/uploads/2014/11/World-Braille-Usage-Third-Edition-1.pdf

// https://de.wikipedia.org/wiki/Brailleschrift
// https://www.pharmabraille.com/wp-content/uploads/2015/01/system_d_blindenschrift_7620.pdf

// https://en.wikipedia.org/wiki/Braille
// https://en.wikipedia.org/wiki/English_Braille
// http://www.acb.org/tennessee/braille.html

// https://fr.wikipedia.org/wiki/Braille
// https://www.pharmabraille.com/wp-content/uploads/2015/01/CBFU_edition_internationale.pdf

enum BrailleLanguage { DE, EN, FR }

Map<BrailleLanguage, String> BRAILLE_LANGUAGES = {
  BrailleLanguage.DE: 'common_language_german',
  BrailleLanguage.EN: 'braille_language_english',
  BrailleLanguage.FR: 'common_language_french',
};

final Map<String, List<String>> _charsToSegmentsDEU = {
  ' ': [],
  '1': ['a'],
  '2': ['a', 'c'],
  '3': ['a', 'b'],
  '4': ['a', 'b', 'd'],
  '5': ['a', 'd'],
  '6': ['a', 'b', 'c'],
  '7': ['a', 'b', 'c', 'd'],
  '8': ['a', 'c', 'd'],
  '9': ['b', 'c'],
  '0': ['b', 'c', 'd'],
  'a': ['a'],
  'b': ['a', 'c'],
  'c': ['a', 'b'],
  'd': ['a', 'b', 'd'],
  'e': ['a', 'd'],
  'f': ['a', 'b', 'c'],
  'g': ['a', 'b', 'c', 'd'],
  'h': ['a', 'c', 'd'],
  'i': ['b', 'c'],
  'j': ['b', 'c', 'd'],
  'k': ['a', 'e'],
  'l': ['a', 'c', 'e'],
  'm': ['a', 'b', 'e'],
  'n': ['a', 'b', 'd', 'e'],
  'o': ['a', 'd', 'e'],
  'p': ['a', 'b', 'c', 'e'],
  'q': ['a', 'b', 'c', 'd', 'e'],
  'r': ['a', 'c', 'd', 'e'],
  's': ['b', 'c', 'e'],
  't': ['b', 'c', 'd', 'e'],
  'u': ['a', 'e', 'f'],
  'v': ['a', 'c', 'e', 'e'],
  'w': ['b', 'c', 'd', 'f'],
  'x': ['a', 'b', 'e', 'f'],
  'y': ['a', 'b', 'd', 'e', 'f'],
  'z': ['a', 'd', 'e', 'f'],
  'ä': ['b', 'd', 'e'],
  'ö': ['b', 'c', 'f'],
  'ü': ['a', 'c', 'd', 'f'],
  'ß': ['b', 'c', 'e', 'f'],
  'st': ['b', 'c', 'd', 'e', 'f'],
  ']': ['b', 'c', 'd', 'e', 'f'],
  '[': ['a', 'c', 'd', 'e', 'f'],
  'au': ['a', 'f'],
  'eu': ['a', 'c', 'f'],
  'ei': ['a', 'b', 'f'],
  'äu': ['b', 'e'],
  'ie': ['b', 'e', 'e'],
  'ch': ['a', 'b', 'd', 'f'],
  'sch': ['a', 'd', 'f'],
  ',': ['c'],
  ';': ['c', 'e'],
  ':': ['c', 'd'],
  '.': ['e'],
  '?': ['c', 'f'],
  '+': ['c', 'd', 'e'],
  '!': ['c', 'd', 'e'],
  '#': ['b', 'd', 'e', 'f'], // number follows
  '=': ['c', 'd', 'e', 'f'],
  '(': ['c', 'd', 'e', 'f'],
  ')': ['c', 'd', 'e', 'f'],
  ']': ['b', 'c', 'd', 'e', 'f'],
  '[': ['a', 'c', 'd', 'e', 'f'],
  '%': ['a', 'b', 'c', 'd', 'e', 'f'],
  '^': ['a', 'b', 'c', 'd', 'f'],
  '`': ['a', 'b', 'c', 'f'],
  '-': ['e', 'f'],
  '§': ['b', 'e', 'f'],
  '»': ['c', 'e', 'f'],
  '«': ['d', 'e', 'f'],
  "'": ['f'], // small letters follows
  '~': ['d'],
  '>': ['b', 'd'],
  '<': ['d', 'f'],
  '/': ['c', 'd', 'f'],
  '\$': ['b', 'f'], // capitel follows
  '_': ['b', 'd', 'f'],
};
final Map<String, List<String>> _charsToSegmentsENG = {
  ' ': [],
  '1': ['a'],
  '2': ['a', 'c'],
  '3': ['a', 'b'],
  '4': ['a', 'b', 'd'],
  '5': ['a', 'd'],
  '6': ['a', 'b', 'c'],
  '7': ['a', 'b', 'c', 'd'],
  '8': ['a', 'c', 'd'],
  '9': ['b', 'c'],
  '0': ['b', 'c', 'd'],
  'a': ['a'],
  'b': ['a', 'c'],
  'c': ['a', 'b'],
  'd': ['a', 'b', 'd'],
  'e': ['a', 'd'],
  'f': ['a', 'b', 'c'],
  'g': ['a', 'b', 'c', 'd'],
  'h': ['a', 'c', 'd'],
  'i': ['b', 'c'],
  'j': ['b', 'c', 'd'],
  'k': ['a', 'e'],
  'l': ['a', 'c', 'e'],
  'm': ['a', 'b', 'e'],
  'n': ['a', 'b', 'd', 'e'],
  'o': ['a', 'd', 'e'],
  'p': ['a', 'b', 'c', 'e'],
  'q': ['a', 'b', 'c', 'd', 'e'],
  'r': ['a', 'c', 'd', 'e'],
  's': ['b', 'c', 'e'],
  't': ['b', 'c', 'd', 'e'],
  'u': ['a', 'e', 'f'],
  'v': ['a', 'c', 'e', 'e'],
  'w': ['b', 'c', 'd', 'f'],
  'x': ['a', 'b', 'e', 'f'],
  'y': ['a', 'b', 'd', 'e', 'f'],
  'z': ['a', 'd', 'e', 'f'],
  'and': ['a', 'b', 'c', 'e', 'f'],
  'for': ['a', 'b', 'c', 'd', 'e', 'f'],
  'of': ['a', 'c', 'd', 'e', 'f'],
  'the': ['b', 'c', 'e', 'f'],
  'with': ['b', 'c', 'd', 'e', 'f'],
  'ch': ['a', 'f'],
  'gh': ['a', 'c', 'f'],
  'sh': ['a', 'b', 'f'],
  'th': ['a', 'b', 'd', 'f'],
  'wh': ['a', 'd', 'f'],
  'ed': ['a', 'b', 'c', 'f'],
  'er': ['a', 'b', 'c', 'd', 'f'],
  'ou': ['a', 'c', 'd', 'f'],
  'ow': ['b', 'c', 'f'],
  'st': ['b', 'e'], //    or /
  'ar': ['b', 'd', 'e'],
  'ing': ['b', 'e', 'f'],
  'ble': ['b', 'd', 'e', 'f'],
  'bb': ['c', 'e'],
  'cc': ['c', 'd'],
  'en': ['c', 'f'],
  'ff': ['c', 'd', 'e'],
  'in': ['d', 'e'],
  'by': ['d', 'e', 'f'],
  ',': ['c'],
  ';': ['c', 'e'],
  ':': ['c', 'd'],
  '.': ['c', 'd', 'f'],
  '?': ['c', 'e', 'f'],
  '!': ['c', 'd', 'e'],
  '+': ['c', 'd', 'e'],
  '#': ['b', 'd', 'e', 'f'], // number follows
  '=': ['c', 'd', 'e', 'f'],
  '-': ['e', 'f'],
  '§': ['b', 'e', 'f'],
  '"': ['c', 'e', 'f'],
  "'": ['b'],
  '~': ['d'],
  '>': ['b', 'd'],
  '<': ['d', 'f'],
  '/': ['b', 'e'],
  '_': ['e', 'f'],
};
final Map<String, List<String>> _charsToSegmentsFRA = {
  ' ': [],
  'A': ['a'],
  'B': ['a', 'c'],
  'C': ['a', 'b'],
  'D': ['a', 'b', 'd'],
  'E': ['a', 'd'],
  'F': ['a', 'b', 'c'],
  'G': ['a', 'b', 'c', 'd'],
  'H': ['a', 'c', 'd'],
  'I': ['b', 'c'],
  'J': ['b', 'c', 'd'],
  'K': ['a', 'e'],
  'L': ['a', 'c', 'e'],
  'M': ['a', 'b', 'e'],
  'N': ['a', 'b', 'd', 'e'],
  'O': ['a', 'd', 'e'],
  'P': ['a', 'b', 'c', 'e'],
  'Q': ['a', 'b', 'c', 'd', 'e'],
  'R': ['a', 'c', 'd', 'e'],
  'S': ['b', 'c', 'e'],
  'T': ['b', 'c', 'd', 'e'],
  'U': ['a', 'e', 'f'],
  'V': ['a', 'c', 'e', 'e'],
  'W': ['b', 'c', 'd', 'f'],
  'X': ['a', 'b', 'e', 'f'],
  'Y': ['a', 'b', 'd', 'e', 'f'],
  'Z': ['a', 'd', 'e', 'f'],
  'À': ['a', 'c', 'd', 'e', 'f'],
  'Â': ['a', 'f'],
  'Ç': ['a', 'b', 'c', 'e', 'f'],
  'È': ['b', 'c', 'e', 'f'],
  'É': ['a', 'b', 'c', 'd', 'e', 'f'],
  'Ê': ['a', 'c', 'f'],
  'Ë': ['a', 'b', 'c', 'f'],
  'Î': ['a', 'b', 'f'],
  'Ï': ['a', 'b', 'c', 'd', 'f'],
  'Ô': ['a', 'b', 'd', 'f'],
  'Œ': ['b', 'c', 'f'],
  'Ù': ['b', 'c', 'd', 'e', 'f'],
  'Û': ['a', 'd', 'f'],
  'Ü': ['a', 'c', 'd', 'f'],
  ',': ['c'],
  ';': ['c', 'e'],
  ':': ['c', 'd'],
  '.': ['c', 'd', 'f'],
  '?': ['c', 'f'],
  '!': ['c', 'd', 'e'],
  '"': ['c', 'd', 'e', 'f'],
  '(': ['c', 'e', 'f'],
  ')': ['d', 'e', 'f'],
  "'": ['e'],
  '/': ['b', 'e'],
  '@': ['b', 'd', 'e'],
//  mathmatics symbols or number follows  ['f'],
  '1': ['a', 'f'],
  '2': ['a', 'c', 'f'],
  '3': ['a', 'b', 'f'],
  '4': ['a', 'b', 'd', 'f'],
  '5': ['a', 'd', 'f'],
  '6': ['a', 'b', 'c', 'f'],
  '7': ['a', 'b', 'c', 'd', 'f'],
  '8': ['a', 'c', 'd', 'f'],
  '9': ['b', 'c', 'f'],
  '0': ['b', 'c', 'd', 'f'],
  '+': ['b', 'c', 'e'],
  '-': ['e', 'f'],
  '=': ['c', 'd', 'e', 'f'],
  '×': ['c', 'e'],
  '÷': ['c', 'd'],
//  typographic symbols follows  ['b', 'd'],
  '¢': ['a', 'd'],
  '€': ['a', 'e'],
  '£': ['a', 'c', 'e'],
  'µ': ['a', 'c', 'd'],
  'π': ['a', 'b', 'c', 'd'],
  '\$': ['b', 'c', 'd'],
  '¥': ['a', 'c', 'd', 'e', 'f'],
  '≤': ['a', 'b', 'f'],
  '≥': ['c', 'd', 'e'],
  '[': ['b', 'c', 'f'],
//  typographic symbols follows  ['d'],
  '©': ['a', 'd'],
  '°': ['a', 'c', 'e'],
  '§': ['a', 'b', 'c', 'd'],
  '®': ['a', 'b', 'c', 'e'],
  '™': ['b', 'c', 'd', 'e'],
  '&': ['a', 'b', 'c', 'd', 'e', 'f'],
  '<': ['a', 'b', 'f'],
  '>': ['c', 'd', 'e'],
  '~': ['b', 'f'],
  '*': ['d', 'e'],
  '\\': ['c', 'd'],
  '#': ['c', 'd', 'e', 'f'],
  '%': ['c', 'd', 'f'],
  '_': ['e', 'f'],
};

var _segmentsToCharsDEU = switchMapKeyValue(_charsToSegmentsDEU);
var _segmentsToCharsENG = switchMapKeyValue(_charsToSegmentsENG);
var _segmentsToCharsFRA = switchMapKeyValue(_charsToSegmentsFRA);

final Numbers = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
final Letters = {
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
final Capitals = {
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
final Mathmatical = {'+', '-', '*', '/', '(', ')', '[', ']', ',', '.', ':'};

List<String> _ordinalNumber(String s, _charsToSegments) {
  switch (s) {
    case '0':
      return _charsToSegments['«'];
      break;
    case '1':
      return _charsToSegments[','];
      break;
    case '2':
      return _charsToSegments[';'];
      break;
    case '3':
      return _charsToSegments[':'];
      break;
    case '4':
      return _charsToSegments['/'];
      break;
    case '5':
      return _charsToSegments['?'];
      break;
    case '6':
      return _charsToSegments['+'];
      break;
    case '7':
      return _charsToSegments['('];
      break;
    case '8':
      return _charsToSegments['»'];
      break;
    case '9':
      return _charsToSegments['*'];
      break;
  }
}

bool _isCapital(String s) {
  return Capitals.contains(s);
}

bool _isNumber(String s) {
  return Numbers.contains(s);
}

bool _isMathmatical(String s) {
  return Mathmatical.contains(s);
}


List<List<String>> encodeBraille(String input, BrailleLanguage language) {
  if (input == null) return [];

  var _charsToSegments;

  switch (language) {
    case BrailleLanguage.DE:
      _charsToSegments = _charsToSegmentsDEU;
      break;
    case BrailleLanguage.EN:
      _charsToSegments = _charsToSegmentsENG;
      break;
    case BrailleLanguage.FR:
      _charsToSegments = _charsToSegmentsFRA;
      break;
  }

  bool numberFollows = false;

  List<String> inputs = input.split('');
  List<List<String>> result = new List<List<String>>();
  for (int i = 0; i < inputs.length; i++) {
    if (language == BrailleLanguage.DE) {

    } else if (language == BrailleLanguage.EN) {

    } else if (language == BrailleLanguage.FR) {

    };


    if (_isNumber(inputs[i])) {
      if (!numberFollows) {
        result.add(_charsToSegments['#']);
        numberFollows = true;
      }
      if (i < inputs.length - 1 && inputs[i + 1] == '.') {
        result.add(_ordinalNumber(inputs[i], _charsToSegments));
        i++;
      } else
        result.add(_charsToSegments[inputs[i]]);
    } else if (language == BrailleLanguage.DE) {
      if (!_isMathmatical(inputs[i])) numberFollows = false;
      if (_isCapital(inputs[i])) {
        result.add(_charsToSegments['\$']);
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
    } else if (language == BrailleLanguage.EN) {
      if (!_isMathmatical(inputs[i])) numberFollows = false;
      if (inputs[i] == 'C' && i < inputs.length - 1 && inputs[i + 1] == 'H') {
        result.add(_charsToSegments['CH']);
        i++;
      } else if (inputs[i] == 'G' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'H') {
        result.add(_charsToSegments['GH']);
        i++;
      } else if (inputs[i] == 'S' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'H') {
        result.add(_charsToSegments['SH']);
        i++;
      } else if (inputs[i] == 'T' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'H') {
        result.add(_charsToSegments['TH']);
        i++;
      } else if (inputs[i] == 'W' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'H') {
        result.add(_charsToSegments['WH']);
        i++;
      } else if (inputs[i] == 'E' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'D') {
        result.add(_charsToSegments['ED']);
        i++;
      } else if (inputs[i] == 'E' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'R') {
        result.add(_charsToSegments['ER']);
        i++;
      } else if (inputs[i] == 'O' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'U') {
        result.add(_charsToSegments['OU']);
        i++;
      } else if (inputs[i] == 'O' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'W') {
        result.add(_charsToSegments['OW']);
        i++;
      } else if (inputs[i] == 'I' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'N') {
        result.add(_charsToSegments['IN']);
        i++;
      } else if (inputs[i] == 'E' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'A') {
        result.add(_charsToSegments['EA']);
        i++;
      } else if (inputs[i] == 'B' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'B') {
        result.add(_charsToSegments['BB']);
        i++;
      } else if (inputs[i] == 'C' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'C') {
        result.add(_charsToSegments['CC']);
        i++;
      } else if (inputs[i] == 'D' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'D') {
        result.add(_charsToSegments['DD']);
        i++;
      } else if (inputs[i] == 'E' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'N') {
        result.add(_charsToSegments['EN']);
        i++;
      } else if (inputs[i] == 'F' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'F') {
        result.add(_charsToSegments['FF']);
        i++;
      } else if (inputs[i] == 'G' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'G') {
        result.add(_charsToSegments['GG']);
        i++;
      } else if (inputs[i] == 'S' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'T') {
        result.add(_charsToSegments['ST']);
        i++;
      } else if (inputs[i] == 'A' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'R') {
        result.add(_charsToSegments['AR']);
        i++;
      } else if (inputs[i] == 'O' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'F') {
        result.add(_charsToSegments['OF']);
        i++;
      } else if (inputs[i] == 'S' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'C' &&
          inputs[i + 2] == 'H') {
        result.add(_charsToSegments['SCH']);
        i = i + 2;
      } else if (inputs[i] == 'A' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'N' &&
          inputs[i + 2] == 'D') {
        result.add(_charsToSegments['AND']);
        i = i + 2;
      } else if (inputs[i] == 'F' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'O' &&
          inputs[i + 2] == 'R') {
        result.add(_charsToSegments['FOR']);
        i = i + 2;
      } else if (inputs[i] == 'T' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'H' &&
          inputs[i + 2] == 'E') {
        result.add(_charsToSegments['THE']);
        i = i + 2;
      } else if (inputs[i] == 'I' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'N' &&
          inputs[i + 2] == 'G') {
        result.add(_charsToSegments['ING']);
        i = i + 2;
      } else if (inputs[i] == 'B' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'L' &&
          inputs[i + 2] == 'E') {
        result.add(_charsToSegments['BLE']);
        i = i + 2;
      } else if (inputs[i] == 'W' &&
          i < inputs.length - 3 &&
          inputs[i + 1] == 'I' &&
          inputs[i + 2] == 'T' &&
          inputs[i + 3] == 'H') {
        result.add(_charsToSegments['WITH']);
        i = i + 2;
      } else
        result.add(_charsToSegments[inputs[i]]);
    } else if (language == BrailleLanguage.FR) {
      if (!_isMathmatical(inputs[i])) numberFollows = false;
    }
  }
  return result;
}

Map<String, dynamic> decodeBraille(
    List<String> inputs, BrailleLanguage language) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': [[]],
      'chars': [0]
    };

  var displays = <List<String>>[];
  var _segmentsToChars;
  switch (language) {
    case BrailleLanguage.DE:
      _segmentsToChars = _segmentsToCharsDEU;
      break;
    case BrailleLanguage.EN:
      _segmentsToChars = _segmentsToCharsENG;
      break;
    case BrailleLanguage.FR:
      _segmentsToChars = _segmentsToCharsFRA;
      break;
  }

  bool numberFollows = false;
  bool capitalFollows = false;
  bool singleCapitalFollows = false;

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';
    var display = <String>[];
    input.split('').forEach((element) {
      display.add(element);
    });
    if (_segmentsToChars.map((key, value) =>
        MapEntry(key.join(), value.toString()))[input.split('').join()] ==
        null)
      char = char + UNKNOWN_ELEMENT;
    else {
      charH = _segmentsToChars.map((key, value) =>
          MapEntry(key.join(), value.toString()))[input.split('').join()];
      if (charH == '\$')
        singleCapitalFollows = true;
      else if (charH == ">")
        capitalFollows == true;
      else if (charH == "'")
        capitalFollows == false;
      else if (charH == '#')
        numberFollows = true;
      else {
        if (numberFollows && charH == 'a')
          charH = '1';
        else if (numberFollows && charH == 'b')
          charH = '2';
        else if (numberFollows && charH == 'c')
          charH = '3';
        else if (numberFollows && charH == 'd')
          charH = '4';
        else if (numberFollows && charH == 'e')
          charH = '5';
        else if (numberFollows && charH == 'f')
          charH = '6';
        else if (numberFollows && charH == 'g')
          charH = '7';
        else if (numberFollows && charH == 'h')
          charH = '8';
        else if (numberFollows && charH == 'i')
          charH = '9';
        else if (numberFollows && charH == 'j')
          charH = '0';
        else if (numberFollows && charH == ',') {
          charH = '1.';
          numberFollows = false;
        } else if (numberFollows && charH == ';') {
          charH = '2.';
          numberFollows = false;
        } else if (numberFollows && charH == ':') {
          charH = '3.';
          numberFollows = false;
        } else if (numberFollows && charH == '/') {
          charH = '4.';
          numberFollows = false;
        } else if (numberFollows && charH == '?') {
          charH = '5.';
          numberFollows = false;
        } else if (numberFollows && charH == '+') {
          charH = '6.';
          numberFollows = false;
        } else if (numberFollows && charH == '(') {
          charH = '7.';
          numberFollows = false;
        } else if (numberFollows && charH == '»') {
          charH = '8.';
          numberFollows = false;
        } else if (numberFollows && charH == '*') {
          charH = '9.';
          numberFollows = false;
        } else if (numberFollows && charH == '«') {
          charH = '0.';
          numberFollows = false;
        } else {
          numberFollows = false;
          if (singleCapitalFollows) {
            charH = charH.toUpperCase();
            singleCapitalFollows = false;
          } else if (capitalFollows) charH = charH.toUpperCase();
        }

        char = char + charH;
      }
    }

    displays.add(display);

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};
}
