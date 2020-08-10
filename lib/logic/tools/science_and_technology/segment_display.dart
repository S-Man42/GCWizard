import 'dart:core';
import 'package:gc_wizard/utils/common_utils.dart';

enum SegmentDisplayType{SEVEN, FOURTEEN, SIXTEEN}

final Map<String, List<String>> AZTo16Segment = {
  '1'  : ['i','l'],
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

final Map<String, List<String>> AZTo14Segment = {
  '1'  : ['i','l'],
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

final Map<String, List<String>> AZTo7Segment = {
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
  '\'' : ['f'], '\'' : ['b'],
  '('  : ['a','d','e','f'],
  '['  : ['a','d','e','f'],
  ')'  : ['a','b','c','d'],
  ']'  : ['a','b','c','d'],
  '?'  : ['a','b','e','g'],
  ' '  : []
};

//TODO!
//var Segment7ToAZ = switchMapKeyValue(AZTo7Segment);
final Map<List<String>, String> Segment7ToAZ = {
  ['b', 'c'] : '1',
  ['a', 'b', 'd', 'e', 'g'] : '2',
  ['a', 'b', 'c', 'd', 'g'] : '3',
  ['b', 'c', 'f', 'g'] : '4',
  ['a', 'c', 'd', 'f', 'g'] : '5',
  ['a', 'c', 'd', 'e', 'f', 'g'] : '6',
  ['c','d','e','f','g'] : '6',
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
  ['a', 'b', 'c', 'd', 'e'] : 'J',
  ['d', 'e', 'f'] : 'L',
  ['c', 'e', 'g'] : 'N',
  //['a', 'b', 'c', 'd', 'e', 'f'] : 'O',
  ['a', 'b', 'e', 'f', 'g'] : 'P',
  ['a', 'b', 'c', 'f', 'g'] : 'Q',
  ['e', 'g'] : 'R',
  //['a', 'c', 'd', 'f', 'g'] : 'S',
  ['d', 'e', 'f', 'g'] : 'T',
  ['b', 'c', 'd', 'e', 'f'] : 'U',
  ['b', 'c', 'd', 'f', 'g'] : 'Y',
  ['d'] : '_',
  ['g'] : '-',
  ['d', 'g'] : '=',
  ['a', 'b', 'g', 'f'] : '°',
  ['b', 'f'] : '"',
  ['f'] : '\'',
  ['b'] : '\'',
  //['a', 'd', 'e', 'f'] : '(',
  ['a', 'd', 'e', 'f'] : '[',
  //['a', 'b', 'c', 'd'] : ')',
  ['a', 'b', 'c', 'd'] : ']',
  ['a', 'b', 'e', 'g'] : '?',
  [] : ''
};
//var Segment14ToAZ = switchMapKeyValue(AZTo14Segment);
final Map<List<String>, String> Segment14ToAZ = {
  ['i','l'] : '1',
  ['a','b','d','e','g1','g2'] : '2',
  ['a','b','c','d','g1','g2'] : '3',
  ['b','c','f','g1','g2'] : '4',
  ['a','c','d','f','g1','g2'] : '5',
  ['a','c','d','e','f','g1','g2'] : '6',
  ['a','j','k'] : '7',
  ['a','b','c','d','e','f','g1','g2'] : '8',
  ['a','b','c','f','g1','g2'] : '9',
  ['a','b','c','d','e','f','j','k'] : '0',
  ['a','b','c','e','f','g1','g2'] : 'A',
  ['a','b','c','d','g2','i','l'] : 'B',
  ['a','d','e','f'] : 'C',
  ['a','b','c','d','i','l'] : 'D',
  ['a','d','e','f','g1'] : 'E',
  ['a','e','f','g1'] : 'F',
  ['a','c','d','e','f','g2'] : 'G',
  ['b','c','e','f','g1','g2'] : 'H',
  ['a','d','i','l'] : 'I',
  ['a','b','c','d','e'] : 'J',
  ['e','f','g1','j','m'] : 'K',
  ['d','e','f'] : 'L',
  ['b','c','e','f','h','j'] : 'M',
  ['b','c','e','f','h','m'] : 'N',
  ['a','b','c','d','e','f'] : 'O',
  ['a','b','e','f','g1','g2'] : 'P',
  ['a','b','c','d','e','f','m'] : 'Q',
  ['a','b','e','f','g1','g2','m'] : 'R',
  ['a','c','d','g2','h'] : 'S',
  ['a','i','l'] : 'T',
  ['b','c','d','e','f'] : 'U',
  ['e','f','j','k'] : 'V',
  ['b','c','e','f','k','m'] : 'W',
  ['h','j','k','m'] : 'X',
  ['h','j','l'] : 'Y',
  ['a','d','j','k'] : 'Z',
  ['d1','d2'] : '_',
  ['g1','g2'] : '-',
  ['d1','d2','g1','g2'] : '=',
  ['a','i','g1','g2','f'] : '°',
  ['f','i'] : '"',
  ['f'] : '\'',
  ['j','m',] : '(',
  ['h','k'] : ')',
  ['a','j','l'] : '?',
  ['j','k'] : '/'  ,
  ['h','m'] : '\\' ,
  ['g1','g2','i','l'] : '+'  ,
  ['g1','g2','i','l','h','j','k','m'] : '*' ,
  [] : ' '
};

final Map<List<String>, String> Segment16ToAZ = {
  ['a1','i','l'] : '1',
  ['a1','a2','b','d1','d2','e','g1','g2'] : '2',
  ['a1','a2','b','c','d1','d2','g1','g2'] : '3',
  ['b','c','f','g1','g2'] : '4',
  ['a1','a2','c','d1','d2','f','g1','g2'] : '5',
  ['a1','a2','c','d1','d2','e','f','g1','g2'] : '6',
  ['a1','a2','j','k'] : '7',
  ['a1','a2','b','c','d1','d2','e','f','g1','g2'] : '8',
  ['a1','a2','b','c','f','g1','g2'] : '9',
  ['a1','a2','b','c','d1','d2','e','f','j','k'] : '0',
  ['a1','a2','b','c','e','f','g1','g2'] : 'A',
  ['a1','a2','b','c','d1','d2','g2','i','l'] : 'B',
  ['a1','a2','d1','d2','e','f'] : 'C',
  ['a1','a2','b','c','d1','d2','i','l'] : 'D',
  ['a1','a2','d1','d2','e','f','g1'] : 'E',
  ['a1','a2','e','f','g1'] : 'F',
  ['a1','a2','c','d1','d2','e','f','g2'] : 'G',
  ['b','c','e','f','g1','g2'] : 'H',
  ['a2','d1','d2','i','l'] : 'I',
  ['a1','a2','b','c','d1','d2','e'] : 'J',
  ['e','f','g1','j','m'] : 'K',
  ['d','e','f'] : 'L',
  ['b','c','e','f','h','j'] : 'M',
  ['b','c','e','f','h','m'] : 'N',
  ['a1','a2','b','c','d1','d2','e','f'] : 'O',
  ['a1','a2','b','e','f','g1','g2'] : 'P',
  ['a1','a2','b','c','d1','d2','e','f','m'] : 'Q',
  ['a1','a2','b','e','f','g1','g2','m'] : 'R',
  ['a1','a2','c','d1','d2','g2','h'] : 'S',
  ['a1','a2','i','l'] : 'T',
  ['b','c','d1','d2','e','f'] : 'U',
  ['e','f','j','k'] : 'V',
  ['b','c','e','f','k','m'] : 'W',
  ['h','j','k','m'] : 'X',
  ['h','j','l'] : 'Y',
  ['a1','a2','d1','d2','j','k'] : 'Z',
  ['d1','d2'] : '_',
  ['g1','g2'] : '-',
  ['d1','d2','g1','g2'] : '=',
  ['a1','a2','i','g1','g2','f'] : '°',
  ['f','i'] : '"',
  ['f'] : '\'',
  ['j','m',] : '(',
  ['h','k'] : ')',
  ['a1','a2','j','l'] : '?',
  ['j','k'] : '/'  ,
  ['h','m'] : '\\' ,
  ['g1','g2','i','l'] : '+'  ,
  ['g1','g2','i','l','h','j','k','m'] : '*' ,
  ['a1','a2','f','g1','g2','c','d1','d2','i','l'] : '\$' ,
  [] : ' '
};

List<List<String>> encodeSegment(String input, SegmentDisplayType currentSegmentTyp) {
  if (input == null || input == '')
    return [];

  Map<String, List<String>> AZToSegment;

  switch (currentSegmentTyp) {
    case SegmentDisplayType.SEVEN:
      AZToSegment = AZTo7Segment;
      break;
    case SegmentDisplayType.FOURTEEN:
      AZToSegment = AZTo14Segment;
      break;
    case SegmentDisplayType.SIXTEEN:
      AZToSegment = AZTo16Segment;
      break;
  }

  var inputCharacters = input.toUpperCase().split('').toList();

  var output = <List<String>>[];

  List<String> prevCharacter;
  for (String character in inputCharacters) {
    if (['.', ','].contains(character)) {
      if (prevCharacter == null)
        output.add(['dp']);
      else {
        prevCharacter.add('dp');
        output.add(prevCharacter);
        prevCharacter = null;
      }
    } else {
      output.add(AZToSegment[character]);
      prevCharacter = AZToSegment[character];
    }
  }

  return output;
}


String decodeSegment(String input, SegmentDisplayType currentSegmentTyp) {
  if (input == null || input == '')
    return '';

  var SegmentToAZ;

  switch (currentSegmentTyp) {
    case SegmentDisplayType.SEVEN:
      SegmentToAZ = Segment7ToAZ;
      break;
    case SegmentDisplayType.FOURTEEN:
      SegmentToAZ = Segment14ToAZ;
      break;
    case SegmentDisplayType.SIXTEEN:
      SegmentToAZ = Segment16ToAZ;
      break;
  }

  input = input.toLowerCase();

  return input
    .split(RegExp(r'[^abcdefghijklm12.]'))
    .map((Segment) {
      if (Segment == ' ' || Segment == '.')
        return ' . ';

      //rebuild Segment: sort the letters ascending
      Segment = Segment.toLowerCase();
      String hSegment = '';
      if (Segment.contains('a1')) {hSegment = hSegment + 'a1';}
      if (Segment.contains('a2')) {hSegment = hSegment + 'a2';}
      if (Segment.contains('a')) {hSegment = hSegment + 'a';}
      if (Segment.contains('b')) {hSegment = hSegment + 'b';}
      if (Segment.contains('c')) {hSegment = hSegment + 'c';}
      if (Segment.contains('d1')) {hSegment = hSegment + 'd1';}
      if (Segment.contains('d2')) {hSegment = hSegment + 'd2';}
      if (Segment.contains('d')) {hSegment = hSegment + 'd';}
      if (Segment.contains('e')) {hSegment = hSegment + 'e';}
      if (Segment.contains('f')) {hSegment = hSegment + 'f';}
      if (Segment.contains('g1')) {hSegment = hSegment + 'g1';}
      if (Segment.contains('g2')) {hSegment = hSegment + 'g2';}
      if (Segment.contains('g')) {hSegment = hSegment + 'g';}
      if (Segment.contains('i')) {hSegment = hSegment + 'i';}
      if (Segment.contains('j')) {hSegment = hSegment + 'j';}
      if (Segment.contains('k')) {hSegment = hSegment + 'k';}
      if (Segment.contains('l')) {hSegment = hSegment + 'l';}
      if (Segment.contains('m')) {hSegment = hSegment + 'm';}
      if (Segment.contains('dp')) {hSegment = hSegment + 'dp';}

      var character = SegmentToAZ[hSegment];

      return character != null ? character : '?';
    })
    .join();

}