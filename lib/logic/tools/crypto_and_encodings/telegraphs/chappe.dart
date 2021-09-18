
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';


final Map<String, List<String>> CODEBOOK_CHAPPE = {
  'A': ['10', '1r', '50', '5l'],
  'B': ['20', '2r', '60', '6l'],
  'C': ['30', '3r', '70', '7l'],
  'D': ['40', '4r', '80', '8l'],
  'E': ['10', '1l', '50', '5r'],
  'F': ['20', '2l', '60', '6r'],
  'G': ['30', '3l', '70', '7r'],
  'H': ['40', '4l', '80', '8r'],
  'I': ['10', '1l', '50', '5l'],
  'K': ['20', '2l', '60', '6l'],
  'L': ['30', '3l', '70', '7l'],
  'M': ['40', '4l', '80', '8l'],
  'N': ['10', '1r', '50', '5r'],
  'O': ['20', '2r', '60', '6r'],
  'P': ['30', '3r', '70', '7r'],
  'Q': ['40', '4r', '80', '8r'],
  'R': ['10', '1r', '50'],
  'S': ['20', '2r', '60'],
  'T': ['30', '3r', '70'],
  'U': ['40', '4r', '80'],
  'V': ['10', '50', '5r'],
  'W': ['20', '60', '6r'],
  'X': ['30', '70', '7r'],
  'Y': ['40', '80', '8r'],
  'Z': ['10', '50', '5l'],
  '1': ['30', '70', '7l'],
  '2': ['40', '80', '8l'],
  '3': ['10', '1l', '50'],
  '4': ['20', '2l', '60'],
  '5': ['30', '3l', '70'],
  '6': ['40', '4l', '80'],
  '7': ['10', '50'],
  '8': ['20', '60'],
  '9': ['30', '70'],
  '0': ['40', '80'],
  '&': ['20', '60', '6l'],
};


List<List<String>> encodeChappe(String input) {
  if (input == null) return [];

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (CODEBOOK_CHAPPE[inputs[i].toUpperCase()] != null) {
      result.add(CODEBOOK_CHAPPE[inputs[i].toUpperCase()]);
    }
  }
  return result;
}

Map<String, dynamic> decodeChappe(List<String> inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'chars': [0]
    };

  var displays = <List<String>>[];
  var segment = <String>[];

  Map<List<String>, String> CODEBOOK = switchMapKeyValue(CODEBOOK_CHAPPE);

  inputs.forEach((element) {
    segment = _stringToSegment(element);
    displays.add(segment);
  });

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';

    if (CODEBOOK.map((key, value) =>
        MapEntry(key.join(), value.toString()))[input.split('').join()] ==
        null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      charH = CODEBOOK.map((key, value) =>
          MapEntry(key.join(), value.toString()))[input.split('').join()];
      char = char + charH;
    }

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};
}

List<String> _stringToSegment(String input) {
  if (input.length % 2 == 0){
    List<String> result = [];
    int j = 0;
    for (int i = 0; i < input.length / 2; i++) {
      result.add(input[j] + input[j + 1]);
      j = j + 2;
    }
    return result;
  } else
    return [];
}