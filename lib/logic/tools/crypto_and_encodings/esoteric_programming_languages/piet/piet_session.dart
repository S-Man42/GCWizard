//source: https://github.com/MatthewMooreZA/PietSharp

import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_block.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/base_operations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_block_op_resolver.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_blocker_builder.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_navigator.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_stack.dart';

class PietResult {
  final String output;
  final bool input_expected;
  final bool input_number_expected;
  final bool error;
  final String errorText;
  final bool finished;
  final PietSession state;

  PietResult(
      {this.output = '',
        this.input_expected = false,
        this.input_number_expected = false,
        this.error = false,
        this.errorText = '',
        this.finished = true,
        this.state = null});
}

var _input_required = false;
var _input_required_number = false;
final _inputRequired = "input required";

Future<PietResult> interpretPiet(List<List<int>> data, List<String> input,
    {int timeOut = 60000, PietSession continueState}) async {

  var pietSession = continueState ?? PietSession(data, timeOut: timeOut);
  pietSession.input  = input;

  try {
    pietSession.run();

    return PietResult(output: pietSession._output, input_expected: _input_required, input_number_expected: _input_required_number);
  } catch (err) {
    if (err.message == _inputRequired) {
      return PietResult(
          output: pietSession._output,
          input_expected: _input_required,
          input_number_expected: _input_required_number,
          finished: false, state: pietSession);
    } else
      return PietResult(
          output: pietSession._output,
          input_expected: _input_required,
          input_number_expected: _input_required_number,
          error: true,
          errorText: err.toString());
  }
}

class PietSession {
  PietBlock _currentBlock;
  Map<PietOps, Function> _actionMap;

  List<List<int>> data;

  PietStack _stack;
  PietBlockOpResolver _opsResolver;
  PietBlockerBuilder _builder;
  PietNavigator _navigator;

  List<String> input;
  var _output = '';

  var _timeOut = 60000;

  PietSession(List<List<int>> image, {int timeOut = 60000}) {
    data = image;

    _builder = PietBlockerBuilder(data);
    _navigator = PietNavigator(data);
    _opsResolver = PietBlockOpResolver();
    _stack = PietStack();
    _timeOut = max(timeOut, 100);

    _currentBlock = _builder.getBlockAt(0, 0);

    var ops = BaseOperations(_stack, this,
        () => _currentBlock,
        (i) => _navigator.rotateDirectionPointer(i),
        (i) => _navigator.toggleCodelChooser(i));
    _actionMap = ops.getMap();
  }

  bool _running = false;
  bool get running => _running;

  void _step() {
    Point result;
    var ret = _navigator.tryNavigate(_currentBlock);
    if (!ret.item1) _running = false;
    result = ret.item2;

    var newBlock = _builder.getBlockAt(result.x, result.y);
    var opCode = _opsResolver.resolve(_currentBlock, newBlock);

    if (_actionMap.containsKey(opCode))
      _actionMap[opCode]();

    _currentBlock = newBlock;
  }

  void run() {
    _running = true;

    var start_time = DateTime.now();

    while (running) {
      if ((DateTime.now().difference(start_time)).inMilliseconds > _timeOut) {
        throw new Exception('common_programming_error_maxiterations');
      }
      //if (_navigator.StepCount % 10 == 0) print(_navigator.StepCount);
      _step();
    }
  }

  void output(String value) {
    _output += value;
  }

  int readInt() {
    _input_required = true;
    _input_required_number = true;
    if (input.length == 0) throw new Exception(_inputRequired);

    var _input = input.first;
    input.removeAt(0);
    _input_required = false;
    return int.tryParse(_input);
  }

  String readChar() {
    _input_required = true;
    _input_required_number = false;
    if (input.length == 0) throw new Exception(_inputRequired);

    var _input = input.first;
    input.removeAt(0);
    _input_required = false;
    return _input;
  }
}
