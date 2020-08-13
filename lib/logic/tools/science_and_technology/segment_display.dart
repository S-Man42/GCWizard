import 'dart:core';

import 'package:gc_wizard/utils/constants.dart';

enum SegmentDisplayType{SEVEN, FOURTEEN, SIXTEEN}

final _baseSegments7Segment = ['a','b','c','d','e','f','g','dp'];
final _baseSegments14Segment = ['a','b','c','d','e','f','g1','g2','h','i','j','k','l','m','dp'];
final _baseSegments16Segment = ['a1','a2','b','c','d1','d2','e','f','g1','g2','h','i','j','k','l','m','dp'];

final Map<String, List<String>> _AZTo16Segment = {
  '1'  : ['b','c','j'],
  '2'  : ['a1','a2','b','d1','d2','e','g1','g2'],
  '3'  : ['a1','a2','b','c','d1','d2','g1','g2'],
  '4'  : ['b','c','f','g1','g2'],
  '5'  : ['a1','a2','c','d1','d2','f','g1','g2'],
  '6'  : ['a1','a2','c','d1','d2','e','f','g1','g2'],
  '7'  : ['a1','a2','j','k'],
  '8'  : ['a1','a2','b','c','d1','d2','e','f','g1','g2'],
  '9'  : ['a1','a2','b','c','f','g1','g2'],
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
  'J'  : ['a2','b','c','d1','d2','e'],
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
  'U'  : ['a1','a2','c','d1','d2','e','f'],
  'V'  : ['e','f','j','k'],
  'W'  : ['b','c','e','f','k','m'],
  'X'  : ['h','j','k','m'],
  'Y'  : ['h','j','l'],
  'Z'  : ['a1','a2','d1','d2','j','k'],
  '_'  : ['d1','d2'],
  '-'  : ['g1','g2'],
  '='  : ['d1','d2','g1','g2'],
  '°'  : ['a1','i','g1','f'],
  '"'  : ['b','f'],
  '\'' : ['f'],
  '('  : ['j','m',],
  '['  : ['a2','d2','i','l'],
  ')'  : ['h','k'],
  ']'  : ['a1','i','l','d1'],
  '?'  : ['a1','a2','j','l'],
  '\$' : ['a1','a2','f','g1','g2','c','d1','d2','i','l'],
  '.'  : ['dp'],
  '/'  : ['j','k'],
  '\\' : ['h','m'],
  '+'  : ['g1','g2','i','l'],
  '*'  : ['g1','g2','i','l','h','j','k','m'],
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
  '9'  : ['a','b','c','f','g1','g2'],
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
  '°'  : ['a','i','g1','g2','f'],
  '"'  : ['f','i'],
  '\'' : ['f'],
  '('  : ['j','m',],
  ')'  : ['h','k'],
  '?'  : ['a','j','l'],
  '/'  : ['j','k'],
  '\\' : ['h','m'],
  '+'  : ['g1','g2','i','l'],
  '*'  : ['g1','g2','i','l','h','j','k','m'],
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
  'I'  : ['a','e'], 'I' : ['b','c'],
  'J'  : ['a','b','c','d','e'],
  'L'  : ['d','e','f'],
  'N'  : ['c','e','g'],
  'O'  : ['a','b','c','d','e','f'],     //'O'  : ['c','d','e','g'],
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
  '°'  : ['a','b','g','f'],
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
  ['f', 'e'] : 'I',
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
  ['a', 'b', 'g', 'f'] : '°',
  ['b', 'f'] : '"',
  ['f'] : '\'',
  ['b'] : '\'',
  //['a', 'd', 'e', 'f'] : '(',
  //['a', 'b', 'c', 'd'] : ')',
  ['a', 'b', 'c', 'd'] : ']',
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
  ['a','b','c','d','e','f','g1','g2'] : '8',
  ['a','b','c','d','f','g1','g2'] : '9',
  ['a','b','c','d','e','f','j','k'] : '0',
  ['a','b','c','d','e','f'] : '0',
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
  ['a','i','g1','g2','f'] : '°',
  ['f','i'] : '"',
  ['b','i'] : '"',
  ['f'] : '\'',
  ['i'] : '\'',
  ['b'] : '\'',
  ['b'] : '\'',
  ['j','m',] : '<',
  ['h','k'] : '>',
  ['j','k'] : '/'  ,
  ['h','m'] : '\\' ,
  ['g1','g2','i','l'] : '+'  ,
  ['g1','g2','i','l','h','j','k','m'] : '*' ,
  ['a','c','d','f','g1','g2','i','l'] : '\$' ,
  ['a','b','g2','l'] : '?' ,
  ['a','b','e','g1','g2'] : '?' ,
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
  ['a1','a2','b','c','d1','d2','e','f','g1','g2'] : '8',
  ['a1','a2','b','c','d1','d2','f','g1','g2'] : '9',
  ['a1','a2','b','c','d1','d2','e','f','j','k'] : '0',
  ['a1','a2','b','c','d1','d2','e','f'] : '0',
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
  ['b','c','d1','d2','e'] : 'J',
  ['e','f','g1','j','m'] : 'K',
  ['d1','d2','e','f'] : 'L',
  ['d1','e','f'] : 'L',
  ['b','c','e','f','h','j'] : 'M',
  ['c','e','g1','g2','l'] : 'M',
  ['b','c','e','f','h','m'] : 'N',
  ['c','e','g1','g2'] : 'N',
  ['e','g1','l'] : 'N',
  ['c','d1','d2','e','g1','g2'] : 'O',
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
  ['a1','a2','i','g1','g2','f'] : '°',
  ['a1','f','g1','i'] : '°',
  ['a2','b','g2','i'] : '°',
  ['f','i'] : '"',
  ['b','i'] : '"',
  ['f'] : '\'',
  ['i'] : '\'',
  ['b'] : '\'',
  ['b'] : '\'',
  ['a2','d2','i','l'] : '[',
  ['a1','d1','i','l'] : ']',
  ['j','m',] : '<',
  ['h','k'] : '>',
  ['j','k'] : '/'  ,
  ['h','m'] : '\\' ,
  ['g1','g2','i','l'] : '+'  ,
  ['g1','g2','i','l','h','j','k','m'] : '*' ,
  ['a1','a2','c','d1','d2','f','g1','g2','i','l'] : '\$' ,
  ['a1','a2','b','g2','l'] : '?' ,
  ['a1','a2','b','e','g1','g2'] : '?' ,
  [] : ' '
};

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

  var inputCharacters = input.toUpperCase().split('').toList();

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

    print(segment);

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

  print(displays);

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

  return segmentToAZ.map((key, value) => MapEntry(key.join(), value))[segments.join()];
}