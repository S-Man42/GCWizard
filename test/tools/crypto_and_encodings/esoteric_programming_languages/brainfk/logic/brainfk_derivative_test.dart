import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/logic/brainfk_derivative.dart';

void main() {
  group("GC8PXAD", () {
    String brainfck =    "++++++++++[>+>+++>+++++++>++++++++++<<<<-]>>>++++++++.<++.++++++++++++++++++++.++++.+++++++.-----------.----.--.++.++++++.++.-----------------.-------.>---------.--------------.++++++++.----------.-----.--.++++.++..";
    String result =      "N 48?40.068' E7?50.244";
    //https://esolangs.org/wiki/Trivial_brainfuck_substitution
    String pikaLang =    "pi pi pi pi pi pi pi pi pi pi pika pipi pi pipi pi pi pi pipi pi pi pi pi pi pi pi pipi pi pi pi pi pi pi pi pi pi pi pichu pichu pichu pichu ka chu pipi pipi pipi pi pi pi pi pi pi pi pi pikachu pichu pi pi pikachu pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pikachu pi pi pi pi pikachu pi pi pi pi pi pi pi pikachu ka ka ka ka ka ka ka ka ka ka ka pikachu ka ka ka ka pikachu ka ka pikachu pi pi pikachu pi pi pi pi pi pi pikachu pi pi pikachu ka ka ka ka ka ka ka ka ka ka ka ka ka ka ka ka ka pikachu ka ka ka ka ka ka ka pikachu pipi ka ka ka ka ka ka ka ka ka pikachu ka ka ka ka ka ka ka ka ka ka ka ka ka ka pikachu pi pi pi pi pi pi pi pi pikachu ka ka ka ka ka ka ka ka ka ka pikachu ka ka ka ka ka pikachu ka ka pikachu pi pi pi pi pikachu pi pi pikachu pikachu";
    String AAA =         brainfck.replaceAll('+', 'AAAA').replaceAll('[', 'aaAA').replaceAll('>', 'aAaA').replaceAll('<', 'AAaa').replaceAll('-', 'AaAa').replaceAll(']', 'aaaA').replaceAll('.', 'aaaa');
    String Blub =        brainfck.replaceAll('>', 'Blub. Blub?').replaceAll('<', 'Blub? Blub.').replaceAll('+', 'Blub. Blub.').replaceAll('-', 'Blub! Blub!').replaceAll('.', 'Blub! Blub.').replaceAll('[', 'Blub! Blub?').replaceAll(']', 'Blub? Blub!');
    String Colonoscopy = brainfck.replaceAll('>', ';};').replaceAll('<', ';{;').replaceAll('+', ';;};').replaceAll('-', ';;{;').replaceAll('.', ';;;};').replaceAll('[', '"{{;').replaceAll(']', '}};');
    String fuckbeEs =    brainfck.replaceAll('>', 'f').replaceAll('<', 'u').replaceAll('+', 'c').replaceAll('-', 'k').replaceAll('.', 'b').replaceAll('[', 'E').replaceAll(']', 's');
    String Morsefuck =   brainfck.replaceAll('>', '.--').replaceAll('<', '--.').replaceAll('+', '..-').replaceAll('-', '-..').replaceAll('.', '-.-').replaceAll('[', '---').replaceAll(']', '...');
    String Ook =         brainfck.replaceAll('>', 'Ook. Ook?').replaceAll('<', 'Ook? Ook.').replaceAll('+', 'Ook. Ook.').replaceAll('-', 'Ook! Ook!').replaceAll('.', 'Ook! Ook.').replaceAll('[', 'Ook! Ook?').replaceAll(']', 'Ook? Ook!');
    String Pewlang =     brainfck.replaceAll('>', 'pew').replaceAll('<', 'Pew').replaceAll('+', 'pEw').replaceAll('-', 'peW').replaceAll('.', 'PEw').replaceAll('[', 'PeW').replaceAll(']', 'PEW');
    String Roadrunner =  brainfck.replaceAll('>', 'meeP').replaceAll('<', 'Meep').replaceAll('+', 'mEEp').replaceAll('-', 'MeeP').replaceAll('.', 'MEEP').replaceAll('[', 'mEEP').replaceAll(']', 'MEEp');
    String ZZZ =         brainfck.replaceAll('>', 'zz').replaceAll('<', '-zz').replaceAll('+', 'z').replaceAll('-', '-z').replaceAll('.', 'zzz').replaceAll('[', 'z+z').replaceAll(']', 'z-z');
    String Fuck =        brainfck.replaceAll('>', '!!!!!#').replaceAll('<', '!!!!!!#').replaceAll('+', '!!!!!!!#').replaceAll('-', '!!!!!!!!#').replaceAll('.', '!!!!!!!!!!#').replaceAll('[', '!!!!!!!!!!!#').replaceAll(']', '!!!!!!!!!!!!#');
    String Kenny =       brainfck.replaceAll('>', 'mmp').replaceAll('<', 'mmm').replaceAll('+', 'mpp').replaceAll('-', 'pmm').replaceAll('.', 'fmm').replaceAll('[', 'mmf').replaceAll(']', 'mpf');
    String Nak =         brainfck.replaceAll('>', 'Nak. Nak?').replaceAll('<', 'Nak? Nak.').replaceAll('+', 'Nak. Nak.').replaceAll('-', 'Nak! Nak!').replaceAll('.', 'Nak! Nak.').replaceAll('[', 'Nak! Nak?').replaceAll(']', 'Nak? Nak!');

    List<Map<String, Object?>> _inputsToExpected = [
      {'derivat': 'brainfck', 'code' : brainfck, 'expectedOutput' : result},
      {'derivat': 'pikaLang', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'AAA', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Blub', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Colonoscopy', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'fuckbeEs', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Morsefuck', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Ook', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Pewlang', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Roadrunner', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'ZZZ', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Fuck', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Nak', 'code' : pikaLang, 'expectedOutput' : result},
      {'derivat': 'Kenny', 'code' : pikaLang, 'expectedOutput' : result},

    ];

    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}', () {
        switch (elem['derivat']) {
          case 'pikaLang':
            var _actual = BRAINFKDERIVATIVE_PIKALANG.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'AAA':
            var _actual = BRAINFKDERIVATIVE_BLUB.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Blub':
            var _actual = BRAINFKDERIVATIVE_BLUB.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Colonoscopy':
            var _actual = BRAINFKDERIVATIVE_COLONOSCOPY.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'fuckbeEs':
            var _actual = BRAINFKDERIVATIVE_FKBEES.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Morsefuck':
            var _actual = BRAINFKDERIVATIVE_MORSEFK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Ook':
            var _actual = BRAINFKDERIVATIVE_OOK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Pewlang':
            var _actual = BRAINFKDERIVATIVE_PEWLANG.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Roadrunner':
            var _actual = BRAINFKDERIVATIVE_ROADRUNNER.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'ZZZ':
            var _actual = BRAINFKDERIVATIVE_ZZZ.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Fuck':
            var _actual = BRAINFKDERIVATIVE___FK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Nak':
            var _actual = BRAINFKDERIVATIVE_NAK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Kenny':
            var _actual = BRAINFKDERIVATIVE_KENNYSPEAK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
        }
      });
    }
  });

  group("Ook.interpretOok:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'code' : '', 'expectedOutput' : ''},

      {'code' : '.', 'input': 'ABC123', 'expectedOutput' : ''}, // error case: no fitting subsitution
      //Input copy
      {'code' : 'Ook. Ook! Ook! Ook? Ook! Ook. Ook. Ook! Ook? Ook!', 'input': 'ABC123', 'expectedOutput' : 'ABC123'},
      {'code' : 'ook.Ook!Ook!OOK? Ook!Ook. Ook. ook!pok? Ook!', 'input': 'ABC123', 'expectedOutput' : 'ABC123'},
      {'code' : 'Ook. Ook! Ook! Ook? Ook! Ook. Ook. Ook! Ook?', 'input': 'ABC123', 'expectedOutput' : 'A'}, // error case: no fitting subsitution

      {'code' : 'Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip? Yip. Yip? Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip! Yip. Yip? Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip. Yip? Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip? Yip. Yip? Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip.'
          ' Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip? Yip. Yip? Yip! Yip. Yip? Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip! Yip. Yip? Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip?'
          ' Yip! Yip! Yip. Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip! Yip? Yip. Yip? Yip! Yip. Yip? Yip! Yip! Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip?'
          ' Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip? Yip. Yip? Yip! Yip. Yip? Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip!'
          ' Yip? Yip! Yip! Yip. Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip? Yip. Yip? Yip!'
          ' Yip. Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip! Yip! Yip! Yip! Yip!'
          ' Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip. Yip? Yip! Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip? Yip.'
          ' Yip? Yip! Yip. Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip!'
          ' Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip? Yip. Yip? Yip!'
          ' Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip! Yip. Yip. Yip. Yip. Yip. Yip! Yip. Yip! Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip. Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip!'
          'Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip? Yip.', 'input': '', 'expectedOutput' : 'free the prof'},

        {'code': 'Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook! Ook! Ook! Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook! Ook.',
          'input': '', 'expectedOutput': 'abc123'}
    ];

    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = BRAINFKDERIVATIVE_SHORTOOK.interpretBrainfkDerivatives(elem['code'] as String, input: elem['input'] as String?);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Ook.generateOok:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'text' : '', 'expectedOutput' : ''},

      //Input copy
      {'text' : 'Verrückt!', 'expectedOutput' : 'Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook. Ook. Ook! Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook! Ook! Ook! Ook! Ook.'},
    ];

    for (var elem in _inputsToExpected) {
      test('text: ${elem['text']}', () {
        var _actual = BRAINFKDERIVATIVE_OOK.generateBrainfkDerivative(elem['text'] as String);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("BrainfkDerivat.interpretDetailedFk:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'code' : "INCREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK\n" +
        "INCREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "IF THE CELL UNDER THE MEMORY POINTER'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "INCREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER\n" +
        "MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n" +
        "DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
        "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER", 'input': '', 'expectedOutput' : 'hello world'},
    ];

    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = BRAINFKDERIVATIVE_DETAILEDFK.interpretBrainfkDerivatives(elem['code'] as String, input: elem['input'] as String);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}