
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';


final Map<String, List<String>> CODEBOOK_CHAPPE = {
  'A': ['10', '1r', '50', '5l'],
  'B': ['1', '3', '4', '5'],
  'C': ['30', '3r', '70', '7l'],
  'D': ['1', '2', '3', '5'],
  'E': ['10', '1l', '50', '5r'],
  'F': ['1', '2', '3', '4'],
  'G': ['30', '3l', '70', '7r'],
  'H': ['2', '6', '6', '6'],
  'I': ['10', '1l', '50', '5l'],
  'J': ['3', '6', '6', '6'],
  'K': ['4', '6', '6', '6'],
  'L': ['30', '3l', '70', '7l'],
  'M': ['6', '6', '6', '6'],
  'N': ['10', '1r', '50', '5r'],
  'O': ['4', '6', '6', '6'],
  'P': ['30', '3r', '70', '7r'],
  'Q': ['2', '6', '6', '6'],
  'R': ['10', '1r', '50'],
  'S': ['2', '4', '6', '6'],
  'T': ['30', '3r', '70'],
  'U': ['3', '6', '6', '6'],
  'V': ['10', '50', '5r'],
  'W': ['1', '3', '6', '6'],
  'X': ['30', '70', '7r'],
  'Y': ['1', '3', '6', '6'],
  'Z': ['10', '50', '5l'],
  '0': ['40', '80'],
  '1': ['30', '70', '7l'],
  '2': ['3', '4', '5', '6'],
  '3': ['10', '1l', '50'],
  '4': ['1', '3', '4', '6'],
  '5': ['30', '3l', '70'],
  '6': ['1', '2', '3', '6'],
  '7': ['10', '50'],
  '8': ['10', '50'],
  '9': ['30', '70'],
  '&': ['1', '2', '3', '4'],
};


List<List<String>> encodeChappe(String input) {
  if (input == null) return [];

  List<String> inputs = input.split('');
  List<List<String>> result = [];
  List<String> segment = [];

  for (int i = 0; i < inputs.length; i++) {
    List<String> segment = [];
    if (CODEBOOK_CHAPPE[inputs[i].toUpperCase()] != null) {
      List<String> segment = CODEBOOK_CHAPPE[inputs[i].toUpperCase()];
      segment.add('70');
      result.add(segment);
    }
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

