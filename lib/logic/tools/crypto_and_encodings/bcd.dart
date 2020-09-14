// Maps are besed on information from
// https://de.wikipedia.org/wiki/BCD-Code
// https://de.wikipedia.org/wiki/Aiken-Code
// https://de.wikipedia.org/wiki/Stibitz-Code
// https://de.wikipedia.org/wiki/Libaw-Craig-Code
// https://de.wikipedia.org/wiki/Gray-Code
// https://www.itwissen.info/Glixon-Code-Glixon-code.html
// http://www.ahok.de/en/hoklas-code.html#:~:text=Three%20of%20the%20four%20bits%20of%20Tompkins%27s%20code,least%20significant%20bits.%20It%27s%20known%20as%20%22reflected%20code%22.

import 'package:gc_wizard/utils/common_utils.dart';

final DigitToBCDOriginal =    {'0' : "0000", '1' : '0001', '2' : '0010', '3' : '0011', '4' : '0100', '5' : '0101', '6' : '0110', '7' : '0111', '8' : '1000', '9' : '1001'};
final DigitToBCDAiken =       {'0' : '0000', '1' : '0001', '2' : '0010', '3' : '0011', '4' : '0100', '5' : '1011', '6' : '1100', '7' : '1101', '8' : '1110', '9' : '1111'};
final DigitToBCDStibitz =     {'0' : '0011', '1' : '0100', '2' : '0101', '3' : '0110', '4' : '0111', '5' : '1000', '6' : '1001', '7' : '1010', '8' : '1011', '9' : '1100'};
final DigitToBCDGray =        {'0' : '0000', '1' : '0001', '2' : '0011', '3' : '0010', '4' : '0110', '5' : '0111', '6' : '0101', '7' : '0100', '8' : '1100', '9' : '1101'};
final DigitToBCDGlixon =      {'0' : '0000', '1' : '0001', '2' : '0011', '3' : '0010', '4' : '0110', '5' : '0111', '6' : '0101', '7' : '0100', '8' : '1100', '9' : '1000'};
final DigitToBCDOBrien =      {'0' : '0001', '1' : '0011', '2' : '0010', '3' : '0110', '4' : '0100', '5' : '1100', '6' : '1110', '7' : '1010', '8' : '1011', '9' : '1001'};
final DigitToBCDPetherick =   {'0' : '0101', '1' : '0001', '2' : '0011', '3' : '0010', '4' : '0110', '5' : '1110', '6' : '1010', '7' : '1011', '8' : '1001', '9' : '1101'};
final DigitToBCDTompkins =    {'0' : '0010', '1' : '0011', '2' : '0111', '3' : '0101', '4' : '0100', '5' : '1100', '6' : '1101', '7' : '1001', '8' : '0111', '9' : '1010'};
final DigitToBCD2421 =        {'0' : '0000', '1' : '0001', '2' : '0010', '3' : '0011', '4' : '0100', '5' : '0101', '6' : '1100', '7' : '1101', '8' : '1110', '9' : '1111'};
final DigitToBCDGrayExcess =  {'0' : '0010', '1' : '0110', '2' : '', '3' : '', '4' : '', '5' : '', '6' : '', '7' : '', '8' : '', '9' : ''};
final DigitToBCDLibawCraig =  {'0' : '00000', '1' : '00001', '2' : '00011', '3' : '00111', '4' : '01111', '5' : '11111', '6' : '11110', '7' : '11100', '8' : '11000', '9' : '10000'};
final DigitToBCD2of5 =        {'0' : '01100', '1' : '11000', '2' : '10100', '3' : '10010', '4' : '01010', '5' : '00110', '6' : '10001', '7' : '01001', '8' : '00101', '9' : '00011'};
final DigitToBCD2of5Postnet = {'0' : '11000', '1' : '00011', '2' : '00101', '3' : '00110', '4' : '01001', '5' : '01010', '6' : '01100', '7' : '10001', '8' : '10010', '9' : '10100'};
final DigitToBCD2of5Planet =  {'0' : '00111', '1' : '11100', '2' : '11010', '3' : '11001', '4' : '10110', '5' : '10101', '6' : '10011', '7' : '01110', '8' : '01101', '9' : '01011'};
final DigitToBCD1of10 =       {'0' : '0000000001', '1' : '0000000010', '2' : '0000000100', '3' : '0000001000', '4' : '0000010000', '5' : '0000100000', '6' : '0001000000', '7' : '0010000000', '8' : '0100000000', '9' : '1000000000'};

var BCDOriginalToDigit = switchMapKeyValue(DigitToBCDOriginal);
var BCDAikenToDigit = switchMapKeyValue(DigitToBCDAiken);
var BCDStibitzToDigit = switchMapKeyValue(DigitToBCDStibitz);
var BCDGrayToDigit = switchMapKeyValue(DigitToBCDGray);
var BCDGlixonToDigit = switchMapKeyValue(DigitToBCDGlixon);
var BCDOBrienToDigit = switchMapKeyValue(DigitToBCDOBrien);
var BCDPetherickToDigit = switchMapKeyValue(DigitToBCDPetherick);
var BCDTompkinsToDigit = switchMapKeyValue(DigitToBCDTompkins);
var BCDLibawCraigToDigit = switchMapKeyValue(DigitToBCDLibawCraig);
var BCDGrayExcessToDigit = switchMapKeyValue(DigitToBCDGrayExcess);
var BCD2421ToDigit = switchMapKeyValue(DigitToBCD2421);
var BCD1of10ToDigit = switchMapKeyValue(DigitToBCD1of10);
var BCD2of5ToDigit = switchMapKeyValue(DigitToBCD2of5);
var BCD2of5PlanetToDigit = switchMapKeyValue(DigitToBCD2of5Planet);
var BCD2of5PostnetToDigit = switchMapKeyValue(DigitToBCD2of5Postnet);

enum BCDType {ORIGINAL, AIKEN, STIBITZ, GRAY, GLIXON, OBRIEN, PETHERICK, TOMPKINS, LIBAWCRAIG, GRAYEXCESS, TWOOFFIVE, ONEOFTEN, PLANET, POSTNET, TWOFOURTWOONE}

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
    case BCDType.GRAYEXCESS: bcdMap = DigitToBCDGrayExcess;
    break;
    case BCDType.TWOOFFIVE: bcdMap = DigitToBCD2of5;
    break;
    case BCDType.PLANET: bcdMap = DigitToBCD2of5Planet;
    break;
    case BCDType.POSTNET: bcdMap = DigitToBCD2of5Postnet;
    break;
    case BCDType.ONEOFTEN: bcdMap = DigitToBCD1of10;
    break;
    case BCDType.TWOFOURTWOONE: bcdMap = DigitToBCD2421;
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
    case BCDType.GRAYEXCESS: bcdMap = BCDGrayExcessToDigit;
    break;
    case BCDType.TWOOFFIVE: bcdMap = BCD2of5ToDigit;
    break;
    case BCDType.PLANET: bcdMap = BCD2of5PlanetToDigit;
    break;
    case BCDType.POSTNET: bcdMap = BCD2of5PostnetToDigit;
    break;
    case BCDType.ONEOFTEN: bcdMap = BCD1of10ToDigit;
    break;
    case BCDType.TWOFOURTWOONE: bcdMap = BCD2421ToDigit;
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


