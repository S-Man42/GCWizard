
import 'package:gc_wizard/tools/science_and_technology/spelling_alphabets/_common/spelling_alphabets_data.dart';

String encodeSpellingAlphabets(String plain, SPELLING language) {
  List<String> result = [];
  Map<String, String> alphabet = SPELLING_ALPHABETS[language]!;

  plain.toUpperCase().split('').forEach((letter){
    if (alphabet[letter] != null) {
      result.add(alphabet[letter]!.toUpperCase());
    } else {
      result.add(' ');
    }
  });
  return result.join(' ');
}

String decodeSpellingAlphabets(String chiffre, SPELLING language) {
  List<String> result = [];
  Map<String, String> alphabet = {};

  SPELLING_ALPHABETS[language]!.forEach((key, value) {
    alphabet[value.toUpperCase()] = key;
  });

  chiffre.toUpperCase().split(' ').forEach((word){
    if (alphabet[word] == null) {
      result.add(' ');
    } else {
      result.add(alphabet[word]!);
    }
  });
  return result.join('');
}