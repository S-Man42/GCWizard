import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';

void main(){
  group("NumeralWords.decodeNumeralwordsEntireWords:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : NumeralWordsDecodeOutput([''], [''], ['numeralwords_language_empty'])},
      {'input' : '', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : NumeralWordsDecodeOutput([''], [''], ['numeralwords_language_empty'])},
      {'input' : 'fünfundzwanzig', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : NumeralWordsDecodeOutput(['25'], ['fünfundzwanzig'], ['numeralwords_language_empty'])},

      {'input' : 'hundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100'},
      {'input' : 'hunderteins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '101'},
      {'input' : 'hundertundeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '101'},
      {'input' : 'einhundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100'},
      {'input' : 'einhunderteins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '101'},
      {'input' : 'einhundertundeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '101'},
      {'input' : 'hundertfünfundzwanzig', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '125'},
      {'input' : 'abc einhundertfünfundzwanzig abc', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '125'},
      {'input' : 'zweihundertfünfundzwanzig', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '225'},
      {'input' : 'tausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '25'},
      {'input' : 'eintausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '25'},
      {'input' : 'zweitausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '25'},
      {'input' : 'hunderttausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100000'},
      {'input' : 'hunderttausendhundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100100'},
      {'input' : 'hunderttausendeinhundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100100'},
      {'input' : 'hunderttausendhunderteins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100101'},
      {'input' : 'hunderttausendhundertundeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100101'},
      {'input' : 'einhunderttausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100000'},
      {'input' : 'einhunderttausendeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '100001'},
      {'input' : 'hunderteinstausendeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '101001'},
      {'input' : 'hundertundeinstausendeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '101001'},
      {'input' : 'einhundertundeinstausendeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '101001'},
      {'input' : 'einhunderttausendundeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '101001'},
      {'input' : 'zweihunderttausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '200000'},
      {'input' : 'fünfundzwanzigtausendsiebenhundertzweiundvierzig', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : true, 'expectedOutput' : '25742'},

      {'input' : 'one', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1'},
      {'input' : 'ten', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '10'},
      {'input' : 'abc ten def one abc', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '10 1'},

      {'input' : 'fifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '50'},
      {'input' : 'fiftyone', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '51'},
      {'input' : 'fifty-one', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '51'},
      {'input' : 'fifty one', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '51'},

      {'input' : 'hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '100'},
      {'input' : 'a hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '100'},
      {'input' : 'one hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '100'},
      {'input' : 'onehundredfifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '150'},
      {'input' : 'one hundred fifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '150'},
      {'input' : 'a hundred and fifty-five', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '155'},
      {'input' : 'two hundred and fifty-five', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '255'},

      {'input' : 'thousand', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1000'},
      {'input' : 'a thousand', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1000'},
      {'input' : 'one thousand', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1000'},
      {'input' : 'onethousandfifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1050'},
      {'input' : 'one thousand fifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1050'},
      {'input' : 'a thousand and fifty-five', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1055'},
      {'input' : 'two thousand and fifty-five', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '2055'},

      {'input' : 'thousandhundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1100'},
      {'input' : 'thousand hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1100'},
      {'input' : 'a thousand and hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '1100'},
      {'input' : 'a thousand and onehundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '100100'},
      {'input' : 'onethousand and onehundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '100100'},
      {'input' : 'a hundredthousandhundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '100100'},
      {'input' : 'a hundredthousandhundredone', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '100101'},
      {'input' : 'twohundredseventy-fivethousandhundredandone', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : true, 'expectedOutput' : '275101'},
      
      {'input' : 'huit cinq seize sis one two eins', 'language' : NumeralWordsLanguage.ALL, 'decodeMode' : true, 'expectedOutput' : '8 5 16 6 1 2 1'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, language: ${elem['language']}, decodeMode: ${elem['decodeMode']}', () {
        var _actual = decodeNumeralwords(elem['input'].toString().toUpperCase(), elem['language'], elem['decodeMode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("NumeralWords.decodeNumeralwordsEntireWordsAsParts:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : ''},
      {'input' : 'fünfundzwanzig', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : {{'25'},{'fünfundzwanzig'},{''}}},

      {'input' : 'hundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'hunderteins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '101'},
      {'input' : 'hundertundeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '101'},
      {'input' : 'einhundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'einhunderteins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '101'},
      {'input' : 'einhundertundeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '101'},
      {'input' : 'hundertfünfundzwanzig', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '125'},
      {'input' : 'abc einhundertfünfundzwanzig abc', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '125'},
      {'input' : 'zweihundertfünfundzwanzig', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '225'},
      {'input' : 'tausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '25'},
      {'input' : 'eintausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '25'},
      {'input' : 'zweitausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '25'},
      {'input' : 'hunderttausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100000'},
      {'input' : 'hunderttausendhundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100100'},
      {'input' : 'hunderttausendeinhundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100100'},
      {'input' : 'hunderttausendhunderteins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100101'},
      {'input' : 'hunderttausendhundertundeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100101'},
      {'input' : 'einhunderttausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100000'},
      {'input' : 'einhunderttausendeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100001'},
      {'input' : 'hunderteinstausendeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '101001'},
      {'input' : 'hundertundeinstausendeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '101001'},
      {'input' : 'einhundertundeinstausendeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '101001'},
      {'input' : 'einhunderttausendundeins', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '101001'},
      {'input' : 'zweihunderttausend', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '200000'},
      {'input' : 'fünfundzwanzigtausendsiebenhundertzweiundvierzig', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '25742'},

      {'input' : 'one', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1'},
      {'input' : 'ten', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '10'},
      {'input' : 'abc ten def one abc', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '10 1'},

      {'input' : 'fifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '50'},
      {'input' : 'fiftyone', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '51'},
      {'input' : 'fifty-one', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '51'},
      {'input' : 'fifty one', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '51'},

      {'input' : 'hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'a hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'one hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'onehundredfifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '150'},
      {'input' : 'one hundred fifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '150'},
      {'input' : 'a hundred and fifty-five', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '155'},
      {'input' : 'two hundred and fifty-five', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '255'},

      {'input' : 'thousand', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1000'},
      {'input' : 'a thousand', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1000'},
      {'input' : 'one thousand', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1000'},
      {'input' : 'onethousandfifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1050'},
      {'input' : 'one thousand fifty', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1050'},
      {'input' : 'a thousand and fifty-five', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1055'},
      {'input' : 'two thousand and fifty-five', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '2055'},

      {'input' : 'thousandhundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1100'},
      {'input' : 'thousand hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1100'},
      {'input' : 'a thousand and hundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '1100'},
      {'input' : 'a thousand and onehundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100100'},
      {'input' : 'onethousand and onehundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100100'},
      {'input' : 'a hundredthousandhundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100100'},
      {'input' : 'a hundredthousandhundredone', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100101'},
      {'input' : 'twohundredseventy-fivethousandhundredandone', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '275101'},

      {'input' : 'huit cinq seize sis one two eins', 'language' : NumeralWordsLanguage.ALL, 'decodeMode' : false, 'expectedOutput' : NumeralWordsDecodeOutput(['8','5','16','6','1','2','1'],
      ['huit', 'cinq', 'seize', 'sis', 'one', 'two', 'eins'],
      ['numeralwords_language_fra', 'numeralwords_language_fra', 'numeralwords_language_fra', 'numeralwords_language_fra', 'numeralwords_language_en', 'numeralwords_language_en','numeralwords_language_du'])},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, language: ${elem['language']}, decodeMode: ${elem['decodeMode']}', () {
        var _actual = decodeNumeralwords(elem['input'].toString().toUpperCase(), elem['language'], elem['decodeMode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("NumeralWords.decodeNumeralwordsWordParts:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : 'Susi wacht einsam während Vater und Mutter zweifelnd Sand sieben. Null Bock, denkt sich Jörg. Ich lasse fünfe grade sein und kegel lieber alle Neune!', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '8 1 2 7 0 5 9'},

      {'input' : 'einszwei', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '1 2'},
      {'input' : 'einszw', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '1'},
      {'input' : 'abczweihundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '200'},
      {'input' : 'abchundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'abceinhundert', 'language' : NumeralWordsLanguage.DEU, 'decodeMode' : false, 'expectedOutput' : '100'},

      {'input' : 'abchundred', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'abc hundreddef', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'abconehundreddef def', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '100'},
      {'input' : 'onehundredfiftydef', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '150'},
      {'input' : 'abcone hundred fiftydef', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '150'},
      {'input' : 'abca hundred and fifty-fivedef', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '155'},
      {'input' : 'abctwo hundred and fifty-fivedef', 'language' : NumeralWordsLanguage.ENG, 'decodeMode' : false, 'expectedOutput' : '255'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, language: ${elem['language']}, decodeMode: ${elem['decodeMode']}', () {
        var _actual = decodeNumeralwords(elem['input'].toString().toUpperCase(), elem['language'], elem['decodeMode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}