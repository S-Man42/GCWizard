import 'dart:math';

part 'package:gc_wizard/tools/crypto_and_encodings/avemaria/logic/avemaria_data.dart';

String decodeAveMaria(String chiffre) {
  List<String> result = [];
  List<String> code = chiffre.toLowerCase().split('  ');

  for (String word in code) {
    List<String> letters = word.split(' ');
    for (String letter in letters) {
      if (_AVE_MARIA_DECODE[letter] == null) {
        result.add(' ');
      } else {
        result.add(_AVE_MARIA_DECODE[letter]!);
      }
    }
  }
  return result.join('');
}

String encodeAveMaria(String plain) {
  List<String> result = [];
  List<String> code = plain.toUpperCase().split('  ');

  for (String letter in code) {
    if (letter == ' ') {
      result.add(' ');
    } else {
      result.add(_AVE_MARIA_ENCODE[letter]![Random().nextInt(2)]);
    }
  }
  return result.join(' ');
}