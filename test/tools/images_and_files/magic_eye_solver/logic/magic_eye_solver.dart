import 'dart:io' as io;
import 'dart:typed_data';

import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/images_and_files/magic_eye_solver/logic/magic_eye_solver.dart';
import 'package:path/path.dart' as path;

var testDirPath = '/resources/';

Uint8List _getFileData(String name) {
  io.File file = io.File(path.join(testDirPath, name));
  return file.readAsBytesSync();
}

void main() {

  group("magic_eye_solver.decodeImageAsync:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : 'magic_eye1.jpg', 'expectedOutput' : 0},
      {'input' : 'magic_eye2.png', 'expectedOutput' : 0},
      {'input' : 'atomium.jpg', 'expectedOutput' : 0},
      {'input' : 'dino.png', 'expectedOutput' : 0},
      {'input' : 'dolphins.jpg', 'expectedOutput' : 0},
      {'input' : 'planet.jpg', 'expectedOutput' : 0},
      {'input' : 'shark.jpg', 'expectedOutput' : 0},
      {'input' : 'thumbsup.jpg', 'expectedOutput' : 0},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await decodeImageAsync(_getFileData(elem['input']));
        expect(_actual.item3, elem['expectedOutput']);
      });
    });
  });

}