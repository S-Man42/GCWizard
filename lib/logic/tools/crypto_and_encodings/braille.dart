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


// http://www.braille.ch/index.html#computer


enum BrailleLanguage { DEU, ENG, FRA, EUR }

Map<BrailleLanguage, String> BRAILLE_LANGUAGES = {
  BrailleLanguage.DEU: 'common_language_german',
  BrailleLanguage.ENG: 'braille_language_english',
  BrailleLanguage.FRA: 'common_language_french',
  BrailleLanguage.EUR: 'braille_language_euro',
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
  'à': ['1', '2', '5', '3', '6'],
  'â': ['1', '6'],
  'ç': ['1', '4', '2', '3', '6'],
  'è': ['4', '2', '3', '6'],
  'é': ['1', '4', '2', '5', '3', '6'],
  'ê': ['1', '2', '6'],
  'ë': ['1', '4', '2', '6'],
  'î': ['1', '4', '6'],
  'ï': ['1', '4', '2', '5', '6'],
  'ô': ['1', '4', '5', '6'],
  'œ': ['4', '2', '6'],
  'ù': ['4', '2', '5', '3', '6'],
  'û': ['1', '5', '6'],
  'ü': ['1', '2', '5', '6'],
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
final Map<String, List<String>> _charsToSegmentsEUR = { // http://fakoo.de/braille/computerbraille-text.html
  ' ': [], // 32
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
  '0': ['3', '4', '6'], //  48
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
  '?': ['2', '6'], //  63
  '@': ['3', '4', '5', '7'], //  64
  'A': ['1', '7'], //  65
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
  '^': ['2', '3', '4', '6', '7'],  //  94 x286e
  '_': ['4', '5', '6', '7'],
  '`': ['3', '4', '5'],
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
  '{': ['1', '2', '3', '5', '6'],
  '|': ['3', '4'],
  '}': ['2', '3', '4', '5', '6'],
  '~': ['2', '3', '4', '6'],
  //'': [],                                      // 127 x2858 [DEL]
  '€': ['4', '5', '7'],                          // 128 x28
  //'': [],                                      // 129 x2800 [HOP]
  '‚': ['3', '6', '7', '8'],                     // 130 x28e4
  'ƒ': ['7', '8'],                               // 131 x28c0
  '„': ['1', '2', '3', '4', '5', '6', '7'],      // 132 x287f
  '…': ['1', '2', '3', '4', '5', '6', '8'],      // 133 x28bf
  '†': ['1', '2', '4', '8'],                     // 134 x288b
  '‡': ['1', '2', '4', '5', '8'],                // 135 x289b
  'ˆ': ['3', '7', '8'],                          // 136 x28c4
  '‰': ['2', '4', '8'],                          // 137 x288a
  'Š': ['6', '7', '8'],                          // 138 x28e0
  '‹': ['2', '7'],                               // 139 x2842
  'Œ': ['2', '3', '7'],                          // 140 x2846
  //'': [],                                      // 141 x2852 [RI]
  'Ž': ['1', '2', '5', '6', '7'],                // 142 x2873
  //'': [],                                      // 143 x286b [SS3]
  //'': [],                                      // 144 x28eb [DCS]
  '‘': ['2', '3', '5', '6', '7'],                // 145 x2876
  '’': ['2', '3', '6', '7'],                     // 146 x2866
  '“': ['1', '3', '8'],                          // 147 x2885
  '”': ['1', '2', '3', '8'],                     // 148 x2887
  '•': ['2', '7', '8'],                          // 149 x28c2
  '–': ['2', '3', '7', '8'],                     // 150 x28c6
  '—': ['1', '3', '5', '6', '8'],                // 151 x28b5
  //'': [],                                      // 152 x28fb [SOS]
  '™': ['1', '2', '4', '5', '6', '7', '8'],      // 153 x28fb
  'š': ['2', '6', '7', '8'],                     // 154 x28e2
  '›': ['1', '2', '3', '4', '5', '8'],           // 155 x289f
  'œ': ['6', '7'],                               // 156 x2860
  //'': [],                                      // 157 x287b [OSC]
  'ž': ['2', '3', '5', '6', '7', '8'],           // 158 x28f6
  'Ÿ': ['1', '2', '3', '4', '5', '6', '7', '8'], // 159 x28ff
  '': [], // 160 x28
  '': [], // 161 x28
  '': [], // 162 x28
  '': [], // 163 x28
  '': [], // 164 x28
  '': [], // 165 x28
  '': [], // 166 x28
  '': [], // 167 x28
  '': [], // 168 x28
  '': [], // 169 x28
  '': [], // 170 x28
  '': [], // 171 x28
  '': [], // 172 x28
  '': [], // 173 x28
  '': [], // 174 x28
  '': [], // 175 x28
  '': [], // 176 x28
  '': [], // 177 x28
  '': [], // 178 x28
  '': [], // 179 x28
  '': [], // 180 x28
  '': [], // 181 x28
  '': [], // 182 x28
  '': [], // 183 x28
  '': [], // 184 x28
  '': [], // 185 x28
  '': [], // 186 x28
  '': [], // 187 x28
  '': [], // 188 x28
  '': [], // 189 x28
  '': [], // 190 x28
  '': [], // 191 x28
  '': [], // 192 x28
  '': [], // 193 x28
  '': [], // 194 x28
  '': [], // 195 x28
  '': [], // 196 x28
  '': [], // 197 x28
  '': [], // 198 x28
  '': [], // 199 x28
  '': [], // 200 x28
  '': [], // 201 x28
  '': [], // 202 x28
  '': [], // 203 x28
  '': [], // 204 x28
  '': [], // 205 x28
  '': [], // 206 x28
  '': [], // 207 x28
  '': [], // 208 x28
  '': [], // 209 x28
  '': [], // 210 x28
  '': [], // 211 x28
  '': [], // 212 x28
  '': [], // 213 x28
  '': [], // 214 x28
  '': [], // 215 x28
  '': [], // 216 x28
  '': [], // 217 x28
  '': [], // 218 x28
  '': [], // 219 x28
  '': [], // 220 x28
  '': [], // 221 x28
  '': [], // 222 x28
  '': [], // 223 x28
  '': [], // 224 x28
  '': [], // 225 x28
  '': [], // 226 x28
  '': [], // 227 x28
  '': [], // 228 x28
  '': [], // 229 x28
  '': [], // 230 x28
  '': [], // 231 x28
  '': [], // 232 x28
  '': [], // 233 x28
  '': [], // 234 x28
  '': [], // 235 x28
  '': [], // 236 x28
  '': [], // 237 x28
  '': [], // 238 x28
  '': [], // 239 x28
  '': [], // 240 x28
  '': [], // 241 x28
  '': [], // 242 x28
  '': [], // 243 x28
  '': [], // 244 x28
  '': [], // 245 x28
  '': [], // 246 x28
  '': [], // 247 x28
  '': [], // 248 x28
  '': [], // 249 x28
  '': [], // 250 x28
  '': [], // 251 x28
  '': [], // 252 x28
  '': [], // 253 x28
  '': [], // 254 x28
  '': [], // 255 x28
};

var _segmentsToCharsDEU = switchMapKeyValue(_charsToSegmentsDEU);
var _segmentsToCharsENG = switchMapKeyValue(_charsToSegmentsENG);
var _segmentsToCharsFRA = switchMapKeyValue(_charsToSegmentsFRA);
var _segmentsToCharsEUR = switchMapKeyValue(_charsToSegmentsEUR);

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

List<List<String>> _encodeBrailleEUR(String input) {
  List<String> inputs = input.split('');
  List<List<String>> result = new List<List<String>>();

  for (int i = 0; i < inputs.length; i++) {
    result.add(_charsToSegmentsEUR[inputs[i]]);
  }
  return result;
}

List<List<String>> _encodeBrailleDEU(String input) {
  bool numberFollows = false;

  List<String> inputs = input.split('');
  List<List<String>> result = new List<List<String>>();

  for (int i = 0; i < inputs.length; i++) {
    if (_isNumber(inputs[i])) {
      if (!numberFollows) {
        result.add(_charsToSegmentsDEU['#']);
        numberFollows = true;
      }
      if (i < inputs.length - 1 && inputs[i + 1] == '.') {
        result.add(_ordinalNumber(inputs[i], _charsToSegmentsDEU));
        i++;
      } else
        result.add(_charsToSegmentsDEU[inputs[i]]);
    } else {
      if (!_isMathmatical(inputs[i])) numberFollows = false;
      if (_isCapital(inputs[i])) {
        result.add(_charsToSegmentsDEU['\$']);
        inputs[i] = inputs[i].toLowerCase();
      }
      if (inputs[i] == 's' && i < inputs.length - 1 && inputs[i + 1] == 't') {
        result.add(_charsToSegmentsDEU['st']);
        i++;
      } else if (inputs[i] == 'a' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'u') {
        result.add(_charsToSegmentsDEU['au']);
        i++;
      } else if (inputs[i] == 'e' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'u') {
        result.add(_charsToSegmentsDEU['eu']);
        i++;
      } else if (inputs[i] == 'e' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'i') {
        result.add(_charsToSegmentsDEU['ei']);
        i++;
      } else if (inputs[i] == 'ä' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'U') {
        result.add(_charsToSegmentsDEU['äu']);
        i++;
      } else if (inputs[i] == 'i' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'e') {
        result.add(_charsToSegmentsDEU['ie']);
        i++;
      } else if (inputs[i] == 'c' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'h') {
        result.add(_charsToSegmentsDEU['ch']);
        i++;
      } else if (inputs[i] == 's' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'c' &&
          inputs[i + 2] == 'h') {
        result.add(_charsToSegmentsDEU['sch']);
        i = i + 2;
      } else
        result.add(_charsToSegmentsDEU[inputs[i]]);
    }
  }
  return result;
}

List<List<String>> _encodeBrailleENG(String input) {

  bool numberFollows = false;

  List<String> inputs = input.split('');
  List<List<String>> result = new List<List<String>>();

  for (int i = 0; i < inputs.length; i++) {
    if (_isNumber(inputs[i])) {
      if (!numberFollows) {
        result.add(_charsToSegmentsENG['#']);
        numberFollows = true;
      }
      if (i < inputs.length - 1 && inputs[i + 1] == '.') {
        result.add(_ordinalNumber(inputs[i], _charsToSegmentsENG));
        i++;
      } else
        result.add(_charsToSegmentsENG[inputs[i]]);
    } else {
      if (!_isMathmatical(inputs[i])) numberFollows = false;
      if (inputs[i] == 'C' && i < inputs.length - 1 && inputs[i + 1] == 'H') {
        result.add(_charsToSegmentsENG['CH']);
        i++;
      } else if (inputs[i] == 'G' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'H') {
        result.add(_charsToSegmentsENG['GH']);
        i++;
      } else if (inputs[i] == 'S' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'H') {
        result.add(_charsToSegmentsENG['SH']);
        i++;
      } else if (inputs[i] == 'T' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'H') {
        result.add(_charsToSegmentsENG['TH']);
        i++;
      } else if (inputs[i] == 'W' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'H') {
        result.add(_charsToSegmentsENG['WH']);
        i++;
      } else if (inputs[i] == 'E' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'D') {
        result.add(_charsToSegmentsENG['ED']);
        i++;
      } else if (inputs[i] == 'E' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'R') {
        result.add(_charsToSegmentsENG['ER']);
        i++;
      } else if (inputs[i] == 'O' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'U') {
        result.add(_charsToSegmentsENG['OU']);
        i++;
      } else if (inputs[i] == 'O' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'W') {
        result.add(_charsToSegmentsENG['OW']);
        i++;
      } else if (inputs[i] == 'I' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'N') {
        result.add(_charsToSegmentsENG['IN']);
        i++;
      } else if (inputs[i] == 'E' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'A') {
        result.add(_charsToSegmentsENG['EA']);
        i++;
      } else if (inputs[i] == 'B' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'B') {
        result.add(_charsToSegmentsENG['BB']);
        i++;
      } else if (inputs[i] == 'C' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'C') {
        result.add(_charsToSegmentsENG['CC']);
        i++;
      } else if (inputs[i] == 'D' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'D') {
        result.add(_charsToSegmentsENG['DD']);
        i++;
      } else if (inputs[i] == 'E' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'N') {
        result.add(_charsToSegmentsENG['EN']);
        i++;
      } else if (inputs[i] == 'F' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'F') {
        result.add(_charsToSegmentsENG['FF']);
        i++;
      } else if (inputs[i] == 'G' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'G') {
        result.add(_charsToSegmentsENG['GG']);
        i++;
      } else if (inputs[i] == 'S' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'T') {
        result.add(_charsToSegmentsENG['ST']);
        i++;
      } else if (inputs[i] == 'A' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'R') {
        result.add(_charsToSegmentsENG['AR']);
        i++;
      } else if (inputs[i] == 'O' &&
          i < inputs.length - 1 &&
          inputs[i + 1] == 'F') {
        result.add(_charsToSegmentsENG['OF']);
        i++;
      } else if (inputs[i] == 'S' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'C' &&
          inputs[i + 2] == 'H') {
        result.add(_charsToSegmentsENG['SCH']);
        i = i + 2;
      } else if (inputs[i] == 'A' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'N' &&
          inputs[i + 2] == 'D') {
        result.add(_charsToSegmentsENG['AND']);
        i = i + 2;
      } else if (inputs[i] == 'F' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'O' &&
          inputs[i + 2] == 'R') {
        result.add(_charsToSegmentsENG['FOR']);
        i = i + 2;
      } else if (inputs[i] == 'T' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'H' &&
          inputs[i + 2] == 'E') {
        result.add(_charsToSegmentsENG['THE']);
        i = i + 2;
      } else if (inputs[i] == 'I' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'N' &&
          inputs[i + 2] == 'G') {
        result.add(_charsToSegmentsENG['ING']);
        i = i + 2;
      } else if (inputs[i] == 'B' &&
          i < inputs.length - 2 &&
          inputs[i + 1] == 'L' &&
          inputs[i + 2] == 'E') {
        result.add(_charsToSegmentsENG['BLE']);
        i = i + 2;
      } else if (inputs[i] == 'W' &&
          i < inputs.length - 3 &&
          inputs[i + 1] == 'I' &&
          inputs[i + 2] == 'T' &&
          inputs[i + 3] == 'H') {
        result.add(_charsToSegmentsENG['WITH']);
        i = i + 2;
      } else
        result.add(_charsToSegmentsENG[inputs[i]]);
    }
  }
  return result;
}

List<List<String>> _encodeBrailleFRA(String input) {
  bool numberFollows = false;

  List<String> inputs = input.split('');
  List<List<String>> result = new List<List<String>>();

  for (int i = 0; i < inputs.length; i++) {
    if (_isNumber(inputs[i])) {
      if (!numberFollows) {
        result.add(_charsToSegmentsFRA['#']);
        numberFollows = true;
      }
      if (i < inputs.length - 1 && inputs[i + 1] == '.') {
        result.add(_ordinalNumber(inputs[i], _charsToSegmentsFRA));
        i++;
      } else
        result.add(_charsToSegmentsFRA[inputs[i]]);
    } else {
      if (!_isMathmatical(inputs[i])) numberFollows = false;
    }
  }

  return result;
}

List<List<String>> encodeBraille(String input, BrailleLanguage language) {
  if (input == null) return [];

  switch (language) {
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
    case BrailleLanguage.DEU:
      _segmentsToChars = _segmentsToCharsDEU;
      break;
    case BrailleLanguage.ENG:
      _segmentsToChars = _segmentsToCharsENG;
      break;
    case BrailleLanguage.FRA:
      _segmentsToChars = _segmentsToCharsFRA;
      break;
    case BrailleLanguage.EUR:
      _segmentsToChars = _segmentsToCharsEUR;
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
