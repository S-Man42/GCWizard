import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/amsco.dart';

void main() {
  group("Amsco.encodeAmsco:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input': null, 'key': '', 'errorcode': ErrorCode.OK, 'expectedOutput': ''},
      {'input': '', 'key': '', 'errorcode': ErrorCode.OK, 'expectedOutput': ''},
      {'input': null, 'key': null, 'errorcode': ErrorCode.OK, 'expectedOutput': ''},
      {'input': '', 'key': null, 'errorcode': ErrorCode.OK, 'expectedOutput': ''},

      {'input': 'Beispielklartext', 'key': '52413', 'errorcode': ErrorCode.OK, 'expectedOutput': 'iteilaelxsprBekt'},
      {'input': 'Beispielklartext', 'key': ' 52413 ', 'errorcode': ErrorCode.OK, 'expectedOutput': 'iteilaelxsprBekt'},
      {'input': 'Beispielklartext', 'key': '524137', 'errorcode': ErrorCode.Key, 'expectedOutput': ''},
      {'input': 'Beispielklartext', 'key': '52413A', 'errorcode': ErrorCode.Key, 'expectedOutput': ''},
      {'input': 'Beispielklartext', 'key': '5243', 'errorcode': ErrorCode.Key, 'expectedOutput': ''},
      {'input': 'Beispielklartext', 'key': '521431', 'errorcode': ErrorCode.Key, 'expectedOutput': ''},
      {'input': 'Beispielklartext', 'key': '524136', 'errorcode': ErrorCode.OK, 'expectedOutput': 'ixireltspteBelak'},
      {'input': 'Beispielklartext', 'key': '2413', 'errorcode': ErrorCode.OK, 'expectedOutput': 'splatBeelteirikx'},
      {'input': 'Beispielklartext und noch mehr Text', 'key': '524136', 'errorcode': ErrorCode.OK, 'expectedOutput': 'ixceir relt h xtspteno TBelandehkum'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encryptAmsco(elem['input'], elem['key']);
        expect(_actual.output, elem['expectedOutput']);
        expect(_actual.errorCode, elem['errorcode']);
      });
    });
  });


  group("Amsco.decodeAmsco:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input': null, 'key': '', 'errorcode': ErrorCode.OK, 'expectedOutput': ''},
      {'input': '', 'key': '', 'errorcode': ErrorCode.OK, 'expectedOutput': ''},
      {'input': null, 'key': null, 'errorcode': ErrorCode.OK, 'expectedOutput': ''},
      {'input': '', 'key': null, 'errorcode': ErrorCode.OK, 'expectedOutput': ''},

      {'input': 'iteilaelxsprBekt', 'key': '52413', 'errorcode': ErrorCode.OK, 'expectedOutput': 'Beispielklartext'},
      {'input': 'iteilaelxsprBekt', 'key': ' 52413 ', 'errorcode': ErrorCode.OK, 'expectedOutput': 'Beispielklartext'},
      {'input': 'Beispielklartext', 'key': '524137', 'errorcode': ErrorCode.Key, 'expectedOutput': ''},
      {'input': 'Beispielklartext', 'key': '52413A', 'errorcode': ErrorCode.Key, 'expectedOutput': ''},
      {'input': 'Beispielklartext', 'key': '5243', 'errorcode': ErrorCode.Key, 'expectedOutput': ''},
      {'input': 'Beispielklartext', 'key': '521431', 'errorcode': ErrorCode.Key, 'expectedOutput': ''},
      {'input': 'ixireltspteBelak', 'key': '524136', 'errorcode': ErrorCode.OK, 'expectedOutput': 'Beispielklartext'},
      {'input': 'splatBeelteirikx', 'key': '2413', 'errorcode': ErrorCode.OK, 'expectedOutput': 'Beispielklartext'},
      {'input': 'ixceir relt h xtspteno TBelandehkum', 'key': '524136', 'errorcode': ErrorCode.OK, 'expectedOutput': 'Beispielklartext und noch mehr Text'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decryptAmsco(elem['input'], elem['key']);
        expect(_actual.output, elem['expectedOutput']);
        expect(_actual.errorCode, elem['errorcode']);
      });
    });
  });
}
