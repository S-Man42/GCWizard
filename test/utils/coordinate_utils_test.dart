import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/utils/coordinate_utils.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('CoordinateUtils.equalsBearing:', () {
    List<Map<String, Object>> _inputsToExpected = [
      {'a' : 0.0, 'b': 0.0, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 360.0, 'b': 360.0, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 0.0, 'b': 360.0, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 360.0, 'b': 0.0, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 359.999, 'b': 0.001, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 0.001, 'b': 359.999, 'tolerance': 0.01, 'expectedOutput': true},

      {'a' : 0.001, 'b': 359.999, 'tolerance': 0.0001, 'expectedOutput': false},
      {'a' : 359.999, 'b': 0.001, 'tolerance': 0.0001, 'expectedOutput': false},

      {'a' : -0.001, 'b': 0.001, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 0.001, 'b': -0.001, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : -0.001, 'b': -0.001, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 360.001, 'b': -0.001, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 360.001, 'b': 0.001, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 720.001, 'b': 0.001, 'tolerance': 0.01, 'expectedOutput': true},
      {'a' : 360.001, 'b': -0.001, 'tolerance': 0.001, 'expectedOutput': false},

      {'a' : 176.0, 'b': 175.999, 'tolerance': 0.01, 'expectedOutput': true},
    ];

    for (var elem in _inputsToExpected) {
      test('a: ${elem['a']}, b:  ${elem['b']}, tolerance:  ${elem['tolerance']}', () {
        var _actual = equalsBearing(elem['a'] as double, elem['b'] as double, tolerance: elem['tolerance'] as double);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group('CoordinateUtils.equalsLatLng:', () {
    List<Map<String, Object>> _inputsToExpected = [
      {'a' : LatLng(42,21), 'b': LatLng(42,21), 'expectedOutput': true},
      {'a' : LatLng(41,21), 'b': LatLng(42,21), 'expectedOutput': false},
      {'a' : LatLng(42,21), 'b': LatLng(42,22), 'expectedOutput': false},

      {'a' : LatLng(41.9999999999999999,22), 'b': LatLng(42,22), 'expectedOutput': true},
      {'a' : LatLng(42,22), 'b': LatLng(42,22.0000000000001), 'expectedOutput': true},

      {'a' : LatLng(90, 20), 'b': LatLng(90, 20), 'expectedOutput': true},
      {'a' : LatLng(90, 20), 'b': LatLng(90, 40), 'expectedOutput': true},
      {'a' : LatLng(-90, 20), 'b': LatLng(90, 20), 'expectedOutput': false},
      {'a' : LatLng(-90, 20), 'b': LatLng(-90, 20), 'expectedOutput': true},
      {'a' : LatLng(-90, 40), 'b': LatLng(-90, 20), 'expectedOutput': true},
      {'a' : LatLng(-89.9999999999999, 40), 'b': LatLng(-90, 20), 'expectedOutput': true},
      {'a' : LatLng(-89.9999999999999, 40), 'b': LatLng(-89.9999999999999, 20), 'expectedOutput': true},
      {'a' : LatLng(90, 40), 'b': LatLng(89.9999999999999, 20), 'expectedOutput': true},
      {'a' : LatLng(90, 40), 'b': LatLng(89.99, 20), 'expectedOutput': false},

      {'a' : LatLng(60, 180), 'b': LatLng(60, 180), 'expectedOutput': true},
      {'a' : LatLng(60, 180), 'b': LatLng(60, -180), 'expectedOutput': true},
      {'a' : LatLng(60, 179.9999999999999), 'b': LatLng(60, -179.9999999999999), 'expectedOutput': true},
      {'a' : LatLng(60, 178.9999999999999), 'b': LatLng(60, -179.9999999999999), 'expectedOutput': false},
      {'a' : LatLng(60, 179.9999999999999), 'b': LatLng(-60, -179.9999999999999), 'expectedOutput': false},
    ];

    for (var elem in _inputsToExpected) {
      test('a: ${elem['a']}, b:  ${elem['b']}', () {
        var _actual = equalsLatLng(elem['a'] as LatLng, elem['b'] as LatLng);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}