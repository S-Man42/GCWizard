import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';

class EnglishQuadgrams extends Quadgrams {

  EnglishQuadgrams() {
    alphabet= "abcdefghijklmnopqrstuvwxyz";
    nbr_quadgrams= 93609337;
    most_frequent_quadgram= "tion";
    max_fitness = 1358;
    average_fitness= 214.8411689016491;
    assetLocation = "assets/quadgrams/en.json";
  }
}
