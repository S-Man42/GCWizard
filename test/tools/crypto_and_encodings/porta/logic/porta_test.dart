import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/porta/logic/porta.dart';

void main() {
  group("Porta: togglePorta:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': '', 'key': '', 'version': PortaTableVersion.ORIGINAL, 'classic': false, 'expectedOutput': ''},
      {
        'input': 'The quick brown fox jumps.',
        'key': 'foxbrown',
        'version': PortaTableVersion.ORIGINAL,
        'classic': true,
        'expectedOutput': 'INRDN TTGIA SLERE B'
      },
      {
        'input': 'INRDNTTGIASLEREB',
        'key': 'foxbrown',
        'version': PortaTableVersion.ORIGINAL,
        'classic': true,
        'expectedOutput': 'THEQI CBRON FOXMP S'
      },
      {
        'input': 'Defend the eastwall of the castle',
        'key': 'kingarthur',
        'version': PortaTableVersion.REVERSE,
        'classic': false,
        'expectedOutput': 'VVYUA YKXOZ SBAGN TULPL ZVVQF LUU'
      },
      {
        'input': 'VVYUAYKXOZSBAGNTULPLZVVQFLUU',
        'key': 'kingarthur',
        'version': PortaTableVersion.REVERSE,
        'classic': false,
        'expectedOutput': 'DEFEN DTHEE ASTWA LLOFT HECAS TLE'
      },
      {
        'input': 'chiffredeporta',
        'key': 'acier',
        'version': PortaTableVersion.ORIGINAL,
        'classic': false,
        'expectedOutput': 'PTRQX EQZPK BFKY'
      },
      {
        'input': 'ABCDEFG',
        'key': 'ABCDEFG',
        'version': PortaTableVersion.ORIGINAL,
        'classic': false,
        'expectedOutput': 'NOOPP QQ'
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = togglePorta(
            elem['input'] as String, elem['key'] as String,
            version: elem['version'] as PortaTableVersion, classic: elem['classic'] as bool);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

}