import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/converter/open_location_code.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:latlong/latlong.dart';

void main() {
  group("Converter.open_location_code.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'AGR76H6X+C95QFH', 'expectedOutput': null},
      {'text': '1GR76H6X+C95QFH', 'expectedOutput': null},
      {'text': '8GR76H6X+C95QFH', 'expectedOutput': {'format': keyCoordsOpenLocationCode, 'coordinate': LatLng(46.2110175, 025.5984958496)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseOpenLocationCode(elem['text'])?.toLatLng();;
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });}