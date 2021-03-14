import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/quadgrams/quadgrams.dart';

class GermanQuadgrams extends Quadgrams {

  GermanQuadgrams() {
    alphabet = 'abcdefghijklmnopqrstuvwxyz';
    nbr_quadgrams = 89600979;
    most_frequent_quadgram = 'eine';
    max_fitness = 1348;
    average_fitness = 204.77802991842023;
    assetLocation = "assets/quadgrams/de.json";
  }
}
