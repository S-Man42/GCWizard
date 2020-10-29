import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/guballa.de/breaker.dart' as guballa;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/german_bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/english_bigrams.dart';

enum VigenereBreakerType{VIGENERE, AUTOKEYVIGENERE, BEAUFORT}
enum VigenereBreakerAlphabet{ENGLISH, GERMAN}
enum VigenereBreakerErrorCode{OK, KEY_LENGTH, CONSOLIDATE_PARAMETER, TEXT_TOO_SHORT, ALPHABET_TOO_LONG, WRONG_GENERATE_TEXT}

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

Future<VigenereBreakerResult> break_cipher(String input, VigenereBreakerType vigenereBreakerType, VigenereBreakerAlphabet alphabet, int keyLengthMin, int keyLengthMax) async {
  if (input == null || input == '')
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.OK);

  if (((keyLengthMin < 3) || (keyLengthMin > 1000)) || ((keyLengthMax < 1) || (keyLengthMax > 1000)))
    // key length not in the valid range 3..1000"
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.KEY_LENGTH);

  var bigrams = getBigrams(alphabet);
  var vigenereSquare = _createVigenereSquare(bigrams.alphabet.length, vigenereBreakerType == VigenereBreakerType.BEAUFORT);
  var cipher_bin = List<int>();
  var resultList = List <guballa.BreakerResult>();
  guballa.BreakerResult best_result = null;
  String out1 = '';
try {
  _iterateText(input, bigrams.alphabet).forEach((char) {cipher_bin.add(char);});
  keyLengthMax = min(keyLengthMax, cipher_bin.length);

  if (cipher_bin.length < 3)
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.TEXT_TOO_SHORT);

  for (int keyLength = keyLengthMin; keyLength <= keyLengthMax; keyLength++) {
    var breakerResult = guballa.break_vigenere(cipher_bin, keyLength, vigenereSquare, bigrams.bigrams);
    resultList.add(breakerResult);
    if (best_result == null || breakerResult.fitness > best_result.fitness)
      best_result = breakerResult;

    out1 = out1 + '\n' + breakerResult.fitness.toString() + ' ' +
        breakerResult.key.map((x) => bigrams.alphabet[x]).join();
  }
  best_result = bestSolution(resultList);
} on Exception
  {
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.WRONG_GENERATE_TEXT);
  };
  var key_str = best_result.key.map((x) => bigrams.alphabet[x]).join();

  var out = encryptVigenere(input, key_str, false);

  return VigenereBreakerResult(plaintext: out, key: key_str +'\n' + out1, fitness: best_result.fitness, errorCode: VigenereBreakerErrorCode.OK );
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
//    case VigenereBreakerAlphabet.SPANISH:
//      return SpanishQuadgrams();
//      break;
//    case VigenereBreakerAlphabet.POLISH:
//      return PolishQuadgrams();
//      break;
//    case VigenereBreakerAlphabet.GREEK:
//      return GreekQuadgrams();
//      break;
//    case VigenereBreakerAlphabet.FRENCH:
//      return FrenchQuadgrams();
//      break;
//    case VigenereBreakerAlphabet.RUSSIAN:
//      return RussianQuadgrams();
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

