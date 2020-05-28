import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/kenny.dart';

void main() {
  group("KennysCode.encryptKenny:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : 'A', 'replaceCharacters': null, 'expectedOutput' : ''},
      {'input' : 'A', 'replaceCharacters': <String>[], 'expectedOutput' : ''},
      {'input' : 'A', 'replaceCharacters': ['m', 'p'], 'expectedOutput' : ''},
      {'input' : 'A', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'mmm'},
      {'input' : 'A', 'replaceCharacters': ['m', 'p', 'f', 'a'], 'expectedOutput' : 'mmm'},

      {'input' : 'AbcZ', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'mmmmmpmmfffp'},
      {'input' : 'AbcZ', 'replaceCharacters': ['ma', 'pbd', 'f1'], 'expectedOutput' : 'mamamamamapbdmamaf1f1f1pbd'},
      {'input' : 'Nein noch nicht', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'pppmppmffppp pppppfmmfmfp pppmffmmfmfpfmp'},
      {'input' : 'Nein noch nicht', 'replaceCharacters': ['mfg', 'ps', 'fd1'], 'expectedOutput' : 'pspspsmfgpspsmfgfd1fd1pspsps pspspspspsfd1mfgmfgfd1mfgfd1ps pspspsmfgfd1fd1mfgmfgfd1mfgfd1psfd1mfgps'},

      {'input' : '1', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : '1'},
      {'input' : 'A1', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'mmm1'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encryptKenny(elem['input'], elem['replaceCharacters']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("KennysCode.decryptKenny:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : 'A', 'replaceCharacters': null, 'expectedOutput' : ''},
      {'input' : 'A', 'replaceCharacters': <String>[], 'expectedOutput' : ''},
      {'input' : 'A', 'replaceCharacters': ['m', 'p'], 'expectedOutput' : ''},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'A'},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f', 'a'], 'expectedOutput' : 'A'},

      {'input' : 'm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'M'},
      {'input' : 'mm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MM'},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'A'},
      {'input' : 'mmmp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AP'},
      {'input' : 'mmmpp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'APP'},
      {'input' : 'mmmppp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AN'},
      {'input' : 'f', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'F'},
      {'input' : 'ff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FF'},
      {'input' : 'fff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FFF'},
      {'input' : 'ma', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MA'},
      {'input' : 'mam', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAM'},
      {'input' : 'mamm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAMM'},
      {'input' : 'mammm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAA'},
      {'input' : 'm111mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'M111A'},

      {'input' : 'mmmmmpmmfffp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'ABCZ'},
      {'input' : 'mamamamamapbdmamaf1f1f1pbd', 'replaceCharacters': ['ma', 'pbd', 'f1'], 'expectedOutput' : 'ABCZ'},
      {'input' : 'pppmppmffppp pppppfmmfmfp pppmffmmfmfpfmp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'NEIN NOCH NICHT'},
      {'input' : 'pspspsmfgpspsmfgfd1fd1pspsps pspspspspsfd1mfgmfgfd1mfgfd1ps pspspsmfgfd1fd1mfgmfgfd1mfgfd1psfd1mfgps', 'replaceCharacters': ['mfg', 'ps', 'fd1'], 'expectedOutput' : 'NEIN NOCH NICHT'},
      {'input' : 'pmpmppppppppffm mmfppfmpmmpp mmmfmfmmfmfp fmmmmfmfpppfppp mpmpffmffppp?', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'KENNY CODE AUCH SCHON DRIN?'},
      {'input' : 'mmmas', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AAS'},
      {'input' : 'mmmmas', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AMAS'},

      {'input' : 'mpfapff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FAR'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decryptKenny(elem['input'], elem['replaceCharacters']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}