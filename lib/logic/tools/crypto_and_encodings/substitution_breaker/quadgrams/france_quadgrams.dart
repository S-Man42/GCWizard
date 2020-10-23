import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';

class FranceQuadgrams extends Quadgrams {

  FranceQuadgrams() {

    alphabet = 'abcdefghijklmnopqrstuvwxyz';
    nbr_quadgrams = 91273991;
    most_frequent_quadgram = 'tion';
    max_fitness = 1357;
    average_fitness = 199.21726523931235;
    assetLocation = "assets/quadgrams/fr.json";
  }
}
