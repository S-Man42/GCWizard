import 'package:tuple/tuple.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/guballa.de/breaker.dart' as guballa;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/german_bigrams.dart';

enum VigenereBreakerType{VIGENERE, AUTOKEYVIGENERE, BEAUFORT}
enum VigenereBreakerAlphabet{ENGLISH, GERMAN}
enum VigenereBreakerErrorCode{OK, KEY_LENGTH, CONSOLIDATE_PARAMETER, TEXT_TOO_SHORT, ALPHABET_TOO_LONG, WRONG_GENERATE_TEXT}

class VigenereBreakerResult {
  final String ciphertext;
  final String plaintext;
  final String key;
  final String alphabet;
  final VigenereBreakerErrorCode errorCode;

  VigenereBreakerResult({
    this.ciphertext = '',
    this.plaintext = '',
    this.key = '',
    this.alphabet = '',
    this.errorCode = VigenereBreakerErrorCode.OK
  });
}

Future<VigenereBreakerResult> break_cipher(String input, VigenereBreakerType vigenereBreakerType, VigenereBreakerAlphabet alphabet, int keyLengthMin, int keyLengthMax) async {
  if (input == null || input == '')
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.OK);

  if (((keyLengthMin < 1) || (keyLengthMin > 1000)) || ((keyLengthMax < 1) || (keyLengthMax > 1000)))
    // key length not in the valid range 1..1000"
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.KEY_LENGTH);

  var vigenereSquare = _createVigenereSquare(vigenereBreakerType == VigenereBreakerType.BEAUFORT);
  var bigrams = getBigrams(alphabet);
  var cipher_bin = List<int>();
  VigenereBreakerResult bestResult =null;
  VigenereBreakerResult currentResult = null;
  guballa.BreakerResult best_result = null;

  _iterateText(input, bigrams.alphabet).forEach((char) {cipher_bin.add(char);});

  String out ='';
  for (int keyLength = keyLengthMin; keyLength <= keyLengthMax; keyLength++) {
    var breakerResult = guballa.break_vigenere(cipher_bin, keyLength, vigenereSquare, bigrams.bigrams);
    if (best_result == null || breakerResult.fitness > best_result.fitness)
      best_result = breakerResult;

    out = out + '\n' + breakerResult.fitness.toString() + ' ' +  breakerResult.key.map((x) => bigrams.alphabet[x]).join()  ;
  }

  var key_str = best_result.key.map((x) => bigrams.alphabet[x]).join();

  return VigenereBreakerResult(plaintext: key_str, key: out, errorCode: VigenereBreakerErrorCode.OK );
}


List<List<int>> _createVigenereSquare(bool beaufortVariant){
  var vigenereSquare = List<List<int>>(26);
  var rowList = List<int>();

  for (int i = 0; i < vigenereSquare.length; i++) {
    rowList.add(i);
  }

  if (beaufortVariant) {
    for (int row = vigenereSquare.length - 1; row >= 0 ; row--) {
      vigenereSquare[row] = rowList;
      rowList= createRowList(rowList);
    }
  } else {
    for (int row = 0; row < vigenereSquare.length; row++) {
      vigenereSquare[row] = rowList;
      rowList = createRowList(rowList);
    }
  }
  return vigenereSquare;
}

Bigrams getBigrams(VigenereBreakerAlphabet alphabet){
  switch (alphabet) {
//    case SubstitutionBreakerAlphabet.ENGLISH:
//      return EnglishBigrams();
//      break;
    case VigenereBreakerAlphabet.GERMAN:
      return  GermanBigrams();
      break;
//    case SubstitutionBreakerAlphabet.SPANISH:
//      return SpanishQuadgrams();
//      break;
//    case SubstitutionBreakerAlphabet.POLISH:
//      return PolishQuadgrams();
//      break;
//    case SubstitutionBreakerAlphabet.GREEK:
//      return GreekQuadgrams();
//      break;
//    case SubstitutionBreakerAlphabet.FRENCH:
//      return FrenchQuadgrams();
//      break;
//    case SubstitutionBreakerAlphabet.RUSSIAN:
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

