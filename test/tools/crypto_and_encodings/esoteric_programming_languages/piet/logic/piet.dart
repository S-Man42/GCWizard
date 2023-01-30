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
  group("piet.interpretPiet:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : 'nfib.png', 'inputText' : '', 'expectedOutput' :
      ''},

      //{'input' : 'erat2_big.png', 'inputText' : '5', 'expectedOutput' : '  '},
      //{'input' : 'fibonacci_big.gif', 'inputText' : '', 'expectedOutput' : '  '},
      {'input' : 'hanoibig.gif', 'inputText' : null, 'expectedOutput' : '-5\b2-6 0\b'},
      {'input' : 'hello_medium.gif', 'inputText' : null, 'expectedOutput' : 'Hello world!'},
      {'input' : 'hello_world_big.png', 'inputText' : null, 'expectedOutput' : 'Hello world!'},
      {'input' : 'nprime.gif', 'inputText' : '5', 'expectedOutput' : 'Y\n'},
      {'input' : 'nprime.gif', 'inputText' : '6', 'expectedOutput' : 'N\n'},
      {'input' : 'primetest.png', 'inputText' : '7', 'expectedOutput' : 'Y\n'},
      {'input' : 'nprime-big.gif', 'inputText' : '17', 'expectedOutput' : 'Y\n'},

      {'input' : 'hi.png', 'inputText' : '', 'expectedOutput' : 'Hi'},
      {'input' : 'loop.gif', 'inputText' : '', 'expectedOutput' : '  '},
      {'input' : 'loop-big.gif', 'inputText' : '', 'expectedOutput' : '  '},
      {'input' : 'nfib.png', 'inputText' : '', 'expectedOutput' :
      ''},
      {'input' : 'nfib-big.gif', 'inputText' : '', 'expectedOutput' : '  '},
      {'input' : 'nhello.gif', 'inputText' : '', 'expectedOutput' : '  '},
      {'input' : 'nhello-big.gif', 'inputText' : '', 'expectedOutput' : '  '},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await interpretPiet(PietImageReader().readImage(_getFileData(elem['input'])), elem['inputText']);
        expect(_actual.output, elem['expectedOutput']);
      });
    });
  });

}