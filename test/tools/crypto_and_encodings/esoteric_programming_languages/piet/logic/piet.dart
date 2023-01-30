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

      //{'input' : 'erat2_big.png', 'inputText' : '5', 'expectedOutput' : '  '},
      //{'input' : 'fibonacci_big.gif', 'inputText' : '', 'expectedOutput' : '  '},
      {'input' : 'piet_hanoibig.gif', 'inputText' : null, 'expectedOutput' : '-5\b2-6 0\b'},
      {'input' : 'piet_nhello.gif', 'inputText' : '', 'expectedOutput' : 'hello world!\n'},
      {'input' : 'piet_nhello-big.gif', 'inputText' : '', 'expectedOutput' : 'hello world!\n'},
      {'input' : 'piet_hello.png', 'inputText' : null, 'expectedOutput' : 'Hello world!'},
      {'input' : 'piet_hello_medium.gif', 'inputText' : null, 'expectedOutput' : 'Hello world!'},
      {'input' : 'piet_hello_world_big.png', 'inputText' : null, 'expectedOutput' : 'Hello world!'},
      {'input' : 'piet_hello_artistic.gif', 'inputText' : null, 'expectedOutput' : 'Hello, world!\n'},
      //{'input' : 'piet_hello_artistic2.gif', 'inputText' : null, 'expectedOutput' : 'Hello, world!\n'},
      {'input' : 'Piet_helloworld-mondrian-big.png', 'inputText' : null, 'expectedOutput' : 'Hello, world!\n'},
      {'input' : 'piet_nprime.gif', 'inputText' : '5', 'expectedOutput' : 'Y\n'},
      {'input' : 'piet_nprime.gif', 'inputText' : '6', 'expectedOutput' : 'N\n'},
      {'input' : 'piet_nprime.gif', 'inputText' : '7', 'expectedOutput' : 'Y\n'},

      {'input' : 'piet_hi.png', 'inputText' : '', 'expectedOutput' : 'Hi\n'},
      {'input' : 'piet_loop.gif', 'inputText' : '', 'expectedOutput' : '10\n9\n8\n7\n6\n5\n4\n3\n2\n1\n'},
      {'input' : 'piet_loop-big.gif', 'inputText' : '', 'expectedOutput' : '10\n9\n8\n7\n6\n5\n4\n3\n2\n1\n'},
      {'input' : 'piet_nfib.gif', 'inputText' : '', 'expectedOutput' : '0\n1\n1\n2\n3\n5\n8\n13\n21\n34\n55\n89\n144\n233\n377\n610\n987\n'},
      {'input' : 'piet_nfib-big.gif', 'inputText' : '', 'expectedOutput' : '0\n1\n1\n2\n3\n5\n8\n13\n21\n34\n55\n89\n144\n233\n377\n610\n987\n'},

      {'input' : 'piet_alpha_filled.png', 'inputText' : '', 'expectedOutput' : 'abcdefghijklmnopqrstuvwxyz'},
      {'input' : 'piet_fizzbuzz.png', 'inputText' : '', 'expectedOutput' : '1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz\n13\n14\nFizzBuzz\n16\n'},
      {'input' : 'piet_factorial_big.png', 'inputText' : '3', 'expectedOutput' : '6'},
      {'input' : 'piet_factorial_big.png', 'inputText' : '5', 'expectedOutput' : '120'},
      {'input' : 'piet_factorial_big.png', 'inputText' : '7', 'expectedOutput' : '5040'},
      {'input' : 'piet_power2_big.png', 'inputText' : '5 3', 'expectedOutput' : '125'},
      {'input' : 'piet_tetris.png', 'inputText' : '', 'expectedOutput' : 'Tetris'},
      {'input' : 'piet _coords.png', 'inputText' : '', 'expectedOutput' : 'N 51 01.129 E 013 48.625'},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await interpretPiet(PietImageReader().readImage(_getFileData(elem['input'])), elem['inputText']);
        expect(_actual.output, elem['expectedOutput']);
      });
    });
  });

  // group("piet.pietSession:", () {
  //  var data = [
  //     [0xC00000, 0xFF0000, 0xFF0000, 0xFF0000, 0xFF0000],
  //     [0XFF0000, 0xFF0000, 0xFF0000, 0xFF0000, 0xFF0000],
  //     [0XFF0000, 0xC00000, 0x000000, 0xC00000, 0x000000],
  //     [0xFFC0FF, 0x000000, 0xFFC0FF, 0x000000, 0x000000],
  //     [0xFFC0FF, 0xFFC0FF, 0xFFC0FF, 0x000000, 0x000000],
  //   ];
  //
  //   List<Map<String, dynamic>> _inputsToExpected = [
  //     {'input' : data, 'expectedOutput' : '10'},
  //   ];
  //
  //   _inputsToExpected.forEach((elem) {
  //     test('input: ${elem['input']}', () async {
  //       var _actual =  _PietSession(elem['input']);
  //       expect(_actual.output, elem['expectedOutput']);
  //     });
  //   });
  // });
}