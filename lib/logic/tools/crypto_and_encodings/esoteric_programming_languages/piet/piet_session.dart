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
  final bool error;
  final String errorText;
  final bool finished;
  final PietSession state;

  PietResult(
      {this.output = '',
        this.input_expected = false,
        this.error = false,
        this.errorText = '',
        this.finished = true,
        this.state = null});
}

var _input_required = false;
var _input_required_number = false;
final _inputRequired = "input required";

Future<PietResult> interpreterPiet(List<List<int>> data, String inp,
    {int timeOut = 60000, PietSession continueState}) async {

  var pietSession = continueState ?? PietSession(data, timeOut: timeOut);

  try {
    pietSession._input = (inp ?? '').split('').toList();
    pietSession.Run();

    return PietResult(output: pietSession._output, input_expected: _input_required);
  } catch (err) {
    if (err.message == _inputRequired) {
      return PietResult(
          output: pietSession._output, input_expected: _input_required, finished: false, state: pietSession);
    } else
      return PietResult(
          output: pietSession._output,
          input_expected: _input_required,
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

  String inp;
  List<String> _input;
  var _output = '';

  var _timeOut = 30000;

  PietSession(List<List<int>> image, {int timeOut = 30000}) {
    data = image;

    _builder = PietBlockerBuilder(data);
    _navigator = PietNavigator(data);
    _opsResolver = PietBlockOpResolver();
    _stack = PietStack();
    _timeOut = max(timeOut, 100);

    _currentBlock = _builder.GetBlockAt(0, 0);

    var ops = BaseOperations(_stack, this,
        () => _currentBlock,
        (i) => _navigator.RotateDirectionPointer(i),
        (i) => _navigator.ToggleCodelChooser(i));
    _actionMap = ops.GetMap();
  }

  bool _Running = false;
  bool get Running => _Running;

  void Step() {
    Point result;
    var ret = _navigator.TryNavigate(_currentBlock);
    if (!ret.item1) _Running = false;
    result = ret.item2;

    var newBlock = _builder.GetBlockAt(result.x, result.y);
    var opCode = _opsResolver.Resolve(_currentBlock, newBlock);

    if (_actionMap.containsKey(opCode))
      _actionMap[opCode]();

    _currentBlock = newBlock;
  }

  void Run() {
    _Running = true;

    var start_time = DateTime.now();

    while (Running) {
      if ((DateTime.now().difference(start_time)).inMilliseconds > _timeOut) {
        throw new Exception('TimeOut: Program runs too long');
      }
      if (_navigator.StepCount % 10 == 0) print(_navigator.StepCount);
      Step();
    }
  }

  void Output(String value) {
    _output += value;
  }

  int ReadInt() {
    _input_required = true;
    _input_required_number = true;
    if (_input.length == 0) throw new Exception(_inputRequired);

    var input = _input.first;
    _input.removeAt(0);
    return int.tryParse(input);
  }

  String ReadChar() {
    _input_required = true;
    _input_required_number = false;
    if (_input.length == 0) throw new Exception(_inputRequired);

    var input = _input.first;
    _input.removeAt(0);
    return input;
  }
}
