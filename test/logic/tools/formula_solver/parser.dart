import 'dart:math';

import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';

void main() {
  group("FormulaParser.parse:", () {
    Map<String, String> values = {
      'A':'3', 'B':'20', 'C': '100', 'D': '5', 'E': 'Pi',
      'Q': '1', 'R': '0', 'S': '200', 'T': '20', 'U': '12', 'V': '9', 'W': '4', 'X': '30', 'Y':'4', 'Z': '50'
    };

    List<Map<String, dynamic>> _inputsToExpected = [
      {'formula' : null, 'values': null, 'expectedOutput' : {'state': 'error', 'result': null}},
      {'formula' : null, 'values': <String, String>{}, 'expectedOutput' : {'state': 'error', 'result': null}},
      {'formula' : null, 'expectedOutput' : {'state': 'error', 'result': null}},
      {'formula' : '', 'expectedOutput' : {'state': 'error', 'result': ''}},
      {'formula' : ' ', 'expectedOutput' : {'state': 'error', 'result': ''}},
      {'formula' : 'A', 'values': null, 'expectedOutput' : {'state': 'error', 'result': 'A'}},
      {'formula' : '0', 'values': null, 'expectedOutput' : {'state': 'ok', 'result': '0'}},
      {'formula' : 'A', 'values': <String, String>{}, 'expectedOutput' : {'state': 'error', 'result': 'A'}},
      {'formula' : '0', 'values': <String, String>{}, 'expectedOutput' : {'state': 'ok', 'result': '0'}},

      {'formula' : 'A', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '3'}},
      {'formula' : 'AB', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '320'}},
      {'formula' : 'A+B', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '23'}},
      {'formula' : 'A + B', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '23'}},
      {'formula' : '[A + B]', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '23'}},
      {'formula' : '[A] + [B]', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '3 + 20'}},
      {'formula' : 'AB + C', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '420'}},
      {'formula' : '(AB) + C', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '420'}},
      {'formula' : 'A(B + C)', 'values': values, 'expectedOutput' : {'state': 'error', 'result': '3(20 + 100)'}},
      {'formula' : '[A][(B + C)]', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '3120'}},
      {'formula' : 'A*(B + C)', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '360'}},
      {'formula' : '[]', 'values': values, 'expectedOutput' : {'state': 'error', 'result': '[]'}},
      {'formula' : '()', 'values': values, 'expectedOutput' : {'state': 'error', 'result': '()'}},
      {'formula' : '?!', 'values': values, 'expectedOutput' : {'state': 'error', 'result': '?!'}},
      {'formula' : 'A []', 'values': values, 'expectedOutput' : {'state': 'error', 'result': '3 []'}},
      {'formula' : 'N []', 'values': values, 'expectedOutput' : {'state': 'error', 'result': 'N []'}},
      {'formula' : 'N', 'values': values, 'expectedOutput' : {'state': 'error', 'result': 'N'}},
      {'formula' : 'E', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': pi.toString()}},
      {'formula' : 'e', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': pi.toString()}},
      {'formula' : 'Pi', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': pi.toString()}},
      {'formula' : 'pi', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': pi.toString()}},
      {'formula' : 'pi * A', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': (pi * 3).toString()}},
      {'formula' : 'E * PI', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': (pi * pi).toString()}},
      {'formula' : 'E [PI]', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': 'E ${pi.toString()}'}},
      {'formula' : '[A*B*2].[C+d+D];', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': '120.110;'}},
      {'formula' : 'N 52 [QR].[S+T*U*2] E 12 [V*W].[XY + Z]', 'values': values, 'expectedOutput' : {'state': 'ok', 'result': 'N 52 10.680 E 12 36.354'}},

      //Trim empty space
      {'formula' : 'sin(0) ', 'values': <String, String>{}, 'expectedOutput' : {'state': 'ok', 'result': '0'}}, //Not working because S in Values and so the s of sin will be replaced

      //math library testing
      {'formula' : '36^(1/2)', 'expectedOutput' : {'state': 'ok', 'result': '6'}},
      {'formula' : 'phi * 2', 'expectedOutput' : {'state': 'ok', 'result': (1.6180339887498948482045868343656381177 * 2).toString()}},
      {'formula' : 'log(100,10)', 'expectedOutput' : {'state': 'ok', 'result': '0.5'}},
      {'formula' : 'log(10,100)', 'expectedOutput' : {'state': 'ok', 'result': '2'}},
      {'formula' : 'pi', 'expectedOutput' : {'state': 'ok', 'result': '${pi}'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('formula: ${elem['formula']}, values: ${elem['values']}', () {
        var _actual = FormulaParser().parse(elem['formula'], elem['values']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("FormulaParser.parse - Functionnames contain variables:", () {

    List<Map<String, dynamic>> _inputsToExpected = [
      {'formula' : 'sin(i)', 'values': <String, String>{'i': '${pi/2}'}, 'expectedOutput' : {'state': 'ok', 'result': '1'}},
      {'formula' : 'SIN (i)', 'values': <String, String>{'i': '${pi/2}'}, 'expectedOutput' : {'state': 'ok', 'result': '1'}},
      {'formula' : 'sin  (I)', 'values': <String, String>{'i': '${pi/2}'}, 'expectedOutput' : {'state': 'ok', 'result': '1'}},

      {'formula' : 'A + sin  (I)', 'values': <String, String>{'a': '2', 'i': '${pi/2}'}, 'expectedOutput' : {'state': 'ok', 'result': '3'}},
      {'formula' : '2 + sin  (I)', 'values': <String, String>{'a': '2', 'i': '${pi/2}'}, 'expectedOutput' : {'state': 'ok', 'result': '3'}},
      {'formula' : '2 + sin  (I) + S', 'values': <String, String>{'i': '${pi/2}'}, 'expectedOutput' : {'state': 'error', 'result': '2 + sin  (1.5707963267948966) + S'}},
      {'formula' : '2 + sin  (I) + S', 'values': <String, String>{'s': '2', 'i': '${pi/2}'}, 'expectedOutput' : {'state': 'ok', 'result': '5'}},

      {'formula' : 'sin(sqrt2)', 'values': <String, String>{'s': '3'}, 'expectedOutput' : {'state': 'ok', 'result': '${sin(sqrt(2))}'}},
      {'formula' : 'sin(pi)', 'values': <String, String>{'s': '3'}, 'expectedOutput' : {'state': 'ok', 'result': '${sin(pi)}'}},
      {'formula' : 'e(e)', 'values': <String, String>{'e': '2'}, 'expectedOutput' : {'state': 'ok', 'result': '7.38905609893065'}},

      {'formula' : 'arcsin(0.2) + sin(2)', 'values': <String, String>{}, 'expectedOutput' : {'state': 'ok', 'result': '1.1106553476160126'}},
      {'formula' : 'sin(2) + arcsin(0.2)', 'values': <String, String>{}, 'expectedOutput' : {'state': 'ok', 'result': '1.1106553476160126'}},
      {'formula' : 'arcsin(sin(0.2))', 'values': <String, String>{}, 'expectedOutput' : {'state': 'ok', 'result': '0.2'}},
      {'formula' : 'sin(arcsin(0.2))', 'values': <String, String>{}, 'expectedOutput' : {'state': 'ok', 'result': '0.2'}},
      {'formula' : 'sin(arcsin(0.2))', 'values': <String, String>{'sin': '0.1'}, 'expectedOutput' : {'state': 'ok', 'result': '0.2'}},
      {'formula' : 'sin(arcsin(sin))', 'values': <String, String>{'sin': '0.1'}, 'expectedOutput' : {'state': 'ok', 'result': '0.1'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('formula: ${elem['formula']}, values: ${elem['values']}', () {
        var _actual = FormulaParser().parse(elem['formula'], elem['values']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}