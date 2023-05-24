import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group("Parser.geohashing.parse:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      //{'text': '', 'expectedOutput': null},
      {'text': '2015-03-27 34.123,-111.456', 'expectedOutput': {'format': CoordinateFormatKey.GEOHASHING, 'coordinate': LatLng(34.520364031734495, -111.75641517793687)}},
      {'text': '34.123,-111.456 2015-03-27', 'expectedOutput': {'format': CoordinateFormatKey.GEOHASHING, 'coordinate': LatLng(34.520364031734495, -111.75641517793687)}},
      {'text': '2008-09-10 34.123,-111.456', 'expectedOutput': {'format': CoordinateFormatKey.GEOHASHING, 'coordinate': LatLng(34.380395695429435, -111.6951528305385)}},
      {'text': '2015-05-05 34.123,-111.456', 'expectedOutput': {'format': CoordinateFormatKey.GEOHASHING, 'coordinate': LatLng(34.380395695429435, -111.6951528305385)}},
    ];

    for (var elem in _inputsToExpected) {
      test('text: ${elem['text']}', () {
        var _actual = Geohashing.parse(elem['text'] as String)?.toLatLng();
        if (_actual == null) {
          expect(null, elem['expectedOutput']);
        } else {
          print(_actual.toString());
          expect((_actual.latitude - ((elem['expectedOutput'] as Map<String, Object>)['coordinate'] as LatLng).latitude).abs() < 1e-8, true);
          expect((_actual.longitude - ((elem['expectedOutput'] as Map<String, Object>)['coordinate'] as LatLng).longitude).abs() < 1e-8, true);
        }
      });
    }
  });
}