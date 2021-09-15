
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final Map<String, List<String>> CODEBOOK_SEMAPHORE = {
  'A': ['l4', 'r5'],
  'B': ['l3', 'r5'],
  'C': ['l2', 'r5'],
  'D': ['l1', 'r5'],
  'E': ['l5', 'r2'],
  'F': ['l5', 'r3'],
  'G': ['l5', 'r4'],
  'H': ['l3', 'l4'],
  'I': ['l2', 'l4'],
  'J': ['l1', 'r3'],
  'K': ['l4', 'r1'],
  'L': ['l4', 'r2'],
  'M': ['l4', 'r3'],
  'N': ['l4', 'r4'],
  'O': ['l3', 'l2'],
  'P': ['l3', 'r1'],
  'Q': ['l3', 'r2'],
  'R': ['l3', 'r3'],
  'S': ['l3', 'r4'],
  'T': ['l2', 'r1'],
  'U': ['l2', 'r2'],
  'V': ['l1', 'r4'],
  'W': ['r2', 'r3'],
  'X': ['r2', 'r4'],
  'Y': ['l2', 'r3'],
  'Z': ['r3', 'r4'],
  '0': ['l4', 'r1'],
  '1': ['l4', 'r5'],
  '2': ['l3', 'r5'],
  '3': ['l2', 'r5'],
  '4': ['l1', 'r5'],
  '5': ['l5', 'r2'],
  '6': ['l5', 'r3'],
  '7': ['l5', 'r4'],
  '8': ['l3', 'l4'],
  '9': ['l2', 'l4'],
  'symboltables_semaphore_cancel':['l2', 'r4'],
  'symboltables_semaphore_correct':['l2', 'r5'],
  'symboltables_semaphore_error':['l2', 'r2'],
  'symboltables_semaphore_attention':['l2', 'r2'],
  'symboltables_semaphore_letters_following':['l1', 'r3'],
  'symboltables_semaphore_numerals_following':['l1', 'r2'],
  'symboltables_semaphore_break':['l5', 'r5'],
};



List<List<String>> encodeSemaphore(String input) {
  if (input == null) return [];

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (CODEBOOK_SEMAPHORE[inputs[i].toUpperCase()] != null)
      result.add(CODEBOOK_SEMAPHORE[inputs[i].toUpperCase()]);
  }
  return result;
}

Map<String, dynamic> decodeSemaphore(
    List<String> inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'chars': [0]
    };

  var displays = <List<String>>[];

  Map<List<String>, String> CODEBOOK = switchMapKeyValue(CODEBOOK_SEMAPHORE);

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

