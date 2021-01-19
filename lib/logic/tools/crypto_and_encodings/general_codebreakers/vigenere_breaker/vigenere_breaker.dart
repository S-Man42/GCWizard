import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/guballa.de/breaker.dart' as guballa;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/guballa.de/breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/bigrams/bigrams.dart';

enum VigenereBreakerType{VIGENERE, AUTOKEYVIGENERE, BEAUFORT}
enum VigenereBreakerAlphabet{ENGLISH, GERMAN, SPANISH, FRENCH}
enum VigenereBreakerErrorCode{OK, KEY_LENGTH, KEY_TOO_LONG, CONSOLIDATE_PARAMETER, TEXT_TOO_SHORT, ALPHABET_TOO_LONG, WRONG_GENERATE_TEXT}

class VigenereBreakerJobData {
  final String input;
  final VigenereBreakerType vigenereBreakerType;
  final VigenereBreakerAlphabet alphabet;
  final int keyLengthMin;
  final int keyLengthMax;

  VigenereBreakerJobData({
      this.input = '',
      this.vigenereBreakerType = null,
      this.alphabet = null,
      this.keyLengthMin = 0,
      this.keyLengthMax = 0
  });
}

class VigenereBreakerResult {
  String plaintext;
  String key;
  double fitness;
  double fitnessFiltered;
  String alphabet;
  VigenereBreakerErrorCode errorCode;

  VigenereBreakerResult({
    this.plaintext = '',
    this.key = '',
    this.fitness = 0.0,
    this.fitnessFiltered = 0.0,
    this.alphabet = '',
    this.errorCode = VigenereBreakerErrorCode.OK
  });
}

const DEFAULT_ALPHABET = "abcdefghijklmnopqrstuvwxyz";

void break_cipherAsync(dynamic jobData) async {
  if (jobData.parameters == null) {
    jobData.sendAsyncPort.send(null);
    return;
  }

  var output = break_cipher(
      jobData.parameters.input,
      jobData.parameters.vigenereBreakerType,
      jobData.parameters.alphabet,
      jobData.parameters.keyLengthMin,
      jobData.parameters.keyLengthMax
  );

  jobData.sendAsyncPort.send(output);
}

VigenereBreakerResult break_cipher(String input, VigenereBreakerType vigenereBreakerType, VigenereBreakerAlphabet alphabet, int keyLengthMin, int keyLengthMax) {
  if (input == null || input == '')
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.OK);

  if (((keyLengthMin < 3) || (keyLengthMin > 1000)) || ((keyLengthMax < 3) || (keyLengthMax > 1000)))
    // key length not in the valid range 3..1000
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.KEY_LENGTH);

  var bigrams = getBigrams(alphabet);

  var vigenereSquare = _createVigenereEncodeSquare(bigrams.alphabet.length, vigenereBreakerType == VigenereBreakerType.BEAUFORT);
  var cipher_bin = <int>[];
  var resultList = List <VigenereBreakerResult>();
  VigenereBreakerResult best_result = null;

  iterateText(input, bigrams.alphabet).forEach((char) {cipher_bin.add(char);});

  if (cipher_bin.length < 3)
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.TEXT_TOO_SHORT);

  if ((keyLengthMin > cipher_bin.length) && (keyLengthMax >  cipher_bin.length))
    // Minimum key length must be equal or greater than the length of the ciphertext
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.KEY_TOO_LONG);

  keyLengthMax = min(keyLengthMax, cipher_bin.length);

  for (int keyLength = keyLengthMin; keyLength <= keyLengthMax; keyLength++) {
    var breakerResult = guballa.break_vigenere(cipher_bin, keyLength, vigenereSquare, bigrams.bigrams, vigenereBreakerType == VigenereBreakerType.AUTOKEYVIGENERE);
    var result = VigenereBreakerResult();

    resultList.add(result);

    result.key = breakerResult.key.map((x) => bigrams.alphabet[x].toUpperCase()).join();

    result.plaintext = decryptVigenere(input, result.key, vigenereBreakerType == VigenereBreakerType.AUTOKEYVIGENERE, ignoreNonLetters: true);
    result.fitness = calc_fitnessBigrams(result.plaintext, bigrams);
  }
  best_result = _bestSolution(resultList);

  return VigenereBreakerResult(plaintext: best_result.plaintext, key: best_result.key, fitness: best_result.fitness, errorCode: VigenereBreakerErrorCode.OK );
}

VigenereBreakerResult _bestSolution(List<VigenereBreakerResult> keyList){
  if (keyList == null || keyList.length == 0)
    return null;

  keyList = _highPassFilter (2, keyList);
  var bestFitness = keyList[0];
  for (var i = 1; i < keyList.length; ++i)
    if (bestFitness.fitnessFiltered < keyList[i].fitnessFiltered)
      bestFitness = keyList[i];

  return bestFitness;
}


/// HighPass Filter
List<VigenereBreakerResult> _highPassFilter( double alpha, List<VigenereBreakerResult> keyList) {

  for (var i = 0; i < keyList.length; ++i)
    keyList[i].fitnessFiltered = alpha * keyList[i].fitness - (i > 0 ? keyList[i - 1].fitness : keyList[i].fitness) -  (i < keyList.length-1 ? keyList[i + 1].fitness : keyList[i].fitness);

  return keyList;
}


List<List<int>> _createVigenereEncodeSquare(int size, bool beaufortVariant){
  var vigenereSquare = List.generate(size, (index) => <int>[]);

  if (beaufortVariant) {
    for (int row = 0; row < vigenereSquare.length; row++) {
      vigenereSquare[row] = List.generate(vigenereSquare.length, (index) => (index - row) % vigenereSquare.length);;
    }
  } else {
    for (int row = 0; row < vigenereSquare.length; row++) {
      vigenereSquare[row] = List.generate(vigenereSquare.length, (index) => (vigenereSquare.length - index + row) % vigenereSquare.length);;
    }
  }

  return vigenereSquare;
}


