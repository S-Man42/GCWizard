import 'dart:core';
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/Models/piet_ops.dart';

class BaseOperations {
    PietStack _stack;

    Function<PietBlock> _getExitedBlock;
    Function<int> _toggleDirectionPointer;
    Function<int> _toggleCodelChooser;

    IPietIO _io;

    BaseOperations(PietStack stack, IPietIO io, Func<PietBlock> getExitedBlock, Action<int> toggleDirectionPointer, Action<int> toggleCodelChooser) {
        _stack = stack;
        _io = io;
        _getExitedBlock = getExitedBlock;
        _toggleDirectionPointer = toggleDirectionPointer;
        _toggleCodelChooser = toggleCodelChooser;
    }

    /// <summary>
    /// Pushes the value of the colour block just exited on to the stack
    /// </summary>
    void Push() {
        var exitedBlock = _getExitedBlock.Invoke();
        if (exitedBlock == null) return;

        _stack.Push(exitedBlock.BlockCount);
    }

    /// <summary>
    /// Pops the top value off the stack and discards it
    /// </summary>
    void Pop() {
        _stack.Pop();
    }

    void Add() {
        _stack.Add();
    }

    void Subtract() {
        _stack.Subtract();
    }

    void Multiply() {
        _stack.Multiply();
    }

    void Divide() {
        _stack.Divide();
    }

    void Mod() {
        _stack.Mod();
    }

    void Not() {
        _stack.Not();
    }

    void Greater() {
        _stack.Greater();
    }

    void Pointer() {
        var result = _stack.Pop();
        if (result.HasValue)
            _toggleDirectionPointer(result.Value);
    }

    void Switch() {
        var result = _stack.Pop();
        if (result.HasValue)
            _toggleCodelChooser(result.Value);
    }

    void Duplicate() {
        _stack.Duplicate();
    }

    void Roll() {
        _stack.Roll();
    }

    void InNumber() {
        var val = _io.ReadInt();
        if (val.HasValue)
            _stack.Push(val.Value);
    }

    void InChar() {
        var val = _io.ReadChar();
        if (val.HasValue)
            _stack.Push(val.Value);
    }

    void OutNumeric() {
        var result = _stack.Pop();
        if (result.HasValue)
            _io.Output(result.Value);
    }

    void OutChar() {
        var result = _stack.Pop();
        if (result.HasValue)
            _io.Output(result.Value);
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

