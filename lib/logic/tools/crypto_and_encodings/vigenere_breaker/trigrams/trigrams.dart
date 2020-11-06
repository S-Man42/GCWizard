import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/guballa.de/breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/vigenere_breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/german_trigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/english_trigrams.dart';

class Trigrams {
  static const int maxAlphabetLength = 32;

  String alphabet = null;
  Map<String, String> replacementList = null;

  // The trigram with the lowest probability receives the value 0, the one with the greatest probability receives the value 1000000
  Map<int, List<int>> trigramsCompressed = null;

  List<int> _trigrams = null;

  List<int> trigrams() {
    if (_trigrams != null)
      return _trigrams;

    if (trigramsCompressed == null)
      return null;

    _trigrams = Quadgrams.decompressQuadgrams(trigramsCompressed, pow(Trigrams.maxAlphabetLength, 2) * alphabet.length);
    trigramsCompressed = null;
    return _trigrams;
  }

  static String trigramsMapToString(Map<int, List<int>> trigramsCompressed) {
    var sb = new StringBuffer();
    bool first = true;
    bool firstEntry = true;
    String out = '';
    var idx = 0;
    sb.write('{');
    trigramsCompressed.forEach((idx, values) {
      if (firstEntry)
        firstEntry = false;
      else
        sb.write(',');
      sb.write(idx.toString());
      sb.write(':');
      sb.write('[');
      first = true;
      values.forEach((val) {
        if (first)
          first = false;
        else
          sb.write(',');
        if (val == null) val = 0;
        out = val.round().toString();
        sb.write(out);
      });
      sb.write(']');
    });
    sb.write('}');

    out = '';
    out = sb.toString()
        .split('')
        .map((char) {
      if (idx > 230 && ((char == ',') | (char == '}'))) {
        idx = 0;
        return char + '\n';
      } else {
        idx += 1;
        return char;
      }
    })
        .join();

    return out;
  }
}

double calc_fitnessTrigrams(String txt, Trigrams trigrams) {
  if (txt == null || txt == '')
    return null;

  var trigramsList = trigrams.trigrams();
  if ((trigrams == null) || (trigrams.alphabet == null) || (trigramsList == null))
    return null;

  var fitness = 0;
  var plain_bin = List<int>();
  var trigram_val = 0;

  iterateText(txt, trigrams.alphabet).forEach((char) {plain_bin.add(char);});

  if (plain_bin.length < 3)
    // More than two characters from the given alphabet are required
    return null;

  for (var idx = 0; idx < (plain_bin.length - 2); idx++) {
    trigram_val = ((((plain_bin[idx] << 5) + plain_bin[idx+1]) & 0x3FF) << 5) + plain_bin[idx+2];

    fitness += trigramsList[trigram_val];
  };

  return fitness / 10000 / (plain_bin.length - 2);
}

Trigrams getTrigrams(VigenereBreakerAlphabet alphabet){
  switch (alphabet) {
    case VigenereBreakerAlphabet.ENGLISH:
      return EnglishTrigrams();
      break;
    case VigenereBreakerAlphabet.GERMAN:
      return  GermanTrigrams();
      break;
    case VigenereBreakerAlphabet.SPANISH:
    //return SpanishBigrams();
//      break;
//    case VigenereBreakerAlphabet.POLISH:
//      return PolishBigrams();
//      break;
//    case VigenereBreakerAlphabet.GREEK:
//      return GreekQuadgrams();
//      break;
    case VigenereBreakerAlphabet.FRENCH:
    //return FrenchBigrams();
//      break;
//    case VigenereBreakerAlphabet.RUSSIAN:
//      return RussianBigrams();
//      break;
    default:
      return null;
  }
}
