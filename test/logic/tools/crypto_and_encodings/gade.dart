import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gade.dart';

void main() {
  group("Gade.buildGade:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' :'', 'expectedOutput' : {'A':'0', 'B':'1', 'C':'2', 'D':'3', 'E':'4', 'F':'5', 'G':'6', 'H':'7', 'I':'8', 'J':'9'}},
      {'input' :'1', 'expectedOutput' : {'A':'1', 'B':'0', 'C':'2', 'D':'3', 'E':'4', 'F':'5', 'G':'6', 'H':'7', 'I':'8', 'J':'9'}},
      {'input' :'22.04.1968 01.07.1987 11.02.1994', 'expectedOutput' : {'A':'0', 'B':'0', 'C':'0', 'D':'0', 'E':'1', 'F':'1', 'G':'1', 'H':'1', 'I':'1', 'J':'1', 'K':'2', 'L':'2', 'M':'2', 'N':'4', 'O':'4', 'P':'6', 'Q':'7', 'R':'7', 'S':'8', 'T':'8', 'U':'9', 'V':'9', 'W':'9', 'X':'9', 'Y':'3', 'Z':'5'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = buildGade(elem['input'], null);
        expect(_actual.item1, elem['expectedOutput']);
      });
    });
  });

  group("Gade.buildGadeNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' :'d', 'expectedOutput' : {'A':'0', 'B':'1', 'C':'2', 'D':'3', 'E':'4', 'F':'5', 'G':'6', 'H':'7', 'I':'8', 'J':'9'}},
      {'input' :'d 4wt zwer46 89 3', 'expectedOutput' : {'A':'3', 'B':'4', 'C':'4', 'D':'6', 'E':'8', 'F':'9', 'G':'0', 'H':'1', 'I':'2', 'J':'5', 'K':'7'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = buildGade(elem['input'], null, onlyNumber: true);
        expect(_actual.item1, elem['expectedOutput']);
      });
    });
  });

  group("Gade.buildGadeInput:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' :'Roentgen', 'input1' :'N 51 CD.FFA, E 011 KA.IJC',
        'expectedOutput' : {'A':'0', 'B':'1', 'C':'1', 'D':'1', 'E':'1', 'F':'2', 'G':'4', 'H':'4', 'I':'5', 'J':'5', 'K':'5', 'L':'7', 'M':'8', 'N':'3', 'O':'6', 'P':'9'},
        'expectedOutput2' :'3 51 11.220, 1 011 50.551'},
      {'input' :'18721888190517', 'input1' :'N PK° OC.ONQ\' E N° AF.FIL\'',
        'expectedOutput' : {'A':'0', 'B':'1', 'C':'1', 'D':'1', 'E':'1', 'F':'2', 'G':'5', 'H':'7', 'I':'7', 'J':'8', 'K':'8', 'L':'8', 'M':'8', 'N':'9', 'O':'3', 'P':'4', 'Q':'6'},
        'expectedOutput2' :'9 48° 31.396\' 1 9° 02.278\''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = buildGade(elem['input'], elem['input1']);
        expect(_actual.item1, elem['expectedOutput']);
        expect(_actual.item2, elem['expectedOutput2']);
      });
    });
  });
}