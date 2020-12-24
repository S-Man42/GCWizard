// http://cliffle.com/esoterica/beatnik/
// https://en.wikipedia.org/wiki/Beatnik_(programming_language)#:~:text=Beatnik%20is%20a%20simple%20stack-oriented%20esoteric%20programming%20language,,of%20the%20score%20determines%20what%20function%20is%20performed.
// https://esolangs.org/wiki/beatnik
// Interpreter inspired by
// - http://search.cpan.org/~beatnik/Acme-Beatnik-0.02/Beatnik.pm
// - https://github.com/catseye/Beatnik


import 'package:gc_wizard/logic/tools/games/scrabble.dart';

class BeatnikOutput{
  final List<String> output;
  final List<String> scrabble;
  final List<String> assembler;
  final List<String> memnonic;
  final List<DebugOutput> debug;

  BeatnikOutput(this.output, this.scrabble, this.assembler, this.memnonic, this.debug);
}

class DebugOutput{
  final String pc;
  final String command;
  final String stack;
  final String output;

  DebugOutput(this.pc, this.command, this.stack, this.output);
}

BeatnikOutput generateBeatnik(var ScrabbleVersion, output){
  List<int> assembler = new List<int>();
  var outputlist;
  outputlist = output.split('').reversed.join('');
  for (int i = 0; i < outputlist.length; i++) {
    assembler.add(5);
    assembler.add(outputlist[i].codeUnitAt(0));
  }
  for (int i = 0; i < outputlist.length; i++) {
    assembler.add(9);
  }
  assembler.add(17);

  List<String> assemblerProgramm = new List<String>();
  List<String> memnonicProgramm = new List<String>();
  for (int i = 0; i < assembler.length; i++){
    if (assembler[i] == 5 || assembler[i] == 13 || assembler[i] == 14 || assembler[i] == 15 || assembler[i] == 16) {
      assemblerProgramm.add(assembler[i].toString() + ' ' + assembler[i + 1].toString());
      memnonicProgramm.add(memnonic(assembler[i]) + ' ' + assembler[i + 1].toString());
      i++;
    } else {
      assemblerProgramm.add(assembler[i].toString());
      memnonicProgramm.add(memnonic(assembler[i]));
    }
  }

  List<DebugOutput> debugProgramm = new List<DebugOutput>();
  debugProgramm.add(DebugOutput('','','',''));

  return  BeatnikOutput(['beatnik_hint_generated'], [''], assemblerProgramm, memnonicProgramm, debugProgramm);
}


class BeatnikStack {
  List<int> _stack;

  BeatnikStack() {
    _stack = new List<int>();
  }

  void push(int c) {
    if (c != null)
      _stack.add(c);
  }

  int peek() {
    var c = _stack[_stack.length - 1];
    return c;
  }

  int pop()  {
    if (_stack.length != 0) {
      var c = _stack.removeAt(_stack.length - 1);
      return c;
    }
  }

  int size() {
    return _stack.length;
  }

  void add(){
    int a = pop();
    int b = pop();
    push(a + b);
  }

  void sub(){
    int a = pop();
    int b = pop();
    push(b - a);
  }

  void swap(){
    int a = pop();
    int b = pop();
    push(a);
    push(b);
  }

  void double(){
    int a = pop();
    push(a);
    push(a);
  }

  String getContent(){
    return '[' + _stack.join(', ') + ']';
  }
}

final memnonicTable = {0 : 'noop', 1 : 'noop', 2 : 'noop', 3 : 'noop', 4 : 'noop',
  5 : 'push', 6 : 'pop', 7 : 'add', 8 : 'input', 9 : 'output', 10 : 'sub', 11 : 'swap', 12 : 'double',
  13 : 'jmpz+', 14 : 'jmpnz+', 15 : 'jmpz-', 16 : 'jmpnz-', 17 : 'exit',
  18 : 'noop', 19 : 'noop', 20 : 'noop', 21 : 'noop', 22 : 'noop', 23 : 'noop' };

String memnonic(int command){
  if (command >= 5 && command <= 17)
    return memnonicTable[command];
  else
    return ' ';
}

String formatNumber(int number){
  if (number < 10)
    return '  ' + number.toString();
  else if (number < 100)
    return ' ' + number.toString();
  else
    return number.toString();
}

String formatString(String input, int length){
  String out = '';
  for (int i = 0; i < length - input.length; i++){
    out = out + ' ';
  }
  return input + out;
}

BeatnikOutput interpretBeatnik(var ScrabbleVersion, String sourcecode, input){
  if (sourcecode == null || sourcecode == '')
    return  BeatnikOutput([''], [''], [''], [''], [DebugOutput('','','','')]);

  var _currentValues = [];
  int value = 0;

  List<int> assembler = new List<int>();
  List<String> scrabbleProgramm = new List<String>();
  List<String> programm = sourcecode
      .replaceAll(new RegExp(r'(\s|\n|\t|\f\|\r)'),'#')
      .replaceAll(new RegExp(r'[^A-ZÄÖÜ]'),'#')
      .replaceAll(new RegExp(r'#+'),'#')
      .split('#');
  for (int i = 0; i < programm.length; i++){
    _currentValues = textToLetterValues(programm[i], ScrabbleVersion);
    value = 0;
    for (int j = 0; j < _currentValues.length; j++) {
      value = value + _currentValues[j];
    }
    if (value > 0) {
      assembler.add(value);
      scrabbleProgramm.add(formatNumber(value) + ' ' + programm[i]);
    }
  }

  List<DebugOutput> debugProgramm = new List<DebugOutput>();
  List<String> assemblerProgramm = new List<String>();
  List<String> memnonicProgramm = new List<String>();
  String space;
  for (int i = 0; i < assembler.length; i++){
    if (assembler[i] < 10)
      space = ' ';
    else
      space = '';
    if (assembler[i] == 5 || assembler[i] == 13 || assembler[i] == 14 || assembler[i] == 15 || assembler[i] == 16) {
      assemblerProgramm.add(space + assembler[i].toString() + ' ' + assembler[i + 1].toString());
      memnonicProgramm.add(memnonic(assembler[i]) + ' ' + assembler[i + 1].toString());
      i++;
    } else {
      assemblerProgramm.add(space + assembler[i].toString());
      memnonicProgramm.add(memnonic(assembler[i]));
    }
  }

  List<String> inputlist = input.split('');

  BeatnikStack stack = new BeatnikStack();

  String output = '';
  bool exit = false;
  int pc = 0;
  int inputindex = 0;
  while (!exit && pc < assembler.length){
// DEBUG
    if (assembler[pc] == 5 || assembler[pc] == 13 || assembler[pc] == 14 || assembler[pc] == 15 || assembler[pc] == 16) {
      debugProgramm.add(DebugOutput(pc.toString(), memnonic(assembler[pc])+' '+formatNumber(assembler[pc+1]), stack.getContent(), output));
      print(formatNumber(pc)+': '+formatNumber(assembler[pc])+' '+formatNumber(assembler[pc+1])+'     Stack: '+formatString(stack.getContent(), 40)+'   Output: '+output);
    } else {
      debugProgramm.add(DebugOutput(pc.toString(), memnonic(assembler[pc]), stack.getContent(), output));
      print(formatNumber(pc)+': '+formatNumber(assembler[pc])+'         Stack: '+formatString(stack.getContent(), 40)+'   Output: '+output);
    }
// DEBUG
    switch (assembler[pc]) {
      case 5: // push n
        if (pc + 1 < assembler.length - 1) {
          pc++;
          stack.push(assembler[pc]);
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_pc', 'beatnik_error_runtime_push', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 6: // pop
        if (stack.size() >= 1) {
          stack.pop();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_pop', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 7: // add
        if (stack.size() >= 2) {
          stack.add();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_add', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 8: // push input
        if (inputindex < inputlist.length - 1) {
          stack.push(inputlist[inputindex].codeUnitAt(0));
          inputindex++;
        } else {
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_invalid_input', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        }
        break;
      case 9: // pop output
        if (stack.size() >= 1) {
          output = output + String.fromCharCode(stack.pop());
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_pop_output', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 10: // sub
        if (stack.size() >= 2) {
          stack.sub();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_sub', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 11: //swap
        if (stack.size() >= 2) {
          stack.swap();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_swap', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 12: //double
        if (stack.size() >= 1) {
          stack.double();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_double', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 13: // jump z +
        if (stack.size() >= 1) {
          if (stack.pop() == 0)
            if (pc + 1 <= assembler.length - 1) {
              pc++;
              pc = pc + assembler[pc];
            } else
              return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_pc', 'beatnik_error_runtime_jmpz_f', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
          else
            pc++;
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_jmpz_f', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 14: // jump nz +
        if (stack.size() >= 1) {
          if (stack.pop() != 0)
            if (pc + 1 <= assembler.length - 1) {
              pc++;
              pc = pc + assembler[pc];
            } else
              return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_pc', 'beatnik_error_runtime_jmpnz_f', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
          else
            pc++;
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_jmpnz_f', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 15: // jump z -
        if (stack.size() >= 1) {
          if (stack.pop() == 0)
            if (pc + 1 <= assembler.length - 1) {
              pc = pc - assembler[pc + 1];
            } else
              return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_pc', 'beatnik_error_runtime_jmpz_b', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
          else
            pc++;
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_jmpz_b', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 16: // jump nz -
        if (stack.size() >= 1) {
          if (stack.pop() != 0)
            if (pc + 1 <= assembler.length - 1) {
              pc = pc - assembler[pc + 1];
            } else
              return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_pc' 'beatnik_error_runtime_jmpnz_b', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
          else
            pc++;
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_jmpnz_b', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
        break;
      case 17: // exit
        exit = true;
        break;
    }
    pc++;
    if (pc < 0)
      return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_pc', 'Step ' + pc.toString()], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
  }
  return BeatnikOutput([output], scrabbleProgramm, assemblerProgramm, memnonicProgramm, debugProgramm);
}