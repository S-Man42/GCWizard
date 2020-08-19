import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/heat.dart';

void main() {
  group("heat.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'temperature' : 56.0, 'humidity' : 30.0, 'isMetric' : true, 'expectedOutput' : '87.287'},
      {'temperature' : 56.0, 'humidity' : 30.0, 'isMetric' : false, 'expectedOutput' : '81.263'},
      {'temperature' : 0.0, 'humidity' : 0.0, 'isMetric' : true, 'expectedOutput' : '-8.785'},
      {'temperature' : 0.0, 'humidity' : 0.0, 'isMetric' : false, 'expectedOutput' : '-42.379'},
    ];

    _inputsToExpected.forEach((elem) {
      test('temperature: ${elem['temperature']}, humidity: ${elem['humidity']}, isMetric: ${elem['isMetric']}', () {
        var _actual;
        if (elem['isMetric'])
          _actual = calculateHeat(elem['temperature'], elem['humidity'], HeatTemperatureMode.Celsius);
        else
          _actual = calculateHeat(elem['temperature'], elem['humidity'], HeatTemperatureMode.Fahrenheit);

        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
