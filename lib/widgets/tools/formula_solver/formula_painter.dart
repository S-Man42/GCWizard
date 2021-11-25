import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:gc_wizard/utils/common_utils.dart';

class FormulaPainter {
  final operators = { '+', '-', '*', '/', '^', '%' };
  final _allCharacters = allCharacters();
  var _variables = <String>[];
  var _functions = <String>[];
  var _constants = <String>[];
  int _formulaId;

  String _operatorsRegEx;
  String _functionsRegEx;
  String _constantsRegEx;
  //String _allCharactersRegEx;
  String _variablesRegEx;

  FormulaPainter() {
    _functions = _toUpperCaseAndSort(FormulaParser.availableParserFunctions());
    _constants = _toUpperCaseAndSort(FormulaParser.CONSTANTS.keys.toList());

    _operatorsRegEx = operators.map((op) => r'\' + op).join();
    _functionsRegEx = _functions.map((function) => function).join('|');
    _constantsRegEx = _functions.map((constant) => constant).join('|');
    //_allCharactersRegEx = _functions.map((character) => character).join('|');
  }


  String paintFormula(String formula, Map<String, String> values, int formulaIndex, bool coloredFormulas) {
    if (formula == null) return null;

    var result = _buildResultString('t', formula.length);
    if (!coloredFormulas) return result;

    var subResult = '';
    this. _formulaId = formulaIndex;


    if (values != null) {
      _variables = values.keys.map((variable) {
        return ((variable == null) || (variable.length == 0)) ? null : variable;
      }).toList();
    }
    _variables = _toUpperCaseAndSort(_variables);
    _variablesRegEx = _variables.map((variable) => variable).join('|');


    formula = FormulaParser.normalizeMathematicalSymbols(formula);
    formula = formula.toUpperCase();

    RegExp regExp = new RegExp(r'(\[)(.+?)(\])');
    var matches = regExp.allMatches(formula);
    if (matches.length > 0) {
      matches.forEach((match) {
        var _parserResult = [match.group(1), match.group(2), match.group(3)];
        result = _coloredContent(result, _parserResult );

        subResult = _paintSubFormula(_parserResult[1]);
        result = _replaceRange(result, _calcOffset(_parserResult, count: 1) - 1, null, subResult);
      });
    } else {
      result = _paintSubFormula(formula);
    }

    return result;
  }

  String _paintSubFormula(String formula) {
    var offset = 0;
    var result = _buildResultString('t', formula.length);
    String subResult;
    List<String> _parserResult;


    if (formula.length > 0) {
      // reference
      if (offset == 0) {
        _parserResult = _isFormulaReference(formula);
        if (_parserResult != null) {
          result = _coloredFormulaReference(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }
      // function
      if (offset == 0) {
        _parserResult = _isFunction(formula);
        if (_parserResult != null) {
          result = _coloredFunction(result, _parserResult);
          // literal
          offset = _calcOffset(_parserResult, count: 2);

          subResult = _paintSubFormula(formula.substring(offset, _calcOffset(_parserResult, count: 3)));
          result = _replaceRange(result, offset, null, subResult);
          offset = _calcOffset(_parserResult);
        }
      }
      // constant
      if (offset == 0) {
        _parserResult = _isConstant(formula);
        if (_parserResult != null) {
          result = _coloredConstant(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }
      // variable
      if (offset == 0) {
        _parserResult = _isVariable(formula);
        if (_parserResult != null) {
          result = _coloredVariable(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }
      // invalid variable
      if (offset == 0) {
        _parserResult = _isInvalidVariable(formula);
        if (_parserResult != null) {
          result = _coloredInvalidVariable(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }
      // number with point
      if (offset == 0) {
        _parserResult = _isNumberWithPoint(formula);
        if (_parserResult != null) {
          result = _coloredNumber(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }
      // number
      if (offset == 0) {
        _parserResult = _isNumber(formula);
        if (_parserResult != null) {
          result = _coloredNumber(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }
      // operator
      if (offset == 0) {
        _parserResult = _isOperator(formula);
        if (_parserResult != null) {
          result = _coloredOperator(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }
      // invalid operator
      if (offset == 0) {
        _parserResult = _isInvalidOperator(formula);
        if (_parserResult != null) {
          result = _coloredInvalidOperator(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }

      // undefnied ?
      if (offset == 0) {
        subResult = 'R';
        result = _replaceRange(result, offset, subResult.length, subResult);
        offset == subResult.length;
      }

      // analyse rest recursive
      if (offset + 1 < formula.length) {
        subResult = formula.substring(offset + 1);
        subResult = _paintSubFormula(subResult);
        result = _replaceRange(result, offset, null, subResult);
      }
    }

    return result;
  }


  List<String> _isFormulaReference(String formula) {
    RegExp regex = RegExp(r'^(\s)*({)(\d)(})');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [_combineGroups([match.group(1), match.group(2)]),
      match.group(3),
      match.group(4)];
  }

  String _coloredFormulaReference(String result, List<String> parts) {
    result = _replaceRange(result, 0, parts[0].length, 'b');
    if (int.tryParse(parts[1]) < _formulaId)
      result = _replaceRange(result, _calcOffset(parts, count: 1) - 1, parts[1].length, 'b');
    else
      result = _replaceRange(result, _calcOffset(parts, count: 1) - 1, parts[1].length, 'B');
    result = _replaceRange(result, _calcOffset(parts, count: 2) - 1, parts[2].length, 'b');

    return result;
  }

  List<String> _isFunction(String formula) {
    //RegExp regex = RegExp(r'^(\s)*\b(' + _functionsRegEx + r')\b(\s)*(\()(\s)*(\S)+(\s)*(\))');
    RegExp regex = RegExp(r'^(\s)*\b(' + _functionsRegEx + r')\b(\s)*(\()');
    var match = regex.firstMatch(formula);

    if (match == null) return null;
    var functionName = _combineGroups([match.group(1), match.group(2), match.group(3)]);
    var offset = functionName.length;
    var result = seperateLiteral(formula.substring(offset), '(', ')');

    if (result == null) return null;
    return [_combineGroups([functionName, result[0]]),
            result[1],
            result[2],
            result[3]];
  }

  String _coloredFunction(String result, List<String> parts) {
    result = _replaceRange(result, 0, parts[0].length, 'b');
    result = _replaceRange(result, _calcOffset(parts, count: 1), parts[1].length, 'b');
    result = _replaceRange(result, _calcOffset(parts, count: 3), parts[3].length, 'b');
    return result;
  }

  String _coloredContent(String result, List<String> parts) {
    result = _replaceRange(result, 0, parts[0].length, 'b');
    result = _replaceRange(result, _calcOffset(parts, count: 2)-1, parts[2].length, 'b');
    return result;
  }

  List<String> _isConstant(String formula) {
    RegExp regex = RegExp(r'^(\s)(' + _constantsRegEx + ')');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredConstant(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'g');
  }

  List<String> _isVariable(String formula) {
    if (_variablesRegEx.isEmpty) return null;
    RegExp regex = RegExp(r'^(\s)*(' + _variablesRegEx + ')');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredVariable(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'r');
  }

  List<String> _isInvalidVariable(String formula) {
    RegExp regex = RegExp(r'^(\s)(\S)');
    var match = regex.firstMatch(formula);

    if ((match != null) && (_allCharacters.contains(match.group(2))))
      return [match.group(0)];
    else
      return null;
    }

  String _coloredInvalidVariable(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'R');
  }

  List<String> _isNumberWithPoint(String formula) {
    RegExp regex = RegExp(r'^(\s)(0-9)*(\.)?(0-9)+');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  List<String> _isNumber(String formula) {
    RegExp regex = RegExp(r'^(\s)(0-9)+');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredNumber(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'g');
  }

  List<String> _isOperator(String formula) {
    var regex = RegExp(r'^(\s)*(' + _operatorsRegEx + r')(\s)*(\-)*(\s)*(^' + _operatorsRegEx +')');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredOperator(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'b');
  }

  List<String> _isInvalidOperator(String formula) {
    var regex = RegExp(r'^(\s)*(' + _operatorsRegEx +')');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredInvalidOperator(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'B');
  }


  String _replaceRange(String string, int start, int length, String replacement) {
    if (length == null)
      return string.replaceRange(start, start + replacement.length, replacement);
    else
      return string.replaceRange(start, start + length, replacement * length);
  }

  int _calcOffset(List<String> list, {int count = -1}) {
    var length = 0;
    for (var i = 0; i< list.length; i++) {
      if ((count > 0) && (i >= count)) break;
      length += list[i].length;
    }
    return length;
  }

  List<String> _toUpperCaseAndSort(List<String> list) {
    list = list.map((entry) {return entry.toUpperCase();}).toList();
    list.sort((a, b) => b.length.compareTo(a.length));
    return list;
  }

  String _buildResultString(String s, int count) {
    return s * count;
  }

  List<String> seperateLiteral(String formula, String openBracket, String closeBracket) {
    var bracketCounter = 0;
    var bracketPosition = -1;

    for (var i=0; i < formula.length; i++) {
      if (formula[i] == openBracket) {
        bracketCounter += 1;
        if (bracketPosition < 0) bracketPosition = i;
      } else if ((formula[i] == closeBracket) && (bracketCounter > 0)) {
        bracketCounter--;
        if (bracketCounter == 0) return [ formula.substring(0, bracketPosition), formula[bracketPosition], formula.substring(bracketPosition +1 , i-1), formula[i]];
      }
    }

    return null;
  }

  String _combineGroups(List<String> list) {
    return list.map((e) { return e == null ? '' : e;}).join();
  }
}