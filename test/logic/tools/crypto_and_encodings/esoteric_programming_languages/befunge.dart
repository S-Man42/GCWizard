import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/befunge.dart';

void main() {
  group("Befunge.interpretBefunge", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'code' : null, 'input' : null, 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : null, 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : 'ABC123;', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: BEFUNGE_ERROR_INFINITE_LOOP, BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://en.wikipedia.org/wiki/Befunge
      {'code' : '>:# 0# \\# g# ,# 1# +# :# 5# 9# *# -# _@ Quine', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '>:# 0# \\# g# ,# 1# +# :# 5# 9# *# -# _@ Quine', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '>              v\n' +
                'v  ,,,,,"Hello"<\n' +
                '>48*,          v\n' +
                'v,,,,,,"World!"<\n' +
                '>25*,@', 'input' : null, 'expectedOutput' : BefungeOutput(Output: 'Hello World!\n', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : ' >25*"!dlrow ,olleH":v\n' +
                '                  v:,_@\n' +
                '                  >  ^\n', 'input' : '', 'expectedOutput' : BefungeOutput(Output: ' Helloworld!\n', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      // random number generator - does not work as a test
      //  {'code' : ' v>>>>>v\n' +
      //            '  12345\n' +
      //            '  ^?^\n' +
      //            ' > ? ?^\n' +
      //            '  v?v\n' +
      //            '  6789\n' +
      //            '  >>>> v\n' +
      //            ' ^    .<\n', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://de.wikipedia.org/wiki/Befunge
      {'code' : '0.1>:#\.#g:#00#00#+p# <', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '0.1> #<:#<.#<:#<0#<0#<p#<+#<0#<0#<g#<\\# <', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '0.1>:.:00p+00g\\v\n' +
                '^           <', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '4 3 + . @', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '7', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : 'v   > . v\n' +
                '         \n' +
                '4   +   @\n' +
                '         \n' +
                '> 3 ^', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '7', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : 'v*>.v\n' +
                '4*+*@\n' +
                '>3^**', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '7', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '"!dlroW olleH"v\n' +
                '@,,,,,,,,,,,,<', 'input' : '', 'expectedOutput' : BefungeOutput(Output: 'Hello World', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '"!dlrow olleH">:#,_@', 'input' : '', 'expectedOutput' : BefungeOutput(Output: 'Hello World', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // http://quadium.net/funge/downloads/bef93src/

      // https://github.com/catseye/Befunge-93/tree/master/eg
      // https://github.com/catseye/Befunge-93/blob/master/eg/befunge2.bf
      {'code' : '<>: #+1 #:+ 3 : *6+ \$#2 9v#\n' +
                'v 7 :   +   8 \\ + + 5   <\n' +
                '>-  :2  -:  " " 1 + \\ v ^<\n' +
                '2 + :   7   + : 7 + v > :\n' +
                ':1- :3- >   :#, _ @ >:3 5*-', 'input' : '', 'expectedOutput' : BefungeOutput(Output: 'BEFUNGE!EGNUFEB', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://github.com/catseye/Befunge-93/blob/master/eg/chars.bf
      {'code' : '25*3*4+>:."=",:,25*,1+:88*2*-#v_@\n' +
                '^                      <', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},


      // self generated
    {'code' : '>43*7+3*87*83+5*69*68*5+94+2*2*98+3*55+5*77*86*v\n' +
              'v                                              >\n' +
              '>52*52**0*52*1*0++1+>1-:v\n' +
              '^,\\ _@', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '0123456789', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},


    ];

    _inputsToExpected.forEach((elem) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = interpretBefunge(elem['code'], input: elem['input']);
        expect(_actual.Output, elem['expectedOutput'].output);
        expect(_actual.Error, elem['expectedOutput'].error);
      });
    });
  });
}