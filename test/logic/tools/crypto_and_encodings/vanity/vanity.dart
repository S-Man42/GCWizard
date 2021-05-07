import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity/vanity.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity/phone_models.dart';

void main() {
  // group("Vanity.encryptVanitySingleNumbers:", () {
  //   List<Map<String, dynamic>> _inputsToExpected = [
  //     {'input' : null, 'expectedOutput' : ''},
  //     {'input' : '', 'expectedOutput' : ''},
  //
  //     {'input' : 'ABCXYZ', 'model': SIEMENS, 'expectedOutput' : '222999'},
  //     {'input' : 'AbcxyZ', 'model': SIEMENS, 'expectedOutput' : '222999'},
  //     {'input' : 'ABC123XYZ', 'model': SIEMENS, 'expectedOutput' : '222123999'},
  //     {'input' : 'ÄÖÜß', 'model': SIEMENS, 'expectedOutput' : '2687'},
  //     {'input' : '*%&/', 'model': SIEMENS, 'expectedOutput' : ''},
  //     {'input' : 'ABC*%&/', 'model': SIEMENS, 'expectedOutput' : '222'},
  //
  //     {'input' : 'ABC01 .?\$&°', 'model': NOKIA, 'expectedOutput' : '222010117*'},
  //     {'input' : 'ABC01 .?\$&°', 'model': SAMSUNG, 'expectedOutput' : '22201011**'},
  //     {'input' : 'ABC01 .?\$&°', 'model': SIEMENS, 'expectedOutput' : '222011001'},
  //   ];
  //
  //   _inputsToExpected.forEach((elem) {
  //     test('input: ${elem['input']}, model: ${elem['model']}', () {
  //       var _actual = encodeVanitySingleNumbers(elem['input'], elem['model']);
  //       expect(_actual, elem['expectedOutput']);
  //     });
  //   });
  // });

  // group("Vanity.encodeVanityMultipleNumbers:", () {
  //   List<Map<String, dynamic>> _inputsToExpected = [
  //     // {'input' : null, 'expectedOutput' : '', 'caseSensitive': false},
  //     // {'input' : '', 'expectedOutput' : '', 'caseSensitive': false},
  //     //
  //     // {'input' : 'ABCXYZ', 'model': SIEMENS, 'caseSensitive': false, 'expectedOutput' : '2 22 222 99 999 9999'},
  //     // {'input' : 'Abc xyZ', 'model': SIEMENS, 'caseSensitive': false, 'expectedOutput' : '2 22 222 1 99 999 9999'},
  //     // {'input' : 'ABC123XYZ', 'model': SIEMENS, 'caseSensitive': false, 'expectedOutput' : '2 22 222 11 2222 3333 99 999 9999'},
  //     // {'input' : 'ÄÖÜß', 'model': SIEMENS, 'caseSensitive': false, 'expectedOutput' : '22222 66666 88888 777777'},
  //     // {'input' : '*%&/', 'model': SIEMENS, 'caseSensitive': false, 'expectedOutput' : ''},
  //     // {'input' : 'ABC*%&/+', 'model': SIEMENS, 'caseSensitive': false, 'expectedOutput' : '2 22 222 000000'},
  //     // {'input' : '. ', 'model': SIEMENS, 'caseSensitive': false, 'expectedOutput' : '0 1'},
  //     //
  //     // {'input' : 'ABC01 .?\$&°', 'model': NOKIA, 'caseSensitive': false, 'expectedOutput' : '2 22 222 00 1111111 0 1 111 7777777 ****************'},
  //     // {'input' : 'ABC01 .?\$&°', 'model': SAMSUNG, 'caseSensitive': false, 'expectedOutput' : '2 22 222 00 11111 0 1 111 **************************** ***********'},
  //     // {'input' : 'ABC01 .?\$&°', 'model': SIEMENS, 'caseSensitive': false, 'expectedOutput' : '2 22 222 00000 11 1 0 000 11111'},
  //
  //     {'input' : 'Hello World', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '44 33 555 555 666 0 # 9 ### 666 777 555 3'},
  //     {'input' : 'hello world', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '# 44 33 555 555 666 0 9 666 777 555 3'},
  //     {'input' : 'HELLO WORLD', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '44 ## 33 555 555 666 0 9 666 777 555 3'},
  //     {'input' : 'HeLlO WoRlD', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '44 33 ## 555 ### 555 # 666 0 9 ### 666 # 777 ### 555 # 3'},
  //     {'input' : 'hElLo wOrLd', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '# 44 # 33 ### 555 # 555 ### 666 0 9 # 666 ### 777 # 555 ### 3'},
  //     {'input' : '1a%B,c a.1.A.a.', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '1111111 2 ***************** ## 22 11 ### 222 0 2 1 1111111 1 ## 2 1 ### 2 1'},
  //     {'input' : '0 0 0', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '00 0 00 0 00'},
  //     {'input' : 'A0 a0 0', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '2 00 0 2 00 0 00'},
  //     {'input' : 'A0 a0 A0', 'model': NOKIA, 'caseSensitive': true, 'expectedOutput' : '2 00 0 2 00 0 # 2 00'},
  //
  //     {'input' : 'Hello World', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '44 33 555 555 666 0 # 9 ### 666 777 555 3'},
  //     {'input' : 'hello world', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '# 44 33 555 555 666 0 9 666 777 555 3'},
  //     {'input' : 'HELLO WORLD', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '44 ## 33 555 555 666 0 9 666 777 555 3'},
  //     {'input' : 'HeLlO WoRlD', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '44 33 ## 555 ### 555 # 666 0 9 ### 666 # 777 ### 555 # 3'},
  //     {'input' : 'hElLo wOrLd', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '# 44 # 33 ### 555 # 555 ### 666 0 9 # 666 ### 777 # 555 ### 3'},
  //     {'input' : '1a%B,c a.1.A.a.', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '1111111 2 ***************** ## 22 11 ### 222 0 2 1 1111111 1 ## 2 1 ### 2 1'},
  //     {'input' : '0 0 0', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '00 0 00 0 00'},
  //     {'input' : 'A0 a0 0', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '2 00 0 2 00 0 00'},
  //     {'input' : 'A0 a0 A0', 'model': SIEMENS, 'caseSensitive': true, 'expectedOutput' : '2 00 0 2 00 0 # 2 00'},
  //   ];
  //
  //   _inputsToExpected.forEach((elem) {
  //     test('input: ${elem['input']}, model: ${elem['model']}, caseSensitive: ${elem['caseSensitive']}', () {
  //       var _actual = encodeVanityMultipleNumbers(elem['input'], elem['model'], caseSensitive: elem['caseSensitive']);
  //       expect(_actual, elem['expectedOutput']);
  //     });
  //   });
  // });

  group("Vanity.decodeVanityMultitap:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      // {'input' : null, 'expectedOutput' : ''},
      // {'input' : '', 'expectedOutput' : ''},

      {'model': phoneModelByName(PHONEMODEL_NOKIA_6230), 'language': PhoneInputLanguage.GERMAN, 'input' : '2', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'A'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_6230), 'language': PhoneInputLanguage.GERMAN, 'input' : '2 22 222 99 999 9999', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Abcxyz'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_6230), 'language': PhoneInputLanguage.GERMAN, 'input' : '2 22 222 1111111 2222 3333 99 999 9999', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Abc123xyz'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_6230), 'language': PhoneInputLanguage.GERMAN, 'input' : '2 666 88 7777', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Aous'}},

      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '2 666 88 7777', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Aous'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '2 666 88 7777', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'ΑΟΤΨ'}},

      {'model': phoneModelByName(PHONEMODEL_NOKIA_6230), 'language': PhoneInputLanguage.GERMAN, 'input' : '88888', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Ü'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_6230), 'language': PhoneInputLanguage.ENGLISH, 'input' : '88888888', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Ü'}},

      {'model': phoneModelByName(PHONEMODEL_SIEMENS_C75), 'language': PhoneInputLanguage.FRENCH, 'input' : '222222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Æ'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_C75), 'language': PhoneInputLanguage.FRENCH, 'input' : '2222222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Å'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_C75), 'language': PhoneInputLanguage.FRENCH, 'input' : '22222222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'A'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_C75), 'language': PhoneInputLanguage.FRENCH, 'input' : '222222222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'B'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_C75), 'language': PhoneInputLanguage.TURKISH, 'input' : '222222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Â'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_C75), 'language': PhoneInputLanguage.TURKISH, 'input' : '2222222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'A'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_C75), 'language': PhoneInputLanguage.TURKISH, 'input' : '22222222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'B'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_C75), 'language': PhoneInputLanguage.TURKISH, 'input' : '222222222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'C'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, model: ${elem['model']}, language: ${elem['language']}', () {
        var _actual = decodeVanityMultitap(elem['input'], elem['model'], elem['language']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}