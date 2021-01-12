// http://www.lscheffer.com/malbolge_spec.html
// http://www.lscheffer.com/malbolge_interp.html
// https://github.com/zb3/malbolge-tools

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/malbolge/malbolge.dart';

malbolgeOutput interpretMalbolge(String program, String STDIN, bool strict){
  List<int> memory = new List<int>(59049);
  if (program.length < 2)
    return malbolgeOutput([
      'malbolge_error_invalid_program',
      'malbolge_error_program_to_short'], [], [], []);

  if (checkNormalize(program))
    program = reverseNormalize(program);

  // load program
  int charCode = 0;
  String malbolge = program.replaceAll(RegExp(r'\s'), '');
  int i = 0;
  while (i < malbolge.length){
    charCode = malbolge.codeUnitAt(i);
    if (charCode < 127 && charCode > 32) {
      if (!validInstructions .contains(xlat1 [(charCode - 33 + i) % 94]))
        return malbolgeOutput([
          'malbolge_error_invalid_program',
          'malbolge_error_invalid_character'], [], [], []);
    }
    if (i == 59049) {
      return malbolgeOutput([
        'malbolge_error_invalid_program',
        'malbolge_error_program_to_big'], [], [], []);
    }
    memory[i] = charCode;
    i++;
  }
  // fill memory with op(i-1, i-2)
  while (i < 59049){
    memory[i] = op(memory[i - 1], memory[i - 2]);
    i++;
  }
  // execute programm
  int a = 0;
  int c = 0;
  int d = 0;
  String opcode = '';
  bool halt = false;
  int input = 0;
  List<String> output = new List<String>();
  List<String> assembler = new List<String>();
  List<String> memnonic = new List<String>();
  List<DebugOutput> debug = new List<DebugOutput>();
  String STDOUT = '';

  while (!halt){
    if (strict) {
      if (memory[c] < 33 || memory[c] > 126) {
        output.addAll([STDOUT,
          '',
          'malbolge_error_runtime',
          'malbolge_error_invalid_opcode',
          'opCode: '+memory[c].toString()+' '+String.fromCharCode(memory[c]),
          'malbolge_error_infinite_loop',
          '',
          'STACK TRACE ----------',
          'c = '+c.toString(),
          'a = '+a.toString(),
          'd = '+d.toString(),]);
        return malbolgeOutput(output, assembler, memnonic, debug);
      }
      opcode = xlat1[(memory[c] - 33 + c) % 94];
      assembler.add(format(c) + '   ' + opcode);
      memnonic.add(opCodeList[opcode]);
    } else {
      opcode = xlat1[(memory[c] - 33 + c) % 94];
      assembler.add(format(c) + '   ' + opCodeList[opcode]);
      memnonic.add(opCodeList[opcode]);
    }
    switch (opcode) {
      case 'j':  //    40     mov d, [d]
        d = memory[d];
        break;

      case 'i':   //     4     c = [d]
        c = memory[d];
        break;

      case '*':  //    39     a = [d] = rotr [d]
        memory[d] =  memory[d] ~/ 3 + (memory[d] % 3) * 19683;
        //memory[d] =  _rotr(memory[d]);
        a = memory[d];
        break;

      case 'p':  //    62     a = [d] = crazy(a, [d])
        memory[d] = op(a, memory[d]);
        a = memory[d];
        break;

      case '<':   //   23     out a % 256
        STDOUT = STDOUT + String.fromCharCode(a % 256);
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
        break;

      case 'o':  //    68     NOP
        break;

      case 'v':  //    81     end
        halt = true;
        break;
    };
    if (strict) {
      if (memory[c] < 33 || memory[c] > 126) {
        output.addAll([STDOUT,
          '',
          'malbolge_error_runtime',
          'malbolge_error_invalid_opcode',
          'opCode: '+memory[c].toString()+' '+String.fromCharCode(memory[c]),
          (opcode == 'i') ? 'malbolge_error_illegal_jump' : 'malbolge_error_illegal_write',
          '',
          'STACK TRACE ----------',
          'c = '+c.toString(),
          'a = '+a.toString(),
          'd = '+d.toString(),]);
        return malbolgeOutput(output, assembler, memnonic, debug);
      };
      memory[c] = xlat2 .codeUnitAt(memory[c] - 33);
    }
    else {
      if (33 <= memory[c] && memory[c] <= 126) {
        memory[c] = xlat2 .codeUnitAt(memory[c] - 33);
      }
    }

    if (c == 59048)
      c = 0;
    else
      c++;
    if (d == 59048)
      d = 0;
    else
      d++;
  }
  output.add(STDOUT);
  return malbolgeOutput(output, assembler, memnonic, debug);
}
