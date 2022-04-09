import 'dart:core';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_block.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_session.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_stack.dart';

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

  Function _getExitedBlock; //<PietBlock>
  Function _toggleDirectionPointer; //<int>
  Function _toggleCodelChooser; //<int>

  PietSession _session;

  BaseOperations(PietStack stack, PietSession session, Function getExitedBlock, Function toggleDirectionPointer, Function toggleCodelChooser) {
    _stack = stack;
    _session = session;
    _getExitedBlock = getExitedBlock; //<PietBlock>
    _toggleDirectionPointer = toggleDirectionPointer;
    _toggleCodelChooser = toggleCodelChooser;
  }

  /// <summary>
  /// Pushes the value of the colour block just exited on to the stack
  /// </summary>
  void Push() {
    PietBlock exitedBlock = _getExitedBlock();
    if (exitedBlock == null) return;

    _stack.Push(exitedBlock.BlockCount);
  }

  /// <summary>
  /// Pops the top value off the stack and discards it
  /// </summary>
  int Pop() {
    return _stack.Pop();
  }

  int Add() {
    return _stack.Add();
  }

  int Subtract() {
    return _stack.Subtract();
  }

  int Multiply() {
    return _stack.Multiply();
  }

  int Divide() {
    return _stack.Divide();
  }

  int Mod() {
    _stack.Mod();
  }

  int Not() {
    return _stack.Not();
  }

  int Greater() {
    return _stack.Greater();
  }

  void Pointer() {
    var result = _stack.Pop();
    if (result != null) _toggleDirectionPointer(result);
  }

  void Switch() {
    var result = _stack.Pop();
    if (result != null) _toggleCodelChooser(result);
  }

  void Duplicate() {
    _stack.Duplicate();
  }

  void Roll() {
    _stack.Roll();
  }

  void InNumber() {
    var val = _session.ReadInt();
    if (val != null) _stack.Push(val);
  }

  void InChar() {
    var val = _session.ReadChar();
    if (val != null && val.isNotEmpty) _stack.Push(val.runes.first);
  }

  void OutNumeric() {
    var result = _stack.Pop();
    if (result != null) _session.Output(result.toString());
  }

  void OutChar() {
    var result = _stack.Pop();
    if (result != null) _session.Output(String.fromCharCode(result));
  }

  Map<PietOps, void Function()> GetMap() {
    return {
        PietOps.Push : this.Push,
        PietOps.Pop : this.Pop,
        PietOps.Add : this.Add,
        PietOps.Subtract : this.Subtract,
        PietOps.Multiply : this.Multiply,
        PietOps.Divide : this.Divide,
        PietOps.Mod : this.Mod,
        PietOps.Not : this.Not,
        PietOps.Greater : this.Greater,
        PietOps.Pointer : this.Pointer,
        PietOps.Switch : this.Switch,
        PietOps.Duplicate : this.Duplicate,
        PietOps.Roll : this.Roll,
        PietOps.InputChar : this.InChar,
        PietOps.InputNumber : this.InNumber,
        PietOps.OutputNumber : this.OutNumeric,
        PietOps.OutputChar : this.OutChar
      };
  }
}

