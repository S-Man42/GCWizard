import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/windchill.dart';

void main() {
  group("Windchill.calculate:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'temperature' : null, 'windspeed' : null, 'isMetric' : true, 'expectedOutput' : null},
      {'temperature' : null, 'windspeed' : null, 'isMetric' : false, 'expectedOutput' : null},
      {'temperature' : -10.0, 'windspeed' : null, 'isMetric' : true, 'expectedOutput' : null},
      {'temperature' : -10.0, 'windspeed' : null, 'isMetric' : false, 'expectedOutput' : null},
      {'temperature' : null, 'windspeed' : -10.0, 'isMetric' : true, 'expectedOutput' : null},
      {'temperature' : null, 'windspeed' : -10.0, 'isMetric' : false, 'expectedOutput' : null},

      {'temperature' : -10.0, 'windspeed' : 5.0, 'isMetric' : true, 'expectedOutput' : -12.934},
      {'temperature' : -10.0, 'windspeed' : 5.0, 'isMetric' : false, 'expectedOutput' : -22.256},
      {'temperature' : 5.0, 'windspeed' : 5.0, 'isMetric' : true, 'expectedOutput' : 4.083},
      {'temperature' : 5.0, 'windspeed' : 5.0, 'isMetric' : false, 'expectedOutput' : -4.637},
      {'temperature' : 5.0, 'windspeed' : 10.0, 'isMetric' : true, 'expectedOutput' : 2.658},
      {'temperature' : 41.0, 'windspeed' : 6.22, 'isMetric' : false, 'expectedOutput' : 36.809},
    ];

    _inputsToExpected.forEach((elem) {
      test('temperature: ${elem['temperature']}, windspeed: ${elem['windspeed']}, isMetric: ${elem['isMetric']}', () {
        var _actual;
        if (elem['isMetric'])
          _actual = calcWindchillMetric(elem['temperature'], elem['windspeed']);
        else
          _actual = calcWindchillImperial(elem['temperature'], elem['windspeed']);

        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
