import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/ragbaby/logic/ragbaby.dart';

void main() {
  group("Ragbaby.encryptRagbaby:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'pw': '', 'expectedOutput' : ''},

      {'input' : 'The quick brown fox jumps.', 'pw': 'its a secret', 'expectedOutput' : 'SLB VYEGQ GGWAY LWT CTWTH.'},
      {'input' : 'BEI GRABTHARS HAMMER', 'pw': '', 'expectedOutput' : 'CGM IUEGAPIBD LERSMA'},
      {'input' : 'du wirst gerächt werden.', 'pw': 'fedcba', 'expectedOutput' : 'CW ZMVYF KAWÄLQC EGYKKW.'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encryptRagbaby(elem['input'] as String, elem['pw'] as String);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Ragbaby.decryptRagbaby:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'expectedOutput' : '', 'pw': '', 'input' : ''},

       {'expectedOutput' : 'THE QUICK BROWN FOU IUMPS.', 'pw': 'its a secret', 'input' :'SLB VYEGQ GGWAY LWT CTWTH.'},
       {'expectedOutput' : 'BEI GRABTHARS HAMMER', 'pw': '', 'input' :'CGM IUEGAPIBD LERSMA'},
       {'expectedOutput' : 'DU WIRST GERÄCHT WERDEN.', 'pw': 'fedcba', 'input' : 'CW ZMVYF KAWÄLQC EGYKKW.'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decryptRagbaby(elem['input'] as String, elem['pw'] as String);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}


