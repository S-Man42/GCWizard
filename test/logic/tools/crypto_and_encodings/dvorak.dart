import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/dvorak.dart';

void main() {
  String inputString = '1234567890abcdefghijklmnopqrstuvwxyz!"§'+'\$'+'%&/()=?^´°`*+'+"'"+'#;,:._-';

  group("Dvorak.encode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'from' : DvorakMode.DVORAK, 'to' : DvorakMode.QWERTZ_T1, 'expectedOutput' : null},
      {'input' : '', 'from' : DvorakMode.DVORAK, 'to' : DvorakMode.QWERTZ_T1, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : DvorakMode.QWERTZ_T1, 'to' : DvorakMode.QWERTZ_T1, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : DvorakMode.QWERTZ_T1, 'to' : DvorakMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.QWERTZ_T1, 'to' : DvorakMode.DVORAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.QWERTZ_T1, 'to' : DvorakMode.DVORAK_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.QWERTY_US_INT, 'to' : DvorakMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.QWERTY_US_INT, 'to' : DvorakMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.QWERTY_US_INT, 'to' : DvorakMode.DVORAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.QWERTY_US_INT, 'to' : DvorakMode.DVORAK_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.DVORAK, 'to' : DvorakMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.DVORAK, 'to' : DvorakMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.DVORAK, 'to' : DvorakMode.DVORAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.DVORAK, 'to' : DvorakMode.DVORAK_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.DVORAK_II_DEU, 'to' : DvorakMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.DVORAK_II_DEU, 'to' : DvorakMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.DVORAK_II_DEU, 'to' : DvorakMode.DVORAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : DvorakMode.DVORAK_II_DEU, 'to' : DvorakMode.DVORAK_II_DEU, 'expectedOutput' : ''},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeDvorak(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}