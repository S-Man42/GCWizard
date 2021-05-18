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

      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'C'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf.'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1 0', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': 'Cf. '}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1 0 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf. H'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1 00 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf.0h'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1 000000 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf.\nH'}},

      {'model': phoneModelByName(PHONEMODEL_NOKIA_3210), 'language': PhoneInputLanguage.GERMAN, 'input' : '', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_3210), 'language': PhoneInputLanguage.GERMAN, 'input' : '222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'c'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_3210), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_3210), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf.'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_3210), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1 0', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf. '}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_3210), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1 0 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf. h'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_3210), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1 00 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf.0h'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_3210), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 1 000000 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf.0h'}},

      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '222', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'C'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 0', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf.'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 0 1', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': 'Cf. '}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 0 1 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf. H'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 00 1 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf, h'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 333 000 1 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf? H'}},

      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '222', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'C'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '222 333', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CΘ'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '222 333 0', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CΘ.'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '222 333 0 1', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CΘ. '}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '222 333 0 1 44', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CΘ. Η'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '222 333 00 1 44', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CΘ, Η'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_S55), 'language': PhoneInputLanguage.GREEK, 'input' : '222 333 000 1 44', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CΘ? Η'}},

      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '#', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '##', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '# #', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '# ##', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '# 222 333', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CF'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '# # 222 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '## # 222 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 #', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'C'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # 333', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CF'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ## 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # # 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ## 333 1 0', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': 'Cf. '}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ## 333 1 0 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf. H'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ## 333 1 0 44 5', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'Cf. Hj'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # 333 1 0', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CF. '}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # 333 1 0 44', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CF. H'}},
      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # 333 1 0 44 5', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'CF. HJ'}},

      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '#', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '##', 'expectedOutput' : {'mode': PhoneCaseMode.NUMBERS, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '# #', 'expectedOutput' : {'mode': PhoneCaseMode.NUMBERS, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '# ##', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '## 222 333', 'expectedOutput' : {'mode': PhoneCaseMode.NUMBERS, 'output': '222333'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '# # 222 333', 'expectedOutput' : {'mode': PhoneCaseMode.NUMBERS, 'output': '222333'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '## # 222 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 #', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': 'c'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cF'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ## 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # # 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'cf'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # ##', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': 'c'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### #', 'expectedOutput' : {'mode': PhoneCaseMode.NUMBERS, 'output': 'c'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### # 333', 'expectedOutput' : {'mode': PhoneCaseMode.NUMBERS, 'output': 'c333'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 #### 333 ##', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': 'c333'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ## ## 333 ## 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'c333H'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # ### 333 ## 44 #', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'c333H'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222   ###   # 333    ##   44 # 5', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'c333HJ'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### # 333 ## 44 # 5 0', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': 'c333HJ.'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### # 333 ## 44 # 5 0 #', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'c333HJ.'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### # 333 ## 44 # 5 0 # 1', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': 'c333HJ. '}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### # 333 ## 44 # 5 0 # 1 7777', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'c333HJ. S'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### # 333 ## 44 # 5 0 # 1 7777 6', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'c333HJ. Sm'}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### # 333 ## 44 # 5 0 # 1 7777 ****', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'c333HJ. S_'}},

      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '*', 'expectedOutput' : {'mode': PhoneCaseMode.UPPER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '**', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': ''}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 *', 'expectedOutput' : {'mode': PhoneCaseMode.NUMBERS, 'output': 'C'}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 * 333', 'expectedOutput' : {'mode': PhoneCaseMode.NUMBERS, 'output': 'C333'}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 * * 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'CF'}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 * * 333 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'CFh'}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '#', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': ' '}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '##', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': '  '}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 #', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'C '}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 # 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'C f'}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ## 333', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'C  f'}},
      {'model': phoneModelByName(PHONEMODEL_SAMSUNG_E1120), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 1 # 333 44', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'C. Fh'}},

      {'model': phoneModelByName(PHONEMODEL_NOKIA_1650), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 AAA ## 333 a 1 0', 'expectedOutput' : {'mode': PhoneCaseMode.CAMEL_CASE, 'output': 'Cf. '}},
      {'model': phoneModelByName(PHONEMODEL_SIEMENS_A65), 'language': PhoneInputLanguage.GERMAN, 'input' : '222 ### # &%/()33mmmm3 ## 44 # 5 0 # 1 Abc 7777', 'expectedOutput' : {'mode': PhoneCaseMode.LOWER_CASE, 'output': 'c333HJ. S'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, model: ${elem['model']}, language: ${elem['language']}', () {
        var _actual = decodeVanityMultitap(elem['input'], elem['model'], elem['language']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}