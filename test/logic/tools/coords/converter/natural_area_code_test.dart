import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/converter/natural_area_code.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:latlong/latlong.dart';

void main() {
  group("Converter.naturalAreaCode.latlonToNaturalAreaCode:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'coord': LatLng(51.907002, 9.113159), 'expectedOutput': NaturalAreaCode('HQRGL6Z7', 'RMJ1H830')},

      {'coord': LatLng(0.0, 0.0), 'expectedOutput': NaturalAreaCode('H0000000', 'H0000000')},
      {'coord': LatLng(89.99999, 179.99999), 'expectedOutput': NaturalAreaCode('ZZZZZ9QH', 'ZZZZXMGZ')},
      {'coord': LatLng(-89.99999, 179.99999), 'expectedOutput': NaturalAreaCode('ZZZZZ9QH', '00001BH0')},
      {'coord': LatLng(89.99999, -179.99999), 'expectedOutput': NaturalAreaCode('00000N7H', 'ZZZZXMGZ')},
      {'coord': LatLng(-89.99999, -179.99999), 'expectedOutput': NaturalAreaCode('00000N7H', '00001BH0')},
    ];

    _inputsToExpected.forEach((elem) {
      test('coord: ${elem['coord']}', () {
        var _actual = latLonToNaturalAreaCode(elem['coord']);
        expect(_actual.x, elem['expectedOutput'].x);
        expect(_actual.y, elem['expectedOutput'].y);
      });
    });
  });

  group("Converter.naturalAreaCode.naturalAreaCodeToLatLon:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'expectedOutput': LatLng(51.907002, 9.113159), 'nac': NaturalAreaCode('HQRGL6Z7', 'RMJ1H830')},

      {'expectedOutput': LatLng(0.0, 0.0), 'nac': NaturalAreaCode('H0000000', 'H0000000')},
      {'expectedOutput': LatLng(89.99999, 179.99999), 'nac': NaturalAreaCode('ZZZZZ9QH', 'ZZZZXMGZ')},
      {'expectedOutput': LatLng(-89.99999, 179.99999), 'nac': NaturalAreaCode('ZZZZZ9QH', '00001BH0')},
      {'expectedOutput': LatLng(89.99999, -179.99999), 'nac': NaturalAreaCode('00000N7H', 'ZZZZXMGZ')},
      {'expectedOutput': LatLng(-89.99999, -179.99999), 'nac': NaturalAreaCode('00000N7H', '00001BH0')},
    ];

    _inputsToExpected.forEach((elem) {
      test('nac: ${elem['nac']}', () {
        var _actual = naturalAreaCodeToLatLon(elem['nac']);
        expect((_actual.latitude - elem['expectedOutput'].latitude).abs() < 1e-4, true);
        expect((_actual.longitude - elem['expectedOutput'].longitude).abs() < 1e-4, true);
      });
    });
  });
}