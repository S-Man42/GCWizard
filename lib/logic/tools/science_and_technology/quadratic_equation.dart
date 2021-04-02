import 'dart:math';
import 'package:intl/intl.dart';

Map<String, String> SolveEquation(String currentA, String currentB, String currentC) {
  if (currentA == null || currentA == '' || currentB == null || currentB == '' || currentC == null || currentC == '')
    return {'': ''};
  currentA = currentA.replaceAll(',', '.');
  currentB = currentB.replaceAll(',', '.');
  currentC = currentC.replaceAll(',', '.');

  Map<String, String> result = new Map<String, String>();
  double a = double.parse(currentA);
  double b = double.parse(currentB);
  double c = double.parse(currentC);

  if (a == 0) result['quadratic_equation_hint_caution'] = 'quadratic_equation_hint_a_null';

  if (b * b - 4 * a * c < 0) {
    result['quadratic_equation_hint_caution'] = 'quadratic_equation_hint_complex';
    result['x1'] = NumberFormat('0.0' + '#' * 7).format(-b / 2 / a) +
        ' + i * ' +
        NumberFormat('0.0' + '#' * 7).format(sqrt(4 * a * c - b * b) / 2 / a);
    result['x2'] = NumberFormat('0.0' + '#' * 7).format(-b / 2 / a) +
        ' - i * ' +
        NumberFormat('0.0' + '#' * 7).format(sqrt(4 * a * c - b * b) / 2 / a);
  } else {
    result['x1'] = NumberFormat('0.0' + '#' * 7).format((-b + sqrt(b * b - 4 * a * c)) / 2 / a);
    result['x2'] = NumberFormat('0.0' + '#' * 7).format((-b - sqrt(b * b - 4 * a * c)) / 2 / a);
  }
  print(result.toString());
  return result;
}
