import 'package:gc_wizard/utils/common_utils.dart';

// https://de.wikipedia.org/wiki/Affine_Chiffre
// https://en.wikipedia.org/wiki/Affine_cipher

final AZToAffineDigit = {
  'A': 0,
  'B': 1,
  'C': 2,
  'D': 3,
  'E': 4,
  'F': 5,
  'G': 6,
  'H': 7,
  'I': 8,
  'J': 9,
  'K': 10,
  'L': 11,
  'M': 12,
  'N': 13,
  'O': 14,
  'P': 15,
  'Q': 16,
  'R': 17,
  'S': 18,
  'T': 19,
  'U': 20,
  'V': 21,
  'W': 22,
  'X': 23,
  'Y': 24,
  'Z': 25
};
final AffineDigitToAZ = switchMapKeyValue(AZToAffineDigit);

final reverseKeyA = {1: 1, 3: 9, 5: 21, 7: 15, 9: 3, 11: 19, 15: 7, 17: 23, 19: 11, 21: 5, 23: 17, 25: 25};

String encodeAffine(String input, int keyA, int keyB) {
  int affinePlain = 0;
  String affineCipher = '';

  if (input == null || input == '') return '';

  return input.toUpperCase().split('').map((character) {
    if (character == ' ') return ' ';

    affinePlain = AZToAffineDigit[character];
    if (affinePlain == null) return '';

    affinePlain = (keyA * affinePlain + keyB) % 26;

    affineCipher = AffineDigitToAZ[affinePlain];
    return affineCipher != null ? affineCipher : '';
  }).join();
}

String decodeAffine(String input, int keyA, int keyB) {
  if (input == null || input == '') return '';

  int affineCipher = 0;
  String affinePlain = '';

  return input.toUpperCase().split('').map((character) {
    if (character == ' ') return ' ';

    affineCipher = AZToAffineDigit[character];
    affineCipher = reverseKeyA[keyA] * (affineCipher - keyB) % 26;

    affinePlain = AffineDigitToAZ[affineCipher];
    return affinePlain != null ? affinePlain : '';
  }).join();
}
