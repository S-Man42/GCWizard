import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/velocity.dart';

void main() {
  group("Projectiles.calculate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'mode': CalculateProjectilesMode.ENERGY, 'outputUnit' : null,'input1' : 0.0, 'inputUnit1': null, 'input2' : 0.0, 'inputUnit1': null, 'expectedOutput' : '0.000'},
    ];

    _inputsToExpected.forEach((elem) {
      test('energy: ${elem['energy']}, mass: ${elem['mass']}, speed: ${elem['speed']}', () {
        var _actual;
        if (elem['mode'] == CalculateProjectilesMode.ENERGY) {
          _actual = convert(calculateSpeed(convert(elem['input1'] , elem['inputUnit1'], MASS_GRAM) / 1000,
                                           convert(elem['input2'] , elem['inputUnit2'], VELOCITY_MS)),
                            ENERGY_JOULE, elem['outputUnit'])
                            .toStringAsFixed(3) + ' ' + elem['outputUnit'].symbol;
        }
        else if (elem['mode'] == CalculateProjectilesMode.MASS) {
          _actual = convert(calculateSpeed(convert(elem['input1'] , elem['inputUnit1'], ENERGY_JOULE),
                                           convert(elem['input2'] , elem['inputUnit2'], VELOCITY_MS)),
                            MASS_GRAM, elem['outputUnit'])
                            .toStringAsFixed(3) + ' ' + elem['outputUnit'].symbol;
        } else {
          _actual = convert(calculateSpeed(convert(elem['input1'] , elem['inputUnit1'], ENERGY_JOULE),
                                           convert(elem['input2'] , elem['inputUnit2'], MASS_GRAM) / 1000),
                            VELOCITY_MS, elem['outputUnit'])
                            .toStringAsFixed(3) + ' ' + elem['outputUnit'].symbol;
      }
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
