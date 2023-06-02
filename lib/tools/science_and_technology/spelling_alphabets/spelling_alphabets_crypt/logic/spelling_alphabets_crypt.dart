// https://www.geocaching.com/geocache/GC9R4YE_barossa-121

import 'package:gc_wizard/tools/science_and_technology/spelling_alphabets/_common/spelling_alphabets_data.dart';
import 'package:gc_wizard/utils/constants.dart';

String encodeSpellingAlphabets(String plain, SPELLING language) {
  List<String> result = [];
  Map<String, String> alphabet = SPELLING_ALPHABETS[language]!;

  if (plain.isEmpty) return '';

  plain.toUpperCase().split('').forEach((letter){
    if (letter == ' ') {
      result.add(' ');
    } else {
      if (alphabet[letter] != null) {
      result.add(alphabet[letter]!.toUpperCase());
    } else {
      result.add(UNKNOWN_ELEMENT);
    }
    }
  });
  return result.join(' ');
}

String decodeSpellingAlphabets(String chiffre, SPELLING language) {
  List<String> result = [];
  Map<String, String> alphabet = {};

  if (chiffre.isEmpty) return '';

  SPELLING_ALPHABETS[language]!.forEach((key, value) {
    alphabet[value.toUpperCase()] = key;
  });

  chiffre.toUpperCase().split(' ').forEach((word){
    if (word == ' ' || word == '') {
      result.add(' ');
    }
    else if (alphabet[word] == null) {
      result.add(UNKNOWN_ELEMENT);
    } else {
      result.add(alphabet[word]!);
    }
  });
  return result.join('');
}