import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_globe_temperature/logic/wet_bulb_globe_temperature.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:latlong2/latlong.dart';

void main() {

  DateTimeTimezone _currentDateTime = DateTimeTimezone(datetime: DateTime(2022, 07, 01, 12, 00, 00), timezone: Duration(hours: 5));
  LatLng _currentCoords = LatLng(35.9, -78.8);
  double _currentWindSpeed = 1;
  double _currentWindSpeedHeight = 10;
  double _currentAirPressure = 1013.25;
  bool _currentAreaUrban = false;
  CLOUD_COVER _currentCloudCover = CLOUD_COVER.CLEAR_0;
  double C30inF = 86.0;
  double C40inF = 104.0;
  double C50inF = 122.0;


  group("wet_bulb_temperature.calculate.WBT:", () {
    // https://wbgt.app/
    List<Map<String, Object?>> _inputsToExpected = [
      {'temperature' : C30inF, 'humidity' : 50.0, 'expectedOutput' : 6.13},
      {'temperature' : C40inF, 'humidity' : 50.0, 'expectedOutput' : 13.59},
      {'temperature' : C50inF, 'humidity' : 50.0, 'expectedOutput' : 15.24},

      {'temperature' : C30inF, 'humidity' : 60.0, 'expectedOutput' : 6.13},
      {'temperature' : C40inF, 'humidity' : 60.0, 'expectedOutput' : 13.59},
      {'temperature' : C50inF, 'humidity' : 60.0, 'expectedOutput' : 15.24},

      {'temperature' : C30inF, 'humidity' : 70.0, 'expectedOutput' : 6.13},
      {'temperature' : C40inF, 'humidity' : 70.0, 'expectedOutput' : 13.59},
      {'temperature' : C50inF, 'humidity' : 70.0, 'expectedOutput' : 15.24},

      {'temperature' : C30inF, 'humidity' : 80.0, 'expectedOutput' : 6.13},
      {'temperature' : C40inF, 'humidity' : 80.0, 'expectedOutput' : 13.59},
      {'temperature' : C50inF, 'humidity' : 80.0, 'expectedOutput' : 15.24},
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
