// https://raw.githubusercontent.com/wallstop/MalbolgeGenerator/master/MalbolgeInterpreter.py
// 

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

final normalTranslate  = '+b(29e*j1VMEKLyC})8&m#~W>qxdRp0wkrUo[D7,XTcA"lI.v%{gJh4G\\-=O@5`_3i<?Z\';FNQuY]szf\$!BS/|t:Pn6^Ha';
final encryptionTranslate  = '5z]&gqtyfr\$(we4{WP)H-Zn,[%\\3dL+Q;>U!pJS72FhOA1CB6v^=I_0/8|jsb9m<.TVac`uY*MK\'X~xDl}REokN:#?G"i@';
final validInstructions  = {'j', 'i', '*', 'p', '<', '/', 'v', 'o'};
final opCodeList = {
  'j' : 'mov d, [d]',
  'i' : 'jmp [d]',
  '*' : '[d] = rotr [d]\na = [d]',
  'p' : '[d] = crz a, [d]\na = [d]',
  '/' : 'in a',
  '<' : 'out a',
  'v' : 'end',
  'o' : 'nop' };

malbolgeOutput generateMalbolge(String inputString){
  String endString = '';
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
    print('----- ' + inputString[x]);
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
      print('- counter '+counter.toString());
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
  return malbolgeOutput([_reverseNormalize(endString + 'v')], [], [], []);
}


malbolgeOutput interpretMalbolge(String program, String STDIN){
  List<int> memory = new List<int>(59049);

  // load program
  int codeUnit = 0;
  String malbolge = program.replaceAll(RegExp(r'\s'), '');
  int j = 0;
  for (int i = 0; i < malbolge.length; i++) {
    codeUnit = malbolge.codeUnitAt(i);
     if (codeUnit < 127 && codeUnit > 32) {
       if (!validInstructions .contains(normalTranslate [(codeUnit - 33 + i) % 94]))
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
    op = normalTranslate [(memory[c] - 33 + c) % 94];
    assembler.add(_format(c) + ' ' + _format(d) + ' ' + _format(a));
    assembler.add(_format(memory[c]) + ' ' + _format(memory[d]) + ' ' + _format(memory[a]));
    memnonic.add('');

    switch (op) {
      case 'i':   //     4     c = [d]
        c = memory[d];
        memnonic.add(opCodeList[op]);
        break;

      case '<':   //   23     out a % 256
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
      memory[c] = encryptionTranslate .codeUnitAt(memory[c] - 33);

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
    tempChar = normalTranslate[((instructionList.codeUnitAt(x) + x - 33) % 94)];
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
      tempChar = String.fromCharCode(((_index(normalTranslate, instructionList[x]) - x) % 94) + 33);
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
  print('_interpret '+instructionList);
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

  // Used to "properly" initialize the malbolgeTape. However, this is a huge performance hit, as most malbolge programs are significantly less than the maximum size, and the crazy ops take time to calculate
  //So, instead, I've added some checks into the interpreter to simply exit on invalid tape indexes. The below section should be uncommented if you wish for "proper" machine execution

  //int currentIndex = malbolgeTape.length;
  //while(currentIndex < 59049){
  //    malbolgeTape.append(_crazy(malbolgeTape[currentIndex - 2], malbolgeTape[currentIndex - 1]));
  //    currentIndex++;
  //}

  while(running){
    currentInstruction = normalTranslate[(malbolgeTape[c] - 33 + c) % 94];

    // executes instruction
    switch (currentInstruction) {
      case '<':
        outputString = outputString + String.fromCharCode(a % 256);
        break;
      case '*':
        if(d >= maxInstructions)
          running =false;
        a = _rotate(malbolgeTape[d]);
        malbolgeTape[d] = a;
        break;
      case 'p':
        if(d >= maxInstructions)
          running = false;
        a = _crazy(a, malbolgeTape[d]);
        malbolgeTape[d] = a;
      break;
      case 'v':
        running = false;
        break;
    } // switch currentInstruction

    // Encrypts the last-executed instructions on the tape
    //If you aren't using jumps, this isn't technically necessary
    if (33 <= malbolgeTape[c] && malbolgeTape[c] <= 126)
      malbolgeTape[c] = encryptionTranslate.codeUnitAt(malbolgeTape[c] - 33);

    // Auto-increment C and D
    c++;
    if(c >= maxInstructions)
      running = false;
    d++;
  }
  return outputString;
}

