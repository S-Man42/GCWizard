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

final Map<String, List<String>> _charsToSegmentsLetters = {
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
};

final Map<String, List<String>> _charsToSegmentsDigits = {
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
};

final Map<String, List<String>> _charsToSegmentsDEU = {
  'ä': ['4', '5', '3'],
  'ö': ['4', '2', '6'],
  'ü': ['1', '2', '5', '6'],
  'ß': ['4', '2', '3', '6'],
  // Basis Interpunktions- und Sonderzeichen
  ',': ['2'],
  ';': ['2', '3'],
  ':': ['2', '5'],
  '?': ['2', '6'],
  '!': ['2', '5', '3'],
  '(': ['2', '5', '3', '6'],
  ')': ['2', '5', '3', '6'],
  '»': ['2', '3', '6'],
  '«': ['5', '3', '6'],
  '.': ['3'],
  '-': ['3', '6'],
  "'": ['6'], // small letters follows
  '§': ['4', '3', '6'],
  // Vollschrift
  ' ': [],
  'au': ['1', '6'],
  'eu': ['1', '2', '6'],
  'ei': ['1', '4', '6'],
  'ch': ['1', '4', '5', '6'],
  'sch': ['1', '5', '6'],
  'st': ['4', '2', '5', '3', '6'],
  'äu': ['4', '3'],
  'ie': ['4', '3', '3'],
  // Mathematische Zeichen
  '+': ['2', '5', '3'],
  '': ['2', '6'],
  '=': ['2', '5', '3', '6'],
  '/': ['2', '5', '6'],
  // others
  ']': ['4', '2', '5', '3', '6'],
  '[': ['1', '2', '5', '3', '6'],
  '%': ['1', '4', '2', '5', '3', '6'],
  '^': ['1', '4', '2', '5', '6'],
  '`': ['1', '4', '2', '6'],
  '~': ['5'],
  '>': ['4', '5'],
  '<': ['5', '6'],
  '_': ['4', '5', '6'],
  '>' : ['4', '5'],
  "'" : ['6'],
  '#': ['4', '5', '3', '6'],


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
  'w': ['2', '4', '5', '6'],
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
  ' ': ['7'],                                    // 160 x2840
  '¡': ['3', '6', '7'], // 161 x28
  '¢': ['5', '8'], // 162 x28
  '£': ['4', '6', '7'],// 163 x28
  '¤': ['4', '6', '7', '8'], // 164 x28
  '¥': ['4', '6', '8'], // 165 x28
  '¦': ['1', '5', '8'], // 166 x28
  '§': ['3', '5', '7'], // 167 x28
  '¨': ['4', '8'], // 168 x28
  '©': ['1', '2', '3', '4', '6', '8'], // 169 x28
  'ª': ['1', '2', '5', '8'], // 170 x28
  '«': ['5', '6', '7', '8'], // 171 x28
  '¬': ['2', '5', '6', '7', '8'], // 172 x28
  //'': [], // 173 x28
  '®': ['1', '2', '3', '5', '8'], // 174 x28
  '¯': ['4', '5', '8'], // 175 x28
  '°': ['4', '5', '6', '8'], // 176 x28
  '±': ['2', '3', '5', '7', '8'], // 177 x28
  '²': ['1', '2', '8'], // 178 x28
  '³': ['1', '4', '8'], // 179 x28
  '´': ['5', '6', '8'], // 180 x28
  'µ': ['1', '3', '4', '8'], // 181 x28
  '¶': ['1', '4', '5', '8'], // 182 x28
  '·': ['3', '7'], // 183 x28
  '¸': ['6', '8'], // 184 x28
  '¹': ['1', '8'], // 185 x28
  'º': ['2', '4', '5', '8'], // 186 x28
  '»': ['4', '5', '7', '8'], // 187 x28
  '¼': ['1', '3', '6', '8'], // 188 x28
  '½': ['1', '2', '3', '6', '8'], // 189 x28
  '¾': ['1', '3', '4', '6', '8'], // 190 x28
  '¿': ['3', '8'], // 191 x28
  'À': ['2', '3', '6', '7', '8'], // 192 x28
  'Á': ['2', '8'], // 193 x28
  'Â': ['1', '6', '7'], // 194 x28
  'Ã': ['3', '4', '6', '7'], // 195 x28
  'Ä': ['5', '6', '7'], // 196 x28
  'Å': ['3', '4', '5', '6', '7'], // 197 x28
  'Æ': ['4', '7'], // 198 x28
  'Ç': ['1', '2', '3', '4', '6', '7'], // 199 x28
  'È': ['3', '5', '7', '8'], // 200 x28
  'É': ['2', '3', '8'], // 201 x28
  'Ê': ['1', '2', '6', '7'], // 202 x28
  'Ë': ['2', '3', '5', '8'], // 203 x28
  'Ì': ['5', '7'], // 204 x28
  'Í': ['2', '5', '8'], // 205 x28
  'Î': ['1', '4', '6', '7'], // 206 x28
  'Ï': ['2', '3', '5', '6', '8'], // 207 x28
  'Ð': ['3', '5', '6', '7'], // 208 x28
  'Ñ': ['2', '5', '6', '7'], // 209 x28
  'Ò': ['5', '7', '8'], // 210 x28
  'Ó': ['2', '5', '6', '8'], // 211 x28
  'Ô': ['1', '4', '5', '6', '7'], // 212 x28
  'Õ': ['2', '6', '7'], // 213 x28
  'Ö': ['3', '5', '8'], // 214 x28
  '×': ['2', '3', '4', '8'], // 215 x28
  'Ø': ['2', '4', '6', '7'], // 216 x28
  'Ù': ['3', '5', '6', '7', '8'], // 217 x28
  'Ú': ['2', '6', '8'], // 218 x28
  'Û': ['1', '5', '6', '7'], // 219 x28
  'Ü': ['2', '3', '6', '8'], // 220 x28
  'Ý': ['3', '5', '6', '8'], // 221 x28
  'Þ': ['2', '3', '5', '7'], // 222 x28
  'ß': ['3', '4', '5', '6', '8'], // 223 x28
  'à': ['1', '2', '3', '5', '6', '8'], // 224 x28
  'á': ['1', '6', '8'], // 225 x28
  'â': ['1', '6', '7', '8'], // 226 x28
  'ã': ['3', '4', '6', '7', '8'], // 227 x28
  'ä': ['3', '4', '5', '8'], // 228 x28
  'å': ['3', '4', '5', '6', '7', '8'], // 229 x28
  'æ': ['4', '7', '8'], // 230 x28
  'ç': ['1', '2', '3', '4', '6', '7', '8'], // 231 x28
  'è': ['2', '3', '4', '6', '8'], // 232 x28
  'é': ['1', '2', '6', '8'], // 233 x28
  'ê': ['1', '2', '6', '7', '8'], // 234 x28
  'ë': ['1', '2', '4', '6', '8'], // 235 x28
  'ì': ['3', '4', '8'], // 236 x28
  'í': ['1', '4', '6', '8'], // 237 x28
  'î': ['1', '4', '6', '7', '8'], // 238 x28
  'ï': ['1', '2', '4', '5', '6', '8'], // 239 x28
  'ð': ['2', '3', '4', '5', '8'], // 240 x28
  'ñ': ['1', '3', '4', '5', '8'], // 241 x28
  'ò': ['3', '4', '6', '8'], // 242 x28
  'ó': ['1', '4', '5', '6', '8'], // 243 x28
  'ô': ['1', '4', '5', '6', '7', '8'], // 244 x28
  'õ': ['1', '3','5', '8'], // 245 x28,
  'ö': ['2', '4', '6', '8'], // 246 x28
  '÷': ['1', '2', '5', '6', '7', '8'], // 247 x28
  'ø': ['2', '4', '6', '7', '8'], // 248 x28
  'ù': ['2', '3', '4', '5', '6', '8'], // 249 x28
  'ú': ['1', '5', '6', '8'], // 250 x28
  'û': ['1', '5', '6', '7', '8'], // 251 x28
  'ü': ['1', '2', '5', '6', '8'], // 252 x28
  'ý': ['2', '4', '5', '6', '8'], // 253 x28
  'þ': ['1', '2', '3', '4', '8'], // 254 x28
  'ÿ': ['1', '3', '4', '5', '6', '8'], // 255 x28
};

var _segmentsToCharsLetters = switchMapKeyValue(_charsToSegmentsLetters);
var _segmentsToCharsDigit = switchMapKeyValue(_charsToSegmentsDigits);
var _segmentsToCharsDEU = switchMapKeyValue(_charsToSegmentsDEU);
var _segmentsToCharsENG = switchMapKeyValue(_charsToSegmentsENG);
var _segmentsToCharsFRA = switchMapKeyValue(_charsToSegmentsFRA);
var _segmentsToCharsEUR = switchMapKeyValue(_charsToSegmentsEUR);

final _DEUmulti = {'—', '*', '[', ']', '‘', '‘', '|', '…', '→', '←', '&', '%', '‰', '°', '’', '"', '\\', '@', '€', '£', '\$', '¢'};
final Map<String, List<List<String>>> _charsetDEUmulti = {
  '—' : [['6'], ['3', '6']],
  '*' : [['6'], ['3', '5']],
  '[' : [['6'], ['2', '3', '5', '6']],
  ']' : [['6'], ['2', '3', '5', '6']],
  '‘' : [['6'], ['2', '3', '6']],
  '‘' : [['6'], ['3', '5', '6']],
  '|' : [['4', '5', '6'], ['1', '2', '3']],
  '…' : [['3'], ['3'], ['3']],
  '→' : [['2', '5'], ['2', '5'], ['1', '3', '5']],
  '←' : [['2', '4', '6'], ['2', '5'], ['2', '5']],
  '&' : [['5'], ['1', '3', '6']],
  '%' : [['3', '4', '5', '6'], []],
  '‰' : [['3', '4', '5', '6'], []],
  '°' : [['4'], ['3', '5', '6']],
  '’' : [['4'], ['3', '5']],
  '"' : [['4'], ['3', '5'], ['3', '5']],
  '\\' : [['4'], ['3', '4']],
  '@' : [['4'], ['3', '4', '5']],
  '€' : [['4'], ['1', '5']],
  '£' : [['4'], ['4', '5', '6']],
  '\$' : [['4'], ['2', '3', '4']],
  '¢' : [['4'], ['1', '4']],
};

final _DEUswitches = {'ocf', 'cf', 'slf', 'nf'};
final Map<String, List<String>> _charsetDEUswitches = {
  'ocf' : ['4', '6'],
  'cf' : ['4', '5'],
  'slf' : ['6'],
  'nf' : ['3', '4', '5', '6']
};
var _segmentsToDEUswitches = switchMapKeyValue(_charsetDEUswitches);

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

List<List<String>> _encodeBrailleEUR(String input) {
  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    result.add(_charsToSegmentsEUR[inputs[i]]);
  }
  return result;
}

List<List<String>> _encodeBrailleDEU(String input) {
  bool StateNumberFollows = false;
  bool StateCapitals = false;

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  _charsToSegmentsDEU.addAll(_charsToSegmentsLetters);
  _charsToSegmentsDEU.addAll(_charsToSegmentsDigits);

  for (int i = 0; i < inputs.length; i++) {
    if (_DEUmulti.contains(inputs[i]))
      result.addAll(_charsetDEUmulti[inputs[i]]);

    if (_isNumber(inputs[i])) {
      if (!StateNumberFollows) {
        result.add(_charsetDEUswitches['nf']);
        StateNumberFollows = true;
      }
      result.add(_charsToSegmentsDEU[inputs[i]]);
    } else {
      if (!_isMathmatical(inputs[i])) StateNumberFollows = false;
      if (_isSmallLetter(inputs[i])) {
        if (StateCapitals)
          StateCapitals = false;
      }
      if (_isCapital(inputs[i])) {
        // check following letter
        if (i < inputs.length - 1 && _isSmallLetter(inputs[i + 1]) )
          result.add(_charsetDEUswitches['ocf']);
        else {
          result.add(_charsetDEUswitches['cf']);
          StateCapitals = true;
        }
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
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (_isNumber(inputs[i])) {
      if (!numberFollows) {
        result.add(_charsToSegmentsENG['#']);
        numberFollows = true;
      }
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



Map<String, dynamic> _decodeEURBraille(List<String> inputs) {
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
      char = char +  _segmentsToCharsEUR.map((key, value) =>
          MapEntry(key.join(), value.toString()))[input.split('').join()];
    }
    displays.add(display);

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};
}

Map<String, dynamic> _decodeDEUBraille(List<String> inputs) {
  var displays = <List<String>>[];

  bool numberFollows = false;
  bool capitalFollows = false;
  bool oneCapitalFollows = false;
  bool smallLettersFollows = false;

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';
    var display = <String>[];
    input.split('').forEach((element) {
      display.add(element);
    });

    _segmentsToCharsDEU.addAll(_segmentsToDEUswitches);
    _segmentsToCharsDEU.addAll(_segmentsToCharsLetters);

    if (_segmentsToCharsDEU.map((key, value) =>
        MapEntry(key.join(), value.toString()))[input.split('').join()] ==
        null)
      char = char + UNKNOWN_ELEMENT;
    else {
      charH = _segmentsToCharsDEU.map((key, value) =>
          MapEntry(key.join(), value.toString()))[input.split('').join()];
      print(charH);
      if (_DEUswitches.contains(charH)) {
        if (charH == 'ocf')
          oneCapitalFollows = true;
        else if (charH == "cf")
          capitalFollows = true;
        else if (charH == "slf")
          smallLettersFollows = false;
        else if (charH == 'nf')
          numberFollows = true;
      } else if (charH == ' ') {
         numberFollows = false;
         capitalFollows = false;
         oneCapitalFollows = false;
         smallLettersFollows = false;
      } else { // no switch
        if (numberFollows) {
          if (_LetterToDigit[charH] == null)
            numberFollows = false;
          else
            charH = _LetterToDigit[charH];
        } else if (oneCapitalFollows) {
            charH = charH.toUpperCase();
            oneCapitalFollows = false;
          }
        else if (capitalFollows) {
          charH = charH.toUpperCase();
        }
        char = char + charH;
        }
      }

    displays.add(display);

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};

}
Map<String, dynamic> _decodeENGBraille(List<String> inputs) {

  return {
    'displays': [[]],
    'chars': [0]
  };
}
Map<String, dynamic> _decodeFRABraille(List<String> inputs) {

  return {
    'displays': [[]],
    'chars': [0]
  };
}

Map<String, dynamic> decodeBraille(List<String> inputs, BrailleLanguage language) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': [[]],
      'chars': [0]
    };

  switch (language) {
    case BrailleLanguage.DEU:
      return _decodeDEUBraille(inputs);
      break;
    case BrailleLanguage.ENG:
      return _decodeENGBraille(inputs);
      break;
    case BrailleLanguage.FRA:
      return _decodeFRABraille(inputs);
      break;
    case BrailleLanguage.EUR:
      return _decodeEURBraille(inputs);
      break;
  }
}
