import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/common/parser/variable_string_expander.dart';

void main() {

  group("VariableStringExpander.run:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input': 'N 51.[A][A+1] E [B][B^A].[4]23', 'substitutions': {'A': '1-3', 'B': '4-0#2,1', 'C': '12,34'}, 'addAsResult' : (e) => e, 'breakCondition' : VariableStringExpanderBreakCondition.RUN_ALL,
        'expectedOutput': [
          {'text': 'N 51.11+1 E 00^1.423', 'variables': {'A': '1', 'B': '0', 'C': '12'}},
          {'text': 'N 51.11+1 E 00^1.423', 'variables': {'A': '1', 'B': '0', 'C': '34'}},
          {'text': 'N 51.11+1 E 11^1.423', 'variables': {'A': '1', 'B': '1', 'C': '12'}},
          {'text': 'N 51.11+1 E 11^1.423', 'variables': {'A': '1', 'B': '1', 'C': '34'}},
          {'text': 'N 51.11+1 E 22^1.423', 'variables': {'A': '1', 'B': '2', 'C': '12'}},
          {'text': 'N 51.11+1 E 22^1.423', 'variables': {'A': '1', 'B': '2', 'C': '34'}},
          {'text': 'N 51.11+1 E 44^1.423', 'variables': {'A': '1', 'B': '4', 'C': '12'}},
          {'text': 'N 51.11+1 E 44^1.423', 'variables': {'A': '1', 'B': '4', 'C': '34'}},

          {'text': 'N 51.22+1 E 00^2.423', 'variables': {'A': '2', 'B': '0', 'C': '12'}},
          {'text': 'N 51.22+1 E 00^2.423', 'variables': {'A': '2', 'B': '0', 'C': '34'}},
          {'text': 'N 51.22+1 E 11^2.423', 'variables': {'A': '2', 'B': '1', 'C': '12'}},
          {'text': 'N 51.22+1 E 11^2.423', 'variables': {'A': '2', 'B': '1', 'C': '34'}},
          {'text': 'N 51.22+1 E 22^2.423', 'variables': {'A': '2', 'B': '2', 'C': '12'}},
          {'text': 'N 51.22+1 E 22^2.423', 'variables': {'A': '2', 'B': '2', 'C': '34'}},
          {'text': 'N 51.22+1 E 44^2.423', 'variables': {'A': '2', 'B': '4', 'C': '12'}},
          {'text': 'N 51.22+1 E 44^2.423', 'variables': {'A': '2', 'B': '4', 'C': '34'}},

          {'text': 'N 51.33+1 E 00^3.423', 'variables': {'A': '3', 'B': '0', 'C': '12'}},
          {'text': 'N 51.33+1 E 00^3.423', 'variables': {'A': '3', 'B': '0', 'C': '34'}},
          {'text': 'N 51.33+1 E 11^3.423', 'variables': {'A': '3', 'B': '1', 'C': '12'}},
          {'text': 'N 51.33+1 E 11^3.423', 'variables': {'A': '3', 'B': '1', 'C': '34'}},
          {'text': 'N 51.33+1 E 22^3.423', 'variables': {'A': '3', 'B': '2', 'C': '12'}},
          {'text': 'N 51.33+1 E 22^3.423', 'variables': {'A': '3', 'B': '2', 'C': '34'}},
          {'text': 'N 51.33+1 E 44^3.423', 'variables': {'A': '3', 'B': '4', 'C': '12'}},
          {'text': 'N 51.33+1 E 44^3.423', 'variables': {'A': '3', 'B': '4', 'C': '34'}},
        ]
      },
      {'input': 'N 51.[A][A+1] E [B][B^A].[4]23', 'substitutions': {'A': '1-3', 'B': '4-0#2,1', 'C': '12,34'}, 'addAsResult' : (e) => e, 'breakCondition' : VariableStringExpanderBreakCondition.BREAK_ON_FIRST_FOUND,
        'expectedOutput': [
          {'text': 'N 51.11+1 E 00^1.423', 'variables': {'A': '1', 'B': '0', 'C': '12'}},
        ]
      },
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, substitutions: ${elem['substitutions']}', () {
        var _actual = VariableStringExpander(elem['input'], elem['substitutions'], elem['addAsResult'], breakCondition: elem['breakCondition']).run();
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("VariableStringExpander.runOnlyPrecheck:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input': 'N 51.[A][A+1] E [B][B^A].[4]23', 'substitutions': {'A': '1-3', 'B': '4-0#2,1', 'C': '12,34'}, 'addAsResult' : (e) => e, 'breakCondition' : VariableStringExpanderBreakCondition.RUN_ALL,
        'expectedOutput': [{'count' : 24}]
      }
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, substitutions: ${elem['substitutions']}', () {
        var _actual = VariableStringExpander(elem['input'], elem['substitutions'], elem['addAsResult'], breakCondition: elem['breakCondition']).run(onlyPrecheck: true);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}