import 'dart:math';

part 'package:gc_wizard/tools/crypto_and_encodings/avemaria/logic/avemaria_data.dart';

String decodeAveMaria(String chiffre) {
  List<String> result = [];
  List<String> code = chiffre.toLowerCase().split('  ');

  for (String word in code) {
    for (String letter in word.split(' ')) {
      if (_AVE_MARIA[letter] == null) {
        result.add(' ');
      } else {
        result.add(_AVE_MARIA[letter]!);
      }
    }
  }
  return result.join('');
}

String encodeAveMaria(String plain) {
  List<String> result = [];
  List<String> code = plain.toUpperCase().split(' ');

  for (String word in code) {
    for (String letter in word.split('')) {
      var results = _AVE_MARIA.entries.where((entry) => entry.value == letter);
      if (results.isEmpty) {
        results = _AVE_MARIA_ENCODE_EXTENSION.where((entry) => entry.value == letter);
      }

      if (results.isNotEmpty) {
        result.add(results.elementAt(Random().nextInt(results.length)).key);
      }
    }
    result.add(' ');
  }
  return result.join(' ').trim();
}