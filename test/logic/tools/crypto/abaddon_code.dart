import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto/abaddon_code.dart';

void main() {
  group("AbaddonCode.encryptKenny:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': null, 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': <String>[], 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': ['¥'], 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : ''},
  
      {'input' : 'A', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : '¥¥µ'},
      {'input' : 'N', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : '¥¥þ'},
      {'input' : 'Z', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : 'þ¥þ'},
  
      {'input' : 'ANZ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : '¥¥µ¥¥þþ¥þ'},
      {'input' : 'A N Z', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : '¥¥µ¥µµ¥¥þ¥µµþ¥þ'},
      {'input' : ' A N Z ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : '¥µµ¥¥µ¥µµ¥¥þ¥µµþ¥þ¥µµ'},
      
      {'input' : 'anz', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : '¥¥µ¥¥þþ¥þ'},
      {'input' : '1A  n §%/ z ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : '¥¥µ¥µµ¥µµ¥¥þ¥µµ¥µµþ¥þ¥µµ'},
      {'input' : '¥µþ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : ''},
  
      {'input' : 'ANZ', 'replaceCharacters': ['0', '1', '2'], 'expectedOutput' : '001002202'},
      {'input' : 'ANZ', 'replaceCharacters': ['a', 'b', 'c'], 'expectedOutput' : 'aabaaccac'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encryptAbaddonCode(elem['input'], elem['replaceCharacters']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("TomTomCode.decryptKenny:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': null, 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': <String>[], 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': ['/'], 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : ''},
  
      {'input' : '¥¥µ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : 'A'},
      {'input' : '¥¥þ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : 'N'},
      {'input' : 'þ¥þ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : 'Z'},
  
      {'input' : ' ¥ ¥ µ ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : 'A'},
      {'input' : '123¥412¥6µ737', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : 'A'},
  
      {'input' : '¥¥µ¥¥þþ¥þ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : 'ANZ'},
      {'input' : '¥¥µ¥µµ¥¥þ¥µµþ¥þ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : 'A N Z'},
      {'input' : '¥µµ¥¥µ¥µµ¥¥þ¥µµþ¥þ¥µµ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : ' A N Z '},
  
      {'input' : '¥', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : ''},
      {'input' : 'µ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : ''},
      {'input' : 'þ', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : ''},
      {'input' : '¥¥', 'replaceCharacters': ['¥', 'µ', 'þ'], 'expectedOutput' : ''},
      
      {'input' : '¥¥µ¥¥þþ¥þ', 'replaceCharacters': ['0', '1', '2'], 'expectedOutput' : ''},
  
      {'input' : '001002202', 'replaceCharacters': ['0', '1', '2'], 'expectedOutput' : 'ANZ'},
  
      {'input' : '--\\--..-.', 'replaceCharacters': ['-', '\\', '.'], 'expectedOutput' : 'ANZ'},
      {'input' : ']][]]||]|', 'replaceCharacters': [']', '[', '|'], 'expectedOutput' : 'ANZ'},
  
      {'input' : '001002202', 'replaceCharacters': ['', ''], 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decryptAbaddonCode(elem['input'], elem['replaceCharacters']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}