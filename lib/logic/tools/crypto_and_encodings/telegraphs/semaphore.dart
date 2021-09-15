
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final Map<String, List<String>> CODEBOOK_SEMAPHORE = {
  'A': ['l', 'r'],
  'B': ['l', 'r'],
  'C': ['l', 'r'],
  'D': ['l', 'r'],
  'E': ['l', 'r'],
  'F': ['l', 'r'],
  'G': ['l', 'r'],
  'H': ['l', 'r'],
  'I': ['l', 'r'],
  'K': ['l', 'r'],
  'L': ['l', 'r'],
  'M': ['l', 'r'],
  'N': ['l', 'r'],
  'O': ['l', 'r'],
  'P': ['l', 'r'],
  'Q': ['l', 'r'],
  'R': ['l', 'r'],
  'S': ['l', 'r'],
  'T': ['l', 'r'],
  'V': ['l', 'r'],
  'W': ['l', 'r'],
  'X': ['l', 'r'],
  'Y': ['l', 'r'],
  'Z': ['l', 'r'],
  '0': ['l', 'r'],
  '1': ['l', 'r'],
  '2': ['l', 'r'],
  '3': ['l', 'r'],
  '4': ['l', 'r'],
  '5': ['l', 'r'],
  '6': ['l', 'r'],
  '7': ['l', 'r'],
  '8': ['l', 'r'],
  '9': ['l', 'r'],
  'symboltables_semaphore_cancel':['l', 'r'],
  'symboltables_semaphore_correct':['l', 'r'],
  'symboltables_semaphore_error':['l', 'r'],
  'symboltables_semaphore_attention':['l', 'r'],
  'symboltables_semaphore_letters_following':['l', 'r'],
  'symboltables_semaphore_numerals_following':['l', 'r'],
  'symboltables_semaphore_numerals_break':['l', 'r'],
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

