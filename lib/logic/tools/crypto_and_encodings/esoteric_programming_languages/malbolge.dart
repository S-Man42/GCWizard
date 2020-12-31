import 'dart:math';

class malbolgeOutput{
  final List<String> output;
  final List<String> assembler;
  final List<String> memnonic;
  final List<DebugOutput> debug;

  malbolgeOutput(this.output, this.assembler, this.memnonic, this.debug);
}

class DebugOutput{
  final String pc;
  final String command;
  final String stack;
  final String output;

  DebugOutput(this.pc, this.command, this.stack, this.output);
}

final xlat1 = '+b(29e*j1VMEKLyC})8&m#~W>qxdRp0wkrUo[D7,XTcA"lI.v%{gJh4G\\-=O@5`_3i<?Z\';FNQuY]szf\$!BS/|t:Pn6^Ha';
final xlat2 = '5z]&gqtyfr\$(we4{WP)H-Zn,[%\\3dL+Q;>U!pJS72FhOA1CB6v^=I_0/8|jsb9m<.TVac`uY*MK\'X~xDl}REokN:#?G"i@';

malbolgeOutput generateMalbolge(String input){
}

malbolgeOutput interpretMalbolge(String program, STDIN){
  List<int> memory = new List<int>(59048);

  // load program
  int codeUnit = 0;
  String malbolge = program.replaceAll(RegExp(r'\s'), '');
  int j = 0;
  for (int i = 0; i < malbolge.length; i++) {
     codeUnit = malbolge.codeUnitAt(i);
     if (codeUnit < 33 || codeUnit > 126) {
      return malbolgeOutput(['malbolge_error_invalid_programm',
      'malbolge_error_invalid_character'], [], [], []);
     }
     memory[i] = codeUnit;
     j = i;
  }
  if (j < 2)
    return malbolgeOutput(['malbolge_error_invalid_programm',
      'malbolge_error_programm_to_short'], [], [], []);
  for (int i = j + 1; i <= 59048; i++)
    memory[i] = _crazy(memory[i - 2], memory[i - 1]);

  // execute programm
  int a = 0;
  int c = 0;
  int d = 0;
  int opCode = 0;
  bool halt = false;
  int input = 0;
  List<String> output = new List<String>();
  List<String> assembler = new List<String>();
  List<String> memnonic = new List<String>();
  List<DebugOutput> debug = new List<DebugOutput>();
  String STDOUT = '';
  while (!halt){
    opCode = memory[c];
    if (_invalid(opCode)) {
      output.addAll([STDOUT,
        '',
        'malbolge_error_runtime'
        'malbolge_error_invalid_opcode']);
      return malbolgeOutput(output, assembler, memnonic, debug);
    }
    opCode = (c + memory[c]) % 94;
    switch (opCode) {
      case 4:   // c = [d]
        c = memory[d];
        break;
      case 5: // output a % 256
        STDOUT = STDOUT + String.fromCharCode(a);
        break;
      case 23: // a  = input
        if (input < STDIN.length) {
          a = STDIN.codeUnitAt(input);
          input++;
        } else {
          output.addAll([STDOUT,
            '',
            'malbolge_error_runtime'
                'malbolge_error_invalid_opcode']);
          return malbolgeOutput(output, assembler, memnonic, debug);
        }
        break;
      case 39: // a = [d] = rotate_right [d]
          a = _rotate(memory[d]);
          memory[d] = _rotate(memory[d]);
        break;
      case 40: // d = [d]
        d = memory[d];
        break;
      case 62: // a = [d] = crazy(a, [d])
        a = _crazy(a, memory[d]);
        memory[d] = _crazy(a, memory[d]);
        break;
      case 68: // NOP
        break;
      case 81: // halt
        halt = true;
        break;
      default:
    };
    memory[c] = xlat2.codeUnitAt(memory[c] - 33);

    if (c == 59048)
      c = 0;
    else
      c++;
    if (d == 59048)
      d = 0;
    else
      d++;
  }
}

String _intToTrits(int input){
  String output = '';
  for (int i = 9; i >= 0; i--) {
    output = output + (input % pow(3, i)).toString();
    if (input >= pow(3, i))
      input = input - pow(3, i);
  }
}

int _tritsToInt(String input){
  int output = 0;
  for (int i = input.length; i > 0; i--)
    output = output + int.parse(input[i - 1]) * pow(3, input.length - i);
  return output;
}

final crazyMap = {'00' : '1', '01' : '0', '02' : '0', '10' : '1', '11' : '0', '12' : '2', '20' : '2', '21' : '2', '22' : '1'};
int _crazy(int mem1, mem2){
  String trits1 = _intToTrits(mem1);
  String trits2 = _intToTrits(mem2);
  String output = '';
  for (int i = 0; i < trits1.length; i++)
    output = output + crazyMap[trits1[i] + trits2[i]];
  return _tritsToInt(output);
}

int _rotate(int input){
  String output = _intToTrits(input);
  return _tritsToInt(output[9] + output.substring(0, 8));
}

bool _invalid(int opCode) {
  return (opCode >= 33 && 126 <= opCode);
}
