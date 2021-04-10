import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:latlong/latlong.dart';

void main() {
  group("Converter.quadtree.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '1203203022132122220122000301310333201333', 'expectedOutput': {'format': keyCoordsQuadtree, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': '41203203022132122220122000301310333201333', 'expectedOutput': null},
      {'text': 'A1203203022132122220122000301310333201333', 'expectedOutput': null},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseQuadtreeToLatLon(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });
}