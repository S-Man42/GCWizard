import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/german_bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/vigenere_breaker.dart';

class Bigrams {
  static const int maxAlphabetLength = 32;

  String  alphabet = null;
  Map<String, String> replacementList = null;
  // The bigram with the lowest probability receives the value 0, the one with the greatest probability receives the value 1000000
  List<List<int>> bigrams = null;
}

