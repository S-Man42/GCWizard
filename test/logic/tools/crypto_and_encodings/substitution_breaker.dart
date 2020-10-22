import 'dart:io';
import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/key.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/generate_quadgrams.dart';
import 'package:path/path.dart' as path;

void main() {


  /// Link for corpus files (for other languages)
  /// https://guballa.gitlab.io/SubstitutionBreaker/cli_explained.html#adding-more-languages
  /// https://wortschatz.uni-leipzig.de/de/download/german#deu_newscrawl-public_2018
  group("substitution_breaker.generate_quadgrams:", () {
    List<Map<String, dynamic>> _inputsToExpected = [

      // Attention: a file is done during execution

      /// generate test-quadgram- file ( Source file from https://gitlab.com/guballa/SubstitutionBreaker/-/blob/development/tests/fixturefiles/quadgram_corpus.txt)
      //{'input' : 'quadgram_corpus.txt', 'fileOut' : 'quadgram_test.dart', 'className' : 'english_quadgrams', 'alphabet' : DEFAULT_ALPHABET, 'errorCode' : ErrorCode.OK, 'expectedOutput' : ''},
      /// generate German quadgram file (Source file from https://pcai056.informatik.uni-leipzig.de/downloads/corpora/deu_news_2015_1M.tar.gz -> deu_news_2015_1M-sentences.txt.txt)
      //{'input' : 'de_corpus.txt', 'fileOut' : 'de_quadgrams.dart', 'className' : 'german_quadgrams', 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : ErrorCode.OK, 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var filePath = path.current + "/lib/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/";
        var fileIn = File(path.normalize(filePath + elem['input']));
        var fileOut= File(path.normalize(filePath + elem['fileOut']));

        var _actual = await generate_quadgrams(fileIn, fileOut, elem['className'], elem['alphabet']);
        expect(_actual.errorCode, elem['errorCode']);
      });
    });
  });


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

  group("substitution_breaker.compressQuadgrams:", () {
    final List<int> quadgrams = [0,0,0,747,0,0,0,0,0,0,11,12,13,0,0,0,17];

    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : quadgrams, 'errorCode' : ErrorCode.OK, 'expectedOutput' : '{3:[747],10:[11,12,13],16:[17]}'},
      //{'input' : en, 'errorCode' : ErrorCode.OK, 'expectedOutput' : '{3:[747],10:[11,12,13],16:[17]}'},
    ];
    //var en = EnglishQuadgrams().quadgrams;
    //var _actual = Quadgrams.quadgramsMapToString(Quadgrams.compressQuadgrams(en));

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = Quadgrams.quadgramsMapToString(Quadgrams.compressQuadgrams(elem['input']));
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("substitution_breaker.decompressQuadgrams:", () {
    final List<int> quadgrams = [0,0,0,747,0,0,0,0,0,0,11,12,13,0,0,0,17];
    final Map<int, List<int>> quadgramsCpmpressed = {3:[747],10:[11,12,13],16:[17]};

    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : quadgramsCpmpressed, 'size' : 17, 'errorCode' : ErrorCode.OK, 'expectedOutput' : quadgrams},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = Quadgrams.decompressQuadgrams(elem['input'], elem['size']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });




  var cipherText ="Rbo rpktigo vcrb bwucja wj kloj hcjd, km sktpqo, cq rbwr loklgo "
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

  var text10 = '''Rbo rpktigo vcrb bwucja wj kloj hcjd, km sktpqo, cq rbwr loklgo 
  vcgg cjqcqr kj skhcja wgkja wjd rpycja rk ltr rbcjaq cj cr.
  -- Roppy Lpwrsborr''';

  var text11 = '''The trouble with having an open mind, of course, is that people 
  will insist on coming along and trying to put things in it.
  -- Terry Pratchett''';

  group("substitution_breaker.breaker:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'alphabet' : BreakerAlphabet.English, 'errorCode' : ErrorCode.OK, 'expectedOutput' : ''},
      {'input' : '', 'alphabet' : BreakerAlphabet.English, 'errorCode' : ErrorCode.OK, 'expectedOutput' : ''},

      {'input' : text10, 'alphabet' : BreakerAlphabet.English, 'errorCode' : ErrorCode.OK, 'expectedOutput' : text11},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {

        var _actual = break_cipher(elem['input'], elem['alphabet']);
        expect(_actual.plaintext, elem['expectedOutput']);
        expect(_actual.errorCode, elem['errorCode']);
      });
    });
  });
}
