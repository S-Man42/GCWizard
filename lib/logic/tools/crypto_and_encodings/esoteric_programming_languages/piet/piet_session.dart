import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/Models/piet_block.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/base_operations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_block_op_resolver.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_blocker_builder.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_io.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_navigator.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_stack.dart';

class PietResult {
  final String output;
  final String code;
  final bool input_expected;
  final bool error;
  final String errorText;
  final bool finished;
  final PietSession state;

  PietResult(
      {this.output = '',
        this.code = '',
        this.input_expected = false,
        this.error = false,
        this.errorText = '',
        this.finished = true,
        this.state = null});
}

class PietSession {
  PietBlock _currentBlock;
  Map<PietOps, Function> _actionMap;

  List<List<int>> _data;

  PietStack _stack;
  PietBlockOpResolver _opsResolver;
  PietBlockerBuilder _builder;
  PietNavigator _navigator;

  PietSession(List<List<int>> data, PietIO io) {
      _data = data;

      _builder = PietBlockerBuilder(_data);
      _navigator = PietNavigator(_data);
      _opsResolver = PietBlockOpResolver();
      _stack = PietStack();

      _currentBlock = _builder.GetBlockAt(0, 0);

      var ops = BaseOperations(_stack, io,
          () => _currentBlock,
          (i) => _navigator.RotateDirectionPointer(i),
          (i) => _navigator.ToggleCodelChooser(i));
      _actionMap = ops.GetMap();
  }

  bool _Running = false;
  bool get Running => _Running;

  Step() {
      Point result;
      var ret = _navigator.TryNavigate(_currentBlock);
      if (!ret.item1) _Running = false;
      result = ret.item2;

      var newBlock = _builder.GetBlockAt(result.x, result.y);
      var opCode = _opsResolver.Resolve(_currentBlock, newBlock);

      Function action;
      if (_actionMap.containsKey(opCode))
        _actionMap[opCode]();

      _currentBlock = newBlock;
  }

  Run() {
      _Running = true;
      while (Running)
          Step();
  }
}
