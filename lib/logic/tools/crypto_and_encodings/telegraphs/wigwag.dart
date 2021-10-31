
import 'package:gc_wizard/utils/common_utils.dart';

enum WigWagCodebook { ORIGINAL, GENERALSERVICECODE }

Map<WigWagCodebook, Map<String, String>> CCITT_CODEBOOK = {
  WigWagCodebook.ORIGINAL: {'title': 'telegraph_wigwag_original_title', 'subtitle': 'telegraph_wigwag_original_description'},
  WigWagCodebook.GENERALSERVICECODE: {'title': 'telegraph_wigwag_general_title', 'subtitle': 'telegraph_wigwag_general_description'},
};

final Map<String, int> originalCode = {
  'ENDOFWORD' : 3,
  'ENDOFSENTENCE' : 33,
  'ENDOFMESSAGE' : 333,
  'UNDERSTOOD' : 2222223,
  'STOPSENDING' : 222222333,
  'REPEAT' : 121121121,
  'ERROR' : 212121,
  'MOVETOTHERIGHT' : 211211211,
  'MOVETOTHELEFT' : 221221221,
  'WAITAMOMENT' : 21112,
  'AREYOUREADY' : 12221,
  'IAMREADY' : 22122,
  'WORKFASTER' : 12222,
  'DIDYOUUNDERSTAND' : 11222,
  'USEWHITEFLAG' : 11112,
  'USEREDFLAG' : 22222,
  'A' : 22,
  'B' : 2112,
  'C' : 121,
  'D' : 222,
  'E' : 12,
  'F' : 2221,
  'G' : 2211,
  'H' : 122,
  'I' : 1,
  'J' : 1122,
  'K' : 2121,
  'L' : 221,
  'M' : 1221,
  'N' : 11,
  'O' : 21,
  'P' : 1212,
  'Q' : 1211,
  'R' : 211,
  'S' : 212,
  'T' : 2,
  'U' : 112,
  'V' : 1222,
  'W' : 1121,
  'X' : 2122,
  'Y' : 111,
  'Z' : 2222,
};

final Map<String, int> generalCode = {
  'ENDOFWORD' : 3,
  'ENDOFSENTENCE' : 33,
  'ENDOFMESSAGE' : 333,
  'UNDERSTOOD' : 2222223,
  'STOPSENDING' : 222222333,
  'REPEAT' : 121121121,
  'ERROR' : 212121,
  'MOVETOTHERIGHT' : 211211211,
  'MOVETOTHELEFT' : 221221221,
  'A' : 112,
  'B' : 121,
  'C' : 211,
  'D' : 212,
  'E' : 221,
  'F' : 122,
  'G' : 123,
  'H' : 312,
  'I' : 213,
  'J' : 232,
  'K' : 323,
  'L' : 231,
  'M' : 132,
  'N' : 322,
  'O' : 223,
  'P' : 313,
  'Q' : 131,
  'R' : 331,
  'S' : 332,
  'T' : 133,
  'U' : 233,
  'V' : 222,
  'W' : 311,
  'X' : 321,
  'Y' : 111,
  'Z' : 113,
};

String encodeWigWag(String plainText, WigWagCodebook language){
 if (plainText == '' || plainText == null)
   return '';

 var codebook;
 switch (language) {
   case WigWagCodebook.ORIGINAL:
     codebook = originalCode;
     break;
   case WigWagCodebook.GENERALSERVICECODE:
     codebook = generalCode;
     break;
 }

 List<String> output = [];

 var encode = plainText
     .replaceAll('END OF WORD', 'ENDOFWORD')
     .replaceAll('END OF SENTENCE', 'ENDOFSENTENCE')
     .replaceAll('END OF MESSAGE', 'ENDOFMESSAGE')
     .replaceAll('STOP SENDING', 'STOPSENDING')
     .replaceAll('MOVE TO THE RIGHT', 'MOVETOTHERIGHT')
     .replaceAll('MOVE TO THE LEFT', 'MOVETOTHELEFT')
     .replaceAll('WAIT A MOMENT', 'WAITAMOMENT')
     .replaceAll('ARE YOU READY', 'AREYOUREADY')
     .replaceAll('I AM READY', 'IAMREADY')
     .replaceAll('WORK FASTER', 'WORKFASTER')
     .replaceAll('DID YOU UNDERSTAND', 'DIDYOUUNDERSTAND')
     .replaceAll('USE WHITE FLAG', 'USEWHITEFLAG')
     .replaceAll('USE RED FLAG', 'USEREDFLAG')
     .split(' ');
 for (int i = 0; i < encode.length; i++) {
    if (codebook[encode[i]] != null)
      output.add(codebook[encode[i]].toString());
    else {
      var encodeElement = encode[i].split('');
      for (int j = 0; j < encodeElement.length; j++) {
        output.add(codebook[encodeElement[j]].toString());
      }
    }
 }
 return output.join(' ');
}

String decodeWigWag(List<int> cypherText, WigWagCodebook language){
  if (cypherText == [] || cypherText == null)
    return '';

  var codebook;
  switch (language) {
    case WigWagCodebook.ORIGINAL:
      codebook = switchMapKeyValue(originalCode);
      break;
    case WigWagCodebook.GENERALSERVICECODE:
      codebook = switchMapKeyValue(generalCode);
      break;
  }

  List<String> output = [];
  cypherText.forEach((element) {
    output.add(codebook[element]);
  });
  return output.join(' ')
      .replaceAll('ENDOFWORD', 'END OF WORD')
      .replaceAll('ENDOFSENTENCE', 'END OF SENTENCE')
      .replaceAll('ENDOFMESSAGE', 'END OF MESSAGE')
      .replaceAll('STOPSENDING', 'STOP SENDING')
      .replaceAll('MOVETOTHERIGHT', 'MOVE TO THE RIGHT')
      .replaceAll('MOVETOTHELEFT', 'MOVE TO THE LEFT')
      .replaceAll('WAITAMOMENT', 'WAIT A MOMENT')
      .replaceAll('AREYOUREADY', 'ARE YOU READY')
      .replaceAll('IAMREADY', 'I AM READY')
      .replaceAll('WORKFASTER', 'WORK FASTER')
      .replaceAll('DIDYOUUNDERSTAND', 'DID YOU UNDERSTAND')
      .replaceAll('USEWHITEFLAG', 'USE WHITE FLAG')
      .replaceAll('USEREDFLAG', 'USE RED FLAG');
}