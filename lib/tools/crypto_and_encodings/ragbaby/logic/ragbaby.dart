import 'package:gc_wizard/tools/crypto_and_encodings/rotation/logic/rotation.dart';
import 'package:gc_wizard/utils/alphabets.dart';

//
// More under
// https://www.cwu.edu/academics/math/_documents/kryptos-challenges/cwu-kryptos-rag-baby-cipher.pdf

enum RagbabyType { NoJX, AZ, AZ09 }

const Map<RagbabyType, String> RAGBABY_OPTIONS = {
  RagbabyType.NoJX: 'ragbaby_option_24',
  RagbabyType.AZ: 'ragbaby_option_26',
  RagbabyType.AZ09: 'ragbaby_option_36',
};

String _translatePasswordIntoKeyAlphabet(String password, {RagbabyType type = RagbabyType.NoJX}) {

  String keyAlphabet;
  if (type == RagbabyType.NoJX) {
    keyAlphabet = alphabet_AZString.replaceAll('J', '').replaceAll('X', '');
  } else if (type == RagbabyType.AZ09) {
    keyAlphabet = alphabet_AZString + "0123456789";
  } else {
    keyAlphabet = alphabet_AZString;
  }

  if (password.isEmpty) return keyAlphabet;

  List<String> cleanedPassword = password.toUpperCase().split('');
  String newAlphabet = '';

  for (var letter in cleanedPassword) {
    if (keyAlphabet.contains(letter)) {
      newAlphabet += letter;
      keyAlphabet = keyAlphabet.replaceAll(letter, '');
    }
  }
  return newAlphabet + keyAlphabet;
}

String encryptRagbaby(String input, String password, {RagbabyType type = RagbabyType.NoJX}) {
  String keyAlphabet = _translatePasswordIntoKeyAlphabet(password, type: type);
  var rotator = Rotator(alphabet: keyAlphabet);

  if (input.isEmpty) return '';

  String cleanedInput = input;

  if (type == RagbabyType.NoJX)  {
    cleanedInput = cleanedInput
        .replaceAll('X', 'U').replaceAll('J', 'I')
        .replaceAll('x', 'u').replaceAll('j', 'i');
  }

  List<String> words = cleanedInput.split(RegExp('\\s+|[\\n\\r]+'));
  List<String> encryptedText = [];

  for (int wordIndex = 0; wordIndex < words.length; wordIndex++) {
    String word = words[wordIndex];
    String encryptedWord = '';

    for (int letterIndex = 0; letterIndex < word.length; letterIndex++) {
      int rotation = wordIndex + letterIndex + 1;
      encryptedWord += rotator.rotate(word[letterIndex], rotation);
    }
    encryptedText.add(encryptedWord);
  }
  return encryptedText.join(' ');
}

String decryptRagbaby(String input, String password, {RagbabyType type = RagbabyType.NoJX}) {

  String key = _translatePasswordIntoKeyAlphabet(password,type: type);
  var rotator = Rotator(alphabet: key);

  if (input.isEmpty) return '';

  List<String> words = input.split(RegExp('\\s+|[\\n\\r]+'));
  List<String> decryptedText = [];

  for (int wordIndex = 0; wordIndex < words.length; wordIndex++) {
    String decryptedWord = '';
    String word = words[wordIndex];

    for (int letterIndex = 0; letterIndex < word.length; letterIndex++) {
      int rotation = -(wordIndex + letterIndex + 1);
      decryptedWord += rotator.rotate(word[letterIndex], rotation);
    }
    decryptedText.add(decryptedWord);
  }
  return decryptedText.join(' ');
}
