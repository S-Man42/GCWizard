import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto/tomtom_code.dart';

void main() {
  group("TomTomCode.encryptKenny:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': null, 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': <String>[], 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': ['/'], 'expectedOutput' : ''},
      {'input' : '', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : ''},
  
      {'input' : 'A', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : '/'},
      {'input' : 'N', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : '\\///'},
      {'input' : 'Z', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : '/\\/\\'},
  
      {'input' : 'ANZ', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : '/ \\/// /\\/\\'},
      {'input' : 'A N Z', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : '/ \\/// /\\/\\'},
      {'input' : ' A N Z ', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : '/ \\/// /\\/\\'},
  
      {'input' : '123456789', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : ''},
  
      {'input' : 'anz', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : '/ \\/// /\\/\\'},
      {'input' : '1A  n §%/ z ', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : '/ \\/// /\\/\\'},
      {'input' : '/ \\/// /\\/\\', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : ''},
  
      {'input' : 'ANZ', 'replaceCharacters': ['0', '1'], 'expectedOutput' : '0 1000 0101'},
      {'input' : 'ANZ', 'replaceCharacters': ['\\', '/'], 'expectedOutput' : '\\ /\\\\\\ \\/\\/'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encryptTomTomCode(elem['input'], elem['replaceCharacters']);
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
      {'input' : '', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : ''},
  
      {'input' : '/', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : 'A'},
      {'input' : '\\///', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : 'N'},
      {'input' : '/\\/\\', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : 'Z'},
  
      {'input' : '/ \\/// /\\/\\', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : 'ANZ'},
      {'input' : '/  \\///  /\\/\\', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : 'ANZ'},
      {'input' : '  /   \\///   /\\/\\  ', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : 'ANZ'},
  
      {'input' : '///// \\\\\\\\\\ /\\/\\/\\/\\', 'replaceCharacters': ['/', '\\'], 'expectedOutput' : ''},
      
      {'input' : '/ \\/// /\\/\\', 'replaceCharacters': ['0', '1'], 'expectedOutput' : ''},
      {'input' : '/ \\/// /\\/\\', 'replaceCharacters': ['\\', '/'], 'expectedOutput' : 'IY'},
  
      {'input' : '0 1000 0101', 'replaceCharacters': ['0', '1'], 'expectedOutput' : 'ANZ'},
      {'input' : '1 0111 1010', 'replaceCharacters': ['1', '0'], 'expectedOutput' : 'ANZ'},
  
      {'input' : '- \\--- -\\-\\', 'replaceCharacters': ['-', '\\'], 'expectedOutput' : 'ANZ'},
      {'input' : '] []]] ][][', 'replaceCharacters': [']', '['], 'expectedOutput' : 'ANZ'},
  
      {'input' : '/ \\/// /\\/\\', 'replaceCharacters': ['', ''], 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decryptTomTomCode(elem['input'], elem['replaceCharacters']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}