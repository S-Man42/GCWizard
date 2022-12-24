import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/widgets/utils/file_utils.dart';

void main() {

  group("file_utils.StringExportImport:", () {

    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'test', 'expectedOutput' : 'test'},
      {'input' : 'πTest', 'expectedOutput' : 'πTest'},
      {'input' : 'þ¥µþµ¥¥¥¥þµþ', 'expectedOutput' : 'þ¥µþµ¥¥¥¥þµþ'},
      {'input' : 'test1\ntest2', 'expectedOutput' : 'test1\ntest2'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = convertBytesToString(convertStringToBytes(elem['input']));
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
