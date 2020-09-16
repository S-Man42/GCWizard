import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chao.dart';

void main() {

  group("Chao.encryptChao:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'keyPlain' : 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'keyChiffre': 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'expectedOutput' : ''},
      {'input' : 'Hallo', 'keyPlain' : 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'keyChiffre': 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'expectedOutput' : 'EFWWD'},
      {'input' : 'OAHQHCNYNXTSZJRRHJBYHQKSOUJY', 'keyPlain' : 'PTLNBQDEOYSFAVZKGJRIHWXUMC', 'keyChiffre': 'HXUCZVAMDSLKPEFJRIGTWOBNYQ', 'expectedOutput' : 'OAHQHCNYNXTSZJRRHJBYHQKSOUJY'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, keyPlain: ${elem['keyPlain']}, keyChiffre: ${elem['keyChiffre']}', () {
        var _actual = encryptChao(elem['input'], elem['keyPlain'], elem['keyChiffre']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Chao.decryptChao:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'keyPlain' : 1, 'keyB': 0, 'expectedOutput' : ''},
      {'input' : 'efWwd', 'keyPlain' : 11, 'keyB': 5, 'expectedOutput' : 'HALLO'},
      {'input' : 'XMGGAN YOGGV', 'keyPlain' : 17, 'keyB': 10, 'expectedOutput' : 'NUMMER KOMMT'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, keyPlain: ${elem['keyPlain']}, keyChiffre: ${elem['keyChiffre']}', () {
        var _actual = decryptChao(elem['input'], elem['keyPlain'], elem['keyChiffre']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}