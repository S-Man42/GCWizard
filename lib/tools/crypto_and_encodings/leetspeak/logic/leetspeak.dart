// https://de.wikipedia.org/wiki/Leetspeak
// https://www.dcode.fr/leet-speak-1337
// http://www.robertecker.com/hp/research/leet-converter.php?lang=de
// ?/\/()|?|) °|L|/-\/2/\|V7€7/201/¯ |>€62€$[)][)((\/)!/V|_|73_/¯ 3¯|¯¯|¯|2[]][5<[-|V7<|(_)/\†|2€|/!/\/67()_L|@¯|¯2[-|V|][|_[_][?|\/|3§
//
// [-_/¯¯|¯=?|2[]=32[]<][[\]<|[)36®3§/][/V°|(_)/\/\/¯|¯3©]|\|0./\/\1|V(_)73$?7$!}{¢?[\]7[)|)(/\/\][1_[_![-/V\3_/-

import 'dart:math';
import 'package:gc_wizard/utils/constants.dart';

part 'package:gc_wizard/tools/crypto_and_encodings/leetspeak/logic/leetspeak_data.dart';
part 'package:gc_wizard/tools/crypto_and_encodings/leetspeak/logic/leetspeak_classes.dart';

LeetFoundOutput _searchLeet(Map<String, String> decodeMap, String chiffre, int length){
  String check = chiffre.substring(0, length);
  bool resultFound = false;
  String resultValue = '';
  decodeMap.forEach((key, value) {
    if (key == check) {
      resultFound = true;
      resultValue= value;
    }
  });
  return LeetFoundOutput(found: resultFound, value: resultValue);
}

String decodeLeetSpeak(String chiffre){

  String plain = '';
  LeetFoundOutput result;
  bool found;
  while (chiffre.isNotEmpty) {
    if (chiffre[0] == ' ') {
      plain = plain + ' ';
      chiffre = chiffre.substring(1);
    }
    else {
      found = false;
      if (chiffre.length >= 5) {
        for (int i = 5; i > 0; i--) {
          if (!found) {
            result = _searchLeet(LEET_SPEAK_DECODE[i]!, chiffre, i);
            if (result.found) {
              found = true;
              chiffre = chiffre.substring(i);
              plain = plain + result.value;
            } // for
          } // if not found
        }
      } // length >= 5
      else if (chiffre.length >= 4) {
        for (int i = 4; i > 0; i--) {
          if (!found) {
            result = _searchLeet(LEET_SPEAK_DECODE[i]!, chiffre, i);
            if (result.found) {
              found = true;
              chiffre = chiffre.substring(i);
              plain = plain + result.value;
            } // for
          } // if not found
        }
      } // length >= 4
      else if (chiffre.length >= 3) {
        for (int i = 3; i > 0; i--) {
          if (!found) {
            result = _searchLeet(LEET_SPEAK_DECODE[i]!, chiffre, i);
            if (result.found) {
              found = true;
              chiffre = chiffre.substring(i);
              plain = plain + result.value;
            } // for
          } // if not found
        }
      } // length >= 3
      else if (chiffre.length >= 2) {
        for (int i = 2; i > 0; i--) {
          if (!found) {
            result = _searchLeet(LEET_SPEAK_DECODE[i]!, chiffre, i);
            if (result.found) {
              found = true;
              chiffre = chiffre.substring(i);
              plain = plain + result.value;
            } // for
          } // if not found
        }
      } // length >= 2
      else if (chiffre.isNotEmpty) {
        for (int i = 1; i > 0; i--) {
          if (!found) {
            result = _searchLeet(LEET_SPEAK_DECODE[i]!, chiffre, i);
            if (result.found) {
              found = true;
              chiffre = chiffre.substring(i);
              plain = plain + result.value;
            } // for
          } // if not found
        }
      } // length >= 1
      if (!found) {
        plain = plain + UNKNOWN_ELEMENT;
        chiffre = chiffre.substring(1);
      }
    } // else
  } // while
  return plain;
}

String encodeLeetSpeak(String plain){

  return plain.toUpperCase().split('').map((letter) {
    if (LEET_SPEAK_ENCODE[letter] == null) {
          return '';
        } else {
          return LEET_SPEAK_ENCODE[letter]![Random().nextInt(LEET_SPEAK_ENCODE[letter]!.length)];
        }
      }).toList().join('');
}