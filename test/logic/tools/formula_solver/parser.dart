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
      {'formula' : 'sin(0) ', 'values': values, 'expectedOutput' : {'state': 'error', 'result': '200IN(0)'}}, //Not working because S in Values and so the s of sin will be replaced
      {'formula' : 'sin(0) ', 'values': <String, String>{}, 'expectedOutput' : {'state': 'ok', 'result': '0'}}, //Not working because S in Values and so the s of sin will be replaced

      //math library testing
      {'formula' : '36^(1/2)', 'expectedOutput' : {'state': 'ok', 'result': '6'}},
      {'formula' : 'phi * 2', 'expectedOutput' : {'state': 'ok', 'result': (1.6180339887498948482045868343656381177 * 2).toString()}},
      {'formula' : 'log(100,10)', 'expectedOutput' : {'state': 'ok', 'result': '0.5'}},
      {'formula' : 'log(10,100)', 'expectedOutput' : {'state': 'ok', 'result': '2'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('formula: ${elem['formula']}, values: ${elem['values']}', () {
        var _actual = FormulaParser().parse(elem['formula'], elem['values']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}