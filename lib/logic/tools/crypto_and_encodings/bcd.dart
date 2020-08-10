// https://de.wikipedia.org/wiki/BCD-Code
// https://de.wikipedia.org/wiki/Aiken-Code
// https://de.wikipedia.org/wiki/Stibitz-Code
// https://de.wikipedia.org/wiki/Libaw-Craig-Code
// https://de.wikipedia.org/wiki/Gray-Code
// https://de.wikipedia.org/wiki/1-aus-n-Code

import 'package:gc_wizard/utils/common_utils.dart';

final DigitToBCD = {'0' : "0000", '1' : '0001', '2' : '0010', '3' : '0011', '4' : '0010',
                    '5' : '0101', '6' : '0110', '7' : '0111', '8' : '1000', '9' : '1001'};
final DigitToBCDAiken = {'0' : '0000', '1' : '0001', '2' : '0010', '3' : '0011', '4' : '0010',
                         '5' : '1011', '6' : '1100', '7' : '1101', '8' : '1110', '9' : '1111'};
final DigitToBCDStibitz = {'0' : '0011', '1' : '0100', '2' : '0101', '3' : '0110', '4' : '0111',
                           '5' : '1000', '6' : '1001', '7' : '1010', '8' : '1011', '9' : '1100'};
final DigitToBCDLibawCraig = {'0' : '00000', '1' : '00001', '2' : '0011', '3' : '00111', '4' : '01111',
                              '5' : '11111', '6' : '11110', '7' : '11100', '8' : '11000', '9' : '10000'};

var BCDToDigit = switchMapKeyValue(DigitToBCD);
var BCDAikenToDigit = switchMapKeyValue(DigitToBCDAiken);
var BCDStibitzToDigit = switchMapKeyValue(DigitToBCDStibitz);
var BCDLibawCraigToDigit = switchMapKeyValue(DigitToBCDLibawCraig);


String BCDencodeOriginal(String input){
  if (input == null || input == '')
    return '' ;

  return input
      .split('')
      .where((character) => DigitToBCD[character] != null)
      .map((character) => DigitToBCD[character])
      .join(String.fromCharCode(8195)); // using wide space
}


String BCDencodeAiken(String input){
  if (input == null || input == '')
    return '' ;

  return input
      .split('')
      .where((character) => DigitToBCDAiken[character] != null)
      .map((character) => DigitToBCDAiken[character])
      .join(String.fromCharCode(8195)); // using wide space
}


String BCDencodeStibitz(String input){
  if (input == null || input == '')
    return '' ;

  return input
      .split('')
      .where((character) => DigitToBCDStibitz[character] != null)
      .map((character) => DigitToBCDStibitz[character])
      .join(String.fromCharCode(8195)); // using wide space
}


String BCDencodeLibawCraig(String input){
  if (input == null || input == '')
    return '' ;

  return input
      .split('')
      .where((character) => BCDLibawCraigToDigit[character] != null)
      .map((character) => BCDLibawCraigToDigit[character])
      .join(String.fromCharCode(8195)); // using wide space
}


String BCDdecodeOriginal(String input){
  if (input == null || input == '')
    return '';

  return input
      .split(RegExp(r'[^01]'))
      .map((bcd) {
        if (bcd == '.' || bcd == ' '  || bcd == '-' )
          return ' ';

        var character = BCDToDigit[bcd];
        return character != null ? character : '';
      })
      .join();
}


String BCDdecodeAiken(String input){
  if (input == null || input == '')
    return '';

  return input
      .split(RegExp(r'[^01]'))
      .map((bcd) {
        if (bcd == '.' || bcd == ' '  || bcd == '-' )
          return ' ';

        var character = BCDAikenToDigit[bcd];

        return character != null ? character : '';
      })
      .join();
}


String BCDdecodeStibitz(String input){
  if (input == null || input == '')
    return '';

  return input
      .split(RegExp(r'[^01]'))
      .map((bcd) {
       if (bcd == '.' || bcd == ' '  || bcd == '-' )
        return ' ';

       var character = BCDStibitzToDigit[bcd];

        return character != null ? character : '';
      })
      .join();
}


String BCDdecodeLibawCraig(String input){
  if (input == null || input == '')
    return '';

  return input
      .split(RegExp(r'[^01]'))
      .map((bcd) {
        if (bcd == '.' || bcd == ' '  || bcd == '-' )
          return ' ';

        var character = BCDLibawCraigToDigit[bcd];

        return character != null ? character : '';
      })
      .join();
}

