import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:math_expressions/math_expressions.dart';

const STATE_OK = 'ok';
const STATE_ERROR = 'error';

class FormulaParser {
  ContextModel _context;

  final Map<String, double> _constants = {
    'ln10': ln10,
    'ln2': ln2,
    'log2e': log2e,
    'log10e': log10e,
    'pi': pi,
    'phi': 1.6180339887498948482045868343656381177,
    'sqrt1_2': sqrt1_2,
    'sqrt2': sqrt2,
  };

  final List<String> _functions = [
    'sqrt',
    'nrt',
    'arcsin',
    'arccos',
    'arctan',
    'sin',
    'cos',
    'tan',
    'log',
    'ln',
    'abs',
    'floor',
    'sgn',
    'e'
  ];

  final formulaCleanUp = {'—' : '-', '–' : '-', '˗' : '-', '−' : '-', '‒' : '-'};

  FormulaParser() {
    _context = ContextModel();

    _constants.entries.forEach((constant) {
      _context.bindVariableName(constant.key, Number(constant.value));
    });
  }

  final parser = Parser();

  // If, for example, the sin() function is used, but there's a variable i, you have to avoid
  // replace the i from sin with the variable value
  Map<String, dynamic> _safeFunctionsAndConstants(String formula) {
    var list = _constants.keys
        .where((constant) => constant != 'e') //special case: If you remove e, you could never use this as variable name
        .toList();

    list.addAll(_functions.map((functionName) => functionName + '\\s*\\(').toList());

    Map<String, String> substitutions = {};
    int j = 0;
    for (int i = 0; i < list.length; i++) {
      var matches = RegExp(list[i], caseSensitive: false).allMatches(formula);
      for (Match m in matches) {
        substitutions.putIfAbsent(m.group(0), () => '\x01${j++}\x01');
      }
      formula = substitution(formula, substitutions);
    }

    return {'formula': formula, 'map': switchMapKeyValue(substitutions)};
  }

  dynamic _evaluateFormula(String formula, Map<String, String> values) {
    Map<String, String> preparedValues = _prepareValues(values);

    //replace constants and formula names
    var safedFormulaNames = _safeFunctionsAndConstants(formula);
    //replace values
    int i = pow(values.length, 2);
    var substitutedFormula = safedFormulaNames['formula'];
    var fullySubstituded = false;
    while (i > 0 && !fullySubstituded) {
      var tempSubstitutedFormula = substitution(substitutedFormula, preparedValues, caseSensitive: false);
      fullySubstituded = _isFullySubstituted(tempSubstitutedFormula, substitutedFormula);

      substitutedFormula = tempSubstitutedFormula;
      i--;
    }
    //restore the formula names
    substitutedFormula = substitution(substitutedFormula, safedFormulaNames['map']);

    try {
      Expression expression = parser.parse(substitutedFormula.toLowerCase());
      var result = expression.evaluate(EvaluationType.REAL, _context);
      if (result == null) throw Exception();

      return result.floor() == result ? result.floor() : result;
    } catch (e) {
      throw FormatException(substitutedFormula);
    }
  }

  bool _isFullySubstituted(String tempSubstitutedFormula, substitutedFormula) {
    return double.tryParse(tempSubstitutedFormula.replaceAll(RegExp(r'[\(\)]'), '')) != null ||
        substitutedFormula == tempSubstitutedFormula.replaceAll(RegExp(r'[\(\)]'), '');
  }

  Map<String, String> _prepareValues(Map<String, String> values) {
    Map<String, String> val = {};
    values.entries.forEach((element) {
      var key = element.key.trim();
      var value = element.value;

      if (value == null || value.length == 0) val.putIfAbsent(key, () => key);

      if (double.tryParse(value) != null)
        val.putIfAbsent(key, () => value);
      else
        val.putIfAbsent(key, () => '($value)');
    });
    return val;
  }

  Map<String, String> parse(String formula, Map<String, String> values) {
    if (formula == null) return {'state': STATE_ERROR, 'result': formula};

    formula = formula.trim();

    if (formula == '') return {'state': STATE_ERROR, 'result': formula};

    if (values == null) values = <String, String>{};

    formula = substitution(formula, formulaCleanUp);

    RegExp regExp = new RegExp(r'\[.+?\]');
    var matches = regExp.allMatches(formula.trim());

    bool hasError = false;
    if (matches.length > 0) {
      Map<String, String> substitutions = {};

      matches.forEach((match) {
        var matchString = match.group(0);
        var content = matchString.substring(1, matchString.length - 1);

        var result;
        try {
          result = _evaluateFormula(content, values);
        } catch (e) {
          hasError = true;
          result = '[' + e.message + ']';
        }
        substitutions.putIfAbsent(matchString, () => result.toString());
      });

      return {'state': hasError ? STATE_ERROR : STATE_OK, 'result': substitution(formula, substitutions)};
    } else {
      try {
        return {'state': hasError ? STATE_ERROR : STATE_OK, 'result': _evaluateFormula(formula, values).toString()};
      } catch (e) {
        return {'state': STATE_ERROR, 'result': e.message};
      }
    }
  }
}
