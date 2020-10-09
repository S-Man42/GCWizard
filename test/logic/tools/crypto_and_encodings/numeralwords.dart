import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeralwords.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

void main(){
  group("NumeralWords.decodeNumeralwords:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'language' : NumeralWordsLanguage.DE, 'decodeMode' : GCWSwitchPosition.left, 'expectedOutput' : ''},
      {'input' : 'fünfundzwanzig', 'language' : NumeralWordsLanguage.DE, 'decodeMode' : GCWSwitchPosition.left, 'expectedOutput' : '25'},
      {'input' : 'Susi wacht einsam während Vater und Mutter zweifelnd Sand sieben. Null Bock, denkt sich Jörg. Ich lasse fünfe grade sein und kegel lieber alle Neune!', 'language' : NumeralWordsLanguage.DE, 'decodeMode' : GCWSwitchPosition.right, 'expectedOutput' : '8 1 2 7 0 5 9'},
      {'input' : 'huit cinq seize sis one two eins', 'language' : NumeralWordsLanguage.ALL, 'decodeMode' : GCWSwitchPosition.left, 'expectedOutput' : '8 5 16 6 1 2 1'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, language: ${elem['language']}, decodeMode: ${elem['decodeMode']}', () {
        var _actual = decodeNumeralwords(elem['input'].toString().toUpperCase(), elem['language'], elem['decodeMode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}