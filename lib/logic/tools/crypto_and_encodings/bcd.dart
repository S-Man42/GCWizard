// Maps are besed on information from
// https://de.wikipedia.org/wiki/BCD-Code
// https://de.wikipedia.org/wiki/Aiken-Code
// https://de.wikipedia.org/wiki/Stibitz-Code
// https://de.wikipedia.org/wiki/Libaw-Craig-Code
// https://de.wikipedia.org/wiki/Gray-Code
// https://www.itwissen.info/Glixon-Code-Glixon-code.html
// http://www.ahok.de/en/hoklas-code.html#:~:text=Three%20of%20the%20four%20bits%20of%20Tompkins%27s%20code,least%20significant%20bits.%20It%27s%20known%20as%20%22reflected%20code%22.

import 'package:gc_wizard/utils/common_utils.dart';

final DigitToBCDOriginal =   {'0' : "0000", '1' : '0001', '2' : '0010', '3' : '0011', '4' : '0100', '5' : '0101', '6' : '0110', '7' : '0111', '8' : '1000', '9' : '1001'};
final DigitToBCDAiken =      {'0' : '0000', '1' : '0001', '2' : '0010', '3' : '0011', '4' : '0100', '5' : '1011', '6' : '1100', '7' : '1101', '8' : '1110', '9' : '1111'};
final DigitToBCDStibitz =    {'0' : '0011', '1' : '0100', '2' : '0101', '3' : '0110', '4' : '0111', '5' : '1000', '6' : '1001', '7' : '1010', '8' : '1011', '9' : '1100'};
final DigitToBCDGray =       {'0' : '0000', '1' : '0001', '2' : '0011', '3' : '0010', '4' : '0110', '5' : '0111', '6' : '0101', '7' : '0100', '8' : '1100', '9' : '1101'};
final DigitToBCDGlixon =     {'0' : '0000', '1' : '0001', '2' : '0011', '3' : '0010', '4' : '0110', '5' : '0111', '6' : '0101', '7' : '0100', '8' : '1100', '9' : '1000'};
final DigitToBCDOBrien =     {'0' : '0001', '1' : '0011', '2' : '0010', '3' : '0110', '4' : '0100', '5' : '1100', '6' : '1110', '7' : '1010', '8' : '1011', '9' : '1001'};
final DigitToBCDPetherick =  {'0' : '0101', '1' : '0001', '2' : '0011', '3' : '0010', '4' : '0110', '5' : '1110', '6' : '1010', '7' : '1011', '8' : '1001', '9' : '1101'};
final DigitToBCDTompkins =   {'0' : '0010', '1' : '0011', '2' : '0111', '3' : '0101', '4' : '0100', '5' : '1100', '6' : '1101', '7' : '1001', '8' : '0111', '9' : '1010'};
final DigitToBCDLibawCraig = {'0' : '00000', '1' : '00001', '2' : '00011', '3' : '00111', '4' : '01111', '5' : '11111', '6' : '11110', '7' : '11100', '8' : '11000', '9' : '10000'};


var BCDOriginalToDigit = switchMapKeyValue(DigitToBCDOriginal);
var BCDAikenToDigit = switchMapKeyValue(DigitToBCDAiken);
var BCDStibitzToDigit = switchMapKeyValue(DigitToBCDStibitz);
var BCDGrayToDigit = switchMapKeyValue(DigitToBCDGray);
var BCDGlixonToDigit = switchMapKeyValue(DigitToBCDGlixon);
var BCDOBrienToDigit = switchMapKeyValue(DigitToBCDOBrien);
var BCDPetherickToDigit = switchMapKeyValue(DigitToBCDPetherick);
var BCDTompkinsToDigit = switchMapKeyValue(DigitToBCDTompkins);
var BCDLibawCraigToDigit = switchMapKeyValue(DigitToBCDLibawCraig);

enum BCDType {ORIGINAL, AIKEN, STIBITZ, GRAY, GLIXON, OBRIEN, PETHERICK, TOMPKINS, LIBAWCRAIG}

String encodeBCD(String input, BCDType type){
  if (input == null || input == '')
    return '' ;

  var bcdMap;
  switch (type) {
    case BCDType.ORIGINAL: bcdMap = DigitToBCDOriginal;
      break;
    case BCDType.AIKEN: bcdMap = DigitToBCDAiken;
      break;
    case BCDType.STIBITZ: bcdMap = DigitToBCDStibitz;
      break;
    case BCDType.GRAY: bcdMap = DigitToBCDGray;
      break;
    case BCDType.GLIXON: bcdMap = DigitToBCDGlixon;
      break;
    case BCDType.OBRIEN: bcdMap = DigitToBCDOBrien;
      break;
    case BCDType.PETHERICK: bcdMap = DigitToBCDPetherick;
      break;
    case BCDType.TOMPKINS: bcdMap = DigitToBCDTompkins;
      break;
    case BCDType.LIBAWCRAIG: bcdMap = DigitToBCDLibawCraig;
      break;
  }

  return input
      .split('')
      .where((character) => bcdMap[character] != null)
      .map((character) => bcdMap[character])
      .join(' ');
}




String decodeBCD(String input, BCDType type){
  if (input == null || input == '')
    return '';

  var bcdMap;
  switch (type) {
    case BCDType.ORIGINAL: bcdMap = BCDOriginalToDigit;
      break;
    case BCDType.AIKEN: bcdMap = BCDAikenToDigit;
      break;
    case BCDType.STIBITZ: bcdMap = BCDStibitzToDigit;
      break;
    case BCDType.GRAY: bcdMap = BCDGrayToDigit;
      break;
    case BCDType.GLIXON: bcdMap = BCDGlixonToDigit;
      break;
    case BCDType.OBRIEN: bcdMap = BCDOBrienToDigit;
      break;
    case BCDType.PETHERICK: bcdMap = BCDPetherickToDigit;
      break;
    case BCDType.TOMPKINS: bcdMap = BCDTompkinsToDigit;
      break;
    case BCDType.LIBAWCRAIG: bcdMap = BCDLibawCraigToDigit;
      break;
  }

  return input
      .split(RegExp(r'[^01]'))
      .map((bcd) {

        var character = bcdMap[bcd];
        return character != null ? character : '';
      })
      .join();
}


