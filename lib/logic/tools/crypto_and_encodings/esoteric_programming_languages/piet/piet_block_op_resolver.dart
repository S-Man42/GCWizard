import 'dart:html';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/Models/piet_block.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/base_operations.dart';
import 'package:tuple/tuple.dart';

enum HueColour {
    Red,
    Yellow,
    Green,
    Cyan,
    Blue,
    Magenta
}

enum Darkness {
    Light,
    Normal,
    Dark
}

class PietBlockOpResolver {
    /// <summary>
    /// Calculates the operation signified by the transition from block1 to block2
    /// </summary>
    /// <param name="block1">The egress block</param>
    /// <param name="block2">The ingress block</param>
    /// <returns>An operation</returns>
    PietOps Resolve(PietBlock block1, PietBlock block2) {
        Tuple2<HueColour, Darkness> colour1;
        Tuple2<HueColour, Darkness> colour2;
        if (_TryResolveColour(block1.Colour, colour1) && _TryResolveColour(block2.Colour, colour2))
        {
            int lightShift = colour2.item2.index - colour1.item2.index;
            if (lightShift < 0)
                lightShift += 3;

            int colourShift = colour2.item1.index - colour1.item1.index;
            if (colourShift < 0)
                colourShift += 6;

            var comparePoint = new Point(colourShift, lightShift);
            if (comparePoint == new Point(0, 0)) return PietOps.Noop;
            else if (comparePoint == new Point(0, 1)) return PietOps.Push;
            else if (comparePoint == new Point(0, 2)) return PietOps.Pop;
            else if (comparePoint == new Point(1, 0)) return PietOps.Add;
            else if (comparePoint == new Point(1, 1)) return PietOps.Subtract;
            else if (comparePoint == new Point(1, 2)) return PietOps.Multiply;
            else if (comparePoint == new Point(2, 0)) return PietOps.Divide;
            else if (comparePoint == new Point(2, 1)) return PietOps.Mod;
            else if (comparePoint == new Point(2, 2)) return PietOps.Not;
            else if (comparePoint == new Point(3, 0)) return PietOps.Greater;
            else if (comparePoint == new Point(3, 1)) return PietOps.Pointer;
            else if (comparePoint == new Point(3, 2)) return PietOps.Switch;
            else if (comparePoint == new Point(4, 0)) return PietOps.Duplicate;
            else if (comparePoint == new Point(4, 1)) return PietOps.Roll;
            else if (comparePoint == new Point(4, 2)) return PietOps.InputNumber;
            else if (comparePoint == new Point(5, 0)) return PietOps.InputChar;
            else if (comparePoint == new Point(5, 1)) return PietOps.OutputNumber;
            else if (comparePoint == new Point(5, 2)) return PietOps.OutputChar;
            //else throw new NotImplementedException();
        }

        return PietOps.Noop;
    }

    bool _TryResolveColour(int colour, Tuple2<HueColour, Darkness> result) {
        switch (colour)
        {
            // red
            case 0xFFC0C0:
                result = Tuple2<HueColour, Darkness>(HueColour.Red, Darkness.Light);
                return true;
            case 0xFF0000:
                result = Tuple2<HueColour, Darkness>(HueColour.Red, Darkness.Normal);
                return true;
            case 0xC00000:
                result = Tuple2<HueColour, Darkness>(HueColour.Red, Darkness.Dark);
                return true;
            // yellow
            case 0xFFFFC0:
                result = Tuple2<HueColour, Darkness>(HueColour.Yellow, Darkness.Light);
                return true;
            case 0xFFFF00:
                result = Tuple2<HueColour, Darkness>(HueColour.Yellow, Darkness.Normal);
                return true;
            case 0xC0C000:
                result = Tuple2<HueColour, Darkness>(HueColour.Yellow, Darkness.Dark);
                return true;
            // green
            case 0xC0FFC0:
                result = Tuple2<HueColour, Darkness>(HueColour.Green, Darkness.Light);
                return true;
            case 0x00FF00:
                result = Tuple2<HueColour, Darkness>(HueColour.Green, Darkness.Normal);
                return true;
            case 0x00C000:
                result = Tuple2<HueColour, Darkness>(HueColour.Green, Darkness.Dark);
                return true;
            //cyan
            case 0xC0FFFF:
                result = Tuple2<HueColour, Darkness>(HueColour.Cyan, Darkness.Light);
                return true;
            case 0x00FFFF:
                result = Tuple2<HueColour, Darkness>(HueColour.Cyan, Darkness.Normal);
                return true;
            case 0x00C0C0:
                result = Tuple2<HueColour, Darkness>(HueColour.Cyan, Darkness.Dark);
                return true;
            //blue
            case 0xC0C0FF:
                result = Tuple2<HueColour, Darkness>(HueColour.Blue, Darkness.Light);
                return true;
            case 0x0000FF:
                result = Tuple2<HueColour, Darkness>(HueColour.Blue, Darkness.Normal);
                return true;
            case 0x0000C0:
                result = Tuple2<HueColour, Darkness>(HueColour.Blue, Darkness.Dark);
                return true;
            //magenta
            case 0xFFC0FF:
                result = Tuple2<HueColour, Darkness>(HueColour.Magenta, Darkness.Light);
                return true;
            case 0xFF00FF:
                result = Tuple2<HueColour, Darkness>(HueColour.Magenta, Darkness.Normal);
                return true;
            case 0xC000C0:
                result = Tuple2<HueColour, Darkness>(HueColour.Magenta, Darkness.Dark);
                return true;
            default:
                result = Tuple2<HueColour, Darkness>(HueColour.Red, Darkness.Light); // default
                return false;
        }
    }
}

