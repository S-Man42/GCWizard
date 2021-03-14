import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';

String encryptKamasutra(String input, String alphabet, {bool ignoreCase = true}) {
  if (input == null || input.length == 0) return '';

  if (alphabet == null) return input;

  if (alphabet.length % 2 == 1) alphabet = alphabet.substring(0, alphabet.length - 1);

  if (alphabet.length == 0) return input;

  return Rotator(alphabet: alphabet)
      .rotate(input, (alphabet.length / 2).floor(), removeUnknownCharacters: false, ignoreCase: ignoreCase);
}
