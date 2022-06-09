import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

enum NotesCodebook {
  ALT,
  BASS,
  TREBLE,
}
const hashLabel = 'k';
const bLabel = 'b';
const h1 = 'c';
const h2 = 'd';
const h3 = 'e';
const h4 = 'f';
const h5 = 'g';
const nh1 = 'w';
const nh2 = 'x';
const nh3 = 'y';
const nh4 = 'z';


final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_ALT = {
  '1': ['-2hs'],
  '1_b': ['-2hs', bLabel],
  '1_k': ['-2hs', hashLabel],
  '2': ['-1h'],
  '2_b': ['-1h', bLabel],
  '2_k': ['-1h', hashLabel],
  '3': ['-1hs'],
  '3_b': ['-1hs', bLabel],
  '3_k': ['-1hs', hashLabel],
  '4': ['1'],
  '4_b': ['1', bLabel],
  '4_k': ['1', hashLabel],
  '5': ['1s'],
  '5_b': ['1s', bLabel],
  '5_k': ['1s', hashLabel],
  '6': ['2'],
  '6_b': ['2', bLabel],
  '6_k': ['2', hashLabel],
  '7': ['2s'],
  '7_b': ['2s', bLabel],
  '7_k': ['2s', hashLabel],
  '8': ['3'],
  '8_b': ['3', bLabel],
  '8_k': ['3', hashLabel],
  '9': ['3s'],
  '9_b': ['3s', bLabel],
  '9_k': ['3s', hashLabel],
  '10': ['4'],
  '10_b': ['4', bLabel],
  '10_k': ['4', hashLabel],
  '11': ['4s'],
  '11_b': ['4s', bLabel],
  '11_k': ['4s', hashLabel],
  '12': ['5'],
  '12_b': ['5', bLabel],
  '12_k': ['5', hashLabel],
  '13': ['5s'],
  '13_b': ['5s', bLabel],
  '13_k': ['5s', hashLabel],
  '14': ['1h'],
  '14_b': ['1h', bLabel],
  '14_k': ['1h', hashLabel],
  '15': ['1hs'],
  '15_b': ['1hs', bLabel],
  '15_k': ['1hs', hashLabel],
  '16': ['2h'],
  '16_b': ['2h', bLabel],
  '16_k': ['2h', hashLabel],
  '17': ['2hs'],
  '17_b': ['2hs', bLabel],
  '17_k': ['2hs', hashLabel],
  '18': ['3h'],
  '18_b': ['3h', bLabel],
  '18_k': ['3h', hashLabel],
  '19': ['3hs'],
  '19_b': ['3hs', bLabel],
  '19_k': ['3hs', hashLabel],
  '20': ['4h'],
  '20_b': ['4h', bLabel],
  '20_k': ['4h', hashLabel],
  '21': ['4hs'],
  '21_b': ['4hs', bLabel],
  '21_k': ['4hs', hashLabel],
  '22': ['5h'],
  '22_b': ['5h', bLabel],
  '22_k': ['5h', hashLabel],
};

final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_BASS = {
  '1': ['-2h'],
  '1_b': ['-2h', bLabel],
  '1_k': ['-2h', hashLabel],
  '2': ['-2hs'],
  '2_b': ['-2hs', bLabel],
  '2_k': ['-2hs', hashLabel],
  '3': ['-1h'],
  '3_b': ['-1h', bLabel],
  '3_k': ['-1h', hashLabel],
  '4': ['-1hs'],
  '4_b': ['-1hs', bLabel],
  '4_k': ['-1hs', hashLabel],
  '5': ['1'],
  '5_b': ['1', bLabel],
  '5_k': ['1', hashLabel],
  '6': ['1s'],
  '6_b': ['1s', bLabel],
  '6_k': ['1s', hashLabel],
  '7': ['2'],
  '7_b': ['2', bLabel],
  '7_k': ['2', hashLabel],
  '8': ['2s'],
  '8_b': ['2s', bLabel],
  '8_k': ['2s', hashLabel],
  '9': ['3'],
  '9_b': ['3', bLabel],
  '9_k': ['3', hashLabel],
  '10': ['3s'],
  '10_b': ['3s', bLabel],
  '10_k': ['3s', hashLabel],
  '11': ['4'],
  '11_b': ['4', bLabel],
  '11_k': ['4', hashLabel],
  '12': ['4s'],
  '12_b': ['4s', bLabel],
  '12_k': ['4s', hashLabel],
  '13': ['5'],
  '13_b': ['5', bLabel],
  '13_k': ['5', hashLabel],
  '14': ['5s'],
  '14_b': ['5s', bLabel],
  '14_k': ['5s', hashLabel],
  '15': ['1h'],
  '15_b': ['1h', bLabel],
  '15_k': ['1h', hashLabel],
  '16': ['1hs'],
  '16_b': ['1hs', bLabel],
  '16_k': ['1hs', hashLabel],
  '17': ['2h'],
  '17_b': ['2h', bLabel],
  '17_k': ['2h', hashLabel],
  '18': ['2hs'],
  '18_b': ['2hs', bLabel],
  '18_k': ['2hs', hashLabel],
  '19': ['3h'],
  '19_b': ['3h', bLabel],
  '19_k': ['3h', hashLabel],
  '20': ['3hs'],
  '20_b': ['3hs', bLabel],
  '20_k': ['3hs', hashLabel],
  '21': ['4h'],
  '21_b': ['4h', bLabel],
  '21_k': ['4h', hashLabel],
  '22': ['4hs'],
  '22_b': ['4hs', bLabel],
  '22_k': ['4hs', hashLabel],
};

final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_TREBLE = {
  '1': ['-5hs'],
  '1_b': ['-5hs', bLabel],
  '1_k': ['-5hs', hashLabel],
  '2': ['-4h'],
  '2_b': ['-4h', bLabel],
  '2_k': ['-4h', hashLabel],
  '3': ['-4hs'],
  '3_b': ['-4hs', bLabel],
  '3_k': ['-4hs', hashLabel],
  '4': ['-3h'],
  '4_b': ['-3h', bLabel],
  '4_k': ['-3h', hashLabel],
  '5': ['-3hs'],
  '5_b': ['-3hs', bLabel],
  '5_k': ['-3hs', hashLabel],
  '6': ['-2h'],
  '6_b': ['-2h', bLabel],
  '6_k': ['-2h', hashLabel],
  '7': ['-2hs'],
  '7_b': ['-2hs', bLabel],
  '7_k': ['-2hs', hashLabel],
  '8': ['-1h'],
  '8_b': ['-1h', bLabel],
  '8_k': ['-1h', hashLabel],
  '9': ['-1hs'],
  '9_b': ['-1hs', bLabel],
  '9_k': ['-1hs', hashLabel],
  '10': ['1'],
  '10_b': ['1', bLabel],
  '10_k': ['1', hashLabel],
  '11': ['1s'],
  '11_b': ['1s', bLabel],
  '11_k': ['1s', hashLabel],
  '12': ['2'],
  '12_b': ['2', bLabel],
  '12_k': ['2', hashLabel],
  '13': ['2s'],
  '13_b': ['2s', bLabel],
  '13_k': ['2s', hashLabel],
  '14': ['3'],
  '14_b': ['3', bLabel],
  '14_k': ['3', hashLabel],
  '15': ['3s'],
  '15_b': ['3s', bLabel],
  '15_k': ['3s', hashLabel],
  '16': ['4'],
  '16_b': ['4', bLabel],
  '16_k': ['4', hashLabel],
  '17': ['4s'],
  '17_b': ['4s', bLabel],
  '17_k': ['4s', hashLabel],
  '18': ['5'],
  '18_b': ['5', bLabel],
  '18_k': ['5', hashLabel],
  '19': ['5s'],
  '19_b': ['5s', bLabel],
  '19_k': ['5s', hashLabel],
  '20': ['1h'],
  '20_b': ['1h', bLabel],
  '20_k': ['1h', hashLabel],
  '21': ['1hs'],
  '21_b': ['1hs', bLabel],
  '21_k': ['1hs', hashLabel],
  '22': ['2h'],
  '22_b': ['2h', bLabel],
  '22_k': ['2h', hashLabel],
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
      'chars': ['']
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

    input = input.replaceAll(RegExp('$h1|$h2|$h3|$h4|$h5|$nh1|$nh2|$nh3|$nh3|$nh4'), '');

    if (input.contains(hashLabel)) {
      display.add(input.replaceAll(hashLabel, ''));
      display.add(hashLabel);
    } else if (input.contains(bLabel)) {
        display.add(input.replaceAll(bLabel, ''));
        display.add(bLabel);
    } else
      display.add(input);

    // display.addAll([h1, h2, h3, h4, h5, nh1, nh2, nh3, nh4, nh5]);
    //
    // display = _filterHelpLines(input, display);

    if (CODEBOOK.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()] == null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      charH = CODEBOOK.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()];
      char = char + charH;
    }

    displays.add(display);

    return char;
  }).toList();

  print('display input: ' + displays.toString() + ' inputs: ' + inputs.toString() + ' chars: ' + text.toString());

  return {'displays': displays, 'chars': text};
}

Map<String, bool> filterVisibleHelpLines(Map<String, bool> displayedSegments) {

  if (!_containsNote(['5h'], displayedSegments)) {
    displayedSegments[h5] = false;
    if (!_containsNote(['4hs', '4h'], displayedSegments)) {
      displayedSegments[h4] = false;
      if (!_containsNote(['3hs', '3h'], displayedSegments)) {
        displayedSegments[h3] = false;
        if (!_containsNote(['2hs', '2h'], displayedSegments)) {
          displayedSegments[h2] = false;
          if (!_containsNote(['1hs', '1h'], displayedSegments))
            displayedSegments[h1] = false;
        }
      }
    }
  }

  if (!_containsNote(['-5hs', '-4h'], displayedSegments)) {
    displayedSegments[nh4] = false;
    if (!_containsNote(['-4hs', '-3h'], displayedSegments)) {
      displayedSegments[nh3] = false;
      if (!_containsNote(['-3hs', '-2h'], displayedSegments)) {
        displayedSegments[nh2] = false;
        if (!_containsNote(['-2hs', '-1h'], displayedSegments))
          displayedSegments[nh1] = false;
      }
    }
  }
  return displayedSegments;
}

bool _containsNote(List<String> notes, Map<String, bool> displayedSegments) {
  for(var note in notes)
    if (displayedSegments[note] != null) return true;
  return false;
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
