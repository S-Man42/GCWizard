import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/utci/logic/utci.dart';

void main() {

  double _currentWindSpeed = 1;

  group("utci.calculate.utci:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'temperature' : 30.0, 'humidity' : 50.0, 'expectedOutput' : 16.006507649716013},
      {'temperature' : 40.0, 'humidity' : 50.0, 'expectedOutput' : 26.549330636018627},
      {'temperature' : 50.0, 'humidity' : 50.0, 'expectedOutput' : 36.812275689130125},

      {'temperature' : 30.0, 'humidity' : 60.0, 'expectedOutput' : 17.61299187172026},
      {'temperature' : 40.0, 'humidity' : 60.0, 'expectedOutput' : 28.44354666875012},
      {'temperature' : 50.0, 'humidity' : 60.0, 'expectedOutput' : 38.973904999739204},

      {'temperature' : 30.0, 'humidity' : 70.0, 'expectedOutput' : 19.096757658323263},
      {'temperature' : 40.0, 'humidity' : 70.0, 'expectedOutput' : 30.169935090250426},
      {'temperature' : 50.0, 'humidity' : 70.0, 'expectedOutput' : 40.906615297195245},

      {'temperature' : 30.0, 'humidity' : 80.0, 'expectedOutput' : 20.475487634750024},
      {'temperature' : 40.0, 'humidity' : 80.0, 'expectedOutput' : 31.744414628454166},
      {'temperature' : 50.0, 'humidity' : 80.0, 'expectedOutput' : 42.65849268513075},
    ];

    for (var elem in _inputsToExpected) {
      test('temperature: ${elem['temperature']}, humidity: ${elem['humidity']}', () {
        var _actual = calculateUTCI(
          elem['temperature'] as double,
          elem['humidity'] as double,
          _currentWindSpeed,
        );
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}
