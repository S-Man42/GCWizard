import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/images_and_files/animated_image_morse_code.dart';
import 'package:tuple/tuple.dart';

void main() {
  var signal1 = <Tuple2<bool, int>>[];
    signal1.add(Tuple2<bool, int>(true, 400));
    signal1.add(Tuple2<bool, int>(true, 400));
    signal1.add(Tuple2<bool, int>(true, 400));
    signal1.add(Tuple2<bool, int>(true, 1000));
    signal1.add(Tuple2<bool, int>(true, 1000));
    signal1.add(Tuple2<bool, int>(true, 1000));
    signal1.add(Tuple2<bool, int>(false, 400));
    signal1.add(Tuple2<bool, int>(false, 400));
    signal1.add(Tuple2<bool, int>(false, 400));
    signal1.add(Tuple2<bool, int>(false, 1000));
    signal1.add(Tuple2<bool, int>(false, 1000));
    signal1.add(Tuple2<bool, int>(false, 1000));
    signal1.add(Tuple2<bool, int>(false, 1000));
    signal1.add(Tuple2<bool, int>(false, 1500));
    signal1.add(Tuple2<bool, int>(false, 1500));

  var signal2 = <Tuple2<bool, int>>[];
  signal2.add(Tuple2<bool, int>(true, 400));
  signal2.add(Tuple2<bool, int>(true, 400));
  signal2.add(Tuple2<bool, int>(true, 1000));
  signal2.add(Tuple2<bool, int>(true, 400));
  signal2.add(Tuple2<bool, int>(true, 1000));
  signal2.add(Tuple2<bool, int>(true, 1000));
  signal2.add(Tuple2<bool, int>(false, 1500));
  signal2.add(Tuple2<bool, int>(false, 1500));
  signal2.add(Tuple2<bool, int>(false, 400));
  signal2.add(Tuple2<bool, int>(false, 400));
  signal2.add(Tuple2<bool, int>(false, 1000));
  signal2.add(Tuple2<bool, int>(false, 1000));
  signal2.add(Tuple2<bool, int>(false, 400));
  signal2.add(Tuple2<bool, int>(false, 1000));
  signal2.add(Tuple2<bool, int>(false, 1000));

  var signal3 = <Tuple2<bool, int>>[];
  signal3.add(Tuple2<bool, int>(true, 380));
  signal3.add(Tuple2<bool, int>(true, 400));
  signal3.add(Tuple2<bool, int>(true, 1050));
  signal3.add(Tuple2<bool, int>(true, 420));
  signal3.add(Tuple2<bool, int>(true, 950));
  signal3.add(Tuple2<bool, int>(true, 1000));
  signal3.add(Tuple2<bool, int>(false, 1500));
  signal3.add(Tuple2<bool, int>(false, 1500));
  signal3.add(Tuple2<bool, int>(false, 400));
  signal3.add(Tuple2<bool, int>(false, 380));
  signal3.add(Tuple2<bool, int>(false, 950));
  signal3.add(Tuple2<bool, int>(false, 1020));
  signal3.add(Tuple2<bool, int>(false, 420));
  signal3.add(Tuple2<bool, int>(false, 1000));
  signal3.add(Tuple2<bool, int>(false, 1000));


  group("animated_image_morse_code.foundSignalTimes:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : signal1, 'expectedOutput' : Tuple3<int, int, int>(700, 700, 1250 )},
      {'input' : signal2, 'expectedOutput' : Tuple3<int, int, int>(700, 700, 1250 )},
      {'input' : signal3, 'expectedOutput' : Tuple3<int, int, int>(685, 685, 1260 )},
    ];
    // print(signal1.length);
    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = foundSignalTimes(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}