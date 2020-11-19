import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/keyboard.dart';

void main() {
  String inputString = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!"§\$%&/()=?^´°`*+#;,:._-'+"'";

  group("Keyboard.encode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : null},
      {'input' : '', 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTZ_T1, 'to' : KeyboardMode.NEO, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.NEO, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.QWERTY_US_INT, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.NEO, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.NEO, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_II_DEU, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.NEO, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU1, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.NEO, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.Dvorak_I_DEU2, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.NEO, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.COLEMAK, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.NEO, 'expectedOutput' : inputString},
      {'input' : inputString, 'from' : KeyboardMode.NEO, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : ''},

      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.QWERTZ_T1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.QWERTY_US_INT, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.Dvorak, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.Dvorak_II_DEU, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.Dvorak_I_DEU1, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.Dvorak_I_DEU2, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.COLEMAK, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.NEO, 'expectedOutput' : ''},
      {'input' : inputString, 'from' : KeyboardMode.RISTOME, 'to' : KeyboardMode.RISTOME, 'expectedOutput' : inputString},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, from: ${elem['from']}, to: ${elem['to']}', () {
        var _actual = encodeKeyboard(elem['input'], elem['from'], elem['to']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}