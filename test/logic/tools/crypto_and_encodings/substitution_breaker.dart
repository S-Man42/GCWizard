import 'dart:io';
import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/key.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/generate_quadgrams.dart';
import 'package:path/path.dart' as path;
import 'dart:async';

void main() {
  group("substitution_breaker.check_alphabet:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '', 'expectedOutput' : null},

      {'input' : 'ABc', 'expectedOutput' : 'abc'},
      {'input' : 'aba', 'expectedOutput' : null},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = Key.check_alphabet(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("substitution_breaker.check_key:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'alphabet' : '', 'expectedOutput' : null},
      {'input' : '', 'alphabet' : '', 'expectedOutput' : null},

      {'input' : 'AbC', 'alphabet' : 'abc', 'expectedOutput' : 'abc'},
      {'input' : 'abca', 'alphabet' : 'abcd', 'expectedOutput' : null},
      {'input' : 'ab', 'alphabet' : 'abc', 'expectedOutput' : null},
      {'input' : 'abcd', 'alphabet' : 'abc', 'expectedOutput' : null},
      {'input' : 'abcd', 'alphabet' : 'abc', 'expectedOutput' : null},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = Key.check_key(elem['input'], elem['alphabet']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("substitution_breaker.decode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      //{'input' : null, 'expectedOutput' : ''},
      //{'input' : '', 'expectedOutput' : ''},

      {'input' : 'Hallo 23', 'expectedOutput' : 'Hallo 23'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var key = Key('abcdefghijklmnopqrstuvwxyz');
        var _actual = key.decode(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("substitution_breaker.encode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      //{'input' : null, 'expectedOutput' : ''},
      //{'input' : '', 'expectedOutput' : ''},

      {'input' : 'Hallo 23', 'expectedOutput' : 'Hallo 23'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var key = Key('abcdefghijklmnopqrstuvwxyz');
        var _actual = key.encode(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });


  var cipherTet ="Rbo rpktigo vcrb bwucja wj kloj hcjd, km sktpqo, cq rbwr loklgo "
                "vcgg cjqcqr kj skhcja wgkja wjd rpycja rk ltr rbcjaq cj cr."
                "-- Roppy Lpwrsborr";
  var text1 = "The museum will be a lasting physical testament to his hard work and "
          "vision, and will house the prestigious collection he cared so deeply about, "
          "for many years to come.";
  var text2 = "Heute ist jeder Autohersteller in der Lage starke Motoren zu bauen, doch "
          "alles hat seine Grenzen, sonst waeren ja alle anderen die sich ans Gesetz "
          "halten die Dummen.";
      var text3 = "Agl qrxlrq okii bl t itxakhj ugexknti alxatqlha ad gkx gtsm odsy thm "
          "pkxkdh, thm okii gdrxl agl uslxakjkdrx ndiilnakdh gl ntslm xd mlluie tbdra, "
          "vds qthe eltsx ad ndql.";


  group("substitution_breaker.generate_quadgrams:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      //{'input' : null, 'expectedOutput' : ''},
      //{'input' : '', 'expectedOutput' : ''},

      {'input' : 'Hallo 23', 'expectedOutput' : 'Hallo 23'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var filePath = path.current + "/lib/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/";
        var fileIn = File(path.normalize(filePath +'quadgram_corpus.txt'));
        var fileOut= File(path.normalize(filePath + 'xxx.txt'));

        var _actual = generate_quadgrams(fileIn, fileOut);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
