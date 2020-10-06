import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bookchiffre.dart';

void main() {

  var text1 = "Und 'wieder' - schneit‘s zur Weihnachtszeit.\n"
      "Ja wieder mal ist es so weit.\n"
      "Der Opa holt vom Abstellraum\n"
      "wie jedes Jahr den Plastikbaum.\n\n"
      "Sein Enkel 'hilft' (so) gut er kann\n"
      "und freut sich auf den Weihnachtsmann.\n"
      "Der Christbaumschmuck wird angebracht.\n"
      "Schon strahlt der Plastikbaum voll Pracht.";

  group("bookchiffre.searchWord:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'word' : null, 'outFormat' : outFormat.RowWord, 'expectedOutput' : ''},
      {'input' : null, 'word' : '', 'outFormat' : outFormat.RowWord, 'expectedOutput' : ''},
      {'input' : null, 'word' : 'und', 'outFormat' : outFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'word' : '', 'outFormat' : outFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'word' : null, 'outFormat' : outFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'word' : 'und', 'outFormat' : outFormat.RowWord, 'expectedOutput' : ''},

      {'input' : text1, 'word' : 'und', 'outFormat' : outFormat.SectionRowWord, 'expectedOutput' : ': 1, : 1, : 1\n: 2, : 2, : 1'},
      {'input' : text1, 'word' : 'und', 'outFormat' : outFormat.RowWord, 'expectedOutput' : ': 1, : 1\n: 6, : 1'},
      {'input' : text1, 'word' : 'und', 'outFormat' : outFormat.Word, 'expectedOutput' : ': 1\n: 30'},
      {'input' : text1, 'word' : 'schneit‘s', 'outFormat' : outFormat.Word, 'expectedOutput' : ': 3'},
      {'input' : text1, 'word' : 'hilft', 'outFormat' : outFormat.Word, 'expectedOutput' : ': 25'},
      {'input' : text1, 'word' : 'so', 'outFormat' : outFormat.Word, 'expectedOutput' : ': 11\n: 26'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = searchWord(elem['input'], elem['word'], elem['outFormat'], "", "", "");
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("bookchiffre.findWord:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'positions' : null, 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : null, 'positions' : '', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : null, 'positions' : 'und', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'positions' : '', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'positions' : null, 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'positions' : 'und', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},


      {'input' : text1, 'positions' : '1-1-1', 'searchFormat' : searchFormat.SectionRowWord, 'expectedOutput' : 'Und'},
      {'input' : text1, 'positions' : '3-1-1', 'searchFormat' : searchFormat.SectionRowWord, 'expectedOutput' : ''},
      {'input' : text1, 'positions' : '6, 6', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : 'Weihnachtsmann'},
      {'input' : text1, 'positions' : '25', 'searchFormat' : searchFormat.Word, 'expectedOutput' : 'hilft'},
      {'input' : text1, 'positions' : '1-1-2 1', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : 'w'},
      {'input' : text1, 'positions' : '2 1 3 3', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : 'l'},
      {'input' : text1, 'positions' : '2 1 3 1 2 1 3 2 2 1 3 3 2 1 3 4 2 1 3 5', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : 'h\ni\nl\nf\nt'},
      {'input' : text1, 'positions' : '2 1 3 1 2 1 3 2 2 1 3 3 2 1 3 4 2 1 3 5  2 1 3 6', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : 'h\ni\nl\nf\nt\n'},
      {'input' : text1, 'positions' : '2 1 3 ', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : ''},

      {'input' : text1, 'positions' : '5 1 4', 'searchFormat' : searchFormat.RowWordLetter, 'expectedOutput' : 'n'},
      {'input' : text1, 'positions' : '1 3 8', 'searchFormat' : searchFormat.RowWordLetter, 'expectedOutput' : 's'},
      {'input' : text1, 'positions' : '25 3', 'searchFormat' : searchFormat.WordLetter, 'expectedOutput' : 'l'},
      {'input' : text1, 'positions' : '4', 'searchFormat' : searchFormat.Letter, 'expectedOutput' : 'w'},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = findWord(elem['input'], elem['positions'], elem['searchFormat']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}