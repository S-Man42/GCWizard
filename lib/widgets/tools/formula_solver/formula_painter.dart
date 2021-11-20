import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:gc_wizard/utils/common_utils.dart';

String paintFormula(String formula, Map<String, String> values, int formulaIndex, bool coloredFormulas) {
  if (formula == null) return null;
  if (!coloredFormulas)
    return _buildResultString('t', formula.length);

  final oppositeBracket =  { '[': ']', '(': ')', '{': '}' };
  final oppositeBracket2 = switchMapKeyValue(oppositeBracket);
  var result = '';
  var brackets = <String>[];
  var operators = { '+', '-', '*', '/', '^', '%' };
  var containsBrackets = formula.contains('[') || formula.contains(']');
  var checkedFormulaResult = '';
  var keys = <String>[];
  var functions = <String>[];
  var _allCharacters = allCharacters();

  var operatorsRegEx = operators.map((op) => r'\' + op).join();

  if (values != null) {
    keys = values.keys.map((key) {
      return ((key == null) || (key.length == 0)) ? null : key;
    }).toList();
  }
  keys.addAll(FormulaParser.constants.keys);
  keys = keys.map((key) {return key.toUpperCase();}).toList();
  keys.sort((a, b) => b.length.compareTo(a.length));

  functions.addAll(FormulaParser.functions);
  functions = functions.map((function) {return function.toUpperCase();}).toList();
  functions.sort((a, b) => b.length.compareTo(a.length));

  formula = FormulaParser.normalizeMathematicalSymbols(formula);
  formula = formula.toUpperCase();
  formula.split('').forEach((e) {
    // checked
    if (checkedFormulaResult.length > 0) {
      result += checkedFormulaResult[0];
      checkedFormulaResult = checkedFormulaResult.substring(1);

      if (oppositeBracket.containsKey(e)) brackets.add(e);
      if (oppositeBracket2.containsKey(e)) {
        var validBracket = (brackets.length > 0) && (brackets[brackets.length - 1] == oppositeBracket2[e]);
        if (validBracket) brackets.removeAt(brackets.length - 1);
      }

    } else {
      // numbers
      if (int.tryParse(e) != null)
        result +=
        _calculated(formula, result, brackets, containsBrackets) ? 'g' : 't';

      // spaces
      else if (e == ' ')
        result += ((result.isEmpty) ? "s" : result[result.length - 1]);

      // formula reference
      else if (e == '{') {
        brackets.add(e);
        var _result = _validFormulaReference(formula.substring(result.length), result, formulaIndex);

        result += _result[0];
        checkedFormulaResult = _result.substring(1);

        //open brackets
      } else if (oppositeBracket.containsKey(e)) {
        brackets.add(e);
        var _result = _checkBracket(formula.substring(result.length), result, e , oppositeBracket[e]);
        result += _result[0];
        checkedFormulaResult = _result.substring(1);

        // close brackets
      } else if (oppositeBracket2.containsKey(e)) {
        var validBracket = (brackets.isNotEmpty) && (brackets[brackets.length - 1] == oppositeBracket2[e]);
        //validBracket = validBracket && ((result.length == 0) || formula[result.length - 1] != opposideBracket2[e]);
        result += validBracket ? "b" : "B";
        if (validBracket) brackets.removeAt(brackets.length - 1);

        // operators
      } else if (operators.contains(e)) {
        var _result = _validOperator(formula.substring(result.length), operatorsRegEx);
        var firstOperatorValid = _validFirstOperator(formula.substring(0, result.length+1), result);
        if (_result.startsWith('b') && firstOperatorValid)
          result += _calculated(formula, result, brackets, containsBrackets) ? 'b' : 't';
        else {
          _result = _buildResultString('B', firstOperatorValid ? _result.length : 1);
          result += _result[0];
          checkedFormulaResult = _result.substring(1);
        }

        //formulas, constants, variables
      } else if (_calculated(formula, result, brackets, containsBrackets)) {
        var valid = false;
        var handled = false;
        // check functions
        for (String function in functions) {
          if (formula.substring(result.length).startsWith(function)) {
            var _result = _validFunction(formula.substring(result.length), function, formula.substring(0, result.length));
            if (_result.isNotEmpty) {
              result += _result[0];
              checkedFormulaResult = _result.substring(1);
              handled = true;
              break;
            } else {
              var _result = _invalidFunction(formula.substring(result.length));
              if (_result.isNotEmpty) {
                result += _result[0];
                checkedFormulaResult = _result.substring(1);
                handled = true;
                break;
              }
            }

          }
        }

        // non function
        if (!handled) {
          // constant or variable
          for (String key in keys) {
            if (formula.substring(result.length).startsWith(key)) {
              valid = true;
              checkedFormulaResult = _buildResultString('r', key.length - 1);
              break;
            }
          }

          if (!valid && !_allCharacters.contains(e))
            result += 't';
          else
            result += valid ? 'r' : 'R';
        }
      } else
        result += 't';
    }
  });

  for (int i = result.length - 2; i >= 0; i--)
    if (result[i] == 's') result = result.substring(0, i) + result[i + 1] + result.substring(i + 1);

  return result;
}

bool _calculated(String formula, String result, List<String> brackets, bool containsBrackets) {
  if (!containsBrackets) return true;

  return (brackets.contains('[') && (formula.substring(result.length).contains(']')));
}

String _validFunction(String formula, String function, String formulaBefore) {
  var valid = true;
  if (RegExp(r'[0-9](\s)*$').firstMatch(formulaBefore) != null) valid = false;
  if (RegExp(r'[\[\]\(\)](\s)*$').firstMatch(formulaBefore) != null) valid = false;

  var regex = RegExp(r'^(.+)[\s]*[(][\s]*[\S]+[\s]*[)]');
  var matches = regex.allMatches(formula);
  if (matches.length > 0) return _buildResultString(valid ? 'b' : 'B', function.length);

  return '';
}

String _invalidFunction(String formula) {
  var regex = RegExp(r'^(.+)[\s]*[(][\s]*[)]');
  var match = regex.firstMatch(formula);
  if (match != null) return _buildResultString('B', match.end);

  return '';
}

String _validOperator(String formula, String operators) {
  var emptyBrackets = r'((\(\s*\))|(\[\s*\]))';
  var bracketMatches = RegExp(emptyBrackets).allMatches(formula);
  bracketMatches.forEach((match) {
    formula = _replaceRange(formula, match.start, match.end, ' ');
  });
  var regex = RegExp('^[$operators]' + r'[\s]*[\-]*[\s]*' + '[^$operators' + r'\s]');
  var match = regex.firstMatch(formula);
  if (match != null) {
    if (bracketMatches.isEmpty || bracketMatches.first.end >= match.end - 1)
      return _buildResultString('b', match.end - 1);
  }

  regex = RegExp('^[$operators]' + r'[\s]*[\-]*[\s]*' + '[$operators]*');
  match = regex.firstMatch(formula);
  return _buildResultString('B', (match != null) ? match.end : 1);
}

bool _validFirstOperator(String formulaBefore, String result) {
  if (formulaBefore[formulaBefore.length -1] == '-') return true;
  formulaBefore = formulaBefore.trim();

  return formulaBefore.length > 1;
}

String _validFormulaReference(String formula, String result, int formulaId) {
  RegExp regex = RegExp(r'[{](\d)[}]');
  var match = regex.firstMatch(formula);
  if (match != null) {
    if (int.tryParse(match.group(1)) < formulaId)
      return _buildResultString('b' , match.end);
    else
      return 'b' + _buildResultString('B' , match.end - 2) + 'b';
  }

  var bracketIndex = formula.indexOf('}');
  return _buildResultString('B', (bracketIndex >= 0) ? bracketIndex +1 : 1);
}

String _checkBracket(String formula, String result, String startBracket, endBracket) {
  var validBracket = true;
  var match = RegExp('[\\$endBracket]').firstMatch(formula);
  if (match == null) validBracket = false;
  // if (startBracket == '(') {
  //   if (result.isNotEmpty ) {
  //     if (RegExp(r'[rR](\s)*$').firstMatch(result) != 0)
  //       return (match != null) ? _buildResultString('B', match.end) : 'B';
  //   }
  // }
  return validBracket ? 'b' : 'B';
}

String _replaceRange(String result, int start, int end, String value) {
  var replacement = '';
  for( var i = start; i < end; i++)
    replacement += value;

  return result.replaceRange(start, end, replacement);
}

bool _validBracket(String result) {
  var regex = RegExp(r'[RGB]');
  var matches = regex.allMatches(result);
  return (matches.length == 0) ;
}

String _buildResultString(String s, int count) {
  var result = '';
  for (var i = 0; i < count; i++)
    result += s;
  return result;
}