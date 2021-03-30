import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/straddling_checkerboard.dart';
import 'package:gc_wizard/utils/constants.dart';

void main() {

  group("encrypt", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      // empty Input
      {'input' : null, 'key': null, 'alphabetWord' : '', 'columnOrder' : '', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : ''},
      {'input' : '', 'key': '', 'alphabetWord' : '', 'columnOrder' : '', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': 'ABCDEFGHIKLMNOPQRSTUVWXYZ', 'expectedOutput' : ''},

      {'input' : 'cache bei n 52 345 678 o 13 09 451', 'key': 'gc wizard ', 'alphabetWord' : '', 'columnOrder' : '0246813579', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'expectedOutput' : '2324642974042897479799599297993994995979969979989749979919939799099997994995991'},
      {'input' : 'cache bei n 52 345 678 o 13 09 451', 'key': 'g c wizad ', 'alphabetWord' : '', 'columnOrder' : '0246813579', 'matrix4x10' : true, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'expectedOutput' : '4542622992022199279998929994969899919395992999909499699799969890'},

      // https://kryptografie.de/kryptografie/chiffre/straddling-checkerboard.htm
      {'input' : 'no attack', 'key': 'SIOERATN  ', 'alphabetWord' : 'CXUDJPZBKQ', 'columnOrder' : '0123456789', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '.WFL/GMYHV', 'expectedOutput' : '729056658088'},
      {'input' : 'Beispielklartext', 'key': 'MDELVAYO  ', 'alphabetWord' : '', 'columnOrder' : '0987654321', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'expectedOutput' : '20825182125872375191781417'},
      {'input' : 'Beispielklartext', 'key': 'RTWXYZ ./ ', 'alphabetWord' : 'pausomvejk', 'columnOrder' : '6087549123', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'expectedOutput' : '3691399796399131933190609170'},
      {'input' : 'Treffen morgen Zwanzig Uhr an Treffpunkt drei', 'key': 'D  EINSTAR', 'alphabetWord' : '', 'columnOrder' : '0123456789', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'expectedOutput' : '7931212352818199133528272485274132822149288528793121220225167280934'},
      {'input' : 'Treffen morgen Zwanzig Uhr an Treffpunkt drei', 'key': 'DEI NS TAR', 'alphabetWord' : '', 'columnOrder' : '8529406137', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'expectedOutput' : '1759292546393977995463616434612996362947633463175929268624961638752'},
      {'input' : 'Treffen morgen 2000 Uhr an Treffpunkt 3', 'key': 'D   EINSTA', 'alphabetWord' : 'R', 'columnOrder' : '0123456789', 'matrix4x10' : true, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'expectedOutput' : '810413134639192010144639312929293923151039963981041313212361783932'},

      // https://en.wikipedia.org/wiki/Straddling_checkerboard
      {'input' : 'ATTACK AT DAWN', 'key': 'ET AON RIS', 'alphabetWord' : '', 'columnOrder' : '0123456789', 'matrix4x10' : false, 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BCDFGHJKLMPQ/UVWXYZ.', 'expectedOutput' : '31132127693169223655'},

      //{'input' : '', 'key': '', 'alphabetWord' : '', 'columnOrder' : '0123456789', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, alphabetWord: ${elem['alphabetWord']}, columnOrder: ${elem['columnOrder']}, matrix4x10: ${elem['matrix4x10']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}', () {
        StraddlingCheckerboardOutput _actual = encryptStraddlingCheckerboard(elem['input'], elem['key'], elem['alphabetWord'], elem['columnOrder'], elem['matrix4x10'], mode: elem['mode'], alphabet: elem['alphabet']);
        expect(_actual.output, elem['expectedOutput']);
      });
    });
  });

  group("decrypt", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'expectedOutput' : 'CACHE BEI N 52 345 678 O 13 09 451', 'key': 'gc wizard ', 'alphabetWord' : '', 'columnOrder' : '0246813579', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'input' : '2324642974042897479799599297993994995979969979989749979919939799099997994995991'},
      {'expectedOutput' : 'CACHE BEI N 52 345 678 O 13 09 451', 'key': 'g c wizad ', 'alphabetWord' : '', 'columnOrder' : '0246813579', 'matrix4x10' : true, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'input' : '4542622992022199279998929994969899919395992999909499699799969890'},

      // https://kryptografie.de/kryptografie/chiffre/straddling-checkerboard.htm
      {'expectedOutput' : 'NO ATTACK', 'key': 'SIOERATN  ', 'alphabetWord' : 'CXUDJPZBKQ', 'columnOrder' : '0123456789', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '.WFL/GMYHV', 'input' : '729056658088'},
      {'expectedOutput' : 'BEISPIELKLARTEXT', 'key': 'MDELVAYO  ', 'alphabetWord' : '', 'columnOrder' : '0987654321', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'input' : '20825182125872375191781417'},
      {'expectedOutput' : 'BEISPIELKLARTEXT', 'key': 'RTWXYZ ./ ', 'alphabetWord' : 'pausomvejk', 'columnOrder' : '6087549123', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'input' : '3691399796399131933190609170'},
      {'expectedOutput' : 'TREFFEN MORGEN ZWANZIG UHR AN TREFFPUNKT DREI', 'key': 'D  EINSTAR', 'alphabetWord' : '', 'columnOrder' : '0123456789', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'input' : '7931212352818199133528272485274132822149288528793121220225167280934'},
      {'expectedOutput' : 'TREFFEN MORGEN ZWANZIG UHR AN TREFFPUNKT DREI', 'key': 'DEI NS TAR', 'alphabetWord' : '', 'columnOrder' : '8529406137', 'matrix4x10' : false, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'input' : '1759292546393977995463616434612996362947633463175929268624961638752'},
      {'expectedOutput' : 'TREFFEN MORGEN 2000 UHR AN TREFFPUNKT 3', 'key': 'D   EINSTA', 'alphabetWord' : 'R', 'columnOrder' : '0123456789', 'matrix4x10' : true, 'mode': PolybiosMode.AZ09, 'alphabet': '', 'input' : '810413134639192010144639312929293923151039963981041313212361783932'},

      // https://en.wikipedia.org/wiki/Straddling_checkerboard
      {'expectedOutput' : 'ATTACK AT DAWN', 'key': 'ET AON RIS', 'alphabetWord' : '', 'columnOrder' : '0123456789', 'matrix4x10' : false, 'mode': PolybiosMode.CUSTOM, 'alphabet': 'BCDFGHJKLMPQ/UVWXYZ.', 'input' : '31132127693169223655'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, alphabetWord: ${elem['alphabetWord']}, columnOrder: ${elem['columnOrder']}, matrix4x10: ${elem['matrix4x10']}, mode: ${elem['mode']}, alphabet: ${elem['alphabet']}', () {
        StraddlingCheckerboardOutput _actual = decryptStraddlingCheckerboard(elem['input'], elem['key'], elem['alphabetWord'], elem['columnOrder'], elem['matrix4x10'], mode: elem['mode'], alphabet: elem['alphabet']);
        expect(_actual.output, elem['expectedOutput']);
      });
    });
  });
}