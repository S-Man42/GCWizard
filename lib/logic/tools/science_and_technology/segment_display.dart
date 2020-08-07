import 'dart:core';
import 'package:gc_wizard/utils/common_utils.dart';

enum SegmentDisplayType{SEVEN, FOURTEEN, SIXTEEN}

final Map<String, List<String>> AZTo16Segment = {
  '1' : ['b','c','j'], '2' : ['a1','a2','b','d1','d2','e','g1','g2'], '3' : ['a1','a2','b','c','d1','d2','g1','g2'], '4' : ['b','c','f','g1','g2'], '5' : ['a1','a2','c','d1','d2','f','g1','g2'],
  '6' : ['a1','a2','c','d1','d2','e','f','g1','g2'], '7' : ['a1','a2','j','l'], '8' : ['a1','a2','b','c','d1','d2','e','f','g1','g2'], '9' : ['a1','a2','b','c','f','g1','g2'], '0' : ['a1','a2','b','c','d1','d2','e','f','j','k'],
  'A' : ['a1','a2','b','c','e','f','g1','g2'], 'B' : ['a1','a2','b','c','d','g2','i','l'], 'C' : ['a1','a2','d1','d2','e','f'], 'D' : ['a1','a2','b','c','d1','d2','i','l'], 'E' : ['a1','a2','d1','d1','d2','e','f','g1','g2'],
  'F' : ['a1','a2','e','f','g1','g2'], 'G' : ['a1','a2','c','d1','d2','e','f','g2'], 'H' : ['b','c','e','f','g1','g2'], 'I' : ['a1','a2','d','i','l'], 'J' : ['a1','a2','b','c','d1','d2','e'],
  'K' : ['e','f','g1','j','m'], 'L' : ['d1','d2','e','f'], 'M' : ['b','c','e','f','h','j'],  'N' : ['b','c','e','f','h','m'], 'O' : ['a1','a2','b','c','d1','d2','e','f'],
  'P' : ['a1','a2','b','e','f','g1','g2'], 'Q' : ['a1','a2','b','c','d1','d2','e','f','m'], 'R' : ['a','b','e','f','g1','g2','m'], 'S' : ['a1','a2','c','d1','d2','g2','h'], 'T' : ['a1','a2','i','l'],
  'U' : ['b','c','d1','d2','e','f'], 'V' : ['e','f','j','k'], 'W' : ['b','c','e','f','k','m'], 'X' : ['h','j','k','m'], 'Y' : ['h','j','l'], 'Z' : ['a1','a2','d1','d2','j','k'],
  ' ' : []
};

final Map<String, List<String>> AZTo14Segment = {
  '1' : ['b','c','j'], '2' : ['a','b','d','e','g1','g2'], '3' : ['a','b','c','d','g1','g2'], '4' : ['b','c','f','g1','g2'], '5' : ['a','c','d','f','g1','g2'],
  '6' : ['a','c','d','e','f','g1','g2'], '7' : ['a','j','l'], '8' : ['a','b','c','d','e','f','g1','g2'], '9' : ['a','b','c','f','g1','g2'], '0' : ['a','b','c','d','e','f','j','k'],
  'A' : ['a','b','c','e','f','g1','g2'], 'B' : ['a','b','c','d','g2','i','l'], 'C' : ['a','d','e','f'], 'D' : ['a','b','c','d','i','l'], 'E' : ['a','d1','d','e','f','g1','g2'],
  'F' : ['a','e','f','g1','g2'], 'G' : ['a','c','d','e','f','g2'], 'H' : ['b','c','e','f','g1','g2'], 'I' : ['a','d','i','l'], 'J' : ['a','b','c','d','e'],
  'K' : ['e','f','g1','j','m'], 'L' : ['d','e','f'], 'M' : ['b','c','e','f','h','j'],  'N' : ['b','c','e','f','h','m'], 'O' : ['a','b','c','d','e','f'],
  'P' : ['a','b','e','f','g1','g2'], 'Q' : ['a','b','c','d','e','f','m'], 'R' : ['a','b','e','f','g1','g2','m'], 'S' : ['a','c','d','g2','h'], 'T' : ['a','i','l'],
  'U' : ['b','c','d','e','f'], 'V' : ['e','f','j','k'], 'W' : ['b','c','e','f','k','m'], 'X' : ['h','j','k','m'], 'Y' : ['h','j','l'], 'Z' : ['a','d','j','k'],
  ' ' : []
};

final Map<String, List<String>> AZTo7Segment = {
  '1' : ['b','c'], '2' : ['a','b','d','e','g'], '3' : ['a','b','c','d','g'], '4' : ['b','c','f','g'], '5' : ['a','c','d','f','g'],
  '6' : ['a','c','d','e','f','g'], '7' : ['a','b','c'], '8' : ['a','b','c','d','e','f','g'], '9' : ['a','b','c','d','f','g'], '0' : ['a','b','c','d','e','f'],
  'A' : ['a','b','c','e','f','g'], 'B' : ['c','d','e','f','g'], 'C' : ['a','d','e','f'], 'D' : ['b','c','d','e','g'], 'E' : ['a','d','e','f','g'],
  'F' : ['a','e','f','g'], 'G' : ['a','c','d','e','f'], 'H' : ['b','c','e','f','g'], 'I' : ['a','e'], 'J' : ['a','c','d'], 'K' : ['a','c','e','f','g'],
  'L' : ['d','e','f'], 'M' : ['a','c','e','g'], 'N' : ['a','b','c','e','f'], 'O' : ['c','d','e','g'], 'P' : ['a','b','e','f','g'], 'Q' : ['a','b','c','f','g'],
  'R' : ['a','g'], 'S' : ['a','c','d','f'], 'T' : ['d','e','f','g'], 'U' : ['b','c','d','e','f'], 'V' : ['b','e','f','g'], 'W' : ['b','d','f','g'], 'X' : ['c','e'],
  'Y' : ['b','c','d','f','g'], 'Z' : ['a','b','d','e'], ' ' : []
};

//TODO!
var Segment7ToAZ = switchMapKeyValue(AZTo7Segment);
var Segment14ToAZ = switchMapKeyValue(AZTo14Segment);
final Map<List<String>, String> Segment16ToAZ = {
  ['b','c','j'] : '1', ['b','c'] : '1'
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