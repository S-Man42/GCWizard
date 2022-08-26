import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/wet_bulb_temperature.dart';

void main() {
  group("wet_bulb_temperature.calculate:", () {
    // https://climate-preparedness.com/understanding-wet-bulb-temperature-and-why-it-is-so-dangerous/
    List<Map<String, dynamic>> _inputsToExpected = [
      {'temperature' : 20.0, 'humidity' : 0.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'expectedOutput' : '14.8'},
      {'temperature' : 38.0, 'humidity' : 0.0, 'temperatureUnit' : TEMPERATURE_CELSIUS,  'expectedOutput' : '25.8'},
      {'temperature' : 42.0, 'humidity' : 0.0, 'temperatureUnit' : TEMPERATURE_CELSIUS,  'expectedOutput' : '28.1'},
      {'temperature' : 46.0, 'humidity' : 0.0, 'temperatureUnit' : TEMPERATURE_CELSIUS, 'expectedOutput' : '30.3'},
      {'temperature' : 50.0, 'humidity' : 0.0, 'temperatureUnit' : TEMPERATURE_CELSIUS,  'expectedOutput' : '32.5'},
      {'temperature' : 30.0, 'humidity' : 15.0, 'temperatureUnit' : TEMPERATURE_CELSIUS,  'expectedOutput' : '33.988'},
      {'temperature' : 30.0, 'humidity' : 25.0, 'temperatureUnit' : TEMPERATURE_CELSIUS,  'expectedOutput' : '42.375'},
    ];

    _inputsToExpected.forEach((elem) {
      test('temperature: ${elem['temperature']}, humidity: ${elem['humidity']}, temperatureUnit: ${elem['temperatureUnit'].symbol}', () {
        var _actual = calculateWetBulbTemperature(elem['temperature'], elem['humidity'], elem['temperatureUnit']);
        expect(_actual.WBT.toStringAsFixed(3), elem['expectedOutput']);
      });
    });
  });
}
