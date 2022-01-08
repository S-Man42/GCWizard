import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/utils/common_utils.dart';

class BrainfkDerivate {
  Map<String, String> substitutions;
  final String commandDelimiter;

  BrainfkDerivate(
      {pointerShiftLeftInstruction,
      pointerShiftRightInstruction,
      decreaseValueInstruction,
      increaseValueInstruction,
      startLoopInstruction,
      endLoopInstruction,
      inputInstruction,
      outputInstruction,
      this.commandDelimiter}) {
    substitutions = {
      pointerShiftRightInstruction: '>',
      pointerShiftLeftInstruction: '<',
      increaseValueInstruction: '+',
      decreaseValueInstruction: '-',
      outputInstruction: '.',
      inputInstruction: ',',
      startLoopInstruction: '[',
      endLoopInstruction: ']'
    };
  }

  String _sanitizeCode(String code) {
    var allChars = substitutions.keys.join('').split('').map((e) {
      switch (e) {
        case '[':
        case ']':
        case '.':
        case '+':
        case '-':
          return '\\' + e;
        default: return e;
      }
    }).toSet().join('').toUpperCase();

    return code.toUpperCase().replaceAll(RegExp('[^$allChars]'), '').replaceAll(RegExp(r'\s'), '');
  }

  String interpretBrainfkDerivat(String code, {String input}) {
    if (code == null || code.length == 0) return '';

    var brainfk = '';
    code = _sanitizeCode(code);

    Map<String, String> _sanitizedSubstitutions = {};
    for (MapEntry<String, String> entry in substitutions.entries) {
      _sanitizedSubstitutions.putIfAbsent(entry.key.toUpperCase().replaceAll(RegExp(r'\s'), ''), () => entry.value);
    }

    while (code.length > 0) {
      var chunk = '';
      var i = 0;
      while (_sanitizedSubstitutions[chunk] == null && i < code.length) {
        i++;
        chunk = code.substring(0, min(i, code.length));
      }

      try {
        brainfk += _sanitizedSubstitutions[chunk];
      } catch (e) {} //if there is no fitting substitution, ignore it.

      code = code.substring(min(i, code.length));
    }

    return interpretBrainfk(brainfk, input: input);
  }

  String generateBrainfkDerivat(String text) {
    if (text == null || text.length == 0) return '';

    var brainfk = generateBrainfk(text);
    if (commandDelimiter != null && commandDelimiter.isNotEmpty)
      brainfk = insertEveryNthCharacter(brainfk, 1, commandDelimiter);

    return substitution(brainfk, switchMapKeyValue(substitutions));
  }
}

// https://esolangs.org/wiki/Trivial_brainfuck_substitution

final BrainfkDerivate BRAINFKDERIVATE_OMAM = BrainfkDerivate(
    pointerShiftRightInstruction: 'hold your horses now',
    pointerShiftLeftInstruction: 'sleep until the sun goes down',
    increaseValueInstruction: 'through the woods we ran',
    decreaseValueInstruction: 'deep into the mountain sound',
    outputInstruction: 'don' + "'" + 't listen to a word i say',
    inputInstruction: 'the screams all sound the same',
    startLoopInstruction: '	though the truth may vary',
    endLoopInstruction: 'this ship will carry',
    commandDelimiter: '\n'
);

final BrainfkDerivate BRAINFKDERIVATE_REVOLUTION9 = BrainfkDerivate(
    pointerShiftRightInstruction: 'It' + "'" + 's alright',
    pointerShiftLeftInstruction: 'turn me on, dead man',
    increaseValueInstruction: 'Number 9',
    decreaseValueInstruction: 'if you become naked',
    outputInstruction: 'The Beatles',
    inputInstruction: 'Paul is dead',
    startLoopInstruction: 'Revolution 1',
    endLoopInstruction: 'Revolution 9',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE_DETAILEDFK = BrainfkDerivate(
    pointerShiftRightInstruction: 'MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT',
    pointerShiftLeftInstruction: 'MOVE THE MEMORY POINTER ONE CELL TO THE LEFT',
    increaseValueInstruction: 'INCREMENT THE CELL UNDER THE MEMORY POINTER BY ONE',
    decreaseValueInstruction: 'DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE',
    outputInstruction: 'PRINT THE CELL UNDER THE MEMORY POINTER' + "'" + 'S VALUE AS AN ASCII CHARACTER',
    inputInstruction: 'REPLACE THE CELL UNDER THE MEMORY POINTER' + "'" + 'S VALUE WITH THE ASCII CHARACTER CODE OF USER INPUT',
    startLoopInstruction: 'IF THE CELL UNDER THE MEMORY POINTER' +
        "'" +
        'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK',
    endLoopInstruction: 'IF THE CELL UNDER THE MEMORY POINTER' +
        "'" +
        'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK',
    commandDelimiter: '\n'
);

final BrainfkDerivate BRAINFKDERIVATE_GERMAN = BrainfkDerivate(
    pointerShiftRightInstruction: 'Links',
    pointerShiftLeftInstruction: 'Rechts',
    increaseValueInstruction: 'Addition',
    decreaseValueInstruction: 'Subtraktion',
    outputInstruction: 'Eingabe',
    inputInstruction: 'Ausgabe',
    startLoopInstruction: 'Schleifenanfang',
    endLoopInstruction: 'Schleifenende',
    commandDelimiter: '\n'
);

final BrainfkDerivate BRAINFKDERIVATE_COLONOSCOPY = BrainfkDerivate(
    pointerShiftRightInstruction: ';};',
    pointerShiftLeftInstruction: ';{;',
    increaseValueInstruction: ';;};',
    decreaseValueInstruction: ';;{;',
    outputInstruction: ';;;};',
    inputInstruction: ';;;{;',
    startLoopInstruction: '{{;',
    endLoopInstruction: '}};'
);

final BrainfkDerivate BRAINFKDERIVATE_KONFK = BrainfkDerivate(
    pointerShiftRightInstruction: 'うんうんうん',
    pointerShiftLeftInstruction: 'うんうんたん',
    increaseValueInstruction: 'うんたんうん',
    decreaseValueInstruction: 'うんたんたん',
    outputInstruction: 'たんうんうん',
    inputInstruction: 'たんうんたん',
    startLoopInstruction: 'たんたんうん',
    endLoopInstruction: 'たんたんたん'
);

final BrainfkDerivate BRAINFKDERIVATE_FKBEES = BrainfkDerivate(
    pointerShiftRightInstruction: 'f',
    pointerShiftLeftInstruction: 'u',
    increaseValueInstruction: 'c',
    decreaseValueInstruction: 'k',
    outputInstruction: 'b',
    inputInstruction: 'e',
    startLoopInstruction: 'E',
    endLoopInstruction: 's'
);

final BrainfkDerivate BRAINFKDERIVATE_PSSCRIPT = BrainfkDerivate(
    pointerShiftRightInstruction: '8=D',
    pointerShiftLeftInstruction: '8==D',
    increaseValueInstruction: '8===D',
    decreaseValueInstruction: '8====D',
    outputInstruction: '8=====D',
    inputInstruction: '8======D',
    startLoopInstruction: '8=======D',
    endLoopInstruction: '8========D'
);

final BrainfkDerivate BRAINFKDERIVATE_ALPHK = BrainfkDerivate(
    pointerShiftRightInstruction: 'a',
    pointerShiftLeftInstruction: 'c',
    increaseValueInstruction: 'e',
    decreaseValueInstruction: 'i',
    outputInstruction: 'j',
    inputInstruction: 'o',
    startLoopInstruction: 'p',
    endLoopInstruction: 's'
);

final BrainfkDerivate BRAINFKDERIVATE_REVERSEFK = BrainfkDerivate(
    pointerShiftRightInstruction: '<',
    pointerShiftLeftInstruction: '>',
    increaseValueInstruction: '-',
    decreaseValueInstruction: '+',
    outputInstruction: ',',
    inputInstruction: '.',
    startLoopInstruction: ']',
    endLoopInstruction: '['
);

final BrainfkDerivate BRAINFKDERIVATE_BTJZXGQUARTFRQIFJLV = BrainfkDerivate(pointerShiftRightInstruction: 'f', pointerShiftLeftInstruction: 'rqi', increaseValueInstruction: 'qua', decreaseValueInstruction: 'rtf', outputInstruction: 'lv', inputInstruction: 'j', startLoopInstruction: 'btj', endLoopInstruction: 'zxg');

final BrainfkDerivate BRAINFKDERIVATE_BINARYFK = BrainfkDerivate(pointerShiftRightInstruction: '010', pointerShiftLeftInstruction: '011', increaseValueInstruction: '000', decreaseValueInstruction: '001', outputInstruction: '100', inputInstruction: '101', startLoopInstruction: '110', endLoopInstruction: '111');

final BrainfkDerivate BRAINFKDERIVATE_TERNARY = BrainfkDerivate(pointerShiftRightInstruction: '01', pointerShiftLeftInstruction: '00', increaseValueInstruction: '11', decreaseValueInstruction: '10', outputInstruction: '20', inputInstruction: '21', startLoopInstruction: '02', endLoopInstruction: '12');

final BrainfkDerivate BRAINFKDERIVATE_KENNYSPEAK = BrainfkDerivate(pointerShiftRightInstruction: 'mmp', pointerShiftLeftInstruction: 'mmm', increaseValueInstruction: 'mpp', decreaseValueInstruction: 'pmm', outputInstruction: 'fmm', inputInstruction: 'fpm', startLoopInstruction: 'mmf', endLoopInstruction: 'mpf');

final BrainfkDerivate BRAINFKDERIVATE_MORSEFK = BrainfkDerivate(pointerShiftRightInstruction: '.--', pointerShiftLeftInstruction: '--.', increaseValueInstruction: '..-', decreaseValueInstruction: '-..', outputInstruction: '-.-', inputInstruction: '.-.', startLoopInstruction: '---', endLoopInstruction: '...');

final BrainfkDerivate BRAINFKDERIVATE_BLUB = BrainfkDerivate(
    pointerShiftRightInstruction: 'Blub. Blub?',
    pointerShiftLeftInstruction: 'Blub? Blub.',
    increaseValueInstruction: 'Blub. Blub.',
    decreaseValueInstruction: 'Blub! Blub!',
    outputInstruction: 'Blub! Blub.',
    inputInstruction: 'Blub. Blub!',
    startLoopInstruction: 'Blub! Blub?',
    endLoopInstruction: 'Blub? Blub!',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE_OOK = BrainfkDerivate(
    pointerShiftRightInstruction: 'Ook. Ook?',
    pointerShiftLeftInstruction: 'Ook? Ook.',
    increaseValueInstruction: 'Ook. Ook.',
    decreaseValueInstruction: 'Ook! Ook!',
    outputInstruction: 'Ook! Ook.',
    inputInstruction: 'Ook. Ook!',
    startLoopInstruction: 'Ook! Ook?',
    endLoopInstruction: 'Ook? Ook!',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE_SHORTOOK = BrainfkDerivate(
    pointerShiftRightInstruction: '.?',
    pointerShiftLeftInstruction: '?.',
    increaseValueInstruction: '..',
    decreaseValueInstruction: '!!',
    outputInstruction: '!.',
    inputInstruction: '.!',
    startLoopInstruction: '!?',
    endLoopInstruction: '?!'
);

final BrainfkDerivate BRAINFKDERIVATE_NAK = BrainfkDerivate(
    pointerShiftRightInstruction: 'Nak. Nak?',
    pointerShiftLeftInstruction: 'Nak? Nak.',
    increaseValueInstruction: 'Nak. Nak.',
    decreaseValueInstruction: 'Nak! Nak!',
    outputInstruction: 'Nak! Nak.',
    inputInstruction: 'Nak. Nak!',
    startLoopInstruction: 'Nak! Nak?',
    endLoopInstruction: 'Nak? Nak!',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE_PIKALANG = BrainfkDerivate(
    pointerShiftRightInstruction: 'pipi',
    pointerShiftLeftInstruction: 'pichu',
    increaseValueInstruction: 'pi',
    decreaseValueInstruction: 'ka',
    outputInstruction: 'pikachu',
    inputInstruction: 'pikapi',
    startLoopInstruction: 'pika',
    endLoopInstruction: 'chu',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE_PEWLANG = BrainfkDerivate(
    pointerShiftRightInstruction: 'pew',
    pointerShiftLeftInstruction: 'Pew',
    increaseValueInstruction: 'pEw',
    decreaseValueInstruction: 'peW',
    outputInstruction: 'PEw',
    inputInstruction: 'pEW',
    startLoopInstruction: 'PeW',
    endLoopInstruction: 'PEW',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE_ROADRUNNER = BrainfkDerivate(
    pointerShiftRightInstruction: 'meeP',
    pointerShiftLeftInstruction: 'Meep',
    increaseValueInstruction: 'mEEp',
    decreaseValueInstruction: 'MeeP',
    outputInstruction: 'MEEP',
    inputInstruction: 'meep',
    startLoopInstruction: 'mEEP',
    endLoopInstruction: 'MEEp',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE_ZZZ = BrainfkDerivate(pointerShiftRightInstruction: 'zz', pointerShiftLeftInstruction: '-zz', increaseValueInstruction: 'z', decreaseValueInstruction: '-z', outputInstruction: 'zzz', inputInstruction: '-zzz', startLoopInstruction: 'z+z', endLoopInstruction: 'z-z');

final BrainfkDerivate BRAINFKDERIVATE_SCREAMCODE = BrainfkDerivate(
    pointerShiftRightInstruction: 'AAAH',
    pointerShiftLeftInstruction: 'AAAAGH',
    increaseValueInstruction: 'F*CK',
    decreaseValueInstruction: 'SHIT',
    outputInstruction: '!!!!!!',
    inputInstruction: 'WHAT?',
    startLoopInstruction: 'OW',
    endLoopInstruction: 'OWIE',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE_FLUFFLEPUFF = BrainfkDerivate(pointerShiftRightInstruction: 'b', pointerShiftLeftInstruction: 't', increaseValueInstruction: 'pf', decreaseValueInstruction: 'bl', outputInstruction: '!', inputInstruction: '?', startLoopInstruction: '*gasp*', endLoopInstruction: '*pomf*');

final BrainfkDerivate BRAINFKDERIVATE_TRIPLET = BrainfkDerivate(pointerShiftRightInstruction: '001', pointerShiftLeftInstruction: '100', increaseValueInstruction: '111', decreaseValueInstruction: '000', outputInstruction: '010', inputInstruction: '101', startLoopInstruction: '110', endLoopInstruction: '011');

final BrainfkDerivate BRAINFKDERIVATE_UWU = BrainfkDerivate(
    pointerShiftRightInstruction: 'OwO',
    pointerShiftLeftInstruction: '°w°',
    increaseValueInstruction: 'UwU',
    decreaseValueInstruction: 'QwQ',
    outputInstruction: '@w@',
    inputInstruction: '>w<',
    startLoopInstruction: '~w~',
    endLoopInstruction: '-w-',
    commandDelimiter: ' '
);

final BrainfkDerivate BRAINFKDERIVATE___FK = BrainfkDerivate(pointerShiftRightInstruction: '!!!!!#', pointerShiftLeftInstruction: '!!!!!!#', increaseValueInstruction: '!!!!!!!#', decreaseValueInstruction: '!!!!!!!!#', outputInstruction: '!!!!!!!!!!#', inputInstruction: '!!!!!!!!!#', startLoopInstruction: '!!!!!!!!!!!#', endLoopInstruction: '!!!!!!!!!!!!#');

final BrainfkDerivate BRAINFKDERIVATE_CUSTOM = BrainfkDerivate(pointerShiftRightInstruction: '', pointerShiftLeftInstruction: '', increaseValueInstruction: '', decreaseValueInstruction: '', outputInstruction: '', inputInstruction: '', startLoopInstruction: '', endLoopInstruction: '');

final Map<BrainfkDerivate, String> BRAINFK_DERIVATES = {
  BRAINFKDERIVATE___FK: '!!F**k',
  BRAINFKDERIVATE_ALPHK: 'Alph**k',
  BRAINFKDERIVATE_BINARYFK: 'BinaryFuck',
  BRAINFKDERIVATE_BLUB: 'Blub',
  BRAINFKDERIVATE_BTJZXGQUARTFRQIFJLV: 'Btjzxgquartfrqifjlv',
  BRAINFKDERIVATE_COLONOSCOPY: 'Colonoscopy',
  BRAINFKDERIVATE_DETAILEDFK: 'DetailedF**k',
  BRAINFKDERIVATE_FLUFFLEPUFF: 'Fluffle Puff',
  BRAINFKDERIVATE_FKBEES: 'f**kbeEs',
  BRAINFKDERIVATE_GERMAN: 'GERMAN',
  BRAINFKDERIVATE_KENNYSPEAK: 'Kenny Speak',
  BRAINFKDERIVATE_KONFK: 'K-on F**k',
  BRAINFKDERIVATE_MORSEFK: 'MorseF**k',
  BRAINFKDERIVATE_NAK: 'Nak',
  BRAINFKDERIVATE_OMAM: 'Omam',
  BRAINFKDERIVATE_OOK: 'Ook',
  BRAINFKDERIVATE_PSSCRIPT: 'P***sScript',
  BRAINFKDERIVATE_PEWLANG: 'PewLang',
  BRAINFKDERIVATE_PIKALANG: 'PikaLang',
  BRAINFKDERIVATE_REVERSEFK: 'ReverseF**k',
  BRAINFKDERIVATE_REVOLUTION9: 'Revolution 9',
  BRAINFKDERIVATE_ROADRUNNER: 'Roadrunner',
  BRAINFKDERIVATE_SCREAMCODE: 'ScreamCode',
  BRAINFKDERIVATE_SHORTOOK: 'Short Ook',
  BRAINFKDERIVATE_TERNARY: 'Ternary',
  BRAINFKDERIVATE_TRIPLET: 'Triplet',
  BRAINFKDERIVATE_UWU: 'UwU',
  BRAINFKDERIVATE_ZZZ: 'ZZZ',
  BRAINFKDERIVATE_CUSTOM: 'Custom',
};
