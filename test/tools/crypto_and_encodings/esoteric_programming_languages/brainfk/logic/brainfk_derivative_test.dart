import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/logic/brainfk_derivative.dart';

void main() {
  group("test conversion with GC8PXAD", () {
    String brainfck =
        "++++++++++[>+>+++>+++++++>++++++++++<<<<-]>>>++++++++.<++.++++++++++++++++++++.++++.+++++++.-----------.----.--.++.++++++.++.-----------------.-------.>---------.--------------.++++++++.----------.-----.--.++++.++..";
    String result = "N 48?40.068' E7?50.244";
    //https://esolangs.org/wiki/Trivial_brainfuck_substitution
    String Pewlang = brainfck
        .replaceAll('>', 'pew ')
        .replaceAll('<', 'Pew ')
        .replaceAll('+', 'pEw ')
        .replaceAll('-', 'peW ')
        .replaceAll('.', 'PEw ')
        .replaceAll('[', 'PeW ')
        .replaceAll(']', 'PEW ');
    String Roadrunner = brainfck
        .replaceAll('>', 'meeP ')
        .replaceAll('<', 'Meep ')
        .replaceAll('+', 'mEEp ')
        .replaceAll('-', 'MeeP ')
        .replaceAll('.', 'MEEP ')
        .replaceAll('[', 'mEEP ')
        .replaceAll(']', 'MEEp ');
    String Kenny = brainfck
        .replaceAll('>', 'mmp ')
        .replaceAll('<', 'mmm ')
        .replaceAll('+', 'mpp ')
        .replaceAll('-', 'pmm ')
        .replaceAll('.', 'fmm ')
        .replaceAll('[', 'mmf ')
        .replaceAll(']', 'mpf ');
    String pikaLang =
        "pi pi pi pi pi pi pi pi pi pi pika pipi pi pipi pi pi pi pipi pi pi pi pi pi pi pi pipi pi pi pi pi pi pi pi pi pi pi pichu pichu pichu pichu ka chu pipi pipi pipi pi pi pi pi pi pi pi pi pikachu pichu pi pi pikachu pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pi pikachu pi pi pi pi pikachu pi pi pi pi pi pi pi pikachu ka ka ka ka ka ka ka ka ka ka ka pikachu ka ka ka ka pikachu ka ka pikachu pi pi pikachu pi pi pi pi pi pi pikachu pi pi pikachu ka ka ka ka ka ka ka ka ka ka ka ka ka ka ka ka ka pikachu ka ka ka ka ka ka ka pikachu pipi ka ka ka ka ka ka ka ka ka pikachu ka ka ka ka ka ka ka ka ka ka ka ka ka ka pikachu pi pi pi pi pi pi pi pi pikachu ka ka ka ka ka ka ka ka ka ka pikachu ka ka ka ka ka pikachu ka ka pikachu pi pi pi pi pikachu pi pi pikachu pikachu";
    String AAA = brainfck
        .replaceAll('>', 'aAaA ')
        .replaceAll('<', 'AAaa ')
        .replaceAll('+', 'AAAA ')
        .replaceAll('-', 'AaAa ')
        .replaceAll('.', 'aaaa ')
        .replaceAll('[', 'aaAA ')
        .replaceAll(']', 'aaaA ');
    String Colonoscopy = brainfck
        .replaceAll('>', ';}; ')
        .replaceAll('<', ';{; ')
        .replaceAll('+', ';;}; ')
        .replaceAll('-', ';;{; ')
        .replaceAll('.', ';;;}; ')
        .replaceAll('[', '{{; ')
        .replaceAll(']', '}}; ');
    String fuckbeEs = brainfck
        .replaceAll('>', 'f ')
        .replaceAll('<', 'u ')
        .replaceAll('+', 'c ')
        .replaceAll('-', 'k ')
        .replaceAll('.', 'b ')
        .replaceAll('[', 'E ')
        .replaceAll(']', 's ');
    String ZZZ = brainfck
        .replaceAll('-', '-z ')
        .replaceAll('>', 'zz ')
        .replaceAll('<', '-zz ')
        .replaceAll('+', 'z ')
        .replaceAll('.', 'zzz ')
        .replaceAll('[', 'z+z ')
        .replaceAll(']', 'z-z ');
    String Fuck = brainfck
        .replaceAll('>', '!!!!!# ')
        .replaceAll('<', '!!!!!!# ')
        .replaceAll('+', '!!!!!!!# ')
        .replaceAll('-', '!!!!!!!!# ')
        .replaceAll('.', '!!!!!!!!!!# ')
        .replaceAll('[', '!!!!!!!!!!!# ')
        .replaceAll(']', '!!!!!!!!!!!!# ');
    String Morsefuck = brainfck
        .replaceAll('-', '-xx ')
        .replaceAll('.', '-x- ')
        .replaceAll('>', 'x-- ')
        .replaceAll('<', '--x ')
        .replaceAll('+', 'xx- ')
        .replaceAll('[', '--- ')
        .replaceAll(']', 'xxx ')
        .replaceAll('x', '.');
    String Nak =
        "Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak! Nak? Nak. Nak? +Nak. Nak? Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak? Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak? Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak? Nak. Nak? Nak. Nak? Nak. Nak? Nak. Nak! Nak! Nak? Nak! Nak. Nak? Nak. Nak? Nak. Nak? Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak? Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak. Nak. Nak? Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak! Nak. Nak! Nak! Nak! Nak! Nak! Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak. Nak. Nak. Nak. Nak! Nak. Nak! Nak.";
    String Ook =
        "Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? +Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook? Ook. Ook? Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook. Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook. Ook? Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook! Ook! Ook! Ook! Ook! Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook! Ook. ";
    String Blub =
        "Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub! Blub? Blub. Blub? +Blub. Blub? Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub? Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub? Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub? Blub. Blub? Blub. Blub? Blub. Blub? Blub. Blub! Blub! Blub? Blub! Blub. Blub? Blub. Blub? Blub. Blub? Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub? Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub. Blub. Blub? Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub! Blub. Blub! Blub! Blub! Blub! Blub! Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub. Blub. Blub. Blub. Blub! Blub. Blub! Blub. ";
    String Triplet = brainfck
        .replaceAll('>', '001 ')
        .replaceAll('<', '100 ')
        .replaceAll('+', '111 ')
        .replaceAll('-', '000 ')
        .replaceAll('.', '010 ')
        .replaceAll('[', '110 ')
        .replaceAll(']', '011 ');
    String Ternary = brainfck
        .replaceAll('>', '01 ')
        .replaceAll('<', '00 ')
        .replaceAll('+', '11 ')
        .replaceAll('-', '10 ')
        .replaceAll('.', '20 ')
        .replaceAll('[', '02 ')
        .replaceAll(']', '12 ');
    String BinaryFk = brainfck
        .replaceAll('>', '010 ')
        .replaceAll('<', '011 ')
        .replaceAll('+', '000 ')
        .replaceAll('-', '001 ')
        .replaceAll('.', '100 ')
        .replaceAll('[', '110 ')
        .replaceAll(']', '111 ');
    String Screamcode = brainfck
        .replaceAll('>', 'AAAH ')
        .replaceAll('<', 'AAAAGH ')
        .replaceAll('+', 'F*CK ')
        .replaceAll('-', 'SHIT ')
        .replaceAll('.', '!!!!!! ')
        .replaceAll('[', 'OW ')
        .replaceAll(']', 'OWIE ');
    String FlufflPuff = brainfck
        .replaceAll('>', 'b ')
        .replaceAll('<', 't ')
        .replaceAll('+', 'pf ')
        .replaceAll('-', 'bl ')
        .replaceAll('.', '! ')
        .replaceAll('[', '*gasp* ')
        .replaceAll(']', '*pomf* ');
    String UWU = brainfck
        .replaceAll('>', 'OwO ')
        .replaceAll('<', '°w° ')
        .replaceAll('+', 'UwU ')
        .replaceAll('-', 'QwQ ')
        .replaceAll('.', '@w@ ')
        .replaceAll('[', '~w~ ')
        .replaceAll(']', '-w- ');
    String ShortOOK = brainfck
        .replaceAll('>', 'x? ')
        .replaceAll('<', '?x ')
        .replaceAll('+', 'xx ')
        .replaceAll('-', '!! ')
        .replaceAll('.', '!. ')
        .replaceAll('[', '!? ')
        .replaceAll(']', '?! ')
        .replaceAll('x', '.');
    String frqiquartf = brainfck
        .replaceAll('>', 'f ')
        .replaceAll('<', 'rqi ')
        .replaceAll('+', 'qua ')
        .replaceAll('-', 'rtf ')
        .replaceAll('.', 'lv ')
        .replaceAll('[', 'btj ')
        .replaceAll(']', 'zxg ');
    String alphk = brainfck
        .replaceAll('>', 'a ')
        .replaceAll('<', 'c ')
        .replaceAll('+', 'e ')
        .replaceAll('-', 'i ')
        .replaceAll('.', 'j ')
        .replaceAll('[', 'p ')
        .replaceAll(']', 's ');
    String pscript = brainfck
        .replaceAll('>', '8=D ')
        .replaceAll('<', '8==D ')
        .replaceAll('+', '8===D ')
        .replaceAll('-', '8====D ')
        .replaceAll('.', '8=====D ')
        .replaceAll('[', '8=======D ')
        .replaceAll(']', '8========D ');
    String omam = brainfck
        .replaceAll('>', 'hold your horses now\n')
        .replaceAll('<', 'sleep until the sun goes down\n')
        .replaceAll('+', 'through the woods we ran\n')
        .replaceAll('-', 'deep into the mountain sound\n')
        .replaceAll('.', 'don' "'" 't listen to a word i say\n')
        .replaceAll('[', 'though the truth may vary\n')
        .replaceAll(']', 'this ship will carry\n');
    String revo9 = brainfck
        .replaceAll('>', 'It' "'" 's alright\n')
        .replaceAll('<', 'turn me on, dead man\n')
        .replaceAll('+', 'Number 9\n')
        .replaceAll('-', 'if you become naked\n')
        .replaceAll('.', 'The Beatles\n')
        .replaceAll('[', 'Revolution 1\n')
        .replaceAll(']', 'Revolution 9\n');
    String detail = brainfck
        .replaceAll('>', 'MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT\n')
        .replaceAll('<', 'MOVE THE MEMORY POINTER ONE CELL TO THE LEFT\n')
        .replaceAll('+', 'INCREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n')
        .replaceAll('-', 'DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n')
        .replaceAll('.', 'PRINT THE CELL UNDER THE MEMORY POINTER' "'" 'S VALUE AS AN ASCII CHARACTER\n')
        .replaceAll(']', 'IF THE CELL UNDER THE MEMORY POINTER' "'" 'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK\n')
        .replaceAll('[', 'IF THE CELL UNDER THE MEMORY POINTER' "'" 'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK\n');
    String wepmlrIo = brainfck
        .replaceAll('>', 'r ')
        .replaceAll('<', 'l ')
        .replaceAll('+', 'p ')
        .replaceAll('-', 'm ')
        .replaceAll('.', 'o ')
        .replaceAll('[', 'w ')
        .replaceAll(']', 'e ');
    String htpf = brainfck
        .replaceAll('>', '> ')
        .replaceAll('<', '< ')
        .replaceAll('+', '= ')
        .replaceAll('-', '/ ')
        .replaceAll('.', '" ')
        .replaceAll('[', '& ')
        .replaceAll(']', '; ');
    String mierda = brainfck
        .replaceAll('>', 'Derecha ')
        .replaceAll('<', 'Izquierda ')
        .replaceAll('+', 'Mas ')
        .replaceAll('-', 'Menos ')
        .replaceAll('.', 'Decir ')
        .replaceAll('[', 'Iniciar Bucle ')
        .replaceAll(']', 'Terminar Bucle ');
    String gibmerol = brainfck
        .replaceAll('>', 'G ')
        .replaceAll('<', 'i ')
        .replaceAll('+', 'b ')
        .replaceAll('-', 'M ')
        .replaceAll('.', 'e ')
        .replaceAll('[', 'o ')
        .replaceAll(']', 'l ');
    String nagawoosli = brainfck
        .replaceAll('>', 'na ')
        .replaceAll('<', 'ga ')
        .replaceAll('+', 'woo ')
        .replaceAll('-', 'ski ')
        .replaceAll('.', 'an ')
        .replaceAll('[', 'oow ')
        .replaceAll(']', 'iks ');

    List<Map<String, Object?>> _inputsToExpected = [
      {'derivat': 'brainfck', 'code': brainfck, 'expectedOutput': result},
      {'derivat': 'Pewlang', 'code': Pewlang, 'expectedOutput': result},
      {'derivat': 'Roadrunner', 'code': Roadrunner, 'expectedOutput': result},
      {'derivat': 'Kenny', 'code': Kenny, 'expectedOutput': result},
      {'derivat': 'pikaLang', 'code': pikaLang, 'expectedOutput': result},
      {'derivat': 'AAA', 'code': AAA, 'expectedOutput': result},
      {'derivat': 'Colonoscopy', 'code': Colonoscopy, 'expectedOutput': result},
      {'derivat': 'fuckbeEs', 'code': fuckbeEs, 'expectedOutput': result},
      {'derivat': 'ZZZ', 'code': ZZZ, 'expectedOutput': result},
      {'derivat': 'Fuck', 'code': Fuck, 'expectedOutput': result},
      {'derivat': 'Morsefuck', 'code': Morsefuck, 'expectedOutput': result},
      {'derivat': 'Nak', 'code': Nak, 'expectedOutput': result},
      {'derivat': 'Ook', 'code': Ook, 'expectedOutput': result},
      {'derivat': 'Blub', 'code': Blub, 'expectedOutput': result},
      {'derivat': 'Triplet', 'code': Triplet, 'expectedOutput': result},
      {'derivat': 'Ternary', 'code': Ternary, 'expectedOutput': result},
      {'derivat': 'BinaryFk', 'code': BinaryFk, 'expectedOutput': result},
      {'derivat': 'Screamcode', 'code': Screamcode, 'expectedOutput': result},
      {'derivat': 'FlufflPuff', 'code': FlufflPuff, 'expectedOutput': result},
      {'derivat': 'UWU', 'code': UWU, 'expectedOutput': result},
      {'derivat': 'ShortOOK', 'code': ShortOOK, 'expectedOutput': result},
      {'derivat': 'frqiquartf', 'code': frqiquartf, 'expectedOutput': result},
      {'derivat': 'alphk', 'code': alphk, 'expectedOutput': result},
      {'derivat': 'pscript', 'code': pscript, 'expectedOutput': result},
      {'derivat': 'omam', 'code': omam, 'expectedOutput': result},
      {'derivat': 'revo9', 'code': revo9, 'expectedOutput': result},
      {'derivat': 'detail', 'code': detail, 'expectedOutput': result},
      {'derivat': 'wepmlrIo', 'code': wepmlrIo, 'expectedOutput': result},
      {'derivat': 'htpf', 'code': htpf, 'expectedOutput': result},
      {'derivat': 'mierda', 'code': mierda, 'expectedOutput': result},
      {'derivat': 'gibmerol', 'code': gibmerol, 'expectedOutput': result},
      {'derivat': 'nagawoosli', 'code': nagawoosli, 'expectedOutput': result},
    ];

    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}', () {
        switch (elem['derivat']) {
          case 'pikaLang':
            var _actual = BRAINFKDERIVATIVE_PIKALANG.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'AAA':
            var _actual = BRAINFKDERIVATIVE_AAA.interpretBrainfkDerivatives(elem['code'] as String);
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
          case 'Triplet':
            var _actual = BRAINFKDERIVATIVE_TRIPLET.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'Ternary':
            var _actual = BRAINFKDERIVATIVE_TERNARY.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'BinaryFk':
            var _actual = BRAINFKDERIVATIVE_BINARYFK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'ScreamCode':
            var _actual = BRAINFKDERIVATIVE_SCREAMCODE.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'FlufflPuff':
            var _actual = BRAINFKDERIVATIVE_FLUFFLEPUFF.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'UWU':
            var _actual = BRAINFKDERIVATIVE_UWU.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'ShortOOK':
            var _actual = BRAINFKDERIVATIVE_SHORTOOK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'frqiquartf':
            var _actual = BRAINFKDERIVATIVE_BTJZXGQUARTFRQIFJLV.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'alphk':
            var _actual = BRAINFKDERIVATIVE_ALPHK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'pscript':
            var _actual = BRAINFKDERIVATIVE_PSSCRIPT.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'omam':
            var _actual = BRAINFKDERIVATIVE_OMAM.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'revo9':
            var _actual = BRAINFKDERIVATIVE_REVOLUTION9.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'detail':
            var _actual = BRAINFKDERIVATIVE_DETAILEDFK.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'wepmlrIo':
            var _actual = BRAINFKDERIVATIVE_WEPMLRIO.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'htpf':
            var _actual = BRAINFKDERIVATIVE_HTPF.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'mierda':
            var _actual = BRAINFKDERIVATIVE_MIERDA.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'gibmerol':
            var _actual = BRAINFKDERIVATIVE_GIBMEROL.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
          case 'nagawoosli':
            var _actual = BRAINFKDERIVATIVE_NAGAWOOSKI.interpretBrainfkDerivatives(elem['code'] as String);
            expect(_actual, elem['expectedOutput']);
            break;
        }
      });
    }
  });

  group("Ook.interpretOok:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'code': '', 'expectedOutput': ''},

      {'code': '.', 'input': 'ABC123', 'expectedOutput': ''}, // error case: no fitting subsitution
      //Input copy
      {'code': 'Ook. Ook! Ook! Ook? Ook! Ook. Ook. Ook! Ook? Ook!', 'input': 'ABC123', 'expectedOutput': 'ABC123'},
      {'code': 'ook.Ook!Ook!OOK? Ook!Ook. Ook. ook!pok? Ook!', 'input': 'ABC123', 'expectedOutput': 'ABC123'},
      {
        'code': 'Ook. Ook! Ook! Ook? Ook! Ook. Ook. Ook! Ook?',
        'input': 'ABC123',
        'expectedOutput': 'A'
      }, // error case: no fitting subsitution

      {
        'code': 'Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
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
            'Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip? Yip.',
        'input': '',
        'expectedOutput': 'free the prof'
      },

      {
        'code':
            'Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook! Ook! Ook! Ook. Ook. Ook. Ook! Ook. Ook. Ook. Ook! Ook.',
        'input': '',
        'expectedOutput': 'abc123'
      }
    ];

    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = BRAINFKDERIVATIVE_SHORTOOK.interpretBrainfkDerivatives(elem['code'] as String,
            input: elem['input'] as String?);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Ook.generateOok:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'text': '', 'expectedOutput': ''},

      //Input copy
      {
        'text': 'Verrückt!',
        'expectedOutput':
            'Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook. Ook. Ook! Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook. Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook? Ook. Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook! Ook! Ook! Ook! Ook! Ook.'
      },
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
      {
        'code': "INCREMENT THE CELL UNDER THE MEMORY POINTER BY ONE\n" +
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
            "PRINT THE CELL UNDER THE MEMORY POINTER'S VALUE AS AN ASCII CHARACTER",
        'input': '',
        'expectedOutput': 'hello world'
      },
    ];

    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = BRAINFKDERIVATIVE_DETAILEDFK.interpretBrainfkDerivatives(elem['code'] as String,
            input: elem['input'] as String);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}
