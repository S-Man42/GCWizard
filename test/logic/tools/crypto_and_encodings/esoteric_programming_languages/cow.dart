import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/cow.dart';

void main() {
  group("Cow.interpretCow:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'code': null, 'expectedOutput': ''},
      {'code': '', 'expectedOutput': ''},
      {'code': 'ABC123;', 'expectedOutput': ''},
      {'code': '++', 'expectedOutput': ''},

      // https://esolangs.org/wiki/COW
      {
        'code':
        'MoO moO MoO mOo MOO OOM MMM moO moO MMM mOo mOo moO MMM mOo MMM moO moO MOO MOo mOo MoO moO moo mOo mOo moo',
        'expectedOutput': '112358132134558914423337761098715972584'
      },
      {
        'code':
        'MoO MoO MoO MoO MoO MoO MoO MoO MOO moO MoO MoO MoO MoO MoO moO MoO MoO MoO MoO moO MoO MoO MoO MoO moO MoO MoO MoO MoO MoO MoO MoO MoO MoO moO MoO MoO MoO MoO mOo mOo mOo mOo mOo MOo moo moO moO moO moO Moo moO MOO mOo MoO moO MOo moo mOo MOo MOo MOo Moo MoO MoO MoO MoO MoO MoO MoO Moo Moo MoO MoO MoO Moo MMM mOo mOo mOo MoO MoO MoO MoO Moo moO Moo MOO moO moO MOo mOo mOo MOo moo moO moO MoO MoO MoO MoO MoO MoO MoO MoO Moo MMM MMM Moo MoO MoO MoO Moo MMM MOo MOo MOo Moo MOo MOo MOo MOo MOo MOo MOo MOo Moo mOo MoO Moo',
        'expectedOutput': 'Hello, World!'
      },
      // https://frank-buss.de/cow.html
      {
        'code':
        'OOOMoOMoOMoOMoOMoOMoOMoOMoOMMMmoOMMMMMMmoOMMMMOOMOomOoMoOmoOmoomOoMMMmoOMMMMMMmoOMMMMOOMOomOoMoOmoOmoomOoMMMmoOMMMMMMmoOMMMMOOMOomOoMoOmoOmooOOOMoOMoOMoOMoOMoOMoOmOoMMMmoOmoOMMMMOOMOomOoMoOmoOmoomOoMoomOoMMMmoOMMMmOomOoMMMmoOmoOmoOMMMMOOMOomOoMoOmoOmoomOoMMMmoOMMMMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoomOoMMMmoOMMMMoOMoomOoMMMmoOMMMMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMooMOoMOoMOoMoo',
        'expectedOutput': 'Frank'
      },
      {
        'code':
        'OOOMoOMoOMoOMoOMoOMoOMoOMoOMMMmoOMMMMMMmoOMMMMOOMOomOoMoOmoOmoomOoMMMmoOMMMMMMmoOMMMMOOMOomOoMoOmoOmoomOoMMMmoOMMMMMMmoOMMMMOOMOomOoMoOmoOmooOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOoMMMmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOoMMMmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOoMMMmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOoMMMmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOomOomOoMMMmoOmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOomOoMMMmoOmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOoMMMmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOoMMMmoOmoOMMMMOOMOomoOMoOmOomoomOomOomOoMMMmoOmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoomOo        OOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOoMMMmoOmoOMMMMOOMOo        moOMoOmOomoomoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOoMMMmoOMMMMOOMOomoOMoOmOomoomOomOoMMMmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoOMoOMoOMoomOoOOOmoOOOOmOomOomOoMMMmoOmoOMMMMOOMOomoOMoOmOomoomoOMoOMoomOo',
        'expectedOutput': 'Hello World!'
      },

      {
        'code':
        'OOO MoO MoO MoO MoO MoO MoO MoO MoO MMM moO MMM MMM moO MMM MOO MOo mOo MoO moO moo mOo MMM moO MMM MMM moO MMM MOO MOo mOo MoO moO moo mOo MMM moO MMM MMM moO MMM MOO MOo mOo MoO moO moo OOO moO OOO mOo mOo MMM moO MMM MOO MOo moO MoO mOo moo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo MMM moO MMM MOO MOo moO MoO mOo moo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO Moo mOo OOO moO OOO mOo mOo mOo MMM moO moO MMM MOO MOo moO MoO mOo moo mOo mOo mOo MMM moO moO moO MMM MOO MOo moO MoO mOo moo moO MoO MoO MoO Moo mOo',
        'expectedOutput': 'n 52 27.345 e 013 09.123'
      },

    ];

    _inputsToExpected.forEach((elem) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = interpretCow(elem['code']).output;
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
