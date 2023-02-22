import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_rgb.dart';

void main() {
  group("Colors.hex:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : RGB(123, 230, 14), 'expectedOutput' : '#7BE60E'},
      {'input' : RGB(0, 0, 0), 'expectedOutput' : '#000000'},
      {'input' : RGB(255, 255, 255), 'expectedOutput' : '#FFFFFF'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var hexCode = HexCode.fromRGB(elem['input']);
        var _actual = hexCode.toString();
        expect(_actual, elem['expectedOutput']);
        expect(hexCode.toRGB().toString(), elem['input'].toString());
      });
    });
  });
}