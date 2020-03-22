import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto/lemon.dart';

void main() {
  group("Lemon.encrypt:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'counterClockWise': null, 'expectedOutput' : ''},
      {'input' : '', 'counterClockWise': null, 'expectedOutput' : ''},
      {'input' : null, 'counterClockWise': false, 'expectedOutput' : ''},
      {'input' : '', 'counterClockWise': false, 'expectedOutput' : ''},
  
      {'input' : 'X', 'counterClockWise': false, 'expectedOutput' : 'X'},
      {'input' : 'X', 'counterClockWise': true, 'expectedOutput' : 'X'},
  
      {'input' : '?', 'counterClockWise': false, 'expectedOutput' : ''},
      {'input' : '?%§!', 'counterClockWise': true, 'expectedOutput' : ''},
  
      {'input' : '?A', 'counterClockWise': false, 'expectedOutput' : 'A'},
      {'input' : '?%A§!', 'counterClockWise': false, 'expectedOutput' : 'A'},
      {'input' : '?A', 'counterClockWise': true, 'expectedOutput' : 'A'},
      {'input' : '?%A§!', 'counterClockWise': true, 'expectedOutput' : 'A'},
  
      {'input' : 'AB', 'counterClockWise': false, 'expectedOutput' : 'BA'},
      {'input' : 'ABC', 'counterClockWise': false, 'expectedOutput' : 'CAB'},
      {'input' : 'ABCD', 'counterClockWise': false, 'expectedOutput' : 'DACB'},
      {'input' : 'ABCDE', 'counterClockWise': false, 'expectedOutput' : 'EADBC'},
      {'input' : 'DID YOU EVER BITE A LEMON', 'counterClockWise': false, 'expectedOutput' : 'NDOIMDEYLOAUEETVIEBR'},
      {'input' : 'Did You Ever Bite A Lemon', 'counterClockWise': false, 'expectedOutput' : 'nDoimdeYLoAueEtvieBr'},
  
      {'input' : 'AB', 'counterClockWise': true, 'expectedOutput' : 'AB'},
      {'input' : 'ABC', 'counterClockWise': true, 'expectedOutput' : 'ACB'},
      {'input' : 'ABCD', 'counterClockWise': true, 'expectedOutput' : 'ADBC'},
      {'input' : 'ABCDE', 'counterClockWise': true, 'expectedOutput' : 'AEBDC'},
      {'input' : 'DID YOU EVER BITE A LEMON', 'counterClockWise': true, 'expectedOutput' : 'DNIODMYEOLUAEEVTEIRB'},
      {'input' : 'Did You Ever Bite A Lemon', 'counterClockWise': true, 'expectedOutput' : 'DniodmYeoLuAEevteirB'}
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, counterClockWise: ${elem['counterClockWise']}', () {
        var _actual = encryptLemon(elem['input'], counterClockWise: elem['counterClockWise']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Lemon.decrypt:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'counterClockWise': null, 'expectedOutput' : ''},
      {'input' : '', 'counterClockWise': null, 'expectedOutput' : ''},
      {'input' : null, 'counterClockWise': false, 'expectedOutput' : ''},
      {'input' : '', 'counterClockWise': false, 'expectedOutput' : ''},
  
      {'input' : 'X', 'counterClockWise': false, 'expectedOutput' : 'X'},
      {'input' : 'X', 'counterClockWise': true, 'expectedOutput' : 'X'},
  
      {'input' : '?', 'counterClockWise': false, 'expectedOutput' : ''},
      {'input' : '?%§!', 'counterClockWise': true, 'expectedOutput' : ''},
  
      {'input' : '?A', 'counterClockWise': false, 'expectedOutput' : 'A'},
      {'input' : '?%A§!', 'counterClockWise': false, 'expectedOutput' : 'A'},
      {'input' : '?A', 'counterClockWise': true, 'expectedOutput' : 'A'},
      {'input' : '?%A§!', 'counterClockWise': true, 'expectedOutput' : 'A'},
  
      {'input' : 'AB', 'counterClockWise': false, 'expectedOutput' : 'BA'},
      {'input' : 'ABC', 'counterClockWise': false, 'expectedOutput' : 'BCA'},
      {'input' : 'ABCD', 'counterClockWise': false, 'expectedOutput' : 'BDCA'},
      {'input' : 'ABCDE', 'counterClockWise': false, 'expectedOutput' : 'BDECA'},
      {'input' : 'NDOIMDEYLOAUEETVIEBR', 'counterClockWise': false, 'expectedOutput' : 'DIDYOUEVERBITEALEMON'},
      {'input' : 'NDO IMD EYLO AUEE T VIEBR', 'counterClockWise': false, 'expectedOutput' : 'DIDYOUEVERBITEALEMON'},
      {'input' : 'nDoimdeYLoAueEtvieBr', 'counterClockWise': false, 'expectedOutput' : 'DidYouEverBiteALemon'},
      {'input' : 'nDo imd eYLo AueE t vieBr', 'counterClockWise': false, 'expectedOutput' : 'DidYouEverBiteALemon'},
  
      {'input' : 'AB', 'counterClockWise': true, 'expectedOutput' : 'AB'},
      {'input' : 'ABC', 'counterClockWise': true, 'expectedOutput' : 'ACB'},
      {'input' : 'ABCD', 'counterClockWise': true, 'expectedOutput' : 'ACDB'},
      {'input' : 'ABCDE', 'counterClockWise': true, 'expectedOutput' : 'ACEDB'},
      {'input' : 'DNIODMYEOLUAEEVTEIRB', 'counterClockWise': true, 'expectedOutput' : 'DIDYOUEVERBITEALEMON'},
      {'input' : 'DniodmYeoLuAEevteirB', 'counterClockWise': true, 'expectedOutput' : 'DidYouEverBiteALemon'}
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, counterClockWise: ${elem['counterClockWise']}', () {
        var _actual = decryptLemon(elem['input'], counterClockWise: elem['counterClockWise']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}