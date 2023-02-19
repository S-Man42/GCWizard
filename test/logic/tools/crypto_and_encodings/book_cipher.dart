import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/book_cipher.dart';

void main() {

  var text1 = "Und 'wieder' - schneit‘s zur Weihnachtszeit.\n"
      "Ja wieder mal.ist es so weit.\n"
      "Der Opa holt vom Abstellraum\n"
      "wie jedes Jahr den Plastikbaum.\n\n"
      "Sein Enkel 'hilft' (so) gut er kann\n"
      "und freut sich auf den Weihnachtsmann.\n"
      "Der Christbaum-schmuck wird angebracht.\n"
      "Schon strahlt der Plastikbaum voll Pracht.";
  

  var test2 = "A b (c)\n"
      "D e f\n"
      "g h i\n"
      "j k l m n\n\n"
      "o p q r - s t\n"
      "'u' v w\n"
      "x y z\n";

  group("book_cipher.encodeText:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'text' : null, 'outFormat' : encodeOutFormat.RowWordLetter, 'expectedOutput' : ''},
      {'input' : null, 'text' : '', 'outFormat' : encodeOutFormat.RowWordLetter, 'expectedOutput' : ''},
      {'input' : null, 'text' : 'und', 'outFormat' : encodeOutFormat.RowWordLetter, 'expectedOutput' : ''},
      {'input' : '', 'text' : '', 'outFormat' : encodeOutFormat.RowWordLetter, 'expectedOutput' : ''},
      {'input' : '', 'text' : null, 'outFormat' : encodeOutFormat.RowWordLetter, 'expectedOutput' : ''},
      {'input' : '', 'text' : 'und', 'outFormat' : encodeOutFormat.RowWordLetter, 'expectedOutput' : ''},

      {'input' : test2, 'text' : 'und', 'outFormat' : encodeOutFormat.SectionRowWordLetter, 'expectedOutput' : '2.2.1.1 1.4.5.1 1.2.1.1'},
      {'input' : test2, 'text' : 'und', 'outFormat' : encodeOutFormat.RowWordLetter, 'expectedOutput' : '6.1.1 4.5.1 2.1.1'},
      {'input' : test2, 'text' : 'und', 'outFormat' : encodeOutFormat.WordLetter, 'expectedOutput' : '21.1 14.1 4.1'},
      {'input' : test2, 'text' : 'und', 'outFormat' : encodeOutFormat.Letter, 'expectedOutput' : '21 14 4'},
      {'input' : 'AAAAAAAAAA', 'text' : 'M', 'outFormat' : encodeOutFormat.Letter, 'expectedOutput' : '?'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeText(elem['input'], elem['text'], elem['outFormat']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("book_cipher.decodeSearchWord:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'word' : null, 'outFormat' : decodeOutFormat.RowWord, 'expectedOutput' : ''},
      {'input' : null, 'word' : '', 'outFormat' : decodeOutFormat.RowWord, 'expectedOutput' : ''},
      {'input' : null, 'word' : 'und', 'outFormat' : decodeOutFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'word' : '', 'outFormat' : decodeOutFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'word' : null, 'outFormat' : decodeOutFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'word' : 'und', 'outFormat' : decodeOutFormat.RowWord, 'expectedOutput' : ''},

      {'input' : text1, 'word' : 'und', 'outFormat' : decodeOutFormat.SectionRowWord, 'expectedOutput' : ': 1, : 1, : 1\n: 2, : 2, : 1'},
      {'input' : text1, 'word' : 'und', 'outFormat' : decodeOutFormat.RowWord, 'expectedOutput' : ': 1, : 1\n: 6, : 1'},
      {'input' : text1, 'word' : 'und', 'outFormat' : decodeOutFormat.Word, 'expectedOutput' : ': 1\n: 30'},
      {'input' : text1, 'word' : 'schneit‘s', 'outFormat' : decodeOutFormat.Word, 'expectedOutput' : ': 3'},
      {'input' : text1, 'word' : 'hilft', 'outFormat' : decodeOutFormat.Word, 'expectedOutput' : ': 25'},
      {'input' : text1, 'word' : 'so', 'outFormat' : decodeOutFormat.Word, 'expectedOutput' : ': 11\n: 26'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeSearchWord(elem['input'], elem['word'], elem['outFormat'], "", "", "");
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("book_cipher.decodeFindWord:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'positions' : null, 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : null, 'positions' : '', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : null, 'positions' : 'und', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'positions' : '', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'positions' : null, 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},
      {'input' : '', 'positions' : 'und', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : ''},

      {'input' : text1, 'positions' : '1-1-1', 'searchFormat' : searchFormat.SectionRowWord, 'expectedOutput' : 'UND'},
      {'input' : text1, 'positions' : '3-1-1', 'searchFormat' : searchFormat.SectionRowWord, 'expectedOutput' : ''},
      {'input' : text1, 'positions' : '7.2', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : 'CHRISTBAUM-SCHMUCK'},
      {'input' : text1, 'positions' : '6, 6', 'searchFormat' : searchFormat.RowWord, 'expectedOutput' : 'WEIHNACHTSMANN'},
      {'input' : text1, 'positions' : '25', 'searchFormat' : searchFormat.Word, 'expectedOutput' : 'HILFT'},
      {'input' : text1, 'positions' : '0', 'searchFormat' : searchFormat.Word, 'expectedOutput' : ''},
      {'input' : text1, 'positions' : '999', 'searchFormat' : searchFormat.Word, 'expectedOutput' : ''},
      {'input' : text1, 'positions' : '1-1-2 1', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : 'W'},
      {'input' : text1, 'positions' : '2 1 3 3', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : 'L'},
      {'input' : text1, 'positions' : '2 1 3 1 2 1 3 2 2 1 3 3 2 1 3 4 2 1 3 5', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : 'HILFT'},
      {'input' : text1, 'positions' : '2 1 3 1 2 1 3 2 2 1 3 3 2 1 3 4 2 1 3 5  2 1 3 6', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : 'HILFT'},
      {'input' : text1, 'positions' : '2 1 3 ', 'searchFormat' : searchFormat.SectionRowWordLetter, 'expectedOutput' : ''},

      {'input' : text1, 'positions' : '5 1 4', 'searchFormat' : searchFormat.RowWordLetter, 'expectedOutput' : 'N'},
      {'input' : text1, 'positions' : '1 3 8', 'searchFormat' : searchFormat.RowWordLetter, 'expectedOutput' : 'S'},
      {'input' : text1, 'positions' : '25 3', 'searchFormat' : searchFormat.WordLetter, 'expectedOutput' : 'L'},
      {'input' : text1, 'positions' : '4', 'searchFormat' : searchFormat.Letter, 'expectedOutput' : 'W'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeFindWord(elem['input'], elem['positions'], elem['searchFormat']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}