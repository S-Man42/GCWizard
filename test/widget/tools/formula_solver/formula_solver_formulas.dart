import 'dart:math';

import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver_formulas.dart';

void main() {
  group("formula_solver_formulas.formulaColors:", () {
    Map<String, String> values = {
      'A':'3', 'B':'20', 'C': '100', 'D': '5', 'E': 'Pi',
      'Q': '1', 'R': '0', 'S': '200', 'T': '20', 'U': '12', 'V': '9', 'W': '4', 'X': '30', 'Y':'4', 'Z': '50'
    };
    Map<String, String> values1 = {
      'AB':'3', 'B':'20'
    };

    List<Map<String, dynamic>> _inputsToExpected = [
      {'formula' : null, 'values': null, 'expectedOutput' : null},
      {'formula' : null, 'values': <String, String>{}, 'expectedOutput' : null},
      {'formula' : null, 'expectedOutput' : null},
      {'formula' : '', 'expectedOutput' : ''},
      {'formula' : ' ', 'expectedOutput' : 's'},
      {'formula' : 'A', 'values': null, 'expectedOutput' : 'R'},
      {'formula' : '0', 'values': null, 'expectedOutput' : 'g'},
      {'formula' : 'A', 'values': <String, String>{}, 'expectedOutput' : 'R'},
      {'formula' : '0', 'values': <String, String>{}, 'expectedOutput' : 'g'},

      {'formula' : 'A', 'values': values, 'expectedOutput' : 'r'},
      {'formula' : 'AB', 'values': values, 'expectedOutput' : 'rr'},
      {'formula' : 'A+B', 'values': values, 'expectedOutput' : 'rbr'},
      {'formula' : 'A + B', 'values': values, 'expectedOutput' : 'rrbbr'},
      {'formula' : '[A + B]', 'values': values, 'expectedOutput' : 'brrbbrb'},
      {'formula' : '[A] + [B]', 'values': values, 'expectedOutput' : 'brbbttbrb'},
      {'formula' : 'AB + C', 'values': values, 'expectedOutput' : 'rrrbbr'},
      {'formula' : '(AB) + C', 'values': values, 'expectedOutput' : 'brrbbbbr'},
      {'formula' : 'A(B + C)', 'values': values, 'expectedOutput' : 'rbrrbbrb'},
      {'formula' : '[A][(B + C)]', 'values': values, 'expectedOutput' : 'brbbbrrbbrbb'},
      {'formula' : 'A*(B + C)', 'values': values, 'expectedOutput' : 'rbbrrbbrb'},
      {'formula' : '[]', 'values': values, 'expectedOutput' : 'bB'},
      {'formula' : '()', 'values': values, 'expectedOutput' : 'bB'},
      {'formula' : '?!', 'values': values, 'expectedOutput' : 'tt'},
      {'formula' : 'A []', 'values': values, 'expectedOutput' : 'ttbB'},
      {'formula' : 'N []', 'values': values, 'expectedOutput' : 'ttbB'},
      {'formula' : 'N', 'values': values, 'expectedOutput' : 'R'},
      {'formula' : 'E', 'values': values, 'expectedOutput' : 'r'},
      {'formula' : 'e', 'values': values, 'expectedOutput' : 'r'},
      {'formula' : 'Pi', 'values': values, 'expectedOutput' : 'rr'},
      {'formula' : 'pi', 'values': values, 'expectedOutput' : 'rr'},
      {'formula' : 'pi * A', 'values': values, 'expectedOutput' : 'rrrbbr'},
      {'formula' : 'E * PI', 'values': values, 'expectedOutput' : 'rrbbrr'},
      {'formula' : 'E [PI]', 'values': values, 'expectedOutput' : 'ttbrrb'},
      {'formula' : '[A*B*2].[C+d+D];', 'values': values, 'expectedOutput' : 'brbrbgbtbrbrbrbt'},
      {'formula' : 'N 52 [QR].[S+T*U*2] E 12 [V*W].[XY + Z]', 'values': values, 'expectedOutput' : 'tttttbrrbtbrbrbrbgbbtttttbrbrbtbrrrbbrb'},
      {'formula' : 'A + B [A + B]', 'values': values, 'expectedOutput' : 'ttttttbrrbbrb'},
      {'formula' : 'A + B]', 'values': values, 'expectedOutput' : 'tttttB'},
      {'formula' : '[A + B', 'values': values, 'expectedOutput' : 'Bttttt'},

      //Trim empty space
      {'formula' : 'sin(0) ', 'values': <String, String>{}, 'expectedOutput' : 'rrrbgbb'},

      //math library testing
      {'formula' : '36^(1/2)', 'expectedOutput' : 'ggbbgbgb'},
      {'formula' : 'phi * 2', 'expectedOutput' : 'rrrrbbg'},
      {'formula' : 'log(100,10)', 'expectedOutput' : 'rrrbgggtggb'},
      {'formula' : 'log(10,100)', 'expectedOutput' : 'rrrbggtgggb'},
      {'formula' : 'pi', 'expectedOutput' : 'rr'},

      {'formula' : 'N [1', 'values': values, 'expectedOutput' : 'ttBt'},
      {'formula' : 'N []', 'values': values, 'expectedOutput' : 'ttbB'},
      {'formula' : 'N [F', 'values': values, 'expectedOutput' : 'ttBt'},
      {'formula' : 'N [F]', 'values': values, 'expectedOutput' : 'ttbRb'},
      {'formula' : 'N [A].[{(B)}]', 'values': values, 'expectedOutput' : 'ttbrbtbbbrbbb'},
      {'formula' : 'N [A].[({B)}]', 'values': values, 'expectedOutput' : 'ttbrbtbbbrBbB'},
      {'formula' : '  N [A].[({B)}]', 'values': values, 'expectedOutput' : 'ttttbrbtbbbrBbB'},
      {'formula' : '  N [AB].[({B)}]', 'values': values, 'expectedOutput' : 'ttttbrrbtbbbrBbB'},
      {'formula' : '  N [AB].[B]', 'values': values1, 'expectedOutput' : 'ttttbrrbtbrb'},
      {'formula' : '  N [AB].[B]', 'values': values1, 'expectedOutput' : 'ttttbrrbtbrb'},

    ];

    _inputsToExpected.forEach((elem) {
      test('formula: ${elem['formula']}, values: ${elem['values']}', () {
        var _actual = FormulaSolverFormulasState.formulaColors(elem['formula'], elem['values']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}