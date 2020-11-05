import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/guballa.de/breaker.dart' as guballa;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/german_bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/english_bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/french_bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/spanish_bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/trigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/german_trigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/english_trigrams.dart';

enum VigenereBreakerType{VIGENERE, AUTOKEYVIGENERE, BEAUFORT}
enum VigenereBreakerAlphabet{ENGLISH, GERMAN, SPANISH, FRENCH}
enum VigenereBreakerErrorCode{OK, KEY_LENGTH, KEY_TOO_LONG, CONSOLIDATE_PARAMETER, TEXT_TOO_SHORT, ALPHABET_TOO_LONG, WRONG_GENERATE_TEXT}

class VigenereBreakerResult {
  final String plaintext;
  final String key;
  final double fitness;
  final String alphabet;
  final VigenereBreakerErrorCode errorCode;

  VigenereBreakerResult({
    this.plaintext = '',
    this.key = '',
    this.fitness = 0.0,
    this.alphabet = '',
    this.errorCode = VigenereBreakerErrorCode.OK
  });
}

const DEFAULT_ALPHABET = "abcdefghijklmnopqrstuvwxyz";

Future<VigenereBreakerResult> break_cipher(String input, VigenereBreakerType vigenereBreakerType, VigenereBreakerAlphabet alphabet, int keyLengthMin, int keyLengthMax) async {
  if (input == null || input == '')
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.OK);

  if (((keyLengthMin < 3) || (keyLengthMin > 1000)) || ((keyLengthMax < 1) || (keyLengthMax > 1000)))
    // key length not in the valid range 3..1000
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.KEY_LENGTH);



  var bigrams = getBigrams(alphabet);
  var trigrams = getTrigrams(alphabet);
  var vigenereSquare = _createVigenereSquare(bigrams.alphabet.length, vigenereBreakerType == VigenereBreakerType.BEAUFORT);
  var cipher_bin = List<int>();
  var resultList = List <guballa.BreakerResult>();
  guballa.BreakerResult best_result = null;
  String out1 = '';
try {
  _iterateText(input, bigrams.alphabet).forEach((char) {cipher_bin.add(char);});

  if (cipher_bin.length < 3)
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.TEXT_TOO_SHORT);

  if ((keyLengthMin > cipher_bin.length) && (keyLengthMax >  cipher_bin.length))
    // Minimum key length must be equal or greater than the length of the ciphertext
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.KEY_TOO_LONG);

  keyLengthMax = min(keyLengthMax, cipher_bin.length);

  for (int keyLength = keyLengthMin; keyLength <= keyLengthMax; keyLength++) {
    var breakerResult = guballa.break_vigenere(cipher_bin, keyLength, vigenereSquare, bigrams.bigrams);
    resultList.add(breakerResult);
    if (best_result == null || breakerResult.fitness > best_result.fitness)
      best_result = breakerResult;

    var key_str = breakerResult.key.map((x) => bigrams.alphabet[x]).join();
    key_str = decryptVigenere(''.padRight(key_str.length, bigrams.alphabet[0]), key_str, false);

    var txt = decryptVigenere(input, key_str, false);
    var fitness = calc_fitnessBigrams(txt, bigrams);
    var fitness1 = calc_fitnessTrigrams(txt, trigrams);

    out1 = out1 + '\n' + fitness.toStringAsFixed(2) + '\t' + fitness1.toStringAsFixed(2) + '\t' +
        key_str  + '\n' +  txt;
  }
  best_result = bestSolution(resultList);
} on Exception
  {
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.WRONG_GENERATE_TEXT);
  };
  var key_str = best_result.key.map((x) => bigrams.alphabet[x]).join();
  key_str = decryptVigenere(''.padRight(key_str.length, bigrams.alphabet[0]), key_str, false);

  //var out = encryptVigenere(input, key_str, false);
  var out = decryptVigenere(input, key_str, false);

  return VigenereBreakerResult(plaintext: out, key: key_str +'\n' + out1, fitness: best_result.fitness, errorCode: VigenereBreakerErrorCode.OK );
}

double calc_fitnessBigrams(String txt, Bigrams bigrams) {
  if (txt == null || txt == '')
    return null;

  if ((bigrams == null) || (bigrams.alphabet == null) || (bigrams.bigrams == null))
    return null;

  var fitness = 0;
  var plain_bin = List<int>();

  _iterateText(txt, bigrams.alphabet).forEach((char) {plain_bin.add(char);});

  if (plain_bin.length < 2)
    // More than two characters from the given alphabet are required
    return null;

  for (var idx = 0; idx < (plain_bin.length - 1); idx++) {
    var ch1 = plain_bin[idx  ];
    var ch2 = plain_bin[idx+1];
    fitness += bigrams.bigrams[ch1][ch2];
  };

  return fitness / (plain_bin.length - 1) / 1000;
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

  _iterateText(txt, trigrams.alphabet).forEach((char) {plain_bin.add(char);});

  if (plain_bin.length < 3)
    // More than two characters from the given alphabet are required
    return null;

  for (var idx = 0; idx < (plain_bin.length - 2); idx++) {
    trigram_val = plain_bin[idx];
    trigram_val = (trigram_val << 5) + plain_bin[idx+1];
    trigram_val = ((trigram_val & 0x3FF) << 5) + plain_bin[idx+2];

    fitness += trigramsList[trigram_val];
  };

  return fitness / (plain_bin.length - 2) / 1000;
}

guballa.BreakerResult bestSolution(List<guballa.BreakerResult> keyList){
  if (keyList == null || keyList.length == 0)
    return null;

  keyList.sort((a, b) => a.fitness.compareTo(b.fitness));
  // var median = _quantile(keyList, 50);
  var lowerQuantile = _quantile(keyList, 25);
  var upperQuantile = _quantile(keyList, 75);
  var quantileDiff = (upperQuantile - lowerQuantile) / 2;
  var antennas = quantileDiff * 3;
  // var lowerAntennas = lowerQuantile - antennas;
  var upperAntennas = upperQuantile + antennas;
  var antennasList = List<guballa.BreakerResult>();

  keyList.forEach((element) {
    if (element.fitness > upperAntennas)
      antennasList.add(element);
  });

  guballa.BreakerResult bestFitness = null;
  if (antennasList.length == 0) {
    keyList.forEach((element) {
      if (bestFitness == null || element.fitness > bestFitness.fitness)
        bestFitness = element;
    });
  } else {
    antennasList.forEach((element) {
      if (bestFitness == null || element.fitness > bestFitness.fitness)
        bestFitness = element;
    });
  }

  return bestFitness;
}

double _quantile(List<guballa.BreakerResult> keyList, int percentage) {
  if (keyList == null || keyList.length == 0)
    return 0;
  if (keyList.length == 1)
    return keyList[0].fitness;

  var position = (keyList.length + 1) * percentage / 100.0;
  var leftNumber = 0.0;
  var rightNumber = 0.0;

  var n = percentage / 100.0 * (keyList.length - 1) + 1;

  if (position >= 1) {
    leftNumber = keyList[n.floor() - 1].fitness;
    rightNumber = keyList[n.floor()].fitness;
  } else {
    leftNumber = keyList[0].fitness; // first data
    rightNumber = keyList[1].fitness; // first data
  }

  if (leftNumber == rightNumber)
    return leftNumber;
  else {
    var part = n - n.floor();
    return leftNumber + part * (rightNumber - leftNumber);
  }
}

List<List<int>> _createVigenereSquare(int size, bool beaufortVariant){
  var vigenereSquare = List<List<int>>(size);
  var rowList = List<int>();

  for (int i = 0; i < vigenereSquare.length; i++) {
    rowList.add(i);
  }

  for (int row = 0; row < vigenereSquare.length; row++) {
    vigenereSquare[row] = rowList;
    rowList = createRowList(rowList);
  }

  if (beaufortVariant)
    vigenereSquare = vigenereSquare.reversed;

  return vigenereSquare;
}

Bigrams getBigrams(VigenereBreakerAlphabet alphabet){
  switch (alphabet) {
    case VigenereBreakerAlphabet.ENGLISH:
      return EnglishBigrams();
      break;
    case VigenereBreakerAlphabet.GERMAN:
      return  GermanBigrams();
      break;
    case VigenereBreakerAlphabet.SPANISH:
      return SpanishBigrams();
//      break;
//    case VigenereBreakerAlphabet.POLISH:
//      return PolishBigrams();
//      break;
//    case VigenereBreakerAlphabet.GREEK:
//      return GreekQuadgrams();
//      break;
    case VigenereBreakerAlphabet.FRENCH:
      return FrenchBigrams();
//      break;
//    case VigenereBreakerAlphabet.RUSSIAN:
//      return RussianBigrams();
//      break;
    default:
      return null;
  }
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

List<int> createRowList(List<int> sourceList) {
  var rowList = List<int>();
  rowList.addAll(sourceList.getRange(1, sourceList.length));
  rowList.add(sourceList[0]);

  return rowList;
}

Iterable<int> _iterateText(String text, String alphabet) sync* {
  var trans = alphabet.toLowerCase();
  int index = -1;

  text = text.toLowerCase();
  for (int i = 0; i < text.length; i++) {
    index = trans.indexOf(text[i]);
    if (index >= 0)
      yield index;
  }
}

