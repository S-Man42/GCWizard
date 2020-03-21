import 'package:gc_wizard/logic/tools/crypto/vigenere.dart';
import 'package:gc_wizard/utils/alphabets.dart';

final trithemiusKey = alphabet_AZ.entries.map((entry) => entry.key).join();

String encryptTrithemius(String input, {int aValue = 0}) {
  return vigenereEncrypt(input, trithemiusKey, false, aValue: aValue);
}

String decryptTrithemius(String input, {int aValue: 0}) {
  return vigenereDecrypt(input, trithemiusKey, false, aValue: aValue);
}