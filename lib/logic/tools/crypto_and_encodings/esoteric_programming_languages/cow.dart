//---------------------------------------------------------
// COW Programming language
// by BigZaphod sean@fifthace.com
// https://github.com/BigZaphod/COW
//
// Licencse: Public Domain
//
// Marco F. atomK
// https://github.com/Atomk/C-COW-Interpreter/blob/master/cow-interpreter.c
//
// Frank Buss
// https://frank-buss.de/cow.html
//---------------------------------------------------------

import 'package:gc_wizard/utils/common_utils.dart';

final ERROR_COW_INVALIDCODE = 'cow_error_invalidcode';
final ERROR_COW_LOOPNOTOPEND = 'cow_error_nomatchingMOO';
final ERROR_COW_LOOPNOTCLOSED = 'cow_error_nomatchingmoo';
final ERROR_COW_MEMORYOUTOFBOUNDS = 'cow_error_memoryoutofbounds';
final ERROR_COW_INFINITELOOP = 'cow_error_infiniteloop';
final ERROR_COW_MAXITERATIONS = 'cow_error_maxiterations';

final commandsMooToInteger = {
  'moo': 0,
  'mOo': 1,
  'moO': 2,
  'mOO': 3,
  'Moo': 4,
  'MOo': 5,
  'MoO': 6,
  'MOO': 7,
  'OOO': 8,
  'MMM': 9,
  'OOM': 10,
  'oom': 11
};

final commandsIntegerToMoo = switchMapKeyValue(commandsMooToInteger);
final mnemonicList = {
  0: 'jump loop start',
  1: 'dec mem',
  2: 'inc mem',
  3: 'exec [mem]',
  4: '[mem]=0 ? input char [mem] : print [mem] as char',
  5: 'dec [mem]',
  6: 'inc [mem]',
  7: '[mem]=0 ? loop end : loop start',
  8: 'clr [mem]',
  9: 'reg=0 ? mov [mem] reg : mov reg [mem]; clr reg',
  10: 'print [mem] as int',
  11: 'input int [mem]'
};

final MAX_MEMORY = 1024;
final MAX_ITERATIONS = 32768;

class CowOutput {
  String output = '';
  String error = '';
  List<String> debug;

  CowOutput(this.output, this.error, this.debug);
}

String error = '';
bool halt = false;
int mem_pos = 0;
List<int> memory = List<int>.generate(MAX_MEMORY, (index) => 0);
String STDOUT = '';
int inputPointer = 0;
int register = 0;
bool has_register_val = false;
List<String> debug = new List<String>();

CowOutput interpretCow(String code, {String STDIN}) {
  STDOUT = '';
  halt = false;
  mem_pos = 0;
  inputPointer = 0;
  register = 0;
  has_register_val = false;
  memory.forEach((element) {
    element = 0;
  });

  if (code == null || code.length == 0) return CowOutput('', '', []);

  code = code.replaceAll(new RegExp(r'\s'), '');
  List<int> instructions = new List<int>();
  for (int i = 0; i < code.length ~/ 3; i++) {
    if (commandsMooToInteger[code.substring(i * 3, i * 3 + 3)] == null)
      return CowOutput('', ERROR_COW_INVALIDCODE, []);
    else
      instructions.add(commandsMooToInteger[code.substring(i * 3, i * 3 + 3)]);
  }
  print(instructions);
  int iterations = 0;
  int prog_pos = 0;

  while (prog_pos < instructions.length && !halt) {
    print(mnemonicList[instructions[prog_pos]]);
    debug.add(mnemonicList[instructions[prog_pos]]);
    prog_pos = _execCommand(instructions[prog_pos], instructions, prog_pos, instructions.length, STDIN);
    iterations++;
    if (iterations > MAX_ITERATIONS) {
      error = ERROR_COW_MAXITERATIONS;
      halt = true;
    }
  };

  return CowOutput(STDOUT, error, debug);
}

int _execCommand(
    int commandCode, List<int> instructionsArray, int instructionIndex, int numberOfInstructions, String STDIN) {
  int MOO_count = 0;
  int moo_count = 0;

  switch (commandCode) {
    case 0: // moo
      instructionIndex -= 2; // Skip previous instruction
      moo_count = 0;

      while (instructionIndex >= 0) {
        switch (instructionsArray[instructionIndex]) {
          case 0: //moo
            moo_count++;
            break;
          case 7: //MOO
            if (moo_count == 0)
              return instructionIndex;
            else
              moo_count--;
            break;
        }
        instructionIndex--;
      }
      halt = true;
      error = ERROR_COW_LOOPNOTOPEND;
      break;

    case 1: // mOo
      if (mem_pos > 0) {
        mem_pos--;
      } else {
        halt = true;
        error = ERROR_COW_MEMORYOUTOFBOUNDS;
      }
      break;

    case 2: // moO
      if (mem_pos < MAX_MEMORY - 1) {
        mem_pos++;
      } else {
        halt = true;
        error = ERROR_COW_MEMORYOUTOFBOUNDS;
      }
      break;

    case 3: // mOO
      if (memory[mem_pos] == commandCode) {
        halt = true;
        error = ERROR_COW_INFINITELOOP;
      } else {
        if (memory[mem_pos] >= 0 && memory[mem_pos] <= 11) {
          _execCommand(memory[mem_pos], instructionsArray, instructionIndex, instructionIndex, STDIN);
        } else {
          halt = true;
          error = ERROR_COW_INVALIDCODE;
        }
      }
      break;

    case 4: // Moo
      if (memory[mem_pos] == 0) {
        memory[mem_pos] = STDIN.codeUnitAt(inputPointer);
        inputPointer++;
      } else {
        STDOUT = STDOUT + String.fromCharCode(memory[mem_pos] % 256);
      }
      break;

    case 5: // MOo
      memory[mem_pos]--;
      break;

    case 6: // MoO
      memory[mem_pos]++;
      break;

    case 7: // MOO
      if (memory[mem_pos] == 0) {
        MOO_count = 0;
        instructionIndex += 2; // Skip next instruction

        while (instructionIndex < numberOfInstructions) {
          switch (instructionsArray[instructionIndex]) {
            case 0:
              if (MOO_count == 0)
                return instructionIndex + 1;
              else
                MOO_count--;
              break;
            case 7:
              MOO_count++;
              break;
          }
          instructionIndex++;
        }
        halt = true;
        error = ERROR_COW_LOOPNOTCLOSED;
      }
      break;

    case 8: // OOO
      memory[mem_pos] = 0;
      break;

    case 9: // MMM
      if (!has_register_val)
        register = memory[mem_pos];
      else
        memory[mem_pos] = register;
      has_register_val = !has_register_val;
      break;

    case 10: // OOM - Print value of current memory block to STDOUT as an integer
      STDOUT = STDOUT + memory[mem_pos].toString();
      break;

    case 11: // oom - Read an integer from STDIN and put it into the current memory block
      String digit = '';
      while (int.tryParse(STDIN[inputPointer]) != null) {
        digit = digit + STDIN[inputPointer];
        inputPointer++;
      }
      memory[mem_pos] = int.parse(digit);
      break;

    default:
      halt = true;
      error = ERROR_COW_INVALIDCODE;
  }
  return instructionIndex + 1;
}

String generateCow(String cowOut) {
  // initial program: store 8, 16, 32 and 64 in memory positions 1, 2, 3 and 4, current memory position is 5
  var program =
      'OOO MoO MoO MoO MoO MoO MoO MoO MoO MMM moO MMM MMM moO MMM MOO MOo mOo MoO moO moo mOo MMM moO MMM MMM moO MMM MOO MOo mOo MoO moO moo mOo MMM moO MMM MMM moO MMM MOO MOo mOo MoO moO moo';

  for (var i = 0; i < cowOut.length; i++) {
    // next character, ignore non-ASCII
    var c = cowOut.codeUnitAt(i);
    if (c > 127) continue;

    // clear position 5 and 6
    program += ' OOO moO OOO mOo';

    // add bits
    for (var j = 6; j > 3; j--) {
      var mask = 1 << j;
      if (c > mask) {
        switch (j) {
          case 6:
          // position 5 = 64
            program += ' mOo MMM moO MMM';
            break;
          case 5:
          // position 5 = 32
            program += ' mOo mOo MMM moO moO MMM';
            break;
          case 4:
          // position 5 = 16
            program += ' mOo mOo mOo MMM moO moO moO MMM';
            break;
        }
        // add position 5 and 6, result in position 6
        program += ' MOO MOo moO MoO mOo moo';
        c -= mask;
      }
    }

    // add rest to position 6 and print
    program += " moO";
    for (var j = 0; j < c; j++) {
      program += " MoO";
    }
    program += " Moo mOo";
  }

  return program;
}
