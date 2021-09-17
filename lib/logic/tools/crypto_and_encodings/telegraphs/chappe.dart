
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';


final Map<String, List<String>> CODEBOOK_CHAPPE = {
  'A': ['2', '3', '4', '5', '6'],
  'B': ['1', '3', '4', '5', '6'],
  'C': ['1', '2', '4', '5', '6'],
  'D': ['1', '2', '3', '5', '6'],
  'E': ['1', '2', '3', '4', '6'],
  'F': ['1', '2', '3', '4', '5'],
  'G': ['1'],
  'H': ['2'],
  'I': ['3'],
  'K': ['4'],
  'L': ['5'],
  'M': ['6'],
  'N': ['1', '2', '4', '6'],
  'O': ['4', '6'],
  'P': ['3', '2', '4', '6'],
  'Q': ['2', '6'],
  'R': ['5', '2', '4', '6'],
  'S': ['2', '4'],
  'T': ['3', '5'],
  'V': ['1', '2', '3', '5'],
  'W': ['1', '3'],
  'X': ['1', '2', '3', '4'],
  'Y': ['1', '3'],
  'Z': ['1', '2', '3', '6'],
  '0': ['1', '2', '3', '4'],
  '1': ['1', '2', '5', '6'],
  '2': ['3', '4', '5', '6'],
  '3': ['2', '3', '4', '5'],
  '4': ['1', '3', '4', '6'],
  '5': ['2', '3', '5', '6'],
  '6': ['1', '2', '3'],
  '7': ['4', '5', '6'],
  '8': ['1', '2', '3', '6'],
  '9': ['1', '2', '4', '5'],
  '?': [],
  '!': ['1', '2', '3', '4', '5', '6'],
  ':': ['1', '6'],
  ';': ['2', '5'],
};


List<List<String>> encodeChappe(String input) {
  if (input == null) return [];

  Map<String, List<String>> CODEBOOK = new Map<String, List<String>>();

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (CODEBOOK_CHAPPE[inputs[i].toUpperCase()] != null)
      result.add(CODEBOOK_CHAPPE[inputs[i].toUpperCase()]);
  }
  return result;
}

Map<String, dynamic> decodeChappe(
    List<String> inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'chars': [0]
    };

  var displays = <List<String>>[];

  Map<List<String>, String> CODEBOOK = switchMapKeyValue(CODEBOOK_CHAPPE);

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';
    var display = <String>[];

    input.split('').forEach((element) {
      display.add(element);
    });

    if (CODEBOOK.map((key, value) =>
        MapEntry(key.join(), value.toString()))[input.split('').join()] ==
        null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      charH = CODEBOOK.map((key, value) =>
          MapEntry(key.join(), value.toString()))[input.split('').join()];
      char = char + charH;
    }

    displays.add(display);

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};


}

