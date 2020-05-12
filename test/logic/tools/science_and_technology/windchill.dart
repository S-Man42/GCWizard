import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/windchill.dart';

void main() {
  group("Windchill.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
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
    ];

    _inputsToExpected.forEach((elem) {
      test('temperature: ${elem['temperature']}, windspeed: ${elem['windspeed']}', () {
        var _actual = calcWindchill(elem['temperature'], elem['windspeed'], elem['isMetric']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
