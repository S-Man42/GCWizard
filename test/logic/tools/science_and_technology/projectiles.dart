import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';

void main() {
  group("Projectiles.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'energy' : null, 'mass' : null, 'speed' : true, 'expectedOutput' : null},
      {'energy' : null, 'mass' : null, 'speed' : false, 'expectedOutput' : null},
      {'energy' : -10.0, 'mass' : null, 'speed' : true, 'expectedOutput' : null},
      {'energy' : -10.0, 'mass' : null, 'speed' : false, 'expectedOutput' : null},
      {'energy' : null, 'mass' : -10.0, 'speed' : true, 'expectedOutput' : null},
      {'energy' : null, 'mass' : -10.0, 'speed' : false, 'expectedOutput' : null},

      {'energy' : -10.0, 'mass' : 5.0, 'speed' : true, 'expectedOutput' : -12.934},
      {'energy' : -10.0, 'mass' : 5.0, 'speed' : false, 'expectedOutput' : -22.256},
      {'energy' : 5.0, 'mass' : 5.0, 'speed' : true, 'expectedOutput' : 4.083},
      {'energy' : 5.0, 'mass' : 5.0, 'speed' : false, 'expectedOutput' : -4.637},
      {'energy' : 5.0, 'mass' : 10.0, 'speed' : true, 'expectedOutput' : 2.658},
      {'energy' : 41.0, 'mass' : 6.22, 'speed' : false, 'expectedOutput' : 36.809},
    ];

    _inputsToExpected.forEach((elem) {
      test('energy: ${elem['energy']}, mass: ${elem['mass']}, speed: ${elem['speed']}', () {
        var _actual;
        if (elem['energy'] == null)
          _actual = calculateEnergy(elem['mass'], elem['speed']);
        else
          if (elem['mass'] == null)
            _actual = calculateMass(elem['energy'], elem['speed']);
          else
            _actual = calculateSpeed(elem['energy'], elem['mass']);

        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
