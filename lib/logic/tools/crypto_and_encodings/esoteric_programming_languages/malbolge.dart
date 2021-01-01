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
  List<int> memory = new List<int>(59049);

  // load program
  int codeUnit = 0;
  String malbolge = program.replaceAll(RegExp(r'\s'), '');
  int j = 0;
  for (int i = 0; i < malbolge.length; i++) {
    if (i > 59048) {
      return malbolgeOutput([
        'malbolge_error_invalid_program',
        'malbolge_error_program_to_big'], [], [], []);
    }
    codeUnit = malbolge.codeUnitAt(i);
     if (codeUnit < 33 || codeUnit > 126) {
      return malbolgeOutput([
        'malbolge_error_invalid_program',
        'malbolge_error_invalid_character'], [], [], []);
     }
     memory[i] = codeUnit;
     j = i;
     print(i.toString()+' '+malbolge[i]+' '+codeUnit.toString());
  }
  if (j < 2)
    return malbolgeOutput([
      'malbolge_error_invalid_program',
      'malbolge_error_program_to_short'], [], [], []);
  for (int i = j + 1; i < 59049; i++) {
    memory[i] = _crazy(memory[i - 2], memory[i - 1]);
  }

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
    opCode = (c + memory[c]) % 94;

    assembler.add(_format(c) + ' ' + _format(d) + ' ' + _format(a));
    assembler.add(_format(memory[c]) + ' ' + _format(memory[d]) + ' ' + _format(memory[a]));
    memnonic.add('');

    switch (opCode) {
      case 4:   // c = [d]
        c = memory[d];
        memnonic.add('jmp [d]');
        break;
      case 5: // out a % 256
      print('out a: '+a.toString()+' '+(a % 256).toString());
        STDOUT = STDOUT + String.fromCharCode(a % 256);
      memnonic.add('out a');
        break;
      case 23: // in a
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
      case 39: // a = [d] = rotr [d]
        memory[d] = _rotate(memory[d]);
        a = memory[d];
        memnonic.add('rotr [d]');
        memnonic.add('mov a, [d]');
        assembler.add('');
        break;
      case 40: // mov d, [d]
        d = memory[d];
        memnonic.add('mov d, [d]');
        break;
      case 62: // a = [d] = crazy(a, [d])
        memory[d] = _crazy(memory[d], a);
        a = memory[d];
        memnonic.add('crz([d], a)');
        memnonic.add('mov a, [d]');
        assembler.add('');
        break;
      case 68: // NOP
        memnonic.add('nop');
        break;
      case 81: // end
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
