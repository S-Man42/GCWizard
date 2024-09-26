import 'dart:io' as io;
import 'dart:typed_data';

import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/tools/images_and_files/visual_cryptography/logic/visual_cryptography.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/list_utils.dart';
import 'package:path/path.dart' as path;
import 'package:tuple/tuple.dart';

var testDirPath = 'test/tools/images_and_files/visual_cryptography/resources/';

Uint8List _getFileData(String name) {
  io.File file = io.File(path.join(testDirPath, name));
  return file.readAsBytesSync();
}

void main() {

  group("visual_cryptography.decodeImagesAsync:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'image1' : 'test1_1.png', 'image2' : 'test1_2.png', 'offsetX' : 0, 'offsetY' : 0, 'expectedOutput' : 'result1.png'},
      {'image1' : 'test2_1.png', 'image2' : 'test2_2.png', 'offsetX' : 2, 'offsetY' : 1, 'expectedOutput' : 'result2.png'},
      {'image1' : 'test3_1.png', 'image2' : 'test3_2.png', 'offsetX' : 4, 'offsetY' : 2, 'expectedOutput' : 'result3.png'},
    ];

    for (var elem in _inputsToExpected) {
      test('image1: ${elem['image1']} image2: ${elem['image2']}', () async {
        var para = Tuple4<Uint8List, Uint8List, int, int>(
          _getFileData(elem['image1'] as String),
          _getFileData(elem['image2'] as String),
          elem['offsetX'] as int, elem['offsetY'] as int);
        var _actual = await decodeImagesAsync(GCWAsyncExecuterParameters(para));
        expect(listEquals(_actual!, _getFileData(elem['expectedOutput'] as String)), true);
      });
    }
  });

  group("visual_cryptography.encodeImagesAsync:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'expectedOutput1' : 'resultKey1.png', 'offsetX' : 0, 'offsetY' : 0, 'scale' : 100, 'pixelSize' : 1, 'image1' : 'source1.png', 'image2' : 'test1_1.png'},
    ];

    for (var elem in _inputsToExpected) {
      test('image1: ${elem['image1']} offsetX: ${elem['offsetX']} offsetY: ${elem['offsetY']}', () async {
        var para = Tuple6<Uint8List, Uint8List?, int, int, int, int>(
            _getFileData(elem['image1'] as String),
            _getFileData(elem['image2'] as String),
            elem['offsetX'] as int, elem['offsetY'] as int,
            elem['scale'] as int, elem['pixelSize'] as int);
        var _actual = await encodeImagesAsync(GCWAsyncExecuterParameters(para));
        //var f = io.File(path.join(testDirPath, 'Key.png'));
        //f.writeAsBytes(_actual!.item1);
print(_actual!.item1.length.toString() + ' ' + _getFileData(elem['expectedOutput1'] as String).length.toString());
        expect(listEquals(_actual.item1, _getFileData(elem['expectedOutput1'] as String)), true);
      });
    }
  });
}