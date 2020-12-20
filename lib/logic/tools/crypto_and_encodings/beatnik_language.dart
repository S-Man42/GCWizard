import 'package:gc_wizard/logic/tools/games/scrabble.dart';
import 'package:gc_wizard/logic/tools/games/scrabble_sets.dart';


bool isValid(String input){
  bool flag = true;
  if (input == null || input == '')
    return true;
  List<String> numbers = input.split(' ');
  numbers.forEach((element) {
    if (int.tryParse(element) == null) {
      flag = false;
    }
  });
  return flag;
}

String generateBeatnik(String language, output){
  return '';
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
    push(a - b);
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
}

List<String> interpretBeatnik(var ScrabbleVersion, String sourcecode, input){
  var _currentValues = [];
  int value = 0;

  List<int> assembler = new List<int>();
  List<String> programm = sourcecode
      .replaceAll(new RegExp(r'[^A-Z]'),' ')
      .replaceAll('  ',' ')
      .split(' ');
  for (int i = 0; i < programm.length; i++){
    _currentValues = textToLetterValues(programm[i], ScrabbleVersion);
    value = 0;
    for (int j = 0; j < _currentValues.length; j++) {
      value = value + _currentValues[j];
    }
    assembler.add(value);
  }

  List<String> inputlist = input.split(' ');

  BeatnikStack stack = new BeatnikStack();

  //
//
  String output = '';
  bool exit = false;
  int command = 0;
  int pc = 0;
  int a = 0;
  int b = 0;
  int inputindex = 0;
  while (!exit){
    command = assembler[pc];
    switch (command) {
      case 5:
        if (pc + 1 < assembler.length) {
          stack.push(assembler[pc + 1]);
          pc = pc + 2;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_pc'];
        break;
      case 6:
        if (stack.size() > 0) {
          stack.pop();
          pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 7:
        if (stack.size() > 2) {
          stack.add();
          pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 8:
        if (inputindex < inputlist.length) {
          stack.push(int.parse(inputlist[inputindex]));
          inputindex++;
          pc++;
        } else {
          return['beatnik_error_runtime', 'beatnik_error_runtime_invalid_input'];
        }
        break;
      case 9:
        if (stack.size() > 1) {
          output = output + String.fromCharCode(stack.pop());
          pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 10:
        if (stack.size() > 2) {
          stack.sub();
          pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 11:
        if (stack.size() > 2) {
          stack.swap();
          pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 12:
        if (stack.size() > 1) {
          stack.double();
          pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 13:
        if (stack.size() > 1) {
          a = stack.pop();
          if (a == 0)
            if (pc + 1 < assembler.length)
              pc = pc + assembler[pc + 1];
            else
              return['beatnik_error_runtime', 'beatnik_error_runtime_pc'];
          else
            pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 14:
        if (stack.size() > 1) {
          a = stack.pop();
          if (a != 0)
            if (pc + 1 < assembler.length)
              pc = pc + assembler[pc + 1];
            else
              return['beatnik_error_runtime', 'beatnik_error_runtime_pc'];
          else
            pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 15:
        if (stack.size() > 1) {
          a = stack.pop();
          if (a == 0)
            if (pc + 1 < assembler.length)
              pc = pc - assembler[pc + 1];
            else
              return['beatnik_error_runtime', 'beatnik_error_runtime_pc'];
          else
            pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 16:
        if (stack.size() > 1) {
          a = stack.pop();
          if (a != 0)
            if (pc + 1 < assembler.length)
              pc = pc - assembler[pc + 1];
            else
              return['beatnik_error_runtime', 'beatnik_error_runtime_pc'];
          else
            pc++;
        } else
          return['beatnik_error_runtime', 'beatnik_error_runtime_stack'];
        break;
      case 17:
        exit = true;
        break;
      default: return['beatnik_error_runtime', 'beatnik_error_runtime_code'];
    }
    if (pc < 0 || pc > assembler.length)
      return['beatnik_error_runtime', 'beatnik_error_runtime_pc'];
  }
  return [output];
}
