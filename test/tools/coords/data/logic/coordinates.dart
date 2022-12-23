import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/coords/data/logic/coordinates.dart';

void main() {
  group("Coordinate.normalizeDEC:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'coord' : DEC(10.0, 10.0), 'expectedOutput' : DEC(10.0, 10.0)},
      {'coord' : DEC(-10.0, -10.0), 'expectedOutput' : DEC(-10.0, -10.0)},

      {'coord' : DEC(90.0, 0.0), 'expectedOutput' : DEC(90.0, 0.0)},
      {'coord' : DEC(-90.0, 0.0), 'expectedOutput' : DEC(-90.0, 0.0)},
      {'coord' : DEC(0.0, 180.0), 'expectedOutput' : DEC(0.0, 180.0)},
      {'coord' : DEC(0.0, -180.0), 'expectedOutput' : DEC(0.0, -180.0)},

      {'coord' : DEC(91.0, 0.0), 'expectedOutput' : DEC(89.0, 180.0)},
      {'coord' : DEC(-91.0, 0.0), 'expectedOutput' : DEC(-89.0, 180.0)},
      {'coord' : DEC(91.0, 180.0), 'expectedOutput' : DEC(89.0, 0.0)},
      {'coord' : DEC(-91.0, 180.0), 'expectedOutput' : DEC(-89.0, 0.0)},
      {'coord' : DEC(91.0, -180.0), 'expectedOutput' : DEC(89.0, 0.0)},
      {'coord' : DEC(-91.0, -180.0), 'expectedOutput' : DEC(-89.0, 0.0)},

      {'coord' : DEC(0.0, 181.0), 'expectedOutput' : DEC(0.0, -179.0)},
      {'coord' : DEC(0.0, -181.0), 'expectedOutput' : DEC(0.0, 179.0)},

      {'coord' : DEC(180.0, 0.0), 'expectedOutput' : DEC(0.0, 180.0)},
      {'coord' : DEC(-180.0, 0.0), 'expectedOutput' : DEC(0.0, 180.0)},
      {'coord' : DEC(540.0, 0.0), 'expectedOutput' : DEC(0.0, 180.0)},
      {'coord' : DEC(-540.0, 0.0), 'expectedOutput' : DEC(0.0, 180.0)},

      {'coord' : DEC(0.0, 360.0), 'expectedOutput' : DEC(0.0, 0.0)},
      {'coord' : DEC(0.0, -360.0), 'expectedOutput' : DEC(0.0, 0.0)},
      {'coord' : DEC(0.0, 540.0), 'expectedOutput' : DEC(0.0, 180.0)},
      {'coord' : DEC(0.0, -540.0), 'expectedOutput' : DEC(0.0, -180.0)},
      {'coord' : DEC(0.0, 541.0), 'expectedOutput' : DEC(0.0, -179.0)},
      {'coord' : DEC(0.0, -541.0), 'expectedOutput' : DEC(0.0, 179.0)},

      {'coord' : DEC(200.0, 10.0), 'expectedOutput' : DEC(-20.0, -170.0)},
      {'coord' : DEC(300.0, 10.0), 'expectedOutput' : DEC(-60.0, 10.0)},
      {'coord' : DEC(660.0, 10.0), 'expectedOutput' : DEC(-60.0, 10.0)},

      {'coord' : DEC(200.0, 190.0), 'expectedOutput' : DEC(-20.0, 10.0)},
      {'coord' : DEC(300.0, 190.0), 'expectedOutput' : DEC(-60.0, -170.0)},
    ];

    _inputsToExpected.forEach((elem) {
      test('coord: ${elem['coord']}', () {
        var _actual = elem['coord'].normalize();
        expect((_actual.latitude - elem['expectedOutput'].latitude).abs() < 1e-10, true);
        expect((_actual.longitude - elem['expectedOutput'].longitude).abs() < 1e-10, true);
      });
    });
  });
}