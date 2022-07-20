import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/quadgrams/logic/quadgrams.dart';

class PolishQuadgrams extends Quadgrams {
  PolishQuadgrams() {
    alphabet = 'abcdefghijklmnopqrstuvwxyz';
    nbr_quadgrams = 80053472;
    most_frequent_quadgram = 'prze';
    max_fitness = 1393;
    average_fitness = 250.73583514232695;
    assetLocation = "assets/quadgrams/pl.json";
  }
}
