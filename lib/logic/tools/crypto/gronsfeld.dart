import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/logic/tools/crypto/vigenere.dart';

String encryptGronsfeld(String input, String key, bool autoKey, {int aValue = 0}) {
  if (input == null)
    return '';
  
  key = digitsToAlpha(key);
  
  return vigenereEncrypt(input, key, autoKey, aValue: aValue);
}

String decryptGronsfeld(String input, String key, bool autoKey, {int aValue: 0}) {
  if (input == null)
    return '';
  
  key = digitsToAlpha(key);
  
  return vigenereDecrypt(input, key, autoKey, aValue: aValue);
}