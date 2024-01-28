import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/battleship/logic/battleship.dart';

void main() {
  group("Battleship.encodeTextToNumbers:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': '', 'expectedOutput': ''},
      {
        'input': 'hallo',
        'expectedOutput':
            '3,1 16,1 22,1 3,2 16,2 22,2 3,3 4,3 10,3 11,3 16,3 22,3 28,3 3,4 5,4 9,4 11,4 16,4 22,4 27,4 29,4 3,5 5,5 9,5 11,5 16,5 22,5 27,5 29,5 3,6 5,6 9,6 11,6 16,6 22,6 27,6 29,6 3,7 5,7 9,7 10,7 11,7 12,7 17,7 23,7 28,7'
      },
      {
        'input': 'HALLO',
        'expectedOutput':
            '2,1 6,1 10,1 14,1 20,1 27,1 28,1 29,1 2,2 6,2 9,2 11,2 14,2 20,2 26,2 30,2 2,3 6,3 8,3 12,3 14,3 20,3 26,3 30,3 2,4 3,4 4,4 5,4 6,4 8,4 9,4 10,4 11,4 12,4 14,4 20,4 26,4 30,4 2,5 6,5 8,5 12,5 14,5 20,5 26,5 30,5 2,6 6,6 8,6 12,6 14,6 20,6 26,6 30,6 2,7 6,7 8,7 12,7 14,7 15,7 16,7 17,7 18,7 20,7 21,7 22,7 23,7 24,7 27,7 28,7 29,7'
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBattleship(elem['input'] as String, true, true);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.encodeTextToExcel:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': '', 'expectedOutput': ''},
      {
        'input': 'hallo',
        'expectedOutput':
            'C,1 P,1 V,1 C,2 P,2 V,2 C,3 D,3 J,3 K,3 P,3 V,3 AB,3 C,4 E,4 I,4 K,4 P,4 V,4 AA,4 AC,4 C,5 E,5 I,5 K,5 P,5 V,5 AA,5 AC,5 C,6 E,6 I,6 K,6 P,6 V,6 AA,6 AC,6 C,7 E,7 I,7 J,7 K,7 L,7 Q,7 W,7 AB,7'
      },
      {
        'input': 'HALLO',
        'expectedOutput':
            'B,1 F,1 J,1 N,1 T,1 AA,1 AB,1 AC,1 B,2 F,2 I,2 K,2 N,2 T,2 Z,2 AD,2 B,3 F,3 H,3 L,3 N,3 T,3 Z,3 AD,3 B,4 C,4 D,4 E,4 F,4 H,4 I,4 J,4 K,4 L,4 N,4 T,4 Z,4 AD,4 B,5 F,5 H,5 L,5 N,5 T,5 Z,5 AD,5 B,6 F,6 H,6 L,6 N,6 T,6 Z,6 AD,6 B,7 F,7 H,7 L,7 N,7 O,7 P,7 Q,7 R,7 T,7 U,7 V,7 W,7 X,7 AA,7 AB,7 AC,7'
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBattleship(elem['input'] as String, true, false);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.encodeGraphicToNumbers:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': '', 'expectedOutput': ''},
      {
        'input': '  #            #     #       \n' +
            '  #            #     #       \n' +
            '  ##     ##    #     #     # \n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   ####    #     #    # ',
        'expectedOutput':
            '3,1 16,1 22,1 3,2 16,2 22,2 3,3 4,3 10,3 11,3 16,3 22,3 28,3 3,4 5,4 9,4 11,4 16,4 22,4 27,4 29,4 3,5 5,5 9,5 11,5 16,5 22,5 27,5 29,5 3,6 5,6 9,6 11,6 16,6 22,6 27,6 29,6 3,7 5,7 9,7 10,7 11,7 12,7 17,7 23,7 28,7'
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBattleship(elem['input'] as String, false, true);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.encodeGraphicToExcel:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': '', 'expectedOutput': ''},
      {
        'input': ' #   #   #   #     #      ### \n' +
            ' #   #  # #  #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' ##### ##### #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' #   # #   # ##### #####  ### ',
        'expectedOutput':
            'B,1 F,1 J,1 N,1 T,1 AA,1 AB,1 AC,1 B,2 F,2 I,2 K,2 N,2 T,2 Z,2 AD,2 B,3 F,3 H,3 L,3 N,3 T,3 Z,3 AD,3 B,4 C,4 D,4 E,4 F,4 H,4 I,4 J,4 K,4 L,4 N,4 T,4 Z,4 AD,4 B,5 F,5 H,5 L,5 N,5 T,5 Z,5 AD,5 B,6 F,6 H,6 L,6 N,6 T,6 Z,6 AD,6 B,7 F,7 H,7 L,7 N,7 O,7 P,7 Q,7 R,7 T,7 U,7 V,7 W,7 X,7 AA,7 AB,7 AC,7'
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBattleship(elem['input'] as String, false, false);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.decodeNumbers:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': '', 'expectedOutput': 'battleship_error_invalid_pair\n' + '\n' + ''},
      {
        'expectedOutput': '  #            #     #       \n' +
            '  #            #     #       \n' +
            '  ##     ##    #     #     # \n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   ####    #     #    # ',
        'input':
            '3,1 16,1 22,1 3,2 16,2 22,2 3,3 4,3 10,3 11,3 16,3 22,3 28,3 3,4 5,4 9,4 11,4 16,4 22,4 27,4 29,4 3,5 5,5 9,5 11,5 16,5 22,5 27,5 29,5 3,6 5,6 9,6 11,6 16,6 22,6 27,6 29,6 3,7 5,7 9,7 10,7 11,7 12,7 17,7 23,7 28,7'
      },
      {
        'expectedOutput': ' #   #   #   #     #      ### \n' +
            ' #   #  # #  #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' ##### ##### #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' #   # #   # ##### #####  ### ',
        'input':
            '2,1 6,1 10,1 14,1 20,1 27,1 28,1 29,1 2,2 6,2 9,2 11,2 14,2 20,2 26,2 30,2 2,3 6,3 8,3 12,3 14,3 20,3 26,3 30,3 2,4 3,4 4,4 5,4 6,4 8,4 9,4 10,4 11,4 12,4 14,4 20,4 26,4 30,4 2,5 6,5 8,5 12,5 14,5 20,5 26,5 30,5 2,6 6,6 8,6 12,6 14,6 20,6 26,6 30,6 2,7 6,7 8,7 12,7 14,7 15,7 16,7 17,7 18,7 20,7 21,7 22,7 23,7 24,7 27,7 28,7 29,7'
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBattleship(elem['input'] as String, true);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.decodeExcel:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': '', 'expectedOutput': 'battleship_error_invalid_pair\n' + '\n' + ''},
      {
        'expectedOutput': '  #            #     #       \n' +
            '  #            #     #       \n' +
            '  ##     ##    #     #     # \n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   # #    #     #    # #\n' +
            '  # #   ####    #     #    # ',
        'input':
            'C,1 P,1 V,1 C,2 P,2 V,2 C,3 D,3 J,3 K,3 P,3 V,3 AB,3 C,4 E,4 I,4 K,4 P,4 V,4 AA,4 AC,4 C,5 E,5 I,5 K,5 P,5 V,5 AA,5 AC,5 C,6 E,6 I,6 K,6 P,6 V,6 AA,6 AC,6 C,7 E,7 I,7 J,7 K,7 L,7 Q,7 W,7 AB,7'
      },
      {
        'expectedOutput': ' #   #   #   #     #      ### \n' +
            ' #   #  # #  #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' ##### ##### #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' #   # #   # #     #     #   #\n' +
            ' #   # #   # ##### #####  ### ',
        'input':
            'B,1 F,1 J,1 N,1 T,1 AA,1 AB,1 AC,1 B,2 F,2 I,2 K,2 N,2 T,2 Z,2 AD,2 B,3 F,3 H,3 L,3 N,3 T,3 Z,3 AD,3 B,4 C,4 D,4 E,4 F,4 H,4 I,4 J,4 K,4 L,4 N,4 T,4 Z,4 AD,4 B,5 F,5 H,5 L,5 N,5 T,5 Z,5 AD,5 B,6 F,6 H,6 L,6 N,6 T,6 Z,6 AD,6 B,7 F,7 H,7 L,7 N,7 O,7 P,7 Q,7 R,7 T,7 U,7 V,7 W,7 X,7 AA,7 AB,7 AC,7'
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBattleship(elem['input'] as String, false);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}
