import 'dart:math';

import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

class AlphabetValues {
  Map<String, String> alphabet;

  AlphabetValues({alphabet}) {
    if (alphabet == null)
      alphabet = alphabetAZ.alphabet;

    this.alphabet = alphabet;
  }

  List<int> textToValues(String text,{bool keepNumbers: false}) {
    text = text.toUpperCase();

    var entries = alphabet.entries.toList();

    if (keepNumbers) {
      alphabet_09.entries.forEach((entry) {
        if (!entries.contains(entry.key))
          entries.add(MapEntry(entry.key, entry.value.toString()));
      });
    }

    entries.sort((a, b) {
      return b.key.length.compareTo(a.key.length);
    });

    var maxKeyLength = entries.first.key.length;

    var output = <int>[];

    while (text.length > 0) {
      String value;
      int i = 0;
      for (i = min(maxKeyLength, text.length); i >= 1; i--) {
        var entry = entries.firstWhere((entry) => entry.key == text.substring(0, i), orElse: () => null);
        if (entry != null) {
          value = entry.value;
          break;
        }
      }

      if (value == null) {
        output.add(null);
        text = text.substring(1);
      } else {
        value.split(',').forEach((v) {
          output.add(int.tryParse(v));
        });

        text = text.substring(i);
      };
    }

    return output;
  }

  String valuesToText(List<int> values) {
    var alphabetMap = switchMapKeyValue(alphabet, keepFirstOccurence: true);

    return values.map((value) {
      var character = alphabetMap[value.toString()];
      return character == null ? UNKNOWN_ELEMENT : character;
    }).toList().join();
  }
}