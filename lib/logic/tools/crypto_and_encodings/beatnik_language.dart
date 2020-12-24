import 'package:gc_wizard/logic/tools/games/scrabble.dart';
import 'package:gc_wizard/logic/tools/games/scrabble_sets.dart';

// http://cliffle.com/esoterica/beatnik/
// https://en.wikipedia.org/wiki/Beatnik_(programming_language)#:~:text=Beatnik%20is%20a%20simple%20stack-oriented%20esoteric%20programming%20language,,of%20the%20score%20determines%20what%20function%20is%20performed.
// https://esolangs.org/wiki/beatnik
// Interpreter inspired by
// - http://search.cpan.org/~beatnik/Acme-Beatnik-0.02/Beatnik.pm
// - https://github.com/catseye/Beatnik


class BeatnikOutput{
  final List<String> output;
  final List<String> scrabble;
  final List<String> assembler;
  final List<String> memnonic;
  final List<_debugOutput> debug;
  final bool input_expected;
  final bool error;
  final String errorText;
  final bool finished;
  final BeatnikState state ;

  BeatnikOutput(this.output, this.scrabble, this.assembler, this.memnonic, this.debug, this.input_expected, this.error, this.errorText, this.finished, this.state);
}

class BeatnikState {
  String output;
  String input;
  List<String> inputlist;
  List<String> assemblerProgramm;
  List<String> memnonicProgramm;
  List<_debugOutput> debugProgramm;
  List<int> stack;
  List<int> assembler;
  int pc;
  bool exit;
  bool input_required;
  var scrabble;

  storeState(int posOffset) {
    this.assemblerProgramm = _assemblerProgramm;
    this.assembler = _assembler;
    this.output = _output;
    this.input = _input;
    this.stack = _stack;
    this.memnonicProgramm = _memnonicProgramm;
    this.debugProgramm = _debugProgramm;
    this.pc = _pc;
    this.inputlist = _inputlist;
    this.input_required = _input_required;
    this.input = _input;
    this.scrabble = _scrabble;
  }

  restoreState() {
    _stack = this.stack;
    _assembler = this.assembler;
    _assemblerProgramm = this.assemblerProgramm;
    _memnonicProgramm = this.memnonicProgramm;
    _debugProgramm = this.debugProgramm;
    _pc = this.pc;
    _inputlist = this.inputlist;
    _input_required = this.input_required;
    _input = this.input;
    _output = this.output;
    _exit = this.exit;
    _scrabble = this.scrabble;
  }
}

String _input;
var _stack = List<int>();
var _assembler = List<int>();
var _assemblerProgramm = List<String>();
var _memnonicProgramm = List<String>();
var _debugProgramm = List<_debugOutput>();
int _pc;
var _inputlist = List<String>();
bool _exit;
var _input_required = false;
String _output;
var _scrabble;

class _debugOutput{
  final String pc;
  final String command;
  final String stack;
  final String output;

  _debugOutput(this.pc, this.command, this.stack, this.output);
}

BeatnikOutput generateBeatnik(var ScrabbleVersion, output){
  List<int> _assembler = new List<int>();
  var outputlist;
  outputlist = output.split('').reversed.join('');
  for (int i = 0; i < outputlist.length; i++) {
    _assembler.add(5);
    _assembler.add(outputlist[i].codeUnitAt(0));
  }
  for (int i = 0; i < outputlist.length; i++) {
    _assembler.add(9);
  }
  _assembler.add(17);

  //List<String> _assemblerProgramm = new List<String>();
  //List<String> _memnonicProgramm = new List<String>();
  for (int i = 0; i < _assembler.length; i++){
    if (_assembler[i] == 5 || _assembler[i] == 13 || _assembler[i] == 14 || _assembler[i] == 15 || _assembler[i] == 16) {
      _assemblerProgramm.add(_assembler[i].toString() + ' ' + _assembler[i + 1].toString());
      _memnonicProgramm.add(_memnonic(_assembler[i]) + ' ' + _assembler[i + 1].toString());
      i++;
    } else {
      _assemblerProgramm.add(_assembler[i].toString());
      _memnonicProgramm.add(_memnonic(_assembler[i]));
    }
  }

  //List<_debugOutput> _debugProgramm = new List<_debugOutput>();
  _debugProgramm.add(_debugOutput('','','',''));

  return  BeatnikOutput(['beatnik_hint_generated'], [''], _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
}

class BeatnikStack {
  //List<int> _stack;

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

final _memnonicTable = {0 : 'noop', 1 : 'noop', 2 : 'noop', 3 : 'noop', 4 : 'noop',
  5 : 'push', 6 : 'pop', 7 : 'add', 8 : 'input', 9 : 'output', 10 : 'sub', 11 : 'swap', 12 : 'double',
  13 : 'jmpz+', 14 : 'jmpnz+', 15 : 'jmpz-', 16 : 'jmpnz-', 17 : 'exit',
  18 : 'noop', 19 : 'noop', 20 : 'noop', 21 : 'noop', 22 : 'noop', 23 : 'noop' };

String _memnonic(int command){
  if (command >= 5 && command <= 17)
    return _memnonicTable[command];
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
    return  BeatnikOutput([''], [''], [''], [''], [_debugOutput('','','','')], false, false, '', true, null);

  var _currentValues = [];
  int value = 0;

  //List<int> _assembler = new List<int>();
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
print(programm[i]+'='+value.toString()+'='+_memnonic(value));
    if (value > 0) {
      _assembler.add(value);
      scrabbleProgramm.add(formatNumber(value) + ' ' + programm[i]);
    }
  }

  //List<_debugOutput> _debugProgramm = new List<_debugOutput>();
  //List<String> _assemblerProgramm = new List<String>();
  //List<String> _memnonicProgramm = new List<String>();
  String space;
  for (int i = 0; i < _assembler.length; i++){
    if (_assembler[i] < 10)
      space = ' ';
    else
      space = '';
    if (_assembler[i] == 5 || _assembler[i] == 13 || _assembler[i] == 14 || _assembler[i] == 15 || _assembler[i] == 16) {
      _assemblerProgramm.add(space + _assembler[i].toString() + ' ' + _assembler[i + 1].toString());
      _memnonicProgramm.add(_memnonic(_assembler[i]) + ' ' + _assembler[i + 1].toString());
      i++;
    } else {
      _assemblerProgramm.add(space + _assembler[i].toString());
      _memnonicProgramm.add(_memnonic(_assembler[i]));
    }
  }

  //List<String> inputlist = input.split('');

  BeatnikStack stack = new BeatnikStack();

  String output = '';
  _exit = false;

  //int _pc = 0;
  int inputindex = 0;
  while (!_exit && _pc < _assembler.length){
// _debug
    if (_assembler[_pc] == 5 || _assembler[_pc] == 13 || _assembler[_pc] == 14 || _assembler[_pc] == 15 || _assembler[_pc] == 16) {
      _debugProgramm.add(_debugOutput(_pc.toString(), _memnonic(_assembler[_pc])+' '+formatNumber(_assembler[_pc+1]), stack.getContent(), output));
      print(formatNumber(_pc)+': '+formatNumber(_assembler[_pc])+' '+formatNumber(_assembler[_pc+1])+'     Stack: '+formatString(stack.getContent(), 40)+'   Output: '+output);
    } else {
      _debugProgramm.add(_debugOutput(_pc.toString(), _memnonic(_assembler[_pc]), stack.getContent(), output));
      print(formatNumber(_pc)+': '+formatNumber(_assembler[_pc])+'         Stack: '+formatString(stack.getContent(), 40)+'   Output: '+output);
    }
// _debug
  switch (_assembler[_pc]) {
      case 5: // push n
        if (_pc + 1 < _assembler.length - 1) {
          _pc++;
          stack.push(_assembler[_pc]);
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime__pc', 'beatnik_error_runtime_push', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 6: // pop
        if (stack.size() >= 1) {
          stack.pop();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_pop', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 7: // add
        if (stack.size() >= 2) {
          stack.add();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_add', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 8: // push input
        if (inputindex < _inputlist.length - 1) {
          stack.push(_inputlist[inputindex].codeUnitAt(0));
          inputindex++;
        } else {
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_invalid_input', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        }
        break;
      case 9: // pop output
        if (stack.size() >= 1) {
          output = output + String.fromCharCode(stack.pop());
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_pop_output', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 10: // sub
        if (stack.size() >= 2) {
          stack.sub();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_sub', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 11: //swap
        if (stack.size() >= 2) {
          stack.swap();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_swap', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 12: //double
        if (stack.size() >= 1) {
          stack.double();
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_double', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 13: // jump z +
        if (stack.size() >= 1) {
          if (stack.pop() == 0)
            if (_pc + 1 <= _assembler.length - 1) {
              _pc++;
              _pc = _pc + _assembler[_pc];
            } else
              return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime__pc', 'beatnik_error_runtime_jmpz_f', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
          else
            _pc++;
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_jmpz_f', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 14: // jump nz +
        if (stack.size() >= 1) {
          if (stack.pop() != 0)
            if (_pc + 1 <= _assembler.length - 1) {
              _pc++;
              _pc = _pc + _assembler[_pc];
            } else
              return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime__pc', 'beatnik_error_runtime_jmpnz_f', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
          else
            _pc++;
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_jmpnz_f', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 15: // jump z -
        if (stack.size() >= 1) {
          if (stack.pop() == 0)
            if (_pc + 1 <= _assembler.length - 1) {
              _pc = _pc - _assembler[_pc + 1];
            } else
              return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime__pc', 'beatnik_error_runtime_jmpz_b', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
          else
            _pc++;
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_jmpz_b', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 16: // jump nz -
        if (stack.size() >= 1) {
          if (stack.pop() != 0)
            if (_pc + 1 <= _assembler.length - 1) {
              _pc = _pc - _assembler[_pc + 1];
            } else
              return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime__pc' 'beatnik_error_runtime_jmpnz_b', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
          else
            _pc++;
        } else
          return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime_stack', 'beatnik_error_runtime_jmpnz_b', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
        break;
      case 17: // exit
        _exit = true;
        break;
    }
    _pc++;
    if (_pc < 0)
      return BeatnikOutput(['beatnik_error_runtime', 'beatnik_error_runtime__pc', 'Step ' + _pc.toString()], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
  }
  return BeatnikOutput([output], scrabbleProgramm, _assemblerProgramm, _memnonicProgramm, _debugProgramm, false, false, '', true, null);
}
