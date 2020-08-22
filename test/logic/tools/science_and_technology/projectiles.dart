import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';

void main() {
  group("Projectiles.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'mode': CalculateProjectilesMode.ENERGY, 'outputUnit' : null,'input1' : 0.0, 'inputUnit1': null, 'input2' : 0.0, 'inputUnit1': null, 'expectedOutput' : '0.000'},
    ];

    _inputsToExpected.forEach((elem) {
      test('energy: ${elem['energy']}, mass: ${elem['mass']}, speed: ${elem['speed']}', () {
        var _actual;
        if (elem['mode'] == CalculateProjectilesMode.ENERGY) {
          _actual = calculateEnergy(elem['mass'], elem['speed']).toStringAsFixed(3);
        }
        else if (elem['mode'] == CalculateProjectilesMode.ENERGY) {
          _actual = calculateMass(elem['energy'], elem['speed']).toStringAsFixed(3);
        } else {
          _actual = calculateSpeed(
              convert(elem['input1'] , elem[inputUnit1], ENERGY_JOULE),
              convert(elem['input2'] , elem['inputUnit2'], _currentOutputVelocityUnit) / 1000
          ).toStringAsFixed(3) + ' ' + _currentOutputVelocityUnit.symbol;
      }
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
