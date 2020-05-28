import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/tap_code.dart';

void main() {
  group("TapCode.encryptTapCode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCIJK', 'mode': TapCodeMode.JToI, 'expectedOutput' : '11 12 13 24 24 25'},
      {'input' : 'ABCIJK', 'mode': TapCodeMode.CToK, 'expectedOutput' : '11 12 13 24 25 13'},

      {'input' : 'ABC123%&ijk', 'mode': TapCodeMode.CToK, 'expectedOutput' : '11 12 13 24 25 13'},
     ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, mode: ${elem['mode']}', () {
        var _actual = encryptTapCode(elem['input'], mode: elem['mode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("TapCode.decryptTapCode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : 'ABCIK', 'mode': TapCodeMode.JToI, 'input' : '11 12 13 24 25'},
      {'expectedOutput' : 'ABKIJ', 'mode': TapCodeMode.CToK, 'input' : '11 12 13 24 25'},

      {'input' : '111 213', 'mode': TapCodeMode.CToK, 'expectedOutput' : 'ABK'},
      {'input' : '111', 'mode': TapCodeMode.CToK, 'expectedOutput' : 'A'},
      {'input' : '45 67', 'mode': TapCodeMode.CToK, 'expectedOutput' : 'U'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, mode: ${elem['mode']}', () {
        var _actual = decryptTapCode(elem['input'], mode: elem['mode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}