import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/velocity.dart';

void main() {
//  group("Projectiles.calculate:", () {
//    List<Map<String, dynamic>> _inputsToExpected = [
//      {'mode': CalculateProjectilesMode.ENERGY, 'outputUnit' : ENERGY_JOULE,'input1' : 1.0, 'inputUnit1': MASS_KGRAM, 'input2' : 1.0, 'inputUnit2': VELOCITY_MS, 'expectedOutput' : '0.500 J'},
//      {'mode': CalculateProjectilesMode.ENERGY, 'outputUnit' : ENERGY_FTLB,'input1' : 1.0, 'inputUnit1': MASS_KGRAM, 'input2' : 1.0, 'inputUnit2': VELOCITY_MS, 'expectedOutput' : '0.369 ft-lb'},
//      {'mode': CalculateProjectilesMode.ENERGY, 'outputUnit' : ENERGY_JOULE,'input1' : 1000.0, 'inputUnit1': MASS_GRAM, 'input2' : 1.0, 'inputUnit2': VELOCITY_MS, 'expectedOutput' : '0.500 J'},
//      {'mode': CalculateProjectilesMode.ENERGY, 'outputUnit' : ENERGY_FTLB,'input1' : 1000.0, 'inputUnit1': MASS_GRAM, 'input2' : 1.0, 'inputUnit2': VELOCITY_MS, 'expectedOutput' : '0.369 ft-lb'},
//      {'mode': CalculateProjectilesMode.VELOCITY, 'outputUnit' : VELOCITY_MS,'input1' : 0.500, 'inputUnit1': ENERGY_JOULE, 'input2' : 1.0, 'inputUnit2': MASS_KGRAM, 'expectedOutput' : '1.000 m/s'},
//      {'mode': CalculateProjectilesMode.VELOCITY, 'outputUnit' : VELOCITY_MS,'input1' : 0.369, 'inputUnit1': ENERGY_FTLB, 'input2' : 1000.0, 'inputUnit2': MASS_GRAM, 'expectedOutput' : '1.000 m/s'},
//      {'mode': CalculateProjectilesMode.VELOCITY, 'outputUnit' : VELOCITY_MS,'input1' : 0.500, 'inputUnit1': ENERGY_JOULE, 'input2' : 1.0, 'inputUnit2': MASS_KGRAM, 'expectedOutput' : '1.000 m/s'},
//      {'mode': CalculateProjectilesMode.VELOCITY, 'outputUnit' : VELOCITY_MS,'input1' : 0.369, 'inputUnit1': ENERGY_FTLB, 'input2' : 1000.0, 'inputUnit2': MASS_GRAM, 'expectedOutput' : '1.000 m/s'},
//      {'mode': CalculateProjectilesMode.MASS, 'outputUnit' : MASS_KGRAM,'input1' : 0.500, 'inputUnit1': ENERGY_JOULE, 'input2' : 1.0, 'inputUnit2': VELOCITY_MS, 'expectedOutput' : '1.000 kg'},
//      {'mode': CalculateProjectilesMode.MASS, 'outputUnit' : MASS_KGRAM,'input1' : 0.369, 'inputUnit1': ENERGY_FTLB, 'input2' : 1.0, 'inputUnit2': VELOCITY_MS, 'expectedOutput' : '1.001 kg'},
//      {'mode': CalculateProjectilesMode.MASS, 'outputUnit' : MASS_GRAM,'input1' : 0.500, 'inputUnit1': ENERGY_JOULE, 'input2' : 1.0, 'inputUnit2': VELOCITY_MS, 'expectedOutput' : '1000.000 g'},
//      {'mode': CalculateProjectilesMode.MASS, 'outputUnit' : MASS_GRAM,'input1' : 0.369, 'inputUnit1': ENERGY_FTLB, 'input2' : 1.0, 'inputUnit2': VELOCITY_MS, 'expectedOutput' : '1000.594 g'},
//    ];
//
//    _inputsToExpected.forEach((elem) {
//      test('energy: ${elem['energy']}, mass: ${elem['mass']}, speed: ${elem['speed']}', () {
//        var _actual;
//        if (elem['mode'] == CalculateProjectilesMode.ENERGY) {
//          _actual = convert(calculateEnergy(convert(elem['input1'] , elem['inputUnit1'], MASS_KGRAM),
//                                            convert(elem['input2'] , elem['inputUnit2'], VELOCITY_MS)),
//                            ENERGY_JOULE, elem['outputUnit'])
//                            .toStringAsFixed(3) + ' ' + elem['outputUnit'].symbol;
//        }
//        else if (elem['mode'] == CalculateProjectilesMode.MASS) {
//          _actual = convert(calculateMass(convert(elem['input1'] , elem['inputUnit1'], ENERGY_JOULE),
//                                          convert(elem['input2'] , elem['inputUnit2'], VELOCITY_MS)),
//                            MASS_KGRAM, elem['outputUnit'])
//                            .toStringAsFixed(3) + ' ' + elem['outputUnit'].symbol;
//        } else { // if (elem['mode'] == CalculateProjectilesMode.VELOCITY)
//          _actual = convert(calculateVelocity(convert(elem['input1'] , elem['inputUnit1'], ENERGY_JOULE),
//                                              convert(elem['input2'] , elem['inputUnit2'], MASS_KGRAM)),
//                            VELOCITY_MS, elem['outputUnit'])
//                            .toStringAsFixed(3) + ' ' + elem['outputUnit'].symbol;
//      }
//        expect(_actual, elem['expectedOutput']);
//      });
//    });
//  });
}
