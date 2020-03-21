import 'package:gc_wizard/logic/tools/crypto/vigenere.dart';

String encryptTrithemius(String input, {int aValue = 0}) {
    return vigenereEncrypt(input, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", false, aValue: aValue);
}

String decryptTrithemius(String input, {int aValue: 0}) {
    return vigenereDecrypt(input, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", false, aValue: aValue);
}