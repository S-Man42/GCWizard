import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/guballa.de/breaker.dart' as guballa;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/guballa.de/generate_quadgrams.dart';

import 'dart:math';

enum SubstitutionBreakerAlphabet{ENGLISH, GERMAN, SPANISH, POLISH, GREEK, FRENCH, RUSSIAN}
enum SubstitutionBreakerErrorCode{OK, MAX_ROUNDS_PARAMETER, CONSOLIDATE_PARAMETER, TEXT_TOO_SHORT, ALPHABET_TOO_LONG, WRONG_GENERATE_TEXT}

class SubstitutionBreakerResult {
  final String ciphertext;
  final String plaintext;
  final String key;
  final String alphabet;
  final SubstitutionBreakerErrorCode errorCode;

  SubstitutionBreakerResult({
    this.ciphertext = '',
    this.plaintext = '',
    this.key = '',
    this.alphabet = '',
    this.errorCode = SubstitutionBreakerErrorCode.OK
  });
}

Future<SubstitutionBreakerResult> break_cipher(String input, Quadgrams quadgrams) async {
  if (input == null || input == '')
    return SubstitutionBreakerResult(errorCode: SubstitutionBreakerErrorCode.OK);

  var res = guballa.break_cipher(quadgrams, input);
  var f = calc_fitness(res.plaintext, quadgrams: quadgrams.quadgrams());
  print("f1: " + f.toString() + " f2: " + res.fitness.toString());

  var minV = 1000000;
  var maxV = 0;
  quadgrams.quadgrams().forEach((element) {
    minV = min(minV, element);
    maxV = max(maxV, element);
  });

  return _convertBreakerResult(guballa.break_cipher(quadgrams, input));
}

SubstitutionBreakerResult _convertBreakerResult(guballa.BreakerResult breakerResult) {
  SubstitutionBreakerErrorCode errorCode;
  switch (breakerResult.errorCode) {
    case guballa.ErrorCode.OK: errorCode = SubstitutionBreakerErrorCode.OK; break;
    case guballa.ErrorCode.MAX_ROUNDS_PARAMETER: errorCode = SubstitutionBreakerErrorCode.MAX_ROUNDS_PARAMETER; break;
    case guballa.ErrorCode.CONSOLIDATE_PARAMETER: errorCode = SubstitutionBreakerErrorCode.CONSOLIDATE_PARAMETER; break;
    case guballa.ErrorCode.TEXT_TOO_SHORT: errorCode = SubstitutionBreakerErrorCode.TEXT_TOO_SHORT; break;
    case guballa.ErrorCode.ALPHABET_TOO_LONG: errorCode = SubstitutionBreakerErrorCode.ALPHABET_TOO_LONG; break;
    case guballa.ErrorCode.WRONG_GENERATE_TEXT: errorCode = SubstitutionBreakerErrorCode.WRONG_GENERATE_TEXT; break;
  }

  return SubstitutionBreakerResult(
    ciphertext: breakerResult.ciphertext,
    plaintext: breakerResult.plaintext,
    key: breakerResult.key,
    alphabet: breakerResult.alphabet,
    errorCode: errorCode,
  );
}

