import 'dart:io' as io;
import 'dart:typed_data';

import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_image_reader.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_language.dart';
import 'package:path/path.dart' as path;

var testDirPath = 'test/resources/piet/';

Uint8List _getFileData(String name) {
  io.File file = io.File(path.join(testDirPath, name));
  return file.readAsBytesSync();
}

void main() {
  group("animated_image_morse_code.analyseImageMorseCode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : 'erat2_big.png', 'inputText' : '5', 'expectedOutput' : '  '},
      {'input' : 'fibonacci_big.gif', 'inputText' : '', 'expectedOutput' : '  '},
      {'input' : 'hanoibig.gif', 'inputText' : '', 'expectedOutput' : '-5\b2-6 0\b'},
      {'input' : 'hello_medium.gif', 'inputText' : '', 'expectedOutput' : 'Hello world!'},
      {'input' : 'hello_world_big.png', 'inputText' : '', 'expectedOutput' : 'Hello world!'},
      {'input' : 'nprime.gif', 'inputText' : 'Y\n', 'expectedOutput' : '  '},
      {'input' : 'primetest.png', 'inputText' : 'n', 'expectedOutput' : '  '},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await interpretPiet(PietImageReader().readImage(_getFileData(elem['input'])), elem['inputText']);
        expect(_actual.output, elem['expectedOutput']);
      });
    });
  });

}