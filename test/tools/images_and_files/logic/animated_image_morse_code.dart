import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/images_and_files/animated_image_morse_code/logic/animated_image_morse_code.dart';
import 'package:tuple/tuple.dart';

void main() {
  var signal1 = <Tuple2<bool, int>>[
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(true, 1000),
      Tuple2<bool, int>(true, 1000),
      Tuple2<bool, int>(true, 1000),
      Tuple2<bool, int>(false, 400),
      Tuple2<bool, int>(false, 400),
      Tuple2<bool, int>(false, 400),
      Tuple2<bool, int>(false, 1000),
      Tuple2<bool, int>(false, 1000),
      Tuple2<bool, int>(false, 1000),
      Tuple2<bool, int>(false, 1000),
      Tuple2<bool, int>(false, 1500),
      Tuple2<bool, int>(false, 1500)];

  var signal2 = <Tuple2<bool, int>>[
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(true, 1000),
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(true, 1000),
      Tuple2<bool, int>(true, 1000),
      Tuple2<bool, int>(false, 1500),
      Tuple2<bool, int>(false, 1500),
      Tuple2<bool, int>(false, 400),
      Tuple2<bool, int>(false, 400),
      Tuple2<bool, int>(false, 1000),
      Tuple2<bool, int>(false, 1000),
      Tuple2<bool, int>(false, 400),
      Tuple2<bool, int>(false, 1000),
      Tuple2<bool, int>(false, 1000)];

  var signal3 = <Tuple2<bool, int>>[
      Tuple2<bool, int>(true, 380),
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(true, 1050),
      Tuple2<bool, int>(true, 420),
      Tuple2<bool, int>(true, 950),
      Tuple2<bool, int>(true, 1000),
      Tuple2<bool, int>(false, 1500),
      Tuple2<bool, int>(false, 1500),
      Tuple2<bool, int>(false, 400),
      Tuple2<bool, int>(false, 380),
      Tuple2<bool, int>(false, 950),
      Tuple2<bool, int>(false, 1020),
      Tuple2<bool, int>(false, 420),
      Tuple2<bool, int>(false, 1000),
      Tuple2<bool, int>(false, 1000)];

  var signal4 = <Tuple2<bool, int>>[
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(false, 400)];

  var signal5 = <Tuple2<bool, int>>[
      Tuple2<bool, int>(true, 400),
      Tuple2<bool, int>(false, 400),
      Tuple2<bool, int>(false, 600)];


  group("animated_image_morse_code.foundSignalTimes:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : signal1, 'expectedOutput' : Tuple3<int, int, int>(700, 700, 1250 )},
      {'input' : signal2, 'expectedOutput' : Tuple3<int, int, int>(700, 700, 1250 )},
      {'input' : signal3, 'expectedOutput' : Tuple3<int, int, int>(685, 685, 1260 )},
      {'input' : signal4, 'expectedOutput' : Tuple3<int, int, int>(400, 400, 400 )},
      {'input' : signal5, 'expectedOutput' : Tuple3<int, int, int>(400, 500, 500 )},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = foundSignalTimes(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}