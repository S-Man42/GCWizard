import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';

void main() {
  group("Projectiles.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'energy' : 0.0, 'mass' : 0.0, 'speed' : 0.0, 'expectedOutput' : '0.000'},
      {'energy' : 0.0, 'mass' : 0.0, 'speed' : 120.0, 'expectedOutput' : '0.000'},
      {'energy' : 0.0, 'mass' : 120.0, 'speed' : 0.0, 'expectedOutput' : '0.000'},
      {'energy' : 0.0, 'mass' : 120.0, 'speed' : 120.0, 'expectedOutput' : '864000.000'},
      {'energy' : 120.0, 'mass' : 0.0, 'speed' : 120.0, 'expectedOutput' : '0.017'},
      {'energy' : 120.0, 'mass' : 120.0, 'speed' : 0.0, 'expectedOutput' : '1.414'},
      {'energy' : 120.0, 'mass' : 120.0, 'speed' : 120.0, 'expectedOutput' : '0'},
    ];

    _inputsToExpected.forEach((elem) {
      test('energy: ${elem['energy']}, mass: ${elem['mass']}, speed: ${elem['speed']}', () {
        var _actual;
        if (elem['energy'] == 0)
          _actual = calculateEnergy(elem['mass'], elem['speed']).toStringAsFixed(3);
        else
          if (elem['mass'] == 0)
            _actual = calculateMass(elem['energy'], elem['speed']).toStringAsFixed(3);
          else if (elem['speed'] == 0)
                 _actual = calculateSpeed(elem['energy'], elem['mass']).toStringAsFixed(3);
               else
                 _actual = '0';

        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
