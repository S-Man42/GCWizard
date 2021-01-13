// http://www.lscheffer.com/malbolge_spec.html
// http://www.lscheffer.com/malbolge_interp.html
//
// Generator for text printing Malbolge programs.
// 2012, 2015 Matthias Ernst.
// Please visit <http://www.matthias-ernst.eu/malbolge.html>
//
// To the extent possible under law, the author has dedicated all copyright
// and related and neighboring rights to this software to the public domain
// worldwide. This software is distributed without any warranty.
//
// See <http://creativecommons.org/publicdomain/zero/1.0/>.

import 'dart:math';

class malbolgeOutput{
  final List<String> output;
  final List<String> assembler;
  final List<String> memnonic;

  malbolgeOutput(this.output, this.assembler, this.memnonic);
}


final xlat1  = '+b(29e*j1VMEKLyC})8&m#~W>qxdRp0wkrUo[D7,XTcA"lI.v%{gJh4G\\-=O@5`_3i<?Z\';FNQuY]szf\$!BS/|t:Pn6^Ha';
final xlat2  = '5z]&gqtyfr\$(we4{WP)H-Zn,[%\\3dL+Q;>U!pJS72FhOA1CB6v^=I_0/8|jsb9m<.TVac`uY*MK\'X~xDl}REokN:#?G"i@';

final validInstructions  = {'j', 'i', '*', 'p', '<', '/', 'v', 'o'};
final opCodeList = {
  'i' : 'jmp [d]',                '4' : 'i',
  '<' : 'out a',                  '5' : '<',
  '/' : 'in a',                  '23' : '/',
  '*' : 'a = [d] = rotr [d]',    '39' : '*',
  'j' : 'mov d, [d]',            '40' : 'j',
  'p' : 'a = [d] = crz a, [d]]', '62' : 'p',
  'v' : 'end',                   '81' : 'v',
  'o' : 'nop',                   '68' : 'o' };

final MB_OUT = 5;
final MB_ROT = 39;
final MB_OPR = 62;
final MB_NOP = 68;
final MB_HALT = 81;

final p9 = [1, 9, 81, 729, 6561];

final o = [
  [4, 3, 3, 1, 0, 0, 1, 0, 0 ],
  [4, 3, 5, 1, 0, 2, 1, 0, 2 ],
  [5, 5, 4, 2, 2, 1, 2, 2, 1 ],
  [4, 3, 3, 1, 0, 0, 7, 6, 6 ],
  [4, 3, 5, 1, 0, 2, 7, 6, 8 ],
  [5, 5, 4, 2, 2, 1, 8, 8, 7 ],
  [7, 6, 6, 7, 6, 6, 4, 3, 3 ],
  [7, 6, 8, 7, 6, 8, 4, 3, 5 ],
  [8, 8, 7, 8, 8, 7, 5, 5, 4 ],
];

int opr(int x, y){
  int i = 0;
  for (int j = 0; j < 5; j++){
    i = i + o[(y ~/ p9[j]) % 9][(x ~/ p9[j]) % 9] * p9[j];
  }
  return i;
}

int rotateR(int n){
  return (n ~/ 3 + (n % 3) * 19683);
}

String format(int n) {
  String output = n.toString();
  for (int i = output.length; i < 6; i++ )
    output = ' ' + output;
  return output;
}

bool instructionListNormalized(String instructionList){
  bool result = true;
  for (int i = 0; i < instructionList.length; i++)
    if (!validInstructions.contains(instructionList[i])) {
      result = false;
      break;
    }
  return result;
}

String normalize(String instructionList){                                      // Converts ASCII-representation to Malbolge-style instructions
  String returnString = '';
  String tempChar = '';
  for (int x = 0; x < instructionList.length; x++) {
    tempChar = xlat1[((instructionList.codeUnitAt(x) + x - 33) % 94)];
    if (validInstructions.contains(tempChar))
      returnString = returnString + tempChar;
  }
  return returnString;
}

String reverseNormalize(String instructionList){                               // Converts from Malbolge-style instructions to actual ASCII-representation
  String returnString = '';
  String tempChar = '';
  for (int x = 0; x < instructionList.length; x++) {
    if (validInstructions.contains(instructionList[x]))  {                        // Checks to see if the instructions provided are valid
      tempChar = String.fromCharCode(((index(xlat1, instructionList[x]) - x) % 94) + 33);
      returnString = returnString + tempChar;
    } else
      return "Invalid program string";
  }
  return returnString;
}

int index(String s, c){
  for (int i = 0; i < s.length; i++)
    if (s[i] == c)
      return i;
  return -1;
}

List<int> memory = new List<int>(59049);         // program
List<int> memory_runtime = new List<int>(59049); // memory at runtime: with encrypted commands
int last_A_val = 0;                              // last value of A register


malbolgeOutput interpretMalbolge(String program, String STDIN, bool strict){

  if (program.length < 2)
    return malbolgeOutput([
      'malbolge_error_invalid_program',
      'malbolge_error_program_to_short'], [], []);

  if (instructionListNormalized(program))
    program = reverseNormalize(program);

  // load program
  int charCode = 0;
  program = program.replaceAll(RegExp(r'\s'), '');
  int i = 0;
  while (i < program.length){
    charCode = program.codeUnitAt(i);
    if (charCode < 127 && charCode > 32) {
      if (!validInstructions .contains(xlat1 [(charCode - 33 + i) % 94]))
        return malbolgeOutput([
          'malbolge_error_invalid_program',
          'malbolge_error_invalid_character'], [], []);
    }
    if (i == 59049) {
      return malbolgeOutput([
        'malbolge_error_invalid_program',
        'malbolge_error_program_to_big'], [], []);
    }
    memory[i] = charCode;
    i++;
  }
  // fill memory with op(i-1, i-2)
  while (i < 59049){
    memory[i] = opr(memory[i - 1], memory[i - 2]);
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
  String STDOUT = '';

  while (!halt){
    if (strict) {
      if (memory[c] < 33 || memory[c] > 126) {
        output.addAll([STDOUT,
          '',
          'malbolge_error_runtime',
          'malbolge_error_invalid_opcode',
          'opCode: ' + memory[c].toString() + ' ' + String.fromCharCode(memory[c]),
          'malbolge_error_infinite_loop',
          '',
          'STACK TRACE ----------',
          'c = ' + c.toString(),
          'a = ' + a.toString(),
          'd = ' + d.toString(),]);
        return malbolgeOutput(output, assembler, memnonic);
      }
    }
    opcode = xlat1[(memory[c] - 33 + c) % 94];
    assembler.add(format(c) + '   ' + opcode);
    memnonic.add(opCodeList[opcode]);

    switch (opcode) {
      case 'j':  //    40     mov d, [d]
        d = memory[d];
        break;

      case 'i':   //     4     c = [d]
        c = memory[d];
        break;

      case '*':  //    39     a = [d] = rotr [d]
        a = memory[d] =  rotateR(memory[d]);
        //a = memory[d];
        break;

      case 'p':  //    62     a = [d] = crazy(a, [d])
        a = memory[d] = opr(a, memory[d]);
        //a = memory[d];
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
          return malbolgeOutput(output, assembler, memnonic);
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
          'opCode: ' + memory[c].toString() + ' ' + String.fromCharCode(memory[c]),
          (opcode == 'i') ? 'malbolge_error_illegal_jump' : 'malbolge_error_illegal_write',
          '',
          'STACK TRACE ----------',
          'c = ' + c.toString(),
          'a = ' + a.toString(),
          'd = ' + d.toString(),]);
        return malbolgeOutput(output, assembler, memnonic);
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
  return malbolgeOutput(output, assembler, memnonic);
}


malbolgeOutput generateMalbolge(String out_s){
  int index = 0;       // current char of out_s
  String malbolgeProgram = '';
  int c = 0;           // current size of Malbolge program. respectively the value of the C register in Malbolge

  // initialize memory
  for (int i = 0; i < memory.length; i++)
    memory[i] = memory_runtime[0] = 0;

  // first character: b -> cause a jump to address 98 which will be encrypted first
  memory_runtime[0] = memory[0] = 'b'.codeUnitAt(0);
  // fill skipped memory cells with NOPs
  for (int i = 1; i < 99; i++){
    create_malbolge_command(MB_NOP, i);
  }

  // Malbolge program execution continues with data pointer at 1 and program counter at 99
  // The data pointer is always D = C-98, so we needn't store its value.
  c = 99;
  while (index < out_s.length){
    print('outer while');
    int command_length = 0;

    do { // load character to A register
      print('   inner while');
      command_length = generate_character(c, out_s[index]);
      index++;
    } while(command_length < 0 && index < out_s.length);
    if (command_length == -1)
      break;

    c += command_length;
    if (c > 59047){
      c = 59047;
      break;
    } else {
      create_malbolge_command(MB_OUT, c); // print A register
      c++;
    }
  }

  if (c > 59047)
    c = 59047;

  // halt
  create_malbolge_command(MB_HALT, c);
  c++;

  for (int i = 0; i < c; i++){ // create output
    malbolgeProgram+= String.fromCharCode(memory[i]);
  }
  return malbolgeOutput([malbolgeProgram], [normalize(malbolgeProgram)], []);
}


int generate_character(int C, String goal) {

  int window_size = 1;                    // Current size of the search window.

  if (goal.codeUnitAt(0) >= 154 && goal.codeUnitAt(0) <= 208) {
    // These characters cannot be generated by our method. Return -1 (no success).
    return -1;
  }

  if (String.fromCharCode(last_A_val) == goal){// goal's value is in the A register already.
    return 0;
  }

  // search for instructions of format NOP* ROT? NOP* OPR? NOP* OPR  or  NOP* ROT
  // that generate goal's value in the A register within the search window.
  while(window_size <= 700 && window_size + C < 59049){
    int rotPos = -1;
    do{
      int inner_opr_pos = rotPos + 1;
      do{
        int cur_A_val = last_A_val;

        for (int i = C; i < C + rotPos; i++){
          create_malbolge_command(MB_NOP, i);
        }

        if (rotPos >= 0){
          create_malbolge_command(MB_ROT, C+rotPos);
          cur_A_val = rotateR(memory_runtime[C+rotPos-98]);
        }

        for (int i = C + rotPos + 1; i < C + inner_opr_pos; i++){
          create_malbolge_command(MB_NOP, i);
        }

        if (inner_opr_pos < window_size-1) {
          create_malbolge_command(MB_OPR, C+inner_opr_pos);
          cur_A_val = opr(cur_A_val,memory_runtime[C + inner_opr_pos - 98]);
          for (int i = C + inner_opr_pos + 1; i < C + window_size; i++){
            create_malbolge_command(MB_NOP, i);
          }
        }

        if (rotPos < window_size-1){
          create_malbolge_command(MB_OPR, C+window_size - 1);
          cur_A_val = opr(cur_A_val, memory_runtime[C + window_size - 1 - 98]);
        }


        if (String.fromCharCode(cur_A_val) == goal){ // Success.
          // Update last_A_val and return length of Malbolge code sequence.
          last_A_val = cur_A_val;
          return window_size;
        }

        inner_opr_pos++;
      } while (inner_opr_pos < window_size);
      rotPos++;
    } while (rotPos < window_size);
    window_size++; // increase size of search window
  }
  // Malbolge program size or search space exceeded. Return -1 (no success).
  return -1;
}

void create_malbolge_command(int command, int position) {
  command = (command - (position) % 94 + 94) % 94;
  if (command < 33) {
    command += 94;
  }
  memory[position] = command;
  if (position >= 98) {
    memory_runtime[position] = xlat2[memory[position]-33].codeUnitAt(0);
  } else {
    memory_runtime[position] = memory[position];
  }
}



malbolgeOutput generateMalbolgePy(String inputString){
// Author: Eli Pinkerton
// Description: A mostly-complete collection of useful malbolge methods
// https://github.com/wallstop/MalbolgeGenerator
  String endString = 'ioooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo';
  String tempString = '';
  List masterList = new List();
  List tempList = new List();
  int counter;
  bool found = false;
  var randomGenerator = Random();

  var opCodes = {'o', 'p', '*'};                                                 // This is the  list of opcodes that the program will use (aside from <)
  // p and * change the value of A, which is crucial for printing
  // o is nice to have, because it increments D, which is then used to get different values of A through * and p
  // j can also be used here, but might crash the program (not sure if I handle jumps to places without data)

  for (int x = 0; x < inputString.length; x++){                                 // Master loop, looks for letters
    tempString = '';
    found = false;                                                              // Whether or not the current letter of the desired string has been found
    if (masterList.length > 0)
      masterList.removeRange(0, masterList.length - 1);                         // masterList holds all possible combination of the above opCodes for some length.
    if (tempList.length > 0)
      tempList.removeRange(0, masterList.length - 1);                           // tempList is used as a temporary holder while all possible combinations of opCodes of length + 1 are generated

    opCodes.forEach((element) {                                                  // Tries only a single opcode at first, length of masterList is 1
      masterList.add(element);
    });
    counter = 0;                                                                // Counter is used to keep track of iterations while searching

    while(!found) {
      counter++;

      // Iterates through all possible combinations of opcodes for the current length, and sees if any of them print the desired character
      for (int i = 0; i < masterList.length; i++) {
        String y = masterList[i];
        tempString = interpret(endString + y + '<');

        // If the desired character is found, then that means that the current malbolge program prints out inputString up until the character we're searching for
        // Alternatively, we could compare the last letter of the malbolge program, but if we were using actual jumps, it might be possible that the output has become corrupted
        // So just in case, we do a substring comparison
        if(tempString == inputString.substring(0, x + 1)){
          endString = endString + y + "<";
          found = true;
          i = masterList.length;
          break;
        }

      }; // masterList forEach

      // Clear templist of previous results
      if (tempList.length > 0)
        tempList.removeRange(0, tempList.length);

      // Only mess around with masterList and tempList if we haven't found a solution.
      if (!found) {
        masterList.forEach((y) {
          // Generate all possible combinations of length + 1
          opCodes.forEach((z) {
            tempList.add(y + z);
          });
        });

        // Update masterList with these new combinations (clears all old ones)
        if (masterList.length > 0)
          masterList.removeRange(0, masterList.length);
        masterList.addAll(tempList);
      }
      // This is the novel part. If no solution has been found by length 5, a random combination of opCodes is appended to the current-good malbolge program.
      // The rational behind this is that most combinations of the above opcodes will change the value of A. With enough changes, eventually A will have a value that allows some combination of 5 opcodes to reach the desired character
      // This potentially makes the code run infinitely, but the likelyhood of this is infinitismally small.
      if(counter == 5 && !found) {
        endString = endString + masterList[randomGenerator.nextInt(masterList.length - 1)];

        // Reset opCode combinations
        if (masterList.length > 0)
          masterList.removeRange(0, masterList.length);
        opCodes.forEach((y) {
          masterList.add(y);
        });
        counter = 0;
      }
    } // while
  } // for
  return malbolgeOutput([reverseNormalize(endString + 'v')], [endString + 'v'], []);
}

String interpret(String instructionList){
  bool running = true;
  String outputString = '';
  int maxInstructions = instructionList.length;
  int a = 0;
  int c = 0;
  int d = 0;
  String currentInstruction = '';
  String malbolgeTapeString = '';

  if (instructionList.length < 2)
    return '';

  if (instructionListNormalized(instructionList))
    malbolgeTapeString = reverseNormalize(instructionList);
  else
    malbolgeTapeString = instructionList;
    // Determines the actual malbolge code, and assigns it to the malbolgeTape

  List malbolgeTape = new List();                                               // Converts the characters on the tape to their numerical values
  for (int i = 0; i < maxInstructions; i++)
    malbolgeTape.add(malbolgeTapeString.codeUnitAt(i));

  while(running){
    currentInstruction = xlat1[(malbolgeTape[c] - 33 + c) % 94];

    // executes instruction
    switch (currentInstruction) {
      case '<': // out a
        outputString = outputString + String.fromCharCode(a % 256);
        break;
      case '*': // a = [d] = rotr [d]
        if(d >= maxInstructions)
          running =false;
        else {
          a = malbolgeTape[d] = rotateR(malbolgeTape[d]);
        }
        break;
      case 'p': //a = [d] = crz a, [d]
        if (d >= maxInstructions)
          running = false;
        else {
          a = malbolgeTape[d] = opr(a, malbolgeTape[d]);
        }
        break;
      case 'o': // nop
        break;
      case 'j': // mov d [d]
        if (d >= maxInstructions)
          running = false;
        else
          d = malbolgeTape[d];
        break;
      case 'i':
        if (d >= maxInstructions)
          running = false;
        else
          c = malbolgeTape[d];
        break;
      case 'v':
        running = false;
        break;
    } // switch currentInstruction

    // Encrypts the last-executed instructions on the tape - If you aren't using jumps, this isn't technically necessary
    if (33 <= malbolgeTape[c] && malbolgeTape[c] <= 126)
      malbolgeTape[c] = xlat2.codeUnitAt(malbolgeTape[c] - 33);

    // Auto-increment C and D
    c++;
    if(c >= maxInstructions)
      running = false;
    d++;
  }
  return outputString;
}