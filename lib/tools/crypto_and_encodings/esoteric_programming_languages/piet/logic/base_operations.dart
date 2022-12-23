import 'dart:core';

import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_block.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_session.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_stack.dart';

enum PietOps {
  Noop,
  Push,
  Pop,
  Add,
  Subtract,
  Multiply,
  Divide,
  Mod,
  Not,
  Greater,
  Pointer,
  Switch,
  Duplicate,
  Roll,
  InputNumber,
  InputChar,
  OutputNumber,
  OutputChar
}

class BaseOperations {
  PietStack _stack;
  Function _getExitedBlock;
  Function _toggleDirectionPointer;
  Function _toggleCodelChooser;
  PietSession _session;

  BaseOperations(PietStack stack, PietSession session, Function getExitedBlock, Function toggleDirectionPointer,
      Function toggleCodelChooser) {
    _stack = stack;
    _session = session;
    _getExitedBlock = getExitedBlock;
    _toggleDirectionPointer = toggleDirectionPointer;
    _toggleCodelChooser = toggleCodelChooser;
  }

  /// <summary>
  /// Pushes the value of the color block just exited on to the stack
  /// </summary>
  void push() {
    PietBlock exitedBlock = _getExitedBlock();
    if (exitedBlock == null) return;

    _stack.push(exitedBlock.blockCount);
  }

  /// <summary>
  /// Pops the top value off the stack and discards it
  /// </summary>
  int pop() {
    return _stack.pop();
  }

  int add() {
    return _stack.add();
  }

  int subtract() {
    return _stack.subtract();
  }

  int multiply() {
    return _stack.multiply();
  }

  int divide() {
    return _stack.divide();
  }

  int mod() {
    _stack.mod();
  }

  int not() {
    return _stack.not();
  }

  int greater() {
    return _stack.greater();
  }

  void pointer() {
    var result = _stack.pop();
    if (result != null) _toggleDirectionPointer(result);
  }

  void switch_() {
    var result = _stack.pop();
    if (result != null) _toggleCodelChooser(result);
  }

  void duplicate() {
    _stack.duplicate();
  }

  void roll() {
    _stack.roll();
  }

  void inNumber() {
    var val = _session.readInt();
    if (val != null) _stack.push(val);
  }

  void inChar() {
    var val = _session.readChar();
    if (val != null && val.isNotEmpty)
      val.runes.forEach((char) {
        _stack.push(char);
      });
  }

  void outNumeric() {
    var result = _stack.pop();
    if (result != null) _session.output(result.toString());
  }

  void outChar() {
    var result = _stack.pop();
    if (result != null) _session.output(String.fromCharCode(result));
  }

  Map<PietOps, void Function()> getMap() {
    return {
      PietOps.Push: this.push,
      PietOps.Pop: this.pop,
      PietOps.Add: this.add,
      PietOps.Subtract: this.subtract,
      PietOps.Multiply: this.multiply,
      PietOps.Divide: this.divide,
      PietOps.Mod: this.mod,
      PietOps.Not: this.not,
      PietOps.Greater: this.greater,
      PietOps.Pointer: this.pointer,
      PietOps.Switch: this.switch_,
      PietOps.Duplicate: this.duplicate,
      PietOps.Roll: this.roll,
      PietOps.InputChar: this.inChar,
      PietOps.InputNumber: this.inNumber,
      PietOps.OutputNumber: this.outNumeric,
      PietOps.OutputChar: this.outChar
    };
  }
}
