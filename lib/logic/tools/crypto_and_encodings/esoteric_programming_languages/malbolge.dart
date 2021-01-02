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
final validOpCodeList = {'j', 'i', '*', 'p', '<', '/', 'v', 'o'};
final opCodeList = {
  'j' : 'mov d, [d]',
  'i' : 'jmp [d]',
  '*' : '[d] = rotr [d]\na = [d]',
  'p' : '[d] = crz a, [d]\na = [d]',
  '/' : 'in a',
  '<' : 'out a',
  'v' : 'end',
  'o' : 'nop' };

malbolgeOutput generateMalbolge(String input){
}

malbolgeOutput interpretMalbolge(String program, STDIN){
  List<int> memory = new List<int>(59049);

  // load program
  int codeUnit = 0;
  String malbolge = program.replaceAll(RegExp(r'\s'), '');
  int j = 0;
  for (int i = 0; i < malbolge.length; i++) {
    codeUnit = malbolge.codeUnitAt(i);
     if (codeUnit < 127 && codeUnit > 32) {
       if (!validOpCodeList.contains(xlat1[(codeUnit - 33 + i) % 94]))
        return malbolgeOutput([
          'malbolge_error_invalid_program',
          'malbolge_error_invalid_character'], [], [], []);
     }
    if (i > 59048) {
      return malbolgeOutput([
        'malbolge_error_invalid_program',
        'malbolge_error_program_to_big'], [], [], []);
    }
     memory[i] = codeUnit;
     j = i;
  }
  // fill memory with crazy(i-1, i-2)
  if (j < 2)
    return malbolgeOutput([
      'malbolge_error_invalid_program',
      'malbolge_error_program_to_short'], [], [], []);
  for (int i = j + 1; i < 59049; i++) {
    memory[i] = _crazy(memory[i - 1], memory[i - 2]);
  }

  // execute programm
  print('execute program ----------------------------------------------');
  int a = 0;
  int c = 0;
  int d = 0;
  int opCode = 0;
  String op = '';
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
        'malbolge_error_runtime',
        'malbolge_error_invalid_opcode',
        'opCode: '+opCode.toString()+' '+String.fromCharCode(opCode),
        '',
        'STACK TRACE ----------',
        'c = '+c.toString(),
        'a = '+a.toString(),
        'd = '+d.toString(),]);
      return malbolgeOutput(output, assembler, memnonic, debug);
    }
    op = xlat1[(memory[c] - 33 + c) % 94];
    assembler.add(_format(c) + ' ' + _format(d) + ' ' + _format(a));
    assembler.add(_format(memory[c]) + ' ' + _format(memory[d]) + ' ' + _format(memory[a]));
    memnonic.add('');
    print('c '+c.toString()+'   '+op+' '+opCodeList[op]);

    switch (op) {
      case 'i':   //     4     c = [d]
        c = memory[d];
        memnonic.add(opCodeList[op]);
        break;

      case '<':   //   23     out a % 256
      print('out a: '+a.toString()+' '+(a % 256).toString());
        STDOUT = STDOUT + String.fromCharCode(a % 256);
        memnonic.add(opCodeList[op]);
        break;

      case '/':  //      5     in a
        if (input < STDIN.length) {
          a = STDIN.codeUnitAt(input);
          input++;
        }
        else {
          output.addAll([STDOUT,
            '',
            'malbolge_error_runtime',
            'malbolge_error_no_input']);
          return malbolgeOutput(output, assembler, memnonic, debug);
        }
        memnonic.add(opCodeList[op]);
        break;

      case '*':  //    39     a = [d] = rotr [d]
        memory[d] = _rotate(memory[d]);
        a = memory[d];
        memnonic.add(opCodeList[op]);
        assembler.add('');
        break;

      case 'j':  //    40     mov d, [d]
        d = memory[d];
        memnonic.add('mov d, [d]');
        break;

      case 'p':  //    62     a = [d] = crazy(a, [d])
        memory[d] = _crazy(a, memory[d]);
        a = memory[d];
        memnonic.add(opCodeList[op]);
        assembler.add('');
        break;

      case 'o':  //    68     NOP
        memnonic.add(opCodeList[op]);
        break;

      case 'v':  //    81     end
        halt = true;
        memnonic.add(opCodeList[op]);
        break;
      default:
    };

    if (!_invalid(memory[c]))
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
  print('fertig: '+STDOUT);
  output.add(STDOUT);
  return malbolgeOutput(output, assembler, memnonic, debug);
}

String _intToTrits(int input){
  String output = '';
  for (int i = 9; i >= 0; i--) {
    if (input >= pow(3, i)) {
      output = output + (input ~/ pow(3, i)).toString();
      input = input % pow(3, i);
    }
    else {
      output = output + '0';
    }
  }
  return output;
}

int _tritsToInt(String input){
  int output = 0;
  for (int i = input.length; i > 0; i--)
    output = output + int.parse(input[i - 1]) * pow(3, input.length - i);
  return output;
}

// final crazyMap = {
//   '00' : '1', '01' : '0', '02' : '0',
//   '10' : '1', '11' : '0', '12' : '2',
//   '20' : '2', '21' : '2', '22' : '1'};

final p9 = {0 : 1, 1 : 9, 2 : 81, 3 : 729, 4 : 6561};

final o = {
  0 : { 0:4, 1:3, 2:3, 3:1, 4:0, 5:0, 6:1, 7:0, 8:0 },
  1 : { 0:4, 1:3, 2:5, 3:1, 4:0, 5:2, 6:1, 7:0, 8:2 },
  2 : { 0:5, 1:5, 2:4, 3:2, 4:2, 5:1, 6:2, 7:2, 8:1 },
  3 : { 0:4, 1:3, 2:3, 3:1, 4:0, 5:0, 6:7, 7:6, 8:6 },
  4 : { 0:4, 1:3, 2:5, 3:1, 4:0, 5:2, 6:7, 7:6, 8:8 },
  5 : { 0:5, 1:5, 2:4, 3:2, 4:2, 5:1, 6:8, 7:8, 8:7 },
  6 : { 0:7, 1:6, 2:6, 3:7, 4:6, 5:6, 6:4, 7:3, 8:3 },
  7 : { 0:7, 1:6, 2:8, 3:7, 4:6, 5:8, 6:4, 7:3, 8:5 },
  8 : { 0:8, 1:8, 2:7, 3:8, 4:8, 5:7, 6:5, 7:5, 8:4 },
};

int _crazy(int x, y){
  int i = 0;
  for (int j = 0; j < 5; j++){
    i = i + o[(y ~/ p9[j]) % 9][(x ~/ p9[j]) % 9] * p9[j];
  }
  return i;
  // String trits1 = _intToTrits(x);
  // String trits2 = _intToTrits(y);
  // String output = '';
  // for (int i = 0; i < trits1.length; i++)
  //   output = output + crazyMap[trits2[i] + trits1[i]];
  //return _tritsToInt(output);
}

int _rotate(int n){
 return (n ~/ 3 + (n % 3) * 19683);
}

bool _invalid(int opCode) {
  return !(32 < opCode && opCode < 127);
}

String _format(int n) {
  String output = n.toString();
  for (int i = output.length; i < 6; i++ )
    output = ' ' + output;
  return output;
}
