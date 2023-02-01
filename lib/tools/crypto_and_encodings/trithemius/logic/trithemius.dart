import 'package:gc_wizard/common/alphabets.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/vigenere/logic/vigenere.dart';

final trithemiusKey = alphabet_AZ.entries.map((entry) => entry.key).join();

String encryptTrithemius(String input, {int aValue = 0}) {
  return encryptVigenere(input, trithemiusKey, false, aValue: aValue);
}

String decryptTrithemius(String input, {int aValue: 0}) {
  return decryptVigenere(input, trithemiusKey, false, aValue: aValue);
}
