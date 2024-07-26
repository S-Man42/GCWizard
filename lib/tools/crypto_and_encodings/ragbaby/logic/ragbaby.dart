import 'package:gc_wizard/tools/crypto_and_encodings/rotation/logic/rotation.dart';
import 'package:gc_wizard/utils/alphabets.dart';

// More under
// https://www.cwu.edu/academics/math/_documents/kryptos-challenges/cwu-kryptos-rag-baby-cipher.pdf

/// Ragbaby Types:
/// ## Options:
/// [NoJX] : (default) 24 letters alphabet: J becomes I and X becomes W
///
/// [AZ]   : 26 letters alphabet: A-Z
///
/// [AZ09] : 36 letters alphabet with numbers: A-Z + 0-9
enum RagbabyType { NoJX, AZ, AZ09 }

const Map<RagbabyType, String> RAGBABY_OPTIONS = {
  RagbabyType.NoJX: 'ragbaby_option_24',
  RagbabyType.AZ: 'ragbaby_option_26',
  RagbabyType.AZ09: 'ragbaby_option_36',
};

/// Returns the secret alphabet:
///
/// The [password] starts the secret alphabet.
/// All remaining characters are added at the end.
/// Every letter of the secret alphabet is unique.
String createSecretAlphabet(String password,
    {RagbabyType type = RagbabyType.NoJX}) {
  String keyAlphabet;
  if (type == RagbabyType.NoJX) {
    keyAlphabet = alphabet_AZString.replaceAll(RegExp('[JX]'), '');
  } else if (type == RagbabyType.AZ09) {
    keyAlphabet = alphabet_AZString + "0123456789";
  } else {
    keyAlphabet = alphabet_AZString;
  }

  if (password.isEmpty) return keyAlphabet;

  List<String> cleanedPassword = password.toUpperCase().split('');
  var newAlphabet = '';

  for (var letter in cleanedPassword) {
    if (keyAlphabet.contains(letter)) {
      newAlphabet += letter;
      keyAlphabet = keyAlphabet.replaceAll(letter, '');
    }
  }
  return newAlphabet + keyAlphabet;
}

/// Encrypts [plainText] with [password] using Ragbaby algorithm
///
/// For more info: https://www.cwu.edu/academics/math/_documents/kryptos-challenges/cwu-kryptos-rag-baby-cipher.pdf
/// and https://youngtyros.com/2023/02/19/ragbaby-cipher/
/// and https://www.dcode.fr/ragbaby-cipher
String encryptRagbaby(String plainText, String password,
    {RagbabyType type = RagbabyType.NoJX}) {
  if (plainText.isEmpty) return '';

  var alphabet = createSecretAlphabet(password, type: type);
  var rotator = Rotator(alphabet: alphabet);
  var cleanedInput = _sanitizeInput(plainText, type);

  final List<String> words = cleanedInput.split(RegExp('\\s+|[\\n\\r]+'));
  List<String> encryptedText = [];

  for (int wordIndex = 0; wordIndex < words.length; wordIndex++) {
    String encryptedWord = '';
    String word = words[wordIndex];
    int corrector = 0;

    for (int letterIndex = 0; letterIndex < word.length; letterIndex++) {
      if (!alphabet.contains(word[letterIndex].toUpperCase())) {corrector++;}

      int rotation = wordIndex + letterIndex + 1 - corrector;
      encryptedWord += rotator.rotate(word[letterIndex], rotation);
    }
    encryptedText.add(encryptedWord);
  }
  return encryptedText.join(' ');
}

/// Decrypts [cipherText] with [password] using Ragbaby algorithm
///
/// For more info: https://www.cwu.edu/academics/math/_documents/kryptos-challenges/cwu-kryptos-rag-baby-cipher.pdf
/// and https://youngtyros.com/2023/02/19/ragbaby-cipher/
/// and https://www.dcode.fr/ragbaby-cipher
String decryptRagbaby(String cipherText, String password,
    {RagbabyType type = RagbabyType.NoJX}) {
  if (cipherText.isEmpty) return '';

  var alphabet = createSecretAlphabet(password, type: type);
  var rotator = Rotator(alphabet: alphabet);
  var cleanedInput = _sanitizeInput(cipherText, type);

  final List<String> words = cleanedInput.split(RegExp('\\s+|[\\n\\r]+'));
  List<String> decryptedText = [];

  for (int wordIndex = 0; wordIndex < words.length; wordIndex++) {
    String decryptedWord = '';
    String word = words[wordIndex];
    int corrector = 0;

    for (int letterIndex = 0; letterIndex < word.length; letterIndex++) {
      if (!alphabet.contains(word[letterIndex].toUpperCase())) {corrector++;}

      int rotation = -(wordIndex + letterIndex + 1) + corrector;
      decryptedWord += rotator.rotate(word[letterIndex], rotation);
    }
    decryptedText.add(decryptedWord);
  }
  return decryptedText.join(' ');
}

String _sanitizeInput(String text, RagbabyType type) {
  String output = text;
  if (type == RagbabyType.NoJX) {
    output = text
        .replaceAll('X', 'W')
        .replaceAll('J', 'I')
        .replaceAll('x', 'w')
        .replaceAll('j', 'i');
  }
  return output;
}