import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/utils/json_utils.dart';

void main() {
  group("JsonUtils.jsonDouble:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '', 'expectedOutput' : null},

      {'input' : 1, 'expectedOutput' : 1.0},
      {'input' : 1.0, 'expectedOutput' : 1.0},
      {'input' : 1.5, 'expectedOutput' : 1.5},

      {'input' : 'A', 'expectedOutput' : null},
      {'input' : true, 'expectedOutput' : null},
      {'input' : false, 'expectedOutput' : null},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = jsonDouble(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("JsonUtils.jsonInt:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '', 'expectedOutput' : null},

      {'input' : 1, 'expectedOutput' : 1},
      {'input' : 1.0, 'expectedOutput' : 1},
      {'input' : 1.5, 'expectedOutput' : null},

      {'input' : 'A', 'expectedOutput' : null},
      {'input' : true, 'expectedOutput' : null},
      {'input' : false, 'expectedOutput' : null},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = jsonInt(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("JsonUtils.jsonBool:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '', 'expectedOutput' : null},

      {'input' : true, 'expectedOutput' : true},
      {'input' : false, 'expectedOutput' : false},

      {'input' : 1, 'expectedOutput' : null},
      {'input' : 1.0, 'expectedOutput' : null},
      {'input' : 1.5, 'expectedOutput' : null},
      {'input' : 'A', 'expectedOutput' : null},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = jsonBool(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("JsonUtils.jsonString:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'test', 'expectedOutput' : 'test'},
      {'input' : 1, 'expectedOutput' : '1'},
      {'input' : 1.0, 'expectedOutput' : '1.0'},

      {'input' : true, 'expectedOutput' : 'true'},
      {'input' : false, 'expectedOutput' : 'false'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = jsonString(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("JsonUtils.jsonStringList:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : [], 'expectedOutput' : <String>[]},

      {'input' : {'test', 'test1'}.toList(), 'expectedOutput' : {'test', 'test1'}},
      {'input' : {'test', 1}.toList(), 'expectedOutput' : {'test', '1'}},
      {'input' : {true, false}.toList(), 'expectedOutput' : {'true', 'false'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}}', () {
        var _actual = jsonStringList(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}