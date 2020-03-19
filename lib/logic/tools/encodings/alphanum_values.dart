import 'package:gc_wizard/utils/alphabets.dart';

import '../../../utils/constants.dart';

class AlphabetValues {
  final Map<String, int> alphabet;

  AlphabetValues({this.alphabet: alphabet_AZ});

  List<int> textToValues(String text,{bool keepNumbers: false}) {
    text = text.toUpperCase();
    return text.split('').map((character) {
      if (keepNumbers && '0123456789'.contains(character))
        return int.tryParse(character);

      return alphabet[character];
    }).toList();
  }

  String valuesToText(List<int> values) {
    return values.map((value) {
      var character = alphabet_AZIndexes[value];
      return character == null ? unknownElement : character;
    }).toList().join();
  }
}