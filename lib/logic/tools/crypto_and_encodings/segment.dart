import 'dart:core';
import 'package:gc_wizard/utils/common_utils.dart';

enum SegmentTyp{Segment7,Segment14,Segment16}

var AZToSegment = {};
final AZTo16Segment = {
  //
  '1' : '', '2' : '', '3' : '', '4' : '', '5' : '',
  '6' : '', '7' : '', '8' : '', '9' : '', '0' : '',
  'A' : '', 'B' : '', 'C' : '', 'D' : '', 'E' : '',
  'F' : '', 'G' : '', 'H' : '', 'I' : '', 'J' : '',
  'K' : '', 'L' : '', 'M' : '',  'N' : '', 'O' : '',
  'P' : '', 'Q' : '', 'R' : '',  'S' : '', 'T' : '',
  'U' : '', 'V' : '', 'W' : '', 'X' : '', 'Y' : '', 'Z' : '',
};
final AZTo14Segment = {
  // http://kryptografie.de/kryptografie/chiffre/14-segment.htm
  '1' : 'bcj', '2' : 'abdeg1g2', '3' : 'abcdg2', '4' : 'bcfg1g2', '5' : 'acdfg1g2',
  '6' : 'acdefg1g2', '7' : 'ajl', '8' : 'abcdefg1g2', '9' : 'abcfg1g2', '0' : 'abcdefjk',
  'A' : 'abcefg1g2', 'B' : 'abcdg2il', 'C' : 'adef', 'D' : 'abcdil', 'E' : 'adefg1g2',
  'F' : 'aefg1g2', 'G' : 'acdefg2', 'H' : 'bcefg1g2', 'I' : 'adil', 'J' : 'abcde',
  'K' : 'efg1jm', 'L' : 'def', 'M' : 'bcefhj',  'N' : 'bcefhm', 'O' : 'abcdef',
  'P' : 'abefg1g2', 'Q' : 'abcdefm', 'R' : 'abefg1g2m', 'S' : 'acdg2h', 'T' : 'ail',
  'U' : 'bcdef', 'V' : 'efjk', 'W' : 'bcefkm', 'X' : 'hjkm', 'Y' : 'hjl', 'Z' : 'adjk',
};
final AZTo7Segment = {
  // http://kryptografie.de/kryptografie/chiffre/7-segment.htm
  '1' : 'bc', '2' : 'abdeg', '3' : 'abcdg', '4' : 'bcfg', '5' : 'acdfg',
  '6' : 'acdefg', '7' : 'abc', '8' : 'abcdefg', '9' : 'abcdfg', '0' : 'abcdef',
  'A' : 'abcefg', 'B' : 'cdefg', 'C' : 'adef', 'D' : 'bcdeg', 'E' : 'adefg',
  'F' : 'aefg', 'G' : 'acdef', 'H' : 'bcefg', 'I' : 'ae', 'J' : 'acd',  'K' : 'acefg',
  'L' : 'def', 'M' : 'aceg',  'N' : 'abcef', 'O' : 'cdeg', 'P' : 'abefg', 'Q' : 'abcfg',
  'R' : 'ag', 'S' : 'acdf', 'T' : 'defg', 'U' : 'bcdef', 'V' : 'befg', 'W' : 'bdfg',
  'X' : 'ce', 'Y' : 'bcdfg', 'Z' : 'abde',
};

var SegmentToAZ = {};
var Segment7ToAZ = switchMapKeyValue(AZTo7Segment);
var Segment14ToAZ = switchMapKeyValue(AZTo14Segment);
var Segment16ToAZ = switchMapKeyValue(AZTo16Segment);

String encodeSegment(String input, SegmentTyp currentSegmentTyp) {
  if (input == null || input == '')
    return '';

  switch (currentSegmentTyp) {
    case SegmentTyp.Segment7:
      AZToSegment = AZTo7Segment;
      break;
    case SegmentTyp.Segment14:
      AZToSegment = AZTo14Segment;
      break;
    case SegmentTyp.Segment16:
      AZToSegment = AZTo16Segment;
      break;
  }

  return input
      .toUpperCase()
      .split('')
      .map((character) {
        if (character == ' ')
          return '-';
        var Segment = AZToSegment[character];
        return Segment != null ? Segment : '';
      })
      .join(String.fromCharCode(8195)); // using wide space
}

String decodeSegment(String input, SegmentTyp currentSegmentTyp) {
  if (input == null || input == '')
    return '';

  switch (currentSegmentTyp) {
    case SegmentTyp.Segment7:
      SegmentToAZ = Segment7ToAZ;
      break;
    case SegmentTyp.Segment14:
      SegmentToAZ = Segment14ToAZ;
      break;
    case SegmentTyp.Segment16:
      SegmentToAZ = Segment16ToAZ;
      break;
  }

  return input
      .split(RegExp(r'[^abcdefghijklm12.]'))
      .map((Segment) {
        if (Segment == ' ' || Segment == '.')
          return ' . ';

        //rebuild Segment: sort the letters ascending
        Segment = Segment.toUpperCase();
        String hSegment = '';
        if (Segment.contains('A1')) {hSegment = hSegment + 'A1';}
        if (Segment.contains('A2')) {hSegment = hSegment + 'A2';}
        if (Segment.contains('A')) {hSegment = hSegment + 'A';}
        if (Segment.contains('B')) {hSegment = hSegment + 'B';}
        if (Segment.contains('C')) {hSegment = hSegment + 'C';}
        if (Segment.contains('D1')) {hSegment = hSegment + 'D1';}
        if (Segment.contains('D2')) {hSegment = hSegment + 'D2';}
        if (Segment.contains('D')) {hSegment = hSegment + 'D';}
        if (Segment.contains('E')) {hSegment = hSegment + 'E';}
        if (Segment.contains('F')) {hSegment = hSegment + 'F';}
        if (Segment.contains('G1')) {hSegment = hSegment + 'G1';}
        if (Segment.contains('G2')) {hSegment = hSegment + 'G2';}
        if (Segment.contains('G')) {hSegment = hSegment + 'G';}
        if (Segment.contains('I')) {hSegment = hSegment + 'I';}
        if (Segment.contains('J')) {hSegment = hSegment + 'J';}
        if (Segment.contains('K')) {hSegment = hSegment + 'K';}
        if (Segment.contains('L')) {hSegment = hSegment + 'L';}
        if (Segment.contains('M')) {hSegment = hSegment + 'M';}
        if (Segment.contains('DP')) {hSegment = hSegment + 'DP';}

        var character = SegmentToAZ[hSegment];

        return character != null ? character : '?';
      })
      .join();
}