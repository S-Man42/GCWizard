import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/utils/common_utils.dart';

void main() {
  group("CommonUtils.insertCharacter:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'index': 0, 'character' : 'A', 'expectedOutput' : null},
      {'input' : 'ABC', 'index': 0, 'character' : null, 'expectedOutput' : 'ABC'},

      {'input' : 'ABC', 'index': -1, 'character' : 'D', 'expectedOutput' : 'DABC'},
      {'input' : 'ABC', 'index': 0, 'character' : 'D', 'expectedOutput' : 'DABC'},
      {'input' : 'ABC', 'index': 1, 'character' : 'D', 'expectedOutput' : 'ADBC'},
      {'input' : 'ABC', 'index': 2, 'character' : 'D', 'expectedOutput' : 'ABDC'},
      {'input' : 'ABC', 'index': 3, 'character' : 'D', 'expectedOutput' : 'ABCD'},
      {'input' : 'ABC', 'index': 4, 'character' : 'D', 'expectedOutput' : 'ABCD'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, input: ${elem['index']}, input: ${elem['character']}', () {
        var _actual = insertCharacter(elem['input'], elem['index'], elem['character']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.insertSpaceEveryNthCharacter:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'n': 0, 'expectedOutput' : ''},
      {'input' : 'ABC', 'n': null, 'expectedOutput' : 'ABC'},
      {'input' : 'ABC', 'n': 0, 'expectedOutput' : 'ABC'},
      {'input' : 'ABC', 'n': 1, 'expectedOutput' : 'A B C'},
      {'input' : 'ABCDEF', 'n': 2, 'expectedOutput' : 'AB CD EF'},
      {'input' : 'ABCDEFGHIJ', 'n': 3, 'expectedOutput' : 'ABC DEF GHI J'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, n: ${elem['n']}', () {
        var _actual = insertSpaceEveryNthCharacter(elem['input'], elem['n']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.digitsToAlpha:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'aValue': null, 'removeNonDigits' : null, 'expectedOutput' : null},
      {'input' : null, 'aValue': null, 'removeNonDigits' : true, 'expectedOutput' : null},
      {'input' : null, 'aValue': 0, 'removeNonDigits' : null, 'expectedOutput' : null},
      {'input' : '', 'aValue': null, 'removeNonDigits' : null, 'expectedOutput' : ''},
  
      {'input' : '', 'aValue': 0, 'removeNonDigits' : null, 'expectedOutput' : ''},
      {'input' : '', 'aValue': null, 'removeNonDigits' : false, 'expectedOutput' : ''},
  
      {'input' : null, 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : null},
  
      {'input' : '', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : ''},
  
      {'input' : '0', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'J'},
  
      {'input' : '0', 'aValue': 1, 'removeNonDigits' : true, 'expectedOutput' : 'B'},
      {'input' : '9', 'aValue': 1, 'removeNonDigits' : true, 'expectedOutput' : 'K'},
  
      {'input' : '0', 'aValue': 13, 'removeNonDigits' : true, 'expectedOutput' : 'N'},
      {'input' : '9', 'aValue': 13, 'removeNonDigits' : true, 'expectedOutput' : 'W'},
  
      {'input' : '0', 'aValue': 26, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': 26, 'removeNonDigits' : true, 'expectedOutput' : 'J'},
      {'input' : '0', 'aValue': 39, 'removeNonDigits' : true, 'expectedOutput' : 'N'},
      {'input' : '9', 'aValue': 39, 'removeNonDigits' : true, 'expectedOutput' : 'W'},
      {'input' : '0', 'aValue': 52, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': 52, 'removeNonDigits' : true, 'expectedOutput' : 'J'},
  
      {'input' : '0', 'aValue': -1, 'removeNonDigits' : true, 'expectedOutput' : 'Z'},
      {'input' : '9', 'aValue': -1, 'removeNonDigits' : true, 'expectedOutput' : 'I'},
      {'input' : '0', 'aValue': -13, 'removeNonDigits' : true, 'expectedOutput' : 'N'},
      {'input' : '9', 'aValue': -13, 'removeNonDigits' : true, 'expectedOutput' : 'W'},
      {'input' : '0', 'aValue': -26, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': -26, 'removeNonDigits' : true, 'expectedOutput' : 'J'},
      {'input' : '0', 'aValue': -39, 'removeNonDigits' : true, 'expectedOutput' : 'N'},
      {'input' : '9', 'aValue': -39, 'removeNonDigits' : true, 'expectedOutput' : 'W'},
      {'input' : '0', 'aValue': -52, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': -52, 'removeNonDigits' : true, 'expectedOutput' : 'J'},
  
      {'input' : '0123456789', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'ABCDEFGHIJ'},
      {'input' : '97531', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'JHFDB'},
  
      {'input' : '0123456789', 'aValue': 21, 'removeNonDigits' : true, 'expectedOutput' : 'VWXYZABCDE'},
      {'input' : '97531', 'aValue': 21, 'removeNonDigits' : true, 'expectedOutput' : 'ECAYW'},
  
      {'input' : '0123456789', 'aValue': -5, 'removeNonDigits' : true, 'expectedOutput' : 'VWXYZABCDE'},
      {'input' : '97531', 'aValue': -5, 'removeNonDigits' : true, 'expectedOutput' : 'ECAYW'},
  
      {'input' : ' 0 !"1§ 2% 3 4. 5 6b 7 s8 E9- ', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'ABCDEFGHIJ'},
      {'input' : '  !"§ %  .  b  s E- ', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : ''},
      
      {'input' : ' 0 !"1§ 2% 3 4. 5 6b 7 s8 E9- ', 'aValue': 0, 'removeNonDigits' : false, 'expectedOutput' : ' A !"B§ C% D E. F Gb H sI EJ- '},
      {'input' : '  !"§ %  .  b  s E- ', 'aValue': 0, 'removeNonDigits' : false, 'expectedOutput' : '  !"§ %  .  b  s E- '},
  
      {'input' : ' 0 !"1§ 2% 3 4. 5 6b 7 s8 E9- ', 'aValue': 13, 'removeNonDigits' : true, 'expectedOutput' : 'NOPQRSTUVW'},
      {'input' : '  !"§ %  .  b  s E- ', 'aValue': 13, 'removeNonDigits' : true, 'expectedOutput' : ''},
  
      {'input' : ' 0 !"1§ 2% 3 4. 5 6b 7 s8 E9- ', 'aValue': 13, 'removeNonDigits' : false, 'expectedOutput' : ' N !"O§ P% Q R. S Tb U sV EW- '},
      {'input' : '  !"§ %  .  b  s E- ', 'aValue': 13, 'removeNonDigits' : false, 'expectedOutput' : '  !"§ %  .  b  s E- '},
      
    ];
  
    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, aValue: ${elem['aValue']}, removeNonDigits: ${elem['removeNonDigits']}', () {
        var _actual = digitsToAlpha(elem['input'], aValue: elem['aValue'], removeNonDigits: elem['removeNonDigits']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.sanitizeIntegerString:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'allowNegativeValues': null, 'allowNumberList' : null, 'expectedOutput' : ''},
      
      {'input' : '', 'allowNegativeValues': null, 'allowNumberList' : null, 'expectedOutput' : ''},
      {'input' : null, 'allowNegativeValues': true, 'allowNumberList' : null, 'expectedOutput' : ''},
      {'input' : null, 'allowNegativeValues': null, 'allowNumberList' : true, 'expectedOutput' : ''},
  
      {'input' : '', 'allowNegativeValues': true, 'allowNumberList' : null, 'expectedOutput' : ''},
      {'input' : '', 'allowNegativeValues': null, 'allowNumberList' : true, 'expectedOutput' : ''},
      {'input' : null, 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ''},
  
      {'input' : '', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ''},
  
      /** negative values, list */
      {'input' : '1', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : '1'},
      {'input' : '123456789', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : '123456789'},
      {'input' : '123 456 789', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : '123 456 789'},
      {'input' : ' 123 456 789 ', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ' 123 456 789 '},
  
      {'input' : '-1', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : '-1'},
      {'input' : '-123456789', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : '-123456789'},
      {'input' : '-123 -456 -789', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : '-123 -456 -789'},
      {'input' : ' -123 -456 -789 ', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ' -123 -456 -789 '},
  
      {'input' : 'a-b1c', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ' - 1 '},
      {'input' : 'a-b1c2%=()3456789', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ' - 1 2 3456789'},
      {'input' : '-12(3) -4a56 -78a9', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : '-12 3 -4 56 -78 9'},
  
      {'input' : '         123        456      789       ', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ' 123 456 789 '},
  
      {'input' : ' 123-   456-   789-   ', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ' 123 - 456 - 789 - '},
      {'input' : ' ---123---   ---456---   ---789---   ', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : ' ---123 --- ---456 --- ---789 --- '},
  
      {'input' : '-1-2-3-4-5-6-7-8-9-', 'allowNegativeValues': true, 'allowNumberList' : true, 'expectedOutput' : '-1 -2 -3 -4 -5 -6 -7 -8 -9 -'},
  
      /** positive values, list */
      {'input' : '1', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : '1'},
      {'input' : '123456789', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : '123456789'},
      {'input' : '123 456 789', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : '123 456 789'},
      {'input' : ' 123 456 789 ', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 123 456 789 '},
  
      {'input' : '-1', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 1'},
      {'input' : '-123456789', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 123456789'},
      {'input' : '-123 -456 -789', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 123 456 789'},
      {'input' : ' -123 -456 -789 ', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 123 456 789 '},
  
      {'input' : 'a-b1c', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 1 '},
      {'input' : 'a-b1c2%=()3456789', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 1 2 3456789'},
      {'input' : '-12(3) -4a56 -78a9', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 12 3 4 56 78 9'},
  
      {'input' : '         123        456      789       ', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 123 456 789 '},
  
      {'input' : ' 123-   456-   789-   ', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 123 456 789 '},
      {'input' : ' ---123---   ---456---   ---789---   ', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 123 456 789 '},
  
      {'input' : '-1-2-3-4-5-6-7-8-9-', 'allowNegativeValues': false, 'allowNumberList' : true, 'expectedOutput' : ' 1 2 3 4 5 6 7 8 9 '},
  
      /** negative values, single */
      {'input' : '1', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '1'},
      {'input' : '123456789', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : '123 456 789', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : ' 123 456 789 ', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
  
      {'input' : '-1', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-1'},
      {'input' : '-123456789', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-123456789'},
      {'input' : '-123 -456 -789', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-123456789'},
      {'input' : ' -123 -456 -789 ', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-123456789'},
  
      {'input' : 'a-b1c', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-1'},
      {'input' : 'a-b1c2%=()3456789', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-123456789'},
      {'input' : '-12(3) -4a56 -78a9', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-123456789'},
  
      {'input' : '         123        456      789       ', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
  
      {'input' : ' 123-   456-   789-   ', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : ' ---123---   ---456---   ---789---   ', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-123456789'},
  
      {'input' : '-1-2-3-4-5-6-7-8-9-', 'allowNegativeValues': true, 'allowNumberList' : false, 'expectedOutput' : '-123456789'},
  
      /** positive values, single */
      {'input' : '1', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '1'},
      {'input' : '123456789', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : '123 456 789', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : ' 123 456 789 ', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
  
      {'input' : '-1', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '1'},
      {'input' : '-123456789', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : '-123 -456 -789', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : ' -123 -456 -789 ', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
  
      {'input' : 'a-b1c', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '1'},
      {'input' : 'a-b1c2%=()3456789', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : '-12(3) -4a56 -78a9', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
  
      {'input' : '         123        456      789       ', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
  
      {'input' : ' 123-   456-   789-   ', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
      {'input' : ' ---123---   ---456---   ---789---   ', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
  
      {'input' : '-1-2-3-4-5-6-7-8-9-', 'allowNegativeValues': false, 'allowNumberList' : false, 'expectedOutput' : '123456789'},
    ];
  
    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, allowNegativeValues: ${elem['allowNegativeValues']}, allowNumberList: ${elem['allowNumberList']}', () {
        var _actual = sanitizeIntegerString(elem['input'], allowNegativeValues: elem['allowNegativeValues'], allowNumberList: elem['allowNumberList']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}