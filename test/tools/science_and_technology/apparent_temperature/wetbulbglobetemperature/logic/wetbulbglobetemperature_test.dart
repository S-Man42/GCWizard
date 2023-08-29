import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/_common/logic/common.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_globe_temperature/logic/wet_bulb_globe_temperature.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:latlong2/latlong.dart';

void main() {

  DateTimeTimezone _currentDateTime = DateTimeTimezone(datetime: DateTime(2022, 07, 01, 12, 00, 00), timezone: const Duration(hours: -5));
  LatLng _currentCoords = const LatLng(35.9, -78.8);
  double _currentWindSpeed = 1; // = 2.23693629 mph

  double _currentWindSpeedHeight = 10;
  double _currentAirPressure = 1013.25;
  bool _currentAreaUrban = false;
  CLOUD_COVER _currentCloudCover = CLOUD_COVER.CLEAR_0;
  double F86inC = 30.0;
  double F104inC = 40.0;
  double F122inC = 50.0;

  group("wet_bulb_temperature.calculate.WBGT.WBGT:", () {
    // https://wbgt.app/
    List<Map<String, Object?>> _inputsToExpected = [
      {'temperature' : F86inC, 'humidity' : 50.0, 'expectedOutput' : 30.77777778}, // 87.4 °F
      {'temperature' : F104inC, 'humidity' : 50.0, 'expectedOutput' : 39.05555556}, // 102.3 °F
      {'temperature' : F122inC, 'humidity' : 50.0, 'expectedOutput' : 47.55555556},// 117.6 °F

      {'temperature' : F86inC, 'humidity' : 60.0, 'expectedOutput' : 31.94444444}, // 89.5 °F
      {'temperature' : F104inC, 'humidity' : 60.0, 'expectedOutput' : 40.55555556}, // 105 °F
      {'temperature' : F122inC, 'humidity' : 60.0, 'expectedOutput' : 49.33333333}, // 120.8 °F

      {'temperature' : F86inC, 'humidity' : 70.0, 'expectedOutput' : 33.05555556}, // 91.5 °F
      {'temperature' : F104inC, 'humidity' : 70.0, 'expectedOutput' : 41.94444444}, // 107.5 °F
      {'temperature' : F122inC, 'humidity' : 70.0, 'expectedOutput' : 51.0}, // 123.8 °F

      {'temperature' : F86inC, 'humidity' : 80.0, 'expectedOutput' : 34.11111111}, // 93.4 °F
      {'temperature' : F104inC, 'humidity' : 80.0, 'expectedOutput' : 43.22222222}, // 109.8 °F
      {'temperature' : F122inC, 'humidity' : 80.0, 'expectedOutput' : 52.5}, // 126.5 °F
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
        expect(_actual.ceil(), (elem['expectedOutput'] as double).ceil());
      });
    }
  });

  group("wet_bulb_temperature.calculate.WBGT.OSHA:", () {
    // https://www.osha.gov/heat-exposure/wbgt-calculator
    LatLng _currentCoords = const LatLng(35.0, -78.0);

    List<Map<String, Object?>> _inputsToExpected = [
      {'temperature' : F86inC, 'humidity' : 50.0, 'expectedOutput' : 31.0},
      {'temperature' : F104inC, 'humidity' : 50.0, 'expectedOutput' : 40.0},
      {'temperature' : F122inC, 'humidity' : 50.0, 'expectedOutput' : 48.0},

      {'temperature' : F86inC, 'humidity' : 60.0, 'expectedOutput' : 33.0},
      {'temperature' : F104inC, 'humidity' : 60.0, 'expectedOutput' : 41.0},
      {'temperature' : F122inC, 'humidity' : 60.0, 'expectedOutput' : 50.0},

      {'temperature' : F86inC, 'humidity' : 70.0, 'expectedOutput' : 34.0},
      {'temperature' : F104inC, 'humidity' : 70.0, 'expectedOutput' : 42.0},
      {'temperature' : F122inC, 'humidity' : 70.0, 'expectedOutput' : 51.0},

      {'temperature' : F86inC, 'humidity' : 80.0, 'expectedOutput' : 35.0},
      {'temperature' : F104inC, 'humidity' : 80.0, 'expectedOutput' : 44.0},
      {'temperature' : F122inC, 'humidity' : 80.0, 'expectedOutput' : 53.0},
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
        expect(_actual.ceil(), elem['expectedOutput']); // _actual.floor() < elem < _actual.ceil()
      });
    }
  });
}
