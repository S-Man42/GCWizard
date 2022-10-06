import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/heat_index.dart';

void main() {
  group("heat.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'temperature' : 56.0, 'humidity' : 30.0, 'expectedOutput' : '87.287'},
      {'temperature' : 0.0, 'humidity' : 0.0, 'expectedOutput' : '-8.785'},
    ];

    _inputsToExpected.forEach((elem) {
      test('temperature: ${elem['temperature']}, humidity: ${elem['humidity']}, temperatureUnit: ${elem['temperatureUnit'].symbol}', () {
        var _actual = calculateHeatIndex(elem['temperature'], elem['humidity']);
        expect(_actual.toStringAsFixed(3), elem['expectedOutput']);
      });
    });
  });
}
