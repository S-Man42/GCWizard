import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/constants.dart';



final Map<String, List<String>> _CODEBOOK_STEINHEIL = {
  'A': ['b', 'e', 'g', ],
  'A': ['c', 'f', 'h', ],
  'B': ['b', 'c', 'e', 'h'],
  'C': ['c', 'e', 'f'],
  'C': ['d', 'f', 'g'],
  'CH': ['e', 'f', 'g', 'h'],
  'D': ['a', 'f', ],
  'D': ['b', 'g', ],
  'D': ['c', 'h', ],
  'E': ['e'],
  'E': ['f'],
  'E': ['g'],
  'E': ['h'],
  'F': ['b', 'c', 'e',],
  'F': ['c', 'd', 'f',],
  'G': ['a', 'b', 'g'],
  'G': ['b', 'c', 'h'],
  'H': ['a', 'b', 'c', 'd'],
  'I': ['a'],
  'I': ['b'],
  'I': ['c'],
  'I': ['d'],
  'J': ['a'],
  'J': ['b'],
  'J': ['c'],
  'J': ['d'],
  'K': ['c', 'e', 'f'],
  'K': ['d', 'f', 'g'],
  'L': ['a', 'f', 'g'],
  'L': ['b', 'g', 'h'],
  'M': ['a', 'b', 'c'],
  'M': ['b', 'c', 'd'],
  'N': ['', '', '', ''],
  'O': ['', ''],
  'P': ['', '', '', ''],
  'Q': ['', ''],
  'R': ['', '', '', ''],
  'S': ['', ''],
  'SCH': ['b', 'd', 'e', 'g'],
  'T': ['', ''],
  'V': ['', '', '', ''],
  'W': ['', ''],
  'X': ['', '', '', ''],
  'Y': ['', ''],
  'Z': ['', '', '', ''],
  '0': ['e', 'f', 'g'],
  '0': ['f', 'g', 'h'],
  '1': ['b', 'c', 'd', 'e'],
  '2': ['a', 'c', 'd', 'f'],
  '3': ['a', 'b', 'd', 'g'],
  '4': ['a', 'b', 'c', 'h'],
  '5': ['a', 'f', 'g', 'h'],
  '6': ['b', 'e', 'g', 'h'],
  '7': ['c', 'd', 'e', 'f'],
  '8': ['d', 'e', 'f', 'g'],
  '9': ['a', 'b', 'g'],
  '9': ['b', 'c', 'h'],
};

Segments encodeSteinheil(String input) {

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (_CODEBOOK_STEINHEIL[inputs[i].toUpperCase()] != null) result.add(_CODEBOOK_STEINHEIL[inputs[i].toUpperCase()]!);
  }
  return Segments(displays: result);
}

SegmentsChars decodeSteinheil(List<String> inputs) {
  if (inputs.isEmpty) return  SegmentsChars(displays: <List<String>>[], chars: []);

  var displays = <List<String>>[];

  Map<List<String>, String> CODEBOOK = switchMapKeyValue(_CODEBOOK_STEINHEIL);

  List<String> text = inputs.map((input) {
    var char = '';
    var charH = '';
    var display = <String>[];

    input.split('').forEach((element) {
      display.add(element);
    });

    if (CODEBOOK.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()] == null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      charH = CODEBOOK.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()] ?? '';
      char = char + charH;
    }

    displays.add(display);

    return char;
  }).toList();

  return SegmentsChars(displays: displays, chars: text);
}
