import 'package:tuple/tuple.dart';

class PietStack {
    List<int> _stack = <int>[];

    int get length => _stack.length;

    Push(int value) {
        _stack.add(value);
        //_stack.Push(value);
    }

    int Pop() {
        return TryPop().item2;
    }

    Add() {
        _ApplyTernary((s1, s2) => s1 + s2);
    }

    Subtract() {
        _ApplyTernary((s1, s2) => s2 - s1);
    }

    Multiply() {
        _ApplyTernary((s1, s2) => s1 * s2);
    }

    Divide() {
        _ApplyTernaryIf(
            (s1, s2) => s2 / s1,
            (_, s2) => s2 != 0
        );
    }

    Mod() {
        // per the spec take the second value mod the first
        _ApplyTernaryIf(
            (s1, s2) => _ModExt(s2, s1),
            (s1, _) => s1 != 0
        );
    }

    /// <summary>
    /// Computes a proper modulo rather than a remainder.
    /// </summary>
    /// <param name="a">the dividend</param>
    /// <param name="n">the divisor</param>
    /// <returns>the modulus</returns>
    int _ModExt(int a, int n) {
        // kudos to Erdal G of Stackoverflow - https://stackoverflow.com/a/61524484

        return (((a %= n) < 0) && n > 0) || (a > 0 && n < 0) ? a + n : a;
    }

    Not() {
        var ret = TryPop();
        var result = ret.item2;
        if (!ret.item1) return;

        Push(result == 0 ? 1 : 0);
    }

    Greater() {
        _ApplyTernary((s1, s2) => s2 > s1 ? 1 : 0);
    }

    Duplicate() {
        var ret = TryPop();
        var result = ret.item2;
        if (!ret.item1) return;
        Push(result);
        Push(result);
    }

    _ApplyTernary(Function operatorFunc) { //<int, int, int>
        var ret = TryPop2();
        var stackResults = ret.item2;
        if (!ret.item1) return;

        var top = stackResults.item1;
        var second = stackResults.item2;

        var result = operatorFunc(top, second);
        Push(result);
    }

    _ApplyTernaryIf(Function operatorFunc, Function conditionalFunc) {//<int, int, int> <int, int, bool>
        var ret = TryPop2();
        var stackResults = ret.item2;
        if (!ret.item1) return;

        var top = stackResults.item1;
        var second = stackResults.item2;

        if (!conditionalFunc(top, second)) return;

        var result = operatorFunc(top, second);
        Push(result);

    }

    void Roll() {
        var ret = TryPop2();
        var stackResults = ret.item2;
        if (!ret.item1) return;

        var numberOfRolls = stackResults.item1;
        var depthOfRoll = stackResults.item2;

        int absNumberOfRolls = numberOfRolls.abs();

        if (numberOfRolls > 0)
            RotateRight(depthOfRoll, absNumberOfRolls);
        else
            RotateLeft(depthOfRoll, absNumberOfRolls);
    }

    // IEnumerable<int> AsEnumerable() {
    //     return _stack.AsEnumerable();
    // }

    Tuple2<bool, int> TryPop() {
        if (_stack.length < 1) return Tuple2<bool, int>(false, null);

        var result = _stack.last;
        _stack.removeLast();

        return Tuple2<bool, int>(true, result);
    }

    Tuple2<bool, Tuple2<int, int>> TryPop2() {
        if (_stack.length < 2) return Tuple2<bool, Tuple2<int, int>>(false, Tuple2<int, int>(0, 0));

        return Tuple2<bool, Tuple2<int, int>>(true, Tuple2<int, int>(Pop(), Pop()));
    }

    bool RotateRight(int depth, int iterations) {
        if (depth > _stack.length) return false;
        // if we need to rotate 3 items 7 items, then we can skip the full cycles and just the the 1
        int absoluteIterations = iterations % depth;

        var stack1 = PietStack(); //<int>(absoluteIterations);
        var stack2 = PietStack(); //<int>(depth - absoluteIterations);
        for (var i = 0; i < depth; i++)
        {
            if (i < absoluteIterations)
                stack1.Push(Pop());
            else
                stack2.Push(Pop());
        }

        while (stack1.length > 0)
            Push(stack1.Pop());

        while (stack2.length > 0)
            Push(stack2.Pop());

        return true;
    }

    bool RotateLeft(int depth, int iterations) {
        if (depth > _stack.length) return false;
        // if we need to rotate 3 items 7 items, then we can skip the full cycles and just the the 1
        int absoluteIterations = iterations % depth;

        var stack1 = PietStack(); //<int>(absoluteIterations);
        var stack2 = PietStack(); //<int>(depth - absoluteIterations);
        for (var i = depth; i > 0; i--)
        {
            if (i <= absoluteIterations)
                stack1.Push(Pop());
            else
                stack2.Push(Pop());
        }

        while (stack2.length > 0)
            Push(stack2.Pop());

        while (stack1.length > 0)
            Push(stack1.Pop());

        return true;
    }
}

