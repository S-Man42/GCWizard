import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
// https://www.pharmabraille.com/wp-content/uploads/2014/11/World-Braille-Usage-Third-Edition-1.pdf

// https://de.wikipedia.org/wiki/Brailleschrift
// https://www.pharmabraille.com/wp-content/uploads/2015/01/system_d_blindenschrift_7620.pdf

// https://en.wikipedia.org/wiki/Braille
// https://en.wikipedia.org/wiki/English_Braille
// http://www.acb.org/tennessee/braille.html
// https://www.pharmabraille.com/wp-content/uploads/2015/11/Rules-of-Unified-English-Braille-2013.pdf

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
  '1': ['1'],
  '2': ['1', '2'],
  '3': ['1', '4'],
  '4': ['1', '4', '5'],
  '5': ['1', '5'],
  '6': ['1', '4', '2'],
  '7': ['1', '4', '2', '5'],
  '8': ['1', '2', '5'],
  '9': ['4', '2'],
  '0': ['4', '2', '5'],
  'a': ['1'],
  'b': ['1', '2'],
  'c': ['1', '4'],
  'd': ['1', '4', '5'],
  'e': ['1', '5'],
  'f': ['1', '4', '2'],
  'g': ['1', '4', '2', '5'],
  'h': ['1', '2', '5'],
  'i': ['4', '2'],
  'j': ['4', '2', '5'],
  'k': ['1', '3'],
  'l': ['1', '2', '3'],
  'm': ['1', '4', '3'],
  'n': ['1', '4', '5', '3'],
  'o': ['1', '5', '3'],
  'p': ['1', '4', '2', '3'],
  'q': ['1', '4', '2', '5', '3'],
  'r': ['1', '2', '5', '3'],
  's': ['4', '2', '3'],
  't': ['4', '2', '5', '3'],
  'u': ['1', '3', '6'],
  'v': ['1', '2', '3', '3'],
  'w': ['4', '2', '5', '6'],
  'x': ['1', '4', '3', '6'],
  'y': ['1', '4', '5', '3', '6'],
  'z': ['1', '5', '3', '6'],
  'ä': ['4', '5', '3'],
  'ö': ['4', '2', '6'],
  'ü': ['1', '2', '5', '6'],
  'ß': ['4', '2', '3', '6'],
  'st': ['4', '2', '5', '3', '6'],
  ']': ['4', '2', '5', '3', '6'],
  '[': ['1', '2', '5', '3', '6'],
  'au': ['1', '6'],
  'eu': ['1', '2', '6'],
  'ei': ['1', '4', '6'],
  'äu': ['4', '3'],
  'ie': ['4', '3', '3'],
  'ch': ['1', '4', '5', '6'],
  'sch': ['1', '5', '6'],
  ',': ['2'],
  ';': ['2', '3'],
  ':': ['2', '5'],
  '.': ['3'],
  '?': ['2', '6'],
  '+': ['2', '5', '3'],
  '!': ['2', '5', '3'],
  '#': ['4', '5', '3', '6'], // number follows
  '=': ['2', '5', '3', '6'],
  '(': ['2', '5', '3', '6'],
  ')': ['2', '5', '3', '6'],
  ']': ['4', '2', '5', '3', '6'],
  '[': ['1', '2', '5', '3', '6'],
  '%': ['1', '4', '2', '5', '3', '6'],
  '^': ['1', '4', '2', '5', '6'],
  '`': ['1', '4', '2', '6'],
  '-': ['3', '6'],
  '§': ['4', '3', '6'],
  '»': ['2', '3', '6'],
  '«': ['5', '3', '6'],
  "'": ['6'], // small letters follows
  '~': ['5'],
  '>': ['4', '5'],
  '<': ['5', '6'],
  '/': ['2', '5', '6'],
  '\$': ['4', '6'], // capitel follows
  '_': ['4', '5', '6'],
};
final Map<String, List<String>> _charsToSegmentsENG = {
  ' ': [],
  '1': ['1'],
  '2': ['1', '2'],
  '3': ['1', '4'],
  '4': ['1', '4', '5'],
  '5': ['1', '5'],
  '6': ['1', '4', '2'],
  '7': ['1', '4', '2', '5'],
  '8': ['1', '2', '5'],
  '9': ['4', '2'],
  '0': ['4', '2', '5'],
  'a': ['a'],
  'b': ['1', '2'],
  'c': ['1', '4'],
  'd': ['1', '4', '5'],
  'e': ['1', '5'],
  'f': ['1', '4', '2'],
  'g': ['1', '4', '2', '5'],
  'h': ['1', '2', '5'],
  'i': ['4', '2'],
  'j': ['4', '2', '5'],
  'k': ['1', '3'],
  'l': ['1', '2', '3'],
  'm': ['1', '4', '3'],
  'n': ['1', '4', '5', '3'],
  'o': ['1', '5', '3'],
  'p': ['1', '4', '2', '3'],
  'q': ['1', '4', '2', '5', '3'],
  'r': ['1', '2', '5', '3'],
  's': ['4', '2', '3'],
  't': ['4', '2', '5', '3'],
  'u': ['1', '3', '6'],
  'v': ['1', '2', '3', '3'],
  'w': ['4', '2', '5', '6'],
  'x': ['1', '4', '3', '6'],
  'y': ['1', '4', '5', '3', '6'],
  'z': ['1', '5', '3', '6'],
  'and': ['1', '4', '2', '3', '6'],
  'for': ['1', '4', '2', '5', '3', '6'],
  'of': ['1', '2', '5', '3', '6'],
  'the': ['4', '2', '3', '6'],
  'with': ['4', '2', '5', '3', '6'],
  'ch': ['1', '6'],
  'gh': ['1', '2', '6'],
  'sh': ['1', '4', '6'],
  'th': ['1', '4', '5', '6'],
  'wh': ['1', '5', '6'],
  'ed': ['1', '4', '2', '6'],
  'er': ['1', '4', '2', '5', '6'],
  'ou': ['1', '2', '5', '6'],
  'ow': ['4', '2', '6'],
  'st': ['4', '3'], //    or /
  'ar': ['4', '5', '3'],
  'ing': ['4', '3', '6'],
  'ble': ['4', '5', '3', '6'],
  'bb': ['2', '3'],
  'cc': ['2', '5'],
  'en': ['2', '6'],
  'ff': ['2', '5', '3'],
  'in': ['5', '3'],
  'by': ['5', '3', '6'],
  ',': ['2'],
  ';': ['2', '3'],
  ':': ['2', '5'],
  '.': ['2', '5', '6'],
  '?': ['2', '3', '6'],
  '!': ['2', '5', '3'],
  '+': ['2', '5', '3'],
  '#': ['4', '5', '3', '6'], // number follows
  '=': ['2', '5', '3', '6'],
  '-': ['3', '6'],
  '§': ['4', '3', '6'],
  '"': ['2', '3', '6'],
  "'": ['4'],
  '~': ['5'],
  '>': ['4', '5'],
  '<': ['5', '6'],
  '/': ['4', '3'],
  '_': ['3', '6'],
};
final Map<String, List<String>> _charsToSegmentsFRA = {
  ' ': [],
  'A': ['a'],
  'B': ['1', '2'],
  'C': ['1', '4'],
  'D': ['1', '4', '5'],
  'E': ['1', '5'],
  'F': ['1', '4', '2'],
  'G': ['1', '4', '2', '5'],
  'H': ['1', '2', '5'],
  'I': ['4', '2'],
  'J': ['4', '2', '5'],
  'K': ['1', '3'],
  'L': ['1', '2', '3'],
  'M': ['1', '4', '3'],
  'N': ['1', '4', '5', '3'],
  'O': ['1', '5', '3'],
  'P': ['1', '4', '2', '3'],
  'Q': ['1', '4', '2', '5', '3'],
  'R': ['1', '2', '5', '3'],
  'S': ['4', '2', '3'],
  'T': ['4', '2', '5', '3'],
  'U': ['1', '3', '6'],
  'V': ['1', '2', '3', '3'],
  'W': ['4', '2', '5', '6'],
  'X': ['1', '4', '3', '6'],
  'Y': ['1', '4', '5', '3', '6'],
  'Z': ['1', '5', '3', '6'],
  'À': ['1', '2', '5', '3', '6'],
  'Â': ['1', '6'],
  'Ç': ['1', '4', '2', '3', '6'],
  'È': ['4', '2', '3', '6'],
  'É': ['1', '4', '2', '5', '3', '6'],
  'Ê': ['1', '2', '6'],
  'Ë': ['1', '4', '2', '6'],
  'Î': ['1', '4', '6'],
  'Ï': ['1', '4', '2', '5', '6'],
  'Ô': ['1', '4', '5', '6'],
  'Œ': ['4', '2', '6'],
  'Ù': ['4', '2', '5', '3', '6'],
  'Û': ['1', '5', '6'],
  'Ü': ['1', '2', '5', '6'],
  ',': ['2'],
  ';': ['2', '3'],
  ':': ['2', '5'],
  '.': ['2', '5', '6'],
  '?': ['2', '6'],
  '!': ['2', '5', '3'],
  '"': ['2', '5', '3', '6'],
  '(': ['2', '3', '6'],
  ')': ['5', '3', '6'],
  "'": ['3'],
  '/': ['4', '3'],
  '@': ['4', '5', '3'],
//  mathmatics symbols or number follows  ['6'],
  '1': ['1', '6'],
  '2': ['1', '2', '6'],
  '3': ['1', '4', '6'],
  '4': ['1', '4', '5', '6'],
  '5': ['1', '5', '6'],
  '6': ['1', '4', '2', '6'],
  '7': ['1', '4', '2', '5', '6'],
  '8': ['1', '2', '5', '6'],
  '9': ['4', '2', '6'],
  '0': ['4', '2', '5', '6'],
  '+': ['4', '2', '3'],
  '-': ['3', '6'],
  '=': ['2', '5', '3', '6'],
  '×': ['2', '3'],
  '÷': ['2', '5'],
//  typographic symbols follows  ['4', '5'],
  '¢': ['1', '5'],
  '€': ['1', '3'],
  '£': ['1', '2', '3'],
  'µ': ['1', '2', '5'],
  'π': ['1', '4', '2', '5'],
  '\$': ['4', '2', '5'],
  '¥': ['1', '2', '5', '3', '6'],
  '≤': ['1', '4', '6'],
  '≥': ['2', '5', '3'],
  '[': ['4', '2', '6'],
//  typographic symbols follows  ['5'],
  '©': ['1', '5'],
  '°': ['1', '2', '3'],
  '§': ['1', '4', '2', '5'],
  '®': ['1', '4', '2', '3'],
  '™': ['4', '2', '5', '3'],
  '&': ['1', '4', '2', '5', '3', '6'],
  '<': ['1', '4', '6'],
  '>': ['2', '5', '3'],
  '~': ['4', '6'],
  '*': ['5', '3'],
  '\\': ['2', '5'],
  '#': ['2', '5', '3', '6'],
  '%': ['2', '5', '6'],
  '_': ['3', '6'],
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
