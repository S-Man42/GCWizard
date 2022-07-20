import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/quadgrams/logic/quadgrams.dart';

class FrenchQuadgrams extends Quadgrams {
  FrenchQuadgrams() {
    alphabet = 'abcdefghijklmnopqrstuvwxyz';
    nbr_quadgrams = 91273991;
    most_frequent_quadgram = 'tion';
    max_fitness = 1357;
    average_fitness = 199.21726523931235;
    assetLocation = "assets/quadgrams/fr.json";
  }
}
