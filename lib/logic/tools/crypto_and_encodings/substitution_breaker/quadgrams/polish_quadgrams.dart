import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';

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
