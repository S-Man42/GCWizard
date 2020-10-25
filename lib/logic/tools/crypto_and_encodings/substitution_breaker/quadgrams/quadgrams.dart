import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/guballa.de/quadgrams.dart' as guballa;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/english_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/french_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/german_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/greek_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/polish_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/russian_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/spanish_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/substitution_breaker.dart';

class Quadgrams extends guballa.Quadgrams {
}

Quadgrams getQuadgrams(SubstitutionBreakerAlphabet alphabet){
  switch (alphabet) {
    case SubstitutionBreakerAlphabet.ENGLISH:
      return EnglishQuadgrams();
      break;
    case SubstitutionBreakerAlphabet.GERMAN:
      return GermanQuadgrams();
      break;
    case SubstitutionBreakerAlphabet.SPANISH:
      return SpanishQuadgrams();
      break;
    case SubstitutionBreakerAlphabet.POLISH:
      return PolishQuadgrams();
      break;
    case SubstitutionBreakerAlphabet.GREEK:
      return GreekQuadgrams();
      break;
    case SubstitutionBreakerAlphabet.FRENCH:
      return FrenchQuadgrams();
      break;
    case SubstitutionBreakerAlphabet.RUSSIAN:
      return RussianQuadgrams();
      break;
    default:
      return null;
  }
}