
import 'dart:math';

import 'package:flutter/services.dart';


class TableTitle{
  final List<String> row;
  final List<String> column;

  TableTitle(this.row, this.column);
}

String buildAuthBundeswehr(String currentCallSign, String currentLetterAuth, String currentLetterCallSign, List<String> rowTitle, List<String> colTitle, List<String> numeralCode, Map<String, Map<String, String>> authTable){
  if (currentCallSign.split('').contains(currentLetterCallSign)) {

    if (['A', 'D', 'E', 'G', 'H', 'I', 'L', 'N', 'O', 'R', 'S', 'T', 'U',].contains(currentLetterCallSign)) {
      List<String> result = [];
      List<String> tupel1 = [];
      for (int i = 0; i < numeralCode.length; i++) {
        if (numeralCode[i] == currentLetterCallSign){
           String t1 = colTitle[i % 13];
           String t2 = rowTitle[i ~/ 13];
           tupel1.add(t1 + t2);
           tupel1.add(t2 + t1);
        }
      }

      String authCode = authTable[currentLetterCallSign][currentLetterAuth];
      List<String> tupel2 = [];
      for (int i = 0; i < numeralCode.length; i++) {
        if (numeralCode[i] == authCode.split('')[0]){
          String t1 = colTitle[i % 13];
          String t2 = rowTitle[i ~/ 13];
          tupel2.add(t1 + t2);
          tupel2.add(t2 + t1);
        }
      }

      List<String> tupel3 = [];
      for (int i = 0; i < numeralCode.length; i++) {
        if (numeralCode[i] == authCode.split('')[1]){
          String t1 = colTitle[i % 13];
          String t2 = rowTitle[i ~/ 13];
          tupel3.add(t1 + t2);
          tupel3.add(t2 + t1);
        }
      }

      int limit = max(tupel1.length, tupel2.length);
      if (tupel3.length > limit)
        limit = tupel3.length;
      String line = '';
      for (int i = 0; i < limit; i++){
        line = '';
        if (i < tupel1.length)
          line = line + tupel1[i] + '  ';
        else
          line = line + '  ' + '  ';

        if (i < tupel2.length)
          line = line + tupel2[i] + '  ';
        else
          line = line + '  ' + '  ';

        if (i < tupel3.length)
          line = line + tupel3[i] + '  ';
        else
          line = line + '  ' + '  ';

        result.add(line);
      }
      return result.join('\n');
    }
    return 'ERROR: LETTER NOT PART AUF AUTHENTICATION CODE';
  }
   return 'ERROR: INVALID LETTER FROM CALLSIGN';
}

String checkAuthBundeswehr(String currentCallSign, String currentAuth){
  return 'bundeswehr_auth_correct';
}