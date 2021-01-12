// https://raw.githubusercontent.com/wallstop/MalbolgeGenerator/master/MalbolgeInterpreter.py
// faulty regarding the generator and also interpreter
//
// https://github.com/zb3/malbolge-tools

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

malbolgeOutput generateMalbolge(String inputString){
  String endString = 'j';
  String tempString = '';
  List masterList = new List();
  List tempList = new List();
  int counter;
  bool found = false;
  var randomGenerator = Random();

  var opCodes = {'o', 'p', '*'};                                           // This is the  list of opcodes that the program will use (aside from <)
                                                                                // p and * change the value of A, which is crucial for printing
                                                                                // o is nice to have, because it increments D, which is then used to get different values of A through * and p
                                                                                // j can also be used here, but might crash the program (not sure if I handle jumps to places without data)

  for (int x = 0; x < inputString.length; x++){                                 // Master loop, looks for letters
    tempString = '';

    found = false;                                                              // Whether or not the current letter of the desired string has been found
    if (masterList.length > 0) masterList.removeRange(0, masterList.length - 1);// masterList holds all possible combination of the above opCodes for some length.
    if (tempList.length > 0) tempList.removeRange(0, masterList.length - 1);    // tempList is used as a temporary holder while all possible combinations of opCodes of length + 1 are generated

    opCodes.forEach((element) {                                                 // Tries only a single opcode at first, length of masterList is 1
      masterList.add(element);
    });
    counter = 0;                                                                // Counter is used to keep track of iterations while searching

    while(!found) {
      counter++;

      // Iterates through all possible combinations of opcodes for the current length, and sees if any of them print the desired character
      for (int i = 0; i < masterList.length; i++) {
        String y = masterList[i];
        tempString = _interpret(endString + y + '<');

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
        if (masterList.length > 0) masterList.removeRange(0, masterList.length);
        masterList.addAll(tempList);
      }
      // This is the novel part. If no solution has been found by length 5, a random combination of opCodes is appended to the current-good malbolge program.
      // The rational behind this is that most combinations of the above opcodes will change the value of A. With enough changes, eventually A will have a value that allows some combination of 5 opcodes to reach the desired character
      // This potentially makes the code run infinitely, but the likelyhood of this is infinitismally small.
      if(counter == 5 && !found) {
        endString = endString + masterList[randomGenerator.nextInt(masterList.length - 1)];

        // Reset opCode combinations
        if (masterList.length > 0) masterList.removeRange(0, masterList.length);
        opCodes.forEach((y) {
          masterList.add(y);
        });
        counter = 0;
      }
    } // while

  } // for
  endString = endString + 'v';
  return malbolgeOutput([_reverseNormalize(endString)], [endString], [], []);
}


malbolgeOutput interpretMalbolge(String program, String STDIN, bool strict){
  List<int> memory = new List<int>(59049);
  if (program.length < 2)
    return malbolgeOutput([
      'malbolge_error_invalid_program',
      'malbolge_error_program_to_short'], [], [], []);

  if (_checkNormalize(program))
    program = _reverseNormalize(program);

  // load program
  int charCode = 0;
  String malbolge = program.replaceAll(RegExp(r'\s'), '');
  int j = 0;
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
print('geladen');
  // fill memory with op(i-1, i-2)
  while (i < 59049){
    memory[i] = _op(memory[i - 1], memory[i - 2]);
    i++;
  }
print('memory filled');
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
      opcode = xlat1 [(memory[c] - 33 + c) % 94];
      assembler.add(_format(c) + '   ' + opcode);
      memnonic.add(opCodeList[opcode]);
    } else {
      opcode = xlat1 [(memory[c] - 33 + c) % 94];
      assembler.add(_format(c) + '   ' + opCodeList[opcode]);
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
        memory[d] = _op(a, memory[d]);
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

int _op(int x, y){
  int i = 0;
  for (int j = 0; j < 5; j++){
    i = i + o[(y ~/ p9[j]) % 9][(x ~/ p9[j]) % 9] * p9[j];
  }
  return i;
}

int _rotr(int n){
 return (n ~/ 3 + (n % 3) * 19683);
}



String _format(int n) {
  String output = n.toString();
  for (int i = output.length; i < 6; i++ )
    output = ' ' + output;
  return output;
}

bool _checkNormalize(String instructionList){
  bool result = true;
  for (int i = 0; i < instructionList.length; i++)
    if (!validInstructions.contains(instructionList[i])) {
      result = false;
      break;
    }
  return result;
}

String _normalize(String instructionList){                                      // Converts ASCII-representation to Malbolge-style instructions
  String returnString = '';
  String tempChar = '';
  for (int x = 0; x < instructionList.length; x++) {
    tempChar = xlat1[((instructionList.codeUnitAt(x) + x - 33) % 94)];
    if (validInstructions.contains(tempChar))
      returnString = returnString + tempChar;
  }
  return returnString;
}

String _reverseNormalize(String instructionList){                               // Converts from Malbolge-style instructions to actual ASCII-representation
  String returnString = '';
  String tempChar = '';
  for (int x = 0; x < instructionList.length; x++) {
    if (validInstructions.contains(instructionList[x]))  {                        // Checks to see if the instructions provided are valid
      tempChar = String.fromCharCode(((_index(xlat1, instructionList[x]) - x) % 94) + 33);
      returnString = returnString + tempChar;
    } else
      return "Invalid program string";
  }
  return returnString;
}

int _index(String s, c){
  for (int i = 0; i < s.length; i++)
    if (s[i] == c)
      return i;
  return -1;
}

String _interpret(String instructionList){
  print('   ... interpret '+instructionList);
  bool running = true;
  String outputString = '';
  int maxInstructions = instructionList.length;
  int a = 0;
  int c = 0;
  int d = 0;
  String currentInstruction = '';

  String malbolgeTapeString = _reverseNormalize(instructionList);               // Determines the actual malbolge code, and assigns it to the malbolgeTape

  List malbolgeTape = new List();                                               // Converts the characters on the tape to their numerical values
  for (int i = 0; i < maxInstructions; i++)
    malbolgeTape.add(malbolgeTapeString.codeUnitAt(i));

  // Used to "properly" initialize the malbolgeTape. However, this is a huge performance hit,
  // as most malbolge programs are significantly less than the maximum size, and the crazy ops take time to calculate
  // So, instead, I've added some checks into the interpreter to simply exit on invalid tape indexes.
  // The below section should be uncommented if you wish for "proper" machine execution

  //int currentIndex = malbolgeTape.length;
  //while(currentIndex < 59049){
  //    malbolgeTape.append(_crazy(malbolgeTape[currentIndex - 2], malbolgeTape[currentIndex - 1]));
  //    currentIndex++;
  //}

  while(running){
    currentInstruction = xlat1[(malbolgeTape[c] - 33 + c) % 94];

    // executes instruction
    switch (currentInstruction) { // check only the instructions the generator uses
      case '<': // out a
        outputString = outputString + String.fromCharCode(a % 256);
        break;
      case '*': // a = [d] = rotr [d]
        if(d >= maxInstructions)
          running =false;
        else {
          a = _rotr(malbolgeTape[d]);
          malbolgeTape[d] = a;
        }
        break;
      case 'p': //a = [d] = crz a, [d]
        if(d >= maxInstructions)
          running = false;
        else {
          a = _op(a, malbolgeTape[d]);
          malbolgeTape[d] = a;
        }
      break;
      case 'j': // d = mov d, [d]
      print('       => d: '+d.toString()+ '   mem[d]: '+malbolgeTape[d].toString());
        d = malbolgeTape[d];
        break;
      case 'v': // halt
        running = false;
        break;
      case 'o': // nop
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

