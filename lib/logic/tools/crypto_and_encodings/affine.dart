import 'package:gc_wizard/utils/common_utils.dart';

// https://de.wikipedia.org/wiki/Affine_Chiffre
// https://en.wikipedia.org/wiki/Affine_cipher

final AZToAffineDigit = {'A' : 00, 'B' : 1, 'C' : 2, 'D' : 3, 'E' : 4, 'F' : 5,
                         'G' : 6, 'H' : 7, 'I' : 8, 'J' : 9, 'K' : 10, 'L' : 11,
                         'M' : 12, 'N' : 13, 'O' : 14, 'P' : 15, 'Q' : 16, 'R' : 17,
                         'S' : 18, 'T' : 19, 'U' : 20, 'V' : 21, 'W' : 22, 'X' : 23, 'Y' : 24, 'Z' : 25};
final AffineDigitToAZ = switchMapKeyValue(AZToAffineDigit);


String encodeAffine(String input, int keyA, int keyB) {
  if (input == null || input == '')
    return '';

  int affinePlain = 0;
  String affineCipher = '';

  return input
      .toUpperCase()
      .split('')
      .map((character) {
        if (character == ' ')
          return ' ';

        affinePlain = AZToAffineDigit[character];
        affinePlain = (keyA * affinePlain + keyB) % 26;

        affineCipher = AffineDigitToAZ[affinePlain];
        return affineCipher != null ? affineCipher : '';
      })
      .join();
}


String decodeAffine(String input, int keyA, int keyB) {
  if (input == null || input == '')
    return '';

  return input
      .split(RegExp(r'[^ABCDEFGHIJKLMNOPQRSTUVWXYZ\.\-/\|]'))
      .map((letter) {
        if (letter == '|' || letter == '/')
        return ' ';

        var character = AffineDigitToAZ[letter];
        return character != null ? character : '';
      })
      .join();
}

