import 'dart:core';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/Models/piet_block.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_io.dart';
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

    PietIO _io;

    BaseOperations(PietStack stack, PietIO io, Function getExitedBlock, Function toggleDirectionPointer, Function toggleCodelChooser) {
        _stack = stack;
        _io = io;
        _getExitedBlock = getExitedBlock; //<PietBlock>
        _toggleDirectionPointer = toggleDirectionPointer;
        _toggleCodelChooser = toggleCodelChooser;
    }

    /// <summary>
    /// Pushes the value of the colour block just exited on to the stack
    /// </summary>
    Push() {
        PietBlock exitedBlock = _getExitedBlock();
        if (exitedBlock == null) return;

        _stack.Push(exitedBlock.BlockCount);
    }

    /// <summary>
    /// Pops the top value off the stack and discards it
    /// </summary>
    Pop() {
        _stack.Pop();
    }

    Add() {
        _stack.Add();
    }

    Subtract() {
        _stack.Subtract();
    }

    Multiply() {
        _stack.Multiply();
    }

    Divide() {
        _stack.Divide();
    }

    Mod() {
        _stack.Mod();
    }

    Not() {
        _stack.Not();
    }

    Greater() {
        _stack.Greater();
    }

    Pointer() {
        var result = _stack.Pop();
        if (result != null) _toggleDirectionPointer(result);
    }

    Switch() {
        var result = _stack.Pop();
        if (result != null) _toggleCodelChooser(result);
    }

    Duplicate() {
        _stack.Duplicate();
    }

    Roll() {
        _stack.Roll();
    }

    void InNumber() {
        var val = _io.ReadInt();
        if (val != null) _stack.Push(val);
    }

    void InChar() {
        var val = _io.ReadChar();
        if (val != null) _stack.Push(val.runes.first); //ToDo Orgin char to Stack
    }

    void OutNumeric() {
        var result = _stack.Pop();
        if (result != null) _io.Output(result.toString());
    }

    OutChar() {
        var result = _stack.Pop();
        if (result != null) _io.Output(String.fromCharCode(result));
    }

    Map<PietOps, void Function()> GetMap()
    {
        return
        {
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

