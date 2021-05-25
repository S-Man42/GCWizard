import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/images_and_files/animated_image_morse_code.dart';
import 'package:tuple/tuple.dart';

void main() {
  var signal1 = {true: 400, true: 400, true: 400, true: 1000, true: 1000, true: 1000, false: 400, false: 400, false: 400, false: 1000, false: 1000, false: 1000, false: 1000, false: 1500, false: 1500};

  group("animated_image_morse_code.foundSignalTimes:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : signal1, 'expectedOutput' : Tuple3<int, int, int>(700, 700, 1250 )},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = foundSignalTimes(elem['input'], elem['key'], elem['oneCharStart']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}