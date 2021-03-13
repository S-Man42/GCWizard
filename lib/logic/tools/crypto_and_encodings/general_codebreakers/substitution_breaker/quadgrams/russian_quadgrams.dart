import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/quadgrams/quadgrams.dart';

class RussianQuadgrams extends Quadgrams {
  RussianQuadgrams() {
    alphabet = 'абвгдежзиклмнопрстуфхцчшэюя';
    nbr_quadgrams = 81030876;
    most_frequent_quadgram = 'ного';
    max_fitness = 1337;
    average_fitness = 238.69789496858542;
    assetLocation = "assets/quadgrams/ru.json";
  }
}
