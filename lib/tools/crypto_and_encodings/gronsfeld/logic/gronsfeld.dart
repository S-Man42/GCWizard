import 'package:gc_wizard/tools/crypto_and_encodings/vigenere/logic/vigenere.dart';
import 'package:gc_wizard/utils/logic_utils/common_utils.dart';

String encryptGronsfeld(String input, String key, bool autoKey, {int aValue = 0}) {
  if (input == null) return '';

  key = digitsToAlpha(key);

  return encryptVigenere(input, key, autoKey, aValue: aValue);
}

String decryptGronsfeld(String input, String key, bool autoKey, {int aValue: 0}) {
  if (input == null) return '';

  key = digitsToAlpha(key);

  return decryptVigenere(input, key, autoKey, aValue: aValue);
}
