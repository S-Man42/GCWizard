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

final legal = 'ji*p</vo';
final space = '\t\r\n\v\f ';
final EXIT = -1;
final WANTS_INPUT = -2;
final opc = {
  'jump': 4,
  'out': 5,
  'in' : 23,
  'rot': 39,
  'movd': 40,
  'opr': 62,
  'nop': 68,
  'halt': 81
};
final opcodes = [4, 5, 23, 39, 40, 62, 68, 81];
final assembly = {
  'i': 4,
  '<': 5,
  '/': 23,
  '*': 39,
  'j': 40,
  'p': 62,
  'o': 68,
  'v': 81
};

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

int op(int x, y){
  int i = 0;
  for (int j = 0; j < 5; j++){
    i = i + o[(y ~/ p9[j]) % 9][(x ~/ p9[j]) % 9] * p9[j];
  }
  return i;
}

int rotr(int n){
  return (n ~/ 3 + (n % 3) * 19683);
}

String format(int n) {
  String output = n.toString();
  for (int i = output.length; i < 6; i++ )
    output = ' ' + output;
  return output;
}

bool checkNormalize(String instructionList){
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


