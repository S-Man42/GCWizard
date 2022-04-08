
    import 'dart:html';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_stack.dart';


class PietSession {
        PietBlock _currentBlock;
        Map<PietOps, Action> _actionMap;

        uint[,] _data;

        PietStack _stack;
        PietBlockOpResolver _opsResolver;
        PietBlockerBuilder _builder;
        PietNavigator _navigator;

        PietSession(int[,] data, IPietIO io) {
            _data = data;

            _builder = new PietBlockerBuilder(_data);
            _navigator = new PietNavigator(_data);
            _opsResolver = new PietBlockOpResolver();
            _stack = new PietStack();

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
            if (!_navigator.TryNavigate(_currentBlock, result)) // Out result
                _Running = false;

            var newBlock = _builder.GetBlockAt(result.x, result.y);
            var opCode = _opsResolver.Resolve(_currentBlock, newBlock);

            Function action;
            if (_actionMap.TryGetValue(opCode, action))  // Out action
                action.Invoke();

            _currentBlock = newBlock;
        }

        Run() {
            _Running = true;
            while (Running)
                Step();
        }
    }
}
