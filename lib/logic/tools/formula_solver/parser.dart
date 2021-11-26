import 'dart:math';

import 'package:gc_wizard/logic/common/parser/variable_string_expander.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/crosstotals.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

const STATE_OK = 'ok';
const STATE_EXPANDED_OK = 'expanded_ok';
const STATE_EXPANDED_ERROR = 'expanded_error';
const STATE_ERROR_GENERAL = 'error';
const STATE_EXPANDED_ERROR_EXCEEDEDRANGE = 'expanded_error_exceededrange';

const _MAX_EXPANDED = 100;

class FormulaParser {
  ContextModel _context;
  Parser parser;

  static final Map<String, double> CONSTANTS = {
    'ln10': ln10,
    'ln2': ln2,
    'log2e': log2e,
    'log10e': log10e,
    'pi': pi,
    'phi': 1.6180339887498948482045868343656381177,
    'sqrt1_2': sqrt1_2,
    'sqrt2': sqrt2,
  };

  static final List<String> _BUILTIN_FUNCTIONS = [
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
    'e',
    'ceil'
  ];

  static final Map<String, Function> _CUSTOM_FUNCTIONS = {
    'cs': (List<double> numbers) => sumCrossSum(numbers.map((number) => number.toInt()).toList()).toInt(),
    'csi': (List<double> numbers) => sumCrossSumIterated(numbers.map((number) => number.toInt()).toList()).toInt(),
    'min': (List<double> numbers) => numbers.reduce(min),
    'max': (List<double> numbers) => numbers.reduce(max),
    'round': (List<double> numbers) {
      var precision = 0;
      if (numbers.length > 1)
        precision = numbers[1].toInt();

      return round(numbers.first, precision: precision);
    },
    'sindeg': (List<double> numbers) => sin(degreesToRadian(numbers.first)),
    'cosdeg': (List<double> numbers) => cos(degreesToRadian(numbers.first)),
    'tandeg': (List<double> numbers) => tan(degreesToRadian(numbers.first)),
    'arcsindeg': (List<double> numbers) => asin(degreesToRadian(numbers.first)),
    'arccosdeg': (List<double> numbers) => acos(degreesToRadian(numbers.first)),
    'arctandeg': (List<double> numbers) => atan(degreesToRadian(numbers.first)),
  };

  // different minus/hyphens/dashes
  static final Map<String, String> alternateOperators = {
    '-': '—–˗−‒',
    '/': ':÷',
    '*': '×',
  };

  FormulaParser() {
    _context = ContextModel();

    CONSTANTS.entries.forEach((constant) {
      _context.bindVariableName(constant.key, Number(constant.value));
    });

    parser = Parser();
    _CUSTOM_FUNCTIONS.forEach((name, handler) {
      parser.addFunction(name, handler);
    });
  }

  static List<String> availableParserFunctions() {
    var result = List<String>.from(_BUILTIN_FUNCTIONS);
    _CUSTOM_FUNCTIONS.forEach((name, handler) {
      result.add(name);
    });

    return result;
  }

  // If, for example, the sin() function is used, but there's a variable i, you have to avoid
  // replace the i from sin with the variable value
  Map<String, dynamic> _safeFunctionsAndConstants(String formula) {
    var list = CONSTANTS.keys
        .where((constant) => constant != 'e') //special case: If you remove e, you could never use this as variable name
        .toList();

    list.addAll(availableParserFunctions().map((functionName) => functionName + '\\s*\\(').toList());

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

  static String normalizeMathematicalSymbols(formula) {
    alternateOperators.forEach((key, value) {
      formula = formula.replaceAll(RegExp('[$value]'), key);
    });
    /**** exponents *****/
    formula = formula.replaceAllMapped(RegExp('[\u2070\u00B9\u00B2\u00B3\u2074\u2075\u2076\u2077\u2078\u2079]+'),
        (Match match) {
      var group = match.group(0);
      group = substitution(group, switchMapKeyValue(superscriptCharacters));
      return '^$group';
    });

    return formula;
  }

  Map<String, dynamic> _parseFormula(String formula, List<FormulaValue> values, bool expandValues) {
    formula = normalizeMathematicalSymbols(formula);

    List<FormulaValue> preparedValues = _prepareValues(values);

    var fixedValues = <String, String>{};
    var variableValues = <String, String>{};
    preparedValues.forEach((value) {
      if (expandValues == false || value.type == null || value.type == FormulaValueType.VALUE) {
        fixedValues.putIfAbsent(value.key, () => value.value);
      } else {
        variableValues.putIfAbsent(value.key, () => value.value);
      }
    });

    //replace constants and formula names
    var safedFormulaNames = _safeFunctionsAndConstants(formula);

    //replace values
    int i = pow(values.length, 2);
    var substitutedFormula = safedFormulaNames['formula'];
    var fullySubstituded = false;
    while (i > 0 && !fullySubstituded) {
      var tempSubstitutedFormula = substitution(substitutedFormula, fixedValues, caseSensitive: false);
      fullySubstituded = _isFullySubstituted(tempSubstitutedFormula, substitutedFormula);

      substitutedFormula = tempSubstitutedFormula;
      i--;
    }

    //expand formulas with range values
    List<Map<String, dynamic>> expandedFormulas;
    if (expandValues && variableValues.length > 0) {
      var count = VariableStringExpander(substitutedFormula, variableValues).run(onlyPrecheck: true).first['count'];
      if (count == null) {
        return {'state': STATE_ERROR_GENERAL, 'result': formula};
      } else if (count > _MAX_EXPANDED) {
        return {'state': STATE_EXPANDED_ERROR_EXCEEDEDRANGE, 'result': formula};
      }

      expandedFormulas = VariableStringExpander(substitutedFormula, variableValues).run();

      var results = <Map<String, dynamic>>[];
      var hasError = false;
      for (var expandedFormula in expandedFormulas) {
        substitutedFormula = substitution(expandedFormula['text'], safedFormulaNames['map']);

        try {
          var result = _evaluateFormula(substitutedFormula, fixedValues);
          results.add({'state': STATE_OK, 'result': result, 'variables': expandedFormula['variables']});
        } catch (e) {
          results.add({'state': STATE_ERROR_GENERAL, 'result': substitutedFormula, 'variables': expandedFormula['variables']});
          hasError = true;
        }
      }

      if (count == 1) {
        return {'state': hasError ? STATE_ERROR_GENERAL : STATE_OK, 'result': results.first['result']};
      }

      return {'state': hasError ? STATE_EXPANDED_ERROR : STATE_EXPANDED_OK, 'result': results};
    } else {
      substitutedFormula = substitution(substitutedFormula, safedFormulaNames['map']);

      try {
        var result = _evaluateFormula(substitutedFormula, fixedValues);
        return {'state': STATE_OK, 'result': result};
      } catch (e) {
        return {'state': STATE_ERROR_GENERAL, 'result': substitutedFormula};
      }
    }
  }

  bool _isFullySubstituted(String tempSubstitutedFormula, substitutedFormula) {
    return double.tryParse(tempSubstitutedFormula.replaceAll(RegExp(r'[\(\)]'), '')) != null ||
        substitutedFormula == tempSubstitutedFormula.replaceAll(RegExp(r'[\(\)]'), '');
  }

  dynamic _evaluateFormula(String formula, Map<String, String> values) {
    Expression expression = parser.parse(formula.toLowerCase());
    var result = expression.evaluate(EvaluationType.REAL, _context);
    if (result == null) throw Exception();

    return result;
  }

  List<FormulaValue> _prepareValues(List<FormulaValue> values) {
    List<FormulaValue> val = [];
    values.forEach((element) {
      var key = element.key.trim();
      var value = element.value;

      if (value == null || value.length == 0) {
        value = key;
      } else if (element.type == FormulaValueType.VALUE && double.tryParse(value) == null) {
        value = '($value)';
      }

      val.add(FormulaValue(key, value, type: element.type));
    });
    return val;
  }

  Map<String, dynamic> parse(String formula, List<FormulaValue> values, {expandValues: true}) {
    if (formula == null) return {'state': STATE_ERROR_GENERAL, 'output': [{'result': formula, 'state': STATE_ERROR_GENERAL}]};

    formula = formula.trim();

    if (formula == '') return {'state': STATE_ERROR_GENERAL, 'output': [{'result': formula, 'state': STATE_ERROR_GENERAL}]};

    if (values == null) values = <FormulaValue>[];

    RegExp regExp = RegExp(r'\[.+?\]');
    var matches = regExp.allMatches(formula);

    var hasBrackets = true;
    if (matches.length == 0) {
      matches = RegExp(r'^.*$').allMatches(formula);
      hasBrackets = false;
    }

    Map<String, Map<String, Map<String, dynamic>>> matchedVariables = {};

    var overallState = STATE_OK;
    matches.forEach((match) {
      var matchString = match.group(0);
      var content = hasBrackets ? matchString.substring(1, matchString.length - 1) : matchString;

      var result = _parseFormula(content, values, expandValues);
      var state = result['state'];
      switch (state) {
        case STATE_OK:
          Map<String, dynamic> out = {'result': _formatOutput(result['result']), 'state': state};
          if (matchedVariables.containsKey(null)) {
            matchedVariables[null].putIfAbsent(matchString, () => out);
          } else {
            matchedVariables.putIfAbsent(null, () => {matchString: out});
          }
          break;
        case STATE_ERROR_GENERAL:
        case STATE_EXPANDED_ERROR_EXCEEDEDRANGE:
          matchedVariables.putIfAbsent(null, () => {matchString: {'result': hasBrackets ? '[${result['result']}]' : result['result'], 'state': state}});
          if (overallState != STATE_EXPANDED_ERROR)
            overallState = state;
          break;
        case STATE_EXPANDED_OK:
        case STATE_EXPANDED_ERROR:
          result['result'].forEach((result) {
            var formatted;
            if (result['state'] == STATE_OK) {
              formatted = _formatOutput(result['result']);
            } else {
              formatted =  hasBrackets ? '[${result['result']}]' : result['result'];
            }

            Map<String, dynamic> out = {'result': formatted, 'variables': result['variables'], 'state': result['state']};

            var variables = result['variables'].toString();
            if (matchedVariables.containsKey(variables)) {
              matchedVariables[variables].putIfAbsent(matchString, () => out);
            } else {
              matchedVariables.putIfAbsent(variables, () => {matchString: out});
            }

            if (state == STATE_EXPANDED_OK) {
              if (overallState == STATE_ERROR_GENERAL)
                overallState = STATE_EXPANDED_ERROR;
              else if (overallState != STATE_EXPANDED_ERROR)
                overallState = result['state'] == STATE_OK ? STATE_EXPANDED_OK : STATE_EXPANDED_ERROR;
            } else {
              overallState = STATE_EXPANDED_ERROR;
            }
          });

          break;
      }
    });

    List<Map<String, dynamic>> output = [];
    matchedVariables.values.forEach((Map<String, Map<String, dynamic>> matchedResults) {
      Map<String, String> substitutions = {};
      var variables;
      var state = STATE_OK;
      matchedResults.forEach((String matchedString, Map<String, dynamic> result) {
        if (variables == null)
          variables = result['variables'];
        if (result['state'] == STATE_ERROR_GENERAL)
          state = STATE_ERROR_GENERAL;
        substitutions.putIfAbsent(matchedString, () => result['result']);
      });

      var backSubstituted = substitution(formula, substitutions);
      var exists = false;
      for (int i = 0; i < output.length; i++) {
        if (output[i]['result'] == backSubstituted) {
          exists = true;
          break;
        }
      }

      if (!exists) {
        Map<String, dynamic> out = {'result': substitution(formula, substitutions), 'state': state};
        if (variables != null)
          out.putIfAbsent('variables', () => variables);
        output.add(out);
      }
    });

    return {'state': overallState, 'output': output};
  }

  String _formatOutput(dynamic value) {
    if (value is double) {
      return NumberFormat('0.############').format(value);
    } else {
      return value.toString();
    }
  }
}
