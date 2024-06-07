import 'package:gc_wizard/utils/alphabets.dart';

//
// More under
// https://www.cwu.edu/academics/math/_documents/kryptos-challenges/cwu-kryptos-rag-baby-cipher.pdf


String translatePasswordIntoKey(String input) {
  List<String> alphabet = alphabet_AZString.split('');
  alphabet.remove('J');
  alphabet.remove('X');

  if (input.isEmpty) return alphabet.join();

  String cleanedInput = input.toUpperCase();
  String newAlphabet = '';

  for (int i = 0; i < cleanedInput.length; i++) {
    String letter = cleanedInput[i];
    if (alphabet.contains(letter)) {
      newAlphabet += letter;
      alphabet.remove(letter);
    }
  }
  return newAlphabet + alphabet.join();
}

String encryptRagbaby(String input, String password) {
  if (input.isEmpty) return '';

  String key = translatePasswordIntoKey(password);
  List<String> cleanedText =
      input.toUpperCase().replaceAll('X', 'U').replaceAll('J', 'I').split(' ');
  List<String> encryptedText = [];

  for (int wIndex = 0; wIndex < cleanedText.length; wIndex++) {
    String word = cleanedText[wIndex];
    String encryptedWord = '';
    for (int lIndex = 0; lIndex < word.length; lIndex++) {
      String letter = word[lIndex];
      if (key.contains(letter)) {
        int index = (key.indexOf(letter) + lIndex + wIndex + 1) % 24;
        encryptedWord += key[index];
      } else {
        encryptedWord += letter; // letters not in key
      }
    }
    encryptedText.add(encryptedWord);
  }

  return encryptedText.join(' ');
}

String decryptRagbaby(String input, String password) {
  if (input.isEmpty) return '';

  String key = translatePasswordIntoKey(password);
  List<String> cleanedText =
      input.toUpperCase().replaceAll('X', 'U').replaceAll('J', 'I').split(' ');
  List<String> words = cleanedText;
  List<String> decryptedText = [];

  for (int wIndex = 0; wIndex < words.length; wIndex++) {
    String word = words[wIndex];
    String decryptedWord = '';
    for (int lIndex = 0; lIndex < word.length; lIndex++) {
      String letter = word[lIndex];
      if (key.contains(letter)) {
        int index = (key.indexOf(letter) - wIndex - lIndex - 1) % 24;
        if (index < 0) index += 24;
        decryptedWord += key[index];
      } else {
        decryptedWord += letter; // letters not in key
      }
    }
    decryptedText.add(decryptedWord);
  }

  return decryptedText.join(' ');
}
