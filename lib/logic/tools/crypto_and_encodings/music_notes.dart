import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

enum NotesCodebook {
  ALT,
  BASS,
  TREBLE,
}

final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_ALT = {
  '1': ['-2hs'],
  '1_b': ['-2hs', 'b'],
  '1_k': ['-2hs', 'k'],
  '2': ['-1h'],
  '2_b': ['-1h', 'b'],
  '2_k': ['-1h', 'k'],
  '3': ['-1hs'],
  '3_b': ['-1hs', 'b'],
  '3_k': ['-1hs', 'k'],
  '4': ['1'],
  '4_b': ['1', 'b'],
  '4_k': ['1', 'k'],
  '5': ['1s'],
  '5_b': ['1s', 'b'],
  '5_k': ['1s', 'k'],
  '6': ['2'],
  '6_b': ['2', 'b'],
  '6_k': ['2', 'k'],
  '7': ['2s'],
  '7_b': ['2s', 'b'],
  '7_k': ['2s', 'k'],
  '8': ['2'],
  '8_b': ['2', 'b'],
  '8_k': ['2', 'k'],
  '9': ['3s'],
  '9_b': ['3s', 'b'],
  '9_k': ['3s', 'k'],
  '10': ['4'],
  '10_b': ['4', 'b'],
  '10_k': ['4', 'k'],
  '11': ['4s'],
  '11_b': ['4s', 'b'],
  '11_k': ['4s', 'k'],
  '12': ['5'],
  '12_b': ['5', 'b'],
  '12_k': ['5', 'k'],
  '13': ['5s'],
  '13_b': ['5s', 'b'],
  '13_k': ['5s', 'k'],
  '14': ['1h'],
  '14_b': ['1h', 'b'],
  '14_k': ['1h', 'k'],
  '15': ['1hs'],
  '15_b': ['1hs', 'b'],
  '15_k': ['1hs', 'k'],
  '16': ['2h'],
  '16_b': ['2h', 'b'],
  '16_k': ['2h', 'k'],
  '17': ['2hs'],
  '17_b': ['2hs', 'b'],
  '17_k': ['2hs', 'k'],
  '18': ['3h'],
  '18_b': ['3h', 'b'],
  '18_k': ['3h', 'k'],
  '19': ['3hs'],
  '19_b': ['3hs', 'b'],
  '19_k': ['3hs', 'k'],
  '20': ['4h'],
  '20_b': ['4h', 'b'],
  '20_k': ['4h', 'k'],
  '21': ['4hs'],
  '21_b': ['4hs', 'b'],
  '21_k': ['4hs', 'k'],
  '22': ['5h'],
  '22_b': ['5h', 'b'],
  '22_k': ['5h', 'k'],
};

final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_BASS = {
  '1': ['-2h'],
  '1_b': ['-2h', 'b'],
  '1_k': ['-2h', 'k'],
  '2': ['-2hs'],
  '2_b': ['-2hs', 'b'],
  '2_k': ['-2hs', 'k'],
  '3': ['-1h'],
  '3_b': ['-1h', 'b'],
  '3_k': ['-1h', 'k'],
  '4': ['-1hs'],
  '4_b': ['-1hs', 'b'],
  '4_k': ['-1hs', 'k'],
  '5': ['1'],
  '5_b': ['1', 'b'],
  '5_k': ['1', 'k'],
  '6': ['1s'],
  '6_b': ['1s', 'b'],
  '6_k': ['1s', 'k'],
  '7': ['2'],
  '7_b': ['2', 'b'],
  '7_k': ['2', 'k'],
  '8': ['2s'],
  '8_b': ['2s', 'b'],
  '8_k': ['2s', 'k'],
  '9': ['3'],
  '9_b': ['3', 'b'],
  '9_k': ['3', 'k'],
  '10': ['3s'],
  '10_b': ['3s', 'b'],
  '10_k': ['3s', 'k'],
  '11': ['4'],
  '11_b': ['4', 'b'],
  '11_k': ['4', 'k'],
  '12': ['4s'],
  '12_b': ['4s', 'b'],
  '12_k': ['4s', 'k'],
  '13': ['5'],
  '13_b': ['5', 'b'],
  '13_k': ['5', 'k'],
  '14': ['5s'],
  '14_b': ['5s', 'b'],
  '14_k': ['5s', 'k'],
  '15': ['1h'],
  '15_b': ['1h', 'b'],
  '15_k': ['1h', 'k'],
  '16': ['1hs'],
  '16_b': ['1hs', 'b'],
  '16_k': ['1hs', 'k'],
  '17': ['2h'],
  '17_b': ['2h', 'b'],
  '17_k': ['2h', 'k'],
  '18': ['2hs'],
  '18_b': ['2hs', 'b'],
  '18_k': ['2hs', 'k'],
  '19': ['3h'],
  '19_b': ['3h', 'b'],
  '19_k': ['3h', 'k'],
  '20': ['3hs'],
  '20_b': ['3hs', 'b'],
  '20_k': ['3hs', 'k'],
  '21': ['4h'],
  '21_b': ['4h', 'b'],
  '21_k': ['4h', 'k'],
  '22': ['4hs'],
  '22_b': ['4hs', 'b'],
  '22_k': ['4hs', 'k'],
};


final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_TREBLE = {
  '1': ['-5hs'],
  '1_b': ['-5hs', 'b'],
  '1_k': ['-5hs', 'k'],
  '2': ['-4h'],
  '2_b': ['-4h', 'b'],
  '2_k': ['-4h', 'k'],
  '3': ['-4hs'],
  '3_b': ['-4hs', 'b'],
  '3_k': ['-4hs', 'k'],
  '4': ['-3h'],
  '4_b': ['-3h', 'b'],
  '4_k': ['-3h', 'k'],
  '5': ['-3hs'],
  '5_b': ['-3hs', 'b'],
  '5_k': ['-3hs', 'k'],
  '6': ['-2h'],
  '6_b': ['-2h', 'b'],
  '6_k': ['-2h', 'k'],
  '7': ['-2hs'],
  '7_b': ['-2hs', 'b'],
  '7_k': ['-2hs', 'k'],
  '8': ['-1h'],
  '8_b': ['-1h', 'b'],
  '8_k': ['-1h', 'k'],
  '9': ['-1hs'],
  '9_b': ['-1hs', 'b'],
  '9_k': ['-1hs', 'k'],
  '10': ['1'],
  '10_b': ['1', 'b'],
  '10_k': ['1', 'k'],
  '11': ['1s'],
  '11_b': ['1s', 'b'],
  '11_k': ['1s', 'k'],
  '12': ['2'],
  '12_b': ['2', 'b'],
  '12_k': ['2', 'k'],
  '13': ['2s'],
  '13_b': ['2s', 'b'],
  '13_k': ['2s', 'k'],
  '14': ['3'],
  '14_b': ['3', 'b'],
  '14_k': ['3', 'k'],
  '15': ['3s'],
  '15_b': ['3s', 'b'],
  '15_k': ['3s', 'k'],
  '16': ['4'],
  '16_b': ['4', 'b'],
  '16_k': ['4', 'k'],
  '17': ['4s'],
  '17_b': ['4s', 'b'],
  '17_k': ['4s', 'k'],
  '18': ['5'],
  '18_b': ['5', 'b'],
  '18_k': ['5', 'k'],
  '19': ['5s'],
  '19_b': ['5s', 'b'],
  '19_k': ['5s', 'k'],
  '20': ['1h'],
  '20_b': ['1h', 'b'],
  '20_k': ['1h', 'k'],
  '21': ['1hs'],
  '21_b': ['1hs', 'b'],
  '21_k': ['1hs', 'k'],
  '22': ['2h'],
  '22_b': ['2h', 'b'],
  '22_k': ['2h', 'k'],
};


List<List<String>> encodeNotes(String input, NotesCodebook notes) {
  if (input == null) return [];

  Map<String, List<String>> CODEBOOK = new Map<String, List<String>>();
  switch (notes) {
    case NotesCodebook.ALT:
      CODEBOOK = CODEBOOK_MUSIC_NOTES_ALT;
      break;
    case NotesCodebook.BASS:
      CODEBOOK = CODEBOOK_MUSIC_NOTES_BASS;
      break;
    case NotesCodebook.TREBLE:
      CODEBOOK = CODEBOOK_MUSIC_NOTES_TREBLE;
      break;
  }

  List<String> inputs = input.split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (CODEBOOK[inputs[i].toUpperCase()] != null) result.add(CODEBOOK[inputs[i].toUpperCase()]);
  }
  return result;
}

Map<String, dynamic> decodeNotes(List<String> inputs, NotesCodebook notes) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'chars': [0]
    };

  var displays = <List<String>>[];

  Map<List<String>, String> CODEBOOK = new Map<List<String>, String>();
  switch (notes) {
    case NotesCodebook.ALT:
      CODEBOOK = switchMapKeyValue(CODEBOOK_MUSIC_NOTES_ALT);
      break;
    case NotesCodebook.BASS:
      CODEBOOK = switchMapKeyValue(CODEBOOK_MUSIC_NOTES_BASS);
      break;
    case NotesCodebook.TREBLE:
      CODEBOOK = switchMapKeyValue(CODEBOOK_MUSIC_NOTES_TREBLE);
      break;
  }

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';
    var display = <String>[];

    input.split('').forEach((element) {
      display.add(element);
    });

    if (CODEBOOK.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()] == null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      charH = CODEBOOK.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()];
      char = char + charH;
    }

    displays.add(display);

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};
}

List<String> _stringToSegment(String input) {
  List<String> result = [];
  int j = 0;
  for (int i = 0; i < input.length / 2; i++) {
    result.add(input[j] + input[j + 1]);
    j = j + 2;
  }
  return result;
}
