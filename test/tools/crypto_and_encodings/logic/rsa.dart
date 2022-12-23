import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/logic/rsa.dart';

void main() {
  group("RSA.encryptRSA:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'e': null, 'p': null, 'q': null, 'expectedOutput' : ''},
      {'input' : '', 'e': null, 'p': null, 'q': null, 'expectedOutput' : ''},
      {'input' : 'A', 'e': null, 'p': null, 'q': null, 'expectedOutput' : ''},
      {'input' : '', 'e': BigInt.from(1721), 'p': BigInt.from(307), 'q': BigInt.from(859), 'expectedOutput' : ''},
      {'input' : null, 'e': BigInt.from(1721), 'p': BigInt.from(307), 'q': BigInt.from(859), 'expectedOutput' : ''},

      {'input' : 'WIKIPEDIA IST 42!', 'e': BigInt.from(1721), 'p': BigInt.from(307), 'q': BigInt.from(859), 'expectedOutput' : '35225 253912 163314 253912 251016 133372 139634 253912 114917 191731 253912 218980 211928 191731 33825 241474 192628'},
      {'input' : '1921', 'e': BigInt.from(17), 'p': BigInt.from(71), 'q': BigInt.from(83), 'expectedOutput' : '1172'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, e: ${elem['e']}p${elem['p']}, q: ${elem['q']},', () {
        var _actual = encryptRSA(elem['input'], elem['e'], elem['p'], elem['q']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("RSA.decryptRSA:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'd': null, 'p': null, 'q': null, 'expectedOutput' : ''},
      {'input' : '', 'd': null, 'p': null, 'q': null, 'expectedOutput' : ''},
      {'input' : 'A', 'd': null, 'p': null, 'q': null, 'expectedOutput' : ''},
      {'input' : '', 'd': BigInt.from(1373), 'p': BigInt.from(307), 'q': BigInt.from(859), 'expectedOutput' : ''},
      {'input' : null, 'd': BigInt.from(1373), 'p': BigInt.from(307), 'q': BigInt.from(859), 'expectedOutput' : ''},

      {'expectedOutput' : 'WIKIPEDIA IST 42!', 'd': BigInt.from(1373), 'p': BigInt.from(307), 'q': BigInt.from(859), 'input' : '35225 253912 163314 253912 251016 133372 139634 253912 114917 191731 253912 218980 211928 191731 33825 241474 192628'},
      {'input' : '1172', 'd': BigInt.from(1013), 'p': BigInt.from(71), 'q': BigInt.from(83), 'expectedOutput' : '1921'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, d: ${elem['e']}p${elem['p']}, q: ${elem['q']},', () {
        var _actual = decryptRSA(elem['input'], elem['d'], elem['p'], elem['q']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("RSA.calculateD:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'e': null, 'p': null, 'q': null, 'expectedOutput' : null},
      {'e': BigInt.from(1721), 'p': BigInt.from(307), 'q': BigInt.from(859), 'expectedOutput' : BigInt.from(1373)},
      {'e': BigInt.from(17), 'p': BigInt.from(71), 'q': BigInt.from(83), 'expectedOutput' : BigInt.from(1013)},
    ];

    _inputsToExpected.forEach((elem) {
      test('e: ${elem['e']}p${elem['p']}, q: ${elem['q']},', () {
        var _actual = calculateD(elem['e'], elem['p'], elem['q']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}