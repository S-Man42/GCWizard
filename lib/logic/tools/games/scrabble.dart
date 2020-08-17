

import 'package:gc_wizard/logic/tools/games/scrabble_sets.dart';

List<int> textToLetterValues (String text, String scrabbleVersion) {
  List<int> output = [];
  ScrabbleSet set = scrabbleSets[scrabbleVersion];

  while (text.length > 0) {
    //Some Scrabble Versions include triple letters (e.g. Klingon has "tlh")
    if (text.length >= 3) {
      var tile = text.substring(0, 3);
      if (set.existLetter(tile)) {
        output.add(set.letterValue(tile));
        text = text.substring(3, text.length);
        continue;
      }
    }

    //Some Scrabble Versions include double letters (e.g. Spanish has "LL" or "RR" tiles)
    if (text.length >= 2) {
      var tile = text.substring(0, 2);
      if (set.existLetter(tile)) {
        output.add(set.letterValue(tile));
        text = text.substring(2, text.length);
        continue;
      }
    }

    output.add(set.letterValue(text[0]));
    text = text.substring(1, text.length);
  }

  return output;
}

List<int> textToLetterFrequencies (String text, String scrabbleVersion) {
  List<int> output = [];
  ScrabbleSet set = scrabbleSets[scrabbleVersion];

  while (text.length > 0) {
    //Some Scrabble Versions include triple letters (e.g. Klingon has "tlh")
    if (text.length >= 3) {
      var tile = text.substring(0, 3);
      if (set.existLetter(tile)) {
        output.add(set.letterValue(tile));
        text = text.substring(3, text.length);
        continue;
      }
    }

    //Some Scrabble Versions include double letters (e.g. Spanish has "LL" or "RR" tiles)
    if (text.length >= 2) {
      var tile = text.substring(0, 2);
      if (set.existLetter(tile)) {
        output.add(set.letterFrequency(tile));
        text = text.substring(2, text.length);
        continue;
      }
    }

    output.add(set.letterFrequency(text[0]));
    text = text.substring(1, text.length);
  }

  return output;
}