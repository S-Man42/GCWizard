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
      {'input' : null, 'expectedOutput' : '', 'caseSensitive' : true},
      {'input' : '', 'expectedOutput' : '', 'caseSensitive' : true},
      {'input' : 'A', 'replaceCharacters': null, 'expectedOutput' : '', 'caseSensitive' : true},
      {'input' : 'A', 'replaceCharacters': <String>[], 'expectedOutput' : '', 'caseSensitive' : true},
      {'input' : 'A', 'replaceCharacters': ['m', 'p'], 'expectedOutput' : '', 'caseSensitive' : true},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'A', 'caseSensitive' : true},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f', 'a'], 'expectedOutput' : 'A', 'caseSensitive' : true},

      {'input' : 'm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'M', 'caseSensitive' : true},
      {'input' : 'mm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MM', 'caseSensitive' : true},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'A', 'caseSensitive' : true},
      {'input' : 'mmmp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AP', 'caseSensitive' : true},
      {'input' : 'mmmpp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'APP', 'caseSensitive' : true},
      {'input' : 'mmmppp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AN', 'caseSensitive' : true},
      {'input' : 'f', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'F', 'caseSensitive' : true},
      {'input' : 'ff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FF', 'caseSensitive' : true},
      {'input' : 'fff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FFF', 'caseSensitive' : true},
      {'input' : 'ma', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MA', 'caseSensitive' : true},
      {'input' : 'mam', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAM', 'caseSensitive' : true},
      {'input' : 'mamm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAMM', 'caseSensitive' : true},
      {'input' : 'mammm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAA', 'caseSensitive' : true},
      {'input' : 'm111mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'M111A', 'caseSensitive' : true},

      {'input' : 'mmmmmpmmfffp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'ABCZ', 'caseSensitive' : true},
      {'input' : 'mamamamamapbdmamaf1f1f1pbd', 'replaceCharacters': ['ma', 'pbd', 'f1'], 'expectedOutput' : 'ABCZ', 'caseSensitive' : true},
      {'input' : 'pppmppmffppp pppppfmmfmfp pppmffmmfmfpfmp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'NEIN NOCH NICHT', 'caseSensitive' : true},
      {'input' : 'pspspsmfgpspsmfgfd1fd1pspsps pspspspspsfd1mfgmfgfd1mfgfd1ps pspspsmfgfd1fd1mfgmfgfd1mfgfd1psfd1mfgps', 'replaceCharacters': ['mfg', 'ps', 'fd1'], 'expectedOutput' : 'NEIN NOCH NICHT', 'caseSensitive' : true},
      {'input' : 'pmpmppppppppffm mmfppfmpmmpp mmmfmfmmfmfp fmmmmfmfpppfppp mpmpffmffppp?', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'KENNY CODE AUCH SCHON DRIN?', 'caseSensitive' : true},
      {'input' : 'mmmas', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AAS', 'caseSensitive' : true},
      {'input' : 'mmmmas', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AMAS', 'caseSensitive' : true},

      {'input' : 'mpfapff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FAR', 'caseSensitive' : true},
      {'input' : 'Mfmfmffmp mfmmppppmmmmmmfmfpfmp!', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MUIMP GEMACHT!', 'caseSensitive' : true},

      {'input' : null, 'expectedOutput' : '', 'caseSensitive' : false},
      {'input' : '', 'expectedOutput' : '', 'caseSensitive' : false},
      {'input' : 'A', 'replaceCharacters': null, 'expectedOutput' : '', 'caseSensitive' : false},
      {'input' : 'A', 'replaceCharacters': <String>[], 'expectedOutput' : '', 'caseSensitive' : false},
      {'input' : 'A', 'replaceCharacters': ['m', 'p'], 'expectedOutput' : '', 'caseSensitive' : false},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'A', 'caseSensitive' : false},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f', 'a'], 'expectedOutput' : 'A', 'caseSensitive' : false},

      {'input' : 'm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'M', 'caseSensitive' : false},
      {'input' : 'mm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MM', 'caseSensitive' : false},
      {'input' : 'mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'A', 'caseSensitive' : false},
      {'input' : 'mmmp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AP', 'caseSensitive' : false},
      {'input' : 'mmmpp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'APP', 'caseSensitive' : false},
      {'input' : 'mmmppp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AN', 'caseSensitive' : false},
      {'input' : 'f', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'F', 'caseSensitive' : false},
      {'input' : 'ff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FF', 'caseSensitive' : false},
      {'input' : 'fff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FFF', 'caseSensitive' : false},
      {'input' : 'ma', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MA', 'caseSensitive' : false},
      {'input' : 'mam', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAM', 'caseSensitive' : false},
      {'input' : 'mamm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAMM', 'caseSensitive' : false},

      {'input' : 'mammm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'MAA', 'caseSensitive' : false},
      {'input' : 'm111mmm', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'M111A', 'caseSensitive' : false},

      {'input' : 'mmmmmpmmfffp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'ABCZ', 'caseSensitive' : false},
      {'input' : 'mamamamamapbdmamaf1f1f1pbd', 'replaceCharacters': ['ma', 'pbd', 'f1'], 'expectedOutput' : 'ABCZ', 'caseSensitive' : false},
      {'input' : 'pppmppmffppp pppppfmmfmfp pppmffmmfmfpfmp', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'NEIN NOCH NICHT', 'caseSensitive' : false},
      {'input' : 'pspspsmfgpspsmfgfd1fd1pspsps pspspspspsfd1mfgmfgfd1mfgfd1ps pspspsmfgfd1fd1mfgmfgfd1mfgfd1psfd1mfgps', 'replaceCharacters': ['mfg', 'ps', 'fd1'], 'expectedOutput' : 'NEIN NOCH NICHT', 'caseSensitive' : false},
      {'input' : 'pmpmppppppppffm mmfppfmpmmpp mmmfmfmmfmfp fmmmmfmfpppfppp mpmpffmffppp?', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'KENNY CODE AUCH SCHON DRIN?', 'caseSensitive' : false},
      {'input' : 'mmmas', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AAS', 'caseSensitive' : false},
      {'input' : 'mmmmas', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'AMAS', 'caseSensitive' : false},

      {'input' : 'mpfapff', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'FAR', 'caseSensitive' : false},

      {'input' : 'Mfmfmffmp mfmmppppmmmmmmfmfpfmp!', 'replaceCharacters': ['m', 'p', 'f'], 'expectedOutput' : 'GUT GEMACHT!', 'caseSensitive' : false},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decryptKenny(elem['input'], elem['replaceCharacters'], elem['caseSensitive']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}