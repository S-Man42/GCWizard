import 'dart:core';
import 'dart:math';

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

enum SegmentDisplayType{SEVEN, FOURTEEN, SIXTEEN, CISTERCIAN}

final _baseSegments7Segment = ['a','b','c','d','e','f','g','dp'];
final _baseSegments14Segment = ['a','b','c','d','e','f','g1','g2','h','i','j','k','l','m','dp'];
final _baseSegments16Segment = ['a1','a2','b','c','d1','d2','e','f','g1','g2','h','i','j','k','l','m','dp'];
final _baseSegmentsCistercianSegment = ['z1','z2','z3','z4','z5','z6','z7','z8','z9','z10','z11','z12','z13','z14','z15','16','z17','z18','z19','z20','z21'];

final Map<String, List<String>> _AZTo16Segment = {
  '1'  : ['b','c','j'],
  '2'  : ['a1','a2','b','d1','d2','e','g1','g2'],
  '3'  : ['a1','a2','b','c','d1','d2','g1','g2'],
  '4'  : ['b','c','f','g1','g2'],
  '5'  : ['a1','a2','c','d1','d2','f','g1','g2'],
  '6'  : ['a1','a2','c','d1','d2','e','f','g1','g2'],
  '7'  : ['a1','a2','j','k'],
  '8'  : ['a1','a2','b','c','d1','d2','e','f','g1','g2'],
  '9'  : ['a1','a2','b','c','d1','d2','f','g1','g2'],
  '0'  : ['a1','a2','b','c','d1','d2','e','f','j','k'],
  'A'  : ['a1','a2','b','c','e','f','g1','g2'],
  'B'  : ['a1','a2','b','c','d1','d2','g2','i','l'],
  'C'  : ['a1','a2','d1','d2','e','f'],
  'D'  : ['a1','a2','b','c','d1','d2','i','l'],
  'E'  : ['a1','a2','d1','d2','e','f','g1'],
  'F'  : ['a1','a2','e','f','g1'],
  'G'  : ['a1','a2','c','d1','d2','e','f','g2'],
  'H'  : ['b','c','e','f','g1','g2'],
  'I'  : ['a1','a2','d1','d2','i','l'],
  'J'  : ['a1','a2','b','c','d1','d2','e'],
  'K'  : ['e','f','g1','j','m'],
  'L'  : ['d1','d2','e','f'],
  'M'  : ['b','c','e','f','h','j'],
  'N'  : ['b','c','e','f','h','m'],
  'O'  : ['a1','a2','b','c','d1','d2','e','f'],
  'P'  : ['a1','a2','b','e','f','g1','g2'],
  'Q'  : ['a1','a2','b','c','d1','d2','e','f','m'],
  'R'  : ['a1','a2','b','e','f','g1','g2','m'],
  'S'  : ['a1','a2','c','d1','d2','g2','h'],
  'T'  : ['a1','a2','i','l'],
  'U'  : ['b','c','d1','d2','e','f'],
  'V'  : ['e','f','j','k'],
  'W'  : ['b','c','e','f','k','m'],
  'X'  : ['h','j','k','m'],
  'Y'  : ['h','j','l'],
  'Z'  : ['a1','a2','d1','d2','j','k'],
  '_'  : ['d1','d2'],
  '-'  : ['g1','g2'],
  '='  : ['d1','d2','g1','g2'],
  '°'  : ['a1','f','g1','i'],
  '"'  : ['f','i'],
  '\'' : ['f'],
  '('  : ['j','m',],
  '<'  : ['j','m',],
  '['  : ['a2','d2','i','l'],
  ')'  : ['h','k'],
  '>'  : ['h','k'],
  ']'  : ['a1','d1','i','l'],
  '?'  : ['a1','a2','b','g2','l'],
  '\$' : ['a1','a2','c','d1','d2','f','g1','g2','i','l'],
  '/'  : ['j','k'],
  '\\' : ['h','m'],
  '+'  : ['g1','g2','i','l'],
  '*'  : ['g1','g2','h','i','j','k','l','m'],
  '%'  : ['a1','c','d2','f','g1','g2','i','j','k','l'],
  ' '  : []
};

final Map<String, List<String>> _AZTo14Segment = {
  '1'  : ['b','c','j'],
  '2'  : ['a','b','d','e','g1','g2'],
  '3'  : ['a','b','c','d','g1','g2'],
  '4'  : ['b','c','f','g1','g2'],
  '5'  : ['a','c','d','f','g1','g2'],
  '6'  : ['a','c','d','e','f','g1','g2'],
  '7'  : ['a','j','k'],
  '8'  : ['a','b','c','d','e','f','g1','g2'],
  '9'  : ['a','b','c','d','f','g1','g2'],
  '0'  : ['a','b','c','d','e','f','j','k'],
  'A'  : ['a','b','c','e','f','g1','g2'],
  'B'  : ['a','b','c','d','g2','i','l'],
  'C'  : ['a','d','e','f'],
  'D'  : ['a','b','c','d','i','l'],
  'E'  : ['a','d','e','f','g1'],
  'F'  : ['a','e','f','g1'],
  'G'  : ['a','c','d','e','f','g2'],
  'H'  : ['b','c','e','f','g1','g2'],
  'I'  : ['a','d','i','l'],
  'J'  : ['a','b','c','d','e'],
  'K'  : ['e','f','g1','j','m'],
  'L'  : ['d','e','f'],
  'M'  : ['b','c','e','f','h','j'],
  'N'  : ['b','c','e','f','h','m'],
  'O'  : ['a','b','c','d','e','f'],
  'P'  : ['a','b','e','f','g1','g2'],
  'Q'  : ['a','b','c','d','e','f','m'],
  'R'  : ['a','b','e','f','g1','g2','m'],
  'S'  : ['a','c','d','g2','h'],
  'T'  : ['a','i','l'],
  'U'  : ['b','c','d','e','f'],
  'V'  : ['e','f','j','k'],
  'W'  : ['b','c','e','f','k','m'],
  'X'  : ['h','j','k','m'],
  'Y'  : ['h','j','l'],
  'Z'  : ['a','d','j','k'],
  '_'  : ['d'],
  '-'  : ['g1','g2'],
  '='  : ['d','g1','g2'],
  '°'  : ['a','f','g1','g2','i'],
  '"'  : ['f','i'],
  '\'' : ['f'],
  '('  : ['j','m',],
  '<'  : ['j','m',],
  ')'  : ['h','k'],
  '>'  : ['h','k'],
  '['  : ['a','d','e','f'],
  ']'  : ['a','b','c','d'],
  '?'  : ['a','b','g2','l'],
  '/'  : ['j','k'],
  '\\' : ['h','m'],
  '+'  : ['g1','g2','i','l'],
  '*'  : ['g1','g2','h','i','j','k','l','m'],
  '\$' : ['a','c','d','f','g1','g2','i','l'],
  ' '  : []
};

final Map<String, List<String>> _AZTo7Segment = {
  // https://www.wikizero.com/en/Seven-segment_display
  '1'  : ['b','c'],                     //'1' : ['a','e'],
  '2'  : ['a','b','d','e','g'],
  '3'  : ['a','b','c','d','g'],
  '4'  : ['b','c','f','g'],
  '5'  : ['a','c','d','f','g'],
  '6'  : ['a','c','d','e','f','g'],     //'6' : ['c','d','e','f','g'],
  '7'  : ['a','b','c'],                 //'7' : ['a','b','c','f'],
  '8'  : ['a','b','c','d','e','f','g'],
  '9'  : ['a','b','c','d','f','g'],     //'9' : ['a','b','c','f','g'],
  '0'  : ['a','b','c','d','e','f'],
  'A'  : ['a','b','c','e','f','g'],
  'B'  : ['c','d','e','f','g'],
  'C'  : ['a','d','e','f'],             //'C' : ['d','e','g'],
  'D'  : ['b','c','d','e','g'],
  'E'  : ['a','d','e','f','g'],
  'F'  : ['a','e','f','g'],
  'G'  : ['a','c','d','e','f'],
  'H'  : ['b','c','e','f','g'],         //'H' : ['c','e','f','g']
  'I'  : ['e','f'],
  'J'  : ['a','b','c','d','e'],
  'L'  : ['d','e','f'],
  'N'  : ['a','b','c','e','f'],
  'O'  : ['c','d','e','g'],
  'P'  : ['a','b','e','f','g'],
  'Q'  : ['a','b','c','f','g'],
  'R'  : ['e','g'],
  'S'  : ['a','c','d','f','g'],
  'T'  : ['d','e','f','g'],
  'U'  : ['b','c','d','e','f'],         //'U'  : ['c','d','e'],
  'Y'  : ['b','c','d','f','g'],
  '_'  : ['d'],
  '-'  : ['g'],
  '='  : ['d','g'],
  '°'  : ['a','b','f','g'],
  '"'  : ['b','f'],
  '\'' : ['f'],                         //'\'' : ['b'],
  '('  : ['a','d','e','f'],
  '['  : ['a','d','e','f'],
  ')'  : ['a','b','c','d'],
  ']'  : ['a','b','c','d'],
  '?'  : ['a','b','e','g'],
  ' '  : []
};

final Map<List<String>, String> _Segment7ToAZ = {
  ['b', 'c'] : '1',
  ['a', 'b', 'd', 'e', 'g'] : '2',
  ['a', 'b', 'c', 'd', 'g'] : '3',
  ['b', 'c', 'f', 'g'] : '4',
  ['a', 'c', 'd', 'f', 'g'] : '5',
  ['a', 'c', 'd', 'e', 'f', 'g'] : '6',
  ['a', 'b', 'c'] : '7',
  ['a','b','c','f'] : '7',
  ['a', 'b', 'c', 'd', 'e', 'f', 'g'] : '8',
  ['a', 'b', 'c', 'd', 'f', 'g'] : '9',
  ['a', 'b', 'c', 'd', 'e', 'f'] : '0',
  ['a', 'b', 'c', 'e', 'f', 'g'] : 'A',
  ['c', 'd', 'e', 'f', 'g'] : 'B',
  ['a', 'd', 'e', 'f'] : 'C',
  ['d','e','g'] : 'C',
  ['b', 'c', 'd', 'e', 'g'] : 'D',
  ['a', 'd', 'e', 'f', 'g'] : 'E',
  ['a', 'e', 'f', 'g'] : 'F',
  ['a', 'c', 'd', 'e', 'f'] : 'G',
  ['b', 'c', 'e', 'f', 'g'] : 'H',
  ['c','e','f','g'] : 'H',
  ['e', 'f'] : 'I',
  ['c'] : 'I',
  ['e'] : 'I',
  ['a', 'b', 'c', 'd', 'e'] : 'J',
  ['b', 'c', 'd', 'e'] : 'J',
  ['d', 'e', 'f'] : 'L',
  ['c', 'e', 'g'] : 'N',
  ['a','b','c', 'e', 'f'] : 'N',
  ['c', 'd', 'e', 'g'] : 'O',
  ['a', 'b', 'e', 'f', 'g'] : 'P',
  ['a', 'b', 'c', 'f', 'g'] : 'Q',
  ['e', 'g'] : 'R',
  //['a', 'c', 'd', 'f', 'g'] : 'S',
  ['d', 'e', 'f', 'g'] : 'T',
  ['b', 'c', 'd', 'e', 'f'] : 'U',
  [ 'c', 'd', 'e'] : 'U',
  ['b', 'c', 'd', 'f', 'g'] : 'Y',
  ['d'] : '_',
  ['g'] : '-',
  ['d', 'g'] : '=',
  ['a', 'g'] : '=',
  ['a', 'b', 'f', 'g'] : '°',
  ['b', 'f'] : '"',
  ['f'] : '\'',
  ['b'] : '\'',
  //['a', 'd', 'e', 'f'] : '(',
  ['a', 'b', 'c', 'd'] : ')',
  // ['a', 'b', 'c', 'd'] : ']',
  //['a', 'd', 'e', 'f'] : 'C',
  ['a', 'b', 'e', 'g'] : '?',
  [] : ' '
};

final Map<List<String>, String> _Segment14ToAZ = {
  ['b','c','j'] : '1',
  ['b','c'] : '1',
  ['a','b','d','e','g1','g2'] : '2',
  ['a','d','e','g1','j'] : '2',
  ['a','b','c','d','g1','g2'] : '3',
  ['a','b','c','d','g2'] : '3',
  ['a','c','d','g2','j'] : '3',
  ['b','c','f','g1','g2'] : '4',
  ['f','g1','g2','i','l'] : '4',
  ['a','c','d','f','g1','g2'] : '5',
  ['a','c','d','e','f','g1','g2'] : '6',
  ['a','j','k'] : '7',
  ['a','j','l'] : '7',
  ['a','b','c'] : '7',
  ['a','b','c','f'] : '7',
  ['a','g1','g2','j','k'] : '7',
  ['a','b','c','d','e','f','g1','g2'] : '8',
  ['a','b','c','d','f','g1','g2'] : '9',
  ['a','b','c','d','e','f','j','k'] : '0',
  ['a','b','c','e','f','g1','g2'] : 'A',
  ['a','b','c','d','g2','i','l'] : 'B',
  ['c','d','e','f','g1','g2'] : 'B',
  ['a','d','e','f'] : 'C',
  ['d','e','g1','g2'] : 'C',
  ['a','b','c','d','i','l'] : 'D',
  ['b','c','d','e','g1','g2'] : 'D',
  ['b','c','d2','g2','l'] : 'D',
  ['a','d','e','f','g1','g2'] : 'E',
  ['a','d','e','f','g1'] : 'E',
  ['a','b','d','e','f','g1','g2'] : 'E',
  ['a','e','f','g1'] : 'F',
  ['a','e','f','g1','g2'] : 'F',
  ['a','c','d','e','f','g2'] : 'G',
  ['a','c','d','e','f'] : 'G',
  ['b','c','e','f','g1','g2'] : 'H',
  ['c','e','f','g1','g2'] : 'H',
  ['e','f','g1','i','l'] : 'H',
  ['e','f','g1','i'] : 'H',
  ['a','d','i','l'] : 'I',
  ['a','b','c','d','e'] : 'J',
  ['b','c','d','e'] : 'J',
  ['e','f','g1','j','m'] : 'K',
  ['d','e','f'] : 'L',
  ['b','c','e','f','h','j'] : 'M',
  ['c','e','g1','g2','l'] : 'M',
  ['b','c','e','f','h','m'] : 'N',
  ['c','e','g1','g2'] : 'N',
  ['e','g1','l'] : 'N',
  ['c','d','e','g1','g2'] : 'O',
  ['a','b','c','d','e','f'] : 'O',
  ['a','b','e','f','g1','g2'] : 'P',
  ['a','b','c','d','e','f','m'] : 'Q',
  ['a','b','e','f','g1','g2','m'] : 'R',
  ['e','g1','g2'] : 'R',
  ['e','g1'] : 'R',
  ['a','c','d','g2','h'] : 'S',
  ['a','i','l'] : 'T',
  ['d','e','f','g1','g2'] : 'T',
  ['b','c','d','e','f'] : 'U',
  ['c','d','e'] : 'U',
  ['e','f','j','k'] : 'V',
  ['b','c','e','f','k','m'] : 'W',
  ['b','c','d','e','f','i','l'] : 'W',
  ['c','d','e','l'] : 'W',
  ['h','j','k','m'] : 'X',
  ['h','j','l'] : 'Y',
  ['b','c','d','f','g1','g2'] : 'Y',
  ['a','d','j','k'] : 'Z',
  ['a','d','g1','g2','j','k'] : 'Z',
  ['d'] : '_',
  ['g1','g2'] : '-',
  ['g1'] : '-',
  ['g2'] : '-',
  ['d','g1','g2'] : '=',
  ['a','g1','g2'] : '=',
  ['a','f','g1','g2','i'] : '°',
  ['f','i'] : '"',
  ['b','i'] : '"',
  ['f'] : '\'',
  ['i'] : '\'',
  ['b'] : '\'',
  ['j','m',] : '(',
  ['h','k'] : ')',
  ['j','k'] : '/'  ,
  ['h','m'] : '\\' ,
  ['g1','g2','i','l'] : '+'  ,
  ['g1','g2','h','i','j','k','l','m'] : '*' ,
  ['a','c','d','f','g1','g2','i','l'] : '\$' ,
  ['a','b','g2','l'] : '?' ,
  ['a','b','e','g1','g2'] : '?' ,
  ['a','b','c','d'] : ']',
  [] : ' '
};

final Map<List<String>, String> _Segment16ToAZ = {
  ['a1','i','l'] : '1',
  ['a1','d1','d2','i','l'] : '1',
  ['b','c','j'] : '1',
  ['b','c'] : '1',
  ['a1','a2','b','d1','d2','e','g1','g2'] : '2',
  ['a1','a2','d1','d2','e','g1','j'] : '2',
  ['a1','a2','b','c','d1','d2','g1','g2'] : '3',
  ['a1','a2','b','c','d1','d2','g2'] : '3',
  ['a1','a2','c','d1','d2','g2','j'] : '3',
  ['b','c','f','g1','g2'] : '4',
  ['f','g1','g2','i','l'] : '4',
  ['a1','a2','c','d1','d2','f','g1','g2'] : '5',
  ['a1','a2','c','d1','d2','e','f','g1','g2'] : '6',
  ['a1','a2','j','k'] : '7',
  ['a1','a2','j','l'] : '7',
  ['a1','a2','b','c'] : '7',
  ['a1','a2','b','c','f'] : '7',
  ['a1','a2','g1','g2','j','k'] : '7',
  ['a1','a2','b','c','d1','d2','e','f','g1','g2'] : '8',
  ['a1','a2','b','c','d1','d2','f','g1','g2'] : '9',
  ['a1','a2','b','c','f','g1','g2'] : '9',
  ['a1','a2','b','c','d1','d2','e','f','j','k'] : '0',
  ['a1','a2','b','c','e','f','g1','g2'] : 'A',
  ['a1','a2','b','c','d1','d2','g2','i','l'] : 'B',
  ['c','d1','d2','e','f','g1','g2'] : 'B',
  ['d1','e','f','g1','l'] : 'B',
  ['a1','a2','d1','d2','e','f'] : 'C',
  ['d1','d2','e','g1','g2'] : 'C',
  ['a1','a2','b','c','d1','d2','i','l'] : 'D',
  ['b','c','d1','d2','e','g1','g2'] : 'D',
  ['b','c','d2','g2','l'] : 'D',
  ['a1','a2','d1','d2','e','f','g1','g2'] : 'E',
  ['a1','a2','d1','d2','e','f','g1'] : 'E',
  ['a1','d1','e','f','g1'] : 'E',
  ['a1','a2','b','d1','d2','e','f','g1','g2'] : 'E',
  ['a1','a2','e','f','g1'] : 'F',
  ['a1','a2','e','f','g1','g2'] : 'F',
  ['a1','e','f','g1'] : 'F',
  ['a1','a2','c','d1','d2','e','f','g2'] : 'G',
  ['a1','a2','c','d1','d2','e','f'] : 'G',
  ['b','c','e','f','g1','g2'] : 'H',
  ['c','e','f','g1','g2'] : 'H',
  ['e','f','g1','i','l'] : 'H',
  ['e','f','g1','i'] : 'H',
  ['a1','a2','d1','d2','i','l'] : 'I',
  ['a1','a2','b','c','d1','d2','e'] : 'J',
  ['a2','b','c','d1','d2','e'] : 'J',
  ['b','c','d1','d2','e'] : 'J',
  ['e','f','g1','j','m'] : 'K',
  ['d1','d2','e','f'] : 'L',
  ['d1','e','f'] : 'L',
  ['b','c','e','f','h','j'] : 'M',
  ['c','e','g1','g2','l'] : 'M',
  ['b','c','e','f','h','m'] : 'N',
  ['c','e','g1','g2'] : 'N',
  ['e','g1','l'] : 'N',
  ['c','g2','l'] : 'N',
  ['c','d1','d2','e','g1','g2'] : 'O',
  ['d1','e','g1','l'] : 'O',
  ['c','d2','g2','l'] : 'O',
  ['a1','a2','b','c','d1','d2','e','f'] : 'O',
  ['a1','a2','b','e','f','g1','g2'] : 'P',
  ['a1','a2','b','c','d1','d2','e','f','m'] : 'Q',
  ['a1','a2','b','e','f','g1','g2','m'] : 'R',
  ['e','g1','g2'] : 'R',
  ['e','g1'] : 'R',
  ['a1','a2','c','d1','d2','g2','h'] : 'S',
  ['a1','a2','i','l'] : 'T',
  ['d1','d2','e','f','g1','g2'] : 'T',
  ['d1','e','f','g1'] : 'T',
  ['b','c','d1','d2','e','f'] : 'U',
  ['c','d1','d2','e'] : 'U',
  ['d1','e','l'] : 'U',
  ['c','d2','l'] : 'U',
  ['e','f','j','k'] : 'V',
  ['b','c','e','f','k','m'] : 'W',
  ['b','c','d1','d2','e','f','i','l'] : 'W',
  ['c','d1','d2','e','l'] : 'W',
  ['h','j','k','m'] : 'X',
  ['h','j','l'] : 'Y',
  ['b','c','d1','d2','f','g1','g2'] : 'Y',
  ['a1','a2','d1','d2','j','k'] : 'Z',
  ['a1','a2','d1','d2','g1','g2','j','k'] : 'Z',
  ['d1','d2'] : '_',
  ['g1','g2'] : '-',
  ['g1'] : '-',
  ['g2'] : '-',
  ['d1','d2','g1','g2'] : '=',
  ['a1','a2','g1','g2'] : '=',
  ['a1','a2','b','f','g1','g2'] : '°',
  ['a1','f','g1','i'] : '°',
  ['a2','b','g2','i'] : '°',
  ['f','i'] : '"',
  ['b','i'] : '"',
  ['b','f'] : '"',
  ['f'] : '\'',
  ['i'] : '\'',
  ['b'] : '\'',
  ['a2','d2','i','l'] : '[',
  ['a1','d1','i','l'] : ']',
  ['j','m',] : '(',
  ['h','k'] : ')',
  ['j','k'] : '/'  ,
  ['h','m'] : '\\' ,
  ['g1','g2','i','l'] : '+'  ,
  ['g1','g2','h','i','j','k','l','m'] : '*' ,
  ['a1','a2','c','d1','d2','f','g1','g2','i','l'] : '\$' ,
  ['a1','a2','b','g2','l'] : '?' ,
  ['a1','a2','b','e','g1','g2'] : '?' ,
  ['a1','c','d2','f','g1','g2','i','j','k','l'] : '%',
  [] : ' '
};

final Map<int, List<String>> _AZToCistercianSegment = {
  1 : ['z2','z11'],
  2 : ['z10','z11'],
  3 : ['z8','z11'],
  4 : ['z7','z11'],
  5 : ['z2','z7','z11'],
  6 : ['z4','z11'],
  7 : ['z2','z4','z11'],
  8 : ['z4','z10','z11'],
  9 : ['z2','z4','z10','z11'],
  10 : ['z1','z11'],
  20 : ['z9','z11'],
  30 : ['z5','z11'],
  40 : ['z6','z11'],
  50 : ['z1','z6','z11'],
  60 : ['z3','z11'],
  70 : ['z1','z3','z11'],
  80 : ['z3','z9','z11'],
  90 : ['z1','z3','z9','z11'],
  100 : ['z11','z21'],
  200 : ['z11','z13'],
  300 : ['z11','z18'],
  400 : ['z11','z19'],
  500 : ['z11','z19','z21'],
  600 : ['z11','z15'],
  700 : ['z11','z15','z21'],
  800 : ['z11','z13','z15'],
  900 : ['z11','z13','z15','z21'],
  1000 : ['z11','z20'],
  2000 : ['z11','z12'],
  3000 : ['z11','z17'],
  4000 : ['z11','z16'],
  5000 : ['z11','z16','z20'],
  6000 : ['z11','z14'],
  7000 : ['z11','z14','z20'],
  8000 : ['z11','z12','z14'],
  9000 : ['z11','z12','z14','z20'],
};

final Map<List<String>, int> _SegmentCistercianToAZ = switchMapKeyValue(_AZToCistercianSegment);


List<List<String>> encodeCistercian(String input) {
  if (input == null || input == '')
    return [];
  var inputCharacters = input.split(RegExp(r'[^1234567890]')).toList();
  print(inputCharacters);
  var output = <List<String>>[];
  var digit = 0;
  var number; // = new List<String>();

  for (String character in inputCharacters) {
    int encodeNumber = int.tryParse(character);
    if (encodeNumber != null && encodeNumber < 10000) {
      var display; // = new List<String>();
      for (int i = 0; i < character.length; i++){
        digit = int.parse(character[i]) * pow(10, character.length - i - 1);
        if (digit != 0) {
          number = _AZToCistercianSegment[digit];
          if (display == null){
            display = number;
          } else {
            for (String charElem in number) {
              if (!display.contains(charElem)) {
                display.add(charElem);
              }
            }
          }
        }
      }
      if (display != null) {
        display.sort();
        output.add(display);
      }
    }
  }
  return output;
}


List<List<String>> encodeSegment(String input, SegmentDisplayType segmentType) {
  if (input == null || input == '')
    return [];

  var AZToSegment;

  switch (segmentType) {
    case SegmentDisplayType.SEVEN:
      AZToSegment = _AZTo7Segment;
      break;
    case SegmentDisplayType.FOURTEEN:
      AZToSegment = _AZTo14Segment;
      break;
    case SegmentDisplayType.SIXTEEN:
      AZToSegment = _AZTo16Segment;
      break;
  }

  var inputCharacters;
    inputCharacters = input.toUpperCase().split('').toList();
  var output = <List<String>>[];

  for (String character in inputCharacters) {
    if (['.', ','].contains(character)) {
      if (output.length == 0 || output.last.contains('dp')) {
        output.add(['dp']);
      } else {
        var prevCharacter = List<String>.from(output.removeLast());
        prevCharacter.add('dp');
        output.add(prevCharacter);
      }
    } else {
      var display;
        display = AZToSegment[character];
        if (display != null)
          output.add(AZToSegment[character]);
    }
  }

  return output;
}


Map<String, dynamic> decodeSegment(String input, SegmentDisplayType segmentType) {
  if (input == null || input == '')
    return {'displays': [], 'text': ''};

  var baseSegments;

  switch (segmentType) {
    case SegmentDisplayType.SEVEN:
      baseSegments = _baseSegments7Segment;
      break;
    case SegmentDisplayType.FOURTEEN:
      baseSegments = _baseSegments14Segment;
      break;
    case SegmentDisplayType.SIXTEEN:
      baseSegments = _baseSegments16Segment;
      break;
    case SegmentDisplayType.CISTERCIAN:
      baseSegments = _baseSegmentsCistercianSegment;
      break;
  }

  input = input.toLowerCase();
  var displays = <List<String>>[];
  List<String> currentDisplay;

  for (int i = 0; i < input.length; i++) {
    var segment = input[i];
    if (i + 1 < input.length && ['1', '2', 'p'].contains(input[i + 1])) {
      i++;
      segment += input[i];
    }

    if (!baseSegments.contains(segment)) {
      if (currentDisplay != null) {
        currentDisplay.sort();
        displays.add(currentDisplay.toSet().toList());
      }

      currentDisplay = null;
      continue;
    }

    if (currentDisplay == null)
      currentDisplay = [];

    currentDisplay.add(segment);
  }

  if (currentDisplay != null) {
    currentDisplay.sort();
    displays.add(currentDisplay.toSet().toList());
  }

  var out = displays.map((display) {
    if (display.length == 1 && display[0] == 'dp') {
      return '.';
    }

    var containsDot = display.contains('dp');
    var segments = List<String>.from(display);
    if (containsDot)
      segments.remove('dp');

    var character = _characterFromSegmentList(segmentType, segments);
    if (character == null) {
      return UNKNOWN_ELEMENT;
    }

    return character + (containsDot ? '.' : '');
  }).join();

  return {'displays': displays, 'text': out};
}


Map<String, dynamic> decodeCistercian(String input) {
  if (input == null || input == '')
    return {'displays': [], 'text': ''};

  var baseSegments = _baseSegmentsCistercianSegment;

  input = input.toLowerCase();
  var displays = <List<String>>[];
  List<String> currentDisplay;

  for (int i = 0; i < input.length; i++) {
    var segment = input[i];
    //if (i + 1 < input.length && ['1', '2', 'p'].contains(input[i + 1])) {
    //  i++;
    //  segment += input[i];
    //}

    if (!baseSegments.contains(segment)) {
      if (currentDisplay != null) {
        currentDisplay.sort();
        displays.add(currentDisplay.toSet().toList());
      }

      currentDisplay = null;
      continue;
    }

    if (currentDisplay == null)
      currentDisplay = [];

    currentDisplay.add(segment);
  }

  if (currentDisplay != null) {
    currentDisplay.sort();
    displays.add(currentDisplay.toSet().toList());
  }

  String out = '';
  bool unknownToken = true;
  int digit = 0;
  List<String> tokens =  input.split(' ');
  //var out = displays.map((display) {
  for (int i = 0; i < tokens.length; i++) {
print(i.toString()+'.'+tokens[i]);
    unknownToken = true;
    digit = 0;
    // segments contains all segments - these have to split into numbers
    //   1000 - 9000    z11   z12 z14 z16 z17 z20
    //    100 -  900    z11   z21 z13 z18 z19 z15
    //     10 -   90    z11   z1  z9  z5  z6  z3
    //      1 -    9    z11   z2  z10 z8  z7  z4
    // to return number.toString()
    // or return UNKNOWN_ELEMENT

    if (tokens[i].contains('z11')) {
      tokens[i] = tokens[i].replaceAll('z11', '');
      // check numbers 100 - 900
      print('check 100 - 900');
      if (tokens[i].contains('z21') && tokens[i].contains('z13') && tokens[i].contains('z15')) { // 900
        digit = digit + 900;
        tokens[i] = tokens[i].replaceAll('z21', ''); tokens[i] = tokens[i].replaceAll('z13', ''); tokens[i] = tokens[i].replaceAll('z15', '');
      } else if (tokens[i].contains('z13') && tokens[i].contains('z15')) { // 800
        digit = digit + 800;
        tokens[i] = tokens[i].replaceAll('z13', ''); tokens[i] = tokens[i].replaceAll('z15', '');
      } else if (tokens[i].contains('z21') && tokens[i].contains('z17')) { // 700
        digit = digit + 700;
        tokens[i] = tokens[i].replaceAll('z21', ''); tokens[i] = tokens[i].replaceAll('z17', '');
      } else if (tokens[i].contains('z15')) { // 600
        digit = digit + 600;
        tokens[i].replaceAll('z15', '');
      } else if (tokens[i].contains('z21') && tokens[i].contains('z19')) { // 500
        digit = digit + 500;
        tokens[i] = tokens[i].replaceAll('z21', ''); tokens[i] = tokens[i].replaceAll('z19', '');
      } else if (tokens[i].contains('z19')) { // 400
        digit = digit + 400;
        tokens[i] = tokens[i].replaceAll('z19', '');
      } else if ( tokens[i].contains('z18')) { // 300
        digit = digit + 300;
        tokens[i] = tokens[i].replaceAll('z18', '');
      } else if (tokens[i].contains('z13')) { // 200
        digit = digit + 200;
        tokens[i] = tokens[i].replaceAll('z13', '');
      } else if (tokens[i].contains('z21')) { // 100
        digit = digit + 100;
        tokens[i] = tokens[i].replaceAll('z21', '');
      }

      // check numbers 1000 - 9000
      print('check 100 - 900');
      if (tokens[i].contains('z20') && tokens[i].contains('z14') && tokens[i].contains('z12')) { // 9000
        digit = digit + 9000;
        tokens[i] = tokens[i].replaceAll('z20', ''); tokens[i] = tokens[i].replaceAll('z14', ''); tokens[i] = tokens[i].replaceAll('z12', '');
      } else if (tokens[i].contains('z14') && tokens[i].contains('z12')) { // 8000
        digit = digit + 8000;
        tokens[i] = tokens[i].replaceAll('z14', ''); tokens[i] = tokens[i].replaceAll('z12', '');
      } else if (tokens[i].contains('z20') && tokens[i].contains('z14')) { // 7000
        digit = digit + 7000;
        tokens[i] = tokens[i].replaceAll('z20', ''); tokens[i] = tokens[i].replaceAll('z14', '');
      } else if (tokens[i].contains('z14')) { // 6000
        digit = digit + 6000;
        tokens[i].replaceAll('z14', '');
      } else if (tokens[i].contains('z20') && tokens[i].contains('z16')) { // 5000
        digit = digit + 5000;
        tokens[i] = tokens[i].replaceAll('z20', ''); tokens[i] = tokens[i].replaceAll('z16', '');
      } else if (tokens[i].contains('z16')) { // 4000
        digit = digit + 4000;
        tokens[i] = tokens[i].replaceAll('z16', '');
      } else if ( tokens[i].contains('z17')) { // 3000
        digit = digit + 3000;
        tokens[i] = tokens[i].replaceAll('z17', '');
      } else if (tokens[i].contains('z12')) { // 2000
        digit = digit + 2000;
        tokens[i] = tokens[i].replaceAll('z12', '');
      } else if (tokens[i].contains('z20')) { // 1000
        digit = digit + 1000;
        tokens[i] = tokens[i].replaceAll('z20', '');
      }

      // check numbers 1 - 10
      if (tokens[i].contains('z10') && tokens[i].contains('z2') && tokens[i].contains('z4')) { // 9
        digit = digit + 9;
        tokens[i] = tokens[i].replaceAll('z10', ''); tokens[i] = tokens[i].replaceAll('z2', ''); tokens[i] = tokens[i].replaceAll('z4', '');
      } else if (tokens[i].contains('z10') && tokens[i].contains('z4')) { // 8
        digit = digit + 8;
        tokens[i] = tokens[i].replaceAll('z10', ''); tokens[i] = tokens[i].replaceAll('z4', '');
      } else if (tokens[i].contains('z2') && tokens[i].contains('z4')) { // 7
        digit = digit + 7;
        tokens[i] = tokens[i].replaceAll('z2', ''); tokens[i] = tokens[i].replaceAll('z4', '');
      } else if (tokens[i].contains('z4')) { // 6
        digit = digit + 6;
        tokens[i].replaceAll('z4', '');
      } else if (tokens[i].contains('z2') && tokens[i].contains('z7')) { // 5
        digit = digit + 5;
        tokens[i] = tokens[i].replaceAll('z2', ''); tokens[i] = tokens[i].replaceAll('z7', '');
      } else if (tokens[i].contains('z7')) { // 4
        digit = digit + 4;
        tokens[i] = tokens[i].replaceAll('z7', '');
      } else if ( tokens[i].contains('z8')) { // 3
        digit = digit + 3;
        tokens[i] = tokens[i].replaceAll('z8', '');
      } else if (tokens[i].contains('z10')) { // 2
        digit = digit + 2;
        tokens[i] = tokens[i].replaceAll('z10', '');
      } else if (tokens[i].contains('z2')) { // 1
        digit = digit + 1;
        tokens[i] = tokens[i].replaceAll('z2', '');
      }

      // check numbers 10 - 90
      print('check 10 - 90');
      if (tokens[i].contains('z1') && tokens[i].contains('z3') && tokens[i].contains('z9')) { // 90
        digit = digit + 90;
        tokens[i] = tokens[i].replaceAll('z1', ''); tokens[i] = tokens[i].replaceAll('z3', ''); tokens[i] = tokens[i].replaceAll('z9', '');
      } else if (tokens[i].contains('z3') && tokens[i].contains('z9')) { // 80
        digit = digit + 80;
        tokens[i] = tokens[i].replaceAll('z3', ''); tokens[i] = tokens[i].replaceAll('z9', '');
      } else if (tokens[i].contains('z1') && tokens[i].contains('z3')) { // 70
        digit = digit + 70;
        tokens[i] = tokens[i].replaceAll('z1', ''); tokens[i] = tokens[i].replaceAll('z3', '');
      } else if (tokens[i].contains('z3')) { // 60
        digit = digit + 60;
        tokens[i].replaceAll('z3', '');
      } else if (tokens[i].contains('z1') && tokens[i].contains('z6')) { // 50
        digit = digit + 50;
        tokens[i] = tokens[i].replaceAll('z1', ''); tokens[i] = tokens[i].replaceAll('z6', '');
      } else if (tokens[i].contains('z6')) { // 40
        digit = digit + 40;
        tokens[i] = tokens[i].replaceAll('z6', '');
      } else if ( tokens[i].contains('z5')) { // 30
        digit = digit + 30;
        tokens[i] = tokens[i].replaceAll('z5', '');
      } else if (tokens[i].contains('z9')) { // 20
        digit = digit + 20;
        tokens[i] = tokens[i].replaceAll('z9', '');
      } else if (tokens[i].contains('z1')) { // 10
        digit = digit + 10;
        tokens[i] = tokens[i].replaceAll('z1', '');
      }

print('finally =>'+tokens[i]+'<');
      if (tokens[i] == '')
        unknownToken = false;
    }
    if (unknownToken)
      out = out + ' ' + UNKNOWN_ELEMENT;
    else
      out = out +  ' ' + digit.toString();
  };

  return {'displays': displays, 'text': out};
}


_characterFromSegmentList(SegmentDisplayType type, List<String> segments) {
  Map<List<String>,String> segmentToAZ;

  switch (type) {
    case SegmentDisplayType.SEVEN:
      segmentToAZ = _Segment7ToAZ;
      break;
    case SegmentDisplayType.FOURTEEN:
      segmentToAZ = _Segment14ToAZ;
      break;
    case SegmentDisplayType.SIXTEEN:
      segmentToAZ = _Segment16ToAZ;
      break;
  }

  return segmentToAZ.map((key, value) => MapEntry(key.join(), value.toString()))[segments.join()];
}