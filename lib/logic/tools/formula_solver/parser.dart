import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto/substitution.dart';
import 'package:math_expressions/math_expressions.dart';

const STATE_OK = 'ok';
const STATE_ERROR = 'error';

class FormulaParser {

  ContextModel _context;

  final Map<String, double> _constants = {
    'e': e,
    'ln10': ln10,
    'ln2': ln2,
    'log2e': log2e,
    'log10e': log10e,
    'pi': pi,
    'phi': 1.6180339887498948482045868343656381177,
    'sqrt1_2': sqrt1_2,
    'sqrt2': sqrt2,
  };

  FormulaParser() {
    _context = ContextModel();

    _constants.entries.forEach((constant) {
      _context.bindVariableName(constant.key, Number(constant.value));
    });
  }

  final parser = Parser();

  dynamic _evaluateFormula(String formula, Map<String, String> values) {
    Expression expression = parser.parse(
      substitution(formula, values, caseSensitive: false).toLowerCase()
    );

    var result = expression.evaluate(EvaluationType.REAL, _context);
    if (result == null)
      throw Exception();

    return result.floor() == result ? result.floor() : result;
  }

  Map<String, String> parse(String formula, Map<String, String> values) {
    if (formula == null)
      return {'state' : STATE_ERROR, 'result': formula};

    formula = formula.trim();

    if (formula == '')
      return {'state' : STATE_ERROR, 'result': formula};

    if (values == null)
      values = <String, String>{};

    try {
      RegExp regExp = new RegExp(r'\[.+?\]');
      var matches = regExp.allMatches(formula.trim());

      if (matches.length > 0) {
        Map<String, String> substitutions = {};

        matches.forEach((match) {
          var matchString = match.group(0);
          var content = matchString.substring(1, matchString.length - 1);
          var result = _evaluateFormula(content, values);
          substitutions.putIfAbsent(matchString, () => result.toString());
        });

        return {'state' : STATE_OK, 'result': substitution(formula, substitutions)};
      } else {
        return {'state' : STATE_OK, 'result': _evaluateFormula(formula, values).toString()};
      }
    } catch(Exception) {
      return {'state' : STATE_ERROR, 'result': formula};
    }
  }
}