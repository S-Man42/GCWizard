import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_globe_temperature/logic/wet_bulb_globe_temperature.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:latlong2/latlong.dart';

void main() {

  DateTimeTimezone _currentDateTime = DateTimeTimezone(datetime: DateTime(2022, 07, 01, 12, 00, 00), timezone: const Duration(hours: 5));
  LatLng _currentCoords = const LatLng(35.9, -78.8);
  double _currentWindSpeed = 1;
  double _currentWindSpeedHeight = 10;
  double _currentAirPressure = 1013.25;
  bool _currentAreaUrban = false;
  CLOUD_COVER _currentCloudCover = CLOUD_COVER.CLEAR_0;
  double F86inC = 30.0;
  double F104inC = 40.0;
  double F122inC = 50.0;


  group("wet_bulb_temperature.calculate.WBT:", () {
    // https://wbgt.app/
    List<Map<String, Object?>> _inputsToExpected = [
      {'temperature' : F86inC, 'humidity' : 50.0, 'expectedOutput' : 16.006507649716013},
      {'temperature' : F104inC, 'humidity' : 50.0, 'expectedOutput' : 26.549330636018627},
      {'temperature' : F122inC, 'humidity' : 50.0, 'expectedOutput' : 36.812275689130125},

      {'temperature' : F86inC, 'humidity' : 60.0, 'expectedOutput' : 17.61299187172026},
      {'temperature' : F104inC, 'humidity' : 60.0, 'expectedOutput' : 28.44354666875012},
      {'temperature' : F122inC, 'humidity' : 60.0, 'expectedOutput' : 38.973904999739204},

      {'temperature' : F86inC, 'humidity' : 70.0, 'expectedOutput' : 19.096757658323263},
      {'temperature' : F104inC, 'humidity' : 70.0, 'expectedOutput' : 30.169935090250426},
      {'temperature' : F122inC, 'humidity' : 70.0, 'expectedOutput' : 40.906615297195245},

      {'temperature' : F86inC, 'humidity' : 80.0, 'expectedOutput' : 20.475487634750024},
      {'temperature' : F104inC, 'humidity' : 80.0, 'expectedOutput' : 31.744414628454166},
      {'temperature' : F122inC, 'humidity' : 80.0, 'expectedOutput' : 42.65849268513075},
    ];

    for (var elem in _inputsToExpected) {
      test('temperature: ${elem['temperature']}, humidity: ${elem['humidity']}', () {
        var _actual = calculateWetBulbGlobeTemperature(
            _currentDateTime,
            _currentCoords,
            _currentWindSpeed,
            _currentWindSpeedHeight,
            elem['temperature'] as double, elem['humidity'] as double,
            _currentAirPressure,
            _currentAreaUrban,
            _currentCloudCover
        ).Twbg;
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}
