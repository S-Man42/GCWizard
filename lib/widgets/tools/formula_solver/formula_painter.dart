import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:gc_wizard/utils/common_utils.dart';

class FormulaPainter {
  static final _operators = { '+', '-', '*', '/', '^', '%' };
  static final _bracket =  { '[': ']', '(': ')', '{': '}' };
  static final numberRegEx = r'(\s*(\d+.\d*|\d*\.\d|\d+)\s*)';// r'(\s*(\d+(.\d*)?|(.\d+))\s*)';
  static final multiCommaNumberRegEx = '^(' + numberRegEx + ')((,)(' + numberRegEx + '))*';
  static final _allCharacters = allCharacters();
  var _variables = <String>[];
  var _functions = <String>[];
  var _specialFunctions = { 'LOG': 1, //'^' + numberRegEx + r'(,)(\s*\d+\s*)', // 1 comma
                            'ROUND': numberRegEx + r'((,)(\s*\d?\s*))?', // 0 or 1 comma
                            'MIN': multiCommaNumberRegEx, // comma 0 or more times
                            'MAX': multiCommaNumberRegEx,  // comma 0 or more times
                            'CS':  multiCommaNumberRegEx,  // comma 0 or more times
                            'CSI':  multiCommaNumberRegEx  // comma 0 or more times
                          };
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

    _operatorsRegEx = _operators.map((op) => r'\' + op).join();
    _functionsRegEx = _functions.map((function) => function).join('|');
    _constantsRegEx = _constants.map((constant) => constant).join('|');
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
    } else
      _variables.clear();

    _variables = _toUpperCaseAndSort(_variables);
    _variablesRegEx = _variables.map((variable) => variable).join('|');


    formula = FormulaParser.normalizeMathematicalSymbols(formula);
    formula = formula.toUpperCase();

    RegExp regExp = new RegExp(r'(\[)(.+?|\s*)(\])'); //(r'(\[)(.+?)(\])');
    var matches = regExp.allMatches(formula);
    if (matches.isNotEmpty) {
      matches.forEach((match) {
        var _parserResult = [formula.substring(0, match.start), match.group(1), match.group(2), match.group(3)];
        var literal = _parserResult[2];
        var emptyLiteral = literal.trim().isEmpty;
        result = _coloredContent(result, _parserResult, emptyLiteral );

        subResult = _paintSubFormula(literal, 0);
        result = _replaceRange(result, _calcOffset(_parserResult, count: 2), null, subResult);
      });
    } else {
      result = _paintSubFormula(formula, 0);
    }

    return _replaceSpaces(result);
  }

  String _paintSubFormula(String formula, int literalOffset) {
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
      // // invalid reference
      // if (offset == 0) {
      //   _parserResult = _isInvalidFormulaReference(formula);
      //   if (_parserResult != null) {
      //     result = _coloredInvalidFormulaReference(result, _parserResult);
      //     offset = _calcOffset(_parserResult);
      //   }
      // }
      // function
      if (offset == 0) {
        _parserResult = _isFunction(formula);
        if (_parserResult != null) {
          result = _coloredFunction(result, _parserResult);
          // literal
          offset = _calcOffset(_parserResult, count: 2);
          subResult = formula.substring(offset, _calcOffset(_parserResult, count: 3));

          if (_specialFunctions.containsKey(_parserResult[0].trim())) {
            var _parserSubResult = _isSpecialFunctionsLiteral(subResult, _parserResult);
            subResult = _coloredSpecialFunctionsLiteral(subResult, _parserSubResult);
            result = _replaceRange(result, offset, null, subResult);
          } else {
            // literal
            subResult = _paintSubFormula(subResult, 0);
            result = _replaceRange(result, offset, null, subResult);
          }
          offset = _calcOffset(_parserResult);
        }
      }
      // literal
      if (offset == 0) {
        _parserResult = _isLiteral(formula);
        if (_parserResult != null) {
          offset = _calcOffset(_parserResult, count: 1);
          var literal = formula.substring(offset, _calcOffset(_parserResult, count: 2));
          var emptyLiteral = literal.trim().isEmpty;

          result = _coloredLiteral(result, _parserResult, emptyLiteral);
          // literal
          if (!emptyLiteral) {
            subResult = _paintSubFormula(literal, literalOffset + offset);
            result = _replaceRange(result, offset, null, subResult);
            offset = _calcOffset(_parserResult);
          }
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
        _parserResult = _isOperator(formula, literalOffset );
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
      // spaces
      if (offset == 0) {
        _parserResult = _isSpaces(formula);
        if (_parserResult != null) {
          result = _coloredSpaces(result, _parserResult);
          offset = _calcOffset(_parserResult);
        }
      }

      // undefnied ?
      if (offset == 0) {
        subResult = 'R';
        if (_bracket.containsKey(formula[0])) subResult = 'B';
        if (_bracket.containsValue(formula[0])) subResult = 'B';
        if (formula[0] == ',') subResult = 'B';
        result = _replaceRange(result, offset, subResult.length, subResult);
        offset = subResult.length;
      }

      // analyse rest recursive
      if (offset < formula.length) {
        subResult = formula.substring(offset);
        subResult = _paintSubFormula(subResult, literalOffset + offset);
        result = _replaceRange(result, offset, null, subResult);
      }
    }

    return result;
  }

  List<String> _isSpaces(String formula) {
    RegExp regex = RegExp(r'^(\s*)');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredSpaces(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 's');
  }

  List<String> _isFormulaReference(String formula) {
    RegExp regex = RegExp(r'^({)([1-9][0-9]*)(})');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(1), match.group(2), match.group(3)];
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

  // List<String> _isInvalidFormulaReference(String formula) {
  //   RegExp regex = RegExp(r'^({)(\.*)(})');
  //   var match = regex.firstMatch(formula);
  //
  //   return (match == null) ? null : [match.group(1), match.group(2), match.group(3)];
  // }
  //
  // String _coloredInvalidFormulaReference(String result, List<String> parts) {
  //   result = _replaceRange(result, 0, parts[0].length, 'b');
  //   result = _replaceRange(result, _calcOffset(parts, count: 1) - 1, parts[1].length, 'B');
  //   result = _replaceRange(result, _calcOffset(parts, count: 2) - 1, parts[2].length, 'b');
  //
  //   return result;
  // }

  List<String> _isFunction(String formula) {
    //RegExp regex = RegExp(r'^(\s*)\b(' + _functionsRegEx + r')\b(\s*)(\()(\s*)(\S+)(\s*)(\))');
    RegExp regex = RegExp(r'^\b(' + _functionsRegEx + r')\b(\s*)(\()');
    var match = regex.firstMatch(formula);

    if (match == null) return null;
    var functionName = _combineGroups([match.group(1), match.group(2)]);
    var offset = functionName.length;
    var result = _seperateLiteral(formula.substring(offset), '(', ')');

    if (result == null) return null;
    //if (result[2].isEmpty) return null;
    return [_combineGroups([functionName, result[0]]),
            result[1],
            result[2],
            result[3]];
  }

  String _coloredFunction(String result, List<String> parts) {
    var emptyLiteral = parts[2].trim().isNotEmpty;
    result = _replaceRange(result, 0, parts[0].length, emptyLiteral ? 'b' : 'B');
    result = _replaceRange(result, _calcOffset(parts, count: 1), parts[1].length, emptyLiteral ? 'b' : 'B');
    result = _replaceRange(result, _calcOffset(parts, count: 3), parts[3].length, emptyLiteral ? 'b' : 'B');
    if (emptyLiteral)
      result = _replaceRange(result, _calcOffset(parts, count: 2), parts[2].length, 'B');

    return result;
  }

  List<String> _isSpecialFunctionsLiteral(String formula, List<String> parts) {
    var functionName = parts[0].trim();
    // RegExp regex = RegExp(_specialFunctions[functionName]);
    // var match = regex.firstMatch(formula);
    //
    // if (match == null) return null;
    //
    // var result = <String>[];
    // for (var i = 1; i <= match.groupCount; i++)
    //   if ((match.group(i) != null) ) result.add(match.group(i));
    // var _specialFunctions = { 'LOG': 1, //'^' + numberRegEx + r'(,)(\s*\d+\s*)', // 1 comma
    // 'ROUND': numberRegEx + r'((,)(\s*\d?\s*))?', // 0 or 1 comma
    // 'MIN': multiCommaNumberRegEx, // comma 0 or more times
    // 'MAX': multiCommaNumberRegEx,  // comma 0 or more times
    // 'CS':  multiCommaNumberRegEx,  // comma 0 or more times
    // 'CSI':  multiCommaNumberRegEx  // comma 0 or more times


    var result = <String>[];
    var splited = formula.split(',');
    var valid = true;
    switch (functionName) {
      case 'LOG':
        valid = splited.length == 2;
        break;
      case 'ROUND':
        valid = splited.length <= 2;
        break;
    }
    if (!valid) return null;

    for (var i = 0; i < splited.length; i++) {
      if (result.isNotEmpty) result.add(',');
      result.add(_paintSubFormula(splited[i], 0));
    }

    return result;
  }

  String _coloredSpecialFunctionsLiteral(String result, List<String> parts) {
    if (parts != null) {
      for (var i = 0; i < parts.length; i++)
        result = _replaceRange(result, _calcOffset(parts, count: i), parts[i].length, (i % 2 == 0) ? 'g' : 'b');
    } else
      result = _buildResultString('R', result.length);

    return result;
  }


  List<String> _isLiteral(String formula) {
    RegExp regex = RegExp(r'^([\(\{])');
    var match = regex.firstMatch(formula);

    if (match == null) return null;
    var result = _seperateLiteral(formula.substring(match.start), match.group(1), _bracket[match.group(1)]);

    if (result == null) return null;
    return [result[1],
            result[2],
            result[3]];
  }

  String _coloredLiteral(String result, List<String> parts, bool empty) {
    result = _replaceRange(result, 0, parts[0].length, empty ? 'B': 'b');
    result = _replaceRange(result, _calcOffset(parts, count: 2), parts[2].length, empty ? 'B': 'b');
    if (empty)
      result = _replaceRange(result, _calcOffset(parts, count: 1), parts[1].length, 'B');

    return result;
  }

  String _coloredContent(String result, List<String> parts, bool empty) {
    result = _replaceRange(result, parts[0].length, parts[1].length, empty ? 'B': 'b');
    result = _replaceRange(result, _calcOffset(parts, count: 3), parts[3].length, empty ? 'B': 'b');
    if (empty)
      result = _replaceRange(result, _calcOffset(parts, count: 2), parts[2].length, 'B');

    return result;
  }

  List<String> _isConstant(String formula) {
    RegExp regex = RegExp(r'^\b(' + _constantsRegEx + r')\b');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredConstant(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'g');
  }

  List<String> _isVariable(String formula) {
    if (_variablesRegEx.isEmpty) return null;
    RegExp regex = RegExp(r'^(' + _variablesRegEx + ')');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredVariable(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'r');
  }

  List<String> _isInvalidVariable(String formula) {
    RegExp regex = RegExp(r'^(\S)');
    var match = regex.firstMatch(formula);

    if ((match != null) && (_allCharacters.contains(match.group(1))))
      return [match.group(0)];
    else
      return null;
    }

  String _coloredInvalidVariable(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'R');
  }

  List<String> _isNumberWithPoint(String formula) {
    RegExp regex = RegExp('^$numberRegEx'); //RegExp('(\s*)([\d.])+'); //RegExp('^$numberRegEx');
    var match = regex.firstMatch(formula);
    if (match == null) return null;

    var value = double.tryParse(match.group(0));
    return (value == null) ? null : [match.group(0)];
  }

  List<String> _isNumber(String formula) {
    RegExp regex = RegExp(r'^(\d)+');
    var match = regex.firstMatch(formula);

    return (match == null) ? null : [match.group(0)];
  }

  String _coloredNumber(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'g');
  }

  List<String> _isOperator(String formula, var offset) {
    var regex = RegExp(r'^([' + _operatorsRegEx + r'])(\s*)(\-)*(\s*)([^' + _operatorsRegEx +'])');
    var match = regex.firstMatch(formula);

    if ((match != null) && (offset == 0) && (match.group(0)[0] != '-')) return null;
    return (match == null) ? null : [_combineGroups([match.group(1), match.group(2), match.group(3), match.group(4)])];
  }

  String _coloredOperator(String result, List<String> parts) {
    return _replaceRange(result, 0, parts[0].length, 'b');
  }

  List<String> _isInvalidOperator(String formula) {
    var regex = RegExp(r'^([' + _operatorsRegEx +']+)');
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
    for (var i = 0; i < list.length; i++) {
      if ((count >= 0) && (i >= count)) break;
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

  List<String> _seperateLiteral(String formula, String openBracket, String closeBracket) {
    var bracketCounter = 0;
    var bracketPosition = -1;

    for (var i=0; i < formula.length; i++) {
      if (formula[i] == openBracket) {
        bracketCounter += 1;
        if (bracketPosition < 0) bracketPosition = i;
      } else if ((formula[i] == closeBracket) && (bracketCounter > 0)) {
        bracketCounter--;
        if (bracketCounter == 0) return [ formula.substring(0, bracketPosition), formula[bracketPosition], formula.substring(bracketPosition +1 , i), formula[i]];
      }
    }

    return null;
  }

  String _combineGroups(List<String> list) {
    return list.map((e) { return e == null ? '' : e;}).join();
  }

  String _replaceSpaces(String result) {
    for (var i = 1; i < result.length; i++)
      if (result[i] == 's') result = _replaceRange(result, i, 1, result[i - 1]);

    for (var i = result.length - 2; i > 0; i--)
      if (result[i] == 's') result = _replaceRange(result, i, 1, result[i + 1]) ;

    return result;
  }
}