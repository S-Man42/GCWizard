import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon_variablewaypoint.dart';
import 'package:latlong/latlong.dart';

void main() {

  group("Parser.latlonVariableWaypoint.parseVariableLatLon:", () {
    final expectedLatLngList = [
      LatLng(51.11960894786239, 0.42652334719892887),
      LatLng(51.11960492060995, 11.426523663312299),
      LatLng(51.11960089147215, 22.4265239678175),
      LatLng(51.11959282759345, 44.426524541965485),
      LatLng(51.22619484235261, 0.42079431270562384),
      LatLng(51.226196421033954, 11.420783247210858),
      LatLng(51.226198012378866, 24.420772183774734),
      LatLng(51.22620123306048, 56.420750063225206),
      LatLng(51.34292319020224, 0.41491506976384096),
      LatLng(51.34293247464074, 11.414921985728482),
      LatLng(51.34294175286147, 28.414928928816426),
      LatLng(51.34296029052551, 104.41494289630785),
    ];

    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': 'N 51.[A][A+1] E [B][B^A].[4]23', 'values': {'A': '1-3', 'B': '4-0#2,1', 'C': '12,34'}, 'projectionData': {'bearing': '[A]00.[B]', 'distance': '[A*2]50, [B+5]', 'ellipsoid': getEllipsoidByName('WGS84')}, 'expectedOutput': expectedLatLngList},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}, values: ${elem['values']}, projectionData: ${elem['projectionData']}', () {
        var _actual = parseVariableLatLon(elem['text'], elem['values'], projectionData: elem['projectionData']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}