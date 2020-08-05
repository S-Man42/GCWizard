import 'dart:core';

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

var AZToSegment = {};
final AZTo14Segment = {
  //a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9
  //abcefg1g2 abcdefg1g2hijklm abcdg2il abcdefg1g2hijklm adef abcdefg1g2hijklm abcdil abcdefg1g2hijklm adefg1g2 abcdefg1g2hijklm aefg1g2 abcdefg1g2hijklm acdefg2 abcdefg1g2hijklm bcefg1g2 abcdefg1g2hijklm adil abcdefg1g2hijklm abcde abcdefg1g2hijklm efg1jm abcdefg1g2hijklm def abcdefg1g2hijklm bcefhj abcdefg1g2hijklm bcefhm abcdefg1g2hijklm abcdef abcdefg1g2hijklm abefg1g2 abcdefg1g2hijklm abcdefm abcdefg1g2hijklm abefg1g2m abcdefg1g2hijklm acdg2h abcdefg1g2hijklm ail abcdefg1g2hijklm bcdef abcdefg1g2hijklm efjk abcdefg1g2hijklm bcefkm abcdefg1g2hijklm hjkm abcdefg1g2hijklm hjl abcdefg1g2hijklm adjk abcdefg1g2hijklm abcdefjk abcdefg1g2hijklm bcj abcdefg1g2hijklm abdeg1g2 abcdefg1g2hijklm abcdg2 abcdefg1g2hijklm bcfg1g2 abcdefg1g2hijklm acdfg1g2 abcdefg1g2hijklm acdefg1g2 abcdefg1g2hijklm ajl abcdefg1g2hijklm abcdefg1g2 abcdefg1g2hijklm abcfg1g2
  //
  'A' : 'ABCEFG', 'B' : '', 'C' : '', 'D' : '', 'E' : '', 'F' : '', 'G' : '', 'H' : '', 'I' : '', 'J' : '',
  'K' : '', 'L' : '', 'M' : '',  'N' : '', 'O' : '', 'P' : '', 'Q' : '', 'R' : '', 'S' : '', 'T' : '',
  'U' : '', 'V' : '', 'W' : '', 'X' : '', 'Y' : '', 'Z' : '',
  '1' : '', '2' : '', '3' : '', '4' : '', '5' : '', '6' : '', '7' : '', '8' : '', '9' : '', '0' : '',
};
final AZTo7Segment = {
  //a      b     c    d     e     f    g     h     i  j   k     l   m    n     o    p     q     r   s   t
  //ABCEFG CDEFG ADEF BCDEG ADEFG AEFG ACDEF BCEFG AE ACD ACEFG DEF ACEG ABCEF CDEG ABEFG ABCFG EG ACDF DEFG
  //
  // u     v    w    x  y     z    0      1  2      3     4    5     6      7     8     9
  // BCDEF BEFG BDFG CE BCDFG ABDE ABCDEF BC ABDEG ABCDG BCFG ACDFG ACDEFG ABC ABCDEFG ABCDFG
  //
  'A' : 'ABCEFG', 'B' : 'CDEFG', 'C' : 'ADEF', 'D' : 'BCDEG', 'E' : 'ADEFG', 'F' : 'AEFG', 'G' : 'ACDEF', 'H' : 'BCEFG', 'I' : 'AE', 'J' : 'ACD',
  'K' : 'ACEFG', 'L' : 'DEF', 'M' : 'ACEG',  'N' : 'ABCEF', 'O' : 'CDEG', 'P' : 'ABEFG', 'Q' : 'ABCFG', 'R' : 'EG', 'S' : 'ACDF', 'T' : 'DEFG',
  'U' : 'BCDEF', 'V' : 'BEFG', 'W' : 'BDFG', 'X' : 'CE', 'Y' : 'BCDFG', 'Z' : 'ABDE',
  '1' : 'BC', '2' : 'ABDEG', '3' : 'ABCDG', '4' : 'BCFG', '5' : 'ACDFG', '6' : 'ACDEFG', '7' : 'ABC', '8' : 'ABCDEFG', '9' : 'ABCDFG', '0' : 'ABCDEF',
};

// Å has same code as À, so À replaces Å in mapping; Å will not occur in this map
var SegmentToAZ = {};
var Segment7ToAZ = switchMapKeyValue(AZTo7Segment);
var Segment14ToAZ = switchMapKeyValue(AZTo14Segment);

String encodeSegment(String input, GCWSwitchPosition currentSegmentTyp) {
  if (input == null || input == '')
    return '';

  return input
      .toUpperCase()
      .split('')
      .map((character) {
        if (character == ' ')
          return '|';
        if (currentSegmentTyp == GCWSwitchPosition.left) {
          AZToSegment = AZTo7Segment;
        } else {
          AZToSegment = AZTo14Segment;
        }
        var Segment = AZToSegment[character];
        return Segment != null ? Segment : '';
      })
      .join(String.fromCharCode(8195)); // using wide space
}

String decodeSegment(String input, GCWSwitchPosition currentSegmentTyp) {
  if (input == null || input == '')
    return '';

  return input
      .split(RegExp(r'[^\.\-/\|]'))
      .map((Segment) {
        if (Segment == '|' || Segment == '/')
          return ' ';

        if (currentSegmentTyp == GCWSwitchPosition.left) {
          SegmentToAZ = Segment7ToAZ;
        } else {
          SegmentToAZ = Segment14ToAZ;
        }

        //Segment nach Buchstaben sortieren - aufsteigend
        Segment = Segment.toUpperCase();
        String hSegment = '';
        if (Segment.contains('A')) {hSegment = hSegment + 'A';}
        if (Segment.contains('B')) {hSegment = hSegment + 'B';}
        if (Segment.contains('C')) {hSegment = hSegment + 'C';}
        if (Segment.contains('D')) {hSegment = hSegment + 'D';}
        if (Segment.contains('E')) {hSegment = hSegment + 'E';}
        if (Segment.contains('F')) {hSegment = hSegment + 'F';}
        if (Segment.contains('G1')) {hSegment = hSegment + 'G1';}
        if (Segment.contains('G2')) {hSegment = hSegment + 'G2';}
        if (Segment.contains('I')) {hSegment = hSegment + 'I';}
        if (Segment.contains('J')) {hSegment = hSegment + 'J';}
        if (Segment.contains('K')) {hSegment = hSegment + 'K';}
        if (Segment.contains('L')) {hSegment = hSegment + 'L';}
        if (Segment.contains('M')) {hSegment = hSegment + 'M';}

        var character = SegmentToAZ[Segment];
        return character != null ? character : '';
      })
      .join();
}