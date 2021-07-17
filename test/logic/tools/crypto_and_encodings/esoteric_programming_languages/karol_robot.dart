import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/karol_robot.dart';

void main() {
  group("KarolRobot.interpret:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'code' : null, 'expectedOutput' : ''},
      {'code' : '', 'expectedOutput' : ''},
      // https://www.geocaching.com/geocache/GC4ZE0V_sauerbrunnen-ii
      {'code' : 'Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Linksdrehen Linksdrehen Schritt Schritt Schritt Schritt Schritt Rechtsdrehen Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Linksdrehen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Schritt Linksdrehen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Schritt Schritt Schritt Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Linksdrehen Schritt Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Schritt Linksdrehen Schritt Rechtsdrehen Schritt Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Linksdrehen Linksdrehen Schritt Schritt Rechtsdrehen Schritt Schritt Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Linksdrehen Schritt Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Schritt Linksdrehen Schritt Schritt Schritt Hinlegen Schritt Rechtsdrehen Schritt Linksdrehen Hinlegen Schritt Rechtsdrehen Schritt Linksdrehen Hinlegen Schritt Rechtsdrehen Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Hinlegen Schritt Schritt Linksdrehen Schritt Schritt Schritt Schritt Schritt Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Schritt Schritt Schritt Schritt Schritt Schritt Schritt Rechtsdrehen Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Schritt Linksdrehen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Schritt Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Schritt Rechtsdrehen Schritt Schritt Schritt Schritt Schritt Schritt Linksdrehen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Schritt Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Schritt Schritt Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Schritt Linksdrehen Schritt Schritt Schritt Linksdrehen Schritt Rechtsdrehen Schritt Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Linksdrehen Linksdrehen Schritt Schritt Rechtsdrehen Schritt Schritt Schritt Rechtsdrehen Schritt Schritt Schritt Schritt Schritt Schritt Linksdrehen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Schritt Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Schritt Schritt Schritt Schritt Linksdrehen Schritt Schritt Schritt Linksdrehen Schritt Hinlegen Schritt Hinlegen Linksdrehen Linksdrehen Schritt Schritt Rechtsdrehen Schritt Schritt Schritt Linksdrehen Hinlegen Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Rechtsdrehen Schritt Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Linksdrehen Schritt Schritt Schritt Schritt Schritt Linksdrehen Schritt Schritt Schritt Linksdrehen Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Linksdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen Schritt Rechtsdrehen Hinlegen Schritt Hinlegen Schritt Hinlegen',
        'expectedOutput' :
            '00000000000000000000000000000000000000000000000000\n'
            '00000000000000000000000000000000000000000000000000\n'
            '88008000080080088880888080080000800088880888808888\n'
            '88008000080080080080808080080008800000080800808000\n'
            '80808000080080080080888080080080800000080800808000\n'
            '80808000088888088880000088888000800088880800808888\n'
            '80808000000080000080000000080000800080000800800008\n'
            '80088000000080000080000000080000800080000800800008\n'
            '80088000000080088880000000080000808088880888808888\n'
            '00000000000000000000000000000000000000000000000000\n'
            '00000000000000000000000000000000000000000000000000\n'
            '88880888808888088880888088880888800088880888808888\n'
            '80000800808008000080808080080800800080000000808000\n'
            '80000800808008000800888080080800800080000000808000\n'
            '88800800808008000800000080080888800088880088808888\n'
            '80000800808008008000000080080800800000080000808008\n'
            '80000800808008008000000080080800800000080000808008\n'
            '88880888808888008000000088880888808088880888808888\n'
            ''},
      // generated
      {'code' : 'schritt(2) linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(3) rechtsdrehen schritt(3) markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen linksdrehen schritt schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt markesetzen schritt schritt markesetzen rechtsdrehen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(2) linksdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt(3) rechtsdrehen schritt(3) rechtsdrehen schritt(2) linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen  schritt rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(4) markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(2) markesetzen schritt markesetzen rechtsdrehen schritt(3) rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt(3) linksdrehen schritt linksdrehen linksdrehen rechtsdrehen schritt(35) linksdrehen schritt(9)',
        'expectedOutput' :
            '000000000000000000000000000000000000\n'
            '099900000900000999000900090099999000\n'
            '900090009090009000900900090090000000\n'
            '900000090009009000000900090090000000\n'
            '900000099999009000000999990099900000\n'
            '900000090009009000000900090090000000\n'
            '900090090009009000900900090090000000\n'
            '099900090009000999000900090099999000\n'
            '000000000000000000000000000000000000\n'
            '000000000000000000000000000000000000\n'
      },
      {'code' : 'move(2) turnleft move(4) putbeeper turnleft move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move(6) turnright move(3) turnright move(3) putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move(3) turnright move putbeeper turnleft move move putbeeper turnright move turnleft move putbeeper turnright move turnright move putbeeper move move putbeeper turnright move putbeeper turnleft move(3) turnleft move(2) turnleft putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move(3) turnright move(3) turnright move(2) turnleft move(4) putbeeper turnleft move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move(6) turnright move(3) turnright move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move(3) turnright move putbeeper move putbeeper move putbeeper  move turnright putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move(4) putbeeper move putbeeper move putbeeper move turnright move(3) turnright move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnleft move putbeeper move putbeeper move putbeeper move putbeeper turnleft move(3) turnleft move(2) putbeeper move putbeeper turnright move(3) turnright putbeeper move putbeeper move putbeeper move putbeeper move(3) turnleft move turnleft turnleft turnright move(35) turnleft move(9)',
        'expectedOutput' :
            '000000000000000000000000000000000000\n'
            '099900000900000999000900090099999000\n'
            '900090009090009000900900090090000000\n'
            '900000090009009000000900090090000000\n'
            '900000099999009000000999990099900000\n'
            '900000090009009000000900090090000000\n'
            '900090090009009000900900090090000000\n'
            '099900090009000999000900090099999000\n'
            '000000000000000000000000000000000000\n'
            '000000000000000000000000000000000000\n'
      },
      {'code' : 'move move turnleft move move move move putbeeper turnleft move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move move move move move move turnright move move move turnright move move move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move move move turnright move putbeeper turnleft move move putbeeper turnright move turnleft move putbeeper turnright move turnright move putbeeper move move putbeeper turnright move putbeeper turnleft move move move turnleft move move turnleft putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move move move turnright move move move turnright move move turnleft move move move move putbeeper turnleft move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move move move turnright move move move turnright move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move move move turnright move putbeeper move putbeeper move putbeeper  move turnright putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move move move putbeeper move putbeeper move putbeeper move turnright move move move turnright move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnleft move putbeeper move putbeeper move putbeeper move putbeeper turnleft move(3) turnleft move move move putbeeper move putbeeper turnright move move move turnright putbeeper move putbeeper move putbeeper move putbeeper move move move turnleft move turnleft turnleft turnright move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move turnleft move move move move move move move move move',
        'expectedOutput' :
            '000000000000000000000000000000000000\n'
            '099900000900000999000900090099999000\n'
            '900090009090009000900900090090000000\n'
            '900000090009009000000900090090000000\n'
            '900000099999009000000999990099900000\n'
            '900000090009009000000900090090000000\n'
            '900090090009009000900900090090000000\n'
            '099900090009000999000900090099999000\n'
            '000000000000000000000000000000000000\n'
            '000000000000000000000000000000000000\n'
      },

      // showing all colors
      {'code' : 'hinlegen(schwarz) schritt hinlegen(weiss) schritt hinlegen(hellrot) schritt hinlegen(hellgelb) schritt hinlegen(hellgrün) schritt hinlegen(hellcyan) schritt hinlegen(hellblau) schritt hinlegen(hellmagenta) schritt hinlegen(rot) schritt hinlegen(gelb) schritt hinlegen(blau) schritt hinlegen(grün) schritt hinlegen(cyan) schritt hinlegen(magenta) schritt hinlegen(dunkelrot) schritt hinlegen(dunkelgelb) schritt hinlegen(dunkelgrün) schritt hinlegen(dunkelcyan) schritt hinlegen(dunkelblau) schritt hinlegen(dunkelmagenta) schritt hinlegen(orange) schritt hinlegen(hellorange) schritt hinlegen(dunkelorange) schritt hinlegen(braun) schritt hinlegen(dunkelbraun)',
        'expectedOutput' :
            '1\n'
            '0\n'
            '2\n'
            '3\n'
            '4\n'
            '5\n'
            '6\n'
            '7\n'
            '8\n'
            '9\n'
            'A\n'
            'B\n'
            'C\n'
            'D\n'
            'E\n'
            'F\n'
            'G\n'
            'H\n'
            'I\n'
            'J\n'
            'K\n'
            'L\n'
            'M\n'
            'N\n'
            'O\n'},
    ];

    _inputsToExpected.forEach((elem) {
      test('code: ${elem['code']}', () {
        var _actual = KarolRobotOutputDecode(elem['code']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("KarolRobot.generate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'language' : KAREL_LANGUAGES.DEU, 'text' : null, 'expectedOutput' : ''},
      {'language' : KAREL_LANGUAGES.ENG, 'text' : null, 'expectedOutput' : ''},
      {'language' : KAREL_LANGUAGES.DEU, 'text' : '', 'expectedOutput' : ''},
      {'language' : KAREL_LANGUAGES.ENG, 'text' : '', 'expectedOutput' : ''},
      {'language' : KAREL_LANGUAGES.DEU, 'text' : 'cache', 'expectedOutput' : 'schritt(2) linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(3) rechtsdrehen schritt(3) markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen linksdrehen schritt schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt markesetzen schritt schritt markesetzen rechtsdrehen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(2) linksdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt(3) rechtsdrehen schritt(3) rechtsdrehen schritt(2) linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen  schritt rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(4) markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(2) markesetzen schritt markesetzen rechtsdrehen schritt(3) rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt(3) linksdrehen schritt linksdrehen linksdrehen rechtsdrehen schritt(35) linksdrehen schritt(9) '},
      {'language' : KAREL_LANGUAGES.ENG, 'text' : 'cache', 'expectedOutput' : 'move move turnleft move move move move putbeeper turnleft move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move move move move move move turnright move move move turnright move move move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move move move turnright move putbeeper turnleft move move putbeeper turnright move turnleft move putbeeper turnright move turnright move putbeeper move move putbeeper turnright move putbeeper turnleft move move move turnleft move move turnleft putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move move move turnright move move move turnright move move turnleft move move move move putbeeper turnleft move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move putbeeper move putbeeper move turnleft move putbeeper move move move move move move turnright move move move turnright move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move move move turnright move putbeeper move putbeeper move putbeeper  move turnright putbeeper move putbeeper move putbeeper move putbeeper turnright turnright move move move move putbeeper move putbeeper move putbeeper move turnright move move move turnright move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper move putbeeper turnleft move putbeeper move putbeeper move putbeeper move putbeeper turnleft move move move turnleft move move putbeeper move putbeeper turnright move move move turnright putbeeper move putbeeper move putbeeper move putbeeper move move move turnleft move turnleft turnleft turnright move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move move turnleft move move move move move move move move move '},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = KarolRobotOutputEncode(elem['text'], elem['language']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}