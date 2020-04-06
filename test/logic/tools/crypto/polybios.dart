import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto/polybios.dart';

void main() {
  group("Polybios.createPolybiosAlphabet:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'gridDimension' : null, 'firstLetters': null, 'mode': null, 'fillAlphabet': null, 'expectedOutput' : null},
      {'gridDimension' : 5, 'firstLetters': null, 'mode': PolybiosMode.AZ09, 'fillAlphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : 'ABCDEFGHIKLMNOPQRSTUVWXYZ'},
      {'gridDimension' : 5, 'firstLetters': '', 'mode': PolybiosMode.AZ09, 'fillAlphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : 'ABCDEFGHIKLMNOPQRSTUVWXYZ'},

      {'gridDimension' : 5, 'firstLetters': 'XYZ', 'mode': PolybiosMode.AZ09, 'fillAlphabet': null, 'expectedOutput' : 'XYZABCDEFGHIKLMNOPQRSTUVW'},
      {'gridDimension' : 5, 'firstLetters': 'XYZ', 'mode': PolybiosMode.custom, 'fillAlphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : 'XYZABCDEFGHIKLMNOPQRSTUVW'},
      {'gridDimension' : 5, 'firstLetters': 'XYZ', 'mode': PolybiosMode.custom, 'fillAlphabet': 'QWERTZUIOPASDFGHKLYXCVBNM', 'expectedOutput' : 'XYZQWERTUIOPASDFGHKLCVBNM'},
      {'gridDimension' : 5, 'firstLetters': null, 'mode': PolybiosMode.custom, 'fillAlphabet': 'QWERTZUIOPASDFGHKLYXCVBNM', 'expectedOutput' : 'QWERTZUIOPASDFGHKLYXCVBNM'},
      {'gridDimension' : 6, 'firstLetters': 'XYZ', 'mode': PolybiosMode.AZ09, 'fillAlphabet': null, 'expectedOutput' : 'XYZABCDEFGHIJKLMNOPQRSTUVW0123456789'},
    ];

    _inputsToExpected.forEach((elem) {
      test(
          'gridDimension: ${elem['gridDimension']}, firstLetters: ${elem['firstLetters']}, mode: ${elem['mode']}, fillAlphabet: ${elem['fillAlphabet']}', () {
        String _actual = createPolybiosAlphabet(
            elem['gridDimension'],
            firstLetters: elem['firstLetters'],
            mode: elem['mode'],
            fillAlphabet: elem['fillAlphabet']
        );
        expect(_actual == null ? null : _actual, elem['expectedOutput']);
      });
    });
  });

  group("Polybios.encryptPolybios:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'key': null, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : null},
      {'input' : '', 'key': '', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : null},
      {'input' : 'ABC', 'key': '12345', 'mode': PolybiosMode.custom, 'alphabet': null, 'expectedOutput' : null},
      {'input' : 'ABC', 'key': '12345', 'mode': PolybiosMode.custom, 'alphabet': '', 'expectedOutput' : null},
      {'input' : 'ABC', 'key': '123456', 'mode': PolybiosMode.custom, 'alphabet': null, 'expectedOutput' : null},
      {'input' : 'ABC', 'key': '123456', 'mode': PolybiosMode.custom, 'alphabet': '', 'expectedOutput' : null},
      {'input' : 'AB CD.12 23 AB', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPA', 'expectedOutput' : null},
      {'input' : 'AB CD.12 23 AB', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'AAAAAAAAAAAAAAAAAAAAAAAAA', 'expectedOutput' : null},

      {'input' : 'HALLO', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '23 11 31 31 34'},
      {'input' : 'Hallo', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '23 11 31 31 34'},
      {'input' : 'Hallo123', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '23 11 31 31 34'},
      {'input' : 'jippie', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '24 24 35 35 24 15'},

      {'input' : 'HALLO', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '22 11 26 26 33'},
      {'input' : 'Hallo', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '22 11 26 26 33'},
      {'input' : 'Hallo123', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '22 11 26 26 33 54 55 56'},
      {'input' : 'Hallo123!', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '22 11 26 26 33 54 55 56'},
      {'input' : 'Jippie', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'expectedOutput' : '24 23 34 34 23 15'},

      {'input' : 'AB CD.12 23 AB', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'CA ED EB CC CA ED'},
      {'input' : 'JM', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'EA'},
      {'input' : 'AB CD.12 23 AB', 'key': 'ABCDJ', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'CA JD JB CC CA JD'},
      {'input' : 'AB CD.12 23 AB', 'key': 'Secr3', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'CS 3R 3E CC CS 3R'},
      {'input' : 'AB CD.12 23 AB', 'key': 'ABCDEF', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'BE DF DD CA ED EE EE EF BE DF'},
      {'input' : 'AB CD.12 23 AB', 'key': 'ABCDJF', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'BJ DF DD CA JD JJ JJ JF BJ DF'},
      {'input' : 'AB CD.12 23 AB', 'key': 'Secr3t', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'E3 RT RR CS 3R 33 33 3T E3 RT'},
      {'input' : 'AB CD.12 23 AB', 'key': 'Secret', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'EE RT RR CS ER EE EE ET EE RT'},
      {'input' : 'AB CD.12 23 AB', 'key': '11111', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : '11 11 11 11 11 11'},
      {'input' : 'AB CD.12 23 AB', 'key': '111111', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : '11 11 11 11 11 11 11 11 11 11'},

      {'input' : 'AB CD.12 23 AB', 'key': '12345', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM', 'expectedOutput' : '31 54 52 33 31 54'},
      {'input' : 'AB CD.12 23 AB', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'QWRTZUIOPASDFGHKLYXJCVBNM0123456789', 'expectedOutput' : 'BE EC EA CB BE EC'},
      {'input' : 'AB CD.12 23 AB', 'key': 'Secr3', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123;_()=.', 'expectedOutput' : 'CS 3R 3E CC CS 3R'},
      {'input' : 'AB CD.12 23 AB', 'key': 'ABCDE9', 'mode': PolybiosMode.custom, 'alphabet': 'QWRTZUIOPASDFGHKLYXJCVBNM0123456789.', 'expectedOutput' : 'BD DE DC B9 99 EC ED ED EE BD DE'},
      {'input' : 'AB CD.12 23 AB', 'key': 'Secr3t', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123;_()=.', 'expectedOutput' : 'E3 RT RR CS TT 3R 33 33 3T E3 RT'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}', () {
        PolybiosOutput _actual = encryptPolybios(elem['input'], elem['key'], mode: elem['mode'], alphabet: elem['alphabet']);
        expect(_actual == null ? null : _actual.output, elem['expectedOutput']);
      });
    });
  });

  group("Polybios.decryptPolybios:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'key': null, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : null},
      {'input' : '', 'key': '', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : null},
      {'input' : 'AB CD', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : null},
      {'input' : '12 34', 'key': '12345', 'mode': PolybiosMode.custom, 'alphabet': null, 'expectedOutput' : null},
      {'input' : '12 34', 'key': '12345', 'mode': PolybiosMode.custom, 'alphabet': '', 'expectedOutput' : null},
      {'input' : '12 34', 'key': '123456', 'mode': PolybiosMode.custom, 'alphabet': null, 'expectedOutput' : null},
      {'input' : '12 34', 'key': '123456', 'mode': PolybiosMode.custom, 'alphabet': '', 'expectedOutput' : null},
      {'input' : '12 34', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPA', 'expectedOutput' : null},
      {'input' : '12 34', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'AAAAAAAAAAAAAAAAAAAAAAAAA', 'expectedOutput' : null},

      {'expectedOutput' : 'HALLO', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'input' : '23 11 31 31 34'},
      {'expectedOutput' : 'HALLO', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'input' : '23 11 31 31 34 2'},
      {'expectedOutput' : 'IIPPIE', 'key': '12345', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'input' : '24 24 35 35 24 15'},

      {'expectedOutput' : 'HALLO', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'input' : '22 11 26 26 33'},
      {'expectedOutput' : 'HALLO123', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'input' : '22 11 26 26 33 54 55 56'},
      {'expectedOutput' : 'HALLO123', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'input' : '22 11 26 26 33 54 55 56 4'},
      {'expectedOutput' : 'JIPPIE', 'key': '123456', 'mode': PolybiosMode.AZ09, 'alphabet': null, 'input' : '24 23 34 34 23 15'},

      {'expectedOutput' : 'ABCDAB', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'CA ED EB CC CA ED'},
      {'expectedOutput' : 'J', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'EA'},
      {'expectedOutput' : 'ABCDAB', 'key': 'ABCDJ', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'CA JD JB CC CA JD'},
      {'expectedOutput' : 'ABCDAB', 'key': 'Secr3', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'CS 3R 3E CC CS 3R'},
      {'expectedOutput' : 'ABCD1223AB', 'key': 'ABCDEF', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'BE DF DD CA ED EE EE EF BE DF'},
      {'expectedOutput' : 'ABCD1223AB', 'key': 'ABCDJF', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'BJ DF DD CA JD JJ JJ JF BJ DF'},
      {'expectedOutput' : 'ABCD1223AB', 'key': 'Secr3t', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'E3 RT RR CS 3R 33 33 3T E3 RT'},
      {'expectedOutput' : 'IBCDPIISIB', 'key': 'Secret', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'EE RT RR CS ER EE EE ET EE RT'},
      {'expectedOutput' : 'QQQQQQ', 'key': '11111', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : '11 11 11 11 11 11'},
      {'expectedOutput' : 'QQQQQQQQQQ', 'key': '111111', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : '11 11 11 11 11 11 11 11 11 11'},

      {'expectedOutput' : 'ABCDAB', 'key': '12345', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM', 'input' : '31 54 52 33 31 54'},
      {'expectedOutput' : 'ABCDAB', 'key': 'ABCDE', 'mode': PolybiosMode.custom, 'alphabet': 'QWRTZUIOPASDFGHKLYXJCVBNM0123456789', 'input' : 'BE EC EA CB BE EC'},
      {'expectedOutput' : 'ABCDAB', 'key': 'Secr3', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123;_()=.', 'input' : 'CS 3R 3E CC CS 3R'},
      {'expectedOutput' : 'ABCD.1223AB', 'key': 'ABCDE9', 'mode': PolybiosMode.custom, 'alphabet': 'QWRTZUIOPASDFGHKLYXJCVBNM0123456789.', 'input' : 'BD DE DC B9 99 EC ED ED EE BD DE'},
      {'expectedOutput' : 'ABCD.1223AB', 'key': 'Secr3t', 'mode': PolybiosMode.custom, 'alphabet': 'QWERTZUIOPASDFGHKLYXJCVBNM0123;_()=.', 'input' : 'E3 RT RR CS TT 3R 33 33 3T E3 RT'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}', () {
        PolybiosOutput _actual = decryptPolybios(elem['input'], elem['key'], mode: elem['mode'], alphabet: elem['alphabet']);
        expect(_actual == null ? null : _actual.output, elem['expectedOutput']);
      });
    });
  });
}