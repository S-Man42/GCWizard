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

const notes = ['5h','4hs','4h','3hs','3h','2hs','2h','1hs','1h','5s','5','4s','4','3s','3',
               '2s','2','1s','1','-1hs','-1h','-2hs','-2h','-3hs','-3h','-4hs','-4h','-5hs'];

final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_ALT = {
  '1':   [notes[21]],
  '1_b': [notes[21], bLabel],
  '1_k': [notes[21], hashLabel],
  '2':   [notes[20]],
  '2_b': [notes[20], bLabel],
  '2_k': [notes[20], hashLabel],
  '3':   [notes[19]],
  '3_b': [notes[19], bLabel],
  '3_k': [notes[19], hashLabel],
  '4':   [notes[18]],
  '4_b': [notes[18], bLabel],
  '4_k': [notes[18], hashLabel],
  '5':   [notes[17]],
  '5_b': [notes[17], bLabel],
  '5_k': [notes[17], hashLabel],
  '6':   [notes[16]],
  '6_b': [notes[16], bLabel],
  '6_k': [notes[16], hashLabel],
  '7':   [notes[15]],
  '7_b': [notes[15], bLabel],
  '7_k': [notes[15], hashLabel],
  '8':   [notes[14]],
  '8_b': [notes[14], bLabel],
  '8_k': [notes[14], hashLabel],
  '9':   [notes[13]],
  '9_b': [notes[13], bLabel],
  '9_k': [notes[13], hashLabel],
  '10':   [notes[12]],
  '10_b': [notes[12], bLabel],
  '10_k': [notes[12], hashLabel],
  '11':   [notes[11]],
  '11_b': [notes[11], bLabel],
  '11_k': [notes[11], hashLabel],
  '12':   [notes[10]],
  '12_b': [notes[10], bLabel],
  '12_k': [notes[10], hashLabel],
  '13':   [notes[9]],
  '13_b': [notes[9], bLabel],
  '13_k': [notes[9], hashLabel],
  '14':   [notes[8]],
  '14_b': [notes[8], bLabel],
  '14_k': [notes[8], hashLabel],
  '15':   [notes[7]],
  '15_b': [notes[7], bLabel],
  '15_k': [notes[7], hashLabel],
  '16':   [notes[6]],
  '16_b': [notes[6], bLabel],
  '16_k': [notes[6], hashLabel],
  '17':   [notes[5]],
  '17_b': [notes[5], bLabel],
  '17_k': [notes[5], hashLabel],
  '18':   [notes[4]],
  '18_b': [notes[4], bLabel],
  '18_k': [notes[4], hashLabel],
  '19':   [notes[3]],
  '19_b': [notes[3], bLabel],
  '19_k': [notes[3], hashLabel],
  '20':   [notes[2]],
  '20_b': [notes[2], bLabel],
  '20_k': [notes[2], hashLabel],
  '21':   [notes[1]],
  '21_b': [notes[1], bLabel],
  '21_k': [notes[1], hashLabel],
  '22':   [notes[0]],
  '22_b': [notes[0], bLabel],
  '22_k': [notes[0], hashLabel],
};

final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_BASS = {
  '1':   [notes[22]],
  '1_b': [notes[22], bLabel],
  '1_k': [notes[22], hashLabel],
  '2':   [notes[21]],
  '2_b': [notes[21], bLabel],
  '2_k': [notes[21], hashLabel],
  '3':   [notes[20]],
  '3_b': [notes[20], bLabel],
  '3_k': [notes[20], hashLabel],
  '4':   [notes[19]],
  '4_b': [notes[19], bLabel],
  '4_k': [notes[19], hashLabel],
  '5':   [notes[18]],
  '5_b': [notes[18], bLabel],
  '5_k': [notes[18], hashLabel],
  '6':   [notes[17]],
  '6_b': [notes[17], bLabel],
  '6_k': [notes[17], hashLabel],
  '7':   [notes[16]],
  '7_b': [notes[16], bLabel],
  '7_k': [notes[16], hashLabel],
  '8':   [notes[15]],
  '8_b': [notes[15], bLabel],
  '8_k': [notes[15], hashLabel],
  '9':   [notes[14]],
  '9_b': [notes[14], bLabel],
  '9_k': [notes[14], hashLabel],
  '10':   [notes[13]],
  '10_b': [notes[13], bLabel],
  '10_k': [notes[13], hashLabel],
  '11':   [notes[12]],
  '11_b': [notes[12], bLabel],
  '11_k': [notes[12], hashLabel],
  '12':   [notes[11]],
  '12_b': [notes[11], bLabel],
  '12_k': [notes[11], hashLabel],
  '13':   [notes[10]],
  '13_b': [notes[10], bLabel],
  '13_k': [notes[10], hashLabel],
  '14':   [notes[9]],
  '14_b': [notes[9], bLabel],
  '14_k': [notes[9], hashLabel],
  '15':   [notes[8]],
  '15_b': [notes[8], bLabel],
  '15_k': [notes[8], hashLabel],
  '16':   [notes[7]],
  '16_b': [notes[7], bLabel],
  '16_k': [notes[7], hashLabel],
  '17':   [notes[6]],
  '17_b': [notes[6], bLabel],
  '17_k': [notes[6], hashLabel],
  '18':   [notes[5]],
  '18_b': [notes[5], bLabel],
  '18_k': [notes[5], hashLabel],
  '19':   [notes[4]],
  '19_b': [notes[4], bLabel],
  '19_k': [notes[4], hashLabel],
  '20':   [notes[3]],
  '20_b': [notes[3], bLabel],
  '20_k': [notes[3], hashLabel],
  '21':   [notes[2]],
  '21_b': [notes[2], bLabel],
  '21_k': [notes[2], hashLabel],
  '22':   [notes[1]],
  '22_b': [notes[1], bLabel],
  '22_k': [notes[1], hashLabel],
};

final Map<String, List<String>> CODEBOOK_MUSIC_NOTES_TREBLE = {
  '1':   [notes[27]],
  '1_b': [notes[27], bLabel],
  '1_k': [notes[27], hashLabel],
  '2':   [notes[26]],
  '2_b': [notes[26], bLabel],
  '2_k': [notes[26], hashLabel],
  '3':   [notes[25]],
  '3_b': [notes[25], bLabel],
  '3_k': [notes[25], hashLabel],
  '4':   [notes[24]],
  '4_b': [notes[24], bLabel],
  '4_k': [notes[24], hashLabel],
  '5':   [notes[23]],
  '5_b': [notes[23], bLabel],
  '5_k': [notes[23], hashLabel],
  '6':   [notes[22]],
  '6_b': [notes[22], bLabel],
  '6_k': [notes[22], hashLabel],
  '7':   [notes[21]],
  '7_b': [notes[21], bLabel],
  '7_k': [notes[21], hashLabel],
  '8':   [notes[20]],
  '8_b': [notes[20], bLabel],
  '8_k': [notes[20], hashLabel],
  '9':   [notes[19]],
  '9_b': [notes[19], bLabel],
  '9_k': [notes[19], hashLabel],
  '10':   [notes[18]],
  '10_b': [notes[18], bLabel],
  '10_k': [notes[18], hashLabel],
  '11':   [notes[17]],
  '11_b': [notes[17], bLabel],
  '11_k': [notes[17], hashLabel],
  '12':   [notes[16]],
  '12_b': [notes[16], bLabel],
  '12_k': [notes[16], hashLabel],
  '13':   [notes[15]],
  '13_b': [notes[15], bLabel],
  '13_k': [notes[15], hashLabel],
  '14':   [notes[14]],
  '14_b': [notes[14], bLabel],
  '14_k': [notes[14], hashLabel],
  '15':   [notes[13]],
  '15_b': [notes[13], bLabel],
  '15_k': [notes[13], hashLabel],
  '16':   [notes[12]],
  '16_b': [notes[12], bLabel],
  '16_k': [notes[12], hashLabel],
  '17':   [notes[11]],
  '17_b': [notes[11], bLabel],
  '17_k': [notes[11], hashLabel],
  '18':   [notes[10]],
  '18_b': [notes[10], bLabel],
  '18_k': [notes[10], hashLabel],
  '19':   [notes[9]],
  '19_b': [notes[9], bLabel],
  '19_k': [notes[9], hashLabel],
  '20':   [notes[8]],
  '20_b': [notes[8], bLabel],
  '20_k': [notes[8], hashLabel],
  '21':   [notes[7]],
  '21_b': [notes[7], bLabel],
  '21_k': [notes[7], hashLabel],
  '22':   [notes[6]],
  '22_b': [notes[6], bLabel],
  '22_k': [notes[6], hashLabel],
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

  if (!_containsNote([notes[0]], displayedSegments)) {
    displayedSegments[h5] = false;
    if (!_containsNote([notes[1], notes[2]], displayedSegments)) {
      displayedSegments[h4] = false;
      if (!_containsNote([notes[3], notes[4]], displayedSegments)) {
        displayedSegments[h3] = false;
        if (!_containsNote([notes[5], notes[6]], displayedSegments)) {
          displayedSegments[h2] = false;
          if (!_containsNote([notes[7], notes[8]], displayedSegments))
            displayedSegments[h1] = false;
        }
      }
    }
  }

  if (!_containsNote([notes[27], notes[26]], displayedSegments)) {
    displayedSegments[nh4] = false;
    if (!_containsNote([notes[25], notes[24]], displayedSegments)) {
      displayedSegments[nh3] = false;
      if (!_containsNote([notes[23], notes[22]], displayedSegments)) {
        displayedSegments[nh2] = false;
        if (!_containsNote([notes[21], notes[20]], displayedSegments))
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
