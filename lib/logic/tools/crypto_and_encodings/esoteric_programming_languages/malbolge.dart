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
  print(memory[j].toString()+' '+_intToTrits((memory[j]))+' , '+memory[j-1].toString()+' '+_intToTrits((memory[j-1])));
  for (int i = j + 1; i < 59049; i++) {
    memory[i] = _crazy(memory[i - 2], memory[i - 1]);
  }
      print(memory[59048].toString()+' '+_intToTrits((memory[59048]))+' , '+memory[59047].toString()+' '+_intToTrits((memory[59047])));

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
    opCode = (memory[c] - 33 + c) % 94;

    assembler.add(_format(c) + ' ' + _format(d) + ' ' + _format(a));
    assembler.add(_format(memory[c]) + ' ' + _format(memory[d]) + ' ' + _format(memory[a]));
    memnonic.add('');

    switch (opCode) {
      case 4:   //     i     c = [d]
        c = memory[d];
        memnonic.add('jmp [d]');
        break;
      case 5:   //     /     out a % 256
      print('out a: '+a.toString()+' '+(a % 256).toString());
        STDOUT = STDOUT + String.fromCharCode(a % 256);
      memnonic.add('out a');
        break;
      case 23:  //     <     in a
        if (input < STDIN.length) {
          a = STDIN.codeUnitAt(input);
          input++;
        } else {
          output.addAll([STDOUT,
            '',
            'malbolge_error_runtime',
            'malbolge_error_no_input']);
          return malbolgeOutput(output, assembler, memnonic, debug);
        }
        memnonic.add('out a');
        break;
      case 39:  //     *     a = [d] = rotr [d]
        memory[d] = _rotate(memory[d]);
        a = memory[d];
        memnonic.add('rotr [d]');
        memnonic.add('mov a, [d]');
        assembler.add('');
        break;
      case 40:  //     j     mov d, [d]
        d = memory[d];
        memnonic.add('mov d, [d]');
        break;
      case 62:  //     p     a = [d] = crazy(a, [d])
        memory[d] = _crazy(memory[d], a);
        a = memory[d];
        memnonic.add('crz([d], a)');
        memnonic.add('mov a, [d]');
        assembler.add('');
        break;
      case 68:  //     o     NOP
        memnonic.add('nop');
        break;
      case 81:  //     v     end
        halt = true;
        memnonic.add('end');
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

final crazyMap = {
  '00' : '1', '01' : '0', '02' : '0',
  '10' : '1', '11' : '0', '12' : '2',
  '20' : '2', '21' : '2', '22' : '1'};
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
    print(j.toString()+' '+p9[j].toString()+' '+((y / p9[j]) % 9).toString()+' '+((x / p9[j]) % 9).toString());
    i = i + o[(y ~/ p9[j]) % 9][(x ~/ p9[j]) % 9] * p9[j];
  }
  //String trits1 = _intToTrits(x);
  //String trits2 = _intToTrits(y);
  //String output = '';
  //for (int i = 0; i < trits1.length; i++)
  //  output = output + crazyMap[trits1[i] + trits2[i]];
  //print('crazy-----'+mem1.toString()+','+mem2.toString());
  //print(trits1);
  //print(trits2);
  //print('----------');
  //print(output);
  //return _tritsToInt(output);
  return i;
}

int _rotate(int input){
  String output = _intToTrits(input);
  print('rotate '+input.toString()+': '+output+'>'+output[9] + output.substring(0, 9));
  return _tritsToInt(output[9] + output.substring(0, 8));
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
