import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';
import 'package:gc_wizard/utils/common_utils.dart';

void main(){

  group("VanityWords.decode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      // empty input
      {'input' : null, 'language' : NumeralWordsLanguage.DEU,
        'expectedOutput' : [NumeralWordsDecodeOutput('?', '', '')]},
      {'input' : '', 'language' : NumeralWordsLanguage.DEU,
        'expectedOutput' : [NumeralWordsDecodeOutput('', '', 'numeralwords_language_empty')]},
      // faulty input
      {'input' : 'e', 'language' : NumeralWordsLanguage.DEU,
        'expectedOutput' : [NumeralWordsDecodeOutput('?', '', '')]},
      // mixed input
      {'input' : '8437676386e', 'language' : NumeralWordsLanguage.DEU,
        'expectedOutput' : [
          NumeralWordsDecodeOutput('8437', 'VIER', '4'),
          NumeralWordsDecodeOutput('?', '', ''),
          NumeralWordsDecodeOutput('?', '', ''),
          NumeralWordsDecodeOutput('6386', 'NEUN', '9'),
          NumeralWordsDecodeOutput('?', '', ''),
        ]},

      {'input' : 'fünfundzwanzig', 'language' : NumeralWordsLanguage.LAT,
        'expectedOutput' : []},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, language: ${elem['language']}, decodeMode: ${elem['decodeMode']}', () {
        var _actual = decodeVanityWords(removeAccents(elem['input'].toString().toLowerCase()), elem['language']);
        var length = elem['expectedOutput'].length;
        for (int i = 0; i < length; i++) {
          expect(_actual[i].number, elem['expectedOutput'][i].number);
          expect(_actual[i].numWord, elem['expectedOutput'][i].numWord);
          expect(_actual[i].language, elem['expectedOutput'][i].language);
        }
      });
    });
  });
}