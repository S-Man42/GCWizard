import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/centroid.dart';
import 'package:latlong2/latlong.dart';

import 'utils.dart';

void main() {
  group("Centroid.centroid:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'coords' : [LatLng(-21.1333, -175.2), LatLng(-8.53333, 179.2167)], 'expectedOutput': LatLng(-14.833315, -177.99165)}
    ];

    _inputsToExpected.forEach((elem) {
      test('coords: ${elem['coords']}', () {
        var actual = centroid(elem['coords']);
        expect(equalsLatLng(actual, elem['expectedOutput']), true);
      });
    });
  });
}